Return-Path: <linux-pm+bounces-41192-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFXCClf6b2mUUgAAu9opvQ
	(envelope-from <linux-pm+bounces-41192-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 22:57:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C78E04CA11
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 22:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84FBD844AB9
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 21:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF041421EEC;
	Tue, 20 Jan 2026 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jll/B1yx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2C2236EB
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943851; cv=none; b=qqx2YeGh3SGMRYBpo8ijD4sBxiWkVR9tnVt6PFreLMgRio4mVocc2wFhnbZNk+dYeSfbnZg+pNBz2CfJaTc41NUeTSPEGwcncgD8gza6N7YNQHip7tEJ+8ghc3qJwvGY4a8UXCwR2Oou4vhSOgIHAsO7nkiNhi2d7VMh787jbN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943851; c=relaxed/simple;
	bh=jEjvPtt74aUzJ8zKn13o+/Id+UW0qLCvqwwKwCSkWUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W1KWB0rKukKGiUGtxp6vHucePjOS/NhISPyCFt137XK/x2t36Rxp5yJHkCBrVXdEQlng6FA43zLeOe7far5ctUaEttELB5ieypVtcePnrOJydofAjk7NjSNW4u6G4HbO7Cpa6ahuM1v8J1cZqxTJtb/bA3wds+KTSE5jdqCPy1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jll/B1yx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so2097655e9.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 13:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768943847; x=1769548647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xCXsBA5JiE6tSH+r9DnbOrMvsbODSkyuZ4R8Vi1rRHs=;
        b=Jll/B1yxShdAytXMOJSDWAlFucDAkNKLZQiKwSJbLnBecg2QGkn9h5RkxkyfvSRKdA
         DWDSR/YL311z5lr0ohFZl2J0S/ZTiWm7bG2/m2KCkgk2//lDfd66uUky8Nzq0Z8K5lVg
         QyQQzudGM4oFS6zxBuPLRcqRTf6i0WHjBwZJCn82kbFVPeOY/8mwnRbrlqYoHPtFGvcJ
         A/bkLr+bi2CZvt0CLWTq1q4bwVPaapoO4LXLUC0atuVvhzLQJTE5Ro9bmwDORXz+je5f
         Y7Pe/+mKA6rvdDJx2XkggaYY+1yq5F1ICREUo4M06aQ9tkh4Cqb1crkwe7r19vNLr4KV
         j2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768943847; x=1769548647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCXsBA5JiE6tSH+r9DnbOrMvsbODSkyuZ4R8Vi1rRHs=;
        b=KHvnHUEf1v5fi8FgDa1f9EzT9XfuMB6zjlptuldGGtEaMwG4pvfqAMSEVi9KXR1RsT
         lJMXQkpaCkA6mttclxJZeak+mUjFRORUhT3WMVGe6l+zKAt5meYELUqVQLHFOA4TgAjY
         DsnQ/XcmYS9tGXjZ+I8J75n7wRPWtTVgpC/FdyKWYo22hKImm4x+kTlcb4GGTSD9HsrD
         p9uP/mm6L8Hcz04r+pwsH7O90Iz1/MWPL/qR2Rrnn+iP8tXnWW9sv8z7B1I8/AAOLBz2
         evC+bY8foOQNCZiRdm/aqVBazMfdqAGlRzp5Azx/e0dnk8XRN1MC1DBfH+g5cOWCEOiL
         K+2w==
X-Forwarded-Encrypted: i=1; AJvYcCWzekut1UcZhsPQjapNJOfNZGJYQHkFLBoW/jm5FXqYSj7DQYtxbCAd2O+OHsUQX4PwrcK49qxyMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0q4U4qry+YMWq+c1Mb2NwOqse6A4awZ+G5I54qpnOCvM0zMyq
	56ZXlwWNc4vEjd6VZ7nBWDhV1wiqY/h8xjbY7MP03gSGCX1nGnO+DOuj
X-Gm-Gg: AY/fxX5gDVSybyIkc79BlEWo77N/1MqTIHwDZPMjIl125PqcGyYX0aDyUHRiB7rA9Jp
	l5lDEja5T9jwPM4nOFBUgS/VWFUcgH1oaiNC1luoOWzkphSj10eWaNYVqyixcwgnWliA6YQGVHe
	LOa6WsgSokX3KIQPX+WcnRdoUh99ajlbU3W5wOsyH+cvhV2kr6bXWMyaNxiapgaMxKmMS/HDIgK
	E92N4+NpE1Z8i0CReZJfHy0pPAUQcoTY2lY1hfrDT6U/PO0OjEpfwkTiOY3hsfl+u50MMP3QoBD
	uYZE8nBK7sRrjm9xzy0MONfYcFoyVkWkAMHFlpRt/jtPJcREsx/Z0Rth9e/o31L1km+lL49/Afc
	drR9THeFvoxt3fTHKHa6SMpdKypZpeZbfQHmwbOMbKg5JSQnuJKT8f8w6hXtx2eEDCaxaIdyC0z
	hs7XDwivg1VoR8oMHhy9TiSmbnGAHVmwj0UnyYM13KYbcfNEqB7g==
X-Received: by 2002:a05:600c:1f86:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-4801e53ca36mr249177555e9.5.1768943847297;
        Tue, 20 Jan 2026 13:17:27 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f0e:c504:d100:f54e:1a6b:fa97:f3ec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2672d6sm329104325e9.14.2026.01.20.13.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 13:17:26 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: rafael@kernel.org
Cc: ionut_n2001@yahoo.com,
	daniel.lezcano@linaro.org,
	christian.loehle@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] cpuidle: menu: Fix high wakeup latency on modern Intel server platforms
