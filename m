Return-Path: <linux-pm+bounces-27237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF923ABA2E4
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 20:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0F01C0384E
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DA627F19B;
	Fri, 16 May 2025 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="W/oE5SRz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D7327A12D;
	Fri, 16 May 2025 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420183; cv=none; b=eGVgijTcT7VayT6NIlOWNA2an50xMgcMjjgOoG0v514oTG8GLJY4E3gzAz2K28Cimjeg4U1x4civPpKY1o0t8eK7sZnEBaRakfaVj6831N+7p5zErMjqGTk6EfsXYsSdWSLlFBMV/B/WyapAFr0nzFVXrfgl6HG0L8TUwzxFTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420183; c=relaxed/simple;
	bh=4zzkMuAkdOu+W/FfqNTZRI/W+u0p/y15oHql9BpsK8E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eulgnZkc0/V7i2bti8e62LN7Au6EZQ6yIkS1LpSy9w8Y3r4yFyrVFXl1kT3Dq0874Gi4e65i9rCKqYEa4w/AMqHRBgwBOKI2gg5rQRMoArCi5vYgEqXmKh9mDXgpK8bHJsV/q1WlrgU+9wBvsjOIo1yzXfwccSM3GT2MbU74OM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=W/oE5SRz; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1C6C69C8E1D;
	Fri, 16 May 2025 14:29:39 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id PCbH_wvc2fc9; Fri, 16 May 2025 14:29:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 831FD9C8DB5;
	Fri, 16 May 2025 14:29:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 831FD9C8DB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1747420178; bh=DLFQAbS2Kkiyq94KoakjX8pyAd/UxyLLg1wnyLzv0wU=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=W/oE5SRzPvBArGS1YBG267e4vXhddpcwKe0ifOxp8PunEA+8BljjqOSTndtfjG40b
	 nkwgw2imxOfsJ7VIjUGEUTF0lji6b/tJInRPAIZ2IHcH6lX8JtHqFzVoykXIcfcenM
	 C2ULAK8hEjKWuSUFtpfyhq9DaYivuMKg0JFKuDWYAzxRYjyE/rxbHCKL5YwGwI6TjB
	 /xNYE0UfV3ZNMP04hiZ+YBK8VwLsmKtU3Abl+XOUarEcGFNmTWJGdnKiTYyWSa6C2B
	 crb7zO5eHU/2OtVk6eqNBWjmQ3926J6TgPtXQG9ipyImYAwFunTSgWMH6iq15gnxhS
	 kJwSkI1IsSzNA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id SkOW1hFp7rD3; Fri, 16 May 2025 14:29:38 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 2BE0C9C0D9F;
	Fri, 16 May 2025 14:29:38 -0400 (EDT)
Date: Fri, 16 May 2025 14:29:37 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Robin Gong <yibin.gong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-imx@nxp.com, linux-input@vger.kernel.org,
	Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>,
	Robin Gong <b38343@freescale.com>,
	Enric Balletbo Serra <eballetbo@gmail.com>
Subject: [PATCH v2 0/9] add support for pf1550 PMIC MFD-based drivers
Message-ID: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series adds support for pf1550 PMIC. It provides the core mfd driver and a
set of three sub-drivers for the regulator, power supply and input subsystems.

Patches 1-4 add the DT binding documents. Patches 5-8 add all drivers. Last
patch adds a MAINTAINERS entry for this device.

Changes since v1 [1]:
   1. DT bindings for all devices included
   2. Add onkey driver
   3. Add driver for the regulators
   4. Ensure charger is activated as some variants have it off by default
   5. Update mfd and charger driver per feedback from eballetbo@gmail.com
   6. Add myself as maintainer for these drivers

[1]: v1: https://lore.kernel.org/1523974819-8711-1-git-send-email-abel.vesa@nxp.com/

Samuel Kayode (9):
  dt-bindings: power: supply: add pf1550
  dt-bindings: regulator: add pf1550
  dt-bindings: input: add pf1550
  dt-bindings: mfd: add pf1550
  mfd: pf1550: add core mfd driver
  regulator: pf1550: add support for regulator
  input: pf1550: add onkey support
  power: supply: pf1550: add battery charger support
  MAINTAINERS: add an entry for pf1550 mfd driver

 .../bindings/input/pf1550_onkey.yaml          |  31 +
 .../devicetree/bindings/mfd/pf1550.yaml       | 122 ++++
 .../bindings/power/supply/pf1550_charger.yaml |  44 ++
 .../devicetree/bindings/regulator/pf1550.yaml |  35 +
 MAINTAINERS                                   |  11 +
 drivers/input/keyboard/Kconfig                |   8 +
 drivers/input/keyboard/Makefile               |   1 +
 drivers/input/keyboard/pf1550_onkey.c         | 200 ++++++
 drivers/mfd/Kconfig                           |  14 +
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/pf1550.c                          | 254 +++++++
 drivers/power/supply/Kconfig                  |   6 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/pf1550_charger.c         | 656 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   7 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/pf1550.c                    | 380 ++++++++++
 include/linux/mfd/pf1550.h                    | 246 +++++++
 18 files changed, 2019 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/pf1550_onkey.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/pf1550.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/pf1550_charger.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/pf1550.yaml
 create mode 100644 drivers/input/keyboard/pf1550_onkey.c
 create mode 100644 drivers/mfd/pf1550.c
 create mode 100644 drivers/power/supply/pf1550_charger.c
 create mode 100644 drivers/regulator/pf1550.c
 create mode 100644 include/linux/mfd/pf1550.h


base-commit: b1d8766052eb0534b27edda8af1865d53621bd6a
-- 
2.49.0


