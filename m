Return-Path: <linux-pm+bounces-30062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB42AF7AF0
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 17:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD964A480D
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E452EFDA9;
	Thu,  3 Jul 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dukQszSw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679B92EFD9A;
	Thu,  3 Jul 2025 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555530; cv=none; b=ceb45tYm2HEBG7edeOZbiP5cu7z1NNi6kmT4k8trcP/tEOvpgU6kYhioaBd2sgmReZwP4okCT764bjuC48u4srD6FuZk1MHzPNXmqgmgg1/yGOQ2JcHScWjPWDO203TU1R5wzzUeewFEJ9D6qVjfU3YDaogo8jkNwHoIEK4505Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555530; c=relaxed/simple;
	bh=zImvd/kgd1afrH/UXH2667AxFgtQy1j88l6X4nP2wM8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YI+wY2bJfn5Ll4KjOJLl+QHDRYbLagOAr1n6ASq8ayCNNGgNLKIflgzTsgoWQzqYa1vfU6c7wbc/6t7L+cNkfF2U+zDEfdSPQCDxvrEQ51TgeNs2IvMfY2tQSE3+JEvaIcxQjd3BTCsPudLoLcihr0QrlYIa5uflkNpqAAUQkgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dukQszSw; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-553dceb345eso31476e87.1;
        Thu, 03 Jul 2025 08:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751555527; x=1752160327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FklnJtDo9yeFD4xiZdN1VsVaoDfKdcDRiLzMHURLjos=;
        b=dukQszSwyyf0dWNR/FWT55M8sU7RzdjPcNqjwHTttppb40OdtJZQDJo94jEobdr3bQ
         0cU6SYK5tXx5BvIjZ3VFW3e5mTzURFRh2I6M6zxJfwGL1cjyegZM4t9gsjXcCr7mIB+c
         MYRz5Qgjajy4cZP2mo01GQ5zcHMuF2VsnM0wEZjnu9FjL9wm+GCPcaB1NEJ8samuHaPd
         k0xGvz7wa8nfsQh9ywrnqtMyTmqON7Zk1daNGHeyrrQq+n/WbvLJK5bon4OWfYobJssJ
         c+ZKiw0mltRRPzkFeSdem5HjvuqapIkoJh765u2mPKpu20g6LJdNtgj1wlii1H+7DI7g
         RDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751555527; x=1752160327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FklnJtDo9yeFD4xiZdN1VsVaoDfKdcDRiLzMHURLjos=;
        b=Z0/YouclRBHVW/YcOrH4/9RO6/xGqRzvMWk+H5eHgm3AlpJ2GImv18yDvmBF70tQl1
         Y1q0f6hjg0y/lN2Atm4YfqOW+oUsTMNoYguekQenTdcocwljSOgubHEd3GS/DU43Sidy
         3Z9ChcCLT4OuJyKARa6dH5xedbxad14ZWV+SPJbAxAXKU3PionQg4VUrVAa2xflxeIk8
         Xe94nfkMhX5UlYamEBYTzDCIpUO8cszcPe9w2L7dkMUMmDwcclCvI/hTCavy0zuo9uoX
         Ra5k4Bh5/Zk5VPRXHxR75oVBKOX8IThRYt0xuaADqStbX9moDBl2C64of5mu+LG7snHa
         RW+w==
X-Forwarded-Encrypted: i=1; AJvYcCWwF8JyPJ5LK+8upPMAWhpnlC0qkpsJF9rU0KkkSX1+UZxxldza0vp0AmRuJlkAU/SHGpvWc5/pUzM/lyQG@vger.kernel.org, AJvYcCXASotqKPJsWN5+OFeaOKtzUsDFzWLKicpyhLxuFsLx1Dk/69fQYZSZhSbFwNuCpJ7xXg8y0yRi77s=@vger.kernel.org, AJvYcCXPHgJY7Yaco3yaDIv+srEA5Mn97M2Cu0ORI4xoGWzgK15y5EPMfBrpP9/k5Wz9E25832PpmTiBknQj@vger.kernel.org
X-Gm-Message-State: AOJu0YyLg/s6ezsVKHsPhhCs6STzUudrlccfMdvs4+vzNJp1THUOmV3z
	9DA4UB0kcsWGguuaMwNOzYL8HlaJJQwaUrOyNIVZICbo2qLr+cBLUkBa
