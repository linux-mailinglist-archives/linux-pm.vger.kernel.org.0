Return-Path: <linux-pm+bounces-42185-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCSJGFk2hWlf+AMAu9opvQ
	(envelope-from <linux-pm+bounces-42185-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 01:31:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B97ECF8A5F
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 01:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DB8E3014C3E
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 00:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9537622068A;
	Fri,  6 Feb 2026 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rf7Lev1F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA41D6DB5
	for <linux-pm@vger.kernel.org>; Fri,  6 Feb 2026 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770337813; cv=none; b=MSB/hC2v/ye/KP1RvNjwkSHqd9YgnxWl9Jy6CaU0iH+vgiXkFpQO4bLnSGtEQCx+SpU9wwQ8GbbeLPj4Bc5AodpucTGyWSgcAQvXVyQY8ABd68s65y6Y9ZJgD/j1R9Ko7BFfhja3WwMLe7nXRj/CZogQ+d0STs5qI7D0M/8ZMcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770337813; c=relaxed/simple;
	bh=pJGGaF4SAuCQ26PqscJU/cq5kYHI08UZ/GeAeNYZgMo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aDtbRv1HmNQXMobW1zUL4eQs15/Qce1sxPWGCkuSoJaobenM0WZReJ6ZfhxB2h1PYtf3y3TROoBWcv6uHS7+TL9BO+lWkZu7DF0xlnZDFTDOpBZqV35x85/ZwXeXkKGIQMFMDByhH8oMXtS8MnWMo11goGhGCdi5uBlV1KRAdD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rf7Lev1F; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81f4ba336b4so1313366b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 16:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770337812; x=1770942612; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qF/Yzqx2szCI50PcY7V0B5RH+WZaMvhchvBAj+YCyU4=;
        b=rf7Lev1FCkOIdtV+kwWOT1Pfk1xL75SLhj9xiOtYUObkcbyJ3p7vnvJy9qPpS6ZXqp
         /Hw0gjD+fowetGeRvmbbr1oHlNYGCm3s0Mc3pGRHIiAmhej24i/fPg2Dx5R+R5vs161n
         n2JfeBDRTLwj5JgbZQHYDXfM3JSnYvhwqypfaolAUUVM60+X8pZHxuslnBBs8LsUk8E7
         mGyDkxyKs3sK8AQgcl5puP43au1ASvz/63MT/ME0aiBRYZ/s8IIKTGbrUJLUq9EQarVl
         t+vHZHqVo+ifoynxWyxDuxFX402Y2v7bcj8GUmatH9u7MTspDRcyh1XIP0DbUXwN4pHT
         7QlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770337812; x=1770942612;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qF/Yzqx2szCI50PcY7V0B5RH+WZaMvhchvBAj+YCyU4=;
        b=Wis1SBHs0wbAb0PlrKDauy9xhxHFn3x8OLkavZDUiQVRkj5v2cQho7xCKGoQegLVSM
         85DRmuCRdwPMq4WQ8G6RobuRMNwlhYzHFlI/PSsy2/dUAfOoSLqOanQq4J7/AlyW9LSg
         Xbse3jHdQcvdHLmyLfw7VChiE7TyRLwyjFuI7/V/IOf9Q48MCyPLXl66TPiboaBtaesI
         9/cKLNa3kmrZSo9OB/i8pXuyDqZVKBftVWcLzAMnKBTb6UYKzXVkM188LeAk59FpEpO/
         xGYdamNciz/D6T7iOqfJr1nznWanZWopJVbHuAWmPEYCZD+Tbx6gKFuXZX2hd7pjnjiN
         vwsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2/EXSiFDWkhuPMEi19mXJ8//iybrGrBscNCKXV8IVcOC4w4btJgCq9dfirOydGrTr0ykPAga9TA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGsiaduQsMCe5B08A70BghSLUmsSQgXHl+sBvmGVacU8Psn5IQ
	XhjQ9PADUbdEhWYhmCtByFfg48RvuAlga+Dxyj95+zXEMXV6lWX0b0OdLi/VhwZ/hOE=
X-Gm-Gg: AZuq6aLx1i0Wxh7np+QydUAVgAOkj1tNsK62eNtbB5Urdi2vbAjbhZ5difC9MRnmC4J
	Ty3Q1donSm45RyfK4ZtA8dGf5o0cgf7aqVUuQVTH5HqdZNe29UUFY+UEj+howjszJadlHFglpJk
	dDMBmx/70RIsv7tl3pyrGnWA94vZQ96pDs720QRvAtc9/Tnd0p8JZbM1L2M3vyiS0fyPo/gCb91
	MK0bH0tkoAsWvD85tdOHDvUrJj2WraHhYT23uj7w3JNpRBL6O/hXfUEsoh24zB0j8A6VxSnBIrb
	VQ3kW9o/xRmNXUkYTJEVvm9w/c7gqybCP2vlV6D6rFLw3DNyDUqvVrQ0a27sRpJEqsQpCToECOQ
	/zPEJodSZamN6GMBs/EA4QF3TEOCmgbcTfFORvh7/F+INP4Yii3467VuBKZosTcttdLLBXoSunV
	49xRNGhhUp
X-Received: by 2002:a05:6a21:7001:b0:366:14ac:e1fa with SMTP id adf61e73a8af0-393ad3ccc68mr1005186637.76.1770337812037;
        Thu, 05 Feb 2026 16:30:12 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951a638a1sm5509205ad.17.2026.02.05.16.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 16:30:11 -0800 (PST)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Subject: [PATCH v2 0/3] PM: QoS/pmdomains: support resume latencies for
 system-wide PM
Date: Thu, 05 Feb 2026 16:29:54 -0800
Message-Id: <20260205-topic-lpm-pmdomain-device-constraints-v2-0-61f7be7d35ac@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAI2hWkC/5WOSw6CMBCGr0Jm7ZC28YGuvIdhUYZBJqEU20o0h
 rtb8AQuvz//6wORg3CES/GBwLNE8WMGsyuAejveGaXNDEaZo9JGYfKTEA6Tw8m13lkZsc05YiQ
 /xhSykCLygU8V8b46KAO5awrcyWvbudU/Dvx45rn0E6Gxca1wTtKlmI+lPmMgDau5l5h8eG8fZ
 725/7wza1SoVdXRnjrbEV8b+x6kCVzmSaiXZfkCDfOxewoBAAA=
X-Change-ID: 20260120-topic-lpm-pmdomain-device-constraints-e5e78ce48502
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=pJGGaF4SAuCQ26PqscJU/cq5kYHI08UZ/GeAeNYZgMo=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBphTYS6nnt8ObEDtB4PSSU7kiBT1rF/kyjZBh0G
 JlJQFLRKHqJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaYU2EgAKCRBZNxia0/vG
 ZaG6D/9H9W47BK4ylwP/1xv9wA1uqjKgFtZL/qY2gsGd1SKHwIBtKrtr04xekgimBAj4LzEYRkY
 xIlULCQONn33n9a/2YJEwc8jfzx6ddzU3os0UeG2i60KcaGZQRgN8SDOBmE8ORdRiXW+zHCpef/
 yavLV39Q5Im3i4BHgg82f/wLZ8lK2CsgU67lQm9ZDPLs6jb1eZjfFTkrZHkZf5axUnO3LihqhnF
 A5+6WXsvZTIIG9qb8koHPBaKNG40AADFnulW2j8DeNU7MC2hPOwrS0cRO2YnZk786TtQHhlsnfo
 jhB3sdeAFh7czNeZgZR+DLuX8OkO+UsaX26wA1BmJS6GKr7xb+MatzoM8ovt0fDk/wjH+zyu7+E
 Xfi0UfXyPnenfuqyfq0v5bfshXMy/HoK7oZD5abCUN20XMgsO2abF+6oGds7cxCEFslhoqrOTmK
 ncYBenkg2E8t0gEeHc5INv8eIqJLDuNp01gSGR2jQJZ0cl2wpNkRlD5iP9NwAsxqbhEslRLOYFZ
 0aTDXbhzKiLEMjjySMGW+SJGgInT5U+N28yK0DGvL0J7bRiffyKuGXSHpug2Zs3YWHU0Wsn/AOf
 u2PEI/chdcpDCexWkTCgzRooVj8eu9MfNhj7Lj4nteqmgX7VvRmEKQM6/YgYJd+OxpauYEQ0eL3
 h5BNewEJ89S9jcA==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42185-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20230601.gappssmtp.com:dkim,linaro.org:email,baylibre.com:mid,baylibre.com:email,msgid.link:url]
