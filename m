Return-Path: <linux-pm+bounces-20975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CDAA1D6FF
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 14:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86973A5190
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 13:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0131FFC65;
	Mon, 27 Jan 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="DnbJ5hxs"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7A31FF7B3;
	Mon, 27 Jan 2025 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737985120; cv=none; b=WyON3etRUefX9SbP5xpAsI2oSjw52EWosjCPdrKcdSIuLlmtWPPH/eDtNRjBgMAiYjwcWXkmDZR5OoFgwR2/3+wwfoTRo4WYDcyArReUs637PHtrQ5DNHBJGJnTxniet7YBE9FUQgtF2+Y3tcn4aA5W0tG47o9GSIf1keDoo5Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737985120; c=relaxed/simple;
	bh=Aw1EynysytPrYU9Bo9VQ1PaLQncnsejAB2ChhzN81jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DHEQVsWnrAjWVWcE5y2ROjUwaxqb10BPTpc8hYTnlTxieY5SGLTh/dQsS1GfPEMfuC2PtYPKWpeXEL58ZHy+ylnSYtFZ0HQsp2v6aDE19BK0s5RUD//FEv7yil0GOL9Cfzk+voF065KZCqKURWYOJIvGAJT2tvzFsXZ0EtBqBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=DnbJ5hxs; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 36f942c4d8f9dfc3; Mon, 27 Jan 2025 14:38:36 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3E8517524A5;
	Mon, 27 Jan 2025 14:38:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1737985116;
	bh=Aw1EynysytPrYU9Bo9VQ1PaLQncnsejAB2ChhzN81jc=;
	h=From:Subject:Date;
	b=DnbJ5hxszQ9L4DjyT+MjHRYBClHma6VzUaA5NyKi+Kk4PX3QBgJ+vd7sWPDnIe5v1
	 TAKJzR6nIj8n8ilRoue7efTJzXUdCFeHufY7BvysJ3SKVUz2V3PVcdnMVyfXaqJSvX
	 M5aQ6Bs0dB3zEMeyPstcCxDeTO73SL5sqNoVd1dQQI9RaVmwLjToNavo7sQzF02rzh
	 62s/zFLRF08K2I85p5gWjhNc1HUduCctm/8vLuLZx4hl2rta33peMwik/8Y6KHE3ji
	 BYMS3S+QjzAn6I/id1EdPHXMszDf/A5T/4IbTinuNbewwoPD4IOpO+uS4cuaEQl6SM
	 68ivzAu87rNjQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject:
 [PATCH v1 0/2] PM: EM: Two cleanups related to em_check_capacity_update()
Date: Mon, 27 Jan 2025 14:10:54 +0100
Message-ID: <6137833.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudeffeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughivghtmhgrrhdrvghgghgvmhgrnhhnsegrrhhmrdgtohhmpdhrtghpthhtoheprhhitggrrhguohdrnhgvrhhiqdgtrghluggvrhhonheslhhinhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

Hi Everyone,

The first of these patches gets rid of an unused function parameter and the
other one reduces em_check_capacity_update() a bit.

Thanks!