X-Gm-Gg: ASbGncuhggUX2sHvYpd+VweYQzUOQWrQHNcDl+3uCzW+/2EY2NmOBNE41QawsjqrLfB
	oqW8aWJ+wjdbPvPtn3ijIORDPCrte8ysR9TAWn2hylWsADQ8xuuw0ZkOsrpjzD1C3TYHVLSOY+F
	boeBj56DAY7NXzOPoQLrS6gq7O3MMLNwMDBFH0FManf7Zb2sT4TAib0NahzMFCGwHl7QwuIh5MM
	5nmIULaQN/Mb8hOgmuTWF1lgaTH8s9LxhEiiYXEjlO2XjqwQ7QkRWLQJiidVRZQScN8TbYxx/N5
	tW6RJI9hUjUYT8EsBIhF4clB+pGn9RKKe4pHleXbcTYZig8Aq/WWdz40g3vAmCn3uoher6k=
X-Google-Smtp-Source: AGHT+IFObnwk1CUw/4SeBMAwtqp40i0kVp9nyZ7PpPHlgqYkcRXB6haIqde1G0SGKx5hXuFwxxb7Og==
X-Received: by 2002:a05:6512:4025:b0:553:297b:3d4e with SMTP id 2adb3069b0e04-5562efc934fmr1450440e87.52.1751555526425;
        Thu, 03 Jul 2025 08:12:06 -0700 (PDT)
Received: from localhost.localdomain ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384ae15esm725e87.178.2025.07.03.08.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:12:06 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/8] Allwinner: A523: add support for A523 THS0/1 controllers
Date: Thu,  3 Jul 2025 23:11:24 +0800
Message-ID: <20250703151132.2642378-1-iuncuim@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

This patch series adds temperature sensor support for the Allwinner A523
family of processors (same die with H728/A527/T527)

Changes:
1) dt-bindings: nvmem: SID: Add binding for A523 SID controller
 - added new patch

2) dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
 - changed clock order
 - added additional nvmem cell with calibration data
 - added requirements for new controllers
 - added description

3) thermal/drivers/sun8i: add gpadc clock
 - removed unnecessary call to clk_prepare_enable() since
 devm_clk_get_enabled()includes this

4) thermal/drivers/sun8i: replace devm_reset_control_get to
 - original function replaced with devm_reset_control_get_shared_deasserted()
 - removed some of the repetitive code executed by 
 devm_reset_control_get_shared_deasserted()

5) thermal/drivers/sun8i: get calibration data from two nvmem cells
 - added possibility to get calibration data from two independent cells

6) thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
 - removed magic digits
 - changed description of calibration data procedure for A523
 - changed numbers of array elements with calibration data

7) arm64: dts: allwinner: A523: Add SID controller node
 - fix typo (sun50i->sun55i)

8) arm64: dts: allwinner: A523: Add thermal sensors and zones
 - cell with calibration data divided into two
 - added passive trips for gpu
 - added information that information obtained from BSP

v1: https://lore.kernel.org/linux-sunxi/20250411003827.782544-1-iuncuim@gmail.com

Mikhail Kalashnikov (8):
  dt-bindings: nvmem: SID: Add binding for A523 SID controller
  dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
  thermal/drivers/sun8i: add gpadc clock
  thermal/drivers/sun8i: replace devm_reset_control_get to
    devm_reset_control_get_shared_deasserted
  thermal/drivers/sun8i: get calibration data from two nvmem cells
  thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
  arm64: dts: allwinner: A523: Add SID controller node
  arm64: dts: allwinner: A523: Add thermal sensors and zones

 .../nvmem/allwinner,sun4i-a10-sid.yaml        |   1 +
 .../thermal/allwinner,sun8i-a83t-ths.yaml     |  49 +++-
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 162 ++++++++++++
 drivers/thermal/sun8i_thermal.c               | 240 ++++++++++++++----
 4 files changed, 406 insertions(+), 46 deletions(-)

-- 
2.49.0


