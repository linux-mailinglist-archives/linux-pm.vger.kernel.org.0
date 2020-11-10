Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBC42ADDDC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 19:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgKJSMA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 10 Nov 2020 13:12:00 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42432 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJSMA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 13:12:00 -0500
Received: by mail-ed1-f66.google.com with SMTP id v22so3419705edt.9;
        Tue, 10 Nov 2020 10:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ObZ+uatBT5aV3E0Ee3Zvvp2n0wcTHU9I6h5xLp1wh8Y=;
        b=n/WTFtmykjcIqILh0ycRB9SG0w5VY1LQx9tbAWOoKWLL6B6WSam5zWuX6GBb0vlk+4
         vcxKNHWA0hEasYzMDX0Vafjs4Xe4CBpIwHQEihFEn82qzlIrAY2CDP4d5nVf3gU661ub
         J6E43rS57TqnD0sbTf1ObnZPOaElLyAdjdrECgYRTXithU8kXLbCYL6pztzRyjFB5Qfa
         3dXss+fTfLI/KTP6Asu9Pj2CuIA/j8qYktnwh2Jhd2l3UIcy1YK9dwvCv+OQsdihcc3T
         hhE8Oxb1yIa5GpsyQi39VfOlhlkY6cPwLNncoTc6LQok4+FQFGssi1YVZsMUGLq+oGFQ
         8gjg==
X-Gm-Message-State: AOAM531jzq/8G6h9EWsZLv2zqXAHk3bTM/IQeGO+yS5rYMu1zDwuV7zE
        L+zUOlqnoKUlJaB09OJ/d9vqqZLrst8=
X-Google-Smtp-Source: ABdhPJwH9rjo7WFDRce3ZY6Wa0VD4LphG89cjoxx/d+KTfqVHXT4euGN+saA+HjI7WjxqocCsmFDRA==
X-Received: by 2002:aa7:c546:: with SMTP id s6mr609076edr.114.1605031918334;
        Tue, 10 Nov 2020 10:11:58 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id rn28sm11065161ejb.22.2020.11.10.10.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:11:57 -0800 (PST)
Date:   Tue, 10 Nov 2020 19:11:55 +0100
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
Subject: Re: [PATCH v8 5/7] ARM: dts: exynos: Add interconnect properties to
 Exynos4412 bus nodes
Message-ID: <20201110181155.GA18447@kozik-lap>
References: <20201104103657.18007-1-s.nawrocki@samsung.com>
 <CGME20201104103726eucas1p248b51b25f5ee42898bf03e9cb2229c5d@eucas1p2.samsung.com>
 <20201104103657.18007-6-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201104103657.18007-6-s.nawrocki@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 11:36:55AM +0100, Sylwester Nawrocki wrote:
> This patch adds the following properties for Exynos4412 interconnect
> bus nodes:
>  - interconnects: to declare connections between nodes in order to
>    guarantee PM QoS requirements between nodes,
>  - #interconnect-cells: required by the interconnect framework,
>  - samsung,data-clk-ratio: which allows to specify minimum data clock
>    frequency corresponding to requested bandwidth for each bus.
> 
> Note that #interconnect-cells is always zero and node IDs are not
> hardcoded anywhere.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v8:
>  - none.
> 
> Changes for v7:
>  - adjusted to the DT property changes: "interconnects" instead
>    of "samsung,interconnect-parent", "samsung,data-clk-ratio"
>    instead of "bus-width".
> 
> Changes for v6:
>  - added bus-width property in bus_dmc node.
> 
> Changes for v5:
>  - adjust to renamed exynos,interconnect-parent-node property,
>  - add properties in common exynos4412.dtsi file rather than
>    in Odroid specific odroid4412-odroid-common.dtsi.
> ---
>  arch/arm/boot/dts/exynos4412.dtsi | 6 ++++++

Thanks, applied with Chanwoo's tags.

Best regards,
Krzysztof

