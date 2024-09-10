Return-Path: <linux-pm+bounces-13935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AF6972E8C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 11:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D22288253
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 09:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC83B18E778;
	Tue, 10 Sep 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="dGUdGZLR"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF3718B49F;
	Tue, 10 Sep 2024 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961392; cv=none; b=K9R09dLjcJQCW9haFHaiPCnKjH1+lDInf/+x1X9mxlAyCEnEo+O5M7Lgg0aWCfRPtyuw8sFUZTU/uZ1IDLPdFmgI6N9vPqs9bVbcHSwfn8O0ycxlwblJ2E9fL8kWCYRuQzr3+VxWw8QxVwMjAW3dtVFCkXjPrLjTvWrjwae39Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961392; c=relaxed/simple;
	bh=mvjLn9zFwJlZz0nGlnZNMMgArdG4cwCr0n5Xbf49/r0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sOsg96Q26KKjoyj2wWmIzVZ/4newYKPz+ug8m/8vHy8GRARvJUhzkhthDPDsmfYlUlLzXAYjtBs3q1Plbet10cHZKWpGcuRZZP6NDdpC+IvFW2s/SxhQGtmjlTZEWBXWh/K6Q2NzqKYH1ONskE1FHQdFhHjmZz7FxplV01dBUsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=dGUdGZLR reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 73940c6d5ef18685; Tue, 10 Sep 2024 11:43:08 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1C1F76B836A;
	Tue, 10 Sep 2024 11:43:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1725961388;
	bh=mvjLn9zFwJlZz0nGlnZNMMgArdG4cwCr0n5Xbf49/r0=;
	h=From:Subject:Date;
	b=dGUdGZLRWpMiSuSZFmDjW3pqK3NHxX40JutUuuA/gI9bylCqKq51XcBkgMAglllwU
	 PN6kzfLwm9LtO8tU52Zx3HZKGZjdgEGB/z4kmnMPYZzY08JWwcXBdm8e4xAaOpljUg
	 cAsuf6ITSTithV+evciAZVW+dlrvKXAT06kldPOCLaaV4xCK/eCZiIbO6BuQ9CEvab
	 umtCqrKKJcr0INsbgkMrCAKbrAwsS78aGovjmw0f/B4VfP9OEGJ3hoJ4RVXGnYzMBX
	 peiaRHPcSTd3snv0B7KnaG3vcKux8wK91GJIJPHYOFk99JwSedqqsp6ku6v7bAEqCO
	 disxLvaJs9a+w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH for 6.13 v1 0/8] thermal: core: Updates related to thermal instances,
 trip points handling and locking
Date: Tue, 10 Sep 2024 11:26:39 +0200
Message-ID: <4920970.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthho
 pehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=15 Fuz1=15 Fuz2=15

Hi Everyone,

This is a collection of thermal core updates for the 6.13 cycle that have been
present in my bleeding-edge branch for some time (they are also present in my
thermal-core-experimental branch).  They are based on linux-pm.git/thermal.

Some of them touch the same pieces of code as

https://lore.kernel.org/linux-pm/20240906073631.1655552-1-daniel.lezcano@linaro.org/

but these are complementary changes rather than real conflicts so adjusting
them to apply along with the above should not be a problem.

The first two patches move the lists of thermal instances from thermal zone
device objects to trip point descriptors, which allows some code to become more
straightforward, and clean up code on top of that.

The next five patches rearrange the handling of trip points while updating thermal
zone temperature to use sorted lists of trip points, which allows the total amount
of computations related to this to be reduced, at least on average.

The last patch simplifies the thermal zone locking with the help of a guard.

Please refer to the individual patch changelogs for details.

Thanks!




