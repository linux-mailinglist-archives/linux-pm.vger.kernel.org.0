Return-Path: <linux-pm+bounces-19438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F37EE9F6D48
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389FD16E110
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 18:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFBD1FC103;
	Wed, 18 Dec 2024 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsCNbgmA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83A11FC0EF;
	Wed, 18 Dec 2024 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546548; cv=none; b=QFepY1xQjWY1O8SuyaWN3UUAKs3DkfgMalV8QQNLlYu7XDqv7RTI+vrtjFcD4LBMxMK+IeYbZQBop9hjYwIKAHvniPaELF4f/5I7eERn4Z8dmHkbeWdp/kvLAdicEk490I1+/pIzByOWn3z7JDd+7+iYJRBpBtyXBuJjo35CnUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546548; c=relaxed/simple;
	bh=BuOxgI2CbOrK9Hxnatsu8Mn/4pRiwpGqt9d6S48h8hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJWbYTHdS7GKI1LWnW1s7dbXVEJis+8E8RDQugHHEfm/faYoC9Ef5BNaSx+jU0mCQ+j8Nfm+hBr0GL9q0kHUfHgdu4bRh7U253YwUW8v2mIIYmiFjObJ3Vch8QIlr5i6WZFePhzaZwkfhXr6QmNf37mtBl4B3NeP0aHd0ZzO7Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsCNbgmA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166360285dso13015ad.1;
        Wed, 18 Dec 2024 10:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734546546; x=1735151346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0xMWNhFbRFrvmQCRSO20OEZKspqHRsl+17s4y7Ifdg=;
        b=bsCNbgmAxMxUBjigI0I5Zg+ZYjSzeTBjKyTguU2OVyR8IwrR/DriTtditX4rrxVOwp
         3c1HjSWdJgIUX9HRIXIrlBfAwwpWz0UzMNWwKCUZnvC1QKClWYkXEsPhVBgUfAXT+S6I
         SQazzl2ffFFtB3tF2a6x3MJm9xOSEpai3FvJVKI1jQX5f9q3fbkYqXQSyisVph7on4Wh
         c2sV90iNkKLMX7sl/RfZriECG0AxVo1nxJUkvBB8p16hLRifqxbQmSC5tqltRr6l8hTW
         jAR5MChBcCfiyMN07B2p65siPwL0t6V/y3+r+GXKbbrYCba3L9mxqUkKSHMmk3V4RkWG
         BPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734546546; x=1735151346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0xMWNhFbRFrvmQCRSO20OEZKspqHRsl+17s4y7Ifdg=;
        b=RCobzUFHMBRT/zolvFXmd7Fhm8tJ3NXwE36KikwT8nsKqf0DDPG47MFe+jOcX0Afkg
         dkLj64jUJp9gZkepPDW5G/qCKONFt1x0Ixa6UTl6xXpkKeMU53Y2wkReEDjHc6PhEVrp
         DXcZzIGzamdnYeFCnllmn494k/N24Y4y8o9OR5XNYdXh0ysE21/WQuSF4llL2iqFhbzx
         UgdrjoZ8fzvl+YIBAnccs73KkFxwG/VIsCDA11EVF1Z0I6qA3W/71G3RaBqVK+gKawI8
         78UTDB7X6khCpqTwIoBS8kTU/+WyHJolC+IXrUbXeRlLE1bxw1AuZcPYHPmJ8x0akY3j
         U9lw==
X-Forwarded-Encrypted: i=1; AJvYcCUTr70cEfYrTnEI7R/octsbihWhpxRB19jAKDTx7ds2dL0nVDKljFqG9aNnEcxkPnwlOUlp0gfd+JI=@vger.kernel.org, AJvYcCVwfQv5q/ySRWAvQcssMcxhT9/UzXzNQZ2YV14cjwEZbpyHxVGR3Tm2A6HXcUIBFSA8WYZ44WnvyJVP@vger.kernel.org, AJvYcCXr/4TxQ0qOhihFRJkj++7IJkbaj4qJjGNcHSdN5jyluxmMchw8BEwnOakrKnIvXMIIm89TjJoGEbaEWjPF@vger.kernel.org
X-Gm-Message-State: AOJu0YwklEf8Jd2WR9QonDSdVmR+rSn3w4plylok9P0G8FJkR+H8Gjyk
	VuuNR+vXHpWYm2cyvwqZRr8NsRj+AIN7+9sMIeKkbf59yNTUO5/J
