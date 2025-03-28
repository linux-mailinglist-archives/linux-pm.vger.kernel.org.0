Return-Path: <linux-pm+bounces-24593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C240A7520E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 22:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F230B3B2F0D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 21:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB831F09BC;
	Fri, 28 Mar 2025 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="s+5s9tDo"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E968D1F4C84;
	Fri, 28 Mar 2025 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743196890; cv=none; b=sqwziV+55RpedJY9anybfpXyHtzfTkGgoajhWkUcOVEr93XABUfZHKWblC0XhxazgZbg6auOQWTd98uNgWEKDcCyT3xrzPTquR+r6k96J4vmt56BeYJYpog1GoLJiyZyIqY/CtYQCJ/HN77TWzs04510FxeKwbTwiEWVYWvDTjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743196890; c=relaxed/simple;
	bh=UGkLoJtbx5sNziafI54D/Isr65TKJvpRmSH3l1aSTGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RkyKnwuHHsJtXhbLFrJYsw92yeF70QUsoq4zrn5J77tRgX5PzfLqbT1OItRXnIh4fghN8GZJBdLI3FFekTk4rox66UlHcpG9fSS9wuSBvTI/z5VZSaVwLv/BCwXpBluu8tjkO69hx3J/ZD1+lwDI/QqLPcET7NIl4OL7Uq/YcHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=s+5s9tDo; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 4bc26fc8e0c88c91; Fri, 28 Mar 2025 22:21:26 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7E1867F0283;
	Fri, 28 Mar 2025 22:21:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743196885;
	bh=UGkLoJtbx5sNziafI54D/Isr65TKJvpRmSH3l1aSTGY=;
	h=From:Subject:Date;
	b=s+5s9tDoFatFzwfoe9/FuGyhTl3fMcDqCeFaNmnx4CxiXZzeDXaZlhDfuEB4Hs4Th
	 X2AiIPMNPQXk6RUAuEnYWglSJkCW0kJnCZ1LKmTxEfZIN6Te/zXHjRx27JfOeX1e8Y
	 cv7S94gq4REsrhIfveTmYhkRPMddr3j9IHqcvG4YGEaywIeI4DaQjqGINxTnGsTFDG
	 IM4/pQ0GXRQn9uFrZOlxpttDeojVVSccwOYhGrAkllaHFIWlvj9GWmOiV9Oxxyvhrj
	 rgTbe5ca65vtn99kGvOmPAu85NrLawTgsfhAvWDXIjlKctZxpn9wfGO+g4mIQgt7V9
	 vwTOkvDqvdGSw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject:
 [PATCH v1 00/10] cpufreq: cpufreq_update_limits() fix and some cleanups
Date: Fri, 28 Mar 2025 21:36:05 +0100
Message-ID: <4651448.LvFx2qVVIh@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrgg
X-DCC--Metrics: v370.home.net.pl 1024; Body=96 Fuz1=96 Fuz2=96

Hi Everyone,

This series of patches consists of a fix for a possible (and actually happening
in some cases) NULL pointer dereference in cpufreq_update_limits() (patch
[01/10]) and a bunch of tangentially related fixes inspired by it, mostly about
using __free() for cleanup and locking guards.

The first patch is definitely for 6.15, but the rest is rather 6.16 material.

Please refer to the individual patch changelogs for more information.

Thanks!




