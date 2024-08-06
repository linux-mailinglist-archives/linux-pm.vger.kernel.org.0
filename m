Return-Path: <linux-pm+bounces-11944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAC794926A
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 16:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160191F25BD1
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C34A20FAAC;
	Tue,  6 Aug 2024 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbCYReMc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3C520FAA7;
	Tue,  6 Aug 2024 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952722; cv=none; b=i1ZrypXBnRvbFF/wsKTXYrd+/BHkvNhPmqt4fu16p9R2aVkais2wRs1JJRGpJV/iN6zCzQQSFd5zKCvXMzSBIvju/zLO1c2vcr8A5ptli05q38OteV7Q4kQkWbRqJ0f8VyvVJHdqEB6zixnIpMUlNePfCSpMR0fyX1qkef0CRuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952722; c=relaxed/simple;
	bh=QVK/Q63Ty0/vwxPdFAgX18Uk2bo2WKZpj8mNx7zlTHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CSL9eBPcwvLVNcydEX4X03ie7cLGe5cs76Lqq0sQrIG0CpAn/740g3IE7uiZ01adL9rCCM5K0f62qb8V4LDjEB34bkCAlFh6kBeKAn5zLh6HcngXzHjJ/Z4hyvxwhX5PBFpxbFHMUOGxkKlrEw+XZHRLIAQ8wE2Yure9YpWDn8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbCYReMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94282C4AF0C;
	Tue,  6 Aug 2024 13:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722952721;
	bh=QVK/Q63Ty0/vwxPdFAgX18Uk2bo2WKZpj8mNx7zlTHc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jbCYReMcMawvrLpAIbnexeTNTcymVDfvKVkaJwm/Q6k05IkKTjBMAiGl5tfYS97Iw
	 TAIYX9dNQKL2phosPWx/IDuJeLe5KCqCJJipdY/YFSwnmA3HjSYBUS0HuQeTu8+5uG
	 P7ESMF0RWFOTkM/OxeSNjA8NCTyb7HUop0bWUqklYfw7iUJXRzgBx7K2UYG87Onu/G
	 +CtVPglMQVDfxic57yKqPa2C4L2SjT52OPeiaVnz3du2sQbfliIhO/R9lNjwVh8E5/
	 eevLw9L3uk9sC8aHm998zlBCX833LS2+nhS9xRv+4dlD4nAJfCM1qN9k4DpQTq6jum
	 Y4p7rszyDraeQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 06 Aug 2024 07:58:27 -0600
Subject: [PATCH 6/6] cpufreq: Drop CONFIG_ARM and CONFIG_ARM64 dependency
 on Arm drivers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-dt-api-cleanups-v1-6-459e2c840e7d@kernel.org>
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

The CONFIG_ARM and CONFIG_ARM64 dependency is redundant as all the
drivers have necessary sub-arch dependency and don't depend on the
architecture support.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/cpufreq/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 10cda6f2fe1d..2561b215432a 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -231,9 +231,7 @@ if X86
 source "drivers/cpufreq/Kconfig.x86"
 endif
 
-if ARM || ARM64
 source "drivers/cpufreq/Kconfig.arm"
-endif
 
 if PPC32 || PPC64
 source "drivers/cpufreq/Kconfig.powerpc"

-- 
2.43.0


