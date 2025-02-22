Return-Path: <linux-pm+bounces-22710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16209A40547
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 04:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90137707E59
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 03:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B22A1FFC54;
	Sat, 22 Feb 2025 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ugl/1YNX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3F7E765
	for <linux-pm@vger.kernel.org>; Sat, 22 Feb 2025 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740194456; cv=none; b=mIqSBtuMK1kI7gU7JQZ8EK7qyaK9Fz4tP+ImtuQ219FPVYPW0XhEd4XCJ88msLH9s9pfwZy6WobG3VxGW6XauKnKthlTiTy1EId4K+JnAgHqQkUPcj+KCBzGcHwcrPswbi9MkR6/TTxI50rRcFQTSDzjOWW3RBmAf6e7UQZ3IPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740194456; c=relaxed/simple;
	bh=T8gjTPsyxGgKvQIHkS3roTDPyGqo8pES7juNDBDBGuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Lx2mPkg+9d1VTSJoT+ftsLtVFryE90QcTVdyrzRVBfJ3G11E5ebJi2+Rzt9ZHnepgkUo94kF3pCL+t99ARumHg6imM37fCWhslLTYDxRC7kzU48bIUhyFYzJDrE9EOXpPajK8mpEuVkys/WwaABjsLBr/IlwQ5nvVbOBov3oGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ugl/1YNX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c2a87378so48531545ad.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 19:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740194454; x=1740799254; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H3y6iz+44k4SeW4sw7BD8Qbz3uarJRE6aXetm/8ariw=;
        b=Ugl/1YNX/+AkF/TPiXstXe8606+dfLcJYGXZqwJuQWOsSaw6bqV3RObPLFQc0jAk4J
         vCFCIML9OtowY/PYBTVMhVVNzaR0+Zy4LP4/c90QaDFiK2odnhnUNfMFbUZlwnAD2n4R
         1IO7ucr9/ND4hVpCZPT5yENi0aj+n5sreEoOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740194454; x=1740799254;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3y6iz+44k4SeW4sw7BD8Qbz3uarJRE6aXetm/8ariw=;
        b=QT81zCrHESOjJ3kl+BINhYYjD3ulK70H+TckxtuF0J//x3DgOb2lRMyxKwoIUx/rj0
         dKzWCuJWpg4Yna4s+MM0fju9Y1oApy2ZyenvWavA0Ms+yh+OGTkwo3INfR/y+KqkARSk
         MEKr0dryoluuIydP7IRUSab5Vt6RiaB4FWfd+U4mbchEC//TsR/lWvhWM/rNa2smhf3W
         Uq2t2t58dffflY9ZS0NnjYaThLyAqyYtu1a0ilA58axjEYlE3UQRZFbL30tHSeiE12vz
         0gtrIvopJVI7v8HU72E2kfUEukIy9SFHKuAIV9AA0bBxh9l1fMppR6OVQq9oBW6c0+ZG
         a2zw==
X-Forwarded-Encrypted: i=1; AJvYcCUrReGsyVjgYQ3uZYMhACIDUC3lXXA2Yy6juVG2ffHgm71z51BTPpUJT5ysKzwvWTSH77BUiyydSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDQUCB6AxWodaazVEJizFcJqvEfpTXDvw/goxUZNqCpRtBqinY
	+cYQFOkL84EWcTAPy8OhdWpuLCj/ZrpshUmiS/7oZdQP66eljwNCf/1ZfDBcHw==
X-Gm-Gg: ASbGncv+DtDPwQwmk2Kgs0caPA1lTAN5sB55VFqee2WAanqCfcAfmFzJ2zoxf8rYWki
	4AsPXCK8bIcNexR7CHRxrOISkFDGKCFjo/PI45qRahcQbBYHXj4RneVG42crwkGDmS39OhrpKnB
	1a5TfDNMfztwX0jGfxbr0keWZHe8Jb6s3yP46bBxvIUkAHkvNBxq2Jqv0pU66FN/Fer3opI2l/A
	k/QulOI99KBAcKHjIAvx/MJdRNAhS1RP6nXQPCAyFsKewG9XRCc3ujFbc+qMyR09DQuVcwjR+nl
	8seUWPlf69tN9BeExjP1J/wqYjI0Mac/awC5Nwn4g0Llmw==
