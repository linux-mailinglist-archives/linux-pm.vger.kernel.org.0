Return-Path: <linux-pm+bounces-29020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63C7ADF9B1
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 01:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645953A104F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 23:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A70927F015;
	Wed, 18 Jun 2025 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/Pd2+fM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C217D2;
	Wed, 18 Jun 2025 23:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750288610; cv=none; b=Iw5c9Rr8FxJ5twIxnTQ9iNAyAIP8696HMuNTPNOZhwlnuBNr0c/fK5oc1z+A62vIXpSnAiXVJwoul5ZmJFa7igfGowjd9coPBXT7MbtpQClTz7m70WYzWxxzXZBJk2ldmQRd7UkXPSc7nhiRUtUxt0Gx+0b8mVxZt4w/Dpgc99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750288610; c=relaxed/simple;
	bh=rE6nQ0F+Or3+w2JIj+5hIiupJczuu7cktpOgR3NEmdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDPAkkpvo/v+9eOCrc9IFL1oMDP/uUDSS178RbJZ4ysnxp12n3eY3Qp8pYxdQn0ZfDlX2uOFTnCx6xDNwuGNH/TMDGazZWlfcVUNEv2JCheUMWbQDsZCkwLjaksQA4cFk2+aTom/gvNwGo8TytHAw1djSEtDCbmidkIe2CRczDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/Pd2+fM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a588da60dfso128364f8f.1;
        Wed, 18 Jun 2025 16:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750288607; x=1750893407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbzqISCl8kUsmp2ZcDZ1M3Jhh34QDTYAjr+w6VVWlCw=;
        b=P/Pd2+fMEgiZSRe0K7vVi3GqCSe2hQvWk0S8nPbp4mN7lMvejPmqkrnXu/DsziHuD3
         RArRhkuDx7NsMgHTG581QaYIpRxQ+RkSHsuE7isRAjDsvkOH/S/xqR+EtivzYKhNqD1S
         HaCYKLNTZVX28HEgmoTMfF0YQe5CrpQd6+kAHr6zBUxp8tMhriPiYRnLqyUIKQR4yBHY
         +F9wAFc5xeZ3vp2yae/FMoJ3NpL/mRndMm2UvGlpK0iXPxbzNUxh4346aE0RQaYhKNcS
         caMOzbu8MbPP2M5GDZJZFCSOs1yww7x+ojriWKBJrnksNbssuplDbWRWxaeb9k0XOq8i
         34yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750288607; x=1750893407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbzqISCl8kUsmp2ZcDZ1M3Jhh34QDTYAjr+w6VVWlCw=;
        b=famtprIZwjrSVRxr+Nk7YHp6Kpvgz9wO4E+OuQPgs9FmRY+9dkS6YNj3aO+9aV7NPa
         F/z9iZI9Wrkq2s+Jae9LelO3hgi1Ft4XMNalxVTrpapBMTxERIHttdnBtZwj2Sma1wG5
         M6CDH/4VTWDPUp/RSXLzzx6Yqu88IAMu/WpNmkpfA5Tm5rg13L0cQPrES3gnw13iykJH
         4pfe/VoksBmZAJrA/srOTUi2LvRXfT0N7lC0HfvbdD3/EkZ/pLGRU6E9Q4ffaFY9eMhC
         knDIilIavpnfD3c1JRGcAQtqiAAJh9F/+u9GC8AL1eghFwiLvphQ/NluuQeX/LS18rLe
         6lTw==
X-Forwarded-Encrypted: i=1; AJvYcCVz08/vqGFqXsFxctseToIsg5msUz8JHyvHyEAcmL5mARG6ccQvRXbA958CJXfXVibMgpbeFLNvsOqWTyU=@vger.kernel.org, AJvYcCXy82AuON06y3e8pSZnVNVNOEfzokF2VYEWrkzfes3+J7cS9eF/8jzpNY4R4vMtP7msX5MQAWK+lDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOoxosA6FoO1Ugn3Kc0tK++jXXMiv1Wz0erhivmm7yEszkSvwB
	4b1BcIBssE4PLCatY7gRZsf4Bp184LMhHYgyrtGCXBza2rwTiDKgsdLt
