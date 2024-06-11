Return-Path: <linux-pm+bounces-8954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BC7903F41
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 16:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13AB01C2331C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB9912B75;
	Tue, 11 Jun 2024 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="pyRIbY2t"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3B1CF90;
	Tue, 11 Jun 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117592; cv=none; b=kzZvxfDRTKJm3/yzceLx6zYXsAYh2odqlswAKDkjdriXvSgkH1CcpyVavDSgKeei06F+SfVHcdkdmLzJ5u+DTSgCZm7BDvvWjbD4N5MTf0AlTJ/hX5gbFlv2f53kvCWq0mrmkvMiqy5X78fH47c+7K810m7IC2676H21fYvJCDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117592; c=relaxed/simple;
	bh=H+bRJvzcbI+nOZCWhjjmp5dz3lA5xGhHR1HFZDaDQdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TddY9g/IPYrnXwudazizJshdQbbtxgn4SH02PUyDPTthaZI2Dqe/9eBBZE0+LckNOWh/uBukyrk6CEOi8VLC7poQuf2fSsusA4jkfn9Xhb6ESVzLHvXo3sduJxrKxqHBSmYkdpzSVRCo5mZdxpWj86Ykp35AGu2zsv5GW8Pi2EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=pyRIbY2t reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 9960b2112a539cf6; Tue, 11 Jun 2024 16:53:07 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3E95F7F46D3;
	Tue, 11 Jun 2024 16:53:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718117587;
	bh=H+bRJvzcbI+nOZCWhjjmp5dz3lA5xGhHR1HFZDaDQdg=;
	h=From:To:Cc:Subject:Date;
	b=pyRIbY2tDtPj0t2ejlh6GQWA46yQBmZLmtL5BpYFuIkBj9x6htHEUMz3X3phkSjLO
	 Smcfo3Jqyo/s8iKcDrDoo38sE1Xq9rLzDqhhaTGNbOmL3XP1xGXSOfjhlVkoLWTPZ2
	 hcUkdUkSzx0jmHmeKJOliqBPn6WB7nRb/6wMtM0QKRCEjJKcWF39uQ/wB/VBJBSKH/
	 9uoOC7oznGbq9huLlt22eKWaDZIhl/yF7+dBd/91WTtLfHUnJxcMGZhwUjcpqsF09G
	 4yFBwMZpjxpyCLV42xuHstx2Z4bPJejo0gQ83L3iib49ipL1bSZpHTKZqYtxLLBi1i
	 Xvxb1z1Urqjeg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Xi Ruoyao <xry111@xry111.site>
Subject:
 [PATCH v1] cpufreq: intel_pstate: Check turbo_is_disabled() in
 store_no_turbo()
Date: Tue, 11 Jun 2024 16:53:06 +0200
Message-ID: <6061905.lOV4Wx5bFT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeigrhih
 udduudesgihrhiduuddurdhsihhtvg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After recent changes in intel_pstate, global.turbo_disabled is only set
at the initialization time and never changed.  However, it turns out
that on some systems the "turbo disabled" bit in MSR_IA32_MISC_ENABLE,
the initial state of which is reflected by global.turbo_disabled, can be
flipped later and there should be a way to take that into account (other
than checking that MSR every time the driver runs which is costly and
useless overhead on the vast majority of systems).

For this purpose, notice that before the changes in question,
store_no_turbo() contained a turbo_is_disabled() check that was used
for updating global.turbo_disabled is the "turbo disabled" bit in
MSR_IA32_MISC_ENABLE had been flipped and that functionality can be
restored.  This way, users will be able to reset global.turbo_disabled
by writing 0 to no_turbo which used to work before.

This guarantees the driver state to remain in sync, but READ_ONCE()
annotations need to be added in two places where global.turbo_disabled
is accessed locklessly, so modify the driver to make that happen.

Fixes: 0940f1a8011f ("cpufreq: intel_pstate: Do not update global.turbo_disabled after initialization")
Closes: https://lore.kernel.org/linux-pm/bf3ebf1571a4788e97daf861eb493c12d42639a3.camel@xry111.site
Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reported-by: Xi Ruoyao <xry111@xry111.site>
Tested-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1302,12 +1302,17 @@ static ssize_t store_no_turbo(struct kob
 
 	no_turbo = !!clamp_t(int, input, 0, 1);
 
-	if (no_turbo == global.no_turbo)
-		goto unlock_driver;
-
-	if (global.turbo_disabled) {
-		pr_notice_once("Turbo disabled by BIOS or unavailable on processor\n");
+	WRITE_ONCE(global.turbo_disabled, turbo_is_disabled());
+	if (global.turbo_disabled && !no_turbo) {
+		pr_notice("Turbo disabled by BIOS or unavailable on processor\n");
 		count = -EPERM;
+		if (global.no_turbo)
+			goto unlock_driver;
+		else
+			no_turbo = 1;
+	}
+
+	if (no_turbo == global.no_turbo) {
 		goto unlock_driver;
 	}
 
@@ -1762,7 +1767,7 @@ static u64 atom_get_val(struct cpudata *
 	u32 vid;
 
 	val = (u64)pstate << 8;
-	if (READ_ONCE(global.no_turbo) && !global.turbo_disabled)
+	if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disabled))
 		val |= (u64)1 << 32;
 
 	vid_fp = cpudata->vid.min + mul_fp(
@@ -1927,7 +1932,7 @@ static u64 core_get_val(struct cpudata *
 	u64 val;
 
 	val = (u64)pstate << 8;
-	if (READ_ONCE(global.no_turbo) && !global.turbo_disabled)
+	if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disabled))
 		val |= (u64)1 << 32;
 
 	return val;




