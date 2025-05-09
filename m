Return-Path: <linux-pm+bounces-26932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66341AB144F
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB8D1B673A0
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AFF29189A;
	Fri,  9 May 2025 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="uQo2FFZH"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C43290D8F;
	Fri,  9 May 2025 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795855; cv=none; b=kTY8xuIOBnD/C1PjTBRMwYkXOHJ0Gq8Ylap0nxifzJhy+sIeWxT1JQ4pBig4EVoS23Drnn6JSIcOD7Sih/7mf6OOZ7BljO+1zRuD8YG5R2OP+m5564vRtyFlHq7k/xsdJf5ioZHPZ+G9tR7FE+5XtKr60oZQ9GxMFQUy9q8HIus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795855; c=relaxed/simple;
	bh=4GBgrzvvN+4kJ+ed+nVHWU+vFzchSbWl69PMneh6zI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DKB36EfNlqohFYSxoDVjUjRfWb7uZWIYFWK5CIOr86R2CFCHcuITCuv35hsvfhs6ita44pi1Do43c2+7kK2mitPbdxxW1+1WkwOofiffcXhFNeRW2bT+2HrP9j87xRyOu6L3qq5pgo5VH9G6oqVbkzfF8a3pS6zxo7hHiUsJq/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=uQo2FFZH; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0B4C8666CB6;
	Fri,  9 May 2025 15:04:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1746795845;
	bh=4GBgrzvvN+4kJ+ed+nVHWU+vFzchSbWl69PMneh6zI8=;
	h=From:Subject:Date;
	b=uQo2FFZHPIayu0Frg80ym2MiZdkqShKX3nhF67L8uRLzv+w6zP3QfS/v6KzushWMy
	 eMVcxKDW5e2vuL2Ffff6/swNAT0T3awLdt/Gu8FbfIWp94YmfG03QFrzqj1UbS1zbz
	 0JyahHtItK9Es5EWcKmT+4dii5CKynrxsWobuZMuKiiwMOln4FCK26tmLKd93b5/Bt
	 aAr5q7eqiDSs96N2mwKzresYg/QKg0WE7SnwyEVOIrplmpEwkC6V+/lQ4UtYG7e+ET
	 EIDktwfkjMLPgmm3qFLb96zuup1Z47uLVj/XhvVUUDSbl4t0vBYw6MyvSjKXTbCLTM
	 2DTxqRIIuDhdw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1 0/3] PM: sleep: Updates related to pm_suspend_target_state
Date: Fri, 09 May 2025 14:49:59 +0200
Message-ID: <5903743.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppedvudejrdduudegrdefgedrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedruddugedrfeegrdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

Hi Everyone,

This allows PM debug messages to be printed during hibernation (again) in
patch [1/3], adds pm_suspend_in_progress() for checking if a system suspend
transition is in progress (which does not cover hibernation) on top of that
(patch [2/3]), and adds pm_sleep_transition_in_progress() covering both
system suspend and hibernation (patch [3/3]).

Thanks!




