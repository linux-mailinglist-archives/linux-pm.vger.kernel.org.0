Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F8D45C32
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 14:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfFNMKB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 08:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfFNMKB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Jun 2019 08:10:01 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22B7B21744;
        Fri, 14 Jun 2019 12:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560514200;
        bh=8IHr1gLtD4hNqNX6dX49R4OHXx8RZC0mKA9co1k7r0Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GRFjtJqWs4Od0DofHFi5X08sv06mdK/RmdUQr3mBnKJYdS1uNW9H4VEWsGocmZl0v
         v1vpqtasZs0f8s3yZu9IfMLakCLgDLMo69noidjS1RrEHnUd7pc5tH2LiItKAtlX7t
         cf46L8Z+/cakYobSvceGWddDvqsGgClDTdNe5i3s=
Received: by mail-lj1-f182.google.com with SMTP id a21so2149304ljh.7;
        Fri, 14 Jun 2019 05:10:00 -0700 (PDT)
X-Gm-Message-State: APjAAAXuRuf/qP/Ly5dy4rses5L3NEosCNqWhNi8vnn/9Bud/hmMuit+
        xgY+CgcHnSeHQ8Z6atijndIqMUTVq76hkEM4xEI=
X-Google-Smtp-Source: APXvYqwY1vJUmcClY7DiOhpKQac9810LonMaVqUAY+cbDTalTdSgVuGq1lXMJRDJ3zZvhaS6+/qwdx4Tw6yJNS0UFq0=
X-Received: by 2002:a2e:94c9:: with SMTP id r9mr4914536ljh.210.1560514198446;
 Fri, 14 Jun 2019 05:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190614095327eucas1p19b6e522efa15c8fd21c51f3900e376e9@eucas1p1.samsung.com>
 <20190614095309.24100-1-l.luba@partner.samsung.com> <20190614095309.24100-9-l.luba@partner.samsung.com>
In-Reply-To: <20190614095309.24100-9-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 14 Jun 2019 14:09:47 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf=N28g850Q67z2sA5-KtkmqTuYLDcR0E_q1gSa17wWWw@mail.gmail.com>
Message-ID: <CAJKOXPf=N28g850Q67z2sA5-KtkmqTuYLDcR0E_q1gSa17wWWw@mail.gmail.com>
Subject: Re: [PATCH v10 08/13] drivers: memory: add DMC driver for Exynos5422
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 14 Jun 2019 at 11:53, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> This patch adds driver for Exynos5422 Dynamic Memory Controller.
> The driver provides support for dynamic frequency and voltage scaling for
> DMC and DRAM. It supports changing timings of DRAM running with different
> frequency. There is also an algorithm to calculate timigns based on
> memory description provided in DT.
> The patch also contains needed MAINTAINERS file update.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  MAINTAINERS                             |    8 +
>  drivers/memory/samsung/Kconfig          |   17 +
>  drivers/memory/samsung/Makefile         |    1 +
>  drivers/memory/samsung/exynos5422-dmc.c | 1262 +++++++++++++++++++++++
>  4 files changed, 1288 insertions(+)
>  create mode 100644 drivers/memory/samsung/exynos5422-dmc.c

Looks good to me. I think there is no dedicated maintainer for
drivers/memory subsystem so I can take it through samsung-soc tree
(just like in case of drivers/memory/samsung/exynos-srom.c). Are
everyone OK with it?

Best regards,
Krzysztof
