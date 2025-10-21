Return-Path: <linux-pm+bounces-36587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF858BF7E52
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 19:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F9A3B5561
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 17:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F05A34DB64;
	Tue, 21 Oct 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4IH1Jzf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865E34C125;
	Tue, 21 Oct 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067551; cv=none; b=clQLDmADRadX5s4CmKXrr9MCCv43+4MtD+ZPP72rpFsD3HsQeAZDK3TPUox5YgEsafDxxaCrlHPKT73AV0WTrAAujScnFV8hkAlrjcPESsAVuEtFJGCI+fym3Ojy+AXNZrSA7daYFQLpZ/oNKF2eNx2xIQC4hsBTwFFGrXZ4Hrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067551; c=relaxed/simple;
	bh=Yo2d8BmvVI13BXWvC99teKJSqgRJdMWLCDpoER2v3Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bydswRGKZothYnRYCIUJKZemuVXEqCB6jHKenOW0BPlm+D982V75N2QyBqpNtjwHoFsUsJjoNsttjB71i0TSXY1YLXUEa57ykaXaRzZ+AkXuALqXonQ4rtpM84pw8zXOWSXxMgxE0i5bTcp5L8Jd9U8j8ggZArqhLMbll4DunS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4IH1Jzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C58EC4CEF7;
	Tue, 21 Oct 2025 17:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761067551;
	bh=Yo2d8BmvVI13BXWvC99teKJSqgRJdMWLCDpoER2v3Zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i4IH1JzfOOHjChES92XubVNDo3V21W2oVfPiNul1oNL5LoGNB6VqU0uGa08m046rM
	 CYcSeHNFevZVZQZUQRCsJ0vyHcV/kJod0zQA9TfTYs3l9+E/kJIclwmDCLkdt64/+8
	 2m4yENiuUoF6uY6ITCGd4xLZIK0MLXcncjggJPUdogYcGdvOEdCNDey5yH1gZQlcXe
	 qmU+Qkk+PtVNKdi0zqlfHmCMeJ8aMchRmzyO6NCUVw7fc9/IOAJz8jFAMvZAs5j+xi
	 R4zKSbhIsYzlfDSbH5MG4fX2y9GS+NAz6fdXOcBchVllXyMjZ9VxxGZUXBeRcazt2p
	 eJryhMEcrJh1A==
Date: Tue, 21 Oct 2025 18:25:43 +0100
From: Lee Jones <lee@kernel.org>
To: samuel.kayode@savoirfairelinux.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Sean Nyekjaer <sean@geanix.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [GIT PULL] Immutable branch between MFD, Input, Power and Regulator
 due for the v6.19 merge window
Message-ID: <20251021172543.GL475031@google.com>
References: <20251001-pf1550-v12-0-a3302aa41687@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001-pf1550-v12-0-a3302aa41687@savoirfairelinux.com>

Enjoy!

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-input-power-regulator-v6.19

for you to fetch changes up to a7d6255a0bf302c028ac680564633a6aac5f611d:

  MAINTAINERS: Add an entry for PF1550 MFD driver (2025-10-21 16:59:07 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Input, Power and Regulator due for the v6.19 merge window

----------------------------------------------------------------
Samuel Kayode (6):
      dt-bindings: mfd: Add binding for the PF1550 PMIC
      mfd: pf1550: Add core driver for the PF1550 PMIC
      regulator: pf1550: Add support for regulator
      Input: pf1550 - add onkey support
      power: supply: pf1550: add battery charger support
      MAINTAINERS: Add an entry for PF1550 MFD driver

 .../devicetree/bindings/mfd/nxp,pf1550.yaml        | 161 ++++++
 MAINTAINERS                                        |  11 +
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/pf1550-onkey.c                  | 197 +++++++
 drivers/mfd/Kconfig                                |  16 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/pf1550.c                               | 367 ++++++++++++
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/pf1550-charger.c              | 641 +++++++++++++++++++++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/pf1550-regulator.c               | 429 ++++++++++++++
 include/linux/mfd/pf1550.h                         | 273 +++++++++
 15 files changed, 2131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml
 create mode 100644 drivers/input/misc/pf1550-onkey.c
 create mode 100644 drivers/mfd/pf1550.c
 create mode 100644 drivers/power/supply/pf1550-charger.c
 create mode 100644 drivers/regulator/pf1550-regulator.c
 create mode 100644 include/linux/mfd/pf1550.h

-- 
Lee Jones [李琼斯]

