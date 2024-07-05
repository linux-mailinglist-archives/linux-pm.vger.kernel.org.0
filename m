Return-Path: <linux-pm+bounces-10714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86868928DC9
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 21:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4057F282834
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 19:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2209617109B;
	Fri,  5 Jul 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="u7m1pZ+0"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18482170842;
	Fri,  5 Jul 2024 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208045; cv=none; b=HlarVBftmucq7RYQ7eVJZRobF6QBUbMSll1EQbR3cBCBlnk/SXGoEpHeX4pf4QC89mLJH2/Pzq8DG1mXuIyGv0WmiUWH5BRps8agoezZUiVy+gw6xpG9fbvMSbqfi6jz4NsXeobXH9ftVT7hAmtdOfDsGy+zW/Y0QlwhpHZd1hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208045; c=relaxed/simple;
	bh=uXwfBNt2fBIUN4N6FYJ3HGg871ne8E1hTg5qJwdyU3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TkOogSkz50sFxrsffLcmGvPUnUuZby6q/Y6Nk//FeDWDW9aSa8oEOmd4N245LzGr8hhY55Oqm2K38nclE6trJdtGQ7OAYe/XEmZ1ZWOvoEPn6bTVLDZRalgEVhVlQJSjxt6yIFZAtT6g1L4/eiZouxW/jGB4WgnbfFPITrTqvVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=u7m1pZ+0; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 71fcfa07f419ad28; Fri, 5 Jul 2024 21:34:01 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8C5837F5773;
	Fri,  5 Jul 2024 21:34:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1720208041;
	bh=uXwfBNt2fBIUN4N6FYJ3HGg871ne8E1hTg5qJwdyU3I=;
	h=From:To:Cc:Subject:Date;
	b=u7m1pZ+0bdvhCQCCKT+qRHUHU5AwPHOvpQ+XKOW2hzPKKzlWswkNr6kqkEsdZ7Arg
	 5d2RALpVHCs62xjO5SqsDbEFW/AOGmWx0KZLsuF9vsihQQGVXf7EqOYcdFFlc48qOH
	 fQW1tE3tOxjrp2Z8m528yrXmRrRbC9RLRSel0KreL0dSpUFp23/66QtYvieZbzVfMY
	 F7xfINAg5GtTErE4KOsdvgqTZnlB+OL6cp+a2CkN7Sxy3L05r3Z5Rja5zPrU/2jSQB
	 LlKTGFoLE/IUI4+X2jl3WFfbDWDOhnR+MROtPaHZqQ/UdSqMLMK4WMYGOf0uopi96X
	 +o6s8s29FLf8g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1 0/2] thermal: core: Sanitize polling delay values
Date: Fri, 05 Jul 2024 21:30:06 +0200
Message-ID: <4585590.LvFx2qVVIh@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugddufeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

Hi Everyone,

These 2 patches deal with issues that may arise if the polling delay value used
for passive polling is at odds with the polling delay values used otherwise.

The first patch simply eliminates the need to worry about possible negative
polling delay values by changing the data type used for representing them
to unsigend int.

The other patch adds a sanity check to ensure that "passive" polling will not
be less frequent than "regular" polling.

Thanks!