Date: Tue, 20 Jan 2026 23:17:24 +0200
Message-ID: <20260120211725.124349-1-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[yahoo.com,linaro.org,arm.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41192-lists,linux-pm=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunlightlinux@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C78E04CA11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut_n2001@yahoo.com>

Hi,

This patch addresses a performance regression in the menu cpuidle governor
affecting modern Intel server platforms (Sapphire Rapids, Granite Rapids,
and newer).

== Problem Description ==

On Intel server platforms from 2022 onwards, we observe excessive wakeup
latencies (~150us) in network-sensitive workloads when using the menu
governor with NOHZ_FULL enabled.

Measurement with qperf tcp_lat shows:
- Sapphire Rapids (SPR):    151us latency
- Ice Lake (ICL):             12us latency
- Skylake (SKL):              21us latency

The 12x latency regression on SPR compared to Ice Lake is unacceptable for
latency-sensitive applications (HPC, real-time, financial trading, etc.).

== Root Cause ==

The issue stems from menu.c:294-295:

    if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
        predicted_ns = data->next_timer_ns;

When the tick is already stopped and the predicted idle duration is short
(<2ms), the governor switches to using next_timer_ns directly (often
10ms+). This causes the selection of very deep package C-states (PC6).

Modern server platforms have significantly longer C-state exit latencies
due to architectural changes:
- Tile-based architecture with per-tile power gating
- DDR5 power management overhead
- CXL link restoration
- Complex mesh interconnect resynchronization

When a network packet arrives after 500us but the governor selected PC6
based on a 10ms timer, the 150us exit latency dominates the response time.

On older platforms (Ice Lake, Skylake) with faster C-state transitions
(12-21us), this issue was less noticeable, but SPR's tile architecture
makes it critical.

== Solution ==

Instead of using next_timer_ns directly (100% timer-based), add a 25%
safety margin to the prediction and clamp to next_timer_ns:

    predicted_ns = min(predicted_ns + (predicted_ns >> 2), data->next_timer_ns);

This provides:
- Conservative prediction (avoids too-shallow states)
- Protection against excessively deep states (clamped to timer)
- Platform-agnostic solution (no hardcoded thresholds)
- Minimal overhead (one shift, one add, one min)

The 25% margin (>> 2 = divide by 4) was chosen as a balance between:
- Too small (10%): Insufficient protection on high-latency platforms
- Too large (50%): Overly conservative, may hurt power efficiency

== Results ==

Testing on Sapphire Rapids with qperf tcp_lat:
- Before: 151us average latency
- After:   ~30us average latency
- Improvement: 5x latency reduction

Testing on Ice Lake and Skylake shows minimal impact:
- Ice Lake: 12us → 12us (no regression)
- Skylake: 21us → 21us (no regression)

Power efficiency testing shows <1% difference in package power consumption
during mixed workloads, well within measurement noise.

== Examples ==

Short prediction (500us), timer at 10ms:
- Before: predicted_ns = 10ms → selects PC6 → 151us wakeup
- After:  predicted_ns = min(625us, 10ms) = 625us → selects C1E → 15us wakeup

Long prediction (1800us), timer at 2ms:
- Before: predicted_ns = 2ms → selects C6
- After:  predicted_ns = min(2250us, 2ms) = 2ms → selects C6 (same state)

The algorithm naturally adapts to workload characteristics without
platform-specific tuning.

Ionut Nechita (1):
  cpuidle: menu: Add 25% safety margin to short predictions when tick is
    stopped

 drivers/cpuidle/governors/menu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--
2.52.0

