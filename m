Return-Path: <linux-pm+bounces-7693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE678C1548
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 21:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8FB1F2236E
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 19:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EB97F7CC;
	Thu,  9 May 2024 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Edh4Dhng"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE43B7E576;
	Thu,  9 May 2024 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282271; cv=none; b=pakLL+xNZrTYBFMQsxOrH2J+7C7N+fe6a7yp3/f163sG84amUFzg8C+/qgV0eXWSuDbIKp0wwOCdukzumGVW13GXDTu1dSWthz/7Ef+E708z+lAQeiLk1PkCBUTqsVxnM3MDNO7vtGKaeNhdBWyL2SIy1UJ3g44URiTJ4O677N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282271; c=relaxed/simple;
	bh=hfQu/7n4py57ijqfCDeYo/FIb/Jz4TjzngGAo2b5WRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iAn5PDhB+2qWbZsOtcd2ufkh6ulS/rsWgzmqoLVmuviEp0JEd3I6vNPd2/pI7f8bazofMCjleUp/FRKihmKK7+GCWqNqm7K7FA1MYIp3bTXvXVcnAzmIjSJ5muNfel/yEQfGT0USdiaEDiAELJa2GmzBChUKMchkQBck9S0ZNzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Edh4Dhng reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id c5fe2c6d1c71ddeb; Thu, 9 May 2024 21:17:46 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 43A37A524E7;
	Thu,  9 May 2024 21:17:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715282266;
	bh=hfQu/7n4py57ijqfCDeYo/FIb/Jz4TjzngGAo2b5WRo=;
	h=From:To:Cc:Subject:Date;
	b=Edh4Dhngr1ijKD6Hw/EBI8vPusd/J2iwvj+0k2kQ9VUKTx9SFGqslhsxVaK6yWURs
	 4DNxBb01m10vi3782LeNZHQnxYQQHohEazNfIYqxigWm2cxnOTxgDd94YUbwR302k7
	 EgdFRVqXSzsiY7BQAjdwKFs3I75TN1opQzgHBMYuLpv2Lgz9T95+3Q9yVlFbjtjZhV
	 DRk3D3zh8o5uvr0ayiBFH+02KhPGxbifFKITFqDXYd24Um2C49zmZ3KxQsFYH6rjP5
	 u8v/zaxkB5M3aIXRf/u68/LNn3pnp9k/JNQSvmzCr6OFqY94+I8yi8BdsD4RvXiMxL
	 1VYxz0J++UMWQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 0/7] thermal/debugfs: Assorted improvements for the 6.11 cycle
Date: Thu, 09 May 2024 21:02:07 +0200
Message-ID: <12438864.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdefvddgudefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggr
 nhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

Hi Everyone,

This series is for the 6.11 cycle, but since it is ready from my POV,
here it goes in case people have the time to look at it in the meantime.

The patches in the series address some minor issues in the thermal
debugfs code and clean it up somewhat.

Please refer to the individual patch changelogs for details.

At one point I'm going to put this series on a separate git branch
for easier access/testing.

Thanks!




