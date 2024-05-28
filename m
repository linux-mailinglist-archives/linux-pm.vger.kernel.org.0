Return-Path: <linux-pm+bounces-8250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 056C58D1F77
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 17:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298B01C22D97
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED6B171650;
	Tue, 28 May 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="tjhNPlYT"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD69417083A;
	Tue, 28 May 2024 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908473; cv=none; b=k6Oc64fKZQKCGuPMh+XL62dG0lspEefBwi51ysiPF1eQJtVCcos4jPBmfISvGeC/2h42ceGL3+ySPIOr2SGZ/W8PlfsSdVZDBUlBpluzGSrqzYwNn62u5KDiqJGQu+G9w6CgIHxWqSqf0YlUyidZdEWR7QTzIZEkwW4ONaPrtvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908473; c=relaxed/simple;
	bh=t+17sNCq8vuCuCyh7gyt499Do7VUx0BR0N19GUKt2LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKrjw34OEEZU2N7Xsk/5quBbaxZ6W36dFklT2Mkj8I4ThW0luHd665AakpLmrHHp3mkgyuJG+2N4tXkM2FbXV6vTD4Vnj6+UukCqo0rEnZcQ5IieTXunTIUzwzqB42EcIKCuUneKEP4uT05tL9NPKobaQvMrcbolr4jhvAmLsz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=tjhNPlYT reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 86cd555c9f7e6b8f; Tue, 28 May 2024 17:01:03 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9E1936A5015;
	Tue, 28 May 2024 17:01:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716908463;
	bh=t+17sNCq8vuCuCyh7gyt499Do7VUx0BR0N19GUKt2LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tjhNPlYTlGkOlSYKfQTZSWfj+TofhCmHjSGWXfgx5MzN89kWKz2FHi85U19OKw2uA
	 t9hgdDM4oBibD+Ydzokd+CDXAZvPsD5GF0tFqCyX+kzLKbUUgjroqpdJmZVf4qdN0K
	 o6bezEWwCS7lHX0AwuqqTZCucHOc+BNQWMSDEBoFtkZn5Fkg2plkKkhkfiaZKqk5yN
	 xR+grhk99ItmKoSzbYEC7HdutWOQ61p3/iCJo+1fdZXsmWoQyHDCRVFZJHeNFAvv2F
	 h1lOYuza0Rn/Ow37/B5QFdYLsGYukMM8ZK6sSwUPVCh+0SwM6wCTJX86k+DYTnnUbc
	 I9jntoXRaV3Mw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v2 6/8] thermal/debugfs: Compute maximum temperature for mitigation
 episode as a whole
Date: Tue, 28 May 2024 16:58:56 +0200
Message-ID: <2279190.iZASKD2KPV@kreacher>
In-Reply-To: <5794974.DvuYhMxLoT@kreacher>
References: <5794974.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnheptddvfeegledvfedvveevhedvteeffeehvdeuiedukeeiledttefgvdeihffgteetnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that the maximum temperature above the trip point must be the
same for all of the trip points involved in a given mitigation episode,
so it need not be computerd for each of them separately.

It is sufficient to compute the maximum temperature for the mitigation
episode as a whole and print it accordingly, so do that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--

v1 -> v2:
   * Rebase.
   * Take patch [5/8] into account.

=2D--
 drivers/thermal/thermal_debugfs.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -94,7 +94,6 @@ struct cdev_record {
  * @trip_temp: trip temperature at mitigation start
  * @trip_hyst: trip hysteresis at mitigation start
  * @count: the number of times the zone temperature was above the trip poi=
nt
=2D * @max: maximum recorded temperature above the trip point
  * @min: minimum recorded temperature above the trip point
  * @avg: average temperature above the trip point
  */
@@ -104,7 +103,6 @@ struct trip_stats {
 	int trip_temp;
 	int trip_hyst;
 	int count;
=2D	int max;
 	int min;
 	int avg;
 };
@@ -122,12 +120,14 @@ struct trip_stats {
  * @timestamp: first trip point crossed the way up
  * @duration: total duration of the mitigation episode
  * @node: a list element to be added to the list of tz events
+ * @max_temp: maximum zone temperature during this episode
  * @trip_stats: per trip point statistics, flexible array
  */
 struct tz_episode {
 	ktime_t timestamp;
 	ktime_t duration;
 	struct list_head node;
+	int max_temp;
 	struct trip_stats trip_stats[];
 };
=20
@@ -561,11 +561,11 @@ static struct tz_episode *thermal_debugf
 	INIT_LIST_HEAD(&tze->node);
 	tze->timestamp =3D now;
 	tze->duration =3D KTIME_MIN;
+	tze->max_temp =3D INT_MIN;
=20
 	for (i =3D 0; i < tz->num_trips; i++) {
 		tze->trip_stats[i].trip_temp =3D THERMAL_TEMP_INVALID;
 		tze->trip_stats[i].min =3D INT_MAX;
=2D		tze->trip_stats[i].max =3D INT_MIN;
 	}
=20
 	return tze;
@@ -738,11 +738,13 @@ void thermal_debug_update_trip_stats(str
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
@@ -798,10 +800,10 @@ static int tze_seq_show(struct seq_file
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
@@ -842,15 +844,14 @@ static int tze_seq_show(struct seq_file
 			c =3D ' ';
 		}
=20
=2D		seq_printf(s, "| %*d | %*s | %*d | %*d | %c%*lld | %*d | %*d | %*d |\n=
",
+		seq_printf(s, "| %*d | %*s | %*d | %*d | %c%*lld | %*d | %*d |\n",
 			   4 , trip_id,
 			   8, type,
 			   9, trip_stats->trip_temp,
 			   9, trip_stats->trip_hyst,
 			   c, 11, duration_ms,
 			   9, trip_stats->avg,
=2D			   9, trip_stats->min,
=2D			   9, trip_stats->max);
+			   9, trip_stats->min);
 	}
=20
 	return 0;




