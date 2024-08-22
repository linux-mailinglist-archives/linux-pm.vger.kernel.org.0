Return-Path: <linux-pm+bounces-12774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0813E95BF6A
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 22:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DD72852D3
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 20:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A39A152E1C;
	Thu, 22 Aug 2024 20:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="q3sjsLaO"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B0037700;
	Thu, 22 Aug 2024 20:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724357383; cv=none; b=UnWKyjc8DCkUaPgiAJoN83BgmYIq+q6FquU1PbttCndnuei8962QLRBwabFaRhVmu+VtH17YFF5Lzv8u4xFDH9hTrc+oeY6V6AlUx11L+16UD5ePHml+S/UVXK2rl+FWqpMb4boVJ6vYDikBz3HMFH2ehxqSu9Ed3NYJyieC0t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724357383; c=relaxed/simple;
	bh=/aCr6dS/9OHutYTsDjW5URvFHpmq9c+NYPO7+VbbgDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gy9thStk5NkeGIhIyxuuR1SFnVqTsPr+dYzhE2M89fXyrWuRqU7sxy+MOS/Jq5dN/JgrtbD+/4WHWtF2CC2D8Q3k80YJkLp4BgowEs60pnFL7X537WfbpDj0lU1xR8juT6ukRHoYfpys5rECDITiPSHBHM2fyZFBCWWDNhSzr9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=q3sjsLaO; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 1947d334ae102889; Thu, 22 Aug 2024 22:09:39 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 4C9C26F0E2D;
	Thu, 22 Aug 2024 22:09:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724357379;
	bh=/aCr6dS/9OHutYTsDjW5URvFHpmq9c+NYPO7+VbbgDE=;
	h=From:Subject:Date;
	b=q3sjsLaOTjzQHC3v2nIZ1Vinj0OnqmaebhC2dejSDB1YvsqM2ZGxyjHxdnQ6RtMwc
	 AWEVZUTXzKYhcHGY4qZjZCKNcXOeRoFl8OsQZRRiT+SUOQvYrCLmxP+B8uwNK5nUfK
	 hwMuvAT3O6tnzY3GS97WKUZTubEzg8lTxFmsv55Hmhuh+8u0JkNDRkf4pP6OtOadeR
	 s5r+QmeD6pxkLoOUcyEJ70qvJNmW5nZeta+AXI+NJ7Pk9YJnsXnWtxxTZ6glKoGQSH
	 zCtVDwrkiTAiwE2tDEbx+QngCLhra+YiVigF+95M4verxxMxc2eyCRwLJfwuDLBt56
	 eChBDGxcj7Z6A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Peter =?ISO-8859-1?Q?K=E4stle?= <peter@piie.net>
Subject: [PATCH v1 0/2] thermal: core: Two fixes for 6.12
Date: Thu, 22 Aug 2024 21:42:33 +0200
Message-ID: <3331194.44csPzL39Z@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudegfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegu
 rghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghrsehpihhivgdrnhgvth
X-DCC--Metrics: v370.home.net.pl 1024; Body=18 Fuz1=18 Fuz2=18

Hi Everyone,

These patches address two thermal core issues that should better be taken
care of in 6.12.

The first patch deals with the handling of polling delays.  It could be
6.11-rc material even, but it may change the behavior somewhat and it's
better to avoid regressing the kernel late in the cycle.

The other one adds some sanity checks for the temperature and hysteresis
of writable trips, to prevent trip low temperature from falling below
THERMAL_TEMP_INVALID due to an invalid temperature/hysteresis combination.

Thanks!




