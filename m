Return-Path: <linux-pm+bounces-20584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AC7A14257
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 20:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839BC3A1F6F
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 19:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D32B236EA8;
	Thu, 16 Jan 2025 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="nZSlPKU7"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2054822FAD4;
	Thu, 16 Jan 2025 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055934; cv=none; b=a8EL8lk3zlf77ZzixMKMccUJDuO3U8lia9YUv2lFwPnqr/mtixB9Tm+w9glUDFMTX8NZ6O//lZwMGyoPYLLstuOez+baJe5dseSWNMmp5qs63UWL7/OTjc1kZ+lZIss/QAHaN8UqOuk4+uglGuk7MSsWzVXFeQwU0K6TqCQ89Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055934; c=relaxed/simple;
	bh=Ww4vYJMoMXRciDk/dWUyiWfFFfvamQZfovoQ24UEu+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eGaGXafC2aKeCBklb/57AH5dGI9ARfoyElTfCoqt0Ur9vDhMtHh+vshhusQgVaAiDcpUbG8wfQS8bqhCTUXiiCBmC5XWvD/Yp3ok31VSDica9/oGoVzlktNjJGFtmpHgDjvXcrNylbF/hPHpCmMN1MkcDOE16dX/Vf2gSWIMH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=nZSlPKU7; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 6aebaa1f6855e023; Thu, 16 Jan 2025 20:32:10 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 61B288E0B61;
	Thu, 16 Jan 2025 20:32:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1737055929;
	bh=Ww4vYJMoMXRciDk/dWUyiWfFFfvamQZfovoQ24UEu+s=;
	h=From:Subject:Date;
	b=nZSlPKU7/5DGWmgU7lkhXBz1f9zjE4K+pCI/26+j1jR+1C8ZcOJRgzrm0SGsmw6H7
	 czN6gibmnkY505x2CywSXBYZYV9FZFVmY9AJ9jOBK+ynFd+MdiKiDHhhZaqrRNnvcD
	 Rvitc0ZUi/UdfPPXP6LGIngp/xL4WLFpjC6akrfcvE7es+2IP2kH0XRZ1TLIQIKqLX
	 OBNyYsFhsMgIkxbTqEd1Wjc+8huqStWl5R2Q5lmoFsF0c+JquBON3TtqSKhVuRaC+I
	 1dBD6pprzYifXzZFr1Sz5S4t92S8Bi0IQoIhqRzXf7TMlhIQu4hnqZb1vNRO8wvnZO
	 OARGSWAMH7jzg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1 0/3] thermal: core: Cosmetic updates
Date: Thu, 16 Jan 2025 20:29:39 +0100
Message-ID: <2772026.mvXUDI8C0e@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

Hi Everyone,

The patches in this series just rename a few things in the thermal
subsystem and relocate a comment.

Thanks!




