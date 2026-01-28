Return-Path: <linux-pm+bounces-41595-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBqMCrereWmuyQEAu9opvQ
	(envelope-from <linux-pm+bounces-41595-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 07:24:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF469D666
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 07:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D0583008D00
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 06:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A45B31062C;
	Wed, 28 Jan 2026 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d5mvaivJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A6330B31;
	Wed, 28 Jan 2026 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769581490; cv=none; b=ng16dgjTKZlyomh/FTJzPivOekOg8mPY+L2s+8ZyLWZezdc7wSaP1tbWb4IBiKTLvk/o7+F2+CAPPiE89OHNKTLmRGsMRtVX+RmBXjS8ihiDEhxDfLvTYBag2ugAUpWVZJplDMllmqmigSOq3ZrvRDz247LN/DuFSwyXrJMsjDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769581490; c=relaxed/simple;
	bh=Aj840i3t8N/IfrKjgfmfivLFXelgXPt3F1t3K8hNwb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tn4HZeG/BeBcci7DHzlUy/7F1tI968E4c8TrZd4ygjHFDynK7ZZ+HetUnRwyt6TkMouSYfD39hpgM9011viGGJ8YGl5iDzVpL30Y+VdRsxZGYo8HAtuQ9cIvXNvubetMRiqvxwPcEv5gOy0+MT8VVi9aOz5YO37xrV/unbJWqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d5mvaivJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kq7sVIAkYdC0Wk2OlT/Wy5PiLugRPhnx5YAvBde7JuM=; b=d5mvaivJWOPWUjuY8tesLaYy2c
	eZvbv5XXwjIFB2OTOGPTHYKuW9UKne1aDDljezSyuZeOrSuEMZ2/DqVHyzRljO9O4N+HuHFrreup8
	ikkk1lIiYjNnAwEYRO6BnGuzQ1P+Aw6+iM5GkFoB8GGCz0pRqwiRy953fw7KJvXbZ7+98MTWGTLCG
	gIZSNPjUHQiecYgA+W9BTlpx0EokwwNJ6HdlqvQwOw9p6BjRp4zPBg+0i7oosv3PLRmAeQ2qS5oGA
	BaBkQhcT31t3dM2nnliod67Lk+FGRpDebv11UJJqcd9yEPGvF+gd/alY6cEi3htuLSVp7O87A8kvi
	QMAx2lAA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkyyt-0000000FXHc-0xZ3;
	Wed, 28 Jan 2026 06:24:47 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] thermal: core: thermal_core.h: fix all kernel-doc warnings
Date: Tue, 27 Jan 2026 22:24:46 -0800
Message-ID: <20260128062446.402175-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41595-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,arm.com:email,linaro.org:email]
X-Rspamd-Queue-Id: 2EF469D666
X-Rspamd-Action: no action

Resolve all kernel-doc warnings in thermal_core.h:

Warning: drivers/thermal/thermal_core.h:99 bad line: trip point.
Warning: drivers/thermal/thermal_core.h:101 bad line: passive trip point.
Warning: drivers/thermal/thermal_core.h:152 struct member 'trips_attribute_group' not described in 'thermal_zone_device'
Warning: drivers/thermal/thermal_core.h:152 struct member 'debugfs' not described in 'thermal_zone_device'
Warning: drivers/thermal/thermal_core.h:152 struct member 'user_thresholds' not described in 'thermal_zone_device'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org

 drivers/thermal/thermal_core.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- linux-next-20260126.orig/drivers/thermal/thermal_core.h
+++ linux-next-20260126/drivers/thermal/thermal_core.h
@@ -77,6 +77,7 @@ struct thermal_governor {
  * @device:	&struct device for this thermal zone
  * @removal:	removal completion
  * @resume:	resume completion
+ * @trips_attribute_group: trip point sysfs attributes
  * @trips_high:	trips above the current zone temperature
  * @trips_reached:	trips below or at the current zone temperature
  * @trips_invalid:	trips with invalid temperature
@@ -97,9 +98,9 @@ struct thermal_governor {
  * @emul_temperature:	emulated temperature when using CONFIG_THERMAL_EMULATION
  * @passive:		1 if you've crossed a passive trip point, 0 otherwise.
  * @prev_low_trip:	the low current temperature if you've crossed a passive
-			trip point.
+ *			trip point.
  * @prev_high_trip:	the above current temperature if you've crossed a
-			passive trip point.
+ *			passive trip point.
  * @ops:	operations this &thermal_zone_device supports
  * @tzp:	thermal zone parameters
  * @governor:	pointer to the governor for this thermal zone
@@ -111,6 +112,8 @@ struct thermal_governor {
  * @poll_queue:	delayed work for polling
  * @notify_event: Last notification event
  * @state: 	current state of the thermal zone
+ * @debugfs:	this thermal zone device's thermal zone debug info
+ * @user_thresholds: list of userspace thresholds for temp. limit notifications
  * @trips:	array of struct thermal_trip objects
  */
 struct thermal_zone_device {

