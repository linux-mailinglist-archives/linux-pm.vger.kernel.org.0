Return-Path: <linux-pm+bounces-10718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 470EB928DEB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 21:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A2F1C210B6
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 19:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD412EBEA;
	Fri,  5 Jul 2024 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="X4Dsrhds"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B181E;
	Fri,  5 Jul 2024 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208884; cv=none; b=TJVz+gUt4TGZFWegTSLavvuGJV/Yj/F5gJIHtSE2P99QUnENKUT86k0zyAVoml+EU1Xn73xeweTuvEN9JSeFNtIklwKr3TJh5ftI3ZSOtnPD0u6ckAacatig5UKQVXSxWyNywiA+Wi6crXSlggSZ2zslHfEZHElcx4Nogi8mNtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208884; c=relaxed/simple;
	bh=xr2Rs3ik0o/ko8vTcT4/0UWvMxgQr1eWmVVC5TUP+oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DJBHdrFgykjLdEHDRfg+xMCeLPcL4AGu+kkUMKXylLYOfP8gcBp48gV7O22eMFzmJgrGMqrdCcBkH0RfDZZPUXQekF0G6Atudhq2wrm6+sPLQqirEkv5FMY3L+AGinnx8nK2V0vH9R9/j0e6J8F53GaoiHezUpt3vJGjGIUn7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=X4Dsrhds; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id d4ab92f077c671ea; Fri, 5 Jul 2024 21:48:00 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0C2067F5774;
	Fri,  5 Jul 2024 21:48:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1720208880;
	bh=xr2Rs3ik0o/ko8vTcT4/0UWvMxgQr1eWmVVC5TUP+oQ=;
	h=From:To:Cc:Subject:Date;
	b=X4Dsrhdsb7MZCJrmx17Cpx25XaefkmuO9If4302MGLRQhC0rtjnrmvF4FdVvcMMzV
	 XoLBkf0nnTyv3tI5mUJ/yZ2SbB0OVT1FjfC6btNjAdSh+2HrOW5StU/9nInWCKwdlo
	 jcjGc6O2+q+NjwxUPzvsY9XixB+b5Ex0Np/LZL32Dv/yweELSOO3XVHGDu7ddTfAkW
	 CFwOyUQ2fMQQgOkll2d0e+TMaWLAzHO7JI0IFowrlHYUZp1NCRK++vE2QQ0XF9kG9O
	 kaichiWhZeo0c9rVscPGvKHkJcx3BAgyrQZFrgnQo0J47yMRAvToClQbconDTurnte
	 OfRTCsv7FMjrg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v2 0/2] thermal: core: Sanitize polling delay values
Date: Fri, 05 Jul 2024 21:43:30 +0200
Message-ID: <2746673.mvXUDI8C0e@rjwysocki.net>
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
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugddugedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
 vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16

Hi Everyone,

This is a v2 of

https://lore.kernel.org/linux-pm/4585590.LvFx2qVVIh@rjwysocki.net/

which is being sent because the second patch in the v2 was incorrect.

These 2 patches deal with issues that may arise if the polling delay value used
for passive polling is at odds with the polling delay values used otherwise.

The first patch simply eliminates the need to worry about possible negative
polling delay values by changing the data type used for representing them
to unsigend int.

The other patch adds a sanity check to ensure that "passive" polling will not
be less frequent than "regular" polling.

Thanks!




