Return-Path: <linux-pm+bounces-8251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A18D1F79
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 17:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D789F1F23BD8
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5484171666;
	Tue, 28 May 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="CrZWDXBH"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C4170848;
	Tue, 28 May 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908473; cv=none; b=EIc8UA6HM0UX9Lze3qHu5lhBOtEsObYviH5rDZvpvpdiQIUA8zDcr8FlW9lmSBDrqvrijrgHzfO3IjT5oOQ2BHh0V5jq7dpvg7ygn/NF3S9FXZaDg4bEJGxiNuWU19dqqRkkXJVGWqfjF4jARmX0SJh5bdqjLtBrib5yCR34aT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908473; c=relaxed/simple;
	bh=7tfm79MQP2qGW3LgqSBxE0uv7WR1NeIzcGDtBjqkyOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzjUXx+2DbpRPz1fuO3EYhm5SV6s1Lu8oYhrExnYgLe3FPlZZJ8rsvyIzRn54MjdANYQfkX2OLafWHs6LERAZCdQhyJIXJ64xHEfvRtx+z/As5mX4zxYfK5jfNOzaRs3yh8KYvsBpFFBt1EDjQYPpmyp2DnKbk+3G+o72rRY95M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=CrZWDXBH reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 8604d37985fdf45e; Tue, 28 May 2024 17:01:03 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5FEC96A5015;
	Tue, 28 May 2024 17:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716908463;
	bh=7tfm79MQP2qGW3LgqSBxE0uv7WR1NeIzcGDtBjqkyOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CrZWDXBHBDbcm+99w/Qrn/dchEVeeQWOfYdH9nUQkxfdBesZyF4lyaL7EfKdmraM5
	 dLpYDl6S9q3SFbBEEzgTWrCXXEk3XtVcwsw+VacwjS22scWZmGedAvtxOxRap5zYwm
	 4s0DbJl2CnLvM41aGn0TsNd78iud9iDsUlyeugB6EXSJyz4yD404Cj00d9vgh/Ijnw
	 P+UGshQ8x1V1leqD1DHtlRjai+4CYXdr6pXAD2DHVwAB/f0z9W8d/kCXdyzvt+5m9n
	 dCQ7PrxA5nIrnzac+Wx5JLSYTHTvhEk8HkgSWng/xwuZ8ZeqK92+Fyagi6ztvl6ut2
	 MAFNfvePydwhA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v2 5/8] thermal/debugfs: Adjust check for trips without statistics in
 tze_seq_show()
Date: Tue, 28 May 2024 16:57:13 +0200
Message-ID: <8389302.T7Z3S40VBb@kreacher>
In-Reply-To: <5794974.DvuYhMxLoT@kreacher>
References: <5794974.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Initialize the trip_temp field in struct trip_stats to
THERMAL_TEMP_INVALID and adjust the check for trips without
statistics in tze_seq_show() to look at that field instead of
comparing min and max.

This will mostly be useful to simplify subsequent changes.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: New patch.

---
 drivers/thermal/thermal_debugfs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -563,6 +563,7 @@ static struct tz_episode *thermal_debugf
 	tze->duration = KTIME_MIN;
 
 	for (i = 0; i < tz->num_trips; i++) {
+		tze->trip_stats[i].trip_temp = THERMAL_TEMP_INVALID;
 		tze->trip_stats[i].min = INT_MAX;
 		tze->trip_stats[i].max = INT_MIN;
 	}
@@ -818,7 +819,7 @@ static int tze_seq_show(struct seq_file
 		trip_stats = &tze->trip_stats[trip_id];
 
 		/* Skip trips without any stats. */
-		if (trip_stats->min > trip_stats->max)
+		if (trip_stats->trip_temp == THERMAL_TEMP_INVALID)
 			continue;
 
 		if (trip->type == THERMAL_TRIP_PASSIVE)




