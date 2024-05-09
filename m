Return-Path: <linux-pm+bounces-7697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A2C8C1552
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 21:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E371C21A9E
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 19:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA1080617;
	Thu,  9 May 2024 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="xz1jHswN"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93677F7C5;
	Thu,  9 May 2024 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282272; cv=none; b=fF/6qP1nsTVV1sP4+sGCkO28+q5uYqRZd59TwKDft4brtLnzNrugaI+IAZtwFkaBgLsOPp7q1Ac8O3H5aj2n9ubPvSBV7OziNHJNhUIWZA9gI5ebW9JjOdt+p0sx6hcYbhLubatXZ7RTPMhdTrIrH5m8O/DlXYWbMUbF5F9WmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282272; c=relaxed/simple;
	bh=5drquzHN/2repaWJ8vxzq1JrgQ2MYkM3g4AKrXEP0v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FW/fla1tSbX2aHYttf6FNLVgMijWwXuhdFln/uDfKEUoUdEgzW/fDinHBn+H2V+o+InP/bJDt/vRNiGR/l0LgeF+rlMsZr1wL77+hQZuBePRnErLYpBBXl3+cDNK+2J0NWvPLOTqKAelUoSHd39FzrbzvLJ7VI6nZ0Jy/1HxthQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=xz1jHswN reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 2e676b0e8bb40e3b; Thu, 9 May 2024 21:17:43 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 75E2DA524E7;
	Thu,  9 May 2024 21:17:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715282262;
	bh=5drquzHN/2repaWJ8vxzq1JrgQ2MYkM3g4AKrXEP0v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xz1jHswNQg11lQA+L1RKulpPb6znnjf1ojZRr1CpUv1Fb9T+2/tVaBaJT5zpgonor
	 hxa6yr3L8vFY09oMiYKN/m+EJwhWTOXKRTMF7SnbyxMIQ0hGoK2PyE30NWfj1xv4lT
	 TdrHZu9kOZXHHf98StiE+cebXOJyVL4KR13t2zIhSSKnfhd0k4JNOKdLnA/U0bHdQ2
	 OiqiPRxIf+KstUXsXAJofoyuKkn6UatNw838sB7INhm3lgz/ZsRyeo56niPVtSDJb4
	 dvbeLJ4Rq2LZs0Iu/cjchmhufan5t7ObOKsZyYCrISUAT35u2RrpsNstzWoJpfhYx3
	 qk5z/NfRjoclw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 5/7] thermal/debugfs: Compute maximum temperature for mitigation
 episode as a whole
Date: Thu, 09 May 2024 21:15:19 +0200
Message-ID: <3295271.aeNJFYEL58@kreacher>
In-Reply-To: <12438864.O9o76ZdvQC@kreacher>
References: <12438864.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdefvddgudeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedtvdefgeelvdefvdevveehvdetfeefhedvueeiudekieeltdetgfdviefhgfetteenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that the maximum temperature above the trip point must be the
same for all of the trip points involved in a given mitigation episode,
so it need not be computerd for each of them separately.

