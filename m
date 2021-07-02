Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8EA3B9D4D
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 10:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhGBIHr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Jul 2021 04:07:47 -0400
Received: from comms.puri.sm ([159.203.221.185]:43932 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhGBIHr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Jul 2021 04:07:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 9B003DF80A;
        Fri,  2 Jul 2021 01:04:44 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D7DRqfSlUVAH; Fri,  2 Jul 2021 01:04:40 -0700 (PDT)
Message-ID: <b1d39dfbe1398192ef1181fc98d6b7e6bedeb649.camel@puri.sm>
Subject: Re: [PATCH v5 2/3] scsi: sd: send REQUEST SENSE for
 BLIST_MEDIA_CHANGE devices in runtime_resume()
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     bvanassche@acm.org, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        kernel@puri.sm, stern@rowland.harvard.edu
Date:   Fri, 02 Jul 2021 10:04:35 +0200
In-Reply-To: <YN3WD4Vem5Zx8Dvq@infradead.org>
References: <20210630084453.186764-1-martin.kepplinger@puri.sm>
         <20210630084453.186764-3-martin.kepplinger@puri.sm>
         <YN3WD4Vem5Zx8Dvq@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Donnerstag, dem 01.07.2021 um 15:49 +0100 schrieb Christoph Hellwig:
> On Wed, Jun 30, 2021 at 10:44:52AM +0200, Martin Kepplinger wrote:
> > +       struct scsi_disk *sdkp = dev_get_drvdata(dev);
> > +       struct scsi_device *sdp = sdkp->device;
> > +       int timeout, res;
> > +
> > +       timeout = sdp->request_queue->rq_timeout *
> > SD_FLUSH_TIMEOUT_MULTIPLIER;
> 
> Is REQUEST SENSE reqlly a so slow operation on these devices that
> we need to override the timeout?

using SD_TIMEOUT works equally fine for me. Is that what you'd rather
like to see?

Bart, is SD_TIMEOUT equally ok for you? If so, I'll resend with your
reviewed-by.

thank you for reviewing!

                            martin

