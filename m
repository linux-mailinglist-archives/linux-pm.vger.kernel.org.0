Return-Path: <linux-pm+bounces-22389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE7DA3B1F9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 08:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4C81886246
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 07:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948C51C07D8;
	Wed, 19 Feb 2025 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LuOTiDTX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1848F1B6D0F
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739948834; cv=none; b=EmbaHI5VRP0ofI74aOFl+sZXwPUV7k4vwTR3SwYv9f6wTUpYQjRhU1mlLy7GzCirZxNoaoH5QwFZY5ZM5dntxlvNyggRNcdgsDNME8Hacs1HIcF1TLdDKxO5+8YJjKOJXoCnC0Z2BBIentnFWjU7LG2DYuDPOi9H9Uco8Bv4a5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739948834; c=relaxed/simple;
	bh=Zyr4va1D3Ha0NHA7NgDMRD1p6wHO7uykIJRhpBQNyjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PBulgQemEYpvoGJp7uCkGtIsqYA1LU9n/tw8Cuoj81xOvvUvTUqB4Ih8mbn7KaEM4AxSKfv7K9p18R3wT7vly4gtnE6FVW2TZa3qAjbSRCILCSBqrKhD2TsBKU5NHNLcdhbpBE6eO1x1EA6LiNw1f+jc92BD4FKtufahUUQPrs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LuOTiDTX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220ecbdb4c2so131813545ad.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 23:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739948832; x=1740553632; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YfgGZzr21LaPimZ5BCr27eSGdmhY3cZSSOMxVIBi6/Q=;
        b=LuOTiDTXGvHn/cx8WRAA87qUrPgZGHPKtt1Kp3jOk2G88kJPOgJqFhZEZ+C3Yrbh3w
         DEA4U8Jef15yuxibJ9dqcgdeVn2BVtP0yFEie902hrNYlgpa7t2wvagu9Wdq0w1mycam
         82RbDtgUlTTnadK5I8bG5D8dP+2zEJS0hBku0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739948832; x=1740553632;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfgGZzr21LaPimZ5BCr27eSGdmhY3cZSSOMxVIBi6/Q=;
        b=Ybvkoy/P0VnkSNUNgwxN3U7Qnm7DXUHk103pjH7MagesjzenPlDUDfJMAwyHG7Wu/V
         W7M6XIszu+DTVluuZ7UjH4vQunEkk23ZZrnLKHlqkhYCc+3S1dFRM2RKpjXWfhOSr5mR
         KD8pipduP2CVLxFjyY000eVukmdMP3bUcBrrdR8iNRkX3Io7BaEiC5zP05Hro+6ORqxk
         tmyjn5zCUJMcvxNOpCDDdGOrgljbawGkuQd+91SXiAfqOBS7Gvk+KCH0wEBZOJM2bzQz
         iD3y2vHPCKEdSfZ8J+l61GnZdbftcnX855uDnkbXey0vNdA3lRprcg69/hX99wICOYnD
         Lo5A==
X-Forwarded-Encrypted: i=1; AJvYcCVm99y5TL0+YyfSP6zwCLJwBehJ7Cpq9PdX/izZXSPHk94iadM/syKilyOY34qVvxBL4Dq36mIPJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAQFgQBudLvBJzRSuZOaPXwxLOBVOnkm+2IiO/mXEzW0+jMAa
	YmCTjEimfbkaveXGATeUdz8t94NFZ7D7ZaECE+iar/IUacNcYH3Iarjays3FMQ==
X-Gm-Gg: ASbGncsSKuQ1dfFOG8lzUpZxxkMAoo7eTbKVOFkszew59rnC2NHRqr0tNBc/0SEd7Rf
	YlX87rfQKKDiu+NGIhvUctIoLFPnWlV0WNfDmE1lsZikS2FNUcLvLUnxP4q7X7ov/U4JZS1RX3Z
	v9F9QioFO0u8ezqy0pQvb0EwHeGetO+YOizPlGB9+bK41+W5SFND5Hen5dETgzm7sN8SxQ+iLkb
	Zneob50dr7ZSAhIe5BWxTWppYAWOqlsAyvZIBBmpF0BG+DtyXQR/+hu8fPe7cEfmhr0/IQWrSHq
	xPF4XyFB67oG5lUQOGjhzZrh4Qmz5+Usa+o=
