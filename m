Return-Path: <linux-pm+bounces-27044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376BBAB38BD
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 15:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F86E460D6E
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757FF293B70;
	Mon, 12 May 2025 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="NHtBkkYQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD0FAD58;
	Mon, 12 May 2025 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056221; cv=none; b=DvD1OYXuRDUxPlV+YA04omjdyLtyDdbIZ7vHkqan/DSGtYFxaxAg6pGwLCqD6pPG4aULl1znRckkx8/GNX/Ig5mJQ1wIO6vNJsSVbLARx1nrvCU2FtVx2NBD8QYbAjz9WuhbjR6/pIyCaAEJCouVsSwqO9zW9/C4ltBS3EK3QNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056221; c=relaxed/simple;
	bh=cBwH3AMY+j1loh80XQyMwRSXd1cJWPgyALHwqOGeA3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itdBl2Yua3u5o2hizM2m9ImEH95F32Z/3M6n1BJLg/UwDRBZG7hjDyc14b+e0BfY8+EWfbovCNqILqQdlJZ/msswY3qNSgA+A/Hc85s+6jVJrZTPOsLQMBFMnOSza+fG8LpXdV3kHQhcMeNbrohdSWEsHQCuTvTDUOEuxirrYAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=NHtBkkYQ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5F8BD666D2F;
	Mon, 12 May 2025 15:23:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1747056210;
	bh=cBwH3AMY+j1loh80XQyMwRSXd1cJWPgyALHwqOGeA3w=;
	h=From:Subject:Date;
	b=NHtBkkYQR2Eu20UISoxPZJzBoTVe46L8yX4VpfLN4xmlOef1/YSG81DwTV0GlCJ1y
	 MxnydAazwwCCMw46LTn7XVqOGh8d3F1fXEgkkRx5pithF89eQxBKblRG7NWaOlmACv
	 btCUKU0vJhpd1k5vc2KiKFjIHNii42dsR2YLzLk4lvvyrXCrtnIXaexRnUSY48ylT0
	 6GMs40dcka8mBfR6IFXz/pJHIGSsHLYJu5CXfOg9zTaNZ406oNvQpiSKvNnP4SR4sn
	 pE0qD+zuwU5ERzhpvcjr2T5Ip63UcetZILpu8H0tmoBYOdHiVnKJVUqLRoE4GJHKCE
	 f8wvRvdxyUjbQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject:
 [PATCH v1] cpufreq: Drop policy locking from cpufreq_policy_is_good_for_eas()
Date: Mon, 12 May 2025 15:23:30 +0200
Message-ID: <2806514.mvXUDI8C0e@rjwysocki.net>
In-Reply-To: <3344336.aeNJFYEL58@rjwysocki.net>
References: <3344336.aeNJFYEL58@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddufeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopeguihgvthhmrghrrdgvghhgvghmrghnnhesrghrmhdrtghomhdprhgtphhtthhopehrihgtrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Policy locking was added to cpufreq_policy_is_good_for_eas() by commit
4854649b1fb4 ("cpufreq/sched: Move cpufreq-specific EAS checks to
cpufreq") to address a theoretical race condition, but it turned out to
introduce a circular locking dependency between the policy rwsem and
sched_domains_mutex via cpuset_mutex. This leads to a board lockup on
OdroidN2 that is based on the ARM64 Amlogic Meson SoC.

Drop the policy locking from cpufreq_policy_is_good_for_eas() to address
this issue.

Fixes: 4854649b1fb4 ("cpufreq/sched: Move cpufreq-specific EAS checks to cpufreq")
Closes: https://lore.kernel.org/linux-pm/1bf3df62-0641-459f-99fc-fd511e564b84@samsung.com/
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -3067,8 +3067,6 @@
 		return false;
 	}
 
-	guard(cpufreq_policy_read)(policy);
-
 	return sugov_is_governor(policy);
 }
 




