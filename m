Return-Path: <linux-pm+bounces-31932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B02B1AE0D
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 08:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404251898737
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 06:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE66214814;
	Tue,  5 Aug 2025 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJ/4Ru0T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6503A175A5;
	Tue,  5 Aug 2025 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754374585; cv=none; b=pQPiiCLR9D21dTictJzGPHkaFgx16M0XxxO8Licwr/ceW3vRIHZYGjTjT38JU9DYPwyJTMzooSYZHlqk3bWqqV/vh6tp/wVC7AVWP4PjajElKWWsK+jIoZM2RlO4yy3XDgZj3l3HA9i4LbC5bDoBoERC8rvryVjC4XESD/xN5os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754374585; c=relaxed/simple;
	bh=E4DnAqs5juCZtQM1q8zq4eWD0Gdeu/dFvmY6c1wEMxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2dDtkqdQUsH1scyGxxvtxzxUPoWrfkqJTY6gGGoAwt6SuIHKVQL1dZsgjZUE/fJZE7MEegxu4pK+8vw2vMJ+8f+A1FhaJt/bPOcDJcbJilyg0l0ChisCPuHoTkzDxebnQXgZ1uxTFqupFtrsHmlEFXAzo3ihfQiOZmHRdkJ7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJ/4Ru0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E23C4CEF4;
	Tue,  5 Aug 2025 06:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754374584;
	bh=E4DnAqs5juCZtQM1q8zq4eWD0Gdeu/dFvmY6c1wEMxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJ/4Ru0TvNSs/1mdSeiR+23gvRUnlX2FrhHXehiRQlAHgboxcESB4VPRLlD+hfkq1
	 UJcqlHcJOCH4rAS3wcL4pWVXA+bcKHT0NzKlNhXNy/bYAgPDG5zZpBDfHBnRanoNPP
	 LIdpgx7xzCqXUIuv6c+Y5g7MjNUso/aENwVC37dtoovy4iASKhwtbHMZLVq+jMsr2U
	 vB5elp+HLmLu0SHb9PAewt7pTwBuJMoY5NjEZC6lMmNdXQM/JkP09J6JYWh/n1QbXf
	 N8XoCbeud6ic6fpBI+xNCfLCfjJeE5tCkwnduo4CG11lZgPs9+MBRs6ogzA3ESiWFg
	 YTNQmGGc9j1Kw==
Date: Tue, 5 Aug 2025 08:16:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org, 
	rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org, djakov@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Sricharan Ramabadhran <quic_srichara@quicinc.com>, Md Sadre Alam <quic_mdalam@quicinc.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: clock: ipq5424-apss-clk: Add ipq5424
 apss clock controller
Message-ID: <20250805-polite-prawn-from-heaven-bccc9b@kuoka>
References: <20250804112041.845135-1-quic_varada@quicinc.com>
 <20250804112041.845135-2-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804112041.845135-2-quic_varada@quicinc.com>

On Mon, Aug 04, 2025 at 04:50:38PM +0530, Varadarajan Narayanan wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
> The RCG and PLL have a separate register space from the GCC.
> Also the L3 cache has a separate pll and needs to be scaled along
> with the CPU.
> 
> Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> [ Added interconnect related changes ]
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


