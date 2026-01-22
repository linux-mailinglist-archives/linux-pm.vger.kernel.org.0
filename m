Return-Path: <linux-pm+bounces-41273-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM8fAXPdcWk+MgAAu9opvQ
	(envelope-from <linux-pm+bounces-41273-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 09:18:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FA162F14
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 09:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AE98589C83
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E67481249;
	Thu, 22 Jan 2026 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJwhJBcS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCA4480970
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069413; cv=none; b=DD3Pe/3+VnJ3Z6FZuOMb076Wun4RMXscr2i1KyILbu6418WHs4M3AC1CigsMmPja45JU0LTPCdcDyA+oCpZ3ek2goEu0D+TTyiN6+ogYKFgdTuLmx10yuLicW+RtNVLZ+yqzWm+Bg/kQD03GC/Xk74I1MRouyX2Lj/CAuds4BhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069413; c=relaxed/simple;
	bh=ly+ObxefnjO7zqPiNFOgC5SzOHX1YJWNyvBq6FWUlKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uh3io4Ysyl9ApnzjQAx9iX3OKG9IFykBu3zBTJdI8N68Z/lZTAJIG7g1WeNGvj0lmlBeMTWU7QdnjIqNdOUPdKNJ2cW53NxoHdLa9KazaXlz/CwN46skEBwuTZCiR5NkB8rHYXcZVOHs1IDGOos3nMSR7SaHXwQFFlYSOZF6yLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJwhJBcS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb2314f52so352460f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 00:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769069408; x=1769674208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QNSsO4GTvrQKxmXyShjL87zNttG4r0OUhsCw6jrsiXI=;
        b=LJwhJBcSvNmD1HegQdNk+CfodMZAH8Wgud6HTB8d+enZO69IME4IwZ+KsdPgkCcVhj
         y5Kxjpc0WyDIhxxc5jz5bCnWY8KVU00QY2II+Z+k5LLgpcuyLPGPIPJTJf79b4ttimtj
         sAuxfv4D5HV5q9S35byZr8FO07d32HabGov5bVCschTk0hyRg1ZaWfj8akfpl4t2gm3u
         eTRFXjc7QLNLaL/TDkZJwLnwPcfJVdjTET0TFPx9+O4AyAlANBBejle1DEEAAeIpTi6+
         BO0QyeCiggjVSlAyfMP/h0ekTWiQTdf9bM6IF2TEk0B1z6tEruExVdSnJMLmwslOw8wF
         00wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769069408; x=1769674208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNSsO4GTvrQKxmXyShjL87zNttG4r0OUhsCw6jrsiXI=;
        b=KX3w+a2z5L8RU6JmaGkuzwEX41DQujy8BaANiUH4Lpg974EtI0CwtQf/LpA4W+OXS5
         ZWf8HVvap49Ogh8tpaEkIN1trOUVhCbbePYNrd0O3zeLyFLEVz03DhFu7NvV2J/n++35
         NGWqQk1POvc98aDBjS2qxShjarhTc2truIDPHC86rb6o7B7E+NFli4gfX2LTxBE5+YGU
         lcFNQK17mHL1rBtY/IupEBkBQsMYE/TzaL6Rva4Qc3Y+qGSMyftV4foaw+xqaru/Bl/t
         I+ry612OCyXefja3J7vD5TB34DC8JDn3CU/g/G2onKm+JhIxx7nqIvR0pZw1O1CrUzwl
         vo5g==
X-Forwarded-Encrypted: i=1; AJvYcCVoE9isWOrlpQrrAuUFc6ZtJEbL8lVygmKmdOpKTaI6NOEeuhfUKOxH35/awXTCv+cp6lMuk4k8Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFVHyLJ6lE1CzTb5YLipZDEHpgzfM0mS6KRhIZEMUJEcREfBud
	PBiqvqh8qp1bbpPlai9gjF6826hTwZATgwtWYjLqpKtldppUcBJzQz+9
X-Gm-Gg: AZuq6aIUp2etoq1etKCMkrAxjbL/1r1uzEADIed80S2fP6vsnZoxYJ7x+0XndcPtrvT
	HcSaEbjl/bJezOEcPkjjnalydOmK5asEMyzGvXA1C0qm4m1A6ODNDqa722+oefGYZZsv0DP+mFw
	autY7WX9XgQkZROIOh7b2A+Bw/QlPKZ6X8QBwXMNZsPegJZqI3niVITdvLKibRpqTdLO3CN3dWd
	Et2MWKcn+PejRJOpO4/tdYf697qXQc1PCf+DY3EM+kJZXoyunpoTZ1f55q3Bes6T/yGx7e/KED/
	MVTy0VhQ+3W/6wEHcUWlb23aiV164UPWe/+9QRfrb0gIR911SyAva5C9466uvPEy5MBxPpS8MXq
	R9vDJ28P6410pBN5gPWKXmLc/kuhvPO1iT7M0I4vwXXqWESQQuKxdtLr2Gi4o56XT4Bt1NXgyHP
	mLhlweLQMf/8vV0epnZjGK0v/1iRg99FHdWCPlFYI=
X-Received: by 2002:adf:e3ca:0:b0:435:9522:2bc9 with SMTP id ffacd0b85a97d-43595222c80mr9996237f8f.5.1769069408176;
        Thu, 22 Jan 2026 00:10:08 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f0e:c606:9800:ea1b:9133:ab8e:bdea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997ed8bsm43766261f8f.36.2026.01.22.00.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 00:10:02 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,
	christian.loehle@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yumpusamongus@gmail.com,
	Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [PATCH v2 0/1] cpuidle: menu: Fix high wakeup latency on modern platforms
Date: Thu, 22 Jan 2026 10:09:37 +0200
Message-ID: <20260122080937.22347-2-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.52.0
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
	TAGGED_FROM(0.00)[bounces-41273-lists,linux-pm=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: E4FA162F14
X-Rspamd-Action: no action

From: Ionut Nechita <ionut_n2001@yahoo.com>

Hi,

This v2 patch addresses high wakeup latency in the menu cpuidle governor
on modern platforms with high C-state exit latencies.

Changes in v2:
==============

Based on Christian Loehle's feedback, I've simplified the approach to use
min(predicted_ns, data->next_timer_ns) instead of the 25% safety margin
from v1.

The simpler approach is cleaner and achieves the same goal: preventing the
governor from selecting excessively deep C-states when the prediction
suggests a short idle period but next_timer_ns is large (e.g., 10ms).

I will test both approaches (simple min vs 25% margin) and provide
detailed comparison data including:
- C-state residency tables
- Usage statistics
- Idle miss counts (above/below)
- Actual latency measurements

Thank you Christian for the valuable feedback and for pointing out that
the simpler approach may be sufficient.

Background:
===========

On Intel server platforms from 2022 onwards (Sapphire Rapids, Granite
Rapids), we observe excessive wakeup latencies (~150us) in network-
sensitive workloads when using the menu governor with NOHZ_FULL enabled.

The issue stems from the governor using next_timer_ns directly when the
tick is already stopped and predicted_ns < TICK_NSEC. This causes
selection of very deep package C-states (PC6) even when the prediction
suggests a much shorter idle duration.

On platforms with high C-state exit latencies (Intel SPR: 190us for C6,
or systems with large C-state gaps like C2 36us → C3 700us with 350us
exit latency), this results in significant wakeup penalties.

Testing:
========

Initial testing on Sapphire Rapids shows 5x latency reduction
(151us → ~30us). I will provide comprehensive test results comparing
baseline, simple min(), and the 25% margin approach.

Ionut Nechita (1):
  cpuidle: menu: Use min() to prevent deep C-states when tick is stopped

 drivers/cpuidle/governors/menu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.52.0


