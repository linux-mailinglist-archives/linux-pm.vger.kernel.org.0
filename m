Return-Path: <linux-pm+bounces-35026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669B1B893F5
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 13:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120F2170744
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 11:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176EC30AD1C;
	Fri, 19 Sep 2025 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNI5CHnQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA919D082;
	Fri, 19 Sep 2025 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758280945; cv=none; b=eXDtVqR52X+bRSZuojVOZgOota9co5+rKYP+O0V+mCHRyxGmNDYKZlnLXZ5vCALN6AX2IpVcsyvwZc2U0/z780AXJuROwZW5vXnlqxPjYhH7CNhW8GgZr2M0cgTzHJKD54MrLeTukVAUkb5EkgesN/1a/+1aSVdK0rPssXP+NVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758280945; c=relaxed/simple;
	bh=gwOu1hDDZ7oz3v/TSybV3mchNVWYM9CtHM03CNGZoRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j3chMBIuvTytbjn7M8T3ctAnYa2K6Wx7MBs7aAWA3wh8Tt5XlZxctDeThlpuCVAhGsJgIxJqiWZfITjs7BgW2Ogf+zi3qlIu0Ra0mAeDiWOG83vmGrQrYq7etAQbbM4CbDehTXg8XO2FiADJ0kiZrUNjarDBjiaPCW/URWNPsII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNI5CHnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D0BC4CEF0;
	Fri, 19 Sep 2025 11:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758280944;
	bh=gwOu1hDDZ7oz3v/TSybV3mchNVWYM9CtHM03CNGZoRI=;
	h=From:To:Cc:Subject:Date:From;
	b=cNI5CHnQd/V/7aV4p5vXBufMebCefC4z/PrtC7lXboKQnueRtTRYdTHJeZt943YkQ
	 3cgvvN6OiG6YnECzwsnneSm26PBzvTm2GRYPfTAWC2rIIC2MXBWCl3NfyoevNMru5m
	 uywF578Zcq2sGS1j2cZdQYn06iFddTzBAZb65NcakwOvlU7/Dqg1BBSspoUNprs3Ka
	 5TKmxvz8rJQ+ZAQMWgy+1EauNM4mC3H2+iR95T5CdfbiY90TMWwiG1soQF9Om0cXrY
	 LKsCQefhAFYD3cyndrSeW8YRJVQZvxR5Lh4gktNA5d/DEGj+SApJmXwlRsTmkUe6Fv
	 3/oL8wrBRWEDQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Dhruva Gole <d-gole@ti.com>
Subject:
 [PATCH v2] cpuidle: Fail cpuidle device registration if there is one already
Date: Fri, 19 Sep 2025 13:22:20 +0200
Message-ID: <12749587.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Refuse to register a cpuidle device if the given CPU has a cpuidle
device already and print a message regarding it.

Without this, an attempt to register a new cpuidle device without
unregistering the existing one leads to the removal of the existing
cpuidle device without removing its sysfs interface.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Add the new check before the driver module reference counting (Dhruva).

---
 drivers/cpuidle/cpuidle.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -635,8 +635,14 @@ static void __cpuidle_device_init(struct
 static int __cpuidle_register_device(struct cpuidle_device *dev)
 {
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+	unsigned int cpu = dev->cpu;
 	int i, ret;
 
+	if (per_cpu(cpuidle_devices, cpu)) {
+		pr_info("CPU%d: cpuidle device already registered\n", cpu);
+		return -EEXIST;
+	}
+
 	if (!try_module_get(drv->owner))
 		return -EINVAL;
 
@@ -648,7 +654,7 @@ static int __cpuidle_register_device(str
 			dev->states_usage[i].disable |= CPUIDLE_STATE_DISABLED_BY_USER;
 	}
 
-	per_cpu(cpuidle_devices, dev->cpu) = dev;
+	per_cpu(cpuidle_devices, cpu) = dev;
 	list_add(&dev->device_list, &cpuidle_detected_devices);
 
 	ret = cpuidle_coupled_register_device(dev);




