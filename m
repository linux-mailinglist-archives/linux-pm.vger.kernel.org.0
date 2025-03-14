Return-Path: <linux-pm+bounces-24073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12613A621A4
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 00:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1570519C5DDD
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 23:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1875E1F3D54;
	Fri, 14 Mar 2025 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2zKYerC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFF11DEFE0;
	Fri, 14 Mar 2025 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741994786; cv=none; b=BC8sJiOKbdEw7ihUQp1n2mShAfifSyTMR7+JLf4YUb+9Zqyrpqqlhtg9b4yMRFJs4+PWFquN2Ix6wL4B0rpDh53ivaI0YKofII6HyANsfF0HBA1o3Nuzc8MwCmFIRHmqGgY40Bbs785QCXbMRbLyyQf2sxeN7y7WdYDgoXBkshQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741994786; c=relaxed/simple;
	bh=zjoBcoFyZYXU5qzW0B7RB/JsSKB2MZ6eRjO0KfsLAB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ukt3ls+EIAxjR6R5bdD5W6z/ALPGqmuNnjqCNMv27B05LsMNFUhOT8byszZdhUCigYpOhX81xxSArucuvlTFs0KSpyUYc7ZbgHSa6klwzGjvvfY0ZMqrYt/IFxoASIzkhq8++8qzm2oaIrYv+2A/5ELYqZXA9oG4R8CYk6NxD/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2zKYerC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2197FC4CEE3;
	Fri, 14 Mar 2025 23:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741994785;
	bh=zjoBcoFyZYXU5qzW0B7RB/JsSKB2MZ6eRjO0KfsLAB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2zKYerCkTgFBGdixjZ5CVrQt/CEerwLVaOM+6LM0SCkK4dwWwkwxuPfPGAcjnSEs
	 ZZJv842FNtCsHwvVgrZAyVxvgMFN03hmLEfFKZckCTwgIX0ktY5+WG2sW7sD6JJ2XE
	 atDfSkG8ShI1H8epztvzIXSjiCHEkWx/Wdy+0JB9M3c5zPRQqi5/PIWrqiPQA22tmb
	 enY8zA6WDsHtTNVF4Fb9i9R8dY+EC38LsqkvnoZOTGeNVEDcCn0MtPL3HNCmw2zN0E
	 M1JnpJSPseHipXORlNtSG9XSjk4/j0zd1OPdjTZkCUZ0ZrbB1tt1zK9lBrOVTBGiKr
	 XxnIVIVHmqCjA==
Date: Fri, 14 Mar 2025 18:26:23 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing
 constraint for interrupt-names
Message-ID: <174199478353.2517830.8352245592008583592.robh@kernel.org>
References: <20250313-dt-bindings-cpufreq-qcom-epss-v1-0-62b0f96ba888@linaro.org>
 <20250313-dt-bindings-cpufreq-qcom-epss-v1-1-62b0f96ba888@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-dt-bindings-cpufreq-qcom-epss-v1-1-62b0f96ba888@linaro.org>


On Thu, 13 Mar 2025 10:08:20 +0100, Krzysztof Kozlowski wrote:
> When narrowing properties per variant, the 'interrupt-names' should have
> the same constraints as 'interrupts'.  Add missing upper bound on the
> property.
> 
> Fixes: e69003202434 ("dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCM2290")
> Fixes: 7ae24e054f75 ("dt-bindings: cpufreq: cpufreq-qcom-hw: Sanitize data per compatible")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


