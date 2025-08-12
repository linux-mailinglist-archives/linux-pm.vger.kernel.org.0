Return-Path: <linux-pm+bounces-32235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF41B23B69
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 23:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9586586157
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 21:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0B92E3AF2;
	Tue, 12 Aug 2025 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6okl9Iz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD52E2DD4;
	Tue, 12 Aug 2025 21:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035801; cv=none; b=HhgvlkNl3Tgh/nlATNjbdBOPHl7WH0gtYaJlOWKdRVEwwP8Xnuv8zbTOw8TwVPo/TXZBsSJERagM2pZqYKA8udQiucedD99nHXPWLul2Ivke6HmCz0EE9M9qTxOUzMpl96eCNhMutoQh6KXg3jEAI8p9hImQSV6rD7HxUz3umJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035801; c=relaxed/simple;
	bh=LeAvm0kodbf6Ts9L7dMnSh08EnxztEITYKbiYnbeZMk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2JkqCbLaOOHRnQZCvTaMpg3Ame3C3QE/9jqD7Bnb/xCvs4QgTdcRZUKQX7PACpm/7dhGH97TgjE3z1JhAV5JYRGU8DZCmY44fq3rk4rp6hfHsYEt0iMP1L6hWAjyR/Sf1eQjQ4+wkXFJj5PT2lutlm2dkzBJlw7HyCBqdrXwhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6okl9Iz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBF2C4CEF1;
	Tue, 12 Aug 2025 21:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755035800;
	bh=LeAvm0kodbf6Ts9L7dMnSh08EnxztEITYKbiYnbeZMk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=U6okl9IzBp8G8Eu/da8JtZmSbYQTvsi3bwYktct9KkSFsGty+cBk4A5OE5GF6S4Dr
	 lynn4+uo3z/UsHFKyxsn5i7LclHBOTquXErS+J7UPj6sD9edRlRq2HE8YFpFwc2yL8
	 d8iogu3Uu7deRlJareyDjtQWrsyph54wK+1u7NL3qbru6hO8AJPT4TN6DDz8qMqoik
	 CnxM1usZslV9hPieDRpiByKwT/+uk1fsjYHctYO70mhf5EpD0X2LhhhG+wi3kiG7k3
	 DJ5341IeGeTFSnz1CGLofCVcVIVgmW+qxG6n/PiT3e08Ogs/jSsj5bIzVeVc3kZQIm
	 ENHVbmZozGVrw==
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
Date: Tue, 12 Aug 2025 16:56:20 -0500
Message-ID: <175503322864.231048.3923613819705551334.b4-ty@kernel.org>
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

[4/4] arm64: dts: qcom: ipq5424: Enable cpufreq
      commit: 77abf70ee126d40dba9ada0a4ccb4c7743f6a3e6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

