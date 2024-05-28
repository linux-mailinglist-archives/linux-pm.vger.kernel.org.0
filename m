Return-Path: <linux-pm+bounces-8260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC278D21FF
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 18:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581BF1C21A6E
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 16:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CF017332A;
	Tue, 28 May 2024 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="YJH4dREI"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2AA171E44;
	Tue, 28 May 2024 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716915264; cv=none; b=RZP6Jvz/2q23p2juERjhHkL03p4obP7DBGD88s3GjwVzgLk/8V5aPPNabSOMg3TiZ4hLQG7aSl7DVrTWg3xRKimFuEOtKR5gPdz873tgjQFnYqRtKlx/0j2/bqMx6OY/o70C9th51VW5bVU3+X874Zy317cwj2yqQ1J2V5qeqa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716915264; c=relaxed/simple;
	bh=vn9XxyYsOXd3b8Z5/62CmIgn6KJhgsWt9QkmG3kKn8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7+piFPNT+tj4SazaNyGryiR0VWEeNWfZvIt7ssm3XnvjcafRvzgjTA7tVPzI9InbtQff1lwysStC1QM39UpwvbjYmznsZ1aS8C/e80H9s7kCn2dW2pAH4Bg4Fr7wqpYq5d8v2hOX0E536tSW5HTPT5PunYGzust8nyHobH3kks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=YJH4dREI reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id f373c1def34ea047; Tue, 28 May 2024 18:54:20 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 718306A5036;
	Tue, 28 May 2024 18:54:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716915259;
	bh=vn9XxyYsOXd3b8Z5/62CmIgn6KJhgsWt9QkmG3kKn8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YJH4dREI8/Vr8uo1uwGWWHDErIuzLs2mdWD56iPWcETlbRPWL2Nxwpd/gTaUu6bvd
	 jlFCtHivPCgzBRe2YRDU5LU2vi01FWKPiZ1fI3xG6H3wjROiueyepojkLXNgd/qm+s
	 w7692MnIvi1pAIqsgvub12lBW4Y9zYVwC/RnHbe65mNbeOT6JfpAe1or9P3bDlmVmF
	 w9fXNzHUXgz79EHQkAubVNgFYhl5VFEMvqKUPBF12OV91OhW25Gp6MJkY5GSflnRUT
	 vKRFHmY2J0KJagmGdZrH+DdGGfEoz9SSJevLeCxMv+PM3zf8cNK1Z8FLZDAocf+oZt
	 lGwOrG9RcjsMQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v2 5/5] thermal: core: Avoid calling .trip_crossed() for critical and
 hot trips
Date: Tue, 28 May 2024 18:54:11 +0200
Message-ID: <8392684.T7Z3S40VBb@kreacher>
In-Reply-To: <12458899.O9o76ZdvQC@kreacher>
References: <12458899.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Invoking the governor .trip_crossed() callback for critical and hot
trips is pointless because they are handled directly by the core,
so make thermal_governor_trip_crossed() avoid doing that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rebase.

---
 drivers/thermal/thermal_core.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -463,6 +463,9 @@ static void thermal_governor_trip_crosse
 					  const struct thermal_trip *trip,
 					  bool crossed_up)
 {
+	if (trip->type == THERMAL_TRIP_HOT || trip->type == THERMAL_TRIP_CRITICAL)
+		return;
+
 	if (governor->trip_crossed)
 		governor->trip_crossed(tz, trip, crossed_up);
 }




