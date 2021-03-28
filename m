Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7B234BCC7
	for <lists+linux-pm@lfdr.de>; Sun, 28 Mar 2021 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhC1PRM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 11:17:12 -0400
Received: from comms.puri.sm ([159.203.221.185]:41270 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229762AbhC1PQ7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Mar 2021 11:16:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id C8C5EDFB8A;
        Sun, 28 Mar 2021 08:16:28 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gmxW1Ic46DIB; Sun, 28 Mar 2021 08:16:27 -0700 (PDT)
Message-ID: <c48122bc8f6c6a380ca1a71054f0155e44206d7e.camel@puri.sm>
Subject: Re: [PATCH v3 0/4] scsi: add runtime PM workaround for SD
 cardreaders
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     bvanassche@acm.org, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-pm@vger.kernel.org, martin.petersen@oracle.com
Date:   Sun, 28 Mar 2021 17:16:23 +0200
In-Reply-To: <20210328145823.GA902609@rowland.harvard.edu>
References: <20210328102531.1114535-1-martin.kepplinger@puri.sm>
         <20210328145823.GA902609@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Sonntag, dem 28.03.2021 um 10:58 -0400 schrieb Alan Stern:
> On Sun, Mar 28, 2021 at 12:25:27PM +0200, Martin Kepplinger wrote:
> > hi,
> > 
> > In short: there are SD cardreaders that send MEDIA_CHANGED on
> > (runtime) resume. We cannot use runtime PM with these devices as
> > I/O always fails. I'd like to discuss a way to fix this
> > or at least allow us to work around this problem:
> 
> In fact, as far as I know _all_ USB SD card readers send Media
> Changed 
> notifications on resume.  Maybe there are some that don't, but I
> haven't 
> heard of any.
> 
> Alan Stern

that makes me worry less about enabling this for "Generic", "Ultra HS-
SD/MMC" then. thanks.

it also makes me think about whether sd should implement this even for
system-resume (not only runtime resume), but I guess that's a minor
issue we could add at any time later.

                               martin


