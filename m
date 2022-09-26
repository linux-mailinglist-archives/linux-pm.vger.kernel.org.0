Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659955E9E3D
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 11:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiIZJs7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 05:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiIZJs0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 05:48:26 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613122314A
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 02:48:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s14so9404015wro.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 02:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rhaVxqhRFD4ReD1YmvEfA36I59kgV9ycJURpgQIgPAY=;
        b=O0TGduRGFfxCPs1TNKBUjv2K0TRM3DSlGM8hGNEn2FmYLBYNJjuttfVFcSFBjmuxk4
         WDFfaWg9OIrIvgA+2Ck+eOg6SPcFURWT2Lev/2Bdr04NH0V7VsIQPW7IM3L+9/mlcUxo
         0npnBC7t9nP049u8cNYgRTEOkm/BZ2KXMTizB/vqAzwwbniRxnGmzOtLD2OmbIE5CDkJ
         bsDrHghNyiZ/NtxVazztuz03LTIP20/Epo79GFR2XSkjJ+AEUUKmQFCb9ndAcZ0+vg51
         DoeqtFuetskqORqVry16CF7xCqKcBP4GidFrt4dMgV5m8xOFQKOChoX/TMVtQgynNExZ
         1U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rhaVxqhRFD4ReD1YmvEfA36I59kgV9ycJURpgQIgPAY=;
        b=csFRER7qyC8hCtP0C0B5M48p6Y82jY5ZOQAJkeuw6E8jvSvpY8NuH3aCUfW8wYkgwA
         XlbUjtiBk3WMTfVsgtDSv62P38fFMGg2ofYxXY9xA8uD0v+n94AgYTHrk3l7iSQd17Tz
         nU89IELwo5mpuFngiKykEmUZAEZL77s5ChKad53Y9kV6Oh15VTSvFp5agVq3MAS3/3dd
         nMUcOhiSI3lJJfZtW09SteF7JWMUOBzaXcZfdXPdjOpuo+eFamEeUi08BrhWVjYXL60/
         l9cq4Oxk4gKyWMEGQ3xLdgg9oMmgKP6zItGL7jVeZVMSIjLr76VCidEXfJZXgstaPkBi
         zbgg==
X-Gm-Message-State: ACrzQf1Q/ESKZh9s3Q59YY0zSWXsdBAD36b1nvDS5+Tp1zanVd5kxvpQ
        E3RoumvPkiPS3eUiDU2fU5t93kizsJ0Gdnj/OGKh2Q==
X-Google-Smtp-Source: AMsMyM46OMAue6ANY6uKjUMLZ396C0tIlTP6O/tQDkCtKtz22djgrgFLtwMsWgsbQcn7gFiaSD5bYrZQs48d9+kRHSU=
X-Received: by 2002:a5d:6c6f:0:b0:22a:7778:6ea2 with SMTP id
 r15-20020a5d6c6f000000b0022a77786ea2mr13171324wrz.15.1664185699688; Mon, 26
 Sep 2022 02:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220923124904.1373936-1-victor.liu@nxp.com> <CAPDyKFqdHX=o4V4K8GdCr4wQ5sjr=JMG6CFAy1849=CtfoSgRQ@mail.gmail.com>
 <75366bfac9fcd4f8c35309193705f0277a164ae4.camel@nxp.com>
In-Reply-To: <75366bfac9fcd4f8c35309193705f0277a164ae4.camel@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 26 Sep 2022 11:47:42 +0200
Message-ID: <CAPDyKFr0XjrU_udKoUKQ_q8RWaUkyqL+8fV-7s1CTMqi7u3-Rg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: runtime: Return properly from rpm_resume() if
 dev->power.needs_force_resume flag is set
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 23 Sept 2022 at 17:23, Liu Ying <victor.liu@nxp.com> wrote:
>
> On Fri, 2022-09-23 at 15:48 +0200, Ulf Hansson wrote:
> > On Fri, 23 Sept 2022 at 14:47, Liu Ying <victor.liu@nxp.com> wrote:
> > >
> > > After a device transitions to sleep state through it's system
> > > suspend
> > > callback pm_runtime_force_suspend(), the device's driver may still
> > > try
> > > to do runtime PM for the device(runtime suspend first and then
> > > runtime
> > > resume) although runtime PM is disabled by that callback.  The
> > > runtime
> > > PM operations would not touch the device effectively and the device
> > > is
> > > assumed to be resumed through it's system resume callback
> > > pm_runtime_force_resume().
> >
> > This sounds like a fragile use case to me. In principle you want to
> > allow the device to be runtime resumed/suspended, after the device
> > has
> > already been put into a low power state through the regular system
> > suspend callback. Normally it seems better to prevent this from
> > happening, completely.
>
> Not sure if we really may prevent this from happening completely.
>
> >
> > That said, in this case, I wonder if a better option would be to
> > point
> > ->suspend_late() to pm_runtime_force_suspend() and ->resume_early()
> > to
> > pm_runtime_force_resume(), rather than using the regular
> > ->suspend|resume() callbacks. This should avoid the problem, I think,
> > no?
>
> I thought about this and it actually works for my particular
> panel-simple case.  What worries me is that the device(DRM device in my
> case) which triggers the runtime PM operations may also use
> ->suspend_late/resume_early() callbacks for whatever reasons, hence no
> fixed order to suspend/resume the two devices(like panel device and DRM
> device).
>
> Also, not sure if there is any sequence issue by using the
> ->suspend_late/resume_early() callbacks in the panel-simple driver,
> since it's written for quite a few display panels which may work with
> various DRM devices - don't want to break any of them.

What you are describing here, is the classical problem we have with
suspend/resume ordering of devices.

There are in principle two ways to solve this.
1. If it makes sense, the devices might be assigned as parent/child.
2. If it's more a consumer/supplier thing, we can add a device-link
between them.

In this way, the PM core can guarantee that the order becomes correct.

Kind regards
Uffe
