Return-Path: <linux-pm+bounces-3889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01392853EE8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 23:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B851C26D68
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 22:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F53C6216F;
	Tue, 13 Feb 2024 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yq/gZYhp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F0627E6
	for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2024 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863995; cv=none; b=LAsa83WhG7F2gtqcEgABarea26PKtw15c9k/VrWCa2BElMulDZvuJDYYuQin4xa8/U114bSJJcgaMCZ+/ZRam6KBH7prL6N59vcTXC+abCmYjiimCQ/qX02PmawVzAgMIJ/rL2l2cHMWF01xBQEx2bp91kGiVU6LdJtZ9Ul1oyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863995; c=relaxed/simple;
	bh=d08dvCKpJiUuiTN0yYybtSwR0TELwLw/HbrdWXQYfhg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yym96OFy09e9TE8Ac8lcxbizbalcwCqKfPj12IpJFbASp5bwtm+txDnBJkEQhCS9ywqSqm3VVvZBODPDlehvIqM/B5PcZ7p9VhOiG0HowNi2FdlgClIfk1d03BxPEAnDvsYBb8PcRzc7ESZZLA50YzdDjieAMaHz+eeLdTAN4po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yq/gZYhp; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33cd57b7eabso704466f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2024 14:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707863992; x=1708468792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WuynJYD3Xp/+mml/cq1YcpkhYxewgGFG3LGCjX78mXU=;
        b=Yq/gZYhpMb2vdIqWmZxKODdI43aGZG0fFHvPBLOTx2gPC0lDg5pgK+LqgfUI/ejTBg
         LyVI687rHmKM9ed4OTFqnNyp1CdBHzfYp6gh/lZRETHYDdjcuDYJ+bQzCzMJ+/qxDqgn
         Mf+psQ4cEJzSQW6YirXo2BmyhmMzJELjYFaS56kotj4eZuRAFPAi7WhB8lg6LPBwUNPN
         nwyHG5tW6eJQB99UZPBWMoNmROOMKlZCjqXTAb97r0fWHBkqymc/dDfB/51VzbylbHY6
         YIhyGz4ltObq0duLenypzqCHsYnRnEq2LvfBEfS7bwijVjyjY5mWr1E1liOF+TxCHbGq
         nP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707863992; x=1708468792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuynJYD3Xp/+mml/cq1YcpkhYxewgGFG3LGCjX78mXU=;
        b=COVtQSFhCOe4GyuKkQdy+grfc33EVX7Gn5WwpSOtxRT4eMi4eDqNTDevRO3xmHmVjn
         7BYu2wMNekr4cvgxjblCqxfzxfMRBp1XIBiSq1ncWWlgh6CWuQlhYjoBl+MxIp72zxYk
         UQ+UwNN0dptZJI3nC88LbDKcx2C4CApZE/qZ9hPCs+A+mxPtLM2zMHRqyUzWN5tQgG3v
         wscZ1lauuANgHOuC2JXZNCe67QQduTOTH6Zf91bkefbftN8r7R/6ILAfx6WVLoIJjipq
         AQ1z5g7YgCtvBizmzIatpUY3iOJzud1UU7J7tR31ear3jRNyc204jMVrcKF89TL2aC4U
         e3nA==
X-Gm-Message-State: AOJu0YwrkBJPFJqlw+xhKOtUw6aqy56lbSFbA4n6n/0yOk02LY/MjaZI
	1XdxjID8Z7eBMWnKw0/UzNXngGTqUPIpiY/IqADX4737e0Af+hcXexSWqOJFATR4EVnYjuLOKT+
	N
X-Google-Smtp-Source: AGHT+IEquYAlTbz4tEeO3qGgDFZtdhh1eHK8IH7BWWYx0J2UOrXAUkuzWH539LA7Fh3CMP1/Wz3VZw==
X-Received: by 2002:a05:6000:152:b0:33b:1562:cf4c with SMTP id r18-20020a056000015200b0033b1562cf4cmr444177wrx.14.1707863991725;
        Tue, 13 Feb 2024 14:39:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXr+hBO00mzvvfxEO9hjMx9Smls2h+bP1VjNTj2DM23IxtVMKIaxxeO3ICJX4r/y3qBkudHjThNp8OLLr/Dh3LIGhrAZOb6G6gJRfyquvp+kIfRN+GcYaJs2Ikz0/bzaCtknumC90BP
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id cc5-20020a5d5c05000000b0033b75a1e8cfsm9262191wrb.24.2024.02.13.14.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:39:51 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH] powercap: dtpm_cpu: Fix error check against freq_qos_add_request()
Date: Tue, 13 Feb 2024 23:39:47 +0100
Message-Id: <20240213223948.1865489-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The caller of the function freq_qos_add_request() checks again a non
zero value but freq_qos_add_request() can return '1' if the request
already exists. Therefore, the setup function fails while the QoS
request actually did not failed.

Fix that by changing the check against a negative value like all the
other callers of the function.

Fixes: 0e8f68d7f0485 ("Add CPU energy model based support")
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 9193c3b8edeb..ae7ee611978b 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -219,7 +219,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 	ret = freq_qos_add_request(&policy->constraints,
 				   &dtpm_cpu->qos_req, FREQ_QOS_MAX,
 				   pd->table[pd->nr_perf_states - 1].frequency);
-	if (ret)
+	if (ret < 0)
 		goto out_dtpm_unregister;
 
 	cpufreq_cpu_put(policy);
-- 
2.34.1


