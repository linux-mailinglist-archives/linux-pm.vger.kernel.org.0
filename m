Return-Path: <linux-pm+bounces-37121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6DEC2130A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 17:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BE242703F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 16:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3287368F42;
	Thu, 30 Oct 2025 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVYb5z3t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C66368F37;
	Thu, 30 Oct 2025 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841367; cv=none; b=Cka+AGjuEXxKLFR90QLn1bygqMMElPAyfUWpULei0S1O7Qfbl5dV+MyZTCfzI9OWXwQ1I8qG9+PWZKXN0DFk7lmu88gE/cUC9erYYPo2Y0HxzzGKN4JN9wUwW4ZAbD2RhhYtNli0j8PI6R+OOqRPTWzg1NrPX+Tekw2eg3UK2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841367; c=relaxed/simple;
	bh=VDLc8wUfMBSZNHsTbwVHcHE2r/TpbECK6ZwoaGE9bcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o80PDPqs2xv07Mjs+zMIQQQnb+D5qPe/MSGwgRFIwhSr5k1cQpeSi0/J7YHXOCV8KBTHfL8ulc00JLSeiteeyyb9kOg0fFxdZbhFtBfTP6TiFkB4BTkyFvW44TFc9TX2N0orGxhnzVgTelY9/5Zbnkq/RB/fexcegcp/fJZzV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVYb5z3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8964BC4CEFF;
	Thu, 30 Oct 2025 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761841367;
	bh=VDLc8wUfMBSZNHsTbwVHcHE2r/TpbECK6ZwoaGE9bcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BVYb5z3trxs2/DUJp6hHyeKT2RqD6IpINkn5QIPGiFA5vFJhBjWaH8YxLg+7EaIyW
	 qXELbIvNlCahXkknztW6GYX+PxOxK9gdd2OUnxFFORbZRVKAbXWdEAnXYoVxDWKs69
	 9a8zuUwvN1rv3DStopO/i9oUl/A/q6g6Wn7dI71bxuQXttlWR4S0Gs9WJcb7Wc5g2c
	 GMdo6n8YYQAoJ3y8Ue34Lnl09s9C4YyXzlp0Z+t08Z4bVp57xvjT049lHB3GQto8MZ
	 UvA9khQTUZ514QAoMh0A+C3h45ZCApwD+c9FJz7R4GyGsIXGgzoGtqQWBChrp6WVmr
	 WJHJMImU+9tGg==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Anusha Rao <quic_anusha@quicinc.com>,
	Devi Priya <quic_devipriy@quicinc.com>,
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
	Georgi Djakov <djakov@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Luo Jie <quic_luoj@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	netdev@vger.kernel.org,
	quic_kkumarcs@quicinc.com,
	quic_linchen@quicinc.com,
	quic_leiwei@quicinc.com,
	quic_pavir@quicinc.com,
	quic_suruchia@quicinc.com,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v7 00/10] Add Network Subsystem (NSS) clock controller support for IPQ5424 SoC
Date: Thu, 30 Oct 2025 11:25:39 -0500
Message-ID: <176184154218.475875.7725687193388038475.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014-qcom_ipq5424_nsscc-v7-0-081f4956be02@quicinc.com>
References: <20251014-qcom_ipq5424_nsscc-v7-0-081f4956be02@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 14 Oct 2025 22:35:25 +0800, Luo Jie wrote:
> The NSS clock controller on the IPQ5424 SoC provides clocks and resets
> to the networking related hardware blocks such as the Packet Processing
> Engine (PPE) and UNIPHY (PCS). Its parent clocks are sourced from the
> GCC, CMN PLL, and UNIPHY blocks.
> 
> Additionally, register the gpll0_out_aux GCC clock, which serves as one
> of the parent clocks for some of the NSS clocks.
> 
> [...]

Applied, thanks!

[09/10] arm64: dts: qcom: ipq5424: Add NSS clock controller node
        commit: e7a1bf542c3b254e4f3e8981e2b769f5c7424960

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

