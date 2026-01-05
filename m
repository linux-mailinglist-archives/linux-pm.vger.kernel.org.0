Return-Path: <linux-pm+bounces-40235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D365CF5E34
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 23:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11DB3302D3BC
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 22:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF11313527;
	Mon,  5 Jan 2026 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewhgjP4j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A50305057;
	Mon,  5 Jan 2026 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653411; cv=none; b=jJG9V9l/L42cBRcf1b92zvO1ay2DQ385lBiyNW5Ttn9K9QZ0a/gjSO3rRejon3pJQjnpH32KvhaAIEvCF2/mx+02Ecwju4AF4ZDcjLahOclNK8BMPZyquw3P3O1E6KJ4oBG/B4juH4qyO3FrTpq4jk+fZ4So9DwIYw2ZnJBnyMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653411; c=relaxed/simple;
	bh=31D6qoX8lgsXUYGBg7xPU+7XAZ30YbSieRYrZ/lfYKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kS0jnvDhCwjmtzmdvAHz7FHzxatgCxgFO9ubBGqchPxsLbtyiFqZ1U96AyUwEaBvlAAvbBp1HZjaMFT+uGMXAW6AOvvOKCM0JEGgl/TOJJuFi9kcnaVbko+mEkllWuTJ1BmrdGrKHr3fWWPDB3t0SRBSAHQAJHYnpKWS2v4xdYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewhgjP4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D73C16AAE;
	Mon,  5 Jan 2026 22:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767653410;
	bh=31D6qoX8lgsXUYGBg7xPU+7XAZ30YbSieRYrZ/lfYKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ewhgjP4jI4POND3+QAJ8bXdQIBgP3tHufyiYg0J/QT7F80ckP4QsLTwewu2TlNJDy
	 q/8BBmefcnK+e3rJ9jnTqmTMnJN323LktWsth/y1zhUArwP+6Z9OQJtmz+9YZ01haO
	 MhFFawTYQIiDXZ0V7dm5hhQtDrKrp5xzJrbX1HLilog6J/NoqivdJkL03fwKycqoHE
	 xf+A6ccdXmIUgIedcxqcIVqmYemPtsKQ4WMZSwo7L5X15o+zh0dW8dbLvGGczr8iax
	 BTYBT+tm87xCTpYmxIuERoxF6GOUJBDUJSIppFZwqmzAWc23uSwQkNHjkQy/XS2oLU
	 qGTMXvo2lGJUA==
From: Bjorn Andersson <andersson@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Vinod Koul <vkoul@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v4 0/9] Various dt-bindings for Milos and The Fairphone (Gen. 6) addition
Date: Mon,  5 Jan 2026 16:50:06 -0600
Message-ID: <176765340206.2986820.1001501110439471396.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210-sm7635-fp6-initial-v4-0-b05fddd8b45c@fairphone.com>
References: <20251210-sm7635-fp6-initial-v4-0-b05fddd8b45c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 10 Dec 2025 10:43:24 +0900, Luca Weiss wrote:
> Document various bits of the Milos SoC in the dt-bindings, which don't
> really need any other changes.
> 
> @Rob: Please pick up the cpufreq, crypto, and pdc dt-bindings, they've
> been on the list since many months and weren't picked up by any
> maintainers, so it would be nice if you could take them through your
> tree. The patch for arm/qcom.yaml will be handled by Bjorn I think.
> 
> [...]

Applied, thanks!

[2/9] dt-bindings: crypto: qcom,prng: document Milos
      commit: f50da52e5b2ed73913cc6d0db7c81cd33ced3ae7
[3/9] dt-bindings: qcom,pdc: document the Milos Power Domain Controller
      commit: 42f2799124a4d0081b0c8c50980e37769e8d6880
[4/9] dt-bindings: arm: qcom: Add Milos and The Fairphone (Gen. 6)
      commit: d88771fda13f2e97a056d471b7b7c11bd17da148
[5/9] arm64: dts: qcom: pm8550vs: Disable different PMIC SIDs by default
      commit: 446f4802aa6eb972718b8708188df533b38dbabe
[6/9] arm64: dts: qcom: Add PM7550 PMIC
      commit: 57e89dfdfa28810f8c1a44bdd301fca287ff83d1
[7/9] arm64: dts: qcom: Add PMIV0104 PMIC
      commit: 8f42f255dfb80e57af98191e7a4e18f7d1cdcb7e
[8/9] arm64: dts: qcom: Add initial Milos dtsi
      commit: d9d59d105f98665187d90a49d9099675491990f6
[9/9] arm64: dts: qcom: Add The Fairphone (Gen. 6)
      commit: e25834d7691f0661fa9700c167c48d18752f62bf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

