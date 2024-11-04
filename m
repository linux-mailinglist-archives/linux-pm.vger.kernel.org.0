Return-Path: <linux-pm+bounces-17005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598FC9BBE45
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 20:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932A61C20FD5
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 19:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D698E1CC899;
	Mon,  4 Nov 2024 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="i2R1XHVn"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74B523A6;
	Mon,  4 Nov 2024 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750066; cv=none; b=E8LPpYOPkobkmC/alC5KipYkYNhtve7CWNzuWBdX8hjaWOYm2y4IYStmj5dC8NwFKZutslE8I89yVajgLwjdULGeiRdnShT09Ic1NIPGwDfdZPcMmKd6kcoflETT3fMVK1F5xEkQylT9Sy29ENSPBfrPrPi/On61iIYXetmd49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750066; c=relaxed/simple;
	bh=XcxlVyk2RSruormQ40uCAg2WHwIJC0YqvJ6x7wf5Hn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsZOctPUQOo3hwsm3WG9dD+6KZ3vvwoGH7Uyv65Au8OWBQIR8j5MJcxiVviO1ymXHvvjONHOkA5eQXFeyVBYJySify5boicL2aJD5f4AsKwdYsZ3dfQRNTd8gyCtGp/jipxHhJOzwfJa0jKgaXh3evdrivXBXx8orU7OvM4EYjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=i2R1XHVn reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id a55bd3338b64d975; Mon, 4 Nov 2024 19:54:21 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 67113950B7B;
	Mon,  4 Nov 2024 19:54:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1730746461;
	bh=XcxlVyk2RSruormQ40uCAg2WHwIJC0YqvJ6x7wf5Hn4=;
	h=From:Subject:Date;
	b=i2R1XHVn09jcoSQFG8ZGQWjuJgTJ346GBsHyMRds1+QsqQgHK632rI2OdI1p45iYn
	 3Clstbbt6KBzK45OFhJEwPHae/wqVRXhEVt0ndVVeTLZiypAXbKXzu5SgtMcMhX9LN
	 wUH+0ImaXQxIguYvbP116b7vGbtNk7d7rTlxLVBXaoPsy1XzV/2PCVj0934ZxeSveS
	 MRUvHhNgNr6sJa7rEgO5pVG37JxJkWud4KMxAxky5of9xUQGkIapZpcG2IKMbrxhwz
	 zOWqJX2QbigKA30Fd6OUhDbobfbAY8IUKitlRl9VuCT3lBIOjiSxOX7JC+XolXbUwD
	 B3F+7dwynuEmA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject:
 [PATCH v1 2/2] cpufreq: intel_pstate: Update asym capacity for CPUs that were
 offline initially
Date: Mon, 04 Nov 2024 19:53:53 +0100
Message-ID: <1913414.tdWV9SEqCh@rjwysocki.net>
In-Reply-To: <12555220.O9o76ZdvQC@rjwysocki.net>
References: <12555220.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrihgtrghrughordhnvghrihdqtggrlhguvghrohhnsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 0; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 929ebc93ccaa ("cpufreq: intel_pstate: Set asymmetric CPU
capacity on hybrid systems") overlooked a corner case in which some
CPUs may be offline to start with and brought back online later,
after the intel_pstate driver has been registered, so their asymmetric
capacity will not be set.

Address this by calling hybrid_update_capacity() in the CPU
initialization path that is executed instead of the online path
for those CPUs.

Note that this asymmetric capacity update will be skipped during
driver initialization and mode switches because hybrid_max_perf_cpu
is NULL in those cases.

Fixes: 929ebc93ccaa ("cpufreq: intel_pstate: Set asymmetric CPU capacity on hybrid systems")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2275,6 +2275,11 @@ static void intel_pstate_get_cpu_pstates
 		} else {
 			cpu->pstate.scaling = perf_ctl_scaling;
 		}
+		/*
+		 * If the CPU is going online for the first time and it was
+		 * offline initially, asym capacity scaling needs to be updated.
+		 */
+		hybrid_update_capacity(cpu);
 	} else {
 		cpu->pstate.scaling = perf_ctl_scaling;
 		cpu->pstate.max_pstate = pstate_funcs.get_max(cpu->cpu);




