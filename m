Return-Path: <linux-pm+bounces-17573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D87479C9111
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 18:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFC81F22187
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 17:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC4718A6BA;
	Thu, 14 Nov 2024 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="PvUs/B8V"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6DE17F505;
	Thu, 14 Nov 2024 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606386; cv=none; b=rD99V6h7TITY2eA5QRSvGvijcZ+QkSip039HbX2lZJq3KAOobZVXYaqGD6exOZswnfQEzujYYE4uTffgQsHRvV9PEdo5l17xPH3fJvg5jy24aqzyRBoH2nURGU4f+wJP13W3kkY0KvH7EDqfHnRDTdpVQ30/tHLWBGmigF7Sj9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606386; c=relaxed/simple;
	bh=Y5+ODZLSVNT2u3UvSdd3lyMAo2vfTcuSQ7RKhFiXcDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pj1U9LsqfvE/k4Ai3YRbdg43I08meFkVjdXg8tDe2PjYylx1lUVQyNd9qC+iCGck0r/xjsjxS/RY2XZ808iN7X9vjjtb4TI/yf1XcySkERhmrtwX68y2R000lX07Q0ehAS1Dwm5jZvxdBi2sxEs4ILWx8xPiPu0zb0zsk6LuYR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=PvUs/B8V reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 4946fef8b595fdd4; Thu, 14 Nov 2024 18:46:21 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DBFCC665CF6;
	Thu, 14 Nov 2024 18:46:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1731606381;
	bh=Y5+ODZLSVNT2u3UvSdd3lyMAo2vfTcuSQ7RKhFiXcDA=;
	h=From:Subject:Date;
	b=PvUs/B8VR66kqq9A3i6o3aKUhdfZsSszLum6AP2tkkNXpY8mW5s8cnMEkeqJMJWtq
	 VUrFVaXfI1v+YNyTE+xQsFHSGP+PMjZtu/VLa4XImkc2HDqwFx0elep9RAZmlNZCvl
	 isWCgyLmB/diUzS6gYYEmdYxqLuhIAj0gi3GwZlN/ygDns2BS5Vc7N/G2t0Lu43aFX
	 qe+6vQ/pLmy55MytK8ZQiZk8XuEeLNFnzrKFOlKmp/+V2Dmi6ffu6jEjvxUPOaRuDG
	 7k52ArXjY+DGCjRYKyAY04Hxy78TTeI7Ji2gknx23yY6kGWO2a6AMZnxEY97BgIpU6
	 au8lBrrcLMtrA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1] cpuidle: Do not return from cpuidle_play_dead() on callback
 failures
Date: Thu, 14 Nov 2024 18:46:20 +0100
Message-ID: <4992010.31r3eYUQgx@rjwysocki.net>
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

If the :enter_dead() idle state callback fails for a certain state,
there may be still a shallower state for which it will work.

Because the only caller of cpuidle_play_dead(), native_play_dead(),
falls back to hlt_play_dead() if it returns an error, it should
better try all of the idle states for which :enter_dead() is present
before failing, so change it accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -70,9 +70,10 @@ int cpuidle_play_dead(void)
 		return -ENODEV;
 
 	/* Find lowest-power state that supports long-term idle */
-	for (i = drv->state_count - 1; i >= 0; i--)
-		if (drv->states[i].enter_dead)
-			return drv->states[i].enter_dead(dev, i);
+	for (i = drv->state_count - 1; i >= 0; i--) {
+		if (drv->states[i].enter_dead && !drv->states[i].enter_dead(dev, i))
+			return 0;
+	}
 
 	return -ENODEV;
 }




