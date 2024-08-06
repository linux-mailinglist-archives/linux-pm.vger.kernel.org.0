Return-Path: <linux-pm+bounces-11938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3374A949251
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 15:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654961C2151B
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 13:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44391D47AD;
	Tue,  6 Aug 2024 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od5noi1n"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEB016B741;
	Tue,  6 Aug 2024 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952713; cv=none; b=Sx0ZEz3yor5R45jMWxzDeeA62BU3ge1NTFr1UTEmPBQQ6SVJv4Ejtx1AbHCEQEjcFnM6PIq798yhCHuFX+8tIUP1QWSbq0A/mtc5B4FHlX1FPKL4kHf4xm1h81PiRYnVGEsKRxsr0GtIavvwxsJAtbHLvDlRA26Boc2rE1tozpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952713; c=relaxed/simple;
	bh=FDPuG2fv6Xq0Fg2WDMvyb/wONCwU5IRwYfqCsKckIVk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BQt/5Zvijih5Hz3xQ/+QTjuIXgPkXliI2lU2j1VMWh0uA30S1ia2ljJqczL8/Ou5ojjlly/sWzY7nrwNMYgbPolYo6YDtQr+U/JIOd6tuO2S29iILfmthOVXYEX52CKD0CnN06Rnyla5WaTgT+DHxF4qwEMFB/JGQAT/Lbjd9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od5noi1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F89C4AF09;
	Tue,  6 Aug 2024 13:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722952713;
	bh=FDPuG2fv6Xq0Fg2WDMvyb/wONCwU5IRwYfqCsKckIVk=;
	h=From:Subject:Date:To:Cc:From;
	b=Od5noi1nlh/IN50c8KsqWutvIm/aZ3IDehou3CK6tIZsxV+dYAnXoJoHOPHzFBc3o
	 fiLZM0Jm3TE7/iY1MvsKk+LPFt8gA3FIlBoD1EYoUgscPRZwAICh3WQl9iTCm3yy32
	 UQLdldikBWgXn2LGH83dhSrKl8pfmRovJJg4q3lYloeYt8U23lgn2RiEoyIIa40t0u
	 8ehDxee087Jd010/6qnRJ5mr/fvJqSLfj0EhQkpcPiU4wztR6jc7QW8yID8u4dYX6j
	 t3sfdlBQN/73UVZSrDQWJ4+k7VbDVamifv5V5l9hM3Lwqca/9c7Ezc2vopH8dplleJ
	 WguIHv1ih1XBQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 0/6] cpufreq: Enable COMPILE_TEST on Arm drivers
Date: Tue, 06 Aug 2024 07:58:21 -0600
Message-Id: <20240806-dt-api-cleanups-v1-0-459e2c840e7d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP0rsmYC/x3MTQqAIBBA4avErBswfyK6SrSwnGogTLQikO6et
 PwW72VIFJkS9FWGSDcnPnxBU1cwb9avhOyKQQqpRScMuhNtYJx3sv4KCV2raNKLUVoqKFWItPD
 zH4fxfT+Hm0qdYQAAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Kevin Hilman <khilman@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev

This series enables building CPUFreq Arm based drivers on multiple 
architectures when COMPILE_TEST is enabled.

The drivers for x86 and powerpc appear to be dependent on the 
respective arch code, so those can't be similarly enabled for 
COMPILE_TEST.

I've built this on arm32, arm64, powerpc, and x86 allmodconfig. It's 
been built by 0-day and I fixed a couple of issues from that. I imagine 
a few more might crop up when this is added to linux-next.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Rob Herring (Arm) (6):
      cpufreq: qcom: Add explicit io.h include for readl/writel_relaxed
      cpufreq: omap: Drop asm includes
      cpufreq: armada-8k: Avoid excessive stack usage
      opp: ti: Drop unnecessary of_match_ptr()
      cpufreq: Enable COMPILE_TEST on Arm drivers
      cpufreq: Drop CONFIG_ARM and CONFIG_ARM64 dependency on Arm drivers

 drivers/cpufreq/Kconfig             |  2 --
 drivers/cpufreq/Kconfig.arm         | 50 ++++++++++++++++++++++---------------
 drivers/cpufreq/armada-8k-cpufreq.c |  2 +-
 drivers/cpufreq/omap-cpufreq.c      |  3 ---
 drivers/cpufreq/qcom-cpufreq-hw.c   |  1 +
 drivers/opp/ti-opp-supply.c         |  2 +-
 6 files changed, 33 insertions(+), 27 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240805-dt-api-cleanups-d63eb4f53423

Best regards,
-- 
Rob Herring (Arm) <robh@kernel.org>


