Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46051DCEC5
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 15:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgEUN6c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 09:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbgEUN6c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 21 May 2020 09:58:32 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBAB2206F6;
        Thu, 21 May 2020 13:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590069512;
        bh=1DCLIBCipyQQDUNxtyK8wNXEu9tHlAet1/MO76lJjLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rWwrMq4iuSJiDkZKM5D6qCLydJQ+L6KtjaToSdqoPHn1VtoJ1bWS6V4T4lbSpwPF7
         wPbywT4ELMPn9rKWbIf8Cwpz5oeOLh7M45hjm8PSkKv5pc3asmj2Aqo/IWhjflls5e
         gu/1oKvdvxn7PShPmsRFfSn0tBMEMGwVDRhWQ0o4=
Received: by mail-oi1-f177.google.com with SMTP id s198so6277299oie.6;
        Thu, 21 May 2020 06:58:31 -0700 (PDT)
X-Gm-Message-State: AOAM531CL9bxicurWM36f7RfVBWQjg/HotpK5zU7Ydz3B0wFHq4gfNrI
        LpqjlnDqkQe5tYM52roELqTYwBF7519QMjt84g==
X-Google-Smtp-Source: ABdhPJwgvDDeFp6B7d05F2Srm+AdAkJNDsKpqEmRJmIiYT/LJLqD3ySoCEf/pMzY3ACHdNOHzk8AcK1vNgX3IABDvF4=
X-Received: by 2002:aca:f084:: with SMTP id o126mr827503oih.106.1590069511216;
 Thu, 21 May 2020 06:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200520142144.520139-1-anders.roxell@linaro.org>
In-Reply-To: <20200520142144.520139-1-anders.roxell@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 21 May 2020 07:58:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLgnMYsf54_YdgWW6TZvPsRaH3LSmG_-0hYguAK2-0b5Q@mail.gmail.com>
Message-ID: <CAL_JsqLgnMYsf54_YdgWW6TZvPsRaH3LSmG_-0hYguAK2-0b5Q@mail.gmail.com>
Subject: Re: [PATCH] power: reset: vexpress: fix build issue
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 20, 2020 at 8:22 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> An allmodconfig kernel makes CONFIG_VEXPRESS_CONFIG a module and
> CONFIG_POWER_RESET_VEXPRESS builtin. That makes us see this build
> error:
>
> aarch64-linux-gnu-ld: drivers/power/reset/vexpress-poweroff.o: in function `vexpress_reset_probe':
> ../drivers/power/reset/vexpress-poweroff.c:119: undefined reference to `devm_regmap_init_vexpress_config'
> ../drivers/power/reset/vexpress-poweroff.c:119:(.text+0x48c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
> `devm_regmap_init_vexpress_config'
> make[1]: *** [/srv/src/kernel/next/Makefile:1126: vmlinux] Error 1
>
> Rework so that POWER_RESET_VEXPRESS depends on 'VEXPRESS_CONFIG=y'.
>
> Fixes: d06cfe3f123c ("bus: vexpress-config: Merge vexpress-syscfg into vexpress-config")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/power/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>

Can you resend this to soc@kernel.org asking them to apply to
vexpress/modules branch so it is applied where the problem was
introduced.

Rob
