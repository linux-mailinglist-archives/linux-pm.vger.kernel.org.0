Return-Path: <linux-pm+bounces-19773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B29649FCE96
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 23:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E9E188363C
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 22:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9552018453F;
	Thu, 26 Dec 2024 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npIoxWvE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB551C54A8;
	Thu, 26 Dec 2024 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735252742; cv=none; b=Impd/g402WP2Qatl8tM5LWtT/c++5vJ/WcficnVc8sr5RWeHnijOoRDMSp4KLihgtMmPTl/gCOYpNgmCavvVhOpGi1S2ER4VXwNRdIQie9Nr0koZeYO0fogiLY1l6xL/KTtvauHBAgEWX7HrN8GAuQSC/eJ1i58QjgXQ7j/YG7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735252742; c=relaxed/simple;
	bh=ghvEWc+CY8H0nlr1RDV+hoiNH9dMWvFeMfs/OYEjr0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebbY7776Poz+adYIiWBk6l4yY+5Xm4z/zCqou3lM6hVPXwE3XOeOhdweYFXPpLnswX+M4SrA0PZcLTC4rgQK8dADfdfht25ZzuKsQefffeiT3U/FpGlTNoAKtLQaC9RyQtr7T+kuLEDzdIP3lfsQGWKnvU1YIvSDuMuwyOW1MMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npIoxWvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4453CC4CEE2;
	Thu, 26 Dec 2024 22:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735252742;
	bh=ghvEWc+CY8H0nlr1RDV+hoiNH9dMWvFeMfs/OYEjr0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=npIoxWvEhlwQcxUAJn3Nn3nExWdThmhOt2E3wRP7AZsLMCDTOena4lCfjCB9ObV8v
	 +8bE1nbr+FQ1W7fnOUrWuvP2oHnH7uo+IU9/7ihoPLVUd7Fuscag0H9l2Li/ZJnPUB
	 OGwE6kkyR3nFgdyq/zE+5m+dssgj1faxr4E09/z6l+59WjBAwRhtTDgcHmseYRV1He
	 RzosjZXEZzVzbWoO64u1m2VLhaDoy1b+yEsd9w1D9iZvpwywHLnqSy7Y0XlsFxUAfK
	 FN0zYX+vf6/O4rB9trQPnTfNnv+pE0ETlF7UnvmPhPeR26utG/qLPpOtWbGne+xu7Y
	 PxLL0kAPjIZrg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	Dang Huynh <danct12@riseup.net>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	=?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v11 0/4] Add MSM8917/PM8937/Redmi 5A
Date: Thu, 26 Dec 2024 16:38:32 -0600
Message-ID: <173525273259.1449028.18344250660598461023.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221-msm8917-v11-0-901a74db4805@mainlining.org>
References: <20241221-msm8917-v11-0-901a74db4805@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 21 Dec 2024 00:40:47 +0100, Barnabás Czémán wrote:
> This patch series add support for MSM8917 soc with PM8937 and
> Xiaomi Redmi 5A (riva).
> 
> 

Applied, thanks!

[1/4] arm64: dts: qcom: Add PM8937 PMIC
      commit: 89f6e0251d3a84aef8380f03009ac1bf182ec206
[2/4] arm64: dts: qcom: Add initial support for MSM8917
      commit: 7f18b1ea7987ff232bc53a830d0aa81ea31d762f
[3/4] dt-bindings: arm: qcom: Add Xiaomi Redmi 5A
      commit: 88efce82a55d61df76e2fc4bdc68459c0b3b7581
[4/4] arm64: dts: qcom: Add Xiaomi Redmi 5A
      commit: 26633b5820569a5e7bb29d713e978107f4a2bd94

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

