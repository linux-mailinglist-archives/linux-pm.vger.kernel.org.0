Return-Path: <linux-pm+bounces-41274-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB9YFnfdcWk+MgAAu9opvQ
	(envelope-from <linux-pm+bounces-41274-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 09:19:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1476562F1C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 09:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F5EA5A322B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 08:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60784481A90;
	Thu, 22 Jan 2026 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNv42n/e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2C8480DC2
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069432; cv=none; b=cl8tQ8zSJy+iSP+nWTvUzsCeNo7DAoUOpibTUA7eYvHDXeqQeSYC4jdJBtuJR4nkp8SQ3F1RtT40uVVycJydjwwWluD4XnW+Cear9cghWVstkJgmHjls+BAqsmQNFuio3Mxtvuhs8mYIHX9EXFU3YNZp8LrayR8ohwd52GZ0eFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069432; c=relaxed/simple;
	bh=IvOasZrut6PCd3af8YtoDpHpptDz9z7PgxcJbJl9S1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUYJfQp1BNt9Xgb/n9T6fcztYItvTumaQK+10XyVFRbOqCXs4TCOcdZ3mQpnwz0Rt9snrmTPPi3xLcseZpzRc+5J4vnn+RpyS1hMyaBBe7Xi6nhzPhzg+9rlCp55i9CYA01bostwlMqp1m/txpgvSozNhYiX75FceB6DNBsoL24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNv42n/e; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-435903c4040so391790f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 00:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769069428; x=1769674228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtOpl7xweHl0EFuZPJYt8DnqlAREakqhJs13CERid+E=;
        b=mNv42n/e1RFd1ldrDrgWz+L0DOvPdZzEYHP9lDBsrkuRW6Xon0MnbkCwc9Jvejm/sa
         BqdKbzXXkxf+dv4xmtDCaTq1Xnk1u3ZHsfslnVR0w93WfmjMrFk5Q57eHYA+o2X/qgVJ
         bDmFuWE8y9HlrCTmNB8IAkExWYBEwYHqcg3M9oqXQxz2+93x7mNBIDvI1pGIAhv2zqf5
         vVRDatPRKhHTtsoD6Gq+Kwj0A77/5FVOJfjS2p6ebcASxV02ZvNfyhYQJXMUladzhbBk
         8mYZeBwL+DmMNH3WqaKqLnikuBPRVst20IUUUQ+zWgryd7o+GuGCNfR74mXbGceE2zNo
         Bg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769069428; x=1769674228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DtOpl7xweHl0EFuZPJYt8DnqlAREakqhJs13CERid+E=;
        b=q+k1+y2WEW9Fwusypfk+2nsegxTsiM8j6Chg9PlUb8izOCljRFjh7zAIRpqphzsFo5
         YhF5P60Dy/PWh1LolCPLx4pTdjbeEXy1XRz6M7kwMBdFLhiG2OqLohvNUR5NXt8XsBTs
         oY3FMCXOkg1cQ18yM97iRBGA2q3wfmn9/Z0tkfN2GK629PrNtnA93XetPMMQZNdkJ7hQ
         9iQg3OjtkJn0z9t2Hexn4HGZt3tY4Ff2TEa1UiSC2HkBGDftfJpN7UKENfHsvG18jMwA
         yth34C7a8EniktqLSMfFzyImCV9ZLI8xWgprdQMushpsmXh+3eajaS3kCeiICUhp0PzF
         k+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUtD3CCrLr1UrrMW1kararmHsZkJz5xIPA6CvTLLGSRbvrGLMv+1f+2ZtFtcLZ+dNk+6/P5OULMNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySx4U8C8tx1CDqUJrKiVsFtH3K+Ek60/3dWreER1s2jw8BDNR6
	8m/wnft3GzpDhM+BC4YjboGH39hO9zE7mncg9BzTAEoVm2t6xuFyJk0VgxsBTx6D
X-Gm-Gg: AZuq6aKf+MLl22xiOhlrKVkre/xH8IPYFBqFeb4/gkZtliGi8u6S6W60JZIo2FiiUT3
	mAwTwAaolPOxN8poPHDFpNPHvKX9YWslLcz2j6I2ZMuPrZSQD5pKI6nCKJtZ3en7sLkLY51H6ym
	8zz19qb8+35JbFT8EXE4Jl6fpHcR462lhJV3BRIczRzz8c8A06ogTOzc21gjCW4kW6yiXW4TtLW
	Nfm8CpmRqaVcRbEl1jRgE/oC6HnQY/C77Yx7g68XlPyHS+w9H2hUaahWLOnVu9AuOQKhGYqM7i8
	SnqMwXReulZ4TGBI/A4kyBAcU2lVuOfghzxDWUysAacqQbmdXLAH+3k6PAaYIw+ajUlvR8j2IrB
	4H/SlfU5mH9Qi7yfOJ2/ia14CCZuB8KgQeMBc0rwSR8554Cp+yQDQ0gcHI7Dva1mae7g6L8CDB8
	hw/u97aOZ8bT10CUf6tISzfGmxao0MEAIE6HHm9og=
X-Received: by 2002:a05:6000:2510:b0:435:9cd5:bb2e with SMTP id ffacd0b85a97d-4359cd5bc49mr9588007f8f.11.1769069428106;
        Thu, 22 Jan 2026 00:10:28 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f0e:c606:9800:ea1b:9133:ab8e:bdea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997ed8bsm43766261f8f.36.2026.01.22.00.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 00:10:27 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,
	christian.loehle@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yumpusamongus@gmail.com,
	Ionut Nechita <ionut_n2001@yahoo.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] cpuidle: menu: Use min() to prevent deep C-states when tick is stopped
