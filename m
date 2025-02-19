Return-Path: <linux-pm+bounces-22398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F3FA3B9C0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 10:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74ED17B4F6
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DF41E2614;
	Wed, 19 Feb 2025 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6siI/BK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F41D5175;
	Wed, 19 Feb 2025 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957225; cv=none; b=BZiH6EnnrzwfGKE2iP6dKldaIvNRrZw5Et5R+iu2yQQMWlxhQ2lFcvx6THppzxx8qXiJhDagwOyXX5x1jGpeR7HgBqgP5fO+0MdSL/fUvrazp5fotqOTkX74YZtYo+Uc13JSwpuTu6Y4akZQbr1bAvo3JcmgKIrBmEzAG+A5cOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957225; c=relaxed/simple;
	bh=pwGGm2Hm5mZhaIRDSeBjgUFdbUBMVkomGoaRRRL0SIc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FME8f5WSYpgn/7AwpaEWB8dUjCm4DvrmTtHtVkYnFKPka4RW3fZlKaK4Blf4pM3KA9Pmyft6h1+G7zYKHMdOQBMYtWmCVw5jqtm/gAKkdslS+A49l9Y3XGxSxktqB6EAUR36LfYswgM0HyVXmjsshcy2Wk6ZPvA4lb0DZwZ6/IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6siI/BK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DE38C4CEE7;
	Wed, 19 Feb 2025 09:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739957225;
	bh=pwGGm2Hm5mZhaIRDSeBjgUFdbUBMVkomGoaRRRL0SIc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=a6siI/BKx9vAxBIkU5GgXFJV77sDWBUYzltsGmJ9zsaop684mK+FDDmKzrozr7WJH
	 U72eLtCHQs9bO02ORDsK3ktqfRZp4chZNItYv1CB3Rjdr5pQAz+ayBOxRYPsKdPT7d
	 wO/Zp1N0OPuu+evGaw0D+ipFg9noWFSVwLUv3ZeFeEZIY69Or1ggyQBe9HA8rY1Dlp
	 f/p4MduO0nqwUIs7YMP3NWV8bwOd1bQ2HlcAktqmyjNhrChO/XvzxQGlIGomsm65ct
	 LZlecWiQbkTilmb3/rlJ9QWSmag8MvoNIQ5t2u7h6vqfB+9gxQJC1haNwxXcX3i5dW
	 bLnTnHXSOMgqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DA2C021B0;
	Wed, 19 Feb 2025 09:27:05 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Subject: [PATCH 0/5] Driver for Apple ISP and cameras.
Date: Wed, 19 Feb 2025 10:26:56 +0100
Message-Id: <20250219-isp-v1-0-6d3e89b67c31@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOCjtWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0ML3cziAl3TlETDlKRk8xQTcyMloMqCotS0zAqwKdGxtbUAwv7hj1U
 AAAA=
X-Change-ID: 20250218-isp-5da1dbc7d472
To: Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org, imx@lists.linux.dev, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Asahi Lina <lina@asahilina.net>, 
 Eileen Yoon <eyn@gmx.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739957223; l=3672;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=pwGGm2Hm5mZhaIRDSeBjgUFdbUBMVkomGoaRRRL0SIc=;
 b=nvrbV1AEtw0ERqvWR3g+Y/OsdqGht+NJ9fo0RU0M70XuBvmPXcB3WJWvOmNNO0rWQafgXj7Ii
 Hpee0XOWX64Auuix7clIRjMzRrVaziNinC0Oe91ZTvLclhYM+ozLWho
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

Hi.

This series adds support for the camera and ISP system present
on Apple devices using M-series chips. This is a "simple" camera
and does not need any special userspace handling, everything
is handled by the firmware running on an ASC coprocessor.

Patches 1 and 2 add support for special handling neccesary for the
ISP power domains. The rest add the driver itself.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
Asahi Lina (1):
      pmdomain: apple: Add force-disable/force-reset

