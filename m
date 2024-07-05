Return-Path: <linux-pm+bounces-10712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC29928DC6
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 21:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94FA9B22128
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 19:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6254F170848;
	Fri,  5 Jul 2024 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="hKA9SSIB"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B6116FF43;
	Fri,  5 Jul 2024 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208044; cv=none; b=u5l2sDng4B1RzF0DPopvDt64q9V5jgiLw+PlWQQaGP37sCZdXkJ20UICoail0Wl30KZDVimHTWb4Y6Mn6KYl1VU6mN+cHymc7/KyPtzZzG//rY0BQs9D3Jqjb2OJZ/Wid+eYkCjDk8waRIy4cx96qUt35eGCnp/3MhpACLqcfVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208044; c=relaxed/simple;
	bh=q10SjI3kjD1CMjeLuNHAQc1nnmz7VXt02YiDk9Ev+8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyblEFxraUgf8njPfLhWyO1jL+9lihS8WJDbIsoUPuhhDCtt7OJpqCOEmaaFwiLNHYQXMsEHuiDaPwo5P1CGcBdzaLhYIcUu70OutRyQBcZ3znsVeQVrByQ9zu1NFFGIEBy/OP92tVlVwD0mK0HJCo+idNu1FpnHxput+KA2yhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=hKA9SSIB reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id c0a784eed57324a2; Fri, 5 Jul 2024 21:33:59 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D450B7F5773;
	Fri,  5 Jul 2024 21:33:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1720208039;
	bh=q10SjI3kjD1CMjeLuNHAQc1nnmz7VXt02YiDk9Ev+8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hKA9SSIBXbAgczYJoRXcSgvYPV+aI9eEeGryFBh/Fs5h26CyXfgc7oVX3mCGsVbXu
	 EmMUrKhI/dnpIbrTK3ylXEDdY1AJpW4Z+WTldST2BXpDa3G3VjAOmo/YV/RflXjv9G
	 twLUnLxhs6dak7JT5aeKolyhHYIEcvHsLsVmgzbIzcgMKHYxNDXyi3GxOHZzKIVCPE
	 Y7Uei8eEqx/daYzxJ7gm9WOv1R70FtahAykPyMDR0kgIz/plbHIVxtdP103lIZmC/D
	 0bN6v3YbQMlpeMDiOWuifVN0Rj4xdY3xvdhaIhasfVbgP6R82dfEWKlkJSjCMSGTO7
	 iXWe8TqOcozqQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v1 2/2] thermal: core: Add sanity check for polling_delay and
 passive_delay
Date: Fri, 05 Jul 2024 21:33:52 +0200
Message-ID: <13555515.uLZWGnKmhe@rjwysocki.net>
In-Reply-To: <4585590.LvFx2qVVIh@rjwysocki.net>
References: <4585590.LvFx2qVVIh@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugddufeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If polling_delay is nonzero and passive_delay is 0, the thermal zone
will use polling except when tz->passive is nonzero, which does not make
sense.

Also if polling_delay is nonzero and passive_delay is greater than
polling_delay, the thermal zone temperature will be updated less often
when tz->passive is nonzero.  This does not make sense either.

Ensure that none of the above will happen.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1440,6 +1440,9 @@ thermal_zone_device_register_with_trips(
 		td->threshold = INT_MAX;
 	}
 
+	if (polling_delay > 0 && passive_delay > polling_delay)
+		passive_delay = polling_delay;
+
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
 




