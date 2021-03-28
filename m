Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07ABE34BCB9
	for <lists+linux-pm@lfdr.de>; Sun, 28 Mar 2021 16:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhC1O6Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 10:58:25 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35293 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231131AbhC1O6Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Mar 2021 10:58:24 -0400
Received: (qmail 902716 invoked by uid 1000); 28 Mar 2021 10:58:23 -0400
Date:   Sun, 28 Mar 2021 10:58:23 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     bvanassche@acm.org, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-pm@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH v3 0/4] scsi: add runtime PM workaround for SD cardreaders
Message-ID: <20210328145823.GA902609@rowland.harvard.edu>
References: <20210328102531.1114535-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328102531.1114535-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Mar 28, 2021 at 12:25:27PM +0200, Martin Kepplinger wrote:
> hi,
> 
> In short: there are SD cardreaders that send MEDIA_CHANGED on
> (runtime) resume. We cannot use runtime PM with these devices as
> I/O always fails. I'd like to discuss a way to fix this
> or at least allow us to work around this problem:

In fact, as far as I know _all_ USB SD card readers send Media Changed 
notifications on resume.  Maybe there are some that don't, but I haven't 
heard of any.

Alan Stern
