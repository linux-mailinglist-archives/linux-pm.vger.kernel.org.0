Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B277734C666
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 10:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhC2IHu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 04:07:50 -0400
Received: from comms.puri.sm ([159.203.221.185]:46964 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231849AbhC2IGM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Mar 2021 04:06:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 31C1BDFD66;
        Mon, 29 Mar 2021 01:05:37 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i8V-yNlrLhxp; Mon, 29 Mar 2021 01:05:35 -0700 (PDT)
Message-ID: <e7a4d08fd3dba4fd22a1907476fad4334a4fbe10.camel@puri.sm>
Subject: Re: [PATCH v3 1/4] scsi: add expecting_media_change flag to error
 path
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        martin.petersen@oracle.com, stern@rowland.harvard.edu
Date:   Mon, 29 Mar 2021 10:05:30 +0200
In-Reply-To: <22533564-9f21-df1a-8cab-7996ccadc788@acm.org>
References: <20210328102531.1114535-1-martin.kepplinger@puri.sm>
         <20210328102531.1114535-2-martin.kepplinger@puri.sm>
         <22533564-9f21-df1a-8cab-7996ccadc788@acm.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Sonntag, dem 28.03.2021 um 09:53 -0700 schrieb Bart Van Assche:
> On 3/28/21 3:25 AM, Martin Kepplinger wrote:
> > diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> > index 08c06c56331c..c62915d34ba4 100644
> > --- a/drivers/scsi/scsi_error.c
> > +++ b/drivers/scsi/scsi_error.c
> > @@ -585,6 +585,18 @@ int scsi_check_sense(struct scsi_cmnd *scmd)
> >                                 return NEEDS_RETRY;
> >                         }
> >                 }
> > +               if (scmd->device->expecting_media_change) {
> > +                       if (sshdr.asc == 0x28 && sshdr.ascq ==
> > 0x00) {
> > +                               /*
> > +                                * clear the expecting_media_change
> > in
> > +                                * scsi_decide_disposition()
> > because we
> > +                                * need to catch possible "fail
> > fast" overrides
> > +                                * that block readahead can cause.
> > +                                */
> > +                               return NEEDS_RETRY;
> > +                       }
> > +               }
> 
> Introducing a new state variable carries some risk, namely that a
> path
> that should set or clear the state variable is overlooked. Is there
> an
> approach that does not require to introduce a new state variable,
> e.g.
> to send a REQUEST SENSE command after a resume?
> 
> Thanks,
> 
> Bart.

wow, thanks for that. Indeed my first tests succeed with the below
change, that doesn't use the error-path additions at all (not setting
expecting_media_change), and sends a request sense instead.

I'm just too little of a scsi developer that I know whether the below
change correctly does what you had in mind. Does it?


--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3707,6 +3707,10 @@ static int sd_resume_runtime(struct device *dev)
 {
        struct scsi_disk *sdkp = dev_get_drvdata(dev);
        struct scsi_device *sdp = sdkp->device;
+       const int timeout = sdp->request_queue->rq_timeout
+               * SD_FLUSH_TIMEOUT_MULTIPLIER;
+       int retries, res;
+       struct scsi_sense_hdr my_sshdr;
        int ret;
 
        if (!sdkp)      /* E.g.: runtime resume at the start of
sd_probe() */
@@ -3714,10 +3718,25 @@ static int sd_resume_runtime(struct device
*dev)
 
        /*
         * This devices issues a MEDIA CHANGE unit attention when
-        * resuming from suspend. Ignore the next one now.
+        * resuming from suspend.
         */
-       if (sdp->sdev_bflags & BLIST_MEDIA_CHANGE)
-               sdkp->device->expecting_media_change = 1;
+       if (sdp->sdev_bflags & BLIST_MEDIA_CHANGE) {
+               for (retries = 3; retries > 0; --retries) {
+                       unsigned char cmd[10] = { 0 };
+
+                       cmd[0] = REQUEST_SENSE;
+                       /*
+                        * Leave the rest of the command zero to
indicate
+                        * flush everything.
+                        */
+                       res = scsi_execute(sdp, cmd, DMA_NONE, NULL, 0,
NULL, &my_sshdr,
+                                       timeout, sdkp->max_retries, 0,
RQF_PM, NULL);
+                       if (res == 0)
+                               break;
+               }
+       }
 
        return sd_resume(dev);

