Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC17653BF
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 11:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfGKJ0S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 05:26:18 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16056 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfGKJ0S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 05:26:18 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d2700be0000>; Thu, 11 Jul 2019 02:26:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 11 Jul 2019 02:26:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 11 Jul 2019 02:26:17 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Jul
 2019 09:26:15 +0000
Subject: Re: [PATCH v2 1/6] ARM: tegra: Remove cpuidle drivers
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190711031312.10038-1-digetx@gmail.com>
 <20190711031312.10038-2-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c087a5cb-2ffa-1cf6-f0bf-631234759a22@nvidia.com>
Date:   Thu, 11 Jul 2019 10:26:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711031312.10038-2-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562837182; bh=hqIKbaLc9u3UzCLBN+TeJmaoAdvZZzW+MJhMM3sW0uY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bbF0YZqRGy0UYIMDV+2nHio1AliAu0r+Pj2lye6MoUfl1nPCx6h3eIgTiVsMLPlNQ
         Br5tEJk3HRK62aXro7HboHWQQHR/oVb4IRR7Ra5OaiIF/0srCD6aen9R59wAW5UDXB
         hSIQoBLPYecQPq0mqcY8waaODaZ04MkZo9CuSoEwEOxvGbFO34ohFnXfk/s3B8xTcq
         +3VPzdC/1IDOmHbIqRR4PDPhj+9iAeaqoRxjXgACWMvIqw1mxmTo8hfJh5CQu5ya7k
         s7l5xpDZ8klmr83hfskwnKIMMC4w/qT/KG71NB3wrycPi8/yeCb6ph8Ek640Guq9dG
         0WRkc6OdafrNw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 11/07/2019 04:13, Dmitry Osipenko wrote:
> Remove the old drivers to replace them cleanly with a new one later on.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/Makefile           |  13 --
>  arch/arm/mach-tegra/cpuidle-tegra114.c |  89 -----------
>  arch/arm/mach-tegra/cpuidle-tegra20.c  | 212 -------------------------
>  arch/arm/mach-tegra/cpuidle-tegra30.c  | 132 ---------------
>  arch/arm/mach-tegra/cpuidle.c          |  50 ------
>  arch/arm/mach-tegra/cpuidle.h          |  21 ---
>  arch/arm/mach-tegra/irq.c              |  18 ---
>  arch/arm/mach-tegra/irq.h              |  11 --
>  arch/arm/mach-tegra/pm.c               |   7 -
>  arch/arm/mach-tegra/pm.h               |   1 -
>  arch/arm/mach-tegra/reset-handler.S    |  11 --
>  arch/arm/mach-tegra/reset.h            |   9 +-
>  arch/arm/mach-tegra/sleep-tegra20.S    | 190 +---------------------
>  arch/arm/mach-tegra/sleep.h            |  12 --
>  arch/arm/mach-tegra/tegra.c            |   3 -
>  drivers/soc/tegra/Kconfig              |   1 -
>  include/soc/tegra/cpuidle.h            |   4 -
>  17 files changed, 5 insertions(+), 779 deletions(-)
>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
>  delete mode 100644 arch/arm/mach-tegra/cpuidle.c
>  delete mode 100644 arch/arm/mach-tegra/cpuidle.h
>  delete mode 100644 arch/arm/mach-tegra/irq.h

By removing all the above, it is really hard to review the diff. Is
there any way you could first consolidate the cpuidle drivers into say
the existing arch/arm/mach-tegra/cpuidle-tegra20.c and then move to
drivers/cpuidle?

Jon

-- 
nvpublic
