Return-Path: <linux-pm+bounces-16324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C479AD4FF
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 21:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320381C21743
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 19:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D391E2300;
	Wed, 23 Oct 2024 19:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tba2eaGK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A7B13BC11;
	Wed, 23 Oct 2024 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712584; cv=none; b=u5jdltH5wR6MmswUlLqHW/wAZRCzKmlIyDtAPQiDVT/MPUi/0mZ8gwh7+KKPlxcuBWA1z5Yi/f2lYj9SKXDE8dmPAEktS2mB9JdgTuj4uDB36fvHh16wKW7RCfvD2bYvnOZGTJdtgNIEz9va/CjkYX2dLzr77TLxb5XHLWUuwIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712584; c=relaxed/simple;
	bh=y/7jYmf1JcJqTTDBz6fJcxDfIXqmBQfVP45wXhvGGlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KVj/i/TUNmms/UFVn2UUwf31pfwsznJ5e8wxV0hH0ii5BiYwKpEJ7+YbxZhh4081+8GI9cSADRzaNuPGqlxyLWIYAcx8mK4sYg0CafKhVpHSo68Kiujwzps5e6iC3ezZr+CVgmWip3z+FB1oHkpHay4DRrfHmslXo8UxtaIPmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tba2eaGK; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb5111747cso1236871fa.2;
        Wed, 23 Oct 2024 12:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729712580; x=1730317380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNk0fOb9DIQVLHw9i7VYExiUbdtUJ37rSb7ICr8WfBE=;
        b=Tba2eaGK26zTQHdr1eb0F/0NdTCkW5u4n6EW8CLB/OFrcIinI4CZlbqOTZxafq9k0u
         XoZMxv9XSle1u5T9JHhQXyriV5eiqkSV78JYI4J+OqI7aTybvw3iEzo6aO5EdDX2rJ8M
         1kb/ay9Nse9L+kd/Utf8DC5bobz0DCANJPNYPAb72cC/WowE22Rw0kVH/ucpUMYxG7Nx
         3NB/QqOKAP37Zyy4jfzM2UgAt0rQfdb6bw9LTfDYD4WbCnF+bbfTVt97ywHzpivFMNCN
         vA+ghgrAI7WLGoEdSfzBxHchvBBwOo3hdSgPgKqZWIqkNvoVjrJ2NrpEhkrE19nEpVbu
         Q6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729712580; x=1730317380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNk0fOb9DIQVLHw9i7VYExiUbdtUJ37rSb7ICr8WfBE=;
        b=CnYDA8Ue7XszuY7Q1BOvBJE5UzZtQ22pOT56VlNKKnK5OlwV36zCjAU3s60uUYiFqU
         Ddj/0zobiMPUHr2qD5U92MCBWuD4VRDlzdFQooraqXWJwXZ7pi9ZvNO1jVkZ8LdDUowD
         Jsl0g3zPXmD8e5guryTXN91MTaVeXF68VnkBogNiIOEFhCnwyPlP6h75wIiiN3yTxrON
         csFQX7ixx0BCb+H2THjgZtOowJl0x006dwcZaxa7ymK5TZSeSnNBXJ4T1XUXx0aG6jcY
         sHELex/K6FIVvKv0iScgwLKB779C/zA0p3ytJP/CeG3tsoNiE0Q5VyQ1tV+2aIRPX7KC
         POYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ESfw6Kh6WL4XGS7bKUwLPJ11rIHwTWRW64BayQICBzKjexVGtlsDHy1QA7a4oKe4mCbUobyy97DO@vger.kernel.org, AJvYcCVze825EwAEluV7RzSkad2cDCSye/pzVmNHakA0A1/xsHed/HnLkSrYm0M2k3tG7FrcHJfKVsBnvg7JzpLF@vger.kernel.org, AJvYcCXOrqMoEOF34kFv/vRPq+4O6Ovnzz8fk9o5oKfRsRAj4b8YS9/WFYIjB3Y88WnEuBSbISBZ+fb0yL5txw==@vger.kernel.org, AJvYcCXj34lIaa6BK55C5IdUHRMljdLaQ6DmvBQCzpPHQI5DpxVx0ReAScSn8xlV7h48BJOIM8gArws83kViN/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsL3D9lxZEOCkfQhn2I/6bkGJyqKWjfrBy8LgHA4e3JrVEuATq
	zlsrm5JUFtrwpmBHLF4vZF6ZnMBAcXA+UaL5Z2bNsKaEFHDmKKSzOyFd6A==