It is sufficient to compute the maximum temperature for the mitigation
episode as a whole and print it accordingly, so do that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/thermal/thermal_debugfs.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -92,7 +92,6 @@ struct cdev_record {
  * @timestamp: the trip crossing timestamp
  * @duration: total time when the zone temperature was above the trip point
  * @count: the number of times the zone temperature was above the trip poi=
nt
=2D * @max: maximum recorded temperature above the trip point
  * @min: minimum recorded temperature above the trip point
  * @avg: average temperature above the trip point
  */
@@ -100,7 +99,6 @@ struct trip_stats {
 	ktime_t timestamp;
 	ktime_t duration;
 	int count;
=2D	int max;
 	int min;
 	int avg;
 };
@@ -115,15 +113,17 @@ struct trip_stats {
  * the way up and down if there are multiple trip described in the
  * firmware after the lowest temperature trip point.
  *
+ * @node: a list element to be added to the list of tz events
  * @timestamp: first trip point crossed the way up
  * @duration: total duration of the mitigation episode
=2D * @node: a list element to be added to the list of tz events
+ * @max_temp: maximum zone temperature during this episode
  * @trip_stats: per trip point statistics, flexible array
  */
 struct tz_episode {
+	struct list_head node;
 	ktime_t timestamp;
 	ktime_t duration;
=2D	struct list_head node;
+	int max_temp;
 	struct trip_stats trip_stats[];
 };
=20
@@ -557,11 +557,10 @@ static struct tz_episode *thermal_debugf
 	INIT_LIST_HEAD(&tze->node);
 	tze->timestamp =3D now;
 	tze->duration =3D KTIME_MIN;
+	tze->max_temp =3D THERMAL_TEMP_INVALID;
=20
=2D	for (i =3D 0; i < tz->num_trips; i++) {
+	for (i =3D 0; i < tz->num_trips; i++)
 		tze->trip_stats[i].min =3D INT_MAX;
=2D		tze->trip_stats[i].max =3D INT_MIN;
=2D	}
=20
 	return tze;
 }
@@ -729,11 +728,13 @@ void thermal_debug_update_trip_stats(str
=20
 	tze =3D list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
=20
+	if (tz->temperature > tze->max_temp)
+		tze->max_temp =3D tz->temperature;
+
 	for (i =3D 0; i < tz_dbg->nr_trips; i++) {
 		int trip_id =3D tz_dbg->trips_crossed[i];
 		struct trip_stats *trip_stats =3D &tze->trip_stats[trip_id];
=20
=2D		trip_stats->max =3D max(trip_stats->max, tz->temperature);
 		trip_stats->min =3D min(trip_stats->min, tz->temperature);
 		trip_stats->avg +=3D (tz->temperature - trip_stats->avg) /
 					++trip_stats->count;
@@ -789,10 +790,10 @@ static int tze_seq_show(struct seq_file
 		c =3D '=3D';
 	}
=20
=2D	seq_printf(s, ",-Mitigation at %llums, duration%c%llums\n",
=2D		   ktime_to_ms(tze->timestamp), c, duration_ms);
+	seq_printf(s, ",-Mitigation at %llums, duration%c%llums, max. temp=3D%dm=
=C2=B0C\n",
+		   ktime_to_ms(tze->timestamp), c, duration_ms, tze->max_temp);
=20
=2D	seq_printf(s, "| trip |     type | temp(m=C2=B0C) | hyst(m=C2=B0C) | du=
ration(ms) |  avg(m=C2=B0C) |  min(m=C2=B0C) |  max(m=C2=B0C) |\n");
+	seq_printf(s, "| trip |     type | temp(m=C2=B0C) | hyst(m=C2=B0C) | dura=
tion(ms) |  avg(m=C2=B0C) |  min(m=C2=B0C) |\n");
=20
 	for_each_trip_desc(tz, td) {
 		const struct thermal_trip *trip =3D &td->trip;
@@ -814,7 +815,7 @@ static int tze_seq_show(struct seq_file
 		trip_stats =3D &tze->trip_stats[trip_id];
=20
 		/* Skip trips without any stats. */
=2D		if (trip_stats->min > trip_stats->max)
+		if (trip_stats->min =3D=3D INT_MAX)
 			continue;
=20
 		if (trip->type =3D=3D THERMAL_TRIP_PASSIVE)
@@ -837,15 +838,14 @@ static int tze_seq_show(struct seq_file
 			c =3D ' ';
 		}
=20
=2D		seq_printf(s, "| %*d | %*s | %*d | %*d | %c%*lld | %*d | %*d | %*d |\n=
",
+		seq_printf(s, "| %*d | %*s | %*d | %*d | %c%*lld | %*d | %*d |\n",
 			   4 , trip_id,
 			   8, type,
 			   9, trip->temperature,
 			   9, trip->hysteresis,
 			   c, 11, duration_ms,
 			   9, trip_stats->avg,
=2D			   9, trip_stats->min,
=2D			   9, trip_stats->max);
+			   9, trip_stats->min);
 	}
=20
 	return 0;




