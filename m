Return-Path: <linux-pm+bounces-14280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EE5979064
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 13:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37526B21D40
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44081CEABE;
	Sat, 14 Sep 2024 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="W3Td9nKu"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E217A12C54B;
	Sat, 14 Sep 2024 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726312604; cv=none; b=hzVX3J5eOmNLgH5hQtNfNBVIOYlkeIRoLBDoXQ3OyCF88j63ygqu6eGpCAWWQ8jtcvuaaln1D9Ymckr8rwPUITawqfa3RHgrhbaU5nRlm+U13b7cE9MAeqvSRYptj0yxAe58aONQs7O4Ej7d8l4UjHvrnaVbQg46RXwIrxVzA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726312604; c=relaxed/simple;
	bh=JOErgjpnuu04eN575aCPVd3VSulYPCTotICG8i3xd78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ie2BNGeMhEKJ9nSFR2VFGNgmhg+ft5rCQfr3poXYBmMQvlja2b1t/k5Mq+zx95HUuKNxuh3fbwP+QDG6wGNGhflsz0jE7/owWCViTyF9ulI7D+gWJTRAVGKjejpnd3PlVvZ1EiJq2EtXUMnqpAkeUdggeFwF2Wt/PLw4ZEJa93Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=W3Td9nKu reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id b6add2ec3eefa7e9; Sat, 14 Sep 2024 13:16:40 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6DC978532AE;
	Sat, 14 Sep 2024 13:16:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726312600;
	bh=JOErgjpnuu04eN575aCPVd3VSulYPCTotICG8i3xd78=;
	h=From:Subject:Date;
	b=W3Td9nKu925inZSXSM7nFxh60FG7LuEXb8pmm0mrfEtcCtARSu0gJCYmlMZTekDhA
	 vgPxNvQLCXMA5zTCSG2STZS4iGgJ68ZpfVvrm8k1uXOwJCpxWkcOLpvH44hp/8P81J
	 Mlp4F6FjtUe1Ul1HPZO9MYobQATyXmabEM35KAU5C+Kbq8fu8Pg5cH7Gq4BlA/kPWO
	 NYbS6A5bDEPR6OuJPhdgiZ+TYDRThwC9p6diRuxzYwjRFkxTKFLdopNT97GXvOvwB2
	 anj7Vr00fgSvVOZC/MXMTpMq+W/WdE+KahoPt5p96349mJeu62fO5XZJY6QKVs6nfa
	 Ag/n7OWoOJcCQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 00/20] thermal: core: Updates related to thermal zone
 initialization, suspend and locking
Date: Sat, 14 Sep 2024 12:24:08 +0200
Message-ID: <6100907.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthho
 pehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=50 Fuz1=50 Fuz2=50

Hi Everyone,

This is a continuation of

https://lore.kernel.org/linux-pm/4920970.GXAFRqVoOG@rjwysocki.net/

that eliminates a couple of races related to thermal zone initialization
and system suspend, cleans up thermal zone updates handling during thermal
zone and cooling device initialization and generally switches over the
thermal core to using guards for locking.

Please see the individual patch changelogs for details.

The patches in this series only received minimum testing (hence RFC), but
all of these changes make sense IMV.

Thanks!