X-Gm-Gg: ASbGncsS0g5+yXAu4ImP84OBEIKQk1954tBAldnm6cGutXOAL4y3tbvDhfoKMDq37ca
	0UdLePZhOeHn5BzFuob3WKY5ltVnZtcU8w1cNP8uyXIqmwU4x9XGpUBIMRS+OToE3f+8PMvZCsc
	vKt24uVTUjtzxCm/0DzgQJfKcymHeoUk1AKVovbyosUWxr+zYKjaMJ6tv8R1eodp3AtJL/nxKPE
	pbZxnl8Qrqi+hcaQHDcO3moY4+VT9OMrYp6vSBxxMbWs5/7q31pWp7jpm8bYwLKBvWIUUuS6F79
	ndJfGNv7UzrEQDopGCIKNwoHAnMDDFbUhMQVDZlGNL+OlNcBWWXKg7Wh9rJmFHt62CY2IGBpaRz
	TsHCpaBbk/fzxebp1XL7y3hczEptamEQ36sGZrgqMVoK6nXSg85CK
X-Google-Smtp-Source: AGHT+IGQqDiCljMIpFbKFKF+ETvJscVwqFptWFt2xTuBVJBu2n7XwcnHLG6lWV9ml+SED/gxWYJwIg==
X-Received: by 2002:a5d:5f4e:0:b0:3a4:f52d:8b05 with SMTP id ffacd0b85a97d-3a572e79d6amr16801398f8f.35.1750288606836;
        Wed, 18 Jun 2025 16:16:46 -0700 (PDT)
Received: from sivan-ThinkPad-X1-Carbon-Gen-9.. (109-186-135-251.bb.netvision.net.il. [109.186.135.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e9a7ee3sm9987035e9.39.2025.06.18.16.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 16:16:46 -0700 (PDT)
From: Sivan Zohar-Kotzer <sivany32@gmail.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: elazarl@gmail.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sivan Zohar-Kotzer <sivany32@gmail.com>
Subject: [PATCH] powercap: dtpm_cpu: Fix NULL pointer dereference race during CPU offlining
Date: Thu, 19 Jun 2025 02:16:31 +0300
Message-ID: <20250618231632.113471-1-sivany32@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_pd_power_uw() function contains a race condition during CPU
offlining:

* DTPM power calculations are triggered (e.g., via sysfs reads) while CPU is online
* The CPU goes offline during the calculation, before em_cpu_get() is called
* em_cpu_get() now returns NULL since the energy model was unregistered
* em_span_cpus() dereferences the NULL pointer, causing a crash

Commit eb82bace8931 introduced the call to em_span_cpus(pd) without
checking if pd is NULL.

Add a NULL check after em_cpu_get() and return 0 power if no energy model
is available, matching the existing fallback behavior.

Fixes: eb82bace8931 ("powercap/drivers/dtpm: Scale the power with the load")
Signed-off-by: Sivan Zohar-Kotzer <sivany32@gmail.com>
---
 drivers/powercap/dtpm_cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 6b6f51b21550..80d93ab4dc54 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -97,6 +97,11 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 
 	pd = em_cpu_get(dtpm_cpu->cpu);
 
+	if (!pd) {
+		pr_warn("DTPM: No energy model available for CPU%d\n", dtpm_cpu->cpu);
+		return 0;
+	}
+
 	pd_mask = em_span_cpus(pd);
 
 	freq = cpufreq_quick_get(dtpm_cpu->cpu);
@@ -207,6 +212,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 	pd = em_cpu_get(cpu);
 	if (!pd || em_is_artificial(pd)) {
 		ret = -EINVAL;
+
 		goto release_policy;
 	}
 
-- 
2.45.2


