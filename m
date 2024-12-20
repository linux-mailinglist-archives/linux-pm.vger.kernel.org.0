Return-Path: <linux-pm+bounces-19587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A259F98C3
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 18:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F6127A7122
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C26022CBEB;
	Fri, 20 Dec 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qOYpPnYM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491A086326
	for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715830; cv=none; b=BBs8xo8n4WqpWDElbP2AsiTyaJjCkBFbvCMxI2xqhSK+JrKneCexnPiiO59PK1sZaetrUoK3Ix4dqQE62YvtZOfz3uTGiKfAKTXIwn92YcgkyYrm4LV13BeS63Q9OdUQrseMlotiaiw0AFRPh71fX3ngDRwtZx4zZAXk0D9T4ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715830; c=relaxed/simple;
	bh=bAysmXT1ApL4MZsbGXlIGLiZFW3xoeOXskBVjon1K5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhsCQLi2tG5EerA5isEVNA6M5VCdwy805M8amxf2va4esMCPCJaRXyhXFt1OJjzd0HjBz2rIR4Cvx8Hzr/DfXS8/Lg0KF7rveaJRnLdoRhjbv2OjcnqJp+tSsIGYaqzZeGDSWqEtqDre1iQPGZPOdD2XSC38hXvhrc+7VM++JyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qOYpPnYM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so3619149a12.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 09:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734715825; x=1735320625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TJaoXje8uHao+uzoShrvm+9AXWvGP52yQ1oIubMZeDc=;
        b=qOYpPnYMBIYcyxPd/dIxvrxDZ2a+MjN5XDo9ufa+Nkc7m6jHNBWj4VZR2dzLQWal/p
         9/EH6SfJvK95in9YX8Z+C38MANHZh2l411ELOKdsHiv/qpFdkmB+/PnClqJALDJ6cokM
         fZ6eFVkQ8j6IgJawG7xaAvIgDhqzDXOX4reOGQYxR1v9xyyigS+cz9Owc9tq7pY8LvHJ
         Qhz05uFjy1ocgkMCpV5jqwH8ONYgaUwNmzbdEMX9tijYrq/WmToyfJOvYhyr3aj+1wa9
         7zkFgM2Ditewl7XtZchWqzJjJoYxtcxhR97PHaX/UX3IIkDdrqxHc959dPq0ekQV2STJ
         Pa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734715825; x=1735320625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJaoXje8uHao+uzoShrvm+9AXWvGP52yQ1oIubMZeDc=;
        b=TCk1083NJrbz3xHi1xce/YZmfCiYLBXDsaazILrAfG7+WWV/bIHLQkSJ0mXTeh2QCN
         mNT3hWUwFBmNn6+SsDcgBAmXntZ3D7wXWqXyvNyUdYkyEnThYDPJpFbRHH5jhAxj+mXG
         q8iX0KylDwTCi9lI2zWcNWiOloxZUApBgcHDwtG1wDQ/BN7kO5tubXmH6DWjE+anzinO
         omJ5ZA/FfXt7/7ry0iMzhK+vDij5TX6OpYRiTv8chucEfOyc76I7+SeZvPeSAfIGf0bS
         uk+PYqO5ZDu7CvzhUyT8LUeqO27x4RvM11kzSz2g6bkYXNiB1TIiXl3vhIjYTVrjh1Wk
         vLaA==
X-Forwarded-Encrypted: i=1; AJvYcCWPv5KGvKWngLKhi8FDK3Q5AVHWW3bPo2C/F6jbUjJ0bxkzo8ZGUlbmk/DE30WFg4CL1qE7wcL6Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVNB4UHPpkYv2GuiW/7mE0KB8CBBWChiIhEcI5l03K1crGfPE
	BzTKbbW7jgxV/UDaIbV8F/c8eabCTKDHMx7+oxbtrsHMXIW6uXJg9qf5bNe2GC4=
X-Gm-Gg: ASbGnctF9m8s6jeUUW1tJn09a7FojZFy7loWA1IAng5cKLdSPxT3OwU/qXahNM8jSvo
	t/Sg29rNp7sV5Y7q4eVACyWDEbik+gL4DOdMIDhlUsCnbP6f305Eg5MkSolqdUEHDezkvBvlnFZ
	otGlRvWzMAmSuopoqnKwDDIjXjFfLyVHjp2ifNoXrCcv7R6rLdLDMWcAOCh4P+OayH+WK0CGeam
	SVBBJG6QRXjqhLYv7PJ8l6H1UryPmO60K/IeK2ATelap7HZhtJdgeAcX5+0r66fG/cx
X-Google-Smtp-Source: AGHT+IH7+XcVUt5iV5cF3xg1wrooGDBJq1k5sc95u227IWRCzMGea6RcPb0ttVzenGGImX0jMdU8ww==
X-Received: by 2002:a05:6402:35c7:b0:5d4:34a5:e317 with SMTP id 4fb4d7f45d1cf-5d81de1611dmr3897302a12.22.1734715825516;
        Fri, 20 Dec 2024 09:30:25 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef80:6d2c:6f87:64ef:2237])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a3d2sm1928475a12.16.2024.12.20.09.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:30:25 -0800 (PST)
Date: Fri, 20 Dec 2024 18:30:22 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: =?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org, iommu@lists.linux.dev,
	Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v10 3/5] arm64: dts: qcom: Add initial support for MSM8917
Message-ID: <Z2WprlxV4wop0jxB@linaro.org>
References: <20241220-msm8917-v10-0-3d5734e8c3a6@mainlining.org>
 <20241220-msm8917-v10-3-3d5734e8c3a6@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220-msm8917-v10-3-3d5734e8c3a6@mainlining.org>

On Fri, Dec 20, 2024 at 12:26:55PM +0100, Barnabás Czémán wrote:
> From: Otto Pflüger <otto.pflueger@abscue.de>
> 
> Add initial support for MSM8917 SoC.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> [reword commit, rebase, fix schema errors]
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8917.dtsi | 1954 +++++++++++++++++++++++++++++++++
>  1 file changed, 1954 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8917.dtsi b/arch/arm64/boot/dts/qcom/msm8917.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..7bd6925029eeb9d6d49a99f8686181e926258cab
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8917.dtsi
> @@ -0,0 +1,1954 @@
> [...]
> +		a53pll: clock@b016000 {
> +			compatible = "qcom,msm8939-a53pll";
> +			reg = <0x0b016000 0x40>;
> +			clocks = <&xo_board>;
> +			clock-names = "xo";
> +			#clock-cells = <0>;
> +			operating-points-v2 = <&pll_opp_table>;
> +
> +			pll_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-960000000 {
> +					opp-hz = /bits/ 64 <960000000>;
> +				};
> +
> +				opp-1094400000 {
> +					opp-hz = /bits/ 64 <1094400000>;
> +				};
> +
> +				opp-1248000000 {
> +					opp-hz = /bits/ 64 <1248000000>;
> +				};
> +
> +				opp-1401600000 {
> +				      opp-hz = /bits/ 64 <1401600000>;

Nitpick: indentation is off here.

Anyway, this looks really nice overall now. Thanks for doing all the
cleanup! FWIW:

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Thanks,
Stephan

