Return-Path: <linux-pm+bounces-37775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 959E5C4C6B4
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 09:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E643C3A29DF
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 08:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25E526AA94;
	Tue, 11 Nov 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mIxigrh9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C95242D78
	for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849995; cv=none; b=S3igJqaq1ct5hg0/Ez/HpZPOzPAUi71SWGWWknLKVhmpKb5vs4EjX832M98KV+q1hzKHIHUhw/tWwDi43UV/lk0Xv7w662vzv+L+9ClrdeIxs1YnMkk56y5MJeGQIuVQIj3Dpw8+9tyorHT0uVLhWPHAK6ej6niVmX9sQ7BSwck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849995; c=relaxed/simple;
	bh=KkQR3qjMGcmcRG03S5TpNxbLTtiLHYQnFdAZ64cshdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh+9Zt9jcTmCSW6OdEdI6cxBKHMjpawya2F5J7nkjnpM0hqkJAhSlLiL4+v5+Y1YdQKuNqDofZIHJyZruL2QUafOYlVlRMWJYwfgzRH6cmivOXqo5ejqbGJSyd+ry3T02nT2C0Dz3R6hPjXM3l764j5YChpVcrF5igsQLTvTSyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mIxigrh9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7af603c06easo644344b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 00:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762849992; x=1763454792; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QeDeCGT894mIiwkpqgXKDFFM7nVk6H8CoMJxBer/3TQ=;
        b=mIxigrh9Q5gGVU1A82Yb/17TjUZ9T9CjmMS9fB8hDpEw1ruX2UW8kthVY2SvZtUO3H
         sJpCFEuYplgqbSCn5UHtiGiDLPTtIvFH2asgN+puhpdjbarZfuKjvVIR7Etpzt7hBZHT
         6a8eaCD+6u7ZSStPX++MC/vGtaHsiy6MfCvt+O/eRCxg8x3v+svEu57M4vd03r6h1s9i
         e/q3xQuianmaiAbClkMdDvU/x63r96PQVvRGvM07i9aRTZ8JUQl2c3sxSgfV2yTNFBFa
         9z5TZ3OhY6vw6O0HklDBoXR4503LtUjKzKUvpj3qRia80izDfRz/HcoKicjZws+DCF/R
         055A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762849992; x=1763454792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeDeCGT894mIiwkpqgXKDFFM7nVk6H8CoMJxBer/3TQ=;
        b=vgisdZxOVI4Ia0DHFT47a2vnaFO9cNhCYxnfvy2lyXJQvKQX7PuIWVKOdk6rNNKQPU
         CoOWAd0ab5QWhqu3KfzGa4bqxta+j+j9DxAiHZj4Que0kLO3U18pakzD2ax6fGVuRxPX
         63dZHtWWJPGGVt5p1YI9ZUieCLe5hVsTg2jC5wPVsrPWmQ20M7llxCJSq5QJlcyjTjok
         2bUOpz7FM5O5H1F+yGU1qzu7L4R8xEucrCPnVTtaEXmOBmaLPxQVC5BZKEQUgkoI9JZd
         z7H9+ZDJIt37dQ/FMf31TAqwpYXLAEBgbpmmHfVX01Z9Q6kAvQEm9K5Mop7iTc9o2sPm
         S7jg==
X-Forwarded-Encrypted: i=1; AJvYcCXOVzPIETDFYWDE/hAJrDg13q5cxBIC7Hz5eSTcWZzJP711YzNWIDN2u1a9t4npd6zbO7UNaemkeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyazi8RX5Sp5njhqAGYM883riSHo/K/YcUYpbYPaymUBU2BcO+l
	UmF5l2k2SWJpJKo0EWdbvct8f2jRjdWcSXo5ZaJwRVCLpuBE6CAqvYKDETvCDIBU01Y=
X-Gm-Gg: ASbGncvXyXQtXPgo++zz9Oeow234Qkgk0LZqcdyZsPu0voOcls/uY8cmXp3rj2fnYEX
	WQqo/mJ1RLfaJjJUcc9GNsOH/AbkHJcPVNihmkgOKvnHSSeX3+TN2Vvn4k6q9bnnVUvbjqUZ5Ri
	/MDMwFDobktquy74Mqu4Cr1jedravCvmqQw1mHXS0F+O/Y0V7kJZX8tZNDGXgNwiL2zgR2X2gS5
	g6zQfS0fJ+taqK/7UKJY0rWn5mhnOvZEfuk18HCcQnnmxYxMjj1CRKvRWS7T7+EibYP0VqwpUwl
	qV6p26VM9BQwi4ONeKX+gUXhbrRqaYtqqT2z+b0ClqYUzLqf91gnHdKaqVkzDRQGUDLyPx/HjE5
	/4cLJQaz1JxzTHT/rn4TXCuOIxM7j1iPTN/6SNNGYKZyGNDVQyC1sJs5B+d3ooR5ervIqwbUB76
	aS
