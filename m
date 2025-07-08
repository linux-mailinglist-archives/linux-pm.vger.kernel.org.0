Return-Path: <linux-pm+bounces-30349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A27AFC622
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 10:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994B13ACA06
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 08:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB332BE7BB;
	Tue,  8 Jul 2025 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyjkQPOt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08F221D87;
	Tue,  8 Jul 2025 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964666; cv=none; b=lD0xzbSp/Iay5Vj63SAO/pBr6Lp5IVMtSXfUoBKS0NtO0epyt1taSrOKA54ljgnICqj3K6oLDUJ3A6r36mXaqBKM+SMZdseEjzAbmx1CqwdhNPuIdubeC7/1cPwa4hEL/z/994B8PM5M5YmandCXbE9zoRBmaGsW11lWiM0EVHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964666; c=relaxed/simple;
	bh=N/0d0mKW07wFgRFLTBIlelDE6XtrInsDavk8ZqJpx5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REeyhHl/ilDPqH95SICyVM7EjubbEqztugez+BY/VKDKBplVV5uuFVzeSXy/UQQck/dWfEYaxPdVfmrilNMZ4LUjjf1WDxT3dFflbpXNO8ssIWpdKqP/V6rCVfP9GNxlmfS7waS6G3xoDnIKDdUTCryhjVBDED4walXQjt/Uyr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyjkQPOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514BEC4CEED;
	Tue,  8 Jul 2025 08:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751964665;
	bh=N/0d0mKW07wFgRFLTBIlelDE6XtrInsDavk8ZqJpx5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GyjkQPOtw0ym/NrawZ2Hn26MiYvjJ2VzHekm5U8LVHv0NJsyc9lIRH84NvkZYNYSt
	 2jzCq32+gtes2SzmX52d97LISK0cnyDUXlaHbuKusCLP0E8OOq/3upy+GtCxhuPfpj
	 DYDQXMfCGKCzbY1Mjg1zmm8sdMalepsPeX10hz93durHXub9sSO6Z0ZaNtvs3yBkvN
	 YS2iA/04qADiFOO+Nxgu8bHtrFD4Cm4gBSXrgXYYrTDMSrL2qqkJ3QPwPS2jJkXmYP
	 YppHeyX7Gybx357//q7sPpvRPDyVA3iy1VOQC0BvodLAzQUbHwjQcQnxSUKUqtG7wo
	 KZy5cignph7kg==
Date: Tue, 8 Jul 2025 10:51:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Georgi Djakov <djakov@kernel.org>, Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/4] arm64: dts: qcom: qcs615: Drop IPA interconnects
Message-ID: <20250708-amiable-owl-of-enthusiasm-e75662@krzk-bin>
References: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
 <20250627-topic-qcs615_icc_ipa-v1-1-dc47596cde69@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250627-topic-qcs615_icc_ipa-v1-1-dc47596cde69@oss.qualcomm.com>

On Fri, Jun 27, 2025 at 09:37:55PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> In the same spirit as e.g. Commit 6314184be391 ("arm64: dts: qcom:
> sc8180x: Drop ipa-virt interconnect") drop the resources that should
> be taken care of through the clk-rpmh driver.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 6 ------

This is non-bisectable and breaks the users. Should be the last patch,
not the first, with explicit notice that it must wait after the next
merge window.

Plus this affects all outside users, which also should be somehow
explained. "Spirit" of some other commit does not apply here. These are
different products, different users. It needs its own rationale and
justification.

Best regards,
Krzysztof


