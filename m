Return-Path: <linux-pm+bounces-11939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D365949256
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 15:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C7C1F246FA
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 13:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405E91D6192;
	Tue,  6 Aug 2024 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSqez2L5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE861D54FB;
	Tue,  6 Aug 2024 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952715; cv=none; b=PEn1OXsD965BqDQcm9V9b+nNlPYZpYQcoc7otshDjnhIJuNPrEOyhC2coCRfVuPCM6No0dkCWCuVPjQIKJ5kaf/jNjk9YUgdn531v+h8StubwamPz0hrLkO/UQXptya5PW5gads84ZPTyhi0R1vSeE81lDODuNebRU6B9XjOPCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952715; c=relaxed/simple;
	bh=eFLcuGQoOEe4ylEhJQgrm8MjoBT93gbTRPgSUO7xFzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELZwNh6Js+53jkM3du/TGRBBHixsucTuk3fFR5DOswah0yAEKE4pxIAh0uszg404H7YUrMXZSIL00bA/0alRQeoYJJ4TBZN/Nknk58UqPNjPlAjB1YYZoo3+4H5P9RqxdPwAtV3/GX0k8tjxJlPck7qcGjjEKchOZ0QQLQzjJsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSqez2L5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EB4C4AF09;
	Tue,  6 Aug 2024 13:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722952714;
	bh=eFLcuGQoOEe4ylEhJQgrm8MjoBT93gbTRPgSUO7xFzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KSqez2L5/vgCuqgmZqBI7MSVyEGMmQgxT3dujmTWUQsbTC/iVkuYKKT7zi0n+Ohjb
	 0hlRxrHp6CQm0GpOrdboy2usp7v5JtT/sBiEhM0dB4bPgmPFadGuAU5rQYhm1iFdOF
	 miXMaomY/jFi1+4fnuJut61Ez1LmQBe1BIX5OSnzGihequf+7DdPkSrSfRuXJruXvt
	 sCOF3lhafNN74L4ib2LQ7l3ty0brnelAPFT8YWTF2phaLsWUPVX3N0TLy4JpTEbkPJ
	 EKgfk2Ekcv0Ts7KF6iy2CBJ/Xyfa+cr5e9/+u9vBn8Vn6Hl5v6m0dEaEqpylyA+fG9
	 EqOLdkrOAX4rA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 06 Aug 2024 07:58:22 -0600
Subject: [PATCH 1/6] cpufreq: qcom: Add explicit io.h include for
 readl/writel_relaxed
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-dt-api-cleanups-v1-1-459e2c840e7d@kernel.org>
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

The qcom-cpufreq-hw driver is relying on an implicit include of io.h
which doesn't get included on some architectures.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 370fe6a0104b..900d6844c43d 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/interconnect.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>

-- 
2.43.0


