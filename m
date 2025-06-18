Return-Path: <linux-pm+bounces-28934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CBAADE229
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 06:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246B41898FFD
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 04:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2251621ABD4;
	Wed, 18 Jun 2025 04:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRqXO5Vo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB9D21ABAE;
	Wed, 18 Jun 2025 04:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750219785; cv=none; b=eA3L6wzLRsS1u2EJw8JFVKEr8xZe5lPklRBZ4PKfq79FeIA2sbAGRMBv+o5vQYYTgzTZNZEDPtYv7eDbq+wMFzfxsPEGbg7NNb1Q3W2/9eQKHfHVaA8PWaIn81zShrADpP8ORxmSpvgLbJh/b8N3QTvwdg2snGKC2w3mnEicAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750219785; c=relaxed/simple;
	bh=R1SVW+ip9jM+Lh5A9v+hTwsf8Xs9Pj+YKS4SvGsvKTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1ReOqfhOrIIQWBnE6XDNNZZcAsH7DwbLOwcuzTAuwt0jI9UHNTd9gcUaUDSWgj2Vl2sdmxuaimgHiBpx304NwPFHWsoVg4kP/ZRBY5FJ536NJiIL24FSTvjF9QJLhfKFkhQDDrj2l52TSMzAkCRO4nWh6rCPFZO9nnf8b8A5tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRqXO5Vo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363D9C4CEF2;
	Wed, 18 Jun 2025 04:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750219784;
	bh=R1SVW+ip9jM+Lh5A9v+hTwsf8Xs9Pj+YKS4SvGsvKTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRqXO5VoKGAmykg5T7jjDtSc8dVDa+Ugo1/HsWDYR5ezA2L6u0bMN781GE7bN0UbY
	 gLWuzB/+mwdQHCIgjIFYwayVUi4NBuZkmaPZ70bQbu6r9wXidp3IZd4EWlXD3oNYMb
	 5DNKtVoibHWBrKqpcIUIBJG8Sc61fD4Kwo18RNTRuZGzIwM/ORnY7Vc92eQEAS9MZp
	 Gq8Gs2+aBeA9OgKonOQOkUd4HHHa08yYBbDZsTy7y7TRXnEfrYM+EXQAYqU4WIOZHn
	 zceAQqFMpxPaOWf2CcAQh4bVcL8aq2MHQo5aS8aVY+EC6ZRefgtSyd3/uakhX0zGRe
	 nRZXlSF35quHA==
From: Bjorn Andersson <andersson@kernel.org>
To: Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Odelu Kukatla <quic_okukatla@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mike Tipton <mdtipton@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH V11 0/7] Add EPSS L3 provider support on SA8775P SoC
Date: Tue, 17 Jun 2025 23:09:26 -0500
Message-ID: <175021976637.732077.15150240059038030494.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415095343.32125-1-quic_rlaggysh@quicinc.com>
References: <20250415095343.32125-1-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 15 Apr 2025 09:53:36 +0000, Raviteja Laggyshetty wrote:
> Add Epoch Subsystem (EPSS) L3 provider support on SA8775P SoCs.
> 
> Current interconnect framework is based on static IDs for creating node
> and registering with framework. This becomes a limitation for topologies
> where there are multiple instances of same interconnect provider.
> Modified interconnect framework APIs to create and link icc node with
> dynamic IDs, this will help to overcome the dependency on static IDs.
> 
> [...]

Applied, thanks!

[6/7] arm64: dts: qcom: sa8775p: add EPSS l3 interconnect provider
      commit: 6531b4b095dacc3067c91a802e1518f3faad72b4
[7/7] arm64: dts: qcom: sa8775p: Add CPU OPP tables to scale DDR/L3
      commit: 985237d49c4cf0254810b4b8078d240ba9bfc2ec

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

