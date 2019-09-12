Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2FE2B0B35
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 11:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfILJU5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Sep 2019 05:20:57 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39425 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbfILJU5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2019 05:20:57 -0400
Received: by mail-qt1-f196.google.com with SMTP id n7so28774663qtb.6;
        Thu, 12 Sep 2019 02:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRDYUjKUnISknWjGCczes9hGkwqyTHO80MEJ0z8YQtY=;
        b=T/fhGMZl5obvMmYH1TyXo7/in4qa+HR1mMZVXLrBV+DItSG9I+TTGxLkuGUyY++G6I
         NK/15UQ809LQcHWsssgiXxt26wyaluUGA01aUrmWEGcN9IRI560GJZDX4WTw2PeRwqZt
         8N1o2SX3f8ZYfYVQ0woVPpXLE3AqcnaGB81iM/S/exBwgi341jAWQBbF8thJq63q38vD
         O/eZ67rICDsdxdko+502o4VTD5TZ+yBiKCNFG4yu4jpcppZioEpC4JqXmqKPmmiSMhhW
         HopNCCPGlPScKUrOSL7/Lo6YuYDvY4ek9ahM1Fyxjy5ISCUUY1q2OVjRM92lfPQFrwQD
         BgJg==
X-Gm-Message-State: APjAAAWk5cM1yb/3+NCYGVTPSwx/3Jel+lATbg6Eg/B1rAf0oK10xOLC
        c4/8WXGuQBeAsClSo1/e0m15e3stFSMcsl4Sst0=
X-Google-Smtp-Source: APXvYqzIZpZevxkIY7u/NjBuiRRepDTUv3VktIMHvRReV0o7vKFBYD1g+Z4j/ghfdNx8/vtpVnjJa6+Xucy5Y8gWc+s=
X-Received: by 2002:ac8:5306:: with SMTP id t6mr39493926qtn.204.1568280056233;
 Thu, 12 Sep 2019 02:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568239378.git.amit.kucheria@linaro.org> <21b9dd0bf0bbc80b69bc81a7efb88243e4981c56.1568239378.git.amit.kucheria@linaro.org>
In-Reply-To: <21b9dd0bf0bbc80b69bc81a7efb88243e4981c56.1568239378.git.amit.kucheria@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Sep 2019 11:20:40 +0200
Message-ID: <CAK8P3a2O80CqJMQ-_0ve82iGMJuZqY4S7q_kAwcXhYX9h3gcuw@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: Kconfig: Fix BRCMSTB driver dependencies
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 12, 2019 at 12:19 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 1851112ccc29..d80e8d70bf10 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -22,6 +22,7 @@ config ARM_CCI400_PORT_CTRL
>
>  config BRCMSTB_GISB_ARB
>         bool "Broadcom STB GISB bus arbiter"
> +       depends on ARCH_BRCMSTB
>         depends on ARM || ARM64 || MIPS
>         default ARCH_BRCMSTB || BMIPS_GENERIC
>         help

This breaks MIPS configurations that need this driver, and
it breask compile-testing on non-ARM/MIPS targets.

> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 651b763f80cd..6f0b1ed1a05a 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -59,6 +59,7 @@ config POWER_RESET_BRCMKONA
>
>  config POWER_RESET_BRCMSTB
>         bool "Broadcom STB reset driver"
> +       depends on ARCH_BRCMSTB
>         depends on ARM || ARM64 || MIPS || COMPILE_TEST
>         depends on MFD_SYSCON
>         default ARCH_BRCMSTB || BMIPS_GENERIC

Same here and below.

> diff --git a/drivers/soc/bcm/Kconfig b/drivers/soc/bcm/Kconfig
> index 648e32693b7e..5a8ff33241ae 100644
> --- a/drivers/soc/bcm/Kconfig
> +++ b/drivers/soc/bcm/Kconfig
> @@ -24,6 +24,7 @@ config RASPBERRYPI_POWER
>
>  config SOC_BRCMSTB
>         bool "Broadcom STB SoC drivers"
> +       depends on ARCH_BRCMSTB
>         depends on ARM || ARM64 || BMIPS_GENERIC || COMPILE_TEST
>         select SOC_BUS
>         help

       Arnd
