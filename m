Return-Path: <linux-pm+bounces-41398-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEPQCi8fdGk32QAAu9opvQ
	(envelope-from <linux-pm+bounces-41398-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 02:23:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6417BF17
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 02:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 497CA3073FDA
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 01:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022C31F0995;
	Sat, 24 Jan 2026 01:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLYZQwrZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A361E9B3F
	for <linux-pm@vger.kernel.org>; Sat, 24 Jan 2026 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769217723; cv=none; b=dlqFUDtQld+CB+UBx6xgFgzRI/dwuDyfttxrNvQDXfZivChVdMl/S9HigCgoo+jEyzByTKhP2F88/FtmIK1FhDe3slLHhahtmZud2NWS96b79g3LvyL2h3EqpVTp/LBvjd/WO9d03n+uFLE/BcXUWJIyHJfk3llrYUtfazODNZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769217723; c=relaxed/simple;
	bh=wvQSevTks610RBfJ7oBqtsKqCB/HWm0eJW4rW75kywU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CtjnFHkfX0ykzMuQOAaYsdaCO3Ze7vpvmsFvVb51G5EdcIPJw4f3fxOQ+HmmnlBjCDxvt/evqedT438VO06FbF393Wab00FjmhMopdFDjKtYIBb+fiZN9T3Gd1oMlUYvgvClvOP0JKRRV1XkK0lp4fwpO6TDsWwhJezkBBmQlD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLYZQwrZ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12338749ea9so3711965c88.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 17:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769217720; x=1769822520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a577FNgbL0JbRd6IsOu504RokGc/26jdmHoERsXu7xE=;
        b=YLYZQwrZQdClNm0+ozko3XXQMt5QHTLB7dWO7oLhxt0v1xuuJ3CcXIKg54k0W/Qomp
         1IMBOsUl6CvRmULjpxw6yiTLZW0Zn9lGrvDwzayqa/+ZeCrum+Tr0WdhunptrrZwhayo
         gnfMxwWT1rbB40qlchCCJWgV+wN5AO8ttGME9i5xHxv3Tft5u0DpEBy7ji6Oo/eM8Yla
         k4RVwQwaz+kDUB2lp38uc9IOxpEjqzCSN1+Yq16vdPd07lqh91IG3ZnpEgHYjggqIPxs
         7WIp1zY6+RlKqwUocNhrHV5AoyjRDTu2EZMvN2b+1MMqSxMOq/sk/NChMdnqT9wNoUGc
         9NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769217720; x=1769822520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a577FNgbL0JbRd6IsOu504RokGc/26jdmHoERsXu7xE=;
        b=Oy4Y+ks+v7wEsRvde4jMA0ScjKPRSqNA7TajxKP5h3ap5MY2E91WnkSLfDu2Z5Oj6D
         eQT85ohD166SnQzVt5UOMiW/TQKpyFcSsF8p37LVgZg+ypKEBepNhC1UmqAhN8UjxE0X
         zh9+T59ptqX/usVeetPRfUgB0b9syq0W3azidIX2PMsvXmxZxMxUD2jKUHcx/NizEDuo
         zZjDl4jcX8ICieXPELKmizal2i7nhP4FNHn1a0ia5Yr5QaXuRE7jPDdM9i3LqVBLG65L
         cbwhIVdfZhP1lH1+YvhcWaleAhCOqErvvilOXxtRxWbvP12HAy88QNy71LVwHC64aLvq
         DLlA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ5XfNoU8I1yGSFyX+QOyM5jfB8tXgK9mp/WaPsnnytIAZMVAk9hHzESP8Gr4oyE7km7MXEqkmOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyArBTpJSgRbLTEqV0VhZlm1oBnwFcrLbtY0Evmsetd+RfvlfVQ
	Nf8AfvcRPH9hLwf49zphU0xE7cU0Mk3MPs9m7uFJqRYNUUJCJTHVmEOeTzyISE1KGV0Gi/QA5DA
	6h6pQDTfwpq/+YQ==
X-Received: from dlbcj34.prod.google.com ([2002:a05:7022:69a2:b0:11f:3043:2c7f])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7023:c081:b0:11d:fc4a:c4f7 with SMTP id a92af1059eb24-1247dba9450mr1771878c88.4.1769217720087;
 Fri, 23 Jan 2026 17:22:00 -0800 (PST)
Date: Fri, 23 Jan 2026 17:21:29 -0800
In-Reply-To: <20260124012133.2451708-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260124012133.2451708-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260124012133.2451708-2-wusamuel@google.com>
Subject: [PATCH bpf-next v3 1/3] PM: wakeup: Handle empty list in wakeup_sources_walk
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41398-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wusamuel@google.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB6417BF17
X-Rspamd-Action: no action

In the case of an empty wakeup_sources list, wakeup_sources_walk_start()
will return an invalid but non-NULL address. This also affects wrappers
of the aforementioned function, like for_each_wakeup_source().

This patch updates wakeup_sources_walk_start() to return NULL in case of
an empty list.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 drivers/base/power/wakeup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 1e1a0e7eeac5..e69033d16fba 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -275,9 +275,7 @@ EXPORT_SYMBOL_GPL(wakeup_sources_read_unlock);
  */
 struct wakeup_source *wakeup_sources_walk_start(void)
 {
-	struct list_head *ws_head = &wakeup_sources;
-
-	return list_entry_rcu(ws_head->next, struct wakeup_source, entry);
+	return list_first_or_null_rcu(&wakeup_sources, struct wakeup_source, entry);
 }
 EXPORT_SYMBOL_GPL(wakeup_sources_walk_start);
 
-- 
2.52.0.457.g6b5491de43-goog


