Return-Path: <linux-pm+bounces-41363-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGkyLxhec2l3vAAAu9opvQ
	(envelope-from <linux-pm+bounces-41363-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 12:40:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 218A07534A
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 12:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DB3D309DCCB
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 11:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B335364E93;
	Fri, 23 Jan 2026 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nSdrrAIM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dtKSAdDx"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C716F350287;
	Fri, 23 Jan 2026 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168245; cv=none; b=ud9+JI2AK8Kg1RbVnvzXR9xWVJdZ5f8AOBOgvSuIiQtu8gcoUeu1Ev3zaKQTlvVwmr90ZON9AUTpzNiRGHktdbRR/jDvaF+RfpTtoj3opz5ctwlbMWX83VZ4zONP1m9tFnGL5MB+GrYYB0FPGluEm4sbKVSRa22tpmIP+K6VBtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168245; c=relaxed/simple;
	bh=AeU2Z3IIsBlH/V1K++fvb9gACwY6twtd0hhKij4PyzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayFY7zT2mTi1j6EtRAbbaesxaydoyrP4x+vJvCjQujEHIf5SoLlrtYbE8oq0hVeeJUnlLLNv/YE9Xmse6nB9qLPGU5JZAAGDULdIyPiv7RfW8f/I4SrmCHFlAxSDxhSPamDchfHtkeblE9VRH0QlqCJ6IBzia9xUnp4v9t3rwUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nSdrrAIM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dtKSAdDx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g77GafIFRqc0FAdTvsw1d/1g9d1E7FYjoasG3KTC0WY=;
	b=nSdrrAIMbTBrDTW8ANhRsJ+9Mg42AuCRulMgWsblu1bNIFoUutvvwe3rJ4LI8ptP0hnt4L
	uDr/4jOnp5nzWbO9pX4lAbibzTPFmn/dLBq3XcLevuwxA3ldp3FQF7UEBLkwHJj01d3XTJ
	gh+323wlP3z90FLCfOgouxzF315lyX9PKFypBEAOR9uvGHK7MCGbLK6cCCTKX1v6NZbxM1
	Wzhl20QVIGIQKCgBH5j2E9I9yrIfFvq8t8wyWqT4CPHZs6rtreePAWIuOmbXP8sS0AvJ1W
	UCDIFFbgmv01ifc9pD4vBqW18jpivEXUgZbAlpcNZNhOJUYxUqpHKKuZ7L9V/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g77GafIFRqc0FAdTvsw1d/1g9d1E7FYjoasG3KTC0WY=;
	b=dtKSAdDxeIGDiOjuPOdkckscFdN6lBCAftyjzK3wPMwV6dvojXjfz3yHri/y5XXMj6mdb4
	rdGXZvAgUJgqmuBg==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 15/21] thermal/qcom/lmh: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Date: Fri, 23 Jan 2026 12:37:01 +0100
Message-ID: <20260123113708.416727-16-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,linutronix.de,gmail.com,linaro.org,intel.com,arm.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-41363-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-0.941];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:dkim,linutronix.de:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email,linaro.org:email]
X-Rspamd-Queue-Id: 218A07534A
X-Rspamd-Action: no action

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.
The flag also disallows force-threading of the primary handler and the
irq-core will warn about this.

The intention here was probably not allowing forced-threading.

Replace IRQF_ONESHOT with IRQF_NO_THREAD.

Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/thermal/qcom/lmh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index ddadcfada5136..3d072b7a4a6dd 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -220,7 +220,7 @@ static int lmh_probe(struct platform_device *pdev)
 	/* Disable the irq and let cpufreq enable it when ready to handle the int=
errupt */
 	irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
 	ret =3D devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
-			       IRQF_ONESHOT | IRQF_NO_SUSPEND,
+			       IRQF_NO_THREAD | IRQF_NO_SUSPEND,
 			       "lmh-irq", lmh_data);
 	if (ret) {
 		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);
--=20
2.51.0