X-Rspamd-Queue-Id: B97ECF8A5F
X-Rspamd-Action: no action

Currently QoS resume latencies are only considered for runtime PM
transitions of pmdomains, which remains the default.

In order to also support QoS resume latencies during system-wide PM,
add a new flag to indicate a resume latency should be used for
system-wide PM *in addition to* runtime PM.

If a user requires a different latency value for system-wide PM
compared to runtime PM, then the runtime PM value can be set for
normal operations, and the system-wide value (and flag) can be set by
during suspend (for example in a drivers ->prepare() hook) and the
runtime PM value can be restored after resume (for example, in a
driver's ->complete() hook.)

To: Rafael J. Wysocki <rafael@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-pm@vger.kernel.org

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
Changes in v2:
- drop the userspace interface
- add genpd helper to iterate over all devices in domain and child domains
- new flag means latency applies to runtime PM *and* system-wide PM
- Link to v1: https://patch.msgid.link/20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com

---
Kevin Hilman (TI) (3):
      PM / QoS: add flag to indicate latency applies system-wide
      pmdomain: core: add genpd_for_each_child() helper
      pmdommain: add support system-wide resume latency constraints

 drivers/pmdomain/core.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pmdomain/core.h     | 17 +++++++++++++++++
 drivers/pmdomain/governor.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_qos.h      |  2 ++
 4 files changed, 106 insertions(+)
---
base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
change-id: 20260120-topic-lpm-pmdomain-device-constraints-e5e78ce48502

Best regards,
--  
Kevin Hilman (TI) <khilman@baylibre.com>


