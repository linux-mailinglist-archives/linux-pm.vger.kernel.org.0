Return-Path: <linux-pm+bounces-24591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1107FA751E8
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 22:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D53816DBAD
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 21:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181A91E25E3;
	Fri, 28 Mar 2025 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="G6+ixo2L"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5AE14D70E;
	Fri, 28 Mar 2025 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743196433; cv=none; b=vCwyTYkj3duz+9+nd70TrWLrPK4A/Gsh5ysQbeKiWBAqox4RknzSn32m/2764dbarZEnmoHxykGJDsqaXPcHrrumSppPp4MkIdvUvupYgUYcR1+ZYdxKuu4edsn1A9JZCPDKVuNgHR2Ije2PKYRhF4oVN6llMVpffsNyOw1bscs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743196433; c=relaxed/simple;
	bh=p5Df4PURRw65SjKz6+ZMGwypp6nJFyA5a6I6Dzb3x8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qahsL6sFuhTE69Le6FLSladAAZnlQDCF9WIUEKyM6jPQFGunzWb5hipyXydMDWIKJ/HSHjL6BA2PXhuObr2lQOjVE8KNcB03lj+tIJAzoi0YFDvGkQKmMfeWjSNEnwZ2kmkQLTCfonE+TWf6HTUwyZZshJ2QstkElsKMAzEPWAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=G6+ixo2L; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id fa18045ec01f91f2; Fri, 28 Mar 2025 22:13:49 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id BA98F7F0283;
	Fri, 28 Mar 2025 22:13:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743196429;
	bh=p5Df4PURRw65SjKz6+ZMGwypp6nJFyA5a6I6Dzb3x8o=;
	h=From:Subject:Date;
	b=G6+ixo2L7lnvqtOZ8WRbaRDTreD/aiVeBzEaec1kIqz42vsfcnR1ri3hy1D/1Irdc
	 8TqxoLXiT72PFHw5wFiDGNdwlYeCOhrorTtVMYGhIP03NjK7ISwrs4lfU2d9950UAn
	 t2waw+TsV+MLsDJman8kP9vCEMmfNyF/gk+Tj8fEfpgjFwuvYfur0dause59kTwZ+x
	 1o0fxqGvHOdNINc2F58qbus0ZwYcb5iDUIUOdVV6gBFYLLSvF5UP0deussJk1rsJcY
	 o90HnguHYqP8lbWvbd8NT0kGTSoYQFC416w7foe9Ph7sGC4e2+wA7usWZfxo2Q/0Kq
	 awYCOSGv4YbXw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v1 02/10] cpufreq: Consolidate some code in cpufreq_online()
Date: Fri, 28 Mar 2025 21:40:43 +0100
Message-ID: <13741234.uLZWGnKmhe@rjwysocki.net>
In-Reply-To: <4651448.LvFx2qVVIh@rjwysocki.net>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
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
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=72 Fuz1=72 Fuz2=72

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that the policy->cpu update in cpufreq_policy_alloc() can be
moved to cpufreq_online() and then it can be carried out under the
policy rwsem, along with the clearing of policy->governor (unnecessary
in the "new policy" code branch, but also not harmful).  If this is
done, the bottom parts of the "if (policy)" branches become identical
and they can be collapsed and moved below the conditional.

Modify the code accordingly which makes it somewhat easier to follow.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1306,7 +1306,6 @@
 	init_waitqueue_head(&policy->transition_wait);
 	INIT_WORK(&policy->update, handle_update);
 
-	policy->cpu = cpu;
 	return policy;
 
 err_min_qos_notifier:
@@ -1394,17 +1393,18 @@
 
 		/* This is the only online CPU for the policy.  Start over. */
 		new_policy = false;
-		down_write(&policy->rwsem);
-		policy->cpu = cpu;
-		policy->governor = NULL;
 	} else {
 		new_policy = true;
 		policy = cpufreq_policy_alloc(cpu);
 		if (!policy)
 			return -ENOMEM;
-		down_write(&policy->rwsem);
 	}
 
+	down_write(&policy->rwsem);
+
+	policy->cpu = cpu;
+	policy->governor = NULL;
+
 	if (!new_policy && cpufreq_driver->online) {
 		/* Recover policy->cpus using related_cpus */
 		cpumask_copy(policy->cpus, policy->related_cpus);




