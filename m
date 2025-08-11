Return-Path: <linux-pm+bounces-32184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F63B214C9
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 20:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91B277AF916
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 18:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257F02E718F;
	Mon, 11 Aug 2025 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rek3mcpp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2A82E7187;
	Mon, 11 Aug 2025 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937688; cv=none; b=CFfoZzBmRPTavXVOcvzdczF75BiU1Md3Vfv2p0+dPKe1A2h9mUY/iaGoGWd0Qmm1dYUd+8Ag5JZGMSd/NxkcSpDicMrjGqIL9jZ5wOYRck/pphGXZ2IHXUNoAXK1Rbgki6d/DQxG54pkyZMsGgx4eG93oApxBqcrr6jlAGnWQ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937688; c=relaxed/simple;
	bh=IjJ4HMTpAO8V6HCzJik+3cgjl/YHdVBEmguWgNN/URE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AW7jN2kMJG3lRm7sGoPHpeGQXBOWN6FAOvUWiCzQXDCiwEqpU9rxCbghcvhAQV5kVosaoDZInOq4aj6SGsFwQHQ1GpdFYN5b+w0BCwnfl3UzV9ECz/uj9llYymSbRlOw9+aleTAogxUIePx6XlKqMDljXsQVTC9ORnKHwkzDQR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rek3mcpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81374C4CEF7;
	Mon, 11 Aug 2025 18:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754937687;
	bh=IjJ4HMTpAO8V6HCzJik+3cgjl/YHdVBEmguWgNN/URE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rek3mcpp72frlPHRh5khSE0n3qnhJvF628sQzDPS1zDtAif0IiSlR3jk+Y7emtnrd
	 VrEZ9J3BONSqB3WeIvg7AOCrL6zuZRlybgtPImwYt1oCCDu3kbGvME1fcI2ax6b2XS
	 VtItNrUZ9HU1w1Zf1IlKVS2h7fPMI5GWI/X7Y+q299fi/8y7KelwJBb9nLbydpPb+l
	 5CbbSI8USCem00jx17bZg2S8sTCHYFSf/mZOlbl6FNgxMLSIyAx61EOihg+DpchV+O
	 6unuVa27lnTyVdXhOwa+Liyc38qr1wid9tHirrneHurDBnGocpMs7uk0GY7xvxLp0+
	 lwCZwAqCGYWvA==
From: Bjorn Andersson <andersson@kernel.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	ilia.lin@kernel.org,
	djakov@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: (subset) [PATCH v7 0/4] Enable cpufreq for IPQ5424
Date: Mon, 11 Aug 2025 13:41:06 -0500
Message-ID: <175493766084.138281.3748243184118825357.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811090954.2854440-1-quic_varada@quicinc.com>
References: <20250811090954.2854440-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 11 Aug 2025 14:39:50 +0530, Varadarajan Narayanan wrote:
> CPU on Qualcomm ipq5424 is clocked by huayra PLL with RCG support.
> Add support for the APSS PLL, RCG and clock enable for ipq5424.
> The PLL, RCG register space are clubbed. Hence adding new APSS driver
> for both PLL and RCG/CBC control. Also the L3 cache has a separate pll
> modeled as ICC clock. The L3 pll needs to be scaled along with the CPU.
> 
> v7: Fix 'Reviewed-by' placement for bindings patch
>     Use enum instead of clock names for l3 pll
>     Select IPQ_APSS_5424 if IPQ_GCC_5424 is enabled
> 
> [...]

Applied, thanks!

[2/4] clk: qcom: apss-ipq5424: Add ipq5424 apss clock controller
      commit: 5bf83c54bab5eb15a2749c6c52b6f96d425490bc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

