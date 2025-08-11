Return-Path: <linux-pm+bounces-32131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA21B200E3
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 09:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9800189DCFF
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 07:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F812DC35F;
	Mon, 11 Aug 2025 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ZQ+7Xu1N"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7C52DC34D;
	Mon, 11 Aug 2025 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898754; cv=none; b=l27u7fsVpVmIaSyhCHeSzsn9EH97hn/30RXsWyfVpc12Cw7t6Z6+wFXxpvSFmyWWJdBM94Wh1vbvliIQC/FLenkSv52/muV5LnUdRWBBNR2MgMdq++BF96eHeYBXsa30y6enjMQNqZ72+RzhCjkzoldnFuvDefo62Nurexlm7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898754; c=relaxed/simple;
	bh=39WBLjsfxKNijYZhYU0A0LkNQJhlQksO1yLsTP+f13w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCdetNKs1Bgx8GFsQsOZsgv0EjhEy8FYwjDFaxxHY8+lGNxL8jgKqdgiYJJHejZQLPD73LQrADbmL2puKZ75teIZbdt/W81WutaPFD41T1rsA0qxaYPi9F4hOkeDveVwLVNVtKV+E/UmZyqPbK1o8W5Ul4drvvauTbteCwxScmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ZQ+7Xu1N; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=ysn3zwyuU6s13DDWolDXQKifp8kTjv/aucfDhO4qCuA=; b=ZQ+7Xu1NFO4Np0TMbQJLOBZv4Y
	xnCQjOvhFHnFhfa0KQfzC5s9SOJCfnBBro+U+jBNVDqmWly2Ff/eDJBX4yG5Dx4wPkW03boI8ly5/
	4fZd2GVvNflKNoM75smMHiC1SwZsuehTN4jJLPEnn8gXb4ilemsJ89nYKDpAQzD85/57u+gmIuOXi
	c54puADCM7vCHqGPDmMGrDCSqfQm0mmY7j5A6NRYjazIGSxq7fbNIbcZHJFQgJe9H7FLSObyqeR+X
	VovaMjFOpBuTg6dYw0c+ibniv2jq41ldoI1ON9Ujhh3GaghFNq1S4YKPMYKJEviJB0HAOF4fJPjX2
	3qb0z0MQ==;
Received: from i53875a0c.versanet.de ([83.135.90.12] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ulNKM-0007Ro-Cb; Mon, 11 Aug 2025 09:52:18 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Alexey Charkov <alchark@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ye Zhang <ye.zhang@rock-chips.com>
Subject: Re: (subset) [PATCH v6 0/7] RK3576 thermal sensor support, including OTP trim adjustments
Date: Mon, 11 Aug 2025 09:52:04 +0200
Message-ID: <175489870466.808197.13531794692476437932.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
References: <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 10 Jun 2025 14:32:36 +0200, Nicolas Frattaroli wrote:
> This series adds support for the RK3576's thermal sensor.
> 
> The sensor has six channels, providing measurements for the package
> temperature, the temperature of the big cores, the temperature of the
> little cores, and the GPU, NPU and DDR controller.
> 
> In addition to adding support for the sensor itself, the series also
> adds support for reading thermal trim values out of the device tree.
> Most of this functionality is not specific to this SoC, but needed to be
> implemented to make the sensors a little more accurate in order to
> investigate whether the TRM swapped GPU and DDR or downstream swapped
> GPU and DDR in terms of channel IDs, as downstream disagrees with what's
> in the TRM, and the difference is so small and hard to pin down with
> testing that the constant offset between the two sensors was a little
> annoying for me to deal with.
> 
> [...]

Applied, thanks!

[6/7] arm64: dts: rockchip: Add thermal nodes to RK3576
      commit: 15e8ba9d8b14ae6de415186622379f5f4dcfd141
[7/7] arm64: dts: rockchip: Add thermal trim OTP and tsadc nodes
      commit: a4053badacf3699023527392c947314b074f5e0e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

