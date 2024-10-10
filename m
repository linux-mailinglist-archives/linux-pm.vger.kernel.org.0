Return-Path: <linux-pm+bounces-15509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D3A999521
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 00:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86FE1C2303B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 22:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BCF1EC01D;
	Thu, 10 Oct 2024 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="NDXHXXSW"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C81E7C12;
	Thu, 10 Oct 2024 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598961; cv=none; b=qwLyuR3+mnPi9LObeE0+9+8P8JG9naCghomQUrvPSnAODtsEOpNvXvTEIMRslavFLb8QwexmHw+EYJ9A2/4IxNhDray+wNZ4yVE4V6b6HyFv0kJ6dXnEYR39k6qBnD11TtOD7iK4uxJATij+oAuZqigXmt6g92KaP5l2Gm/5WWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598961; c=relaxed/simple;
	bh=HA4TfzmPcQgOlDGx1HKQ4a7Us7mD3RLmcsM9rkBT370=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b4wxO+qenEJOY0tVbzSLU52CTsrSwFaYuKTY17lCXJaEr1rj+YIxyHfa/T1zfwJ47XkUIK6iPJPRo7Y6GBONqnlahGg2zc4XxX3RSv3rNmamGFbzFk2JFVTNIOkhXSNZOwtSUKra6sQKGhdnNci5dBjYpzp/CSuBQR2Dy4f8s/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=NDXHXXSW; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 66c1623ba68ce2f1; Fri, 11 Oct 2024 00:22:29 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B368369EF02;
	Fri, 11 Oct 2024 00:22:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728598949;
	bh=HA4TfzmPcQgOlDGx1HKQ4a7Us7mD3RLmcsM9rkBT370=;
	h=From:Subject:Date;
	b=NDXHXXSWAkb0AHeUfDwQtNoW56Tvn8vvKdnQ5hyBTqaV2dghgsOGXd6Zv6XDUPTrH
	 dRkBHZ1GkHUYg/I01GtKFUZDjpQyq+4sR3VFScHBlL0zRY7wXeDfMRFf8RF+bVVnjZ
	 hbl1xcgZKqZY6KVdRNPpb25ssvH1RDUvEsAoFHhX2ybpXo+iNeozsWu4tzWy4Qhind
	 6dvYW8W+SbY80gvHTqub5fE/EogsFle83IIOVN0UWRV505xzsfL47jokUrrqStciw0
	 tXf9aIqbCyztFrRHD3q8yd4gbuSDucXwxnSwx4LnokzRk6/NleTA2fLcr13iur4brV
	 JfLwtfCu9lehA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 00/11] thermal: core: Reimplement locking through guards
Date: Thu, 10 Oct 2024 23:59:35 +0200
Message-ID: <4985597.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrgh
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

Hi Everyone,

This is a continuation of

https://lore.kernel.org/linux-pm/2215082.irdbgypaU6@rjwysocki.net/

and (quite obviously) it is based on that series.

The majority of the patches in it are new iterations of patches included in

https://lore.kernel.org/linux-pm/6100907.lOV4Wx5bFT@rjwysocki.net/

and there is one new patch ([02/11]).

All of these patches are related to locking, but some of them are preparatory.

The series as a whole introduces guards for thermal zones and cooling devices
and uses them to re-implement locking in the thermal core.  It also uses mutex
guards for thermal_list_lock and thermal_governor_lock locking.

As usual, the details are described by the individual patch changelogs.

Thanks!