X-Gm-Gg: ASbGnctuLit8jbO8WsSxcczYntyODTOwmd3FxGaDfRXIoZdeR5VmLM6ka1+TpbBNnSE
	jS6Go9dyy0B/GOcy1NnIx+U4f8xsoZIEjRXeR9I+xL77RvHNQd00y+negfEst/9t4mi7CthI+Bs
	hj+NNVILvPRrbS3f3XVw3rH4hpp9ZS8Nm3/ITfgTp6MVYq4SwY7+MyNFQcp7or/MENpEqVLxU07
	RwFXmh4lbV8/sw3D/s2zT0h66U6UmAdDiHRQeuBVPFZxf+EyxUPwlEqMQ==
X-Google-Smtp-Source: AGHT+IE5H942ad1OAia3lBBhcksY1y+20uAlvIpOi6ha/V3bCOYFzx6F6Fufey/f4PXmeYsSviXIPg==
X-Received: by 2002:a17:902:da89:b0:215:e98c:c5c1 with SMTP id d9443c01a7336-218d722cf3amr59411945ad.30.1734546546134;
        Wed, 18 Dec 2024 10:29:06 -0800 (PST)
Received: from nick-mbp.. ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-218a1dcb3ffsm79202565ad.75.2024.12.18.10.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 10:29:05 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Asahi Linux <asahi@lists.linux.dev>,
	Linux ARM Kernel Architecture <linux-arm-kernel@lists.infradead.org>,
	Linux power management <linux-pm@vger.kernel.org>,
	Devicetree <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v3 2/7] cpufreq: apple-soc: Drop setting the PS2 field on M2+
Date: Thu, 19 Dec 2024 02:25:04 +0800
Message-ID: <20241218182834.22334-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218182834.22334-1-towinchenmi@gmail.com>
References: <20241218182834.22334-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

Newer device do not use this. It is not known what this field does,
but change the behavior to be same as macOS to be safe.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 4dcacab9b4bf..ad6c7b8f290c 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -25,7 +25,7 @@
 #define APPLE_DVFS_CMD			0x20
 #define APPLE_DVFS_CMD_BUSY		BIT(31)
 #define APPLE_DVFS_CMD_SET		BIT(25)
-#define APPLE_DVFS_CMD_PS2		GENMASK(16, 12)
+#define APPLE_DVFS_CMD_PS2		GENMASK(15, 12)
 #define APPLE_DVFS_CMD_PS1		GENMASK(4, 0)
 
 /* Same timebase as CPU counter (24MHz) */
@@ -55,6 +55,7 @@
 #define APPLE_DVFS_TRANSITION_TIMEOUT 100
 
 struct apple_soc_cpufreq_info {
+	bool has_ps2;
 	u64 max_pstate;
 	u64 cur_pstate_mask;
 	u64 cur_pstate_shift;
@@ -69,18 +70,21 @@ struct apple_cpu_priv {
 static struct cpufreq_driver apple_soc_cpufreq_driver;
 
 static const struct apple_soc_cpufreq_info soc_t8103_info = {
+	.has_ps2 = true,
 	.max_pstate = 15,
 	.cur_pstate_mask = APPLE_DVFS_STATUS_CUR_PS_T8103,
 	.cur_pstate_shift = APPLE_DVFS_STATUS_CUR_PS_SHIFT_T8103,
 };
 
 static const struct apple_soc_cpufreq_info soc_t8112_info = {
+	.has_ps2 = false,
 	.max_pstate = 31,
 	.cur_pstate_mask = APPLE_DVFS_STATUS_CUR_PS_T8112,
 	.cur_pstate_shift = APPLE_DVFS_STATUS_CUR_PS_SHIFT_T8112,
 };
 
 static const struct apple_soc_cpufreq_info soc_default_info = {
+	.has_ps2 = false,
 	.max_pstate = 15,
 	.cur_pstate_mask = 0, /* fallback */
 };
@@ -148,9 +152,12 @@ static int apple_soc_cpufreq_set_target(struct cpufreq_policy *policy,
 		return -EIO;
 	}
 
-	reg &= ~(APPLE_DVFS_CMD_PS1 | APPLE_DVFS_CMD_PS2);
+	reg &= ~APPLE_DVFS_CMD_PS1;
 	reg |= FIELD_PREP(APPLE_DVFS_CMD_PS1, pstate);
-	reg |= FIELD_PREP(APPLE_DVFS_CMD_PS2, pstate);
+	if (priv->info->has_ps2) {
+		reg &= ~APPLE_DVFS_CMD_PS2;
+		reg |= FIELD_PREP(APPLE_DVFS_CMD_PS2, pstate);
+	}
 	reg |= APPLE_DVFS_CMD_SET;
 
 	writeq_relaxed(reg, priv->reg_base + APPLE_DVFS_CMD);
-- 
2.47.1


