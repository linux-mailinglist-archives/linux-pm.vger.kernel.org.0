Return-Path: <linux-pm+bounces-24074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E946A621A6
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 00:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B0A7AAA2A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 23:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C7E1F3D54;
	Fri, 14 Mar 2025 23:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHhLJ679"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5417BA1;
	Fri, 14 Mar 2025 23:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741994818; cv=none; b=WuZO1pMxRIDQ4jFw1Tqv2fyHKBBF3tZ8+TS1bdM8hLivlO/32RAuR0onsncwXOhxvIzrFn9pW6THLH8niubibUKGI39yRRgNxNOZaVR783/tBfgZAslww6LbbNNBfpyymXYqhmcc5jUG+8CvkYUnRFask8ysuLTKaA3PizxrDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741994818; c=relaxed/simple;
	bh=91gDf0RqfLxoR2JJpYBOn5Wr8zw4DyLamP+LfxYT+/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/wKVTWU4KvTthbLrHeJqLRBZw2e5OgNzC/GqDcZKwJaNwLeW7PAQZ0Aorw8zZGSwqSeBueuP26HzFZU4sIEtGPN4nYhYWUjgMMh4xiXM9bbS7NLdnhL7mrWYYsSCruk+gfcXuX4LicBRXokSH1QfuLmcSstJ5IkpJ3ZLyd8EtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHhLJ679; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4539C4CEE3;
	Fri, 14 Mar 2025 23:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741994818;
	bh=91gDf0RqfLxoR2JJpYBOn5Wr8zw4DyLamP+LfxYT+/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DHhLJ6795iP75525MdQ0MFGNqJ8Npi9I6iZFfI/gFpqHppRsLvDb/Us4+y0QgtdBA
	 MCWuR3Xj47XnH0OB9LnVJytCz8961B+vjCsrL3TITWGhL4QbMhkRhF3UFwEAH+BpO3
	 BBqbmz0cRfaxh9w50KVU8VTVuQWbWPjU+9M0MbYDMVD9mMIA8US+RGVqdt5P/dCphO
	 KJuNsKdjgjX5Tx10+IARKnFHg+HcD4n+q4fNAKOBZOx9gBXWTgKnObMwUjukcBrmko
	 C+FOXHrzBg6OahfxiR5fBsukA+mVejp9w11doZSUuhD9S9hm9NHAmVqgFmY/5nBo/3
	 UImWyYdpAC0MQ==
Date: Fri, 14 Mar 2025 18:26:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Drop
 redundant minItems:1
Message-ID: <174199481633.2518571.4189253141018900957.robh@kernel.org>
References: <20250313-dt-bindings-cpufreq-qcom-epss-v1-0-62b0f96ba888@linaro.org>
 <20250313-dt-bindings-cpufreq-qcom-epss-v1-2-62b0f96ba888@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-dt-bindings-cpufreq-qcom-epss-v1-2-62b0f96ba888@linaro.org>


On Thu, 13 Mar 2025 10:08:21 +0100, Krzysztof Kozlowski wrote:
> List cannot have 0 items, so 'minItems: 1' in each if:then: is
> redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 4 ----
>  1 file changed, 4 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


