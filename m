Return-Path: <linux-pm+bounces-41193-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P6wGeT4b2mUUgAAu9opvQ
	(envelope-from <linux-pm+bounces-41193-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 22:51:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3924D4C91A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 22:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61676848BBC
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 21:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04935423A8A;
	Tue, 20 Jan 2026 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhUUf0n9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DC44218A1
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943852; cv=none; b=VvtQsbQtxiATdpDkHlsKi/jsDr826UamoY6grPe9Hd2bztVtEszytR15xoxNHuIDRWmyhgLDWYyb+zk2c+9+GEFv8GQBPNKcXn6EuBF2lHhDV/oAyVyBfTsFFE2adxMntBk7DiVRu2Kyz3I+WLmWysJnH69EZmgJc/mymJj7q2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943852; c=relaxed/simple;
	bh=wSNBtjMm+V2IMmq80iy1SYwdosKesmUsLxmEQ8W4CfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPJPL+86Rm6py8BHIik1TVRi38oWVTHQzwlPgzLT7niNKQWVh8gg7l56212TiExgZoiQ35Zld8OR6ZGlLf+qlq8y9n6os0yAskDo7BCjrC/dRDZAicEaRxq5QPipaYnlE3UP7Y8c2NfsYblN+XmZ2afnH5hKSlfqqumrF82LEKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhUUf0n9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee0291921so40218865e9.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 13:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768943848; x=1769548648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GD+qh96BuStlVCr6m9cgS9Z50cJM3b7YbGlN1ubHWWY=;
        b=hhUUf0n917x45y0PUHXNQCb6JKigOyr7PIpiMiE/1W4vLvKLmAVVCO8c5rosGGZMAY
         xvyA4PoFchSNa59ayvA3aqhEX9uQroi1tRsFP/dLOoyPPVVk7xA0iJ8AGSEXlL40mdHd
         IhbMJsb2HEcT9/jgzkuiG/zHJ65GYiV2LozkMPI16t05Euz6biDNMichHhr1+EcHhGHK
         AaA0WSl4yEk3iYx/wFvwAPI/l4osEvDCKa6H6IVmGrjo2VN7D+wamNAPHxr/QDZtvGFA
         7TUwWq44uBwUHv4T9nvQOj+k1sFq/y8J4AONng7KQ+WcSegnj3tVDALmGq7zuMtV89NM
         mCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768943848; x=1769548648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GD+qh96BuStlVCr6m9cgS9Z50cJM3b7YbGlN1ubHWWY=;
        b=EyrKCBnSgGOLJ6GVo5SQs2ISSG/CCU8wOZoY3gq6mKT8a8H/OvHVw7ws455h2Bi/lT
         LEeJKxG/9QlK/P9EMM6KjDiHsnLNteQeBr5+IxR/lDIafwIckMU84NSbV5wedCxb8Jsv
         DwKAJ8CwsCV+V08/8yssyONU1JJUwua0L9buk6jw0rNUSlC1g1lJ4hhd9VFsHLfZMHSc
         6jVYb7ugeSsP3CMWuB+OuAdR5cagZJPM/ISX7+h2PHiie5eCsHP0108MiLeo2awBxsZC
         38hX0FONwwThnnX/FWODLPXvCd59Sx8xzJCM79/ff2y7RxNErO+4hQrhyFFD0CUa1P//
         R25A==
X-Forwarded-Encrypted: i=1; AJvYcCXAHFgp6ERdL2r3riYgMfCdlr4QHELEwJPXBrx4X3DZrl+n3CmSckQk+qCUDUcRKMHdI28HMmbI9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOE3ZAt7c6dxkBDeQIUCuqZ3zHxyQg4CVqze8aXnxbGD8qJXx
	dKQU5qgsl/w+GKMBwSPe+4hDhIB3+8EKoqOSlAE1ISnlF0QGBCaEiOkg
X-Gm-Gg: AY/fxX7Gw94+q5cNIjK1cdkfwBrm6mpz3Vv+ceyiOGSfy8ScTzy5bOAruMuSKn4Oa4V
	3r+T1fB6ei4nvFGCJ9QjUonXhlTuma8AePBdNB4dQd1U9RzfNac9mBLnxIH4MdLkWNh09q5M3Ub
	UwRJXLDyMLJZZcaeViVKXk051m+ITt4pBnzdHgmRFpJPQ2UrQK5aB7r+4WyUm9Qs4kA/KEu+d4a
	TLcKtLZJCLE8VPMwnPE+fDha/laITPwkxjJUzo+x8KVj5MalPm6M9DFD2nofNDoDL0IbjK3CgoK
	+oE/z/XIzzMbteF3VlxzT6KoGdKkrDsnqysKaVYy+lwm7oFX1pIG4IR2zS4HfBNoOevKetYYu4C
	L6J2lseJVoLM+ao/LQqDJbiyKF5vDeULxm6lfNCoRJNyBSO/B+iObOJ7KD1mN2YZhZDeuE/j2+y
	hBY5uau3PTPZL+uVvrm5K7jk0aB7mMMsBbYUesgMs=
X-Received: by 2002:a05:600c:811a:b0:480:1dc6:2686 with SMTP id 5b1f17b1804b1-4801eac0cfcmr174219805e9.13.1768943848296;
        Tue, 20 Jan 2026 13:17:28 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f0e:c504:d100:f54e:1a6b:fa97:f3ec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2672d6sm329104325e9.14.2026.01.20.13.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 13:17:28 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: rafael@kernel.org
Cc: ionut_n2001@yahoo.com,
	daniel.lezcano@linaro.org,
	christian.loehle@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/1] cpuidle: menu: Add 25% safety margin to short predictions when tick is stopped
