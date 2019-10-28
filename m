Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B819E77AE
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 18:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbfJ1RgB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 13:36:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40734 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfJ1RgB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 13:36:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id p59so8529336edp.7;
        Mon, 28 Oct 2019 10:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Q/O2+63vyfOOc8TciZScYae9QvHO/ZsisH+/bPe/bY=;
        b=eVkeo5iTVCluLRShWEk6t86YnBt6Bgom3x/bEdNuXwCUtTKbOpjEU+AjA2yr2/3AOk
         oNbfVhU3uRaMEkF7tAftmoNmCJ29SmT9lEUu76xau8n8oGdNKQESu6wVkqvfw0yjATeO
         H4aT8qVMU/UQqP7pj0o4qQqEYl4MuD4aZJOQ0CxcuqPSu17tsJgjszNjQP7OgaIQx1zS
         FAzPh9nOipW12EmOz8YW0GkvYm2Ekwy1jgCBRXnxx+XfxTxgr6vnP6XQYTqXRWJWT2Yz
         5u5b5JnfhJFRMWUF4LEMwX+g0Crv0RBG1y8Ai6jbp3JK9rxcBQzqjXwrw/PJpKcRaENX
         JosA==
X-Gm-Message-State: APjAAAVf5l7ltmwVuuBLHqomhYDL5+V5fuSF7SbStIPl7uM3XsSuA8Ss
        Cihyv5JQy72r68HokQ4ZeoI=
X-Google-Smtp-Source: APXvYqzoUJl7QMBZQoYR89SoTXUdW/ohGM8/IS7x6+XbBSVHr6HcscdiM7+fVXuN3VrPgkEN0cQ0OA==
X-Received: by 2002:aa7:d3c4:: with SMTP id o4mr21407071edr.194.1572284157625;
        Mon, 28 Oct 2019 10:35:57 -0700 (PDT)
Received: from kozik-lap ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id f19sm565060edx.48.2019.10.28.10.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 10:35:56 -0700 (PDT)
Date:   Mon, 28 Oct 2019 18:35:55 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     vireshk@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v6 1/2] soc: samsung: Add Exynos Adaptive Supply Voltage
 driver
Message-ID: <20191028173555.GB14395@kozik-lap>
References: <CGME20191028151546eucas1p120f516f70114027d99724a40ea163af0@eucas1p1.samsung.com>
 <20191028151534.9920-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191028151534.9920-1-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 28, 2019 at 04:15:33PM +0100, Sylwester Nawrocki wrote:
> The Adaptive Supply Voltage (ASV) driver adjusts CPU cluster operating
> points depending on exact revision of an SoC retrieved from the CHIPID
> block or the OTP memory.  This allows for some power saving as for some
> CPU clock frequencies we can lower CPU cluster's supply voltage comparing
> to safe values common to all the SoC revisions.
> 
> This patch adds support for Exynos5422/5800 SoC, it is partially based
> on code from https://github.com/hardkernel/linux repository,
> branch odroidxu4-4.14.y, files: arch/arm/mach-exynos/exynos5422-asv.[ch].
> 
> Tested on Odroid XU3, XU4, XU3 Lite.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v5:
>  - "syscon" compatible in the chipid node is not required any more,
>    use device_node_to_regmap() instead of syscon_node_to_regmap(),
>  - dropped "Unsupported product ID" log,
>  - EXYNOS_ASV_SYSBSYS* enumeration simplified and moved to exynos5422
>    specific header,
>  - dropped unnecessary headers inclusion,
>  - dropped unused argument from exynos5422_asv_parse* helpers,
>  - added const qualifier to some function arguments.
> 
> Changes since v4:
>  - Fixed include guard in drivers/soc/samsung/exynos5422-asv.h
> 
> Changes since v3:
>  - instead of removing/adding OPP use dedicated API to adjust OPP's
>    voltage, only exynos_asv_update_cpu_opps() function has changed,
>  - added a comment describing ASV tables at beginning of
>    exynos5422-asv.c file.
> 
> Changes since v2:
>  - use devm_kzalloc() in probe() to avoid memory leak,
>  - removed leading spaces in exynos-chipid.h,
>  - removed unneeded <linux/init.h> header inclusion,
>  - dropped parentheses from exynos542_asv_parse_sg(),
>  - updated Kconfig entry,
>  - added const attribute to struct exynos_asv_susbsys::cpu_dt_compat.
> 
> Changes since v1 (RFC):
>  - removed code for parsing the ASV OPP tables from DT, the ASV OPP tables
>    moved to the driver,
>  - converted to use the regmap API,
>  - converted to normal platform driver.
> 
> ---
>  drivers/soc/samsung/Kconfig          |  10 +
>  drivers/soc/samsung/Makefile         |   3 +
>  drivers/soc/samsung/exynos-asv.c     | 177 ++++++++++
>  drivers/soc/samsung/exynos-asv.h     |  71 ++++
>  drivers/soc/samsung/exynos5422-asv.c | 505 +++++++++++++++++++++++++++
>  drivers/soc/samsung/exynos5422-asv.h |  31 ++
>  6 files changed, 797 insertions(+)
>  create mode 100644 drivers/soc/samsung/exynos-asv.c
>  create mode 100644 drivers/soc/samsung/exynos-asv.h
>  create mode 100644 drivers/soc/samsung/exynos5422-asv.c

Thanks, applied.

Best regards,
Krzysztof

