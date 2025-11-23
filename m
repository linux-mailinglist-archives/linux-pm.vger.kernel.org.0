Return-Path: <linux-pm+bounces-38406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D2BC7DDFE
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 09:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0191D3A9A47
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0E82BEC2E;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ2e94La"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AB621A449;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763886984; cv=none; b=f1G9+bYthwZimRoPLSv+X+qAHQa4qEcJ3caeAe6IXCmwVzXvJWZp5je7s10u0tt8Q+p7IDIn8Kz4BeHw6+dIoCToIs2gW7ppMtNMnApFu8ZXI0CVDXhWz4sqn5+chGzFl0ud2d4GGDtjkgcy7d7P3HPqD9AIieLpczPcX419rK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763886984; c=relaxed/simple;
	bh=BpGpxP773zsyhDqiIdTbkt1LHwhw61h1r+wf9K8eXBA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gs17CM6ovRqKEEA5zKGVklumo5I4ilmDg9RgsFNBp9fSw2dO8f35zYfVkEoFt6KWnCu/v0ChhTSM6bVDThRiCUBhlO1B0Zk6Mf02oLqAP854lGjBRiiW4R5kx5x1T//1spxR5UUQOpsR+mNNMvGDaxYN/ZlXeQwOyKDt+uSb0Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ2e94La; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C90EC113D0;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763886984;
	bh=BpGpxP773zsyhDqiIdTbkt1LHwhw61h1r+wf9K8eXBA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=hQ2e94LaWlWci7Q2fJQVO0RbwNmlcAiWS0JKfKgDd1tMjCImRXuTmxt57poYlYSSA
	 ILX0dRv3sKWG/8l0R31AoAd3PQWPEWAnpZpW0GiuuhXdYtrIl+Of2vqnSRD27uHhLE
	 /c8S9dRVbORd8DXUoFs5VGbCfhUztn/K9KG2mQbDrJnjRcZi1Tdk2eDA4FZNyUe7J1
	 jABSOiZOvdAsCExuLcUBtwl1QE2NDg2viN9D3Lyi0ymiNOu9W8tMgUasJ0R2MG3BaA
	 xYFJis95h5HPt8CSAIMTUwDGogH8RRpNoKwye9NpiQoQeBMM406jj3zyib/ENoudg8
	 nh68fYuRS28+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394EFCFA46B;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Subject: [PATCH 0/6] Introduce MAX77759 charger driver
Date: Sun, 23 Nov 2025 08:35:47 +0000
Message-Id: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGPHImkC/x2MQQqAIBAAvyJ7TlBBrb4SHaw220MWK4QQ/j3pO
 AwzL2RkwgyjeIHxoUxXaqA7AesRUkRJW2MwylitlZVnKN57O8imOSLL3prFGbc5pwO07Gbcqfz
 Laa71A6K3ftdiAAAA
X-Change-ID: 20251105-max77759-charger-852b626d661a
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763886983; l=1935;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=BpGpxP773zsyhDqiIdTbkt1LHwhw61h1r+wf9K8eXBA=;
 b=BWVPQuQsjLSNkUQqrd15xu/QTq3ozxwwQ2vwMMcB/GYDKnpH5yHZo2OYSKPSBUfx/euLcrJbV
 nJPACkoU7CFCwihqtmUdLp8NRbWZ13t2vr/ibMQv0GZBPk8vharpQqE
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

MAX77759 PMIC is used in Pixel 6 and 6 Pro (Oriole/Raven) boards.
One of the functions of the MAX77759 PMIC is a battery charger. This
patchset introduces a driver for this function. One of the unique
features of this charger driver is that it works with a USB input where
the Type-C controller is TCPCI based.

Changes to the board files will follow soon once this patchset is reviewed.

For reference to the MAX77759 MFD based patchset (present in upstream):
https://lore.kernel.org/all/20250509-max77759-mfd-v10-0-962ac15ee3ef@linaro.org/

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
Amit Sunil Dhamne (6):
      dt-bindings: power: supply: Add Maxim MAX77759 charger
      dt-bindings: mfd: maxim,max77759: add charger child node
      dt-bindings: usb: maxim,max33359: Add supply property for VBUS in OTG mode
      mfd: max77759: modify irq configs
      power: supply: max77759: add charger driver
      usb: typec: tcpm/tcpci_maxim: deprecate WAR for setting charger mode

 .../devicetree/bindings/mfd/maxim,max77759.yaml    |  12 +
 .../power/supply/maxim,max77759-charger.yaml       |  36 +
 .../devicetree/bindings/usb/maxim,max33359.yaml    |   4 +
 MAINTAINERS                                        |   7 +
 drivers/mfd/max77759.c                             |  27 +-
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/max77759_charger.c            | 866 +++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpci_maxim.h               |   1 +
 drivers/usb/typec/tcpm/tcpci_maxim_core.c          |  48 +-
 include/linux/mfd/max77759.h                       |   9 +
 11 files changed, 999 insertions(+), 23 deletions(-)
---
base-commit: 39f90c1967215375f7d87b81d14b0f3ed6b40c29
change-id: 20251105-max77759-charger-852b626d661a

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>



