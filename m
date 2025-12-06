Return-Path: <linux-pm+bounces-39264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DB7CAA01D
	for <lists+linux-pm@lfdr.de>; Sat, 06 Dec 2025 05:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5972F3253F0E
	for <lists+linux-pm@lfdr.de>; Sat,  6 Dec 2025 03:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130752BD580;
	Sat,  6 Dec 2025 03:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukkmd+3K"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFBF296BD6;
	Sat,  6 Dec 2025 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764993594; cv=none; b=kBv9wpHN46kn+/av/kwGBJahJARe2B+yaTnCSrPOLuOIN40e0fPv3nocDsZ18jttREJrWXy2Mwn5Dy9+ZYLHJf6w3aA4+bTQ1NkiZkMK52C3+tdbpQxELfJMZrRYEyNcmmnc3I/XNw1sKYQZeRzDwzYkG2PR3a2flcSSiC4B38Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764993594; c=relaxed/simple;
	bh=+uq+QxkkNnADYHAyHPkaa9Tz9K/l+B6LhYrUK7N/CSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNeeckcHz6NlqzRzeQ1Hx65NrT75ASIH1eyfMyFkM6wJWvzWIlWZPNPqQAJE29UF3knuTu03sAjkFrI4DXg0L6dBk1uTuKhjas/j5nosZEv64Atwm0dvtYpzeTBwA0MziPXwOQzqIOzlCKcBPrV666Jrx96ItI0rJr/hIklktF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukkmd+3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC387C113D0;
	Sat,  6 Dec 2025 03:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764993593;
	bh=+uq+QxkkNnADYHAyHPkaa9Tz9K/l+B6LhYrUK7N/CSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ukkmd+3KFD0GknD7DU0nnmaVMl5vA/1pjIf4ITt3AxrjzQvamGGUenDMTFd6dZS8H
	 X/hYbcySzN9mR0faVianX9ww9CJl1zQjtRwgPAwQ8Cazvzutqbbg71Ov07myp2nCxg
	 zRSD9wJeJp9dbixVPbctOGPAp7OwSzhANknogSd445Xov/4SYTeYJ/TOrpxwOjAZmV
	 Ft6CIAyV1TpjvQg9ajTsVTI7WY60rnS55ROo3qgWAIOSsizAIr9BXzy2N4H2VhIimE
	 cGHGvZLka0mPDUGWUgTX5IhUkxAb55e8W1NZw07+ZZ27nAQVMqq/lnPBVOotV4vHAK
	 Xvni98nUwm8Gw==
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
Subject: Re: [PATCH v2 0/3] Define VDD_MXC for SC8280XP
Date: Fri,  5 Dec 2025 22:06:06 -0600
Message-ID: <176499396490.224243.15580177530806530343.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202-topic-8280_mxc-v2-0-46cdf47a829e@oss.qualcomm.com>
References: <20251202-topic-8280_mxc-v2-0-46cdf47a829e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 02 Dec 2025 18:36:19 +0100, Konrad Dybcio wrote:
> This has somehow been omitted, leading to potentially stale votes.
> On the flip side, the domain will now be powered off, which will
> uncover any omissions we've made in the DTs so far.
> 
> Reasonably tested on an x13s without pd_ignore_unused (camera still
> works).
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: power: qcom,rpmpd: Add SC8280XP_MXC_AO
      commit: 01e17231b051b9392f93d1c7a7adfec5a7d4d72d
[2/3] pmdomain: qcom: rpmhpd: Add MXC to SC8280XP
      commit: 2dac255225ece85cf38c9557a413ac324e3a6651
[3/3] arm64: dts: qcom: sc8280xp: Add missing VDD_MXC links
      commit: 3e12e2ec598b90e8f6af8b455ceeba8cd58123ad

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

