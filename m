Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE91A568365
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 11:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiGFJVW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 05:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbiGFJVP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 05:21:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B981759B;
        Wed,  6 Jul 2022 02:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4239E61C7B;
        Wed,  6 Jul 2022 09:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E177C341CA;
        Wed,  6 Jul 2022 09:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657099273;
        bh=WwyVSdZffKGWz2R6RdngoJpksypjl3TOOhDleKEMPr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSI1p6TRFXRut9439VlvkMxtBQ5/v+zrVALqaB1OG2yUotwdM9aEehT22gY8KrgbC
         KV6YATir5U/D/m4eIL37fQWi3c8EvZ5LsK5Cpb9ZpzWfOQiidinzBh014fepxjxMd9
         PeaLODzJ4mBMjXSO/0c8cDWEsbqw8f95pFscyvyw=
Date:   Wed, 6 Jul 2022 11:21:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Varad Gautam <varadgautam@google.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] thermal: sysfs: Perform bounds check when storing
 thermal states
Message-ID: <YsVUB76c2b0EkRBb@kroah.com>
References: <20220705150002.2016207-1-varadgautam@google.com>
 <YsRkPUcrMj+JU0Om@kroah.com>
 <CAOLDJOJ_v75WqGt2mZa0h-GgF+NThFBY5DvasH+9LLVgLrrvog@mail.gmail.com>
 <YsUvgWmrk+ZfUy3t@kroah.com>
 <CAOLDJOJug5jYpaSjY1tAYWNo0QRM4NB+wM2Vd2=Lf_O7TRjVCg@mail.gmail.com>
 <6eed01c90fafe681cccba2f227d65f2e9bfb8348.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eed01c90fafe681cccba2f227d65f2e9bfb8348.camel@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 06, 2022 at 04:51:59PM +0800, Zhang Rui wrote:
> On Wed, 2022-07-06 at 09:16 +0200, Varad Gautam wrote:
> > On Wed, Jul 6, 2022 at 8:45 AM Greg KH <gregkh@linuxfoundation.org>
> > wrote:
> > > 
> > > On Tue, Jul 05, 2022 at 11:02:50PM +0200, Varad Gautam wrote:
> > > > On Tue, Jul 5, 2022 at 6:18 PM Greg KH <
> > > > gregkh@linuxfoundation.org> wrote:
> > > > > 
> > > > > On Tue, Jul 05, 2022 at 03:00:02PM +0000, Varad Gautam wrote:
> > > > > > Check that a user-provided thermal state is within the
> > > > > > maximum
> > > > > > thermal states supported by a given driver before attempting
> > > > > > to
> > > > > > apply it. This prevents a subsequent OOB access in
> > > > > > thermal_cooling_device_stats_update() while performing
> > > > > > state-transition accounting on drivers that do not have this
> > > > > > check
> > > > > > in their set_cur_state() handle.
> > > > > > 
> > > > > > Signed-off-by: Varad Gautam <varadgautam@google.com>
> > > > > > Cc: stable@vger.kernel.org
> > > > > > ---
> > > > > >  drivers/thermal/thermal_sysfs.c | 12 +++++++++++-
> > > > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/thermal/thermal_sysfs.c
> > > > > > b/drivers/thermal/thermal_sysfs.c
> > > > > > index 1c4aac8464a7..0c6b0223b133 100644
> > > > > > --- a/drivers/thermal/thermal_sysfs.c
> > > > > > +++ b/drivers/thermal/thermal_sysfs.c
> > > > > > @@ -607,7 +607,7 @@ cur_state_store(struct device *dev,
> > > > > > struct device_attribute *attr,
> > > > > >               const char *buf, size_t count)
> > > > > >  {
> > > > > >       struct thermal_cooling_device *cdev =
> > > > > > to_cooling_device(dev);
> > > > > > -     unsigned long state;
> > > > > > +     unsigned long state, max_state;
> > > > > >       int result;
> > > > > > 
> > > > > >       if (sscanf(buf, "%ld\n", &state) != 1)
> > > > > > @@ -618,10 +618,20 @@ cur_state_store(struct device *dev,
> > > > > > struct device_attribute *attr,
> > > > > > 
> > > > > >       mutex_lock(&cdev->lock);
> > > > > > 
> > > > > > +     result = cdev->ops->get_max_state(cdev, &max_state);
> > > > > > +     if (result)
> > > > > > +             goto unlock;
> > > > > > +
> > > > > > +     if (state > max_state) {
> > > > > > +             result = -EINVAL;
> > > > > > +             goto unlock;
> > > > > > +     }
> > > > > > +
> > > > > >       result = cdev->ops->set_cur_state(cdev, state);
> > > > > 
> > > > > Why doesn't set_cur_state() check the max state before setting
> > > > > it?  Why
> > > > > are the callers forced to always check it before?  That feels
> > > > > wrong...
> > > > > 
> > > > 
> > > > The problem lies in thermal_cooling_device_stats_update(), not
> > > > set_cur_state().
> > > > 
> > > > If ->set_cur_state() doesn't error out on invalid state,
> > > > thermal_cooling_device_stats_update() does a:
> > > > 
> > > > stats->trans_table[stats->state * stats->max_states +
> > > > new_state]++;
> > > > 
> > > > stats->trans_table reserves space depending on max_states, but
> > > > we'd end up
> > > > reading/writing outside it. cur_state_store() can prevent this
> > > > regardless of
> > > > the driver's ->set_cur_state() implementation.
> > > 
> > > Why wouldn't cur_state_store() check for an out-of-bounds condition
> > > by
> > > calling get_max_state() and then return an error if it is invalid,
> > > preventing thermal_cooling_device_stats_update() from ever being
> > > called?
> > > 
> > 
> > That's what this patch does, it adds the out-of-bounds check.
> 
> No, I think Greg' question is
> why cdev->ops->set_cur_state() return 0 when setting a cooling state
> that exceeds the maximum cooling state?

Yes, that is what I am asking, it should not allow a state to be
exceeded.

thanks,

greg k-h
