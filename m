Return-Path: <linux-pm+bounces-35659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B5EBB24ED
	for <lists+linux-pm@lfdr.de>; Thu, 02 Oct 2025 03:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44473323BCC
	for <lists+linux-pm@lfdr.de>; Thu,  2 Oct 2025 01:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4421465B4;
	Thu,  2 Oct 2025 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXH0mmx7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E153C33;
	Thu,  2 Oct 2025 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370286; cv=none; b=WQU5RLXVvUKR5YTDQiuxOXo5C6sp3x9XCPQi3pfya6cPJQr+4+IMdbiwGYlAkKW0AHSnwDX/DJrIk8HYVHOUOatOSAZgbPrduw8wXh/7maROs5irD2fbGvgm++QyCWsn1YEblPT4+vrCQpRPlAfJLCBazlTadCzcWpKnKRNoz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370286; c=relaxed/simple;
	bh=orYqUHOQq/dpMoz7wQGqiTQeBrJ2oIsx48bUQSmWSBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To0Qr6BQHIhR5prPthaZzLLOsTIT0f5X06MCrxJe9CBKfMghcd9beeI7wC4galP+UdXFRg0RXdX9Be5237WfEVaQ4X6RLGzXu3YC7olEATyxqUYZJ0Q+uvcEE5QZc7/kLpAFe255BDyxMEqhmcIbiLYdSgD9s7D1bSZQNSa9/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXH0mmx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC9AC4CEF1;
	Thu,  2 Oct 2025 01:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759370286;
	bh=orYqUHOQq/dpMoz7wQGqiTQeBrJ2oIsx48bUQSmWSBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXH0mmx7e8nHvxI/qVehiqeM+sCtXqeCHqV5z0GIs+Af6FI72ETpHjVvNt8/0ox4p
	 txWYoxq+DoTQck5Wk0DW1V23FA3Qxk+cJKMAd+ukRrcuym3MaxGdWkPDo37iVTcOhZ
	 jRFlgLzNj/rnfJmF19APgCuYW6wizBTTf1aJyfD/WFgo8LCBgkM5w7F7l1HnsH/i4L
	 fOwicxTy9LKANRsxR03TIaeNzfJC/Xz+JcJhlRAscsA3tp0ef/bqQg5s2FzDrNREzd
	 hd5HjR8wUmUC/eb5+tsTKVh0oMojmYMc9F8SeeDF4D4XtvNSIfmyQj4VJeBP4XDLF2
	 ELHqVxDSR+H2w==
Date: Wed, 1 Oct 2025 20:58:04 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rohit Agarwal <quic_rohiagar@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Lakshmi Sowjanya D <quic_laksd@quicinc.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: interconnect: qcom: Drop QPIC_CORE
 IDs
Message-ID: <175937028401.2886916.12818454708377622301.robh@kernel.org>
References: <20250926-sdx75-icc-v2-0-20d6820e455c@oss.qualcomm.com>
 <20250926-sdx75-icc-v2-2-20d6820e455c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-sdx75-icc-v2-2-20d6820e455c@oss.qualcomm.com>


On Fri, 26 Sep 2025 12:12:10 +0530, Manivannan Sadhasivam wrote:
> From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> 
> As like other SDX targets, SDX75 QPIC BCM resource is also modeled as a
> RPMh clock in clk-rpmh driver. However, for SDX75, this resource was also
> described as an interconnect node mistakenly.
> 
> Hence, drop the QPIC interconnect IDs and let the clients use clk-rpmh
> driver to vote for this resource.
> 
> Even though this change is an ABI break, it is necessary to avoid
> describing the same resource provider in two different drivers, as it may
> lead to votes from clients overriding each other.
> 
> Fixes: 956329ec7c5e ("dt-bindings: interconnect: Add compatibles for SDX75")
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> [mani: kept the QUP defines value unchanged]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  include/dt-bindings/interconnect/qcom,sdx75.h | 2 --
>  1 file changed, 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


