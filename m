Return-Path: <linux-pm+bounces-33382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF3CB3B47C
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 09:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C029188FF74
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 07:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8F1275AFB;
	Fri, 29 Aug 2025 07:38:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109422A4D5;
	Fri, 29 Aug 2025 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453085; cv=none; b=hdfaBnPnFoVLIzB9kVHDNiHSUB0Lk6mehScMBTBejHwIGalPT+nkpziEnkf6IiTNUm/tGkv7KAcPUfYLYrMRgBc74+1QgoMihOO/DRADGktpmPV94xm2OPu2kZ2nN7o8k8RGvpgrBkwJm2ub5coXy2Ez3w/sfaK3e7nB2gnoYYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453085; c=relaxed/simple;
	bh=Tl11kOoBn9+Z8c4phzkCXnlIR9PQSdgakpVZpWjZPB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txRTni1onmod4xKWrNnOo2/cJvILLJt1E0pPLUpun37vtljwNwpQ+VMPX/Zpbb7BSO/4jNNKeM3oK5gr9ATJmHJLYwRc46+UTH5V3BLbkZP+JkuYwMaOgRX0w+6ithl7e0CVJ/ZqRHWGKrPM91kFeCjO3A8tFpp5RIvxvV6YPak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B299C4CEF0;
	Fri, 29 Aug 2025 07:38:04 +0000 (UTC)
Date: Fri, 29 Aug 2025 09:38:02 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Varadarajan Narayanan <quic_varada@quicinc.com>, Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Anusha Rao <quic_anusha@quicinc.com>, Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, 
	Devi Priya <quic_devipriy@quicinc.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Richard Cochran <richardcochran@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com, quic_leiwei@quicinc.com, 
	quic_pavir@quicinc.com, quic_suruchia@quicinc.com
Subject: Re: [PATCH v4 07/10] dt-bindings: clock: qcom: Add NSS clock
 controller for IPQ5424 SoC
Message-ID: <20250829-quick-green-pigeon-a15507@kuoka>
References: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
 <20250828-qcom_ipq5424_nsscc-v4-7-cb913b205bcb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828-qcom_ipq5424_nsscc-v4-7-cb913b205bcb@quicinc.com>

On Thu, Aug 28, 2025 at 06:32:20PM +0800, Luo Jie wrote:
> NSS clock controller provides the clocks and resets to the networking
> blocks such as PPE (Packet Process Engine) and UNIPHY (PCS) on IPQ5424
> devices.
> 
> Add support for the compatible string "qcom,ipq5424-nsscc" based on the
> existing IPQ9574 NSS clock controller Device Tree binding. Additionally,
> update the clock names for PPE and NSS for newer SoC additions like
> IPQ5424 to use generic and reusable identifiers "nss" and "ppe" without
> the clock rate suffix.
> 
> Also add master/slave ids for IPQ5424 networking interfaces, which is
> used by nss-ipq5424 driver for providing interconnect services using
> icc-clk framework.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../bindings/clock/qcom,ipq9574-nsscc.yaml         | 62 ++++++++++++++++++---
>  include/dt-bindings/clock/qcom,ipq5424-nsscc.h     | 65 ++++++++++++++++++++++
>  include/dt-bindings/interconnect/qcom,ipq5424.h    | 13 +++++
>  include/dt-bindings/reset/qcom,ipq5424-nsscc.h     | 46 +++++++++++++++
>  4 files changed, 178 insertions(+), 8 deletions(-)


Are you going to change the binding in next version?

Best regards,
Krzysztof


