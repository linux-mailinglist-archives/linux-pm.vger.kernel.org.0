Return-Path: <linux-pm+bounces-24075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE46A621AF
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 00:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 807057AB0CF
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 23:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC83D1F4163;
	Fri, 14 Mar 2025 23:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDCsQ6k/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6481F3D54;
	Fri, 14 Mar 2025 23:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741994930; cv=none; b=b6HJfx9KZoY3y54xhVmMulmrX0PzzWdvR15kpo0Nk772VhUSNEMIJgx5NLm0cbNLYfdhNdb1gZNFX2f2cUZLyy9m8jRihr4Ahy0q9KvTmREQ8MN+JzV7vwaJhLYqJ/B1JmF5zcOynAOS6Yo4DVadok+2cYXTAhmqW6ZdIJ8tX8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741994930; c=relaxed/simple;
	bh=e7qziMucS5vlpLPiMW4SqHYTIFGh75myzpsM6kVrJRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvKyiv1vtYzb7J2Bpi5kXMkTpzy7bH+FAX8kd15HSOqCOaWkCAG2pSV0uIFI/Qx9lJdAghgz8rivi2bbLyViIuFwAdlBd8f+Wkg5VLafYTO1C8EQPZKC/Lfdeb5zaoqPhsTEb+5PSxsgmNZLog1+LlTLVQkhqH845nDOIkFEm4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDCsQ6k/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E9FC4CEE3;
	Fri, 14 Mar 2025 23:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741994930;
	bh=e7qziMucS5vlpLPiMW4SqHYTIFGh75myzpsM6kVrJRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDCsQ6k/3vfCL0lu574QRvGXGvI/r/rSCSjjawd+SWwp4AlfX/ScGvWlbjT4qeilK
	 dGgZm9ictpfcqB12Ot1HjtilGgVZt/iJStgKunZfPFnHGrfVar5vMxVomvA4W5TO/s
	 mrGsl2V0FIoYWqGkmntgmF0zomXwBQ+yaqsTxJjX6KnWoEgFUIsKvU1fgn5loFzdCu
	 B53/o1cS6/rgn9t4dkUzTanWm/C5NdPTC6kaOZTs6eQtAXe7KPfTwlEW6xckYwS6nr
	 GFxShxuunh4+EdzXQBeKQL4raUP3zffAxBLsFUo2pGOIOf7cfKq/Sz5HDas0zUc3Rr
	 U72e/IGKa9HUg==
Date: Fri, 14 Mar 2025 18:28:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Narrow
 properties on SDX75, SA8775p and SM8650
Message-ID: <174199492734.2520690.17228936351174695421.robh@kernel.org>
References: <20250313-dt-bindings-cpufreq-qcom-epss-v1-0-62b0f96ba888@linaro.org>
 <20250313-dt-bindings-cpufreq-qcom-epss-v1-3-62b0f96ba888@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-dt-bindings-cpufreq-qcom-epss-v1-3-62b0f96ba888@linaro.org>


On Thu, 13 Mar 2025 10:08:22 +0100, Krzysztof Kozlowski wrote:
> Add SDX75 and SA8775p compatibles to respective if:then: blocks to
> narrow their properties and add a new section for SM8650 with four 'reg'
> and 'interrupts' (top-level already allows four).
> 
> SA8755p DTS comes without interrupts, but only because they might not
> be available for OS under given firmware.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