X-Google-Smtp-Source: AGHT+IF0MpWDOqFRBnsjQsSAyFd02JvgmIfI/f1b3BYgfqScUk4w7n/fsE2EGQ3VkCQMhrfpdc9u6w==
X-Received: by 2002:a05:6a21:32a3:b0:1ee:c75c:bed8 with SMTP id adf61e73a8af0-1eec75cc221mr9646530637.26.1739948832381;
        Tue, 18 Feb 2025 23:07:12 -0800 (PST)
Received: from giver-p620.tpe.corp.google.com ([2401:fa00:1:10:224f:3294:90fd:ad2d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adf5ae6af3fsm4461016a12.53.2025.02.18.23.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 23:07:11 -0800 (PST)
From: Yu-Che Cheng <giver@chromium.org>
Date: Wed, 19 Feb 2025 15:07:07 +0800
Subject: [PATCH] thermal: gov_power_allocator: Update total_weight on bind
 and cdev updates
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-fix-power-allocator-weight-v1-1-79b1a99e94eb@chromium.org>
X-B4-Tracking: v=1; b=H4sIABqDtWcC/x3MSwqAMAwA0atI1ga0WH9XERe1jRoQK2lRQby7x
 eWDYR4IJEwB+uwBoZMD+z2hzDOwq9kXQnbJoAqlC1W2OPONh79I0GybtyZ6wYt4WSNqZ2ztqkk
 3XQNpcAil+p8P4/t+d6kZRGwAAAA=
X-Change-ID: 20250218-fix-power-allocator-weight-5dac6d4b5797
To: Lukasz Luba <lukasz.luba@arm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chen-Yu Tsai <wenst@chromium.org>, Yu-Che Cheng <giver@chromium.org>
X-Mailer: b4 0.15-dev-42535

params->total_weight is not initialized during bind and not updated when
the bound cdev changes. The cooling device weight will not be used due
to the uninitialized total_weight, until we trigger an update via sysfs.

The bound cdev update will be triggered during thermal zone registration,
where each cooling device will be bound to the thermal zone one by one.

The power_allocator_bind can be called without additional cdev update
when manually changing the policy of a thermal zone via sysfs.

Update total_weight when bind and cdev updates to ensure total_weight is
correct.

Fixes: a3cd6db4cc2e ("thermal: gov_power_allocator: Support new update callback of weights")
Signed-off-by: Yu-Che Cheng <giver@chromium.org>
---
 drivers/thermal/gov_power_allocator.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 3b644de3292e..600cb0e367c3 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -656,11 +656,10 @@ static void power_allocator_update_tz(struct thermal_zone_device *tz,
 			if (power_actor_is_valid(instance))
 				num_actors++;
 
-		if (num_actors == params->num_actors)
-			return;
+		if (num_actors != params->num_actors)
+			allocate_actors_buffer(params, num_actors);
 
-		allocate_actors_buffer(params, num_actors);
-		break;
+		fallthrough;
 	case THERMAL_INSTANCE_WEIGHT_CHANGED:
 		params->total_weight = 0;
 		list_for_each_entry(instance, &td->thermal_instances, trip_node)
@@ -731,6 +730,8 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 
 	tz->governor_data = params;
 
+	power_allocator_update_tz(tz, THERMAL_INSTANCE_WEIGHT_CHANGED);
+
 	return 0;
 
 free_params:

---
base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
change-id: 20250218-fix-power-allocator-weight-5dac6d4b5797

Best regards,
-- 
Yu-Che Cheng <giver@chromium.org>


