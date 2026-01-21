Return-Path: <linux-pm+bounces-41238-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNBIHDL6cGmgbAAAu9opvQ
	(envelope-from <linux-pm+bounces-41238-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 17:09:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D91E659B3C
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 17:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4089AA5242
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 15:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E3C480357;
	Wed, 21 Jan 2026 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAOvyqbt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7F038BDC7
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769009537; cv=none; b=pGeGySufepDN7I99fySoiMccI4FKLEVJUEkwVv9Vdq+uySB1kTcGkf2a/7pGoFtPaWOU7u0e/tJKSuSAu7oT0hmZShybBdAgqD8mJZ1JMjBSxxluzsgKdl6Hg2PN9gmkNz704ySvRVmVfGExA11L8BuAjekswN/+MIMbrHzHaLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769009537; c=relaxed/simple;
	bh=m5l9glzlQdkTaKfNaDnN8sFdatZLvmq6941LcITDeuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JUW+2M158qaUtf0gNz1lIWj9g7lGzkb8f7+vTSsYNjwL1PsM+3PpUhwI7O5JKvdgfKKVDto3g3ba+wdNWBDpiDR5Kafk2/vLj+EeB+CA2zwyl2mw2luVo9hYHz259DZszamdWCdRxP8OvGMh5exXL7SGqQRD3xseXlnwZ2om/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAOvyqbt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a743050256so18875145ad.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 07:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769009536; x=1769614336; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4W0ec4fQDJd2xOwnuzTfcy8ZaXM1RW26O37NMjr14ds=;
        b=LAOvyqbt8v7ivDE+p33TZrgRbwTEbuv36g+KhzmWrnLEfrTqxqkpCWgOaIH8x8hPD8
         qzwt2VxzGSJRalMLRfaMgMyXOnu7tKYfvVMeC5ySWzzeoDKvZIL8Q9g6WN4yQz9L6Oo/
         W/ejAPvCHq8o5RLTdFAqpjce+WlXSZArCHTUX48JcY1rJj25HoKhaiZwGWOyX+VGTI6U
         LEFcIdi3mX5osnQAqPdIR+S63tFeYWu9sGnazNcw2zPl9sOyZ3zi0XpxBxgpkCJRER7b
         7B0yHy8ccD4RC7LODBLweWL7zhBsq8fX2PugfqmcMuV0s0FZz7J1bQP260d9RdpxiwRT
         8KMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769009536; x=1769614336;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W0ec4fQDJd2xOwnuzTfcy8ZaXM1RW26O37NMjr14ds=;
        b=xRy4ujvP/wBZCRMnC6U2yrp0KPj4Sf0zi+89XCmiBRyw0DLF0l8DIY7ODK0EAAleIB
         iKJ3b0qVyu4ADOPMR841wuwJ7k0tQV+b1TggnMq5M3XAVZaysJzMmoOVUNDUqUdkk74X
         hw6SO63ooMwcxtC01JPClC+wOJgMzSN5HlZA6edllQNJHT7GP/6ADJE2ufTrNtimtaN2
         mnfh5SNT/Nql3v+X87NzPd9A6Lb/kkqb/utFoZDB3+rLzENGvzcg6QbDBHbSF1KDuMLD
         DwEoFwy70/QfjwBiAzecZhIuSFbkTYMOlKJ/aFEkOr8G331rtWmzz234MtRP18KKgotG
         GyOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKeD8ArU0Ku6ODwKH/Mj+l9BmF33kHgK+ziW+YOV2ydUy2CECjZ7tOnMwjAEs9xWKVOyuiXiuWqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzA+ttBy41xpB/fU7Cb6lFMEbWKcNIu7GdFq7wmAMZuN8gLU7n
	4nb8i6JX/ps4Q3YHx1rai0bMKOIMh39+8GAUHtvwgXHKfCirN9Yfj1qF
X-Gm-Gg: AZuq6aLysIYI0wJYmLXDP6HZF2JuFDJbVs75KXVdLD1JHGMU7QLLTYahC8J0+CxycQ1
	oPv8uxTjRQuq2ka0dupxkT9y94+7jAW40aQeYVP51C+Se5MqGieRnsrYGgizohwkaudVGD8aKQ8
	jugvDEXIho9uvcYrA1lqiXD2+Og5amPRDLhzRBI/GRHL1OnpLHAdnEokpe+gFO/PSyHeRgyRyux
	ZyY2YyNb+q9actf5BVtrg47EeqzwtbC2RK3DF5PpoqFoGccYxO2Nkwaj511p3tACf1H63GHOpg+
	r6QgrsbRmU6ylCqloXbIPZ/k6ECijqoOWJgNiMS1Amn1ToXbJbk+crpQX7Eddu5c5L8qXDCQz0j
	94C3mm++a23Rcipbng48th10VbcVrTSnksUcJuQ2o7KM+n/ex2pyBBnj79RgQNdzIm0oNRwZrzo
	9pb5jQtU3K40XgydX1pKyTldZpsOKqQx80lc8=
X-Received: by 2002:a17:902:ce0c:b0:290:c516:8c53 with SMTP id d9443c01a7336-2a76b053c28mr47806965ad.40.1769009535555;
        Wed, 21 Jan 2026 07:32:15 -0800 (PST)
Received: from junjungu-PC.localdomain ([188.253.124.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dd19asm159153125ad.59.2026.01.21.07.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:32:15 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 21 Jan 2026 23:32:06 +0800
Subject: [PATCH] cpufreq: scmi: Fix device_node reference leak in
 scmi_cpu_domain_id()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-b4-scmi-cpufreq-v1-1-b0547210feac@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHXxcGkC/x3MQQqAIBBA0avErBtQE4WuEi3SpppFZkoRhHdPW
 r7F/y9kSkwZ+uaFRDdnPkKFbBvw2xRWQp6rQQllhFQSncbsd0YfryXRiUp3kzXWkNMeahUTLfz
 8x2Es5QPsgKfkYQAAAA==
X-Change-ID: 20260121-b4-scmi-cpufreq-243a7676eb4c
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769009530; l=941;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=m5l9glzlQdkTaKfNaDnN8sFdatZLvmq6941LcITDeuc=;
 b=cfXD1Y1geysfvUU65r8/VTNhJv8/QJBeT0RrlIICW84nj+GcFWUl8FvfztZPFGogJbIRG+qKI
 umusYR73874BWDNCOBLN0hBKLb15zKgVsa0K/kK8Qc8b5s84NGUZ2RF
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-41238-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ustcgu@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D91E659B3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When calling of_parse_phandle_with_args(), the caller is responsible
to call of_node_put() to release the reference of device node.
In scmi_cpu_domain_id(), it does not release the reference.

Fixes: e336baa4193e ("cpufreq: scmi: Prepare to move OF parsing of domain-id to cpufreq")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index e0e1756180b0..c7a3b038385b 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -101,6 +101,7 @@ static int scmi_cpu_domain_id(struct device *cpu_dev)
 			return -EINVAL;
 	}
 
+	of_node_put(domain_id.np);
 	return domain_id.args[0];
 }
 

---
base-commit: 053966c344dbd346e71305f530e91ea77916189f
change-id: 20260121-b4-scmi-cpufreq-243a7676eb4c

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>