X-Google-Smtp-Source: AGHT+IGSlTSMEUDWa5zkqAnk1M/8JnSJQQ5A2rsUFZ0Eb9qxUx54wP4dKysIAXrGrIpNxfQ6BtJKqA==
X-Received: by 2002:a2e:859:0:b0:2fb:5da7:47a1 with SMTP id 38308e7fff4ca-2fc9d353f9dmr17138871fa.16.1729712580233;
        Wed, 23 Oct 2024 12:43:00 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.244.166])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b1d8sm4803940a12.72.2024.10.23.12.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 12:42:59 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 23 Oct 2024 22:42:49 +0300
Subject: [PATCH v7 1/7] power: supply: add undervoltage health status
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-starqltechn_integration_upstream-v7-1-9bfaa3f4a1a0@gmail.com>
References: <20241023-starqltechn_integration_upstream-v7-0-9bfaa3f4a1a0@gmail.com>
In-Reply-To: <20241023-starqltechn_integration_upstream-v7-0-9bfaa3f4a1a0@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729712576; l=2343;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=y/7jYmf1JcJqTTDBz6fJcxDfIXqmBQfVP45wXhvGGlI=;
 b=JneTa0BzvjMPdrKEaKH9Kn5fj3tHERa20ejeyse3FvfW2bQ2LwA/fP3Cz/5OjZiLPEhJW6mps
 rrfnJcGWEpJCA0knUGpxzovGy/dgsGiiXt4Qg4Da+LJOtHSWbN2kuVg
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add POWER_SUPPLY_HEALTH_UNDERVOLTAGE status for power supply
to report under voltage lockout failures.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes for v5:
- update Documentation/ABI/testing/sysfs-class-power and
  drivers/power/supply/power_supply_sysfs.c
---
 Documentation/ABI/testing/sysfs-class-power | 2 +-
 drivers/power/supply/power_supply_sysfs.c   | 1 +
 include/linux/power_supply.h                | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 45180b62d426..32c018c5d088 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -433,7 +433,7 @@ Description:
 
 		Valid values:
 			      "Unknown", "Good", "Overheat", "Dead",
-			      "Over voltage", "Unspecified failure", "Cold",
+			      "Over voltage", "Under voltage", "Unspecified failure", "Cold",
 			      "Watchdog timer expire", "Safety timer expire",
 			      "Over current", "Calibration required", "Warm",
 			      "Cool", "Hot", "No battery"
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 571de43fcca9..247c2910ba34 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -99,6 +99,7 @@ static const char * const POWER_SUPPLY_HEALTH_TEXT[] = {
 	[POWER_SUPPLY_HEALTH_OVERHEAT]		    = "Overheat",
 	[POWER_SUPPLY_HEALTH_DEAD]		    = "Dead",
 	[POWER_SUPPLY_HEALTH_OVERVOLTAGE]	    = "Over voltage",
+	[POWER_SUPPLY_HEALTH_UNDERVOLTAGE]	    = "Under voltage",
 	[POWER_SUPPLY_HEALTH_UNSPEC_FAILURE]	    = "Unspecified failure",
 	[POWER_SUPPLY_HEALTH_COLD]		    = "Cold",
 	[POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE] = "Watchdog timer expire",
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index b98106e1a90f..e96d262f3c2b 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -58,6 +58,7 @@ enum {
 	POWER_SUPPLY_HEALTH_OVERHEAT,
 	POWER_SUPPLY_HEALTH_DEAD,
 	POWER_SUPPLY_HEALTH_OVERVOLTAGE,
+	POWER_SUPPLY_HEALTH_UNDERVOLTAGE,
 	POWER_SUPPLY_HEALTH_UNSPEC_FAILURE,
 	POWER_SUPPLY_HEALTH_COLD,
 	POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE,

-- 
2.39.2


