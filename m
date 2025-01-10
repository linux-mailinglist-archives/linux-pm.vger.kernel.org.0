Return-Path: <linux-pm+bounces-20222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F22B4A09146
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C40188E08F
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F74520E334;
	Fri, 10 Jan 2025 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="NXCKxYIr"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94F20DD7B;
	Fri, 10 Jan 2025 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513883; cv=none; b=hDTuKvvuOpqEB0Xjs6MOuMHtoY0oBlfldO7vVt40n5EpXKIOevc9H4iMaTdhtohIAW8Bdfj94t0eFNqrMiXu7Pi2uBQEQRUEThvyOAz99glMtEfOCDj36sY2axAPM/0tTdn1RpSzPozCMyQ92CyGXEy4eu+C7rD3vGISBxZHa0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513883; c=relaxed/simple;
	bh=JRpFs8vlso28oK3SQMqsTjUHBPUQoUM9MUibav8CxeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tra2uRPFR77pzf7NZa30hxUgsd8qkMrQ3sN5rJUr28weaXiFahcXHSTwHwgUj4RbvOd1kNFFE2M8nv5Vpvm4cfMCLdRGS3CSH6jbw09m1EFrf5xA78EHYvxzKbqYjeAu4cpi0BCQBoOP3vgSWR0Tckwukw5qSaCM9IEgVgE85Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=NXCKxYIr; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id f50eb3ce50cc4d91; Fri, 10 Jan 2025 13:57:59 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id BE7D78E05BD;
	Fri, 10 Jan 2025 13:57:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736513879;
	bh=JRpFs8vlso28oK3SQMqsTjUHBPUQoUM9MUibav8CxeE=;
	h=From:Subject:Date;
	b=NXCKxYIrookOoTkOJ1sxD0zSIy7H149+SFGIJgVO5Se1ki8QT6WX76nGmhBs+DTUC
	 lTaoiYZXDBfi2lXI0dUXKIBmluazpgUIgNCxt85fCioOdzdG0UrP1q7IYkQC3BblKt
	 1xz48WxNsRz5f1gjHNH7rLxiC/J7Md3u1r9AfE0n25Pk/EM4m+HEvermLHQI2VJoV3
	 92omZtOGvjrV57icUCAII6pVdwZLdPxy4bOnw/iAyjp+HvXsBQg1cRvoKePRHqP2/5
	 mGeQTDlbdi/ylJ4qXMx3Cgnr6smWKJ/aOZoq5dze/LG1h+ENzNPL+C5poL9MfBidDo
	 gvxqBm2I+Y0Pg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v1 0/4] cpuidle: teo: Fix and cleanups
Date: Fri, 10 Jan 2025 13:51:29 +0100
Message-ID: <4953183.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedggeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrlhhovghhlhgvsegrrhhmrdgtohhmpdhrtghpthhtoheprghrthgvmhdrsghithihuhhtshhkihihsehlihhnuhi
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

Hi Everyone,

This addresses a relatively recently added inconsistency in behavior of the teo
governor on systems where idle state 0 is a "polling" state (patch [1/4]) and
makes some other changes that may be regarded as cleanups.

Please review.

Thanks!




