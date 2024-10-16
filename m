Return-Path: <linux-pm+bounces-15739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B9B9A0388
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 10:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F84B25B83
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 08:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0F71D4171;
	Wed, 16 Oct 2024 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdZQu0lv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F045A1D1E99;
	Wed, 16 Oct 2024 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065779; cv=none; b=DE6uYgVRiN86KbhGp3yKCDmLdKtjuWTx6jKQOKkusxUXNKVTsGceFl4UZzxdXw0fI4sF6Fpgs7H+27H5mHxo1xvIntIrBmHApNfpnLmvHDGc6Uy4s5AOgqhwqsiY1pNK2xTbfmQ9Jofe1XN2gSEx/ddegWrD6mwCRebHfMU3LyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065779; c=relaxed/simple;
	bh=VQWxLbP46Yk3JT2ruUu0Qw3xjvSUtKf+K6RBYmBe+lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPV/PDB+UNRic1w+yJ6soybzyVhgoHYyloyAVzP1cMRNVMMoIBsosv8Hd9/aFUgYWKow9cxKhv4ypPSDdcfYoJ4Qz1aT0w3jTgniVmhDZJywINcqiI2N5rzTpOLWKReUtPEkQdtCJdHU1+ItC2OXvtB9fwS469Ipt6W7GrcpE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdZQu0lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CC7C4CED0;
	Wed, 16 Oct 2024 08:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729065778;
	bh=VQWxLbP46Yk3JT2ruUu0Qw3xjvSUtKf+K6RBYmBe+lM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdZQu0lvkqQKp6i7wnzriOv0ggkWZWcHotek7nZZSEdw35cKxZpgEDMR9IrMPXZbQ
	 WYoop23uy1X0RnPZxv+h22a0dffsyAWGe47B3VkLwdnV46GNOwJL0i3dnbOWnL5pqV
	 omdNB+UMVqzfLHYIcQhnCKXUFkU6z65UbCHDFkDyHmnnjxUI+O5bzUMFG8CnQdhrus
	 XL9m9kdJ61u2FNby/2sWKy01wPxw1/DeGD4aTCMMTOmDF7gVJmeIWCVkItZEaRNeJH
	 MyKxVJEiK6L05viEsJafMLkbLfvaL3SZzmumCECEL5gaUXlP26Z9cagMEpkoaYU6ij
	 1iyG5JVbDWBUg==
Date: Wed, 16 Oct 2024 09:02:48 +0100
From: Lee Jones <lee@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v8 3/3] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
Message-ID: <20241016080248.GN8348@google.com>
References: <20241001104145.24054-1-macpaul.lin@mediatek.com>
 <20241001104145.24054-3-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001104145.24054-3-macpaul.lin@mediatek.com>

Argh, I couldn't bring myself to do it!  Here's a PR instead:

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-dt-mfd-input-leds-power-rtc-v6.13

for you to fetch changes up to 6e357f572638547e9c9e8d8abb7dc572c12032f3:

  dt-bindings: mfd: mediatek: mt6397: Convert to DT schema format (2024-10-16 09:00:38 +0100)

----------------------------------------------------------------
Immutable branch between DT, MFD, Input, LEDs Power and RTC due for the v6.13 merge window

----------------------------------------------------------------
Macpaul Lin (1):
      dt-bindings: mfd: mediatek: mt6397: Convert to DT schema format

 .../bindings/input/mediatek,pmic-keys.yaml         |   2 +-
 .../devicetree/bindings/leds/leds-mt6323.txt       |  63 ---
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml   | 588 +++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/mt6397.txt   | 110 ----
 .../bindings/power/reset/mt6323-poweroff.txt       |  20 -
 .../devicetree/bindings/rtc/rtc-mt6397.txt         |  31 --
 MAINTAINERS                                        |   8 +-
 7 files changed, 595 insertions(+), 227 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-mt6323.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/mt6397.txt
 delete mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txtThe following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-dt-mfd-input-leds-power-rtc-v6.13

for you to fetch changes up to 6e357f572638547e9c9e8d8abb7dc572c12032f3:

  dt-bindings: mfd: mediatek: mt6397: Convert to DT schema format (2024-10-16 09:00:38 +0100)

----------------------------------------------------------------
Immutable branch between DT, MFD, Input, LEDs Power and RTC due for the v6.13 merge window

----------------------------------------------------------------
Macpaul Lin (1):
      dt-bindings: mfd: mediatek: mt6397: Convert to DT schema format

 .../bindings/input/mediatek,pmic-keys.yaml         |   2 +-
 .../devicetree/bindings/leds/leds-mt6323.txt       |  63 ---
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml   | 588 +++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/mt6397.txt   | 110 ----
 .../bindings/power/reset/mt6323-poweroff.txt       |  20 -
 .../devicetree/bindings/rtc/rtc-mt6397.txt         |  31 --
 MAINTAINERS                                        |   8 +-
 7 files changed, 595 insertions(+), 227 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-mt6323.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/mt6397.txt
 delete mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt

-- 
Lee Jones [李琼斯]

