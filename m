Return-Path: <linux-pm+bounces-105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5B47F5942
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 08:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED10E1C2090D
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 07:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8E510A3C;
	Thu, 23 Nov 2023 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2lKM+wF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A5A100
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 23:33:10 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2809a824bbbso450991a91.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 23:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700724790; x=1701329590; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ffEiV3gyDVMcASEwnogOw570ilHF1Jzww0yDLp3D91A=;
        b=G2lKM+wFbbLHzvkBsHKo2taPk5w6kKP3KV06AG90ck1QDpqSbKV+NqeGYnBhugatEt
         7lvebqUyBKZRsHcck7WRkpAQF4wF0bufBiStjdVy3TW1XCd50+uBepeQifgPZSs1yyZ9
         r+kQ2dB8asilo+VGIa72bwpiFZcDAxkMKDbwFrhLdSCODRiKrwBKZv9xs2v2tH1Sk2vJ
         3ewTrHnsn6PCKKUd0DfEe1yAOSfLz0289xbd1Ns9bPKur7ahouT/uDFF0qi+p+vjZJuR
         /jwpi+kpJGhB8TvxjQrLHW/1izl8Bk4atmiLeOv7hXDM+QqvVkIO5vRzWwNsHGU8clx2
         DnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700724790; x=1701329590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffEiV3gyDVMcASEwnogOw570ilHF1Jzww0yDLp3D91A=;
        b=frEI68G/6v5+uDcyJ310k/2i9sePyG/o+QW4MosyL5SVJEgBTR0HwOOYdIqKww9opD
         o2NfbPFRc1Y8N7weOWrujMhSya99wHHH/vQr6FRbAfi9na05WK7pYgcCKO1Xqvmkj/kA
         fCpN7+pOiKtmp4aBWa+McQR8fR7eLNT9v3C8bjW3ihBhSjhYMi2mC2NOfND/TR5i1gH2
         Uiqlp4kMsMHbLBWA7Ch86PCJi94G5MiYSzbetg7Sa1UjhRRdlJPKOVY2Gqa3lzYDH2Ya
         Wrou2+n8dPUMA96a7viWAvGQ9YKS496GZTVZUpizGO4SVWvvZyZLoUaUTSZhyZQphIo/
         WLew==
X-Gm-Message-State: AOJu0Yw846XwBpgeVbW/kEEVJUkOnbtdyMzU3Y9IlZv10mgX14EGbf2G
	7Bk7zLiDRa6Y/3zOrAWgB9dYGg==
X-Google-Smtp-Source: AGHT+IEfgTIAg/DkFLGwiJvcTbNfYpNcdqN4KZFX93yabcAErmxr+c3FyEtlUcwSx3IxCgFGctptOA==
X-Received: by 2002:a17:90b:4c4b:b0:280:2652:d41 with SMTP id np11-20020a17090b4c4b00b0028026520d41mr4398418pjb.4.1700724790066;
        Wed, 22 Nov 2023 23:33:10 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id ci8-20020a17090afc8800b0027d0adf653bsm666844pjb.7.2023.11.22.23.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 23:33:09 -0800 (PST)
Date: Thu, 23 Nov 2023 13:03:07 +0530
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
Message-ID: <20231123073307.kvw25kg4hjce5jbp@vireshk-i7>
References: <20231122134113.63670-1-cniedermaier@dh-electronics.com>
 <20231123072840.vds22wlb7hzgnye3@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123072840.vds22wlb7hzgnye3@vireshk-i7>
X-Spam-Level: *

On 23-11-23, 12:58, Viresh Kumar wrote:
> On 22-11-23, 14:41, Christoph Niedermaier wrote:
> > For a 900MHz i.MX6ULL CPU the 792MHz OPP is disabled. There is no
> > convincing reason to disable this OPP. If a CPU can run at 900MHz,
> > it should also be able to cope with 792MHz. Looking at the voltage
> > level of 792MHz in [1] (page 24, table 10. "Operating Ranges") the
> > current defined OPP is above the minimum. So the voltage level
> > shouldn't be a problem. However in [2] (page 24, table 10.
> > "Operating Ranges"), it is not mentioned that 792MHz OPP isn't
> > allowed. Change it to only disable 792MHz OPP for i.MX6ULL types
> > below 792 MHz.
> > 
> > [1] https://www.nxp.com/docs/en/data-sheet/IMX6ULLIEC.pdf
> > [2] https://www.nxp.com/docs/en/data-sheet/IMX6ULLCEC.pdf
> > 
> > Fixes: 0aa9abd4c212 ("cpufreq: imx6q: check speed grades for i.MX6ULL")
> > Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> > Reviewed-by: Marek Vasut <marex@denx.de>
> > Reviewed-by: Fabio Estevam <festevam@denx.de>
> > ---
> > V2: - Improve the commit message
> >     - Add Fixes tag
> >     - Add Reviewed-by tag
> > ---
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> > Cc: Stefan Agner <stefan@agner.ch>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Marek Vasut <marex@denx.de>
> > Cc: Fabio Estevam <festevam@denx.de>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > To: linux-arm-kernel@lists.infradead.org
> > ---
> >  drivers/cpufreq/imx6q-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> > index 494d044b9e72..33728c242f66 100644
> > --- a/drivers/cpufreq/imx6q-cpufreq.c
> > +++ b/drivers/cpufreq/imx6q-cpufreq.c
> > @@ -327,7 +327,7 @@ static int imx6ul_opp_check_speed_grading(struct device *dev)
> >  			imx6x_disable_freq_in_opp(dev, 696000000);
> >  
> >  	if (of_machine_is_compatible("fsl,imx6ull")) {
> > -		if (val != OCOTP_CFG3_6ULL_SPEED_792MHZ)
> > +		if (val < OCOTP_CFG3_6ULL_SPEED_792MHZ)
> >  			imx6x_disable_freq_in_opp(dev, 792000000);
> >  
> >  		if (val != OCOTP_CFG3_6ULL_SPEED_900MHZ)
> 
> What about another similar check ?
> 
> 		if (val != OCOTP_CFG3_6ULL_SPEED_900MHZ)

Yeah, that isn't required I guess.

Applied. Thanks.

-- 
viresh

