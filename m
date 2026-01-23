Return-Path: <linux-pm+bounces-41378-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKksOASBc2nxwwAAu9opvQ
	(envelope-from <linux-pm+bounces-41378-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 15:09:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBDF76C10
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 15:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9920305993F
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 14:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EF83101B1;
	Fri, 23 Jan 2026 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umWR+2XV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21B311C33
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177034; cv=none; b=dCtNlc0JU58/IhGe7ac7IfWSR3+LSsfMRRMI11+8uYPgH0yIdvOQYJ3rJ4J+w619QeIbzEBQczIe25ExcE1Y6G6jDxCdiP5bGiwoyrv7ONj2YChIHJXTOYf79GVZgsHZ8BqNvQHQiJqBkxe+Non6k15cj/jbuFH2jYNaxISh/og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177034; c=relaxed/simple;
	bh=cbwL/YZ4UilhCaiHWa3UUw8jnvLlX8j1XzPaUoH7ovs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DNb+as+ObRgjfyrjvOHlJWjGfDoczYnet3jpLZ3+ntlZ6KVSCYIxkSfGgHys1TOURsY+oyKmPdF8qh4N7shWaPpBZ2Ao8Ig3XyNz8/yfsQ/9AA/u7BUlV0hwdnfOTjt/116fV76WGboWzLMETHgC1x76ejITeLDq9N5EcO0RuHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aleksbgbg.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=umWR+2XV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aleksbgbg.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47d62cc05daso21584975e9.3
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 06:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769177029; x=1769781829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EoeGlA3h5CpIHkfVehuCUZuXt6jRZ7PdOxFkdAMedEI=;
        b=umWR+2XVuQqTAec8MaWQnORWj6tv3VZnvnveBrMw9R3lDc2jV8jJGwVSOZ/KRjoqqR
         tsrrN19J/Ospg7ZHqDo32mPMRx3Prz+APyUG442kVtYTjbyJX7LCzTjNdrxTU4CcXux3
         V0Jx/aXEH181FjlRWrO2gM+n0b5ybB6Pw1Bv4+gDu9A5SJMVoGm6UA/bcEcfSEuBQni0
         J1qoMXX3zJoAoGtqkO7msHAdByeupLZ/pHLpw9N2mzyV1w9VKN+cg7+BDFHUUICB3ku7
         3adMqa56JAESSGFb6cDCkGXrqcZ7GZZqnDKzsz7UdK+i5JruJCRoNIaT0sb9/t3Nc2Tl
         rU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769177029; x=1769781829;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EoeGlA3h5CpIHkfVehuCUZuXt6jRZ7PdOxFkdAMedEI=;
        b=eZ4gAsQVxJA0Hb4WqdeICXRMdfXZWiTp00RLZ04UhD+8Xcp75ml1cLDYFoEkyXwhWy
         ZMhTXqhBusY8lSzwoNEVLymUF1WpO4+knlCk0lRqfmUIH0oZGmiNkf9GG2NwJE5n4JVu
         qWSObtK+P6wjhngd7ok05S82fzaI5+z7rw2Gj35h2k+7Q0Ce7rJtOqEmwu+cG2QEBrDx
         AJoGR8Fhtv7ZqdhXWHoxVgsZUYxjw6SpWBtB4RplwD1d4fYFThN2JBK8G3eQgRgH8l+s
         GK80cR0lWPeKuKZMoCncrWXxUaMvvTou9a6zF9EpVQi7007anmbFPCxL8mq1Xz0uEGfK
         fH6g==
X-Forwarded-Encrypted: i=1; AJvYcCVPG+fz9HLaH8NlQzNhXiJpGKR1IDCPgJPipFOkY3K/GvSoeIeZsXpgaUhqpcemEJHegfQtWiP3QA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRO17oGW+jsNdrsXk1M/X1D5SEEtW0P6bM3zF+qP1p0LRX0yKj
	oGu27U3Onjy3x52LVKwqUJRYQ0Uctwor9FRIb1c7iH/JDe/FTe5NDJOSV7F+oCesCpGk2fBxH3u
	9tC+fD9ieje9JDiOvYw==
X-Received: from wman18.prod.google.com ([2002:a05:600c:6c52:b0:47e:e07c:131b])
 (user=aleksbgbg job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:34d0:b0:480:32da:f33e with SMTP id 5b1f17b1804b1-4804c9ae6a0mr56897025e9.17.1769177029295;
 Fri, 23 Jan 2026 06:03:49 -0800 (PST)
Date: Fri, 23 Jan 2026 14:03:44 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260123140344.449458-1-aleksbgbg@google.com>
Subject: [PATCH v1] OPP: Return correct value in dev_pm_opp_get_level
From: Aleks Todorov <aleksbgbg@google.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Aleks Todorov <aleksbgbg@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41378-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksbgbg@google.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FBDF76C10
X-Rspamd-Action: no action

Commit 073d3d2ca7d4 ("OPP: Level zero is valid") modified the
documentation for this function to indicate that errors should return a
non-zero value to avoid colliding with the OPP level zero, however
forgot to actually update the return.

No in-tree kernel code depends on the error value being 0.

Fixes: 073d3d2ca7d4 ("OPP: Level zero is valid")
Signed-off-by: Aleks Todorov <aleksbgbg@google.com>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index dbebb8c829bc..ae43c656f108 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -241,7 +241,7 @@ unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
 {
 	if (IS_ERR_OR_NULL(opp) || !opp->available) {
 		pr_err("%s: Invalid parameters\n", __func__);
-		return 0;
+		return U32_MAX;
 	}
 
 	return opp->level;
-- 
2.52.0.457.g6b5491de43-goog


