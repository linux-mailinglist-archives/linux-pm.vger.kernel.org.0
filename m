Return-Path: <linux-pm+bounces-29879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FB0AEF0F7
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 10:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA48166F2A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 08:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB33926A0B3;
	Tue,  1 Jul 2025 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtwZOxjL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB824503F;
	Tue,  1 Jul 2025 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358251; cv=none; b=ra7F2iVfaJ6N3plL4NlIIVNYJWqCAY2+SmocgkuftIGDYylEd8rOmRwjowTr+lQnsF1hC4HvPz6G/NuLW9GWpxT71087lBPXpqzBxx99rTaAxRGnWQAWwRYyLwLGOIFQXAqKr6Mp2Nn6AtS0Xq8XHtVDGktLJTFlVxEBCFu4blg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358251; c=relaxed/simple;
	bh=R2mIkacQGW2O2sU10/Kr7qil4EtR9Jqg+Wkl3QVALp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A48iJsZnaZR35Dxf7OQaREb3ake2xSK8WEbi8PWSrSBMhXTaiyaWKvXT/jHnnf/ZEYidE1yYrjGdJB19LMPkCjXpbRb2FTqsp+E6LAFjDBZnVh+gCekX9tRMHTnxC1mLnr5mihKdJVcEUqxYdLGupjzGF+s7n3CZa5btnUkpmqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtwZOxjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A01C4CEEB;
	Tue,  1 Jul 2025 08:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751358250;
	bh=R2mIkacQGW2O2sU10/Kr7qil4EtR9Jqg+Wkl3QVALp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZtwZOxjLbIKJVbGF5ex09ZhO8xeq+x1L/RpREDlu6zXAh4ZwfBKTwdkIzMgbW8Vry
	 FPeuit6qCx+iMWnzoHTmrFoWA7H9pI1QGGmL1N25gtdAXBFcYXz8SRvg9bhf4y47Nv
	 2mW6IF4eGEmfn7vgHLkal4YEEWwHSNJWM+pu7HaibXl5GqzfeoBopBw7SxoBGFLbYt
	 aqkfBKlTvhOFIH9MFj08OfQYaViDkx6oYa/O2nrj0AjeLspscEOrje0Njb4lPgKt46
	 +MWEDQEqhupgdvKj00CsBPqGZaWHRVHuYA/69m4ZRC6zwgl/ZHqJnznR1/77gNApHb
	 ishLTHoy+nwoQ==
Date: Tue, 1 Jul 2025 10:24:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Georgi Djakov <djakov@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Richard Cochran <richardcochran@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Anusha Rao <quic_anusha@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com, 
	quic_linchen@quicinc.com, quic_leiwei@quicinc.com, quic_suruchia@quicinc.com, 
	quic_pavir@quicinc.com
Subject: Re: [PATCH v2 8/8] arm64: defconfig: Build NSS clock controller
 driver for IPQ5424
Message-ID: <20250701-divergent-cream-okapi-83181d@krzk-bin>
References: <20250627-qcom_ipq5424_nsscc-v2-0-8d392f65102a@quicinc.com>
 <20250627-qcom_ipq5424_nsscc-v2-8-8d392f65102a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250627-qcom_ipq5424_nsscc-v2-8-8d392f65102a@quicinc.com>

On Fri, Jun 27, 2025 at 08:09:24PM +0800, Luo Jie wrote:
> NSS clock controller is needed for supplying clocks and resets to the
> networking blocks for the Ethernet functions on the IPQ5424 platforms.
> 
> All boards based on the IPQ5424 SoC will require this driver to be enabled.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


