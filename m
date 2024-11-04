Return-Path: <linux-pm+bounces-16909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5219BABB3
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 05:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E3A1C2087F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 04:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B71187332;
	Mon,  4 Nov 2024 04:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yz7JR7oL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3C185952;
	Mon,  4 Nov 2024 04:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730693632; cv=none; b=G8JuDwYuU6/RjkaueSsHezO/iYa+c7Bk9AkCNYLbdloz/fzDnzGiqoxP1rDARybnywR2q/rmVOvuKkM+/mlas+MfMOuahrC7K2h4rs6JP7fmC4NA0BBrGVmkOsVYX6DBpYeZx3LNrSloZNmqUYmGIRrpazIU6DMqDp7uC9+dVrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730693632; c=relaxed/simple;
	bh=GXvtWXMoN06vkqwKrBdNU3Qoig0XTOVvUiraEOSA7Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftO16q7z1aCuesQseIInrexs6Qv/jozuuBwXhvzwdqcpttUY3S098H/xJ6DwlYYDacmbhvA1GzZ/XaFwr8MZlphVUQj0CWguMXyRW8+4z37XJNLCjimbPQKXJDfEKjsL5pudweQ3x22N+DP7PkDwCXCiw+LMY2OoXIKQoWYvUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yz7JR7oL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BFFC4CED6;
	Mon,  4 Nov 2024 04:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730693631;
	bh=GXvtWXMoN06vkqwKrBdNU3Qoig0XTOVvUiraEOSA7Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yz7JR7oL7gy+CIdQG+VtpIWmsIK30cMUuk+tTGXxGBfaKB0M2Z9LcU0WLujIQVaIg
	 9DJ/wsaSZKKo53KAwPNQyEKZw7nDCnV77KWOvqPnA6SuyBXkaqo0Bv+/gwsERjmeGP
	 TP3TcDiclbGPTknJpuXdYj0AHwZoFCcjZlAWCHhhyWjBtdDfvosdN+/31JVsv48woV
	 0qhNJ85uyTORf+pWYimQGUMJn0tfEkYPp/57bIMZkJjSItZsvH41yJQy6wx67xFof2
	 OsclTHCQFboI9qkaPdzC/vAuAbuOHDOeTuVBnTVBkQsQrcA+tqfdWm5caLRPw1g85w
	 oW69ot+1595Nw==
From: Bjorn Andersson <andersson@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Steev Klimaszewski <steev@kali.org>
Subject: Re: (subset) [PATCH v6 0/6] arm64: dts: qcom: enable Bluetooth and WLAN on sc8280xp and sm8450 boards
Date: Sun,  3 Nov 2024 22:13:38 -0600
Message-ID: <173069362372.23540.7321635486876743738.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
References: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 18 Oct 2024 14:49:10 +0200, Bartosz Golaszewski wrote:
> This series previously only concerned sc8280xp but while enabling
> WLAN/BT on sm8450 I noticed some more changes will be required so I
> folded the latter into this series and updated the sc8280xp CRD and X13
> patches.
> 
> ==
> 
> [...]

Applied, thanks!

[3/6] arm64: dts: qcom: sc8280xp-crd: model the PMU of the on-board wcn6855
      commit: e848528bdfc2a933590498c326d3320d85078c93
[4/6] arm64: dts: qcom: sc8280xp-crd: enable bluetooth
      commit: 38439741623c5fede0c171da801bf0a8b6a2e293
[5/6] arm64: dts: qcom: sc8280xp-x13s: model the PMU of the on-board wcn6855
      commit: 36937845ce2ab3a645e27c6a11642cc0b4f038fe
[6/6] arm64: dts: qcom: sm8450-hdk: model the PMU of the on-board wcn6855
      commit: fe79fbce6efd25414e626036c9382a8019184064

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

