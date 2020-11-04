Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6502A65D2
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 15:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgKDOGW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 09:06:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40414 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgKDOGW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 09:06:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id k18so2423915wmj.5;
        Wed, 04 Nov 2020 06:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S41teLRLSZ7isGd7nFyvP35fxvOeeax7aZ66a+ME5Ss=;
        b=cK1aHpaSQh6BAEvBb0+cEMuC6ob/HqGktSYGqM0a6ChzjoBj17USMkgNj/YXmM0zwf
         bMWC4hoFiMyzIKIUN8guRldlieXgRnapU2nK9nal7ShhSc6pIaOhOUD49XTLPdEZf9ke
         3UAWlFzdI5n9pPW7O7T9VYdeG/Np95gjDBXTsJnbIgcTmx0Xp11vcSiEkspMpWVcrsuI
         7H6F5vVNg03OHB12cvP+pca3gEB9ev84bFsx7UKxN3STCvGlTTk1mqjVPECvYQ1PTMxP
         0fZOo4Bg4xuGE5T706pO3ceTLS7vhSAVj8E831F52DnfFgYzf5MwMFUk9S3aKGrxJ5kR
         7sUg==
X-Gm-Message-State: AOAM530JNMiL6Qnpf8mOvDqWfsxwX9uayvl8PNypn6VUry8J3G6EoRNp
        a0NkpewYotWOtHHg7qJ/O+W0SAl07QQ=
X-Google-Smtp-Source: ABdhPJzub2Qdl39XwePCwW5f4Na1s1gFDl9l1dWju07Y2lOINxiR82U83DMQ2PjXZBKrxm2EzbTIJg==
X-Received: by 2002:a05:600c:2282:: with SMTP id 2mr5089187wmf.154.1604498779470;
        Wed, 04 Nov 2020 06:06:19 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id g186sm6885889wma.1.2020.11.04.06.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 06:06:17 -0800 (PST)
Date:   Wed, 4 Nov 2020 15:06:16 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 2/7] interconnect: Add generic interconnect driver for
 Exynos SoCs
Message-ID: <20201104140616.GA3024@kozik-lap>
References: <20201104103657.18007-1-s.nawrocki@samsung.com>
 <CGME20201104103720eucas1p1014217e751a681796ed508af22c6bb12@eucas1p1.samsung.com>
 <20201104103657.18007-3-s.nawrocki@samsung.com>
 <20201104123729.GA13371@kozik-lap>
 <346da718-2340-c862-9a1a-c5f64aae19c2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <346da718-2340-c862-9a1a-c5f64aae19c2@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 02:22:37PM +0100, Sylwester Nawrocki wrote:
> On 04.11.2020 13:37, Krzysztof Kozlowski wrote:
> > On Wed, Nov 04, 2020 at 11:36:52AM +0100, Sylwester Nawrocki wrote:
> 
> >> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> >> index d203520..c2f9e9d 100644
> >> --- a/drivers/interconnect/Makefile
> >> +++ b/drivers/interconnect/Makefile
> >> @@ -6,3 +6,4 @@ icc-core-objs				:= core.o bulk.o
> >>  obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
> >>  obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
> >>  obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
> >> +obj-$(CONFIG_INTERCONNECT_SAMSUNG)	+= samsung/
> >> \ No newline at end of file
> > 
> > This needs a fix.
> 
> Corrected, thanks for pointing out.
>  
> >> diff --git a/drivers/interconnect/samsung/Kconfig b/drivers/interconnect/samsung/Kconfig
> >> new file mode 100644
> >> index 0000000..508ed64
> >> --- /dev/null
> >> +++ b/drivers/interconnect/samsung/Kconfig
> >> @@ -0,0 +1,13 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only
> >> +config INTERCONNECT_SAMSUNG
> >> +	bool "Samsung interconnect drivers"
> > 
> > "Samsung SoC interconnect drivers"
> 
> Changed.
> 
> >> +	depends on ARCH_EXYNOS || COMPILE_TEST
> > 
> > Don't the depend on INTERCONNECT?
> 
> This file gets included only if INTERCONNECT is enabled, see
> higher level Kconfig file.

I missed the include part, looks good.

>  
> >> +	help
> >> +	  Interconnect drivers for Samsung SoCs.
> >> +
> >> +
> > 
> > One line break
> 
> Fixed.
> 
> >> +config INTERCONNECT_EXYNOS
> >> +	tristate "Exynos generic interconnect driver"
> >> +	depends on INTERCONNECT_SAMSUNG
> > 
> > How about:
> > default y if ARCH_EXYNOS
> 
> OK, added.
> 
> >> +	help
> >> +	  Generic interconnect driver for Exynos SoCs.
> >> diff --git a/drivers/interconnect/samsung/Makefile b/drivers/interconnect/samsung/Makefile
> >> new file mode 100644
> >> index 0000000..e19d1df
> >> --- /dev/null
> >> +++ b/drivers/interconnect/samsung/Makefile
> >> @@ -0,0 +1,4 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +exynos-interconnect-objs		:= exynos.o
> > 
> > What is this line for?
>  
> That allows to change the module name, so it's exynos-interconnect.ko
> rather than just exynos.c. It's done similarly for other SoCs in 
> the subsystem.

Thanks, makes sense.

Best regards,
Krzysztof
