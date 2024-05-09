Return-Path: <linux-pm+bounces-7696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321618C1551
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 21:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0F81F22DC0
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 19:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73A58005B;
	Thu,  9 May 2024 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="BpuNagfE"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B939F7F7C7;
	Thu,  9 May 2024 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282272; cv=none; b=CesZ66hjXdiaMmVC1wvL05TpMlmBEeLMyGiDTHSypVF2EebnknqoxYgxjE3V/Tus4qL6rHhqoESXZ2k2xOFj9pnmdQaBHA3zOzxEbSjcW7boQuWRMA/AmZTZAetMCOWj7MH/oJCKOVnOCRT9YD8r1mxb5266j3A95ExYP5yKzXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282272; c=relaxed/simple;
	bh=w7hl8f75TBp7AGYlTLjWYghFPj6/vgqEA8DZpRjrTSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDwPDXZoJD9JjthjqKCfOaUlEwbq4ce5WU78QYCQUwlqpkuM2nYj2VcH6Rw85HSceP27RuVCcLk31elN0yv4uImZYA+Jz+AWX0+S0PEREhtvEhGHRN3mrOD8sDM5MJQpQUC1dU5wKGOveh+AjGS5W4c6vHKwH/mlRNC0oXvNzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=BpuNagfE; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 30a928e63f7562ff; Thu, 9 May 2024 21:17:43 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2750EA524E7;
	Thu,  9 May 2024 21:17:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715282263;
	bh=w7hl8f75TBp7AGYlTLjWYghFPj6/vgqEA8DZpRjrTSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BpuNagfESfQ/zGd63tvEI9eKWPLS0QqPfVY5taSWC5e9VkWaFIOcK0w6PGHyPposp
	 o+eyYxC9eqPQYxBXG/s1zQ3A18v3ZR0+UbXkeDfWqXl2lwtMWMN/Nn+0SlOIm374ED
	 bijKCcyaLST1k0DnudnhwVH1UBEa301rWGGIMX6J31vhRYAn8bMs0W+KkQQhPX+yRV
	 4R1gp1uTbUhmwTyeZil7Jo6w1VXmJrveWki6CPLydGTg7DOJfOtsiH+lzzI9CjZ7CP
	 3FpG+IA53k6laSw5oxXvx3P+3Uo4wSvsDXzAPptKBrgr3TS5K4lsFfVPR44c1AZh++
	 qJIL+tmgMBJPA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 4/7] thermal/debugfs: Fix up units in "mitigations" files
Date: Thu, 09 May 2024 21:14:27 +0200
Message-ID: <13515448.uLZWGnKmhe@kreacher>
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

Print temperature units as m=C2=B0C rather than =C2=B0mC (the meaning of wh=
ich is
unclear) and add time unit to the duration column.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/thermal/thermal_debugfs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -792,7 +792,7 @@ static int tze_seq_show(struct seq_file
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
@@ -842,7 +842,7 @@ static int tze_seq_show(struct seq_file
 			   8, type,
 			   9, trip->temperature,
 			   9, trip->hysteresis,
=2D			   c, 10, duration_ms,
+			   c, 11, duration_ms,
 			   9, trip_stats->avg,
 			   9, trip_stats->min,
 			   9, trip_stats->max);




