Return-Path: <linux-pm+bounces-24592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305FFA751EA
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 22:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827833B09CD
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 21:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C64A1EF36D;
	Fri, 28 Mar 2025 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Io01FBFl"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E4A18C907;
	Fri, 28 Mar 2025 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743196434; cv=none; b=pEJ/tOipVIuocJXe3EWANtM40L2DMCeHDXm7rONlA/mbgqzFAuYxwD7C1ak8ye0pQtGtlHkjRvmBZenYCbDvdjTzlZSXEvqf1NBor60S9bBYLatTkLqaJ7oY4PSjib0uf1dpjviwSDs2K/c3PlabKjzHW40Bda864zfMnp0QOeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743196434; c=relaxed/simple;
	bh=2FWGf5Q/mGzVuy8kNdFngb6gqlwjuoE0G0zt+wG0MgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbAf8I+rOYf8oxMgShfQqVJIsywcb7lD/D4ADwIHAlew1VcUVyTVvVQlE4kK50acUdfcQi1V17t26Jw3PvCLYmgLi/fTeSEpbERu+rD4weQI16ObHPysLtZX/mzhLt3mDkYynFS9Yg2DEm0M/zhL+mLnUZzcEehpldKweH72NDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Io01FBFl; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id de5077abbd14a3e0; Fri, 28 Mar 2025 22:13:50 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B39D27F0283;
	Fri, 28 Mar 2025 22:13:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743196430;
	bh=2FWGf5Q/mGzVuy8kNdFngb6gqlwjuoE0G0zt+wG0MgU=;
	h=From:Subject:Date;
	b=Io01FBFlXdKgTnwiRWg+BR6JYXUU0ZTKE9Dwmv0SQR9txTrVMsVyFG1IQIEKn7TEc
	 LNxWcWdEyvyfVJc6O2+lmfUPl4JZbfEsqxyIFloA1Ncdh5YqSu2O7iKC5PpehMgehN
	 Z7xyyAtk/IRw4ZsZHDxXFB+o9h7GCZLAZoy/aoYGYhwY6tyq3rPJLhv0I/HZ2FSQ/A
	 sSF5D65ymsVATRxoXfFCGeaW/4WIuK4oJokIOztJJIrTyay8IuuLiXqOhwSxg7s3Y6
	 oyR/aKzExsZVjWOagyqMMK628PM8LbfG7aUVza5+NakvJnTczescqDzNC7Cr3u3aLO
	 pYw/rLxuA1XTw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Marek =?ISO-8859-1?Q?Marczykowski=2DG=F3recki?=
 <marmarek@invisiblethingslab.com>
Subject:
 [PATCH v1 01/10] cpufreq: Reference count policy in cpufreq_update_limits()
Date: Fri, 28 Mar 2025 21:39:08 +0100
Message-ID: <1928789.tdWV9SEqCh@rjwysocki.net>
In-Reply-To: <4651448.LvFx2qVVIh@rjwysocki.net>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepkeeileehffelfefggfdtjedvkeettdejfeevueegfedvhffgudeuteeigfeileetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphh
X-DCC--Metrics: v370.home.net.pl 1024; Body=84 Fuz1=84 Fuz2=84

=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since acpi_processor_notify() can be called before registering a cpufreq
driver or even in cases when a cpufreq driver is not registered at all,
cpufreq_update_limits() needs to check if a cpufreq driver is present
and prevent it from being unregistered.

=46or this purpose, make it call cpufreq_cpu_get() to obtain a cpufreq
policy pointer for the given CPU and reference count the corresponding
policy object, if present.

=46ixes: 5a25e3f7cc53 ("cpufreq: intel_pstate: Driver-specific handling of =
_PPC updates")
Closes: https://lore.kernel.org/linux-acpi/Z-ShAR59cTow0KcR@mail-itl
Reporetd-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab.c=
om>=20
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/cpufreq/cpufreq.c |    6 ++++++
 1 file changed, 6 insertions(+)

=2D-- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2781,6 +2781,12 @@
  */
 void cpufreq_update_limits(unsigned int cpu)
 {
+	struct cpufreq_policy *policy __free(put_cpufreq_policy);
+
+	policy =3D cpufreq_cpu_get(cpu);
+	if (!policy)
+		return;
+
 	if (cpufreq_driver->update_limits)
 		cpufreq_driver->update_limits(cpu);
 	else




