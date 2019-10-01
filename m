Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0213C4105
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 21:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfJAT3z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 15:29:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38757 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfJAT3z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 15:29:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so4485491wmi.3;
        Tue, 01 Oct 2019 12:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q0iDGc1E9ekhBaWFlBf1LP49ZCDrj5bAJUiHy7EZfQo=;
        b=OJEsqWCPeV3koRWKNwLNdwiJ+hZaOw3z45FgC0fUt06AXrTwkdRv+B2Un4gb98yCTk
         54C7MH7n671dH+6eeUX3AGH455+Mg8qY9T7Mr5Y5cBIgBzP7H6iOFCWpbXYkC8o+WZZb
         ehChgjEVj5BxYp/p7L13qhnZ1MXfTlg0O9Wx+ykMVMCoA73NMC6zNMIH5L5SAAVao9Z8
         17u55mDdOZ0yukHeMp0ljbtTQr+4htkOxme+y7BtJVMA1bD/+/V13+Kozknl4NxOd1l1
         TKreACbVJDWuX+p9+7VeqJU43rl7l2ZLUam3k6+S7WdG20nCO7SweK6wbdj1kZF8DYR9
         s8Jw==
X-Gm-Message-State: APjAAAVJU+BkQrPDWV8UB7nD45voFEAK3XXqLD5BnTVsPSllR8ryIRY4
        HJU4ahcdE6Fsa3/zVyWUXiE=
X-Google-Smtp-Source: APXvYqz8SWAyLJpy57Jibq45aJj30fnZ1zAgPLs0+ck9XS1xtptYz2Won1AlyuNYf/aSOVkTsYP1bw==
X-Received: by 2002:a05:600c:351:: with SMTP id u17mr5345904wmd.130.1569958192282;
        Tue, 01 Oct 2019 12:29:52 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id b186sm6524895wmd.16.2019.10.01.12.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 12:29:51 -0700 (PDT)
Date:   Tue, 1 Oct 2019 21:29:47 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, b.zolnierkie@samsung.com, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v13 0/8] Exynos5 Dynamic Memory Controller driver
Message-ID: <20191001192947.GA1815@kozik-lap>
References: <CGME20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8@eucas1p2.samsung.com>
 <20190821104303.32079-1-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821104303.32079-1-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 21, 2019 at 12:42:55PM +0200, Lukasz Luba wrote:
> Hi all,
> 
> This is v13 which makes cosmetic changes. It is based on current mainline
> (v5.3-rc5) with with devfreq/for-next where there is a PPMU patch [1].
> 
> The patch set adds support of Dynamic Memory Controller for Exynos5422 SoC.
> The driver supports Dynamic Voltage and Frequency Scaling
> for the DMC and DRAM. It also provides needed timings for different
> speed operations of the DRAM memory.
> There is also new generic code in of_memory and headers which allows to parse
> LPDDR3 memories defined in device-tree.
> 
> Here are the last changes suggested by Krzysztof during his review.
> For the previous changes in older revisions please refer to [2], there is
> more detailed change log.
> 
> changes:
> v13:
> - skipped patch with chipID changes in DT, since it is not used anymore,
> - removed license comment in of_memory.c since SPDX has been merged,
> - aligned comment to the current fields in the structure,
> - changed printed warning when timings are not found,
> 
> Regards,
> Lukasz Luba
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/commit/?h=for-next&id=b617376df8f01c975dee66802f4da16291f92079
> [2] https://lkml.org/lkml/2019/7/22/251
> 
> 
> Lukasz Luba (8):
>   dt-bindings: ddr: rename lpddr2 directory
>   dt-bindings: ddr: add LPDDR3 memories
>   drivers: memory: extend of_memory by LPDDR3 support
>   dt-bindings: memory-controllers: add Exynos5422 DMC device description
>   drivers: memory: add DMC driver for Exynos5422
>   ARM: dts: exynos: add syscon to clock compatible
>   ARM: dts: exynos: add DMC device for exynos5422
>   ARM: exynos_defconfig: enable DMC driver
>

Just to let you know:

I applied the set some days ago but this did not make to merge window.
Now, I put it on for-next branch so will appear on linux-next soon. I
also applied the fixes sent later.

I'll take also the latest work with interrupt mode for DMC (after minor
fix in bindings).

Best regards,
Krzysztof