Eileen Yoon (2):
      media: apple: Add Apple ISP driver
      arm64: dts: apple: Add ISP nodes

Sasha Finkelstein (2):
      dt-bindings: power: apple,pmgr-pwrstate: Add force-{disable,reset} properties
      media: dt-bindings: Add Apple ISP

 .../devicetree/bindings/media/apple,isp.yaml       | 151 ++++
 .../bindings/power/apple,pmgr-pwrstate.yaml        |  10 +
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/apple/isp-common.dtsi          |  45 ++
 arch/arm64/boot/dts/apple/isp-imx248.dtsi          |  62 ++
 arch/arm64/boot/dts/apple/isp-imx364.dtsi          |  78 ++
 arch/arm64/boot/dts/apple/isp-imx558-cfg0.dtsi     | 101 +++
 arch/arm64/boot/dts/apple/isp-imx558.dtsi          | 102 +++
 arch/arm64/boot/dts/apple/t600x-die0.dtsi          |  48 ++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi     |   6 +
 arch/arm64/boot/dts/apple/t600x-pmgr.dtsi          |  81 ++
 arch/arm64/boot/dts/apple/t8103-j293.dts           |   6 +
 arch/arm64/boot/dts/apple/t8103-j313.dts           |   6 +
 arch/arm64/boot/dts/apple/t8103-j456.dts           |   6 +
 arch/arm64/boot/dts/apple/t8103-j457.dts           |   6 +
 arch/arm64/boot/dts/apple/t8103-pmgr.dtsi          | 118 +++
 arch/arm64/boot/dts/apple/t8103.dtsi               |  50 ++
 arch/arm64/boot/dts/apple/t8112-j413.dts           |   7 +
 arch/arm64/boot/dts/apple/t8112-j493.dts           |   6 +
 arch/arm64/boot/dts/apple/t8112-pmgr.dtsi          | 118 +++
 arch/arm64/boot/dts/apple/t8112.dtsi               |  50 ++
 drivers/media/platform/Kconfig                     |   1 +
 drivers/media/platform/Makefile                    |   1 +
 drivers/media/platform/apple/Kconfig               |   5 +
 drivers/media/platform/apple/Makefile              |   3 +
 drivers/media/platform/apple/isp/Kconfig           |  16 +
 drivers/media/platform/apple/isp/Makefile          |   3 +
 drivers/media/platform/apple/isp/isp-cam.c         | 414 ++++++++++
 drivers/media/platform/apple/isp/isp-cam.h         |  21 +
 drivers/media/platform/apple/isp/isp-cmd.c         | 635 +++++++++++++++
 drivers/media/platform/apple/isp/isp-cmd.h         | 692 ++++++++++++++++
 drivers/media/platform/apple/isp/isp-drv.c         | 586 ++++++++++++++
 drivers/media/platform/apple/isp/isp-drv.h         | 284 +++++++
 drivers/media/platform/apple/isp/isp-fw.c          | 770 ++++++++++++++++++
 drivers/media/platform/apple/isp/isp-fw.h          |  24 +
 drivers/media/platform/apple/isp/isp-iommu.c       | 251 ++++++
 drivers/media/platform/apple/isp/isp-iommu.h       |  20 +
 drivers/media/platform/apple/isp/isp-ipc.c         | 258 ++++++
 drivers/media/platform/apple/isp/isp-ipc.h         |  25 +
 drivers/media/platform/apple/isp/isp-regs.h        |  56 ++
 drivers/media/platform/apple/isp/isp-v4l2.c        | 900 +++++++++++++++++++++
 drivers/media/platform/apple/isp/isp-v4l2.h        |  16 +
 drivers/pmdomain/apple/pmgr-pwrstate.c             |  43 +-
 43 files changed, 6077 insertions(+), 6 deletions(-)
---
base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
change-id: 20250218-isp-5da1dbc7d472



