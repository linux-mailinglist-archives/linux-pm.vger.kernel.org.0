Return-Path: <linux-pm+bounces-35657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD58BB23E0
	for <lists+linux-pm@lfdr.de>; Thu, 02 Oct 2025 03:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15359380F68
	for <lists+linux-pm@lfdr.de>; Thu,  2 Oct 2025 01:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C64537E9;
	Thu,  2 Oct 2025 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DseHaLYH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8E632;
	Thu,  2 Oct 2025 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367828; cv=none; b=OTK8A4IBb+4PUddFMA7XtPgimT2tV98qp5zvlFdjRfLSTpZAWjOvekjgdasjfN9x7mecCsvL083Vr8SbVOl5CD8Fe0ll97Y+y6OcKJnNhQfe8UL7em3hLtxWFik7zxZHHX20c45Wf2QS1YpJ1IJQohizVwXj1iz2rz7rd8PCZ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367828; c=relaxed/simple;
	bh=gLZ0UVkrnFaQO1QfoYUGLipP+gZyboeSBBk2VODCAP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2aJ/GJL3SDSqk6vjX+hnx6uBx1O2EhTMxnpBWZ0vb0wtlZVknd4G02AptIrxTznW93F2HXqilSTh9l6MMYTD35Z0G6RSPHR0ygyGf9Fp2T2cmULhHn9UxnOGmwm/hH4+apxvUn12nGC1uxTISVAmep6Kgm84Ps/QQBpyjknGKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DseHaLYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6EBC4CEF1;
	Thu,  2 Oct 2025 01:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759367828;
	bh=gLZ0UVkrnFaQO1QfoYUGLipP+gZyboeSBBk2VODCAP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DseHaLYH2yUpGOrx81GhPcx0UAZnaLZmx4VuQe2mu2jOT3iTKKkQy8puQ37eWnoi5
	 /uW2mqqqdZy7bzJf5f/WKb11BpQtboA7RyFytgh4rHYi/9/NUXyM6YbN+8mv5Nwyc4
	 ga9bhjsLT9eYYQbms4xbran4+MiKEx6Zcr7nw5RFNQVT78zXIm9gAGkQ/t1UKdgHie
	 OBrqNbUPFeVICGKa8obkGsJlPoqwK3G9CryXT8LCxCsDrgTWQyyx93mnKQXsE3cDr2
	 OGwtzExjmMFtmSBEtXqKhcbbhNK9ezP7xFdUynjppFqM/jjcBvY5x0tVSkxAvNoOAW
	 H2MLy4zXh2kZA==
Date: Wed, 1 Oct 2025 20:17:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: linux-pm@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Devi Priya <quic_devipriy@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	quic_kkumarcs@quicinc.com, quic_leiwei@quicinc.com,
	Conor Dooley <conor+dt@kernel.org>, quic_suruchia@quicinc.com,
	quic_linchen@quicinc.com, Anusha Rao <quic_anusha@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>, quic_pavir@quicinc.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v6 03/10] dt-bindings: interconnect: Add Qualcomm IPQ5424
 NSSNOC IDs
Message-ID: <175936782597.2832511.10991854182415010050.robh@kernel.org>
References: <20250925-qcom_ipq5424_nsscc-v6-0-7fad69b14358@quicinc.com>
 <20250925-qcom_ipq5424_nsscc-v6-3-7fad69b14358@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-qcom_ipq5424_nsscc-v6-3-7fad69b14358@quicinc.com>


On Thu, 25 Sep 2025 22:05:37 +0800, Luo Jie wrote:
> Add the NSSNOC master/slave ids for Qualcomm IPQ5424 network subsystem
> (NSS) hardware blocks. These will be used by the gcc-ipq5424 driver
> that provides the interconnect services by using the icc-clk framework.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  include/dt-bindings/interconnect/qcom,ipq5424.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


