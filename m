Return-Path: <linux-pm+bounces-23651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C22AA5724F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 20:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 492997A8E29
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C301F256C6C;
	Fri,  7 Mar 2025 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Qn79S/7u"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F07254AFD;
	Fri,  7 Mar 2025 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376572; cv=none; b=H+c1iwKXbC7EOcVAngtCy5PXO5/SO2HSJ6AJAoLzA9BSwnL8uk1EV/tim4RDWrXOHaldbrzfL06JuDQe1Z3VloX2ACTQcol44/AwbQNAtxhyhJ2bG84uPjJ/hQMrxTcZi2+nYYymo4DUjcjFZcrGJlNS5iVkGLpM/Q7wHD8wB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376572; c=relaxed/simple;
	bh=Ccjz8W1h/ZSWzpBW6Pli5ZjJF81V8/l4pL/JvHejhUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e12jHhyrR5mCpqqtJ/I20SS3H6I79W6A1QPtq2g3Ok25btu2Vw7Y2QW9Zw/boimB4aMzaam81s4FPLRn5o4BG5vgcOEk16gSjYJxJyuiSIRft/0LtNbcursmG95mtk8503Ssl3aufe17LEGbS/P36W0k2T6PUMXm0wGUv1dbF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Qn79S/7u; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id b980cc6cc07cbb7d; Fri, 7 Mar 2025 20:42:43 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7FED89A0BFB;
	Fri,  7 Mar 2025 20:42:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741376563;
	bh=Ccjz8W1h/ZSWzpBW6Pli5ZjJF81V8/l4pL/JvHejhUs=;
	h=From:Subject:Date;
	b=Qn79S/7u59JDTpIdC0OknBcLi+8B89MF3VItl4EYFVt+LQW31c0+2Efd7mNAJkFlN
	 1LerF2Rb49tqk1+zgbSWHo2Hw97lsvXCOJC5PrxWOh9hZN5tFxM40KVNFeIYI3BE5/
	 2vzJm83+TvpSsbkpg2/bYErFA0iGG5dJz0t9dRaNMcWAgG0RiYkgx+3xp3Ctqh9/yf
	 sfQjJA+GzCYlwd8gPt59pK1xaEncHrE32WlgJ8yV2ODPfOJBl35jTKipneRb+FUyF0
	 S+Iib2++eBvtyl5O4J+c9TD1y1clWjOv4D9gYcAfSKCTQNp7yjoSDlrEY7rUSQeNvq
	 3nEc1UznCiqhg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject:
 [RFC][PATCH v0.3 3/6] cpufreq/sched: Allow .setpolicy() cpufreq drivers to
 enable EAS
Date: Fri, 07 Mar 2025 20:16:13 +0100
Message-ID: <1940620.CQOukoFCf9@rjwysocki.net>
In-Reply-To: <22640172.EfDdHjke4D@rjwysocki.net>
References: <22640172.EfDdHjke4D@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some cpufreq drivers, like intel_pstate, have built-in governors that
are used instead of regular cpufreq governors, schedutil in particular,
but they can work with EAS just fine, so allow EAS to be used with
those drivers.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -3053,6 +3053,20 @@
 	return 0;
 }
 
+static bool cpufreq_policy_is_good_for_eas(struct cpufreq_policy *policy)
+{
+	/*
+	 * For EAS compatibility, require that either schedutil is the policy
+	 * governor or the policy is governed directly by the cpufreq driver.
+	 *
+	 * In the latter case, it is assumed that EAS can only be enabled by the
+	 * cpufreq driver itself which will not enable EAS if it does not meet
+	 * the EAS' expectations regarding performance scaling response.
+	 */
+	return sugov_is_cpufreq_governor(policy) || (!policy->governor &&
+		policy->policy != CPUFREQ_POLICY_UNKNOWN);
+}
+
 bool cpufreq_ready_for_eas(const struct cpumask *cpu_mask)
 {
 	int i;
@@ -3069,7 +3083,7 @@
 
 			return false;
 		}
-		policy_is_ready = sugov_is_cpufreq_governor(policy);
+		policy_is_ready = cpufreq_policy_is_good_for_eas(policy);
 		cpufreq_cpu_put(policy);
 		if (!policy_is_ready) {
 			pr_debug("rd %*pbl: schedutil is mandatory for EAS\n",




