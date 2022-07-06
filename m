Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1455C567FA4
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 09:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiGFHRF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 03:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiGFHRE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 03:17:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0C5222AF
        for <linux-pm@vger.kernel.org>; Wed,  6 Jul 2022 00:17:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b2so12925477plx.7
        for <linux-pm@vger.kernel.org>; Wed, 06 Jul 2022 00:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tfH8664UHgjV+2jYP2o3Me9myzK7TwJx+jhwNn0JvyI=;
        b=HlELrmOdwl3EiZsHOgJRt0JH0Da5y6wa7WoiSFjNcoqVeMJOU3U8m2CodJqT1HOHEQ
         SM+Q0V5IE7bBaCXqSg1PKuXTpR3kPD8NtxqT2S94qCQlkpmixRP7x1/d5Jyb80LQ3X24
         ZPxchV8ILLaLTn38koxgUr1mDH1WeFoAp4xIILm/iqP/Gbgiwi6NEcdhp7BIW8HrDIJX
         Wrs9ZVavFbtbFLW1sO3fOPyzmGXrfGbMCFSb2ecao2ZY4anXo1cLCV6j9jj5oo3oOMao
         oWgbbHmuDAFlwVGNnsoJQdUN/0hoBLUJNNl3Wxy4LchljUWUb1F2cb06h6KGZYXBND6L
         fV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfH8664UHgjV+2jYP2o3Me9myzK7TwJx+jhwNn0JvyI=;
        b=eS7ipnwHCbxkMh6dcKOswVCtPfOfFf4szqqefSAlKPeEuNZ1oZlpj1cfb0vxUEXIfS
         PbqsOG9BSpTB+58RZfxcF+cTHHfdAgMPw9YIBmPt4NZdMT3SuXMAAq0zipzcimr89j8H
         kICR3srTCB9qdWADDq3u6jWDB+4cG9ikpj8dmZ7pSpPB/Xj7BPBg8ngsl2GNS2SqdD5m
         js2t1g+tcBrLG8vTcyWSe68CO/DEu9DdFGf6nrT/wVvUMIoxAS34iW5s+0gwiyOGGYNF
         isdLs2VCt6b4zatSn+hJnzReBgxlBy6bP16ug978uHvHGDRuveB4+ROCHPOAQ405n1Oy
         kmHQ==
X-Gm-Message-State: AJIora9hTcA4FGA8gwZv4KSzd6TFQ+lEgR1u+28Nlg3Pb4tG2UeSTLSX
        AQQFFFQ/xy2/T1fyt7LtT5090Ills/H1x4ifyvBsxA==
X-Google-Smtp-Source: AGRyM1svTMN91R9urVgT2hpWinIt0CNDCABC4iWVvoIhyCPfVdSDwzkHpleTtKRi1fMl7A9POp+r1f1RP4HCaU65KUU=
X-Received: by 2002:a17:90a:f8c4:b0:1ef:b67d:f67b with SMTP id
 l4-20020a17090af8c400b001efb67df67bmr1587038pjd.145.1657091822187; Wed, 06
 Jul 2022 00:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220705150002.2016207-1-varadgautam@google.com>
 <YsRkPUcrMj+JU0Om@kroah.com> <CAOLDJOJ_v75WqGt2mZa0h-GgF+NThFBY5DvasH+9LLVgLrrvog@mail.gmail.com>
 <YsUvgWmrk+ZfUy3t@kroah.com>
In-Reply-To: <YsUvgWmrk+ZfUy3t@kroah.com>
From:   Varad Gautam <varadgautam@google.com>
Date:   Wed, 6 Jul 2022 09:16:51 +0200
Message-ID: <CAOLDJOJug5jYpaSjY1tAYWNo0QRM4NB+wM2Vd2=Lf_O7TRjVCg@mail.gmail.com>
Subject: Re: [PATCH] thermal: sysfs: Perform bounds check when storing thermal states
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 6, 2022 at 8:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 05, 2022 at 11:02:50PM +0200, Varad Gautam wrote:
> > On Tue, Jul 5, 2022 at 6:18 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jul 05, 2022 at 03:00:02PM +0000, Varad Gautam wrote:
> > > > Check that a user-provided thermal state is within the maximum
> > > > thermal states supported by a given driver before attempting to
> > > > apply it. This prevents a subsequent OOB access in
> > > > thermal_cooling_device_stats_update() while performing
> > > > state-transition accounting on drivers that do not have this check
> > > > in their set_cur_state() handle.
> > > >
> > > > Signed-off-by: Varad Gautam <varadgautam@google.com>
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > >  drivers/thermal/thermal_sysfs.c | 12 +++++++++++-
> > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> > > > index 1c4aac8464a7..0c6b0223b133 100644
> > > > --- a/drivers/thermal/thermal_sysfs.c
> > > > +++ b/drivers/thermal/thermal_sysfs.c
> > > > @@ -607,7 +607,7 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
> > > >               const char *buf, size_t count)
> > > >  {
> > > >       struct thermal_cooling_device *cdev = to_cooling_device(dev);
> > > > -     unsigned long state;
> > > > +     unsigned long state, max_state;
> > > >       int result;
> > > >
> > > >       if (sscanf(buf, "%ld\n", &state) != 1)
> > > > @@ -618,10 +618,20 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
> > > >
> > > >       mutex_lock(&cdev->lock);
> > > >
> > > > +     result = cdev->ops->get_max_state(cdev, &max_state);
> > > > +     if (result)
> > > > +             goto unlock;
> > > > +
> > > > +     if (state > max_state) {
> > > > +             result = -EINVAL;
> > > > +             goto unlock;
> > > > +     }
> > > > +
> > > >       result = cdev->ops->set_cur_state(cdev, state);
> > >
> > > Why doesn't set_cur_state() check the max state before setting it?  Why
> > > are the callers forced to always check it before?  That feels wrong...
> > >
> >
> > The problem lies in thermal_cooling_device_stats_update(), not set_cur_state().
> >
> > If ->set_cur_state() doesn't error out on invalid state,
> > thermal_cooling_device_stats_update() does a:
> >
> > stats->trans_table[stats->state * stats->max_states + new_state]++;
> >
> > stats->trans_table reserves space depending on max_states, but we'd end up
> > reading/writing outside it. cur_state_store() can prevent this regardless of
> > the driver's ->set_cur_state() implementation.
>
> Why wouldn't cur_state_store() check for an out-of-bounds condition by
> calling get_max_state() and then return an error if it is invalid,
> preventing thermal_cooling_device_stats_update() from ever being called?
>

That's what this patch does, it adds the out-of-bounds check.

> thanks,
>
> greg k-h