Date: Thu, 22 Jan 2026 10:09:39 +0200
Message-ID: <20260122080937.22347-4-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122080937.22347-2-sunlightlinux@gmail.com>
References: <20260122080937.22347-2-sunlightlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,vger.kernel.org,gmail.com,yahoo.com];
	TAGGED_FROM(0.00)[bounces-41274-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunlightlinux@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 1476562F1C
X-Rspamd-Action: no action

From: Ionut Nechita <ionut_n2001@yahoo.com>

When the tick is already stopped and the predicted idle duration is short
(< TICK_NSEC), the original code uses next_timer_ns directly. This can
lead to selecting excessively deep C-states when the actual idle duration
is much shorter than the next timer event.

On modern Intel server platforms (Sapphire Rapids and newer), deep package
C-states can have exit latencies of 150-190us due to:
- Tile-based architecture with per-tile power gating
- DDR5 and CXL power management overhead
- Complex mesh interconnect resynchronization

When a network packet arrives after 500us but the governor selected a deep
C-state (PC6) based on a 10ms timer, the high exit latency (150us+)
dominates the response time.

Use the minimum of predicted_ns and next_timer_ns instead of using
next_timer_ns directly. This avoids selecting unnecessarily deep states
when the prediction is short but the next timer is distant, while still
being conservative enough to prevent getting stuck in shallow states for
extended periods.

Testing on Sapphire Rapids with qperf tcp_lat shows:
- Before: 151us average latency (frequent PC6 entry)
- After: ~30us average latency (avoids PC6 on short predictions)
- Improvement: 5x latency reduction

The fix is platform-agnostic and benefits other platforms with high
C-state exit latencies. Testing on systems with large C-state gaps
(e.g., C2 at 36us → C3 at 700us with 350us latency) shows similar
improvements in avoiding deep state selection for short idle periods.

Power efficiency testing shows minimal impact (<1% difference in package
power consumption during mixed workloads), well within measurement noise.

Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
---
 drivers/cpuidle/governors/menu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 64d6f7a1c776..199eac2a1849 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -287,12 +287,16 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	/*
 	 * If the tick is already stopped, the cost of possible short idle
 	 * duration misprediction is much higher, because the CPU may be stuck
-	 * in a shallow idle state for a long time as a result of it.  In that
-	 * case, say we might mispredict and use the known time till the closest
-	 * timer event for the idle state selection.
+	 * in a shallow idle state for a long time as a result of it.
+	 *
+	 * Instead of using next_timer_ns directly (which could be very large,
+	 * e.g., 10ms), use the minimum of the prediction and the timer. This
+	 * prevents selecting excessively deep C-states when the prediction
+	 * suggests a short idle period, while still clamping to next_timer_ns
+	 * to avoid unnecessarily shallow states.
 	 */
 	if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
-		predicted_ns = data->next_timer_ns;
+		predicted_ns = min(predicted_ns, data->next_timer_ns);
 
 	/*
 	 * Find the idle state with the lowest power while satisfying
-- 
2.52.0


