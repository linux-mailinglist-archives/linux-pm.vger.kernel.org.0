Return-Path: <linux-pm+bounces-20973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1576AA1D6FB
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 14:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F54D16508D
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0EF1FF7C9;
	Mon, 27 Jan 2025 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="DrkXsmy7"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E681FDA84;
	Mon, 27 Jan 2025 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737985119; cv=none; b=O2jyGC+zKki01vpfF1gCsWW5PueoVKYE/zlyeb3J+Fj5pgUcl9G+gbjplcVw6aO4isz5rX7Ee/ClJMpz7B6eAVMvI0qS/aLsFYy+GKviOt3nv8eBJIHu38+Zv1T//ssDSPzxB8zZOz84DhdtgNYeRJKi6KKtu3SWCelDH9rm7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737985119; c=relaxed/simple;
	bh=H/4YXUpsBBffwG41i8xNB3n1VcyFQqEEC+lBRUJyDsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtNlkcE0AXNpWWQPqY5hwMX9/5m9zFAh8oIJZLbl51lpX7FN+22d614nzXReJft/6cP1yzWuEGss489FoCloDF7Yx3Hky/JeTp2PbQyb81MRAkedVypG02wEfeGSmgzI9vby27fIsybzOhYe4uhay9e7/aXmxT+TLq7I5YYkH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=DrkXsmy7; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 7ed27b2b65d0c582; Mon, 27 Jan 2025 14:38:35 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7EEC87524A4;
	Mon, 27 Jan 2025 14:38:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1737985115;
	bh=H/4YXUpsBBffwG41i8xNB3n1VcyFQqEEC+lBRUJyDsA=;
	h=From:Subject:Date;
	b=DrkXsmy7NkyLzxyjKUhE4jfxfCfHdjSeQU20sWTEU8dmKm1JZ8xvERYq5cG2CfFpl
	 PQo1QGgADYc/WQnf/sTmMIx5pSK9lY7Y9VFYyfBzl2lzlIPfdpGqJowkuQxCmwe7a1
	 ax5+zdBG7Asz/qcKRoEtnQgADDasTRpwkidWCzcQ5Klrqw0j++VFjkvmGABgxn2WeY
	 uW0mdh49r2oJdjvkSroxoaDiztrMw7UKvwRXdGHQoQRHrqEEo/TXrQum+rOsWZsovL
	 TBDpSPcNIj/3CWRjlJ2bHceWVLE4NUdI6v5RiSYY1EbrzUupH1zkcyZqtpPWuPJWHa
	 7lYolUdAq/Mlg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject:
 [PATCH v1 2/2] PM: EM: Slightly reduce em_check_capacity_update() overhead
Date: Mon, 27 Jan 2025 14:38:25 +0100
Message-ID: <1925950.tdWV9SEqCh@rjwysocki.net>
In-Reply-To: <6137833.lOV4Wx5bFT@rjwysocki.net>
References: <6137833.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudeffeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughivghtmhgrrhdrvghgghgvmhgrnhhnsegrrhhmrdgtohhmpdhrtghpthhtoheprhhitggrrhguohdrnhgvrhhiqdgtrghluggvrhhonheslhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Every iteration of the loop over all possible CPUs in
em_check_capacity_update() causes get_cpu_device() to be called twice
for the same CPU, once indirectly via em_cpu_get() and once directly.

Get rid of the indirect get_cpu_device() call by moving the direct
invocation of it earlier and using em_pd_get() instead of em_cpu_get()
to get a pd pointer for the dev one returned by it.

This also exposes the fact that dev is needed to get a pd, so the code
becomes somewhat easier to follow after it.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/energy_model.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -774,7 +774,8 @@
 		}
 		cpufreq_cpu_put(policy);
 
-		pd = em_cpu_get(cpu);
+		dev = get_cpu_device(cpu);
+		pd = em_pd_get(dev);
 		if (!pd || em_is_artificial(pd))
 			continue;
 
@@ -798,7 +799,6 @@
 		pr_debug("updating cpu%d cpu_cap=%lu old capacity=%lu\n",
 			 cpu, cpu_capacity, em_max_perf);
 
-		dev = get_cpu_device(cpu);
 		em_adjust_new_capacity(dev, pd);
 	}
 




