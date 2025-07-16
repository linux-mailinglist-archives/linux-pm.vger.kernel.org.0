Return-Path: <linux-pm+bounces-30943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 181EDB07E34
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 21:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F0E1C42F6D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 19:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD252D94A9;
	Wed, 16 Jul 2025 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV8HDASu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CE72D948C;
	Wed, 16 Jul 2025 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694867; cv=none; b=hxJolIUeJYcG28RQTD0n3bG2r4UtiL21O1TK3fAjKEDdSH9ipIqb+lhYRTYNX1fS1lJLpVSAG5m0gphcRmuDEV+UWWZ7PZ1TQns8pXmFDXdBgTuiRMZa9vwHm43oRGA7ZXWcN2vtzVv/4zMKIJiD5TwXrxU5n8imedTrGg/VYZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694867; c=relaxed/simple;
	bh=JoaDugOdEsm6VBigNN/aseb7gg+U/Aam2Vgxf86pNuA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+3oCXcodYLqyY+aF3Ge8xOSW1GPkxO3PCQgHlE3nOA9ZfzJWL2T8hsQxM3AAdJrp2zgaUkN8i+d/5WN5lqtKUfswVMKfr0pRkZ1kXJ9+40MNzw1WT7yf0s+w3v1X4MWYqCmUmGVLO/n4rdKim/MkuIO66peHenbTm7rFW5a2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV8HDASu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575A3C4CEF5;
	Wed, 16 Jul 2025 19:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752694866;
	bh=JoaDugOdEsm6VBigNN/aseb7gg+U/Aam2Vgxf86pNuA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mV8HDASufuwUDcE3p2CRvepyTKumUHXwNHCBMkO426SZZTUorFDUNHhRXsGy546AA
	 +Eg/NtEpPJkMKk+jucdWZJROfeLOqCntB2XdtlP9ZWBIoIS7gxro9SGP0quyV2866H
	 LI92IZlqdBOAp6kcSAsFluSDwwQHMYrtJyH4+74aVdXOpcyogA0auK/eC0yZ3HxOsa
	 51+2K+iwh9BuhIhFY7c8vxJ3KUGxuxg2vq83rnCW/bDFUxfPHpFSiUDSOYaab/WRbu
	 fKnVjMe31y95bRYLopAR4GGLTfBcG/nRPfDC/LSSG+VXG2F9satHindBTE/3T3ypen
	 DraYk+Djg5VPQ==
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
Subject: Re: [PATCH v9 0/6] Add support for IPQ5018 tsens
Date: Wed, 16 Jul 2025 14:40:55 -0500
Message-ID: <175269485291.105136.1922330001182021659.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <DS7PR19MB88836DC6965515E12D70BB2C9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
References: <20250228051521.138214-1-george.moussalem@outlook.com> <DS7PR19MB88836DC6965515E12D70BB2C9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 28 Feb 2025 09:11:33 +0400, George Moussalem wrote:
> IPQ5018 has tsens V1.0 IP with 5 sensors, of which 4 are in use,
> and 1 interrupt. There is no RPM present in the soc to do tsens early
> enable. Adding support for the same here.
> 
> Last patch series sent by Qualcomm dates back to Sep 22, 2023.
> Since I'm working on OpenWrt support for IPQ5018 based boards (routers)
> and Sricharan Ramabadhran <quic_srichara@quicinc.com> in below email
> confirmed this SoC is still active, I'm continuing the efforts to send
> patches upstream for Linux kernel support.
> https://lore.kernel.org/all/63dc4054-b1e2-4e7a-94e7-643beb26a6f3@quicinc.com/
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: nvmem: Add compatible for IPQ5018
      (no commit info)
[2/6] dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
      (no commit info)
[3/6] thermal: qcom: tsens: update conditions to strictly evaluate for IP v2+
      (no commit info)
[4/6] thermal: qcom: tsens: add support for tsens v1 without RPM
      (no commit info)
[5/6] thermal: qcom: tsens: Add support for IPQ5018 tsens
      (no commit info)
[6/6] arm64: dts: qcom: ipq5018: Add tsens node
      commit: 767d6b3ecc292c83442ca84e5e22e38adea9733d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

