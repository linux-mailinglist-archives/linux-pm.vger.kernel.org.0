Return-Path: <linux-pm+bounces-29876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49709AEF0D4
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 10:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC7F4A0539
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 08:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62D8264638;
	Tue,  1 Jul 2025 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPgII8Bp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF66D202995;
	Tue,  1 Jul 2025 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358063; cv=none; b=N/5uAvFO7XdVozACOIEIHP1m8fiQxkrTnoIzMvjyxPVQT8KYQufrrxp7gS7FAB5sauLNlD0kWLF/G3Gel2g1UMeUiA19mjSDG09DwrOhf+CWVLDTPCFmClDYqwYJ4U7358BvPJsgGwGCa5Wih+oW6OWjGVmGsLNprly0rNROeVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358063; c=relaxed/simple;
	bh=IKeZCcNNQbdeaNTVppkO6cUdRxq1Vqd2h///xUYe4Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVOeRyFYqtnNwu/I7GBDyUKj+PrglrYgV2ai5s/sVBPdt6a4+2Cj0kWZEraIxHPqubyFoCZGQNpmPjPQeZmfwS3qgpZpXayjGSrxxO7OolqBlQJpInSrf17M8QRFus3OBbWlOhxYW4y5pGiJjHkrB4EgcVjLGqYd/Un1oXwDJk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPgII8Bp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7D7C4CEEE;
	Tue,  1 Jul 2025 08:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751358063;
	bh=IKeZCcNNQbdeaNTVppkO6cUdRxq1Vqd2h///xUYe4Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XPgII8Bp2xOLTGJFW4oR2RScTDXxzOla0kh5UQCZWPcqXs4g8Mq4TvkEGuz1gyNb3
	 4yIZxBXluNgK/ZI1Y61dL9DGvwxiiNiEne95SYwtywSf49qza7R86NoMXxDE82KKB8
	 +BMDw6JqkvhohxYRLnb7Jd8zqgki7QGFOnFHyjqUsiIJDfe0AHUO1YkkrGMHwNEU64
	 V+v3k+vmEHGP4dDHGi1yIndszJqq12EQ1CIYTREdjxtQIrJvHg7CuPWUukFAXSQmcl
	 0a39IoVA31UeaxTKEShRW/ORjm+U6+Pg4oMDL6xlODTRsnL3vYQDaouC7u9TczXH9a
	 GBm50AC+6/yhQ==
Date: Tue, 1 Jul 2025 10:21:00 +0200
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
Subject: Re: [PATCH v2 1/8] dt-bindings: interconnect: Add Qualcomm IPQ5424
 NSSNOC IDs
Message-ID: <20250701-devious-pony-of-prowess-ff36c9@krzk-bin>
References: <20250627-qcom_ipq5424_nsscc-v2-0-8d392f65102a@quicinc.com>
 <20250627-qcom_ipq5424_nsscc-v2-1-8d392f65102a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250627-qcom_ipq5424_nsscc-v2-1-8d392f65102a@quicinc.com>

On Fri, Jun 27, 2025 at 08:09:17PM +0800, Luo Jie wrote:
> Add the NSSNOC master/slave ids for Qualcomm IPQ5424 network subsystem
> (NSS) hardware blocks. These will be used by the gcc-ipq5424 driver
> that provides the interconnect services by using the icc-clk framework.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  include/dt-bindings/interconnect/qcom,ipq5424.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


