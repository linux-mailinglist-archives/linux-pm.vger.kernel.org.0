Return-Path: <linux-pm+bounces-24838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0F8A7C7C0
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 07:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7539F3B12BA
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 05:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6091B3940;
	Sat,  5 Apr 2025 05:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGNMAs6v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C391C5D55;
	Sat,  5 Apr 2025 05:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743832499; cv=none; b=cVcCI4dOnjQGAzUIv8s26h26rkk2+Wp6yK0JdNRfTY/CmhmpcIPU7XXNM8AKNNdmlLmE6+YjJNVPgB87knD6DLCkLAHjf8y6d5T2xEYriJBZeDfMBaQepL8Bsa7wW1jeDEZCbY3+/3UQinAvm3Y0WSRTpYVL4HQcL6MgUnXpD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743832499; c=relaxed/simple;
	bh=We9oXwORVimFqBPPGA/hvHaf6inkTosUkB3Mur4TS9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lOoJgxy3H6t9K85dK8MDxx3wkObQDP43hEbZIuavisvTbEZu9llx6igHcx7e3BVngdNFgBIuiABzFHZcP7sVaYTxlNrRrgW5Ja6TA4ymd3NmMfb7aG509UzoogE9g+oJaOggZZo8BduyIqzxEXPyCrHoo4DR4ezAg2G+nx0LqJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGNMAs6v; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-303a66af07eso2086951a91.2;
        Fri, 04 Apr 2025 22:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743832498; x=1744437298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ELXP8BnMg0kJvaDE3S2jRkd/Etcxd1UmTQ1mFWYQwxU=;
        b=BGNMAs6v7cK+gb9Vb9D7wPhsHbOZXHQDdAOVAiIJHJkegacNVmY/Mrz8RCQk4Ie06y
         uh9s37mw2M9TWkfPXPoof8WMxEVdwuqBAkhEEHjLnvWb7TDwaeYnP7FkJVUv/svZJzYd
         QaCGYhXRilqK4IrBND0dkLfBaGj3rWyOlrC3auLBzfoL2TA8rk39+eVs3VnvgnEA6Mng
         tUDOBgP8hw8T7x+BL8U2/zWu1E2PiGOrGPLryNrF6f67ZoOJuv7FC9B9xuodod89qcdj
         +kJTf11Ea5ESAQtkaMoJQfgDNc8J/0QqYfnefHyMDyI0VBjJuasFudiLpJqQPuZ6kPkC
         hDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743832498; x=1744437298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELXP8BnMg0kJvaDE3S2jRkd/Etcxd1UmTQ1mFWYQwxU=;
        b=PDSgIXPDs+BaEfygWJj6lxKJELMEyv6j3Ojk9zTQBHtqe6qq4VW7ZM+2vW1pSlqWWD
         lRlecJfz2QIKN9sZ/gs0b0G32MJtqkDhnPX7C7hAzCkQ4rc3FLiTY5RGctsJXpbRIXR+
         a3TlgtzkrjaNKr3XG6A53dl5IlYVxo5LfLkGVzByE+5M2rjvMkqSde+hsoRzFn+brfzj
         sWVgScFyeFSNiI0F+b/zKO2BST9r01q02f4F4EuGCtd3vFzcYHJ0pxz+mJGpabTDMyK9
         q6U1QY/IRPjypCX8FwIUaXuxFz8OV/GoXIWiw9Z7gIhiu+q6bPA6sREX6FEQHlOVb2uF
         979g==
X-Forwarded-Encrypted: i=1; AJvYcCWZuIZdaM2R7+4jwXOPbGSpqyEGZqyxBpRksRLPkZDAsOrKLbWeMs+YSwc2enzR+3QbZNsmGhBEyUA=@vger.kernel.org, AJvYcCXoOU7SWaGKabrQTah69buwl/H7za/M6ipYgKitaJCS+p6wpQ2gkn4/dGxyvjefAJgRhtJXds5zQI/zd/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzlELDJyB+BPatlFCeYUuJNfHZAGnih1qsttM9lgDnoMdKdL7i
	1PwYVy4SVQ4+wVFMcl/g/MnRb0Rsx7SmqOUMIEiGQvqDVOhL+/k9
X-Gm-Gg: ASbGncsWSyVWKl0r2dddxpLcr5hep90Oyv9leggti5lAdWMR07HRiHQy3zjOI09T7A+
	v5DgvQIcAO3EYuY1+YVYO44HHnou3uuY1SVGzBuNwB2jBNlTFUOkiki0j0gBWLMT/7agG7I4Bff
	cZgqHw4yoDIGPiLb0a9sHRzSDVxeN7HSQFlkosCPa6BdVPFYl5/6SgIKzcbf3yPhlhFQv05r/rm
	L+R3oMbZASd0DpkRhTzQkEczI8NTikaAc6glZ37GrUzcGj39orXB1rQcin6j9NzeZaL7JLLRnmK
	RbrzefBsXO+3y9r9oZIteiiBFyztPK9Js+sxh+XhbXzrak3UvGOr571f3Nifhju1pjUJfw==
X-Google-Smtp-Source: AGHT+IFYqOzn0CbqAzO6U16/vv3yxNPBs7vBAGPe7v1D1GRNSbbegU+qDr2xpouLjVmiFE9cnTiGcg==
X-Received: by 2002:a17:90a:fc44:b0:2ee:aed2:c15c with SMTP id 98e67ed59e1d1-306af788c23mr2724148a91.28.1743832497475;
        Fri, 04 Apr 2025 22:54:57 -0700 (PDT)
Received: from henry.localdomain ([223.72.104.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30561ca5da3sm5555489a91.0.2025.04.04.22.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 22:54:56 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v1] cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate()
Date: Sat,  5 Apr 2025 13:54:47 +0800
Message-Id: <20250405055447.73925-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpufreq_cpu_get_raw() can return NULL when the target CPU is not present
in the policy->cpus mask. scmi_cpufreq_get_rate() does not check for
this case, which results in a NULL pointer dereference.

Add NULL check after cpufreq_cpu_get_raw() to prevent this issue.

Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI message protocol")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index c310aeebc8f3..c735f39245bf 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -37,11 +37,17 @@ static struct cpufreq_driver scmi_cpufreq_driver;
 
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct scmi_data *priv = policy->driver_data;
+	struct cpufreq_policy *policy;
+	struct scmi_data *priv;
 	unsigned long rate;
 	int ret;
 
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (!policy)
+		return 0;
+
+	priv = policy->driver_data;
+
 	ret = perf_ops->freq_get(ph, priv->domain_id, &rate, false);
 	if (ret)
 		return 0;
-- 
2.34.1


