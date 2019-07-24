Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B83B734A9
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 19:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfGXRKy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 13:10:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35967 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfGXRKy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 13:10:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so47882748wrs.3;
        Wed, 24 Jul 2019 10:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WXZ1g7GkxFmyDSWuDgpIVN7PNvx6qdlx90diYuseAHM=;
        b=OxcpcrsB+Nh2xELyiA1Yv99FUMYEvIzlG+yG6yit/9f+ygFbVXl643sfdbjfTELuxq
         idsz3sFggjLg/Gg6NF+dJf2rjjIRxeqPZ5MDsKX1ZrRlC4uObhXX86heyKh95Wkodj1v
         U4WUJ7pn/cEGUy5B5uC2ApCHw4MAEq+lXuXA+rMOTNcVtDEAwKk6NUb1f1FN3r/AIsc8
         ydWZ8mnHClDLJXGMtD/8V6agsp4T0+iwtYvMAjPnf2irlIjEZitUM59y9ZDzfCsL2+Qn
         OPFMhSkgXvUBr7kctdng2R97yfAlcf3Qmp7mL9KGMN6Xx8w/c8vAMK5xFNQHkZNZVGJh
         eLWw==
X-Gm-Message-State: APjAAAVD+MFvB6sQcMX6EAM6DmggUnFOkh3csKTByiHJ7qYFVClzvfqa
        1NesBTuV8WdHIkf0Yv4Ae+k=
X-Google-Smtp-Source: APXvYqw3AXAnk2BJ//1eeyPDtP4kO0/8LrlqA6LpAN1k2ctyqioKAHYzmf7hgtsMo7drCGHj11qc2Q==
X-Received: by 2002:adf:da4d:: with SMTP id r13mr57744544wrl.281.1563988252192;
        Wed, 24 Jul 2019 10:10:52 -0700 (PDT)
Received: from kozik-lap ([194.230.155.239])
        by smtp.googlemail.com with ESMTPSA id n9sm88609422wrp.54.2019.07.24.10.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 10:10:51 -0700 (PDT)
Date:   Wed, 24 Jul 2019 19:10:49 +0200
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
Subject: Re: [PATCH v12 6/9] ARM: dts: exynos: add chipid label and syscon
 compatible
Message-ID: <20190724171049.GA11333@kozik-lap>
References: <20190722094646.13342-1-l.luba@partner.samsung.com>
 <CGME20190722094730eucas1p2f3f8298c43c8bf0d96135bca9a9e753b@eucas1p2.samsung.com>
 <20190722094646.13342-7-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190722094646.13342-7-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 22, 2019 at 11:46:43AM +0200, Lukasz Luba wrote:
> Add the chipid label which allows to use it in phandle from other device.
> Use syscon in compatible to get the regmap of the device register set.
> The chipid is used in DMC during initialization to compare compatibility.
> 

I cannot find its usage in DMC driver.

Best regards,
Krzysztof


> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
> index 67f9b4504a42..4801ca759feb 100644
> --- a/arch/arm/boot/dts/exynos5.dtsi
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -35,8 +35,8 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> -		chipid@10000000 {
> -			compatible = "samsung,exynos4210-chipid";
> +		chipid: chipid@10000000 {
> +			compatible = "samsung,exynos4210-chipid", "syscon";
>  			reg = <0x10000000 0x100>;
>  		};
>  
> -- 
> 2.17.1
> 
