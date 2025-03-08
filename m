Return-Path: <linux-pm+bounces-23665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2928A57702
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 01:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DF5176C7B
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 00:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587C6C8EB;
	Sat,  8 Mar 2025 00:45:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364557462;
	Sat,  8 Mar 2025 00:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741394743; cv=none; b=Ev1gvHHgw1rSg72gj0zqjsAgGdhPo25+gLvRT/tn7DBBg3RWrbhQG4ac5TpcvRHhQq5bgv9RguV+08FCfQU2FHW1Wm+sg0JYN+GMFcy9bePPNyysc8hFZNO4hTbnLW1gggDgkhPL3ADCsaUWRgbD+hU0HD826SJtei6qscvuvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741394743; c=relaxed/simple;
	bh=BJ2oF+Imqwr7SxK33oGwZLM3UFkM3Bn6dk6Q0o3g8tc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OHFFLmQwXhgdCrD/kZI67Qj5PPWAfT6w6yRAFWSGo1cWydCphUxS+ZGaZdELGQl0tAXkUisrDUIv0udW3E/seiFBrakrDrfaR+6ShtrTJyErFkAB6dNJfnf1ip9CsUBqLge+owrwnE5Mp7YDRkUVT9/G53upSLNh+5CkGrJ91ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACD3C4CEE3;
	Sat,  8 Mar 2025 00:45:42 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 68723180B9A; Sat, 08 Mar 2025 01:45:40 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Cercueil <paul@crapouillou.net>, Samuel Holland <samuel@sholland.org>, 
 David Lechner <david@lechnology.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
Subject: Re: (subset) [PATCH 0/7] power: supply: core: convert to fwnode
Message-Id: <174139474040.178030.7965473451247701320.b4-ty@collabora.com>
Date: Sat, 08 Mar 2025 01:45:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 25 Feb 2025 00:21:33 +0100, Sebastian Reichel wrote:
> The goal of this series is to replace any OF specific code in the
> power-supply core with more generic fwnode code.
> 
> The first 5 patches of this series mostly take care of removing .of_node
> from power_supply_config in favor of using the existing .fwnode.
> 
> Patch 6 replaces the OF specific logic in battery-info. This will
> hopefully also allow Hans de Goede reusing the code with his Intel
> Dollar Cove TI CC battery driver series.
> 
> [...]

Applied, thanks!

[1/7] power: supply: core: get rid of of_node
      commit: 134254038739a6c6ecb7548a2f895d89a0dc9d2a
[4/7] power: supply: all: switch psy_cfg from of_node to fwnode
      commit: 46d0c03c55033693811d5e4ae36a7eade1ebc82c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


