Return-Path: <linux-pm+bounces-41208-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO98LwMycGkSXAAAu9opvQ
	(envelope-from <linux-pm+bounces-41208-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 02:55:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 335C84F682
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 02:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 252736AFC68
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 01:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079AD324B1C;
	Wed, 21 Jan 2026 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="slEyusAK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F532255D
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 01:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768960498; cv=none; b=KPXmdPMWR4gT9npBD4MijYKD8Gx1yf9OPGt2cJivHnsneq35DrXDHuWsFXnBD+OpAaNcPVfTwdagHuZuMicTOi1vyxFjrw+6nDU5vLO7/p8YLvdkjCaNoCxaeFzNzHoLU4jjSj8aIdHPtPw7ovd8dtHWXmA1vs2kAm4qYAwoZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768960498; c=relaxed/simple;
	bh=Rmqp/m7akasxWO6L3dMMic3piFM2EjGmsa3rEH5mUGs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sAXYSK110+K1CfKDzFK55lqueSFSyd6gjGxF4kfWKnXnfiJJKxh8JfhNmv+BcaP9SnsV1VmXFNW0uAz02IBMLu/5+jCbPwkftAXUD+AdENb+qFfNqPMhAqD14zpuncWuSsaeKMWkD37uuaQIBTFjzCJBL1EmWv0TqYhHSN5F9F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=slEyusAK; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c5513f598c0so2328605a12.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 17:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768960486; x=1769565286; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hUf88O7+JjGtU1cVF6m4MJJt+3dBEy09MHuH37V6osw=;
        b=slEyusAK2eOzBIms0tGaUZzXR0MZxD3ylp6Eit3fTvqDdZmYL+rzaPRkcmDwP8H+Tn
         /EjZThkAJHjiUgIOe6zg8LiOEnBgSXVVSnpdSYRZd1+eHqkY8ljChrJMPgyBEJyz551Q
         oGTxbHYWbfgK/6fzflTare7up5JOabsgXaDCVmYqd6qFwtTYM0xZmWWireAN+bDzZd+j
         NeNc89EbL467vY0ssqUhV+xHWjEy1a4+lTY3IYHpk+GgaiUHJWbE3SJOHS6A4jpqfcy8
         yWB3ERiC8P/sL74aBDaGzUktdA1rtwr4677w3gb37Nl4009DP7lMtP6V7agd/e01N/Dj
         Du/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768960486; x=1769565286;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUf88O7+JjGtU1cVF6m4MJJt+3dBEy09MHuH37V6osw=;
        b=biIt5c2AqlUWmifIABWoNgH/gho1WQkNvi+6dArSJ7FpGFNZKwmwmncSI5giBVkZVM
         CneU90gB+UEbpM/rQbylTc+HrYAgm3Y6aK++aKCEWalEyD503x4zSrDXj+Ag3haWSRbm
         GZeP74lJRn41onHOVmjQ7mjf5Sx1abWlWoQnJjgeLLeJOL/u4mvgYff+OBjzchOh8qn/
         vhPtK5SrSt9zkL8HFU92cqbiDhYKYRESYCUlUHCAwMQ6VzWH4zeQUMUzV2QOH4KGreHE
         hjWyUYQv77SGUJA4LOof7P0pJmdM8HXGLDYrtE6WEr/YEDj+bVz/O/3g+dxL6zZSbFeo
         WIOA==
X-Forwarded-Encrypted: i=1; AJvYcCU5PBGv1wWJmNQfRXhloILv2Uj78bC3lD1pjbHfJKVWoWW0ay8NK43ZBw0aVXzS8YoKzfwOPOO5Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAvk4dh6Lyph8t3IEESSN00t92o8hMN99r1t+Oa1NyjZJ7VC19
	8PijlCAumbjHKvGWRhFFPk+ng4k7AkD4cqSIcE6xMwVZC9onOzEYweKsww2Py1oNbW0=
X-Gm-Gg: AZuq6aKQck26lqYC2v4p8Bqv70Jq7laJRRHx2uysX520B68WnGc5i0RxxTfcAnWz9PI
	Qs4D8L64DrLDjSVA/ZQU7Umz7faSEwY9EMsEWpuL71nqS/d2+fa11ZBI1T9ItXK1FWiDpvRCTVE
	kVebrmaGlPBF7SGCHGJyg5Km2MUHu9AEJvb4PgDzYH87GJ3JV3ungSDQ9/Up0kuRuIvtu7xi+/C
	5iNQBeMsLrkts9jZjkGjo8FZv6Vk4LqQdUl1vKxJrXIoSaKliRhqp6sV11mjwQEDiDsoHKFtay2
	wSy6zZGepg+AKfmKMzdiNAg57ufePJBOoM/RuAeV99ORp8xtr6vgWX//YmuAtdMzYp5aEAboXXa
	pmNuVABrYl/2+nYAGgczWXt4mM3+G/3k4hHXqu4vTJM4w9Yqr1VnrlJTeWaOD1+qLG7D/eH4tId
	r1RSuK19Io
X-Received: by 2002:a17:903:1110:b0:271:479d:3dcb with SMTP id d9443c01a7336-2a717518996mr152931315ad.6.1768960486067;
        Tue, 20 Jan 2026 17:54:46 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a71941c088sm136095455ad.91.2026.01.20.17.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 17:54:45 -0800 (PST)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Subject: [PATCH 0/2] PM: QoS/pmdomains: support resume latencies for
 system-wide PM
Date: Tue, 20 Jan 2026 17:54:43 -0800
Message-Id: <20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOMxcGkC/y2NywrCQAxFf6VkbWA6tFr8FXFRZqIGnIfJVITSf
 29Ql+fAvWcFJWFSOHcrCL1ZuWSD/tBBeMz5TsjRGLzzR9d7h61UDvisCWuKJc2cMdouEIaStYm
 JpkgjnaZAwzQ6D/ZVhW78+XYu1x8LvRbLtb/cth2baIRljAAAAA==
X-Change-ID: 20260120-topic-lpm-pmdomain-device-constraints-e5e78ce48502
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=Rmqp/m7akasxWO6L3dMMic3piFM2EjGmsa3rEH5mUGs=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBpcDHl8I/YVHnUKyUUE/Tsj9yEaWCIxOyAsCJLe
 HDH7mbf+QmJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaXAx5QAKCRBZNxia0/vG
 ZRvyD/0fLWbqpk/lRT9JHQXTrOZBjPFbodCyqMWtICOZhvhTsbTPwJZpFqWITJC8FzioDBZWEEF
 x+54z8Qo2YfkHqE4A3hdgm8OXIubyKTfX6apzsJtY4HnPASEoGQqCR81cqCjdNF4CmJ2qkxIXW7
 RChhwjJ6Gt6vwPbpNreTO9k1QWfoGwVb+eUamWLuJNkA1DINTAWnEMLDzsgFyFohu0qwW/pkK1e
 3qQZZHHerkSt5SwMmowUXr6D0xCsnbx9t2arlIbENjOiLdB+kjszeCoCEnaW3EuA0YIpKOnrs1T
 40cFvBYvCN4MIZ5Ta7ozwoEgrk/odsXEJfJE6+6o4zA8gjgNdvmyQHJVJYtK3sNxC6HtXWQBdVl
 APaOWvCTkOWc3+y2cek8VsOi6ytUB3lC5xuCZjKwTkbqV/c6y6EwxbaDZ5fihW/SwsYPxYPSwiM
 H0KZom/Kc31lvxYPEXdGyWkwKqX/4ow/cni1BCOaJQ5LE6LGCcLODhCR6pqzaIR5GOKizLgQrRG
 6vbBAfx/R1OJNmrly5+SXCEeg9faEEU5CKKF0dwOhd3kLa178R//4OY2TSdYbctM4PpJJL6ZZOQ
 NIhxGqVY7EtDNbMSWEPdxX7voAW9QDSnANOcR6TglNgxCFdHSFx0AozdGOLIRckNQBHcbjwE4Rv
 9pandF1aZyRgzcA==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-41208-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,baylibre-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 335C84F682
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently QoS resume latencies are only considered for runtime PM
transitions of pmdomains, which remains the default.

In order to also support QoS resume latencies during system-wide PM,
add a new flag to indicate a resume latency should be used for
system-wide PM *instead of* runtime PM.

For example, by doing this:

   # echo 500000 > /sys/devices/.../<dev0>/power/pm_qos_resume_latency_us

dev0 now has a resume latency of 500000 usec for runtime PM
transitions.

Then, if the new flag is also set:

   # echo 1 > /sys/devices/.../<dev0>/power/pm_qos_latency_sys

That 500000 usec delay now applies to system-wide PM (and not to
runtime PM).

If a user requires a different latency value for system-wide PM
compared to runtime PM, then the runtime PM value can be set for
normal operations, and the system-wide value (and flag) can be set by
userspace before suspend, and the runtime PM value can be restored
after resume.

To: Rafael J. Wysocki <rafael@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-pm@vger.kernel.org

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
Kevin Hilman (TI) (2):
      PM / QoS: add flag to indicate latency applies system-wide
      pmdommain: add support system-wide resume latency constraints

 drivers/base/power/sysfs.c  | 27 +++++++++++++++++++++++++++
 drivers/pmdomain/governor.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/pm_qos.h      |  2 ++
 3 files changed, 70 insertions(+), 1 deletion(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260120-topic-lpm-pmdomain-device-constraints-e5e78ce48502

Best regards,
--  
Kevin Hilman (TI) <khilman@baylibre.com>


