Return-Path: <linux-pm+bounces-18048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1125E9D8553
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC886B42F6A
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 11:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955BE1991D9;
	Mon, 25 Nov 2024 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="a1h2Km8A"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F034192D73;
	Mon, 25 Nov 2024 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533898; cv=none; b=BCFPKFCWE7QNCrELP0Th+4WGZU9lKFcTlqWrcBDogJtgKh52wqi0CHremoKQoY7260OTkXJ1skorZt8fldWSONUB2UGEWDq8YSXSx3ofus5M9rBMv/SbcVqpYZsjjyXyDUxdocgId7ezADmjUOxNM9h9xmWFmCj1TXFDqPvt/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533898; c=relaxed/simple;
	bh=pqSDwwu39Q8LaZw3f+Ug74GgVdI7tY0hPyhMtuK+EX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RX34byYLOr7odEPH9leHNNRZaXXv/rgC8sV6d0BO5Ob9MY3ivudGODtdKjjMCNjEIE7h/LVzdyfsYAuaP1rNJYi10WHoLTmyYzZuWvxiKS9Z4+7UzGrVOCBp9HDToHEHSjKDrgX6TiIabVGKdhqWCjmcrSZbeaFyOhJwddbdmRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=a1h2Km8A reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 4b051d227fd2c5b1; Mon, 25 Nov 2024 12:24:46 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 4E6F218F4CDB;
	Mon, 25 Nov 2024 12:24:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1732533886;
	bh=pqSDwwu39Q8LaZw3f+Ug74GgVdI7tY0hPyhMtuK+EX8=;
	h=From:Subject:Date;
	b=a1h2Km8AC44zwJfV6A0iPc+w2bk5QF2v4gzFsfCGdXRYnThwVOoDLWV5wXJbikOsi
	 BXl0vuUrzKbFi71Qm+bW0UEZNjYI/Ay4RNo9jiWjjcjgKNc9fLCdB13Y4ghHFL9+u8
	 Iz2B/+dwGn863BTvfExybVhJZ7rkQu1SFYJATS4KB+MxKtIYUSJqwpLMT3UGFMa3ud
	 /bHbW/IvpoNbP+c2nDa15Tbpbyo0huCQ8OqY+qVCVIdB2ijE40LI8JAg3HFLactlQ8
	 kbKI/tnlNBLg8CK3lVGZilNQf4ohI8GCavGlc0h8OexS9R18cexk+O1YBO1TbjhIS+
	 wHPVj8G1cq0ZA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Sasha Levin <sashal@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>
Subject:
 [PATCH v1] thermal: gov_power_allocator: Add missing NULL pointer check
Date: Mon, 25 Nov 2024 12:24:46 +0100
Message-ID: <2761105.mvXUDI8C0e@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehsrghshhgrlheskhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 0dc23567c206 ("thermal: core: Move lists of thermal instances
to trip descriptors") overlooked the case in which the Power Allocator
governor attempts to bind to a tripless thermal zone and params->trip_max
is NULL in check_power_actors().

No power actors can be found in that case, so check_power_actors() needs
to be made return 0 then to restore its previous behavior.

Fixes: 0dc23567c206 ("thermal: core: Move lists of thermal instances to trip descriptors")
Closes: https://lore.kernel.org/linux-pm/Z0NeGF4ryCe_b5rr@sashalap/
Reported-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_power_allocator.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/thermal/gov_power_allocator.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_power_allocator.c
+++ linux-pm/drivers/thermal/gov_power_allocator.c
@@ -588,10 +588,15 @@ static void allow_maximum_power(struct t
 static int check_power_actors(struct thermal_zone_device *tz,
 			      struct power_allocator_params *params)
 {
-	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
+	const struct thermal_trip_desc *td;
 	struct thermal_instance *instance;
 	int ret = 0;
 
+	if (!params->trip_max)
+		return 0;
+
+	td = trip_to_trip_desc(params->trip_max);
+
 	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
 		if (!cdev_is_power_actor(instance->cdev)) {
 			dev_warn(&tz->device, "power_allocator: %s is not a power actor\n",




