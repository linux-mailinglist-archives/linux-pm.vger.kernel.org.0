Return-Path: <linux-pm+bounces-11940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF1B94925A
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 15:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE83D281D28
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 13:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CA91EA0DF;
	Tue,  6 Aug 2024 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="av06cCPX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC6D1EA0CD;
	Tue,  6 Aug 2024 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952716; cv=none; b=pvHOE+sik5nHhDF5c9JyhsMnUKIbku3Am2UP1aztD/i84NJOzaEC2Odf7gonFxXEkJbEs5nGYpm2h3ahdRBhummEGcVR5iLkAmcr+0oVL7PWufkVzVSzpm6cLwCWJtqbVSv0RKpUx+a0gpiQiHenKHGN2Jq4w9ZPAWkHOf3//iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952716; c=relaxed/simple;
	bh=O6glnD5wiXE98gLVRHUvmVB4RVvcHr0FDiaVdLjF2KY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XLXFsdwhLl48mBvFaigVZfi3r5g98tCkJlTn4+gfZD8f2XrOku4sW/WcJNbWWf9hyix3ZTSgg3hWHvcqbEP+oeI16qQTG2IHHrUoTKtjsjTGkzduQgX4S7HxQ3NnYn4sqm+pSESw2B/3zcRBqSGzKeOAW8IdNfaXIn4GkVnbTXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=av06cCPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0705C4AF11;
	Tue,  6 Aug 2024 13:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722952716;
	bh=O6glnD5wiXE98gLVRHUvmVB4RVvcHr0FDiaVdLjF2KY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=av06cCPXNd155wv3Dvm0kSw7gTCjsITJkQX/nsGcdomek8+59kQHT7GpPHxxpiaDQ
	 JqoOTWzROUPqSw5DkvvjiNiC4wEZf5h2zzIbUyALL63Us5ll5RBU/GykKsDgKOpgvD
	 9sUW88m2daFuDyiz+ltZ4oCgbd/CmpAAiVxpIIHzdy3xdJ7GGzfg+jJfAODou/hGiI
	 2XdQ9G7sS89kPK4Ygy0CnrOQAjdzI1MxM7qAc7eGzbKyNh5qDk0gyYN7lmq/JbFf09
	 oqsCuCIv5I2fRFoLMjvJaMC8JevL5TSPyEBpymz8EMB/TRRb3MTsxc0hzRzJlOnBlr
	 IKcIZ2qAKCuoQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 06 Aug 2024 07:58:23 -0600
Subject: [PATCH 2/6] cpufreq: omap: Drop asm includes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-dt-api-cleanups-v1-2-459e2c840e7d@kernel.org>
References: <20240806-dt-api-cleanups-v1-0-459e2c840e7d@kernel.org>
In-Reply-To: <20240806-dt-api-cleanups-v1-0-459e2c840e7d@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Kevin Hilman <khilman@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev

The omap driver doesn't actually need asm/smp_plat.h, so drop it.
asm/cpu.h is not needed either as linux/cpu.h is already included.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/cpufreq/omap-cpufreq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 3458d5cc9b7f..de8be0a8932d 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -28,9 +28,6 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
-#include <asm/smp_plat.h>
-#include <asm/cpu.h>
-
 /* OPP tolerance in percentage */
 #define	OPP_TOLERANCE	4
 

-- 
2.43.0


