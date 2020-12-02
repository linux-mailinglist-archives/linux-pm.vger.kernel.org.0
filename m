Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479502CC952
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 23:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgLBWFP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 17:05:15 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:41020 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLBWFP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 17:05:15 -0500
Received: by mail-ej1-f68.google.com with SMTP id f23so361001ejt.8;
        Wed, 02 Dec 2020 14:04:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FLQRrJdRQRW07zjr5Xq/Y30bP6fkFk0ghfD0rgGQLLQ=;
        b=SAilAzUU+JeTrgykOwtvnRZQiqBJG3kTYnK62KtZLvLi/7Kdv0edXOPw+hP77a7DUu
         EKEcRv3sTsKdY+Hq4JBJcwYHqOfwGzVe4M3flDXtX4VQv/CV2XYTnbbIO7rZk1xJIJTn
         qEUoJlb+cAet0smOkX3WFlmW0i0XQ/YGDz/MiPshMx/g3U13InW7zYo1OX871xVQquRK
         skFgPRunxyyC88sqq5gXJbILo8kqFTUMUfGyzE1jax1mz5+7Gxx4HD7Ng6xLRzW15dnu
         Yn7Mx5bGYADpCQ2yuGqgDXq0ZnzQpKn61hJlNnmQlYih/lXP/U9XzxrZvtiG5pDfwiUg
         ZnVw==
X-Gm-Message-State: AOAM533ZCIFnDTliY6qUsYsEi+XQY6E0ehV+YV0WEMLmulcgsllEtLiS
        0v/qdrkolu4b2GxT4kZwO5s=
X-Google-Smtp-Source: ABdhPJw8KbLUcLavsavX3o/08tR7+M9k4icmncsa4ebLT0Hev8ojD58k0LbcsMNIwR+Imi2osuZJwQ==
X-Received: by 2002:a17:906:7e43:: with SMTP id z3mr1786272ejr.67.1606946673313;
        Wed, 02 Dec 2020 14:04:33 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n7sm42628edb.34.2020.12.02.14.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 14:04:32 -0800 (PST)
Date:   Thu, 3 Dec 2020 00:04:30 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 3/3] ARM: dts: exynos: Fix charging regulator voltage and
 current for i9100
Message-ID: <20201202220430.GB135888@kozik-lap>
References: <20201202203516.43053-1-timon.baetz@protonmail.com>
 <20201202203516.43053-3-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202203516.43053-3-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 02, 2020 at 09:07:28PM +0000, Timon Baetz wrote:
> Set CHARGER current and CHARGER_CV voltage according to Galaxy S2 kernel
> fork.
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  arch/arm/boot/dts/exynos4210-i9100.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
> index 9f8d927e0d21..2700d53ea01b 100644
> --- a/arch/arm/boot/dts/exynos4210-i9100.dts
> +++ b/arch/arm/boot/dts/exynos4210-i9100.dts
> @@ -558,14 +558,14 @@ safe2_sreg: ESAFEOUT2 {
>  
>  			charger_reg: CHARGER {
>  				regulator-name = "CHARGER";
> -				regulator-min-microamp = <60000>;
> -				regulator-max-microamp = <2580000>;
> +				regulator-min-microamp = <200000>;
> +				regulator-max-microamp = <950000>;
>  			};
>  
>  			chargercv_reg: CHARGER_CV {
>  				regulator-name = "CHARGER_CV";
> -				regulator-min-microvolt = <3800000>;
> -				regulator-max-microvolt = <4100000>;
> +				regulator-min-microvolt = <4200000>;
> +				regulator-max-microvolt = <4200000>;

I am looking at my sources of Android 3.0 for GT-I9100 but I cannot find
charger voltages for it. Where did you find it?

Best regards,
Krzysztof
