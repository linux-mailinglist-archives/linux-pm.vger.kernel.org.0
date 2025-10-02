Return-Path: <linux-pm+bounces-35658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAD1BB23F6
	for <lists+linux-pm@lfdr.de>; Thu, 02 Oct 2025 03:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F38D380F4A
	for <lists+linux-pm@lfdr.de>; Thu,  2 Oct 2025 01:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CC27262A;
	Thu,  2 Oct 2025 01:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peaJHVZG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4C735958;
	Thu,  2 Oct 2025 01:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367859; cv=none; b=Ommfs4l5Pv9Nh6ZQglU4x9oiKbDmUxWPQC9A67NGdPWRUYr7W+87DoARe4pHFf3l2PHRjeWnFYeUZkE6Hds4rE9B29T5+GPh8xx3Z4jwCiDXvON394Ug+BfGifUDHQg9fsFkwRJidz457qRlxM7ikippDmhwAIAUT3oEMaNJnE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367859; c=relaxed/simple;
	bh=bqYRt5rCkxHQimYlJJh1kdOrE6Xw7RcJ54X+qmXzIxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrVAF3L675QeuGpKvNtT+k/xZXEgWMML5c9mUaY+H16lqEYtp7gwcxyGNIpBpJerjtwz3epfO9Vas5beFz61+aCsVDwM2JpXRSrckL+95BDYTDkC8fxp5UwXL/vEwNzKURbcOEoBznRpHj9E/3m03XMYp6zOM94i86ZKOOi7uO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peaJHVZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9326C4CEF1;
	Thu,  2 Oct 2025 01:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759367859;
	bh=bqYRt5rCkxHQimYlJJh1kdOrE6Xw7RcJ54X+qmXzIxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peaJHVZG4GrFd29dDXIyJzGX58yR1Gqb9/p1wNcxArhxo+ggnT/Wdzai5cn0qBHia
	 UpXlb4dX5OnyK54x8/QHRbESVonDF72uY/DySMvZJpt5u2eL7DzK1zR0kEeZUlsP5r
	 1eKM+FfZ9IYAud9nkGmTpaliwnERwLFvQWgfn1otrUlAT2WRXcoYAd1S/FIJ5TPcdQ
	 +4xEsLIRca9wKX7UIMsGxiG6I/6jCEmEimTksjrfxECSJIwcsYeu6JySuvHjwhEOHT
	 0ZT0xyXrqrowUZB4GF/UTMDIfbopYuEXnS0bq+x28gxzFqdKOtZdmpP313LXbm1SRX
	 LCUYWgaZZY6jQ==
Date: Wed, 1 Oct 2025 20:17:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Will Deacon <will@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, quic_leiwei@quicinc.com,
	quic_suruchia@quicinc.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, quic_pavir@quicinc.com,
	netdev@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Anusha Rao <quic_anusha@quicinc.com>, quic_linchen@quicinc.com,
	Bjorn Andersson <andersson@kernel.org>, linux-clk@vger.kernel.org,
	Devi Priya <quic_devipriy@quicinc.com>, quic_kkumarcs@quicinc.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v6 05/10] dt-bindings: clock: gcc-ipq5424: Add definition
 for GPLL0_OUT_AUX
Message-ID: <175936785706.2833327.15374958134771066830.robh@kernel.org>
References: <20250925-qcom_ipq5424_nsscc-v6-0-7fad69b14358@quicinc.com>
 <20250925-qcom_ipq5424_nsscc-v6-5-7fad69b14358@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-qcom_ipq5424_nsscc-v6-5-7fad69b14358@quicinc.com>


On Thu, 25 Sep 2025 22:05:39 +0800, Luo Jie wrote:
> The GCC clock GPLL0_OUT_AUX is one of source clocks for IPQ5424 NSS clock
> controller.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  include/dt-bindings/clock/qcom,ipq5424-gcc.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


