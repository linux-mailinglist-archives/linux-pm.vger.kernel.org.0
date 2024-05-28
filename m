Return-Path: <linux-pm+bounces-8252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 005178D1F7D
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 17:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868BE281C62
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DAA171E53;
	Tue, 28 May 2024 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Wzc5a65+"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4517109D;
	Tue, 28 May 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908474; cv=none; b=WStMTPMi4f6FTKxUYTjwa2P7RUSCxZRGpxNjG3TrT9bOHzhfAX/BXf/uetzHnwk5T6LLvO8s+Ke6+cUWrzD5/N/XkCNm2qxLMgtnlHLlE27OpXyJX77Pim72OLtBO6NitMhgSKZhBdXH9g/WbUQAvuwCCDkuDeIk0eS31jkl3Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908474; c=relaxed/simple;
	bh=tJjnmqBkTi8msWgW3IHCxMU/BeR3u3SJ2XDiT6tH350=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rl+uIrpEtQiGeOWK07sEIn6sSIi/0hMX+50lm0wwfPLY6Ceiw3C01cfahKAAyBb6LqHXAirllLhhUXWbgF5/rlOg071phWeQrqteNJpvWyQPIFyBpW10BcejlxXAfOj70VRoax309Pz5LwCrUXwDSXSithD7+Nqog62nFPHfbcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Wzc5a65+ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id b882543790f2134f; Tue, 28 May 2024 17:01:05 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D94156A5015;
	Tue, 28 May 2024 17:01:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716908465;
	bh=tJjnmqBkTi8msWgW3IHCxMU/BeR3u3SJ2XDiT6tH350=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wzc5a65++ay8xCSqAtfBONCkwC7PtfxqUjn96P6fUIP/nyRSIbU4lBC6MaxI1SGEF
	 /Unn9pzgw9NaB8/hdOgaif/J5qvaIwNuIU4OxRQzkRT0HIu3U622tlNJ1zMZ3iBnaH
	 nhOPax/aekzIHY9+qod5etqgZ7WQHNle31VrlvqBS0rsxPt8BiitGnGHbuggt40eFj
	 yMqwY2VVVn8VcKblIAaPHZLOyhf5J1zyF/sk5gV/Gvtw7yy9+99fg3UBD5HYzEfxKK
	 D/p0QQuno2U8OrSH3FXPTz9Z35F2Lp2BCYattVjrJahvPMdyP5Or0HJpb05KLjoRdM
	 sPwLETeAn0ojw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v2 3/8] thermal/debugfs: Print mitigation timestamp value in
 milliseconds
Date: Tue, 28 May 2024 16:55:00 +0200
Message-ID: <1898781.tdWV9SEqCh@kreacher>
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

Because mitigation episode duration is printed in milliseconds, there
is no reason to print timestamp information for mitigation episodes in
smaller units which also makes it somewhat harder to interpret the
numbers.

Print it in milliseconds for consistency.

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
@@ -797,8 +797,8 @@ static int tze_seq_show(struct seq_file
 		c =3D '=3D';
 	}
=20
=2D	seq_printf(s, ",-Mitigation at %lluus, duration%c%llums\n",
=2D		   ktime_to_us(tze->timestamp), c, duration_ms);
+	seq_printf(s, ",-Mitigation at %llums, duration%c%llums\n",
+		   ktime_to_ms(tze->timestamp), c, duration_ms);
=20
 	seq_printf(s, "| trip |     type | temp(=C2=B0mC) | hyst(=C2=B0mC) |  dur=
ation   |  avg(=C2=B0mC) |  min(=C2=B0mC) |  max(=C2=B0mC) |\n");
=20




