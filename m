Return-Path: <linux-pm+bounces-7698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49C28C1557
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 21:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF3A2831CB
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 19:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE6E82492;
	Thu,  9 May 2024 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Dv4w2OCI"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4AC7FBAA;
	Thu,  9 May 2024 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282273; cv=none; b=PEASYpMtfcFs/W5qCBKuNd5x9l0XAczzf2YM8HDTHRHnNcSBiJKjSU+jIfzL7bXR4l+pNX84G5z7RB53Q/Bks0he9B10aW0Vr4E63W9cOdjLbDZg7KMmm+L+DP4n8Ex4xJha+l5LSl3pZ81X42OGNZHGLova1ToGLMY6JbyzQo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282273; c=relaxed/simple;
	bh=9TH7xYV2r3k4IZIMImzh8JQm/dLSNPLQ/yaBEE8XBDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dR0xqYstlS5hx9uyiqUSU7CEi3uMEJRLBddux3thNVjQzQ1BTCXW8lqiF6iiw8f/weOH1Ko0ZgsiINNz6znwHuuZWRSbd1Er9ZryAAIO3fxFY+lK31w/i9BldugQU5GmVdrh1ekkPUiciUvwJ83cOnSLIS8Fvk7HU3QVj6lKnCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Dv4w2OCI reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id ce133ce02d53c444; Thu, 9 May 2024 21:17:44 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E80D1A524E7;
	Thu,  9 May 2024 21:17:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715282264;
	bh=9TH7xYV2r3k4IZIMImzh8JQm/dLSNPLQ/yaBEE8XBDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dv4w2OCI1J0MUee8p9stL1NnwNIrGkty3aNOkThwnyjJB38rnSiD9u0tkIEF6EpCD
	 rT2grUEW+7UijTfEwiWD1ubPJSLHLkuKXo7WBTMxB0bAFWw6s8bkXm9Vw1vMbbvhxE
	 bZGyXEqH3bKGYiL2pFyeUj9m70YUWF19HSGy1pQw0GMI2C6THHHIinKpAmFF/Tgjrp
	 mx3dkW6DIo1ATet7bjRw4lim9jHVv4iTBUxQYQpWlSLCfdCSbUjFI//L6L7bk5Ouvy
	 AEYnJEMiE37qZ72yKH+M7NxY8T2xk1hwQh9e/JNMp1iLxyC5oD8WQexTFDgeWsbr7X
	 nmG0tolNs7CbA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 3/7] thermal/debugfs: Print mitigation timestamp value in
 milliseconds
Date: Thu, 09 May 2024 21:13:17 +0200
Message-ID: <1892146.tdWV9SEqCh@kreacher>
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

Because mitigation episode duration is printed in milliseconds, there
is no reason to print timestamp information for mitigation episodes in
smaller units which also makes it somewhat harder to interpret the
numbers.

Print it in milliseconds for consistency.

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
@@ -789,8 +789,8 @@ static int tze_seq_show(struct seq_file
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




