Return-Path: <linux-pm+bounces-11769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4105943614
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 21:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148F61C220CB
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 19:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857CB4084E;
	Wed, 31 Jul 2024 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="assU+0D1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582541396;
	Wed, 31 Jul 2024 19:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453215; cv=none; b=EaEOZ6IUCZVBYLK7OhHRVIQ6Gjz5TC9qXhG1pKfE/9XFBvYxNqQLMWNLf9cBsMAm48LpIzcBdCGJqhUUaTNCEzm8+Xns7toqKvG1V8aFnfmcRV/QzPLlgoRpczOK+kGn8esQ1SsEdIwBDtsVYIpqLRBDpx93i3mwkVEYZ0gAcVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453215; c=relaxed/simple;
	bh=sXfKPdSvD2xim8678B03Zbrmf3C5NmYf7KYIuKYHsoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bQlcHCMK4R6kioYji9O4VVATWd5mVKfnXAQ4T/UrybpA3qC979Ki5Ay0I8z59yyLtLUZEjxTA2sKCK3V26tj5SSDt9gb2HCS3TkNiZ7lGD2h3CMm9a24Mk9euf/mvcW1A8trWz0/gZgT6IC+l/pWxZEo9ocNYm7pJWptqWTj03s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=assU+0D1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A3BC116B1;
	Wed, 31 Jul 2024 19:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453214;
	bh=sXfKPdSvD2xim8678B03Zbrmf3C5NmYf7KYIuKYHsoA=;
	h=From:To:Cc:Subject:Date:From;
	b=assU+0D1YghzXsD+joyjA3vi6CzirGdiekQCGVFCwHkLtRIYEffmPn0VE9pkTLcIf
	 nGenEgRMNufXPB3RChqIQ14LmpOjfpNdeqnXPegXMIi+3q5cxTjBcGhxpF1/RMRpBn
	 kWr4HA3112qA6xrchcDYw13HLGcuF5V4f/bpaqatUVN08wHoY0j0LIzoSvXeJG0pOT
	 Te5mUnjsSF8WhBhx5FHwemCb/2Toeh3ciUXfpeMw2DZg4rtjufftUGiBYK05JlOfz8
	 vzVOMURc2wrTJSxxVV8Kmv2wn1cV3cCvb7taxlts4AL9SVew0DGzC1aeHhRGETpDPV
	 QuzoGThOJ9hkw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH] cpufreq: Use of_property_present()
Date: Wed, 31 Jul 2024 13:12:40 -0600
Message-ID: <20240731191312.1710417-2-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_present() to test for property presence rather than
of_(find|get)_property(). This is part of a larger effort to remove
callers of of_find_property() and similar functions. of_find_property()
leaks the DT struct property and data pointers which is a problem for
dynamically allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/cpufreq/cpufreq-dt.c           | 11 +++--------
 drivers/cpufreq/pmac64-cpufreq.c       |  2 +-
 drivers/cpufreq/sti-cpufreq.c          |  2 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c |  2 +-
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 6532c4d71338..983443396f8f 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -69,7 +69,6 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
 static const char *find_supply_name(struct device *dev)
 {
 	struct device_node *np __free(device_node) = of_node_get(dev->of_node);
-	struct property *pp;
 	int cpu = dev->id;
 
 	/* This must be valid for sure */
@@ -77,14 +76,10 @@ static const char *find_supply_name(struct device *dev)
 		return NULL;
 
 	/* Try "cpu0" for older DTs */
-	if (!cpu) {
-		pp = of_find_property(np, "cpu0-supply", NULL);
-		if (pp)
-			return "cpu0";
-	}
+	if (!cpu && of_property_present(np, "cpu0-supply"))
+		return "cpu0";
 
-	pp = of_find_property(np, "cpu-supply", NULL);
-	if (pp)
+	if (of_property_present(np, "cpu-supply"))
 		return "cpu";
 
 	dev_dbg(dev, "no regulator for cpu%d\n", cpu);
diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index 2cd2b06849a2..c87cd6e0b638 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -505,7 +505,7 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpunode)
 			continue;
 		if (strcmp(loc, "CPU CLOCK"))
 			continue;
-		if (!of_get_property(hwclock, "platform-get-frequency", NULL))
+		if (!of_property_present(hwclock, "platform-get-frequency"))
 			continue;
 		break;
 	}
diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index 8e2e703c3865..b15b3142b5fe 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -267,7 +267,7 @@ static int __init sti_cpufreq_init(void)
 		goto skip_voltage_scaling;
 	}
 
-	if (!of_get_property(ddata.cpu->of_node, "operating-points-v2", NULL)) {
+	if (!of_property_present(ddata.cpu->of_node, "operating-points-v2")) {
 		dev_err(ddata.cpu, "OPP-v2 not supported\n");
 		goto skip_voltage_scaling;
 	}
diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 95ac8d46c156..293921acec93 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -146,7 +146,7 @@ static bool dt_has_supported_hw(void)
 		return false;
 
 	for_each_child_of_node_scoped(np, opp) {
-		if (of_find_property(opp, "opp-supported-hw", NULL)) {
+		if (of_property_present(opp, "opp-supported-hw")) {
 			has_opp_supported_hw = true;
 			break;
 		}
-- 
2.43.0