X-Google-Smtp-Source: AGHT+IG5CWuK3bxeWKGTfxUWBmU3PpIWhqsqihli0ujhkotua7F5B7/NQjWuR0nNhjVKL8K3C1GuDg==
X-Received: by 2002:a05:6a20:7348:b0:342:2a1b:870f with SMTP id adf61e73a8af0-3579b79a0demr2573811637.20.1762849992236;
        Tue, 11 Nov 2025 00:33:12 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9632e15sm14530544b3a.14.2025.11.11.00.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 00:33:11 -0800 (PST)
Date: Tue, 11 Nov 2025 14:03:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, vireshk@kernel.org, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: Queries on required-opps on calling dev_pm_opp_set_opp()
Message-ID: <kaxxdh2xt4hghwn23qzle5wx2ltdzq7eyp7rtyvbsgffjvowv6@hgphk72idpbz>
References: <8e542a9d-132d-45c3-b17f-1dcea4bdf337@oss.qualcomm.com>
 <7paqqdkxfxd3hz76o7o4q7pkmc27czqtn3smffpkwoha7bncdq@w7ik7v3c5uwk>
 <b3e9403e-6194-448d-a361-45c645a2ab2b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3e9403e-6194-448d-a361-45c645a2ab2b@oss.qualcomm.com>

On 10-11-25, 17:37, Krishna Chaitanya Chundru wrote:
> Something like this.
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 33574ad706b9..833057f55328 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2050,21 +2050,21 @@ pcie0_opp_table: opp-table {
>                                 /* GEN 1 x1 */
>                                 opp-2500000 {
>                                         opp-hz = /bits/ 64 <2500000>;
> -                                       required-opps =
> <&rpmhpd_opp_low_svs>;
> +                                       required-opps =
> <&rpmhpd_opp_low_svs>, <&pcie0_opp_rchng_clk_20_mhz>;
>                                         opp-peak-kBps = <250000 1>;
>                                 };
> 
>                                 /* GEN 2 x1 */
>                                 opp-5000000 {
>                                         opp-hz = /bits/ 64 <5000000>;
> -                                       required-opps =
> <&rpmhpd_opp_low_svs>;
> +                                       required-opps =
> <&rpmhpd_opp_low_svs>, <&pcie0_opp_rchng_clk_20_mhz>;
>                                         opp-peak-kBps = <500000 1>;
>                                 };
> 
>                                 /* GEN 3 x1 */
>                                 opp-8000000 {
>                                         opp-hz = /bits/ 64 <8000000>;
> -                                       required-opps = <&rpmhpd_opp_nom>;
> +                                       required-opps = <&rpmhpd_opp_nom>,
> <&pcie0_opp_rchng_clk_100_mhz>;
>                                         opp-peak-kBps = <984500 1>;
>                                 };
>                         };
> @@ -2106,7 +2106,30 @@ pcie0_phy: phy@1c06000 {
>                         assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
>                         assigned-clock-rates = <100000000>;
> 
> +                       operating-points-v2 = <&pcie0_phy_opp_table>;
> +
>                         status = "disabled";
> +
> +                       pcie0_phy_opp_table: opp-table {
> +                               compatible = "operating-points-v2";
> +
> +                               pcie0_opp_rchng_clk_20_mhz: opp1 {
> +                                       opp-hz = /bits/ 64 <0>,
> +                                                /bits/ 64 <0>,
> +                                                /bits/ 64 <0>,
> +                                                /bits/ 64 <20000000>,
> +                                                /bits/ 64 <0>;
> +                               };
> +
> +                               pcie0_opp_rchng_clk_100_mhz: opp2 {
> +                                       opp-hz = /bits/ 64 <0>,
> +                                                /bits/ 64 <0>,
> +                                                /bits/ 64 <0>,
> +                                                /bits/ 64 <100000000>,
> +                                                /bits/ 64 <0>;
> +                               };
> +                       };
> +
                 };
> At least for our use case, wee don't want to set it in the phy driver, we
> want the controller
> driver only to drive this.

Since you already have the phy node added as a clk in the controller node, can't
you add another opp-hz entry there and make this work ?

-- 
viresh

