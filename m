Return-Path: <linux-pm+bounces-17575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2E69C9158
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 19:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 456EDB2A21A
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B6418BB82;
	Thu, 14 Nov 2024 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="uhWmnbmW"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A8175D5D;
	Thu, 14 Nov 2024 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606480; cv=none; b=VbtpG/Z75mQ5Js3fxjJ2R1LSW+YWZLuaSVQsARro+YjW8qZpuFcOVMTbYHm6aRHmh+tKKcQNIWwV5VxPgrUnHUh+Ge+BnWI9HSOw0wfXdbtGH5x0S0+rNKjPdV9101YVx87ZVrkbsjJg1KQwQ12kN9M6Hh+TFV3htFGGzfxItgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606480; c=relaxed/simple;
	bh=HMwxgerIXtybTadGF19QWB5QBDuxTsaaCs4rDMHIcWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ME+AVHE0kLsikizjrgl9ZQ7PUk1/a4fekbVy3oH7RHQZ2f6uYL10MtTxgwXTg91xDVf25Cb2mtGQEzCkhFg+SLBsGue2Jb0iE2rD1x63T3EHySvVkTOfOVYBmnsJlM+6fMnzvEKxEIiSKIfEX8YxcfEuZtuKSDjwYxFZYZdi1qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=uhWmnbmW reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 4fd1f0bef9360896; Thu, 14 Nov 2024 18:47:56 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id ED3AF665CF6;
	Thu, 14 Nov 2024 18:47:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1731606476;
	bh=HMwxgerIXtybTadGF19QWB5QBDuxTsaaCs4rDMHIcWM=;
	h=From:Subject:Date;
	b=uhWmnbmWCZmTKvTsqsHjJXBOTzO1zOpetvCuBgpXq2V2MOghBYes9IFqr7tdc0grh
	 vZ1O6a1rAqZCiyHYGK3Et1OzYgBOT131rQZ4JYBCYBMVGZAn/RhfULLQrDPgRuK5rM
	 7yVoeIedyqvq0uVfefIuFysZAzpMdyxureoj1XI8FsSFMHhhi93JmKX2+xZdyUX7U5
	 0m3p3g8MEhkkDCnomnqSsJNkgwYihwkjgqyq0ktzV8A9K3HOhNPVZWZ3RGBjb7EFKG
	 bQH7zpvgr7/JZr4RQzc0m7NiWpAmfPwV3qdj9NeTsK+kZK2DEu6UGi14P1OkeiAZ3o
	 UTQuwYqHKD8Jw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1] ACPI: processor_idle: Use acpi_idle_play_dead() for all C-states
Date: Thu, 14 Nov 2024 18:47:55 +0100
Message-ID: <2373563.ElGaqSPkdT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehprghtrhihkhdrfihlrgiilhihnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthh
X-DCC--Metrics: v370.home.net.pl 0; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that acpi_processor_setup_cstates() can set state->enter_dead to acpi_idle_play_dead() for all C-states unconditionally and remove the
confusing C-state type check done before setting it.

No intentional functional impact.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -803,12 +803,12 @@ static int acpi_processor_setup_cstates(
 		state->enter = acpi_idle_enter;
 
 		state->flags = 0;
-		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2 ||
-		    cx->type == ACPI_STATE_C3) {
-			state->enter_dead = acpi_idle_play_dead;
-			if (cx->type != ACPI_STATE_C3)
-				drv->safe_state_index = count;
-		}
+
+		state->enter_dead = acpi_idle_play_dead;
+
+		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2)
+			drv->safe_state_index = count;
+
 		/*
 		 * Halt-induced C1 is not good for ->enter_s2idle, because it
 		 * re-enables interrupts on exit.  Moreover, C1 is generally not




