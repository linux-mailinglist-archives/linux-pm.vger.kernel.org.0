Return-Path: <linux-pm+bounces-15598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4625199C246
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 09:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09588281D6E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 07:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294D314AD2E;
	Mon, 14 Oct 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="o/24iZFK";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="kUgnqLhc"
X-Original-To: linux-pm@vger.kernel.org
Received: from bayard.4d2.org (bayard.4d2.org [5.78.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D465E13DB9F;
	Mon, 14 Oct 2024 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892698; cv=none; b=OIavXJGcwDmi+XS9EAc/xapPB00y62LvLASXpJEdVach1eSvmaXTx6Aib87H8AW03Oz+07s5MqUFO3XrkKOeSKaerclGUII9eUHNC3sCZ79dxk6Djx1hUJ6Fv5iE8TNkwasB+A57vJC82vkclRG7XpCSj8sYd5k3pTJil3geBYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892698; c=relaxed/simple;
	bh=Zh8qbVVIX7EsBpJFG/gcKYvAuggerEXcwlv2jiDrPbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jp0J0FFts4y42LzBokqrWn1fI6AiNnBfrW/OJgdpKF1oVP/ANGmp7GtIr0SMAi6/Ip0+S2CSgroleFT34KVcWnOi9apWR3gDaRM+OKprT0NlA8xWHdv8fpGxOmA6bON8RDfH7+ufNh5NKI3tHsEMtKPjqEMZ30AKoajJx4Wa8Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=o/24iZFK; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=kUgnqLhc; arc=none smtp.client-ip=5.78.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 92879122FE22;
	Mon, 14 Oct 2024 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1728891520; bh=Zh8qbVVIX7EsBpJFG/gcKYvAuggerEXcwlv2jiDrPbs=;
	h=From:To:Cc:Subject:Date:From;
	b=o/24iZFKJYmLwlXVRJ+jgYXwoiyWYJRHJJHsujVOfVJAv1AVOh35NDNLmhdrNlLbw
	 kAuYbb/hHepa1GDILnyYD9oJuAwVLyzwPkBvJZ2tLdSEQqNcYBcZbXSpHQuj42NV0b
	 gG2O/iT25gp69DINZVj8+Anq9IWcNHrNdfmBHC1ibOugVRrZdjFPaL7gCVTf1jLhaY
	 0TsW6lf131cL9B0w4imX68R265tudazjKgsKU0PjwSLJdk7E4eovQFLmStuXxpyTwr
	 OELtuxhle4mmtf5PwSRgI6p7FEuUsxuoAKLsfgcm0PKW+06HTQkTAaohKrO/3EYNk3
	 JSvfkObdP0fHg==
X-Virus-Scanned: amavisd-new at 4d2.org
Authentication-Results: bayard.4d2.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I1NoHwtUyw32; Mon, 14 Oct 2024 00:38:38 -0700 (PDT)
Received: from localhost.localdomain (unknown [110.52.220.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 531B7122FE1E;
	Mon, 14 Oct 2024 00:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1728891518; bh=Zh8qbVVIX7EsBpJFG/gcKYvAuggerEXcwlv2jiDrPbs=;
	h=From:To:Cc:Subject:Date:From;
	b=kUgnqLhc0j+qgIaHSDUxoQLC0f0+/URJuqxRQbc7ofvAhqYAC8wMXLapSmbc8RjQ3
	 Gf2jIONH02Rn0TpDVp5DsamsyyDRliDEHxtEvfcIf8jgdwVGfn2rYLZJdyARnb8ekj
	 NtG6M/pJg5G2Jc/aSulzYiuTIX3dDBXFXvfxqtLYw9w44bCl7FwHh1RrqTChC2nLdH
	 geoM79FZ1izrDy/PMAGWoAGUghQFNEoTTOdamXqSExcYg/M0d4pkJsZuxDEn7o0VED
	 FjLhew2QRG6Uvehl2VwuvSumyupHlD7RxWNnAzolv8YP0C4VyNob4cZvxj1UEsdidt
	 gnTG9/w9T/ypg==
From: Haylen Chu <heylenay@4d2.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Haylen Chu <heylenay@4d2.org>
Subject: [PATCH v5 0/3] riscv: sophgo: add thermal sensor support for cv180x/sg200x SoCs
Date: Mon, 14 Oct 2024 07:38:10 +0000
Message-ID: <20241014073813.23984-1-heylenay@4d2.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements driver for Sophgo cv180x/sg200x on-chip thermal
sensor and adds thermal zones for CV1800B SoCs.

Changed from v4:
1. support temperature threshold violation interrupts
2. completely switch codename to cv1800
3. style improvements
4. update e-mail address
Link: https://lore.kernel.org/all/SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com/

Changed from v3:
1. style improvments
2. drop unnecessary dt parameters for simplicity
Link: https://lore.kernel.org/all/SEYPR01MB42213F3A032C60C6AF5EB677D7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com/

Changed from v2:
1. style and code improvements
2. use human-readable value for sensor parameters
Link: https://lore.kernel.org/all/SG2PR01MB4218013241B3EED779D3BAE8D7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com/

Changed from v1:
1. style and code improvements
2. make sample parameters configurable
3. generalize document temperature calculating formula
Link: https://lore.kernel.org/all/SEYPR01MB422119B40F4CF05B823F93DCD7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com/

Haylen Chu (3):
  dt-bindings: thermal: sophgo,cv1800-thermal: Add Sophgo CV1800 thermal
  thermal: cv1800: Add cv1800 thermal driver support
  riscv: dts: sophgo: cv18xx: Add sensor device and thermal zone

 .../thermal/sophgo,cv1800-thermal.yaml        |  57 ++++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |  28 ++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |   8 +
 drivers/thermal/Kconfig                       |   6 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/cv1800_thermal.c              | 296 ++++++++++++++++++
 6 files changed, 396 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
 create mode 100644 drivers/thermal/cv1800_thermal.c

-- 
2.46.2


