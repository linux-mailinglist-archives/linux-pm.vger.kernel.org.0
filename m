Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4EC7A1DA8
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 13:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbjIOLr0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 07:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjIOLrZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 07:47:25 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB29CD8
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 04:47:20 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d7e904674aeso2015838276.3
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 04:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694778440; x=1695383240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pKvJMFgrnKfiKIEIwaAMBoyLZ9Folrq2rV1ccO7Uz70=;
        b=E4udoxGd2oPMSCWzUWqg08GKQu2dzsuSkKtJlPUHqO8KS9fM4aZjsJSXketKK7rUJT
         k/BN+cLb9vhkcWS8IwsWApLnP1LrGrP07ePtRNvePT8s1PV/ZsG+g1in5DJ7e7ypqYh1
         OxEdXjqNkqsfM4rRuOswTnXWFHzBWBC0CErZhjQwa4PNGzrE/dCWPUvnlVsE2hltj8Yz
         I6wOZgbdCTUO54ovRFMaTme5IPiVYGADiJAF0UqyipVXqpzDqAEzABjscwVVPSU9+CUq
         Z2R2M6L/PvHpVWP69ae5HIdCHHAzjSMFWCWiGsTLBV9yvJO3qO0Uc0ADqnVyG7XVO5lz
         QZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694778440; x=1695383240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKvJMFgrnKfiKIEIwaAMBoyLZ9Folrq2rV1ccO7Uz70=;
        b=I2o1/okPCrcpcmZM13rV4sAhj+bADNjIiu+3ScenbvWFM3ZLmG9TZQaIgEfHZ2AHiQ
         SNtVjKTaTiqk26NeGs+w1ozoAFgBrUKE3IlJqK3O845kI5Tv1ob/SsyllNKSbrtKawFf
         wNRPf24rR+I5zBSMuribXVNuB6FQwxlMn3QajwJEi6WB//RHv7Q0FMmxdsiADuoTLt0R
         zpO02aJjHwMMpb3ZL4hpFPCO7EBnJy9zctrpgLqieRCbkjv2IWUtv3+be7njYMh2lF8y
         j3G25+4/uK9kMw4Z9lPV9TaN818KCfiul3lFfG/8UBkCNcMIRwSgs02Ow+5bZiyuaBdz
         HNpQ==
X-Gm-Message-State: AOJu0YwUwFTq4/NvALM4ABtChyJIS3gVKSrEm4cI5egF/ELv77Nq5g/r
        dOZi8NLzcIaU7cOCKxfnT/2c8zDzsAMTvRYvgAHTug==
X-Google-Smtp-Source: AGHT+IHNjbPocfOapzruHHkOSM0gBYdeN9YzEb9OGi/a0yQ9a+TId3ZzRP/xtB5m5r4YaOhU3X77DPcN8RZinfnXLMw=
X-Received: by 2002:a25:d450:0:b0:d81:61fd:ef5d with SMTP id
 m77-20020a25d450000000b00d8161fdef5dmr1350219ybf.27.1694778440112; Fri, 15
 Sep 2023 04:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230915092003.658361-1-ulf.hansson@linaro.org>
 <20230915092003.658361-5-ulf.hansson@linaro.org> <CAOgh=FzNordx=_YMiQs2Uj6JQ7Ctqqi=XZbbRAY9cS-F8v68RA@mail.gmail.com>
In-Reply-To: <CAOgh=FzNordx=_YMiQs2Uj6JQ7Ctqqi=XZbbRAY9cS-F8v68RA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Sep 2023 13:46:44 +0200
Message-ID: <CAPDyKFpYRwDGbYajVK8MMDjf=0ab-ZpMH2QXKUsVAFy0kh-iYA@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] pmdomain: apple: Move Kconfig option to the
 pmdomain subsystem
To:     Eric Curtin <ecurtin@redhat.com>, Neal Gompa <neal@gompa.dev>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ Neal

On Fri, 15 Sept 2023 at 11:45, Eric Curtin <ecurtin@redhat.com> wrote:
>
> On Fri, 15 Sept 2023 at 10:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > The Kconfig option belongs closer to the corresponding implementation,
> > hence let's move it from the soc subsystem to the pmdomain subsystem.
> >
> > Cc: Hector Martin <marcan@marcan.st>
> > Cc: Sven Peter <sven@svenpeter.dev>
> > Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> > Cc: <asahi@lists.linux.dev>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> This patch in the patchset looks the same as yesterday, so...
>
> Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Yes my bad, again. I forgot to add yours and Neal's tags, sorry.

Thanks!

Kind regards
Uffe

>
> Is mise le meas/Regards,
>
> Eric Curtin
>
> > ---
> >  drivers/pmdomain/Kconfig       |  1 +
> >  drivers/pmdomain/apple/Kconfig | 18 ++++++++++++++++++
> >  drivers/soc/apple/Kconfig      | 13 -------------
> >  3 files changed, 19 insertions(+), 13 deletions(-)
> >  create mode 100644 drivers/pmdomain/apple/Kconfig
> >
> > diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> > index 03c8991ad0fd..482d9e970e14 100644
> > --- a/drivers/pmdomain/Kconfig
> > +++ b/drivers/pmdomain/Kconfig
> > @@ -3,5 +3,6 @@ menu "PM Domains"
> >
> >  source "drivers/pmdomain/actions/Kconfig"
> >  source "drivers/pmdomain/amlogic/Kconfig"
> > +source "drivers/pmdomain/apple/Kconfig"
> >
> >  endmenu
> > diff --git a/drivers/pmdomain/apple/Kconfig b/drivers/pmdomain/apple/Kconfig
> > new file mode 100644
> > index 000000000000..12237cbcfaa9
> > --- /dev/null
> > +++ b/drivers/pmdomain/apple/Kconfig
> > @@ -0,0 +1,18 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +if ARCH_APPLE || COMPILE_TEST
> > +
> > +config APPLE_PMGR_PWRSTATE
> > +       bool "Apple SoC PMGR power state control"
> > +       depends on PM
> > +       select REGMAP
> > +       select MFD_SYSCON
> > +       select PM_GENERIC_DOMAINS
> > +       select RESET_CONTROLLER
> > +       default ARCH_APPLE
> > +       help
> > +         The PMGR block in Apple SoCs provides high-level power state
> > +         controls for SoC devices. This driver manages them through the
> > +         generic power domain framework, and also provides reset support.
> > +
> > +endif
> > diff --git a/drivers/soc/apple/Kconfig b/drivers/soc/apple/Kconfig
> > index a1596fefacff..eff486a77337 100644
> > --- a/drivers/soc/apple/Kconfig
> > +++ b/drivers/soc/apple/Kconfig
> > @@ -4,19 +4,6 @@ if ARCH_APPLE || COMPILE_TEST
> >
> >  menu "Apple SoC drivers"
> >
> > -config APPLE_PMGR_PWRSTATE
> > -       bool "Apple SoC PMGR power state control"
> > -       depends on PM
> > -       select REGMAP
> > -       select MFD_SYSCON
> > -       select PM_GENERIC_DOMAINS
> > -       select RESET_CONTROLLER
> > -       default ARCH_APPLE
> > -       help
> > -         The PMGR block in Apple SoCs provides high-level power state
> > -         controls for SoC devices. This driver manages them through the
> > -         generic power domain framework, and also provides reset support.
> > -
> >  config APPLE_RTKIT
> >         tristate "Apple RTKit co-processor IPC protocol"
> >         depends on MAILBOX
> > --
> > 2.34.1
> >
> >
>
