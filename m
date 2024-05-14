Return-Path: <linux-pm+bounces-7824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AA68C4F6B
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0B81F22EAC
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FF413F44D;
	Tue, 14 May 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QiX0W+fR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NM+t7ENq"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5A86AEE
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681943; cv=none; b=RoGeLS9loIOPD98aLtMwBHpSNY6Ku4s+5gqU03ZIgtVucXqqpnOYXjx/rAzW5gOi1fsC0Ti6eu1IHvRQYZJ6JKYUW/ZqIrt+ev2/BmQUSPwfEqfro++S7WBpYSpkPpaU3dyYwBkxiyMFUKKBtWntUvTosoz+CinQqrMkEP6+bq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681943; c=relaxed/simple;
	bh=9rErEuln4y191cMzjN3JuvF+EeU2Bd+PIEmJcZ4O4fQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FQdi78K+gfNLxEVhs9z87F16z3EWImLwx1o+Xjt8m7P3JLySGL8x2M2i/SkbsJuJvzSkpu55bZ8CuUlIyO7a/4QdsjOg6hlg2zE9hRKHO+iqgAGnP/lP6WRtNSPm8eCPx5bosbUA7kLX07Xj//bQdqN499e86auDAIHFys5nzKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QiX0W+fR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NM+t7ENq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk5CgS6B5oyNLclqCex58cIw6ZWGR4IQZAog646r55s=;
	b=QiX0W+fRyLI24UNxTCRlKLXBh34K/L4jhVKkM4Y56u8DOMKamON2uKnkywcXIVkEqEXT+O
	Nf8E5n3ErNqp50jsjGDDIFAO+vBSTJOlBwHJRVTPz5Ez4nu9V0qSv/L56ZrDM2vGjbBj+N
	ODU60LVOpQdADGkXRQ6uUI6A4Sm0MprYZczqeBTJLaiSMXeYgW+hr9sNcfjy/n0deBSqDb
	HgX8cka7s2ZBfMzzSZlH46+67exUfwSG60wfbH/eVGu5w5NA/lbsqd4KtD7noN0cQGQa6D
	dMY0YLjMGuFFXtiOuwOtNvqY8IpnTNXDJNUof2o/IwyHj0ZZKSkPeygj16kiCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk5CgS6B5oyNLclqCex58cIw6ZWGR4IQZAog646r55s=;
	b=NM+t7ENqjF9e8dfqDMUL/OeGCY1LpUXUeKD7ykUuFQce/1zXCT7HPd/qfMc8F3i83zXLno
	KTAAPyFobhlT3XAg==
From: "thermal-bot for Dmitry Rokosov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/amlogic: Support A1 SoC
 family Thermal Sensor controller
Cc: Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240328191322.17551-3-ddrokosov@salutedevices.com>
References: <20240328191322.17551-3-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193533.10875.6369416976926253190.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     7fcd7dfa5ec29afe0b3fe8ad6a5f42c19e71d6be
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//7fcd7dfa5ec29afe0b3fe8ad6a5f42c19e71d6be
Author:        Dmitry Rokosov <ddrokosov@salutedevices.com>
AuthorDate:    Thu, 28 Mar 2024 22:13:11 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

thermal/drivers/amlogic: Support A1 SoC family Thermal Sensor controller

In comparison to other Amlogic chips, there is one key difference.
The offset for the sec_ao base, also known as u_efuse_off, is special,
while other aspects remain the same.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240328191322.17551-3-ddrokosov@salutedevices.com
---
 drivers/thermal/amlogic_thermal.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index df7a5ed..cd4776a 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -220,6 +220,12 @@ static const struct amlogic_thermal_data amlogic_thermal_g12a_ddr_param = {
 	.regmap_config = &amlogic_thermal_regmap_config_g12a,
 };
 
+static const struct amlogic_thermal_data amlogic_thermal_a1_cpu_param = {
+	.u_efuse_off = 0x114,
+	.calibration_parameters = &amlogic_thermal_g12a,
+	.regmap_config = &amlogic_thermal_regmap_config_g12a,
+};
+
 static const struct of_device_id of_amlogic_thermal_match[] = {
 	{
 		.compatible = "amlogic,g12a-ddr-thermal",
@@ -229,6 +235,10 @@ static const struct of_device_id of_amlogic_thermal_match[] = {
 		.compatible = "amlogic,g12a-cpu-thermal",
 		.data = &amlogic_thermal_g12a_cpu_param,
 	},
+	{
+		.compatible = "amlogic,a1-cpu-thermal",
+		.data = &amlogic_thermal_a1_cpu_param,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_amlogic_thermal_match);

