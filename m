Return-Path: <linux-pm+bounces-21484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650B0A2AB62
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 15:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36FFF16B167
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 14:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8925E230995;
	Thu,  6 Feb 2025 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="RTLFuRJk"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8A1EDA20;
	Thu,  6 Feb 2025 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852174; cv=none; b=RETjKLmIsH37KTmz1y6QwNct7ZrOCdSjmvbJzM184IMV0p8sodA+intmFmdEeGjH68N4B6JRQhVnCd7wxhmZ4fHceRYIDN0CKQzygxyuoiHHwl+g0cZq7nCqcrrGYSMRWF2Eq4g2N/CzMve1yJmTYVfZ4/QNv0q6tbCLfNem5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852174; c=relaxed/simple;
	bh=ixHGPp5ZLF5maWj/njvU5xlymHep1GI46tlAYLZj4Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aj0BrotlbxiKB9E4QSG63WIIrFenF9d3N8JFVageaEzTd1dGiWgJgwgWUuMcBIsN8T2vgvfKoRBOT00w3D2HFyh38HxelLoTS51/CopHySyb2DybaS5OlqyBJ+UXo/FsiQZTSTlEf7keUpdnsnmRGk7S+BHKkJku0et4P+U2+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=RTLFuRJk; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id ec84bb99580961bd; Thu, 6 Feb 2025 15:29:24 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 71ED26BA970;
	Thu,  6 Feb 2025 15:29:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1738852163;
	bh=ixHGPp5ZLF5maWj/njvU5xlymHep1GI46tlAYLZj4Vc=;
	h=From:Subject:Date;
	b=RTLFuRJkG98k8S1KWQNxTR51aOBdRiU9P17oihnhD24Ik2oXoHR28lSgJdkyyP16l
	 tWW7B4ruTugSgRbOWwkbZ2biz3onCS4NbgjPrtvx2SGhhtUuSvojzhpG4Rt+bf5QgW
	 Hlk6Np27FT0nCVUU8uv5vb4oExMGTrfLA+3pSutxZe35JfSC9M1mANPgX6IC99k3kq
	 rQVkNDYw5sOGr/QIbsKyabyG1gpsZr3jZuj0MGb1ukjGM+th8Qs47Z2ZicQcmdmDtm
	 T7IunpvsVTWjrH1Ibq/ZAEEk4FkFJgjZOcGhvr4OU6TLQTEWm4Ijq96ELTvfcCPxnP
	 ZBrcq+0i54JTg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject:
 [RFT][PATCH v1 3/5] cpuidle: menu: Tweak threshold use in
 get_typical_interval()
Date: Thu, 06 Feb 2025 15:25:18 +0100
Message-ID: <8490144.T7Z3S40VBb@rjwysocki.net>
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

To prepare get_typical_interval() for subsequent changes, rearrange
the use of the data point threshold in it a bit and initialize that
threshold to UINT_MAX which is more consistent with its data type.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -116,7 +116,7 @@
  */
 static unsigned int get_typical_interval(struct menu_device *data)
 {
-	unsigned int max, divisor, thresh = INT_MAX;
+	unsigned int max, divisor, thresh = UINT_MAX;
 	u64 avg, variance, avg_sq;
 	int i;
 
@@ -129,8 +129,8 @@
 	for (i = 0; i < INTERVALS; i++) {
 		unsigned int value = data->intervals[i];
 
-		/* Discard data points above the threshold. */
-		if (value > thresh)
+		/* Discard data points above or at the threshold. */
+		if (value >= thresh)
 			continue;
 
 		divisor++;
@@ -186,7 +186,7 @@
 	if ((divisor * 4) <= INTERVALS * 3)
 		return UINT_MAX;
 
-	thresh = max - 1;
+	thresh = max;
 	goto again;
 }
 




