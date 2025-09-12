Return-Path: <linux-pm+bounces-34524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 995BEB5436D
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 09:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD111B27A5E
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 07:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C25296BDC;
	Fri, 12 Sep 2025 07:04:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932A5136347;
	Fri, 12 Sep 2025 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757660670; cv=none; b=K3BefdLuL4OPR2K+uQ6ByK7WPvDW4t+KpdvLD7qXKrFJPABMvb1P/7eRljNf0sy/RwmvtzdeibQ9CMY0fYYk5fVwKtwjlZAMJGccGW6iFBc5AKg9I26raKWQqlHxJvMxyJXnaQzS+cB7CSmRXky0cn2L8agtSIvhcxdw28IWmj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757660670; c=relaxed/simple;
	bh=4WRSRiY2vrLVB4/i8o5RgqvNQK2OOzdq9znWjEzV7cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3tCskAnJ2yzQoPRGWJEyB8/OOa/n0zxhY6QVibMLZ5xBrjrM9Y1M+wYrHVL/ZWjZp+i4ZNc3MHVLuTc42WRsQMJbQCuAk7w1QihDx+RTMu+7D1DKNw4x+e97JYPmPYurW2JnIi/ce8Cz/ssISuB6lRhfdzaivpECzwho0dmMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DD8C4CEF4;
	Fri, 12 Sep 2025 07:04:29 +0000 (UTC)
Date: Fri, 12 Sep 2025 09:04:27 +0200
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
Subject: Re: [PATCH v5 02/10] dt-bindings: clock: Add required
 "interconnect-cells" property
Message-ID: <20250912-nocturnal-horse-of-acumen-5b2cbd@kuoka>
References: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
 <20250909-qcom_ipq5424_nsscc-v5-2-332c49a8512b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909-qcom_ipq5424_nsscc-v5-2-332c49a8512b@quicinc.com>

On Tue, Sep 09, 2025 at 09:39:11PM +0800, Luo Jie wrote:
> The Networking Subsystem (NSS) clock controller acts as both a clock
> provider and an interconnect provider. The #interconnect-cells property
> is mandatory in the Device Tree Source (DTS) to ensure that client
> drivers, such as the PPE driver, can correctly acquire ICC clocks from
> the NSS ICC provider.
> 
> Although this property is already present in the NSS CC node of the DTS
> for CMN PLL for IPQ9574 SoC which is currently supported, it was previously
> omitted from the list of required properties in the bindings documentation.
> Adding this as a required property is not expected to break the ABI for
> currently supported SoC.
> 
> Marking #interconnect-cells as required to comply with Device Tree (DT)
> binding requirements for interconnect providers.

DT bindings do not require interconnect-cells, so that's not a correct
reason. Drop them from required properties.

Best regards,
Krzysztof


