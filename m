Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51A945608A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 17:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhKRQgJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 11:36:09 -0500
Received: from comms.puri.sm ([159.203.221.185]:39730 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233095AbhKRQgJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Nov 2021 11:36:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id CBBDCDFAF7;
        Thu, 18 Nov 2021 08:33:08 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6MVWenE3JsnY; Thu, 18 Nov 2021 08:33:08 -0800 (PST)
Message-ID: <c9e7799c4b02210c5be29d1c18c4eabd2fe0194b.camel@puri.sm>
Subject: Re: [PATCH] media: i2c: dw9714: use pm_runtime_force_suspend/resume
 for system suspend
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm,
        linux-pm@vger.kernel.org
Date:   Thu, 18 Nov 2021 17:33:04 +0100
In-Reply-To: <YZPqEu4W+JnY6LMY@paasikivi.fi.intel.com>
References: <20211109125505.2682553-1-martin.kepplinger@puri.sm>
         <YZPqEu4W+JnY6LMY@paasikivi.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Dienstag, dem 16.11.2021 um 19:27 +0200 schrieb Sakari Ailus:
> Hi Martin,
> 
> On Tue, Nov 09, 2021 at 01:55:05PM +0100, Martin Kepplinger wrote:
> > Using the same suspend function for runtime and system suspend
> > doesn't
> > work in this case (when controlling regulators and clocks).
> > suspend() and
> > resume() are clearly meant to stay balanced.
> > 
> > Use the pm_runtime_force_* helpers for system suspend and fix error
> > like the
> > following when transitioning to system suspend:
> > 
> > [  559.685921] dw9714 3-000c: I2C write fail
> > [  559.685941] dw9714 3-000c: dw9714_vcm_suspend I2C failure: -5
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> >  drivers/media/i2c/dw9714.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/i2c/dw9714.c
> > b/drivers/media/i2c/dw9714.c
> > index fcbebb3558b5..f6ddd7c4a1ff 100644
> > --- a/drivers/media/i2c/dw9714.c
> > +++ b/drivers/media/i2c/dw9714.c
> > @@ -267,7 +267,8 @@ static const struct of_device_id
> > dw9714_of_table[] = {
> >  MODULE_DEVICE_TABLE(of, dw9714_of_table);
> >  
> >  static const struct dev_pm_ops dw9714_pm_ops = {
> > -       SET_SYSTEM_SLEEP_PM_OPS(dw9714_vcm_suspend,
> > dw9714_vcm_resume)
> > +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > +                               pm_runtime_force_resume)
> >         SET_RUNTIME_PM_OPS(dw9714_vcm_suspend, dw9714_vcm_resume,
> > NULL)
> >  };
> 
> The purpose of the vcm suspend / resume callbacks is to gently move
> the
> lens to the resting position without hitting the stopper.
> 
> The problem currently appears to be that during system suspend, the
> VCM may
> well be powered off and the driver isn't checking for that. How about
> adding that check?
> 

thanks for having a look. Actually, I forgot to add support for a power
supply regulator, so this patch (description) is wrong and I'll send a
different one that adds optional vcc regulator support and splits up
system/runtime suspend functions to handle the regulator correctly.

thank you!

                              martin


