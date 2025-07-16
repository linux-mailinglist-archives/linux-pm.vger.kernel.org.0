Return-Path: <linux-pm+bounces-30944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8504B07E39
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 21:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024DE560034
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 19:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43912DAFBB;
	Wed, 16 Jul 2025 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVrlG6EE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3FF2D9EEA;
	Wed, 16 Jul 2025 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694867; cv=none; b=OMH8iZDlCruiLrMUWdnPOKSWodG+0GJFhustmdU0GKL3hfCVkpCSRg+x4KZZjtEw1GQIQmAIIttNTF5A4XZHKcNgSOHhkgIIWV07ibvmrbOYp7HdbELdZvZl/c+u6fbXt3e6mpysVKCnBIGEl7vtTQUTKsQRi61rmqsvnmwSWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694867; c=relaxed/simple;
	bh=7n4mVWRObZD2kgTUCGdeQ3rgBXwuGEAyG0g/RMj5SmE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnDI1EH73isTpDvi78rU0tuBeKd97oOGu6BezEMqhK5F75kpiHJwX85whX43t8wJtuKc1SIQ/tbcrsqIs3AjOcpuTo1idwweasaQx78PrTWSguCPpzKpz6pMvybCXnD+3WVXtu1D1AtSqKhspszkCLCr0/nHTD+TcvSTuCf9nwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVrlG6EE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568A9C4CEF8;
	Wed, 16 Jul 2025 19:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752694867;
	bh=7n4mVWRObZD2kgTUCGdeQ3rgBXwuGEAyG0g/RMj5SmE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pVrlG6EEocKF+DbvqTNKGtj2zFeL5dUbdT9NIcI/Nq1F/IgKR/dwgsjW8fGqcLmZI
	 cq2pDszyeGt9PoD5hlyBqfQgwMWXaDYxBN2Oqe4zPGofoHUcTyq32MvYsCk57bNaVi
	 nkZKaPjsFMMF7/IeLC+kuBVxBsxg2Q3M5xqv0nXQgjgX1UZzjkRiNCR/k7EldkEWbs
	 yiIMFFYFtvto57UVZbuUtMVrZgxPRgMZ95QWb8KuCExeT11882Yib90tySuFnKldQ6
	 lSRi+jHuF04P6UsjYz4tQwO3YwwHuXCk31sVCPPIB2m4DYB2oib+KrdAKDfN+tkNft
	 hc9dtlsjSinXA==
From: Bjorn Andersson <andersson@kernel.org>
To: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	quic_srichara@quicinc.com,
	Dmitry Baryshkov <lumag@kernel.org>,
	George Moussalem <george.moussalem@outlook.com>
Subject: Re: (subset) [PATCH v9 6/6] arm64: dts: qcom: ipq5018: Add tsens node
Date: Wed, 16 Jul 2025 14:40:56 -0500
Message-ID: <175269485292.105136.4259302867093840483.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <DS7PR19MB88832B88DAB1DA7942C686869DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
References: <20250228051521.138214-1-george.moussalem@outlook.com> <DS7PR19MB88832B88DAB1DA7942C686869DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 28 Feb 2025 09:11:39 +0400, George Moussalem wrote:
> IPQ5018 has tsens V1.0 IP with 5 sensors, though 4 are in use.
> There is no RPM, so tsens has to be manually enabled. Adding the tsens
> and nvmem nodes and adding 4 thermal sensors (zones). With the
> critical temperature being 120'C and action is to reboot.
> 
> 

Applied, thanks!

[6/6] arm64: dts: qcom: ipq5018: Add tsens node
      commit: 767d6b3ecc292c83442ca84e5e22e38adea9733d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

