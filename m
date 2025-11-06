Return-Path: <linux-pm+bounces-37506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8726C3AB80
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 12:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C04B1A42CB4
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 11:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18FB31AF0A;
	Thu,  6 Nov 2025 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uOnL4fwB"
X-Original-To: linux-pm@vger.kernel.org
Received: from sonic314-19.consmr.mail.gq1.yahoo.com (sonic314-19.consmr.mail.gq1.yahoo.com [98.137.69.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A65231B110
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429816; cv=none; b=PbYPQv/GejhRcP0x+qELw9rRk1mWXo7RfDFY/21LHfa71Os+zdbeexGF3UMMKTLgQi5paKECIBV3+NXKIjKrnDdmsiWZAN+u0GcRda/zY39fYzOtMQfWyZXfusdq88vSgg16YM9ROt1oYIOG1egU6D4keT5WYZwqP/aqQqz3Dkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429816; c=relaxed/simple;
	bh=sC0i03XrfK+aAFJKa1QWFz01JSapbAfVrpNt2LQ8wd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=burXczdJMbX7g1jtQwpnbGli3q/u1PzxMkUmjpFFBmkEbNEgeC7fUGPZbNg4EV2Xk7yzRmosfQlpxAi2UgK7Vxew5TN9V2fy9JzfQMloJpV5hAYbJYg1Z6S0+aR5+V0ov13HMQ5kbGM9HVmrePvrMjJS6Bc0NXBjBqeG01FSxwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=uOnL4fwB; arc=none smtp.client-ip=98.137.69.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762429809; bh=2NqNGQgdR8dBJVHAkyaPyaTZDk61lHGGvXQ0jY/4ZXc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=uOnL4fwBSS+euF8346wizjHZbGpVYm8l17vAkkLIx300ZDz6TkQZq19eWBp7R16X0qlv3peMhUKHypN13FGV88wC/2kb9SAITinBmQSp1U0diLPZznzj7jcPMlv6Jms3N3J6M9stFgUplg40MqpSbFTd+euwSZN9nBmtlKokLlS/aiKAvqGgOXjlyo2HMQYaJ1NSM3Tg5gF07WiDjFF393n6hA+1i/CF5lRlezqFr3ypIzxrkthZXLF/sn5pDCk5Ap+xDUs5xecF6l1Ip0lJZDUC/EootC+5kr+SN+HyraRmBVLpGozaxbawAPoY9p6YB7aR3WNHzoTCoN8S777DHw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762429809; bh=VKAksN3FeoCI0DT5N1dmjP9zvNXiZMQJ7N8i0lHlpeC=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=BPmYyy4SvaxfWWbKXbeN/JHjHEagmmbImedUGEY6bIdJeNyV4F4RJZtTX8BxGL2uneUKj1ofWiU9VDpYusrHmk9lGtCMAbiYrhjZTHKwiCnwkuIOSNvuNOv1Sz7lHNVC0y/FNVVPS5GO8983irKDqpWsBMqTvL8u9VWag9wZYBlIvdLxbKEltW8RdQEeS8ZOS92kSvcAbAZUpu+ufZ3Hkr1GF86OJ1IPJ9QCK6OIb5VxbiWWkNw3HKEyoYHRB/Yxn+r9AgGYVEQk3HBP/LAPh4jbzr0VaAM1m39J4TQF4KnacMjvB1w7mAOfWRRaEVX/1yeg488BIFF3g3GLfqspew==
X-YMail-OSG: FsdktGkVM1mkYImRS80awQNUrL1Xn_6foRdjk5U0qAOlkQYRm2OlO7HpY5BZ7RX
 1vJoFVqVXVt3AKcZC3_gewM9VSXnMTWLiCll29s4fyPfEITLaB8p5UKNvRQq5rPWyeLM.2Jjxveq
 75XPPoepssPXThNRbrBrq.t0omGJ.gv8rjadJy0UHKdUvNvIztAHlvTceesz.COEO.FKBvb0xfaH
 hXrYgjV0PjNsy8l1k7yP2OQOOwz1vTsBfGrvDlxM9TYcm_Gyp05UnNFGtjWbeM4pO_Z890qFCFnp
 yqpHVasSW1rshPiFBmHG7wg6SjuzXMNQq9YClQBjOlBXmq2w0.Kcl92pL.d7gFtghY5meSnucCQw
 cybcRDu7SXvNfOiG.obLze9UuL6CABRc_P8M8nIsnMVZZEsusLk76IcDhA_kiqrKig0VBlIxuNGA
 5.x91EQJ1jD1Nk6kdFG4csBp8c0Wq_ap8.0rcogDoJVkGMtrm7G2yIrfS17f.mjwIIY3wmAte4De
 GQjpbFv_4QNqAv5jDmW5bSC31poi9Gzda9jZOEgJGUOPiRyI7iMj501r0SHsU7PZ5bqinfw8cxQZ
 HAYobdzM4nLNQdU_UOQuhQY3qIiCleJC6eFqpX6uiWbO6I4yq.wT1F96o4TNFIN25CEK3k43hLFa
 mC7sOyIOA6wozhKZf03qYdCLoQ0gBXZIIMdhcH_ngrYQwg1e_xDIdmzWl0bVsb6VW22N7vMuDgks
 V5Q9WhWRkA.w_GyMjcSLREXoAp1.boeC.j0NquVFJUmnRnP9knjEWOJf6VOye3tIxLDscmxOkGKd
 Vr4OwP8oLJjCKZTYjn5GLkLdPDJ35MgjQwux5MOniwjJkdQlKoQ7jxIMsL5qdyct8o3dzCUs0Yzj
 0ZFwZTvWnALmcTbLo1k6iSlgVevzeGfC9tFMQHiL7q.L4aLVuNA9Btbfdph6FtKCheEuKXMmKp15
 2D8bQMO5Kin5rZanVPZriICUHtGl2L9HVtc2ZG6_ln3ihq6cfSPc3wpBsXhiNmEEHJ3dpVuA5Qms
 4gOyFJNm649Iyj7XbuGzKplTFr54d_JGpicC918P..Qjw0TYVAhuWfwvtFH9W5u23C9yd348dl0A
 yQAqCqaNWKBwNfJ7e8gqhzOEx_KbGVCnxNMENrhSvMqBwQmq.h44nrje60xYf9GtN1sqaeNgQtMZ
 Z8Rs2BuQM4jFxSQZ_oaNPosOea8uP2_0W.gfiT17mhDqGV5PZGSGUSA2uxk8LfNBcSzRD8Q6mEWA
 HyBaCFr.mxfbyorLqqBKBm_ZA6Q0lgOlOd6Czh7DvBQQMNNSjZ6BZCcSZHZ3NXRgL0dGObpMLlpb
 0BUJuAVvnptVErMqN9hcT4F8AYhgcAriB2cJEIFQoVI_Qc0GyhGhwXe9WvAlKAy5R7MQFinrde_E
 wCLQFJGjddjyQsdW8_4mrKe2U.q_xuXbSEfxqo6GOxyfGYMNkIRMw9Kx2LlqDGMcXEx5pN3LUqy8
 Lyat6SuY_zaIs7GJ.WI8IgISX1gsaL0OSx6I84hVWnxUuM3dv0d4Yoc8vvudp6sR4QH9C3Wa4RfH
 5VPn7Fn3MCKT_rt939PlCUkWfkgf.Uy6_wO2.4WjqC9bRyFIgrnM6Tpozfnt4JkZXMByAw9nlr0C
 aR_.HZ4g_3FCsXRRT_vyogzn_bKoGd9VQZ1oT2bddBMXaqY3WBxiu92uLduZ_qHALKr6I6BYBVWL
 R6G0E61t2bKjxKlAzTGrMMrPhZD8QLFnuzxp8OgHLeV3Y7b4N875xS8XQhByddWOFxa8DCh1ICP8
 ptdgtth9Z2_IyWgmZyMQSu5K8aypKGZQsJFukgouiCW0F..h8BEaG9GR2QjYIhFiawY.9y96jlot
 _YmMMMcyoKKF42BC68.3c4eAc8KsG4KEwf9ya6FuqNVjPqBfLza528O6qVUdD0NVnVHV6h_zAACs
 RZTtrJChNXBpzxKKcF6Qsb0xrv6m.mG2PcHPEjrMK7y_oqbRHrHUSnNNXzo.jBoRapZ.NJ8v59yt
 xBvXE7bfZSoBNsIEnI0HIqqYRSWXACw2__dwCg0qsOiUT2hgPqzERpZ8t_Wt8voBzwBZudw9qW9g
 Weii.Y6i78ikOSBqa27_EQmzvDfhpKpkcUorAqRWywp0RvJdC9d4Pw7iBHvVw3nf_oSuqZcn1P87
 KGAT0jXyMju6QnJ7VF1GLTqecQZwmhESqDhvYGxa.PQnGMWSwtnbJ7SzESNEqTKU66w9YpEhBzpp
 7hJ6mgpvgMzALk8SK75y8GzSYzoA6NZNO2KXumBIIQ3BXEHmAj1ppKTLwqHcckzmLw1IYLxplR1m
 XS6UGy9adn7UpxnyBoWU-
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 7148212a-1dc7-4061-8833-5f97ad941812
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Thu, 6 Nov 2025 11:50:09 +0000
Received: by hermes--production-bf1-58477f5468-vjcpj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a2a71f3be34b9b294192b02c80d46421;
          Thu, 06 Nov 2025 11:39:58 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Subject: [PATCH 2/2] time: tick-oneshot: add missing Return: and param descriptions to  kernel-doc
Date: Thu,  6 Nov 2025 12:39:38 +0100
Message-ID: <20251106113938.34693-3-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106113938.34693-1-adelodunolaoluwa@yahoo.com>
References: <20251106113938.34693-1-adelodunolaoluwa@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several functions in kernel/time/tick-oneshot.c were missing parameter
and return value descriptions in their kernel-doc comments. This caused
warnings during doc generation.

Update the kernel-doc blocks to include detailed @param and
Return: descriptions for better clarity and to fix kernel-doc warnings.
No functional code changes are made.

Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
---
 kernel/time/tick-oneshot.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-oneshot.c b/kernel/time/tick-oneshot.c
index 5e2c2c26b3cc..ffee943d796d 100644
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -19,6 +19,10 @@
 
 /**
  * tick_program_event - program the CPU local timer device for the next event
+ * @expires: the time at which the next timer event should occur
+ * @force: flag to force reprograming even if the event time hasn't changed
+ *
+ * Return: 0 on success, negative error code on failure
  */
 int tick_program_event(ktime_t expires, int force)
 {
@@ -57,6 +61,13 @@ void tick_resume_oneshot(void)
 
 /**
  * tick_setup_oneshot - setup the event device for oneshot mode (hres or nohz)
+ * @newdev: Pointer to the clock event device to configure
+ * @handler: Function to be called when the event device triggers an interrupt
+ * @next_event: Initial expiry time for the next event (in ktime)
+ *
+ * Configures the specified clock event device for onshot mode,
+ * assigns the given handler as its event callback, and programs
+ * the device to trigger at the specified next event time.
  */
 void tick_setup_oneshot(struct clock_event_device *newdev,
 			void (*handler)(struct clock_event_device *),
@@ -69,6 +80,10 @@ void tick_setup_oneshot(struct clock_event_device *newdev,
 
 /**
  * tick_switch_to_oneshot - switch to oneshot mode
+ * @handler: function to call when an event occurs on the tick device
+ *
+ * Return: 0 on success, -EINVAL if the tick device is not present,
+ *         not functional, or does not support oneshot mode.
  */
 int tick_switch_to_oneshot(void (*handler)(struct clock_event_device *))
 {
@@ -101,7 +116,7 @@ int tick_switch_to_oneshot(void (*handler)(struct clock_event_device *))
 /**
  * tick_oneshot_mode_active - check whether the system is in oneshot mode
  *
- * returns 1 when either nohz or highres are enabled. otherwise 0.
+ * Return: 1 when either nohz or highres are enabled, otherwise 0.
  */
 int tick_oneshot_mode_active(void)
 {
@@ -120,6 +135,9 @@ int tick_oneshot_mode_active(void)
  * tick_init_highres - switch to high resolution mode
  *
  * Called with interrupts disabled.
+ *
+ * Return: 0 on success, -EINVAL if the tick device cannot switch
+ *         to oneshot/high-resolution mode.
  */
 int tick_init_highres(void)
 {
-- 
2.43.0


