Return-Path: <linux-pm+bounces-14262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA85B979017
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 12:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092CF1C221EF
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 10:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2561CF5D6;
	Sat, 14 Sep 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="BunJqhg7"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7968D635;
	Sat, 14 Sep 2024 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311066; cv=none; b=r+FwDi4L7u2Z65QwMATYyNR2bd4kVufiONWzqBqF3Rcc8OKQXfo5eAhy5oz6P7Ef3ZS09TYzWiohKEVDsegMfzDDEsKnWjwnM1dB1N8hj3uWV7OdeJ1iuHBh7LBoeXofzKiXUWicda1pOYpgr0n3WXuaHI8VJO6K32tY1hP6i90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311066; c=relaxed/simple;
	bh=cDtItHbdNGnN9iqgNK0L4DgeyKSEtRo50VDSA5j1JO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SkLvJKkK/R+UqW6KASBBtUGLai8Yc2IhA/3ktT8vLtOc2OUxVDAjFgsRcT1e+Q9ixaTFfO39bxRDpZdAmY8vF3Yet5snpyZEff+0dBNNiMRFIDaRRtB4fXdnMLahCQry65fbh1Pdy2OVQvzklYNfkNLYYmhbPLSsTmct2ILZB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=BunJqhg7 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 35d387eeb166edd4; Sat, 14 Sep 2024 12:50:54 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0FC178532AE;
	Sat, 14 Sep 2024 12:50:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726311054;
	bh=cDtItHbdNGnN9iqgNK0L4DgeyKSEtRo50VDSA5j1JO4=;
	h=From:Subject:Date;
	b=BunJqhg7Jj9W996RPxTobbMZRfdeuWWbejTd4TRNdULLdp8qEBkMGg+/WBcvx2vJR
	 iho5Ue+zadrqVRrzpSUgA+Fj0K7v8FR0FDrmdDUJcsmHcAASit948DFPy8dSIL3ILW
	 TjLJ3TyD5K4ZSOXIb/hL/mVf3MfvEnmrPek3ZZ9cwxNCNnkLblpzE8JyfAFpl3B45N
	 3KVhUbz38n/c38MYaUAtPr5auTw0kUrz2bB9hw/Oad5NMNzlL+z9vSzR13EbYGc1Sa
	 YfVNkN6ZbSg1yBJv195Z0mojJ8AH5l40h/WmzE3i8CPB7NMTnleHmR9ELGJV+Ljrxl
	 d41/aZ+lPsvbw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 18/20] thermal: core: Call __thermal_cdev_update() on
 cdev unbind
Date: Sat, 14 Sep 2024 12:48:22 +0200
Message-ID: <2227092.Icojqenx9y@rjwysocki.net>
In-Reply-To: <6100907.lOV4Wx5bFT@rjwysocki.net>
References: <6100907.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When deleting a thermal instance from a cooling device's list of thermal
instances, update it in case its state has been determined by the thermal
instance going away.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -864,6 +864,12 @@ static void thermal_instance_delete(stru
 	guard(cooling_dev)(instance->cdev);
 
 	list_del(&instance->cdev_node);
+
+	/*
+	 * Update the cdev in case its state has been determined by the thermal
+	 * instance going away.
+	 */
+	__thermal_cdev_update(instance->cdev);
 }
 
 /**




