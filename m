Return-Path: <linux-pm+bounces-21485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C36A2AB63
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 15:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED62416B25F
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFDC23F29A;
	Thu,  6 Feb 2025 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="M7DRQVSi"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB21EDA33;
	Thu,  6 Feb 2025 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852175; cv=none; b=JUq5RYpdPwuWd7rcjmOQwAKnenzr6u6HP8Gl+k98P1LmGYL3z6kbMIKPHpE7aDu79hllWetFINJ1yxaM10pIkucWl+tFbCZXd8aHBBLWECWTcHkMxWNsRofxoALnlQjG7yfO70aD0CGvJTnXA8e6jlfcI5lO6xUq8DZmuRf9PIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852175; c=relaxed/simple;
	bh=w88YqCV4joJ59wLsJjRrUn/tCBNWwaQK/X+ysio0IFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNlEOhxZvIwBC4VY18DrDC2avEKLQYgXR6snA08PPt4KM0XahwGMXsDeAXPlCYhWhSSFn8zFVHiSBZavU/brE8xir7t1Ydq+mt/REVxTsnSG3xH1SfnF+0OE/v7EJds+9R7p6k4rzLGzhvuUFMRZILORKa1bn697oVrAgR2Mh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=M7DRQVSi; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id e5625c4cae068dd4; Thu, 6 Feb 2025 15:29:25 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1EEA26BA970;
	Thu,  6 Feb 2025 15:29:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1738852165;
	bh=w88YqCV4joJ59wLsJjRrUn/tCBNWwaQK/X+ysio0IFA=;
	h=From:Subject:Date;
	b=M7DRQVSigP8PXrHLIp1ijxfv9rKoEe6f6XUdS6rAfsBKNFwP+b0r08Dg1xXdXnh8g
	 DfiGglwesh5WPYZNjH++USZU6dbPg9HYqj/4Wq7TNlrujiXXO6blQN3zGUMMfRsLHb
	 OWIltwzl1OM+R6yg01fc7sD/NlsIbOM5iNKVwWfMzom+a1BtZfL5SUNbYtolvVcLaz
	 mXPpSwdaKAujq2nRQX/mOzNezORHqnM8sE8UNCvXSMS71Qm4kPdk5ZK7WlnA+hut1G
	 dsCCBC5Dbh5gJGRyrApf4xJ+9QxDMOZeUesxGMkMqE0O1SIz3gvJro46IGWIDhFDmX
	 +bkVsNxCJINkg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: [RFT][PATCH v1 1/5] cpuidle: menu: Drop a redundant local variable
Date: Thu, 06 Feb 2025 15:22:59 +0100
Message-ID: <13699686.uLZWGnKmhe@rjwysocki.net>
In-Reply-To: <1916668.tdWV9SEqCh@rjwysocki.net>
References: <1916668.tdWV9SEqCh@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdhlohgvhhhlvgesrghrmhdrtghomhdprhgtphhtthhopegrrhhtvghmrdgsihhthihuthhskhhihieslhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Local variable min in get_typical_interval() is updated, but never
accessed later, so drop it.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -117,7 +117,7 @@
 static unsigned int get_typical_interval(struct menu_device *data)
 {
 	int i, divisor;
-	unsigned int min, max, thresh, avg;
+	unsigned int max, thresh, avg;
 	uint64_t sum, variance;
 
 	thresh = INT_MAX; /* Discard outliers above this value */
@@ -125,7 +125,6 @@
 again:
 
 	/* First calculate the average of past intervals */
-	min = UINT_MAX;
 	max = 0;
 	sum = 0;
 	divisor = 0;
@@ -136,9 +135,6 @@
 			divisor++;
 			if (value > max)
 				max = value;
-
-			if (value < min)
-				min = value;
 		}
 	}
 




