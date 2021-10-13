Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCA442CD25
	for <lists+linux-pm@lfdr.de>; Wed, 13 Oct 2021 23:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJMV55 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Oct 2021 17:57:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhJMV54 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Oct 2021 17:57:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B2F7611C1;
        Wed, 13 Oct 2021 21:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634162153;
        bh=S9orB+5wdNKdU4LROmw2Z2uPUps8cEsb0w3LjRFHPzA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=josAi2+NkXI2PRrz1POfIEfjK0r6Fh6UWsJu+/hViAWlh71czm+xO6miQAEazaiBr
         /x9ihfDTRP0rBRWXG8eyp0YMgxDPoc/d+s9e1+0RGTDg9LUUxVpD3evdVKhxK8NQmP
         gjFaWXomPYMyVVBbcaK3DanpPf2/0JX8T6i7a98j7HBmIxCqbMcoqcLgY3oXJlj9mS
         xuftihK9ufXHJR1CtYksxVIQ6QGyiHuypqp7wDNI0ewXzZnnOKu8sWJSxpX3RLE4mh
         yoEbIK31miJZ/URa/i+KhfQ2zEbemxnF5F6pvs3X7Zvbectf+gNccF+FEFsTjJbn5y
         Sq1WIi7UjEJQA==
Received: by mail-wr1-f51.google.com with SMTP id g25so13004567wrb.2;
        Wed, 13 Oct 2021 14:55:53 -0700 (PDT)
X-Gm-Message-State: AOAM530IFsUx8Ug+tIH0cgTsgbJsW9LM1sYqcxlcnN6SM0g7h2RCyH/U
        2zVDm8z+eSgzQSVG7yDADwC3XV7zeoaW9McHvAw=
X-Google-Smtp-Source: ABdhPJx/0UMp1odX0CbgVF6fPVWIWr/hsa9pTyanRqhtvF2rw6cHDb/NnRS7OZb5lN7dr5y13KskTeZ0fdoN5YUQFGU=
X-Received: by 2002:a1c:2358:: with SMTP id j85mr15297304wmj.1.1634162151597;
 Wed, 13 Oct 2021 14:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211013160125.772873-1-arnd@kernel.org> <7b4c1c31-3ef6-db9b-dc98-8a6f7a3d6243@gmail.com>
In-Reply-To: <7b4c1c31-3ef6-db9b-dc98-8a6f7a3d6243@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 13 Oct 2021 23:55:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0KKpfxfh=qZM8pQs51qxqLZMcn_RLC99mpR5eC4tX+4A@mail.gmail.com>
Message-ID: <CAK8P3a0KKpfxfh=qZM8pQs51qxqLZMcn_RLC99mpR5eC4tX+4A@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: tegra: add ARCH_SUSPEND_POSSIBLE dependency
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        He Ying <heying24@huawei.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 13, 2021 at 10:49 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> > diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> > index 2cc3c208a180..af97992eaa82 100644
> > --- a/drivers/cpuidle/Kconfig.arm
> > +++ b/drivers/cpuidle/Kconfig.arm
> > @@ -100,6 +100,7 @@ config ARM_MVEBU_V7_CPUIDLE
> >  config ARM_TEGRA_CPUIDLE
> >       bool "CPU Idle Driver for NVIDIA Tegra SoCs"
> >       depends on (ARCH_TEGRA || COMPILE_TEST) && !ARM64 && MMU
> > +     depends on ARCH_SUSPEND_POSSIBLE
> >       select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
> >       select ARM_CPU_SUSPEND
> >       help
> >
>
> Arnd, thank you for the patch!
>
> Apparently ARM_QCOM_SPM_CPUIDLE doesn't have that problem visible
> because it selects QCOM_SPM, which depends on ARCH_QCOM, and thus
> ARCH_QCOM should be auto-selected(?).

No, that's not how it works. In fact ARM_QCOM_SPM_CPUIDLE has the
exact same problem. I tried to check if there are other drivers affected
by this problem before I sent my patch, but I did something wrong and
missed this one.

> I'm curious whether this needs to
> be corrected, otherwise (ARCH_QCOM || COMPILE_TEST) doesn't make much
> sense for that driver. And then it will need the same Kconfig fix as well.
>
> I assume this problem wasn't caught by regular kernel build bots because
> they don't test randconfig, don't they?

They do test randconfig builds, but only a few of them. This one is
rather hard to hit, it probably took me 100 builds before I hit the first
one and I haven't run into the QCOM one yet, though I did see a
different issue for ARM_QCOM_SPM_CPUIDLE:

WARNING: unmet direct dependencies detected for QCOM_SPM
  Depends on [n]: ARCH_QCOM [=n]
  Selected by [y]:
  - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64)
&& (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]

       Arnd