Date: Tue, 20 Jan 2026 23:17:25 +0200
Message-ID: <20260120211725.124349-2-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120211725.124349-1-sunlightlinux@gmail.com>
References: <20260120211725.124349-1-sunlightlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[yahoo.com,linaro.org,arm.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-41193-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NEQ_ENVFROM(0.00)[sunlightlinux@gmail.com,linux-pm@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3924D4C91A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut_n2001@yahoo.com>

When the tick is already stopped and the predicted idle duration is short
(< TICK_NSEC), the original code uses next_timer_ns directly. This can be
too conservative on platforms with high C-state exit latencies.

On Intel server platforms (2022+), this causes excessive wakeup latencies
(~150us) when the actual idle duration is much shorter than next_timer_ns,
because the governor selects package C-states (PC6) when shallower states
would be more appropriate.

Add a 25% safety margin to the prediction instead of using next_timer_ns
directly, while still clamping to next_timer_ns to avoid selecting
unnecessarily deep states.

Testing shows this reduces qperf latency from 151us to ~30us on affected
platforms while maintaining good power efficiency. Platforms with fast
C-state transitions (Ice Lake: 12us, Skylake: 21us) see minimal impact.

Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
---
 drivers/cpuidle/governors/menu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 64d6f7a1c776..de1dd46fea7a 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -287,12 +287,20 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	/*
 	 * If the tick is already stopped, the cost of possible short idle
 	 * duration misprediction is much higher, because the CPU may be stuck
-	 * in a shallow idle state for a long time as a result of it.  In that
-	 * case, say we might mispredict and use the known time till the closest
-	 * timer event for the idle state selection.
+	 * in a shallow idle state for a long time as a result of it.
+	 *
+	 * Add a 25% safety margin to the prediction to reduce the risk of
+	 * selecting too shallow state, but clamp to next_timer to avoid
+	 * selecting unnecessarily deep states.
+	 *
+	 * This helps on platforms with high C-state exit latencies (e.g.,
+	 * Intel server platforms 2022+ with ~150us) where using next_timer
+	 * directly causes excessive wakeup latency when the actual idle
+	 * duration is much shorter.
 	 */
 	if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
-		predicted_ns = data->next_timer_ns;
+		predicted_ns = min(predicted_ns + (predicted_ns >> 2),
+				   data->next_timer_ns);
 
 	/*
 	 * Find the idle state with the lowest power while satisfying
-- 
2.52.0


