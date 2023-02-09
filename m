Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8906869110B
	for <lists+linux-pm@lfdr.de>; Thu,  9 Feb 2023 20:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjBITMc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 9 Feb 2023 14:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBITMc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2023 14:12:32 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046BF5DC31;
        Thu,  9 Feb 2023 11:12:31 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id p26so9375477ejx.13;
        Thu, 09 Feb 2023 11:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niG2EGz1c3OyIttax2i1EHaJSbYZ3YTZEcZ6nzjdxG0=;
        b=wRo7s/lGJsqWVTANk/4w69h3W3SONzNTDIMNoh3AuwLumyEzG6In4UeMXeem657Iqy
         qi9Ii/VPAavDzc/8zRX4UbVIGhSvvr/wDsNBGcDUGKLutDZ+gSS9V/xRYsBE2aGeGIF9
         OVWPjLM9g/hKtmpYAhJVPZvgAClHe9+lTfVGFy0NQkcOnZZnx9P9oPmLabUQQYiWVIt4
         dWFXWy/FqGnxfpIAHcMR09t36lk7fXOXyueZCEE7iVcRg1/8aNKcYehqs2zeCHnd4sPF
         sOtKiYq43jIGu0Ih6IOC3Jj8PEKXFIN3wBZ8BCiDqIIErbCNKTAHGiUR/DgLIXGB9qy1
         g7XQ==
X-Gm-Message-State: AO0yUKX+j8og7+3riy4qedBeEowE7uMt542xPEJUoZCeejrrjO1vL7Hf
        Wal+MguhWrBBm3fGHJXoLiLU4QHT1TTjNxkpw3M=
X-Google-Smtp-Source: AK7set/MBDxY2bsqoUNJIfYp1yC1dE/C3CJidAg9e+hMJUPfMqLOQ4lw0XH2Dx0dGNSmaYEZnFvIZYKr9ymv3Fd+uE8=
X-Received: by 2002:a17:907:7e82:b0:8ad:d366:54c4 with SMTP id
 qb2-20020a1709077e8200b008add36654c4mr899027ejc.4.1675969949277; Thu, 09 Feb
 2023 11:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20230207195909.474953-1-u.kleine-koenig@pengutronix.de> <20230208050523.p6437bes6cmpd33k@vireshk-i7>
In-Reply-To: <20230208050523.p6437bes6cmpd33k@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Feb 2023 20:12:17 +0100
Message-ID: <CAJZ5v0j8RCEE21Aj8j47k4bXV8-b=kKynBYWdf2tQL6Hfcsfbg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Make cpufreq_unregister_driver() return void
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 8, 2023 at 6:05 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 07-02-23, 20:59, Uwe Kleine-König wrote:
> > All but a few drivers ignore the return value of
> > cpufreq_unregister_driver(). Those few that don't only call it after
> > cpufreq_register_driver() succeeded, in which case the call doesn't
> > fail.
> >
> > Make the function return no value and add a WARN_ON for the case that
> > the function is called in an invalid situation (i.e. without a previous
> > successful call to cpufreq_register_driver()).
> >
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/cpufreq/brcmstb-avs-cpufreq.c | 5 +----
> >  drivers/cpufreq/cpufreq.c             | 8 +++-----
> >  drivers/cpufreq/davinci-cpufreq.c     | 4 +++-
> >  drivers/cpufreq/mediatek-cpufreq-hw.c | 4 +++-
> >  drivers/cpufreq/omap-cpufreq.c        | 4 +++-
> >  drivers/cpufreq/qcom-cpufreq-hw.c     | 4 +++-
> >  include/linux/cpufreq.h               | 2 +-
> >  7 files changed, 17 insertions(+), 14 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.3 material, thanks!
