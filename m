Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E617242A2AB
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 12:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhJLKz5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 12 Oct 2021 06:55:57 -0400
Received: from gloria.sntech.de ([185.11.138.130]:35288 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235881AbhJLKzz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Oct 2021 06:55:55 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1maFPm-00050U-8a; Tue, 12 Oct 2021 12:53:46 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org
Cc:     Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Anup Patel <anup.patel@wdc.com>,
        Anup Patel <anup.patel@wdc.com>
Subject: Re: [PATCH v9 5/8] cpuidle: Factor-out power domain related code from PSCI domain driver
Date:   Tue, 12 Oct 2021 12:53:45 +0200
Message-ID: <4115080.dWhdjDhTqs@diego>
In-Reply-To: <3552162.bMjzuKGm0O@diego>
References: <20211012095857.1314214-1-anup.patel@wdc.com> <20211012095857.1314214-6-anup.patel@wdc.com> <3552162.bMjzuKGm0O@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Dienstag, 12. Oktober 2021, 12:50:54 CEST schrieb Heiko Stübner:
> Hi Anup,
> 
> Am Dienstag, 12. Oktober 2021, 11:58:54 CEST schrieb Anup Patel:
> > The generic power domain related code in PSCI domain driver is largely
> > independent of PSCI and can be shared with RISC-V SBI domain driver
> > hence we factor-out this code into dt_idle_genpd.c and dt_idle_genpd.h.
> > 
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> 
> On a Rockchip rk3399 with "psci_idle" cpuidle driver and states
> "WFI", "cpu-sleep" and "cluster-sleep" I checked that all states
> are entered sucessfully both before and after applying this patch, so
> 
> ARM64-side:
> Tested-by: Heiko Stuebner <heiko@sntech.de>

sorry about the noise, but scrap that.

There is a difference between psci-idle and psci I only noticed too late.

Heiko


