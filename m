Return-Path: <linux-pm+bounces-104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF6A7F5937
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 08:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A676A281218
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 07:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C57A168A4;
	Thu, 23 Nov 2023 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZhH8/68"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E32110
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 23:28:43 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cb55001124so1224607b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 23:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700724523; x=1701329323; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oOpcXmiBIDh/X0eIBXMfB+uo9xCU3x3A5tDFUwNRRs8=;
        b=JZhH8/68k04HsvjGBrFDXqDrHdHRjMHHgn7h1XvrM9gjCiPzgEBuw6V0wCQTyY8gZc
         oIpyJosWKNRuaBYEwdrmXTlD+nyXD6vY1tMT39Ik2xp9oBryFu6nbjl/AZ+qhLIF5GZT
         R8zG9Um3KoXYAxcu1HDHRPzSVQPaV/wOLtIBf8Bh/9qB6oCFNfxxqiGMKWq9xImqb1tA
         E97SXTn1ZEYzTjmg3pE1oCo/AVGZOYCLsNHaBhilA+M8yJGtq1OpcPm/8B3CCFYu7e0k
         RQ7MJ+8tHqqNg9mAYkh6O8RbJZMu0EY1EnrE+35Qg3NGhiY1q8pye7AeS9qRvSdoMfQt
         TQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700724523; x=1701329323;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOpcXmiBIDh/X0eIBXMfB+uo9xCU3x3A5tDFUwNRRs8=;
        b=t3k35XpQGWi6nyudzWl1BoLLiSUlMGp4yYuohRHpbnm3FSkd5SprPn30BHeyzPQdZq
         9/vcjCuEXAOlJmdDRD7pjCUJ4eOUPj99HH+ddUTSucoWa2twq6zo30qkPV9EDzmTnA8b
         ZD7g/BFedsZAQgTCBoazyK0w8O0u/OFCgAldcQuvZTHYXtNyP7ND1httQwn5Enw8SB/8
         Xm1iIrZeIEWaeDCZVQyTJsq51BcxdKG4PtDoBv3kShr9k4ph7FHmysQRWl6YjcEfPypG
         S/JboHLgbp738niA+atqAr2PG4yNpI6gWd9Af1IXpxCXwEsVsxhQGd7grv1xbfpN9JKZ
         yTog==
X-Gm-Message-State: AOJu0YxiXSItJL0Ca9+qgOWMQM+RiLU38h5QEgdJZH2e3X1v4XnQRg83
	IosXjPQwhWlc0LmeaaXW1C5Xyw==
X-Google-Smtp-Source: AGHT+IEoSb6gQS1kuuioEzNYPrByuL5ADMEQ8JQeY2qXtDtBxjRBSl1RiFmrAj/729LaLsa2+jZh4g==
X-Received: by 2002:a05:6a20:3d8b:b0:18b:acc8:a5fa with SMTP id s11-20020a056a203d8b00b0018bacc8a5famr455309pzi.7.1700724523028;
        Wed, 22 Nov 2023 23:28:43 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79188000000b00686b649cdd0sm607620pfa.86.2023.11.22.23.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 23:28:42 -0800 (PST)
Date: Thu, 23 Nov 2023 12:58:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	=?utf-8?Q?S=C3=A9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
	Stefan Agner <stefan@agner.ch>, Shawn Guo <shawnguo@kernel.org>,
	Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
	NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: imx6q: Only disabling 792MHz OPP for
 i.MX6ULL types below 792MHz
Message-ID: <20231123072840.vds22wlb7hzgnye3@vireshk-i7>
References: <20231122134113.63670-1-cniedermaier@dh-electronics.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231122134113.63670-1-cniedermaier@dh-electronics.com>
X-Spam-Level: *

On 22-11-23, 14:41, Christoph Niedermaier wrote:
> For a 900MHz i.MX6ULL CPU the 792MHz OPP is disabled. There is no
> convincing reason to disable this OPP. If a CPU can run at 900MHz,
> it should also be able to cope with 792MHz. Looking at the voltage
> level of 792MHz in [1] (page 24, table 10. "Operating Ranges") the
> current defined OPP is above the minimum. So the voltage level
> shouldn't be a problem. However in [2] (page 24, table 10.
> "Operating Ranges"), it is not mentioned that 792MHz OPP isn't
> allowed. Change it to only disable 792MHz OPP for i.MX6ULL types
> below 792 MHz.
> 
> [1] https://www.nxp.com/docs/en/data-sheet/IMX6ULLIEC.pdf
> [2] https://www.nxp.com/docs/en/data-sheet/IMX6ULLCEC.pdf
> 
> Fixes: 0aa9abd4c212 ("cpufreq: imx6q: check speed grades for i.MX6ULL")
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Fabio Estevam <festevam@denx.de>
> ---
> V2: - Improve the commit message
>     - Add Fixes tag
>     - Add Reviewed-by tag
> ---
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 494d044b9e72..33728c242f66 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -327,7 +327,7 @@ static int imx6ul_opp_check_speed_grading(struct device *dev)
>  			imx6x_disable_freq_in_opp(dev, 696000000);
>  
>  	if (of_machine_is_compatible("fsl,imx6ull")) {
> -		if (val != OCOTP_CFG3_6ULL_SPEED_792MHZ)
> +		if (val < OCOTP_CFG3_6ULL_SPEED_792MHZ)
>  			imx6x_disable_freq_in_opp(dev, 792000000);
>  
>  		if (val != OCOTP_CFG3_6ULL_SPEED_900MHZ)

What about another similar check ?

		if (val != OCOTP_CFG3_6ULL_SPEED_900MHZ)

-- 
viresh

