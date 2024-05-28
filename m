Return-Path: <linux-pm+bounces-8253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BA78D1F7E
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 17:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9261F281CC0
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 15:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129C3171E74;
	Tue, 28 May 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="riyBFEWM"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D30617084C;
	Tue, 28 May 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908475; cv=none; b=uEcxgzx363PB7SUxYU7DsHJIP187rJIHb2pS2Ue/sjSXfLp1ZozExvArtk3x9S91X4EdkFde/3yNfeevGyv0G1q1kJ+KCmWk8Fi3Co7v69rfjl5DHGcSGfU5+rIUDyCEIiEBcHdHNIo1tucmAPlmzA08n3p5vxOp+MIhg7U6tDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908475; c=relaxed/simple;
	bh=vW6qQdWS+x7HKH7tGvOAOqJMj5lDZHrUY+hgW3/qXG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z67T17uRS+CV7Bj5xY1c0Pfr0M500AeMx9iMYwr8bcmQ11sDSlcs2nj4R8U3ilxRVFvi55QbLTbuy76G/tHcZinuIocodU+4YCUghtCoKTuRZjSIloqYMh8A41KlBK+0JfrZYEWB6O6jYR0hlr0E+nkDH9htrpV4204GB4ijFUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=riyBFEWM; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 64c56ac2e6e07815; Tue, 28 May 2024 17:01:04 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1BEDE6A5015;
	Tue, 28 May 2024 17:01:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716908464;
	bh=vW6qQdWS+x7HKH7tGvOAOqJMj5lDZHrUY+hgW3/qXG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=riyBFEWMPyDNN8yEx8QEG7H7eOyNetD2cLRROO2tR1OIqDevTgFF7w4Wqlm9rne3U
	 YzGJ9RJ+Lx9EWwZfAuQuLgc+zty6SHPpJMHP0wqjbvvP6dBoiHiAcdWJITnavX4IzF
	 A72lVL9dIjzKC9N/Eqf2fjYOxUpEvSVY/OjV1EIqaftkM15xBcC/6vnbkhfPgoBpZF
	 L13/5hzDAzsD5QBnSek4ptBH3KoM7GhUmqdrNp3uPA6vi3OUwBlWZ85TJ461fIG6BO
	 wilRxn+Z45un8LljXG2RgvfKD56008duIgUtqAFkpEjNRIkl4HyW2nMPaNfoAJEEe3
	 uzx7M6dcQVjaQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v2 4/8] thermal/debugfs: Fix up units in "mitigations" files
Date: Tue, 28 May 2024 16:55:53 +0200
Message-ID: <13533101.uLZWGnKmhe@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnheptddvfeegledvfedvveevhedvteeffeehvdeuiedukeeiledttefgvdeihffgteetnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Print temperature units as m=C2=B0C rather than =C2=B0mC (the meaning of wh=
ich is
unclear) and add time unit to the duration column.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--

v1 -> v2: Rebase.

=2D--
 drivers/thermal/thermal_debugfs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -800,7 +800,7 @@ static int tze_seq_show(struct seq_file
 	seq_printf(s, ",-Mitigation at %llums, duration%c%llums\n",
 		   ktime_to_ms(tze->timestamp), c, duration_ms);
=20
=2D	seq_printf(s, "| trip |     type | temp(=C2=B0mC) | hyst(=C2=B0mC) |  d=
uration   |  avg(=C2=B0mC) |  min(=C2=B0mC) |  max(=C2=B0mC) |\n");
+	seq_printf(s, "| trip |     type | temp(m=C2=B0C) | hyst(m=C2=B0C) | dura=
tion(ms) |  avg(m=C2=B0C) |  min(m=C2=B0C) |  max(m=C2=B0C) |\n");
=20
 	for_each_trip_desc(tz, td) {
 		const struct thermal_trip *trip =3D &td->trip;
@@ -846,7 +846,7 @@ static int tze_seq_show(struct seq_file
 			   8, type,
 			   9, trip_stats->trip_temp,
 			   9, trip_stats->trip_hyst,
=2D			   c, 10, duration_ms,
+			   c, 11, duration_ms,
 			   9, trip_stats->avg,
 			   9, trip_stats->min,
 			   9, trip_stats->max);




