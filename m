Return-Path: <linux-pm+bounces-38744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF745C8BC26
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 21:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E0564E5427
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C97F340275;
	Wed, 26 Nov 2025 20:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdpMkULu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE5E23AB9D;
	Wed, 26 Nov 2025 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764187520; cv=none; b=Lb1+3quCJL50lhkgBwzYIeuC8Oo2phIHgCTfB/59mHYxlRfxYGK3oLsTKTysD/VxENWrIHm/91C+2ysT1e05bJr+3put5Oz/jHOqzaOfvA3lBKMonVCcUzI0m+0zmOVbNRhMqk01q6WxElJ/IRxjrbb/+c4/bkFCJYBIBoBepEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764187520; c=relaxed/simple;
	bh=lTxE64UghqbjCwYBFbTZVg1XETR3oqEJqhAJgQ3oMN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUzSSpMSHfZX9StrOk5BbQU13qtTzaPZeu94KKdk5+RfVHCkrRgZm3jkjbW3inl0IKp6i86an9IJsHGC+TYQW1YVHoin2dnxGc34cjwGbvfVCW0WULTKOQ+kdYSSMZqMISKtWqv1l5OU2YAGUV8gg5u1OkVO7+lLIRdIU/C80bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdpMkULu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77D0C4CEF7;
	Wed, 26 Nov 2025 20:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764187519;
	bh=lTxE64UghqbjCwYBFbTZVg1XETR3oqEJqhAJgQ3oMN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FdpMkULuaV+5iHWUmteQ/gSJGPOTqqnOzPFz7tLrIe2+zjKJ5MOpkOwEf6hZO/zMK
	 Qa5AbjjUpRUcA2IjYh7nYs7fWi9Y2FTAT61jTJ7VSyg72pesa97vEkr0vWzFeOB/yh
	 8qczpawhm09RG58dOf0F3FmxQ9H2LG3kCrWS4ghieOLABj7VQBiYG5U7+Fz7FpzNq7
	 vxqmak2p/2QNCueaaFxlh8Ap+zZqK2CRePMrJOn6oeTzUpaotSn/a5xLGhN6b/fFJ/
	 60g16DAVvEk5CHy5vD+rmPVUgr3jAkB3D1pDmWoB21llElEsWOLrwonnitN5fmPPWQ
	 oeoXbb545MAwg==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 0/5] Define VDD_MXC for SC8280XP
Date: Wed, 26 Nov 2025 14:10:41 -0600
Message-ID: <176418784438.1591314.8587929353938909456.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
References: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 04 Nov 2025 20:31:05 +0100, Konrad Dybcio wrote:
> This has somehow been omitted, leading to potentially stale votes.
> On the flip side, the domain will now be powered off, which will
> uncover any omissions we've made in the DTs so far.
> 
> Reasonably tested on an x13s without pd_ignore_unused (camera still
> works).
> 
> [...]

Applied, thanks!

[2/5] dt-bindings: remoteproc: qcom,sc8280xp-pas: Fix CDSP power desc
      commit: ca079ec3ebed19a12c1bf080496dacbc6fdfbb39

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

