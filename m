Return-Path: <linux-pm+bounces-31218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FAAB0C7C3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 17:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D461AA5DC7
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 15:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BAE2D6639;
	Mon, 21 Jul 2025 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQpMcXXF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243C82989AD;
	Mon, 21 Jul 2025 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112228; cv=none; b=iOT2EeCHJnABZOLuopoYls/aMSMLPsFCs2XinYdaxPqo49B4rFbAdsPcthTkxFiAjaCc1Ute05WS/1pHoYIrVL7h0k2XP/ala5zMY2mPqq5YyLxE8iDR/IZk/q6sVlyed+twLkJT2g4ILrdEgZDYVjacDuE5tbzIhzjKMX3JgI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112228; c=relaxed/simple;
	bh=vPbKId0oexCnk3rHxjJx/4Vv2g1W+vbieRquTrehV2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ud/xyfYAYETuR472NC/58qZLJRDRt+8IvRFr59eutJCj9g6sa2fcu7HLSA9tgsSoNaMXNmJ8sXNy5oc1VsohaKoEUblrFyj8gANYUaipOYy/JGC0D8c5X89K8lkc21J3svQ2/SvaghRFI5+CU+wBruN72qpvZSb/jGk1QuhGsjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQpMcXXF; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-74264d1832eso5753702b3a.0;
        Mon, 21 Jul 2025 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753112226; x=1753717026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wcari+pfAQyvOfkfes+Ld6UurqwzVSHlw11zA1GTL/s=;
        b=CQpMcXXFHNeVxcSjyNWZ8bfvh40y73HDUoVt4L2MDLrSexjfc506EEXZxRTl7zRvZ1
         x4AmMTpR51RlvMg5/rkbZ9pBJQgB76yQyV3eC4mBVxckx86R9Jklwg2phtmGb5UsIdou
         nvlkPdMZk0+xjWiDbJEgi/yF0UBz1CTgKT+0P3ScFOn9pFnBcyMNcnkeCnm+ELLjQp3F
         XNwNpp/VBCaO51WuQkWOwTYmwSoXWaPuC/KCj1CD/qe452YHXjn5wS1KkIhzoRTGiaI4
         SGJR6yPA5Rujy4xccEsX8nJfIRhoITe+ifHqcDk/ejXbA2Mgb5gDfBsslM/+jfH+k2Gn
         A45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753112226; x=1753717026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wcari+pfAQyvOfkfes+Ld6UurqwzVSHlw11zA1GTL/s=;
        b=IofkWABz3mCuQicETNqpTmUCeFV8JHJK2v2ftgAtEVwpTYJCXVF5/YVmluCYGsz3uE
         7V2TKUffTWvZlEevDOoSyAr65mDoXBCWWu9csTj2xC9RPNvUTN8K2JZgDCixtFG7K/+5
         9PUSRnUJlTKcRq2bb+9xV8jvyuWpxmVBJHbxYrOZ0h/48SmZ7vjmr0q71hhjSiul1L/q
         7ltAG456+Dx0aHhpGWlU7i6dEx2S/xRRryXaR5YF/IKDfXXipDtV69ajEvO1lf7RuRCU
         bve2SGYHE8bAU2M0b0djZUyaxpSKzaJV8kbf6ZJvAMz4CCpOqpHmm6OzQK7vz8RYJufo
         5AQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaKHUspdYzWOjc8J2oXYSwcuxZL13irxi7r2R61hLamlWYcg4zuNladyMKDDM0ZrzWYCRWebLi7jmsd0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KhbFL3Gobsh4JI3ftW0ASlYDfEh7Ucep7IrGg4iOw/IMnNKO
	/vPlOySGGYNrqs1nJX3xXaj0nCTGsumWiqnM5X/39Z+u5u7XwC9+M7rP
X-Gm-Gg: ASbGnctgdeTPJQjCWv5X1vgTqMUWEHTnaRHddo/O18kHfd+diA22/K9u679m3XI2+nT
	7fSEUHX9poHvBwV0tu1w433QYzO3cgFvGztrxTQ3ab2SVZanznSC1sdxY9rC/Wsm8ocu83ktfBr
	bIbBN/JzP0Tcq+hSNYEf9qspQ4HdFkpXuZvaJZfBFK6KXw+ygmFC5MFy/vZe7ZZpLUS8aP3WIsu
	7pPZRW8ldFWhTosA7j3mYnakKkwelga+Ww66gpmcAOX27wQd/TGSMEfJNqY/0nVFKqob74CV7RA
	Nw9tEwsGiaI7ZTwsukW0pF+w3AbGx7nxlAhMswhNDEYtFYInu0QomaMRopTvKD7Td0FMNldWo2y
	ENUbCm6vd7u1KRqq3LQuvvqDOoq+uVNqrIWp1Qe2cYqys+mRX99TNc/dS7hgeIGVi/gclWPTfIl
	XdCGdehzacTg==
X-Google-Smtp-Source: AGHT+IG3AhBxGUgQrWz76VnBmLK/tDhyYtOOhCNOqFmeDwg8FrXTay+mxeCWGFs66OtMhVz+EEv2JQ==
X-Received: by 2002:a05:6a00:188f:b0:740:9d7c:8f5c with SMTP id d2e1a72fcca58-75725589c70mr28755994b3a.18.1753112226285;
        Mon, 21 Jul 2025 08:37:06 -0700 (PDT)
Received: from zzhwaxy-virtual-machine.localdomain ([223.166.23.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2a6esm5679090b3a.11.2025.07.21.08.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:37:06 -0700 (PDT)
From: Zihuan Zhang <zzhwaxy.kernel@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zzhwaxy.kernel@gmail.com>
Subject: [PATCH v1] cpufreq: Avoid creating sysfs link for offline CPUs
Date: Mon, 21 Jul 2025 23:36:56 +0800
Message-Id: <20250721153656.5103-1-zzhwaxy.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, cpufreq_add_dev() attempts to create a sysfs link
even when the target CPU is offline. Although guarded by a NULL
check on cpufreq_policy, this behavior is not strictly correct,
since offline CPUs shouldn't have their sysfs interface created.

This patch cleans up the logic to only add the sysfs link
when the CPU is online and cpufreq policy is properly initialized.

Signed-off-by: Zihuan Zhang <zzhwaxy.kernel@gmail.com>
---
 drivers/cpufreq/cpufreq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d7426e1d8bdd..0a77892d366c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1660,12 +1660,12 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 		ret = cpufreq_online(cpu);
 		if (ret)
 			return ret;
-	}
 
-	/* Create sysfs link on CPU registration */
-	policy = per_cpu(cpufreq_cpu_data, cpu);
-	if (policy)
-		add_cpu_dev_symlink(policy, cpu, dev);
+		/* Create sysfs link on CPU registration */
+		policy = per_cpu(cpufreq_cpu_data, cpu);
+		if (policy)
+			add_cpu_dev_symlink(policy, cpu, dev);
+	}
 
 	return 0;
 }
-- 
2.34.1