X-Google-Smtp-Source: AGHT+IFEtqensgVKo94kHd4rZCSCPkU/vwwbllBt8OusMBGYurpSquv8U+hoAavoP2RCD31qoy/6dQ==
X-Received: by 2002:a17:902:db0a:b0:220:fb23:48dd with SMTP id d9443c01a7336-221a11bc739mr72747905ad.50.1740194453887;
        Fri, 21 Feb 2025 19:20:53 -0800 (PST)
Received: from giver-p620.tpe.corp.google.com ([2401:fa00:1:10:c868:d428:c08b:ac8a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349210sm144182635ad.11.2025.02.21.19.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 19:20:53 -0800 (PST)
From: Yu-Che Cheng <giver@chromium.org>
Date: Sat, 22 Feb 2025 11:20:34 +0800
Subject: [PATCH v2] thermal: gov_power_allocator: Update total_weight on
 bind and cdev updates
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-fix-power-allocator-weight-v2-1-a94de86b685a@chromium.org>
X-B4-Tracking: v=1; b=H4sIAIFCuWcC/32NQQ6CMBBFr2Jm7RjagFhX3sOwKGWkkwAlUwQN4
 e5WErcu38/L+ytEEqYI18MKQjNHDkMCfTyA83ZoCblJDDrTRabVBR/8wjEsJGi7Ljg7BcGFuPU
 TFo115yavi9KUkAKjULL3+L1K7Dkm+71/zeq7/rLmX3ZWqLA0tbLGkMmpvjkvoednfwrSQrVt2
 wfV918UxwAAAA==
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

Add a new function to handle weight update logic, including updating
total_weight, and call it when bind, weight changes, and cdev updates to
ensure total_weight is always correct.

Fixes: a3cd6db4cc2e ("thermal: gov_power_allocator: Support new update callback of weights")
Signed-off-by: Yu-Che Cheng <giver@chromium.org>
---
Changes in v2:
- Move the total_weight update to a new function for clarity.
- Found v1 may cause crash when there are thermal zones without any
  active or passive trip points.
  Check trip_max before accessing its trip_desc. 
- Link to v1: https://lore.kernel.org/r/20250219-fix-power-allocator-weight-v1-1-79b1a99e94eb@chromium.org
---
 drivers/thermal/gov_power_allocator.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 3b644de3292e..126452fb470e 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -641,6 +641,22 @@ static int allocate_actors_buffer(struct power_allocator_params *params,
 	return ret;
 }
 
+static void power_allocator_update_weight(struct power_allocator_params *params)
+{
+	const struct thermal_trip_desc *td;
+	struct thermal_instance *instance;
+
+	if (!params->trip_max)
+		return;
+
+	td = trip_to_trip_desc(params->trip_max);
+
+	params->total_weight = 0;
+	list_for_each_entry(instance, &td->thermal_instances, trip_node)
+		if (power_actor_is_valid(instance))
+			params->total_weight += instance->weight;
+}
+
 static void power_allocator_update_tz(struct thermal_zone_device *tz,
 				      enum thermal_notify_event reason)
 {
@@ -656,16 +672,12 @@ static void power_allocator_update_tz(struct thermal_zone_device *tz,
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
-		params->total_weight = 0;
-		list_for_each_entry(instance, &td->thermal_instances, trip_node)
-			if (power_actor_is_valid(instance))
-				params->total_weight += instance->weight;
+		power_allocator_update_weight(params);
 		break;
 	default:
 		break;
@@ -731,6 +743,8 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 
 	tz->governor_data = params;
 
+	power_allocator_update_weight(params);
+
 	return 0;
 
 free_params:

---
base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
change-id: 20250218-fix-power-allocator-weight-5dac6d4b5797

Best regards,
-- 
Yu-Che Cheng <giver@chromium.org>


