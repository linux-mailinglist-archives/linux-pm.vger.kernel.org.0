Return-Path: <linux-pm+bounces-42186-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJ4vCmI2hWlf+AMAu9opvQ
	(envelope-from <linux-pm+bounces-42186-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 01:31:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBC1F8A6D
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 01:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0F46301F33C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 00:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD5E21FF23;
	Fri,  6 Feb 2026 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HAoR/549"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84F221275
	for <linux-pm@vger.kernel.org>; Fri,  6 Feb 2026 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770337814; cv=none; b=NyIwGNQyHfneazw1g8k895fa302VlCCYnucoyU26fvA/x5gTzgbbb0+iYD5ay46yylXU2zYkRNxA3XdToets4L+oLM3rdmmpedQodwuC0F8GkCvkbHh1G4LVJdK3bBFrdK0ClamIGECWP69hWO3OdPCBj1rzWeg7zJEO+JPqvK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770337814; c=relaxed/simple;
	bh=1jGOBqEAdToOhyDULhg4DWaXfwam16dPRiJvXBh0MIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MW4EqgiR7y+HIzwh3Urdg6HeTK7tB5qDJKrzsIBoSIqJeptHBYgzd+GwEWDjnHWcS3Pw83oKrnlTsC+mJ4Z7KRIaoBvg/3MPKDjYqh45f4+xegIiqqT9793Wc5p1BApylLIo8bOlVTY4iGQYQsZ/DBxJc0SZ6lKVQWKeXomeJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HAoR/549; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-352f00d0e83so718640a91.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 16:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770337813; x=1770942613; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrN3Hy5+qjniQM1xljDClFlyW3uFR+YG06Wn9GxtVMU=;
        b=HAoR/549PWWkEzbdMaNeX76qbsef7aFVCwHvmkc8RB8dMLb7JAKq2l9tBuiQjNU2kK
         tFknZnFmuCbsZaqacm7NanOM2vRpLj9Dsx16xXRyBKXJABBz9OBNKs43te0/TJmdgpmd
         PI/hrwmP4/19BfwQ3/Mupw+BzRWOWmOhSkxFF7lCdY7sx+uVXGcO7AiDzMV8fNRyjtrJ
         GPplGXE8HTenoOfODkP5p857H0+5GYeEzpht1yU7EoiY6ZGuaSWIGNeMT+SGDXiLB3Ve
         9rbVyXiLgBfnfPDeQ2W+pM51RYVqFW1+tC0jhakgvpRi3+Ti7Jw4nkieU/wpcn57E20F
         KhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770337813; x=1770942613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RrN3Hy5+qjniQM1xljDClFlyW3uFR+YG06Wn9GxtVMU=;
        b=GL7k/uMwsf05vKd+TlbvNSus7GwGVFrpHx3nBW2NKnu8EwflMnv9u80W5Y/S4w9Dpu
         mtJajiAmFyzAJOu+6Ye1Ne2s/Ho6Nzregw/kXf17rA81KIAxA/cK6hUYbU7UKneTHJcS
         rD7Hfw79nigo2HydkibddLrFq44DTkOjwC4xvLIyu1JgFhdNNRSWvdltfumT6A7Y2hqL
         hbc9Ph3jn3hvticHMXNyjOYbv208Z0lzI/i2u9Dfp78NybRzTqhKZ5yvgZ3xfxgvp/BF
         tcl8Hub1e7oBdstI/EQVbtgFttexjuvddrbXTRdVLOevHPObX+jY7tYj34thpmISbZps
         T2kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSqo2qE5+WqYCIOhCHJgh4DrD/sRtaJM+HYRGihY0KFBakgIVINyosNUM2y2UUMVpy6q/7cejQLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwKexu1QIzyGRVWF6FlC3+ReoiKnUlGG8KBGDnlDSpBlAdGt/
	v70lxH/S7gcPpQgNCsuC9vr5TDFSUCjIfu6ZVi2kemFTauBI3FLmVySStXItYCoKgE0=
X-Gm-Gg: AZuq6aLE+k9uS2Lad1O8ywsm5Rp/4dLmyI77157rIg8pORVfaa3W77DI7/iH0zgyZQ1
	eyFV7WwIW1pZdFNjNCu1CxwcslKDRRvK995aL/Uk/N3VoTStazkxOn/MCboBqX3nqSdeYDitpv6
	sjCmp0UVNmDzbefOgEMFdc8Gcl5L6Cdctzdx840JFgkZdS9uBwiPIlEO2So0miW9cs3HandHyBp
	cJRr9mMnQ/5E/+SGK1GuHAOAvnZ9fP0ysxGHUWAc07WroUaSNSKDxmMw8wk2gawEQ7D7FBQTO4b
	zpRU0xK7iEiJb1Sc//U6+Hhgnkq7/W5n0I5UCsXZ0fvWrxAw8wtSMHQFuvBh/8teLJdsBfJeIsr
	1RzyjQy+V7HL9EjLBZWj5MeFTPIJHAVJFLAkrCwts3znpUO5nrUUWWXIVF5nC1h/fYB7H5aG9fC
	sNt+cg+Urw
X-Received: by 2002:a17:90b:4c8c:b0:343:684c:f8a0 with SMTP id 98e67ed59e1d1-354b3cda0f9mr723619a91.23.1770337813050;
        Thu, 05 Feb 2026 16:30:13 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b21f9178sm795845a91.11.2026.02.05.16.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 16:30:12 -0800 (PST)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Thu, 05 Feb 2026 16:29:55 -0800
Subject: [PATCH v2 1/3] PM / QoS: add flag to indicate latency applies
 system-wide
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-topic-lpm-pmdomain-device-constraints-v2-1-61f7be7d35ac@baylibre.com>
References: <20260205-topic-lpm-pmdomain-device-constraints-v2-0-61f7be7d35ac@baylibre.com>
In-Reply-To: <20260205-topic-lpm-pmdomain-device-constraints-v2-0-61f7be7d35ac@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=850; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=1jGOBqEAdToOhyDULhg4DWaXfwam16dPRiJvXBh0MIU=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBphTYSsed0yG8Ju3nJQEklrOCU7mygfYzJoj9nt
 OFJnIjrKgGJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaYU2EgAKCRBZNxia0/vG
 ZX4ID/9uSj0cth+0hoHlHMuGLLIYCcuaJFmgLdgB18tlG8nmEMwacfl1Vh8RRD2ZVvaAQJ/tB0m
 3Sitb1on4EA8p6dUvf6PgaDklZ/ylXT5Hgr13fwI+hMEYQdoibHi4M05hiaMvo7gJHtK83jOSYw
 sZvLqzmT2UubWRMkwjXEscxyi2G9DHqYBnREI86qQu4DA7fEyWBOHa1LWsFmwQqhnuMenbyOaRO
 +8ysdEsqkd1bGWEKBfmDMcd3FXteDrzaYtRd07YOQJUPozn8WYeGa6sWlYBYC0lYO/URZTqO7cz
 fJjCEB1I5jefrzH3C87qUArKlYraij6anODKOpE9zDSWR427mN+GYXgv5Ziz4kHZEkOLgT6AgRk
 Z4m47lAGCLKB5YDKctVQkIdNSqdBtfm0qxQjAEqWdQdwWk9pQRt+auefLCJPaOKyxeV6RsKIxo7
 FjXXnT2sxN7sWAX1bvB96vB6gdkjMZQ9NJtd6lNakddBO+lIuPcAuWOjteIfnpCDsx8iqscL2Yf
 /vr47dJla6S4v8gybSiUumTT9TBDiVKdsfiJK7layLJxTViS9+vROdZsUZzIZrUac3XVuLm65s6
 ts7IbQ4LH+qi/3hhfLEFxVU8ZO5It6ntIv9g5zBcR78Tt6xn9YMzBYDYAc5+i6kHc0xcDqkUNfy
 JbvQEEJPvvuveLg==
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
	TAGGED_FROM(0.00)[bounces-42186-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20230601.gappssmtp.com:dkim,baylibre.com:mid,baylibre.com:email]
X-Rspamd-Queue-Id: BBBC1F8A6D
X-Rspamd-Action: no action

By default, the QoS resume latency currenly only applied to runtime PM
decisions.

Add new PM_QOS_FLAG_LATENCY_SYS flag to indicate that the
resume latency QoS constraint should be applied to system-wide
PM *in addition to* runtime PM.

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 include/linux/pm_qos.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 6cea4455f867..aededda52b6b 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -37,6 +37,8 @@ enum pm_qos_flags_status {
 #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)
 
 #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
+/* latency value applies to system-wide suspend/s2idle */
+#define PM_QOS_FLAG_LATENCY_SYS		(2 << 0)
 
 enum pm_qos_type {
 	PM_QOS_UNITIALIZED,

-- 
2.51.0


