Return-Path: <linux-pm+bounces-24944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E229A80F52
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 17:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE27D8A15CB
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACBE22A81A;
	Tue,  8 Apr 2025 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbG1so7M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA7822A4DA;
	Tue,  8 Apr 2025 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124658; cv=none; b=DCkUPUJuT/VO1sXFPP4DCH+Sog8UtaD/Fa0BQpgcVPt4uLSw+w5Duz25TDc/hjPJkDXC6Zhqj3+0tsKR7+fDL1BtFTlwLFNLMlsfd+LnPeLDU0CJjoQkkMcvjkLo5L++Fw/XldP0YDLUpHySccJjggRvkep/0SF3UN77fJDJnAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124658; c=relaxed/simple;
	bh=ZzIgV5IKaibdPCxd8eKQeMZsCih99PjQUMQDgFfG5dU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HeT+XCJYL4CwJ7wTxIzHILEt9/tmzY6mEhEsXtVwLHoSx96GlI01eyJ1S1VpPSYgFnK2oymYIZlfaLdyVYbum+2eOIvJZHmJ+KY3j8BG4MTnC4H32fU7AmbZc3NXf7PcSHL+xPplG0qTadTLONuhmezgzhIkcL9Qaq6uPuAeLSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbG1so7M; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7399838db7fso5134748b3a.0;
        Tue, 08 Apr 2025 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744124655; x=1744729455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nojCoF+V4HIbKW8c++yPFqWUGF41mxnhAevsaFUXc3o=;
        b=YbG1so7MIAVDOYE+OGi+8IWggPhWeN8ZG+/GMbl3fhtxyfr5o6asdQ+rqY0oQJ6JFC
         cNe5nX4RN7oqgSzzFP0AZtgmZLuEj8Poy+KZenakMiR9m5cvYGDMq0zBtX17ZFAwT9dn
         5Nxq280I5ztzbzEx3VRdsillCUiLdNWUQpJ9j9KEHEjqzpxOSibbJ4U6AsVPFyaTuxK+
         UAilauowSq6sGLvpOnMx0/pLxKpV9omYk04JkPqXHuRpKuWCvcs+i2skrEs4a0G/7wFa
         uDn+qUaEBrzouMWjeZ6zaMhlzl30lsUMT/bWd8ZAfI0at6LlX4yfiv2oPAHePMnw9g/m
         FEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744124655; x=1744729455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nojCoF+V4HIbKW8c++yPFqWUGF41mxnhAevsaFUXc3o=;
        b=sxpWcH8GLdO800sx4H7uNP0H2k//dHl608CvY2kirL0wsSZb4Xjwujjz5r6dX11T6L
         d2vfl6yetD1DgRCNR6Rtyg9HCpLyfdtr+LcpE8yqySEv7DUmh16ND41mMHiTIwUwU/84
         rwtwtzC8NdwJE47KUa+WwLXY3TlhjsY3hF5IyUX4I6t2EjwAaltU03saYMQrkBDkCNkX
         SXJhCwS1dvkmZKCMEGy82fwqzrdiQl4Gz0OPU6uV6a/LF9GsEPLE60mH00/Nvo14zh9q
         kKEJIKpdix9D3dS9Psq98XxSeKAUMAn92d2rJS/tJRTpScV8Fv6jPyrl99+kYSMIO7XK
         tsTA==
X-Forwarded-Encrypted: i=1; AJvYcCV7/WOH9u559JKzKrnbVUTsiWzCLg9YQgOiGvgfZ5WkyYSWvZIIsxPBPtI9M/AnxWP/TxrMKJKNRfc=@vger.kernel.org, AJvYcCVW+4ppfS7Rg9ZsBPRbNCuZqcKpR/vIINGEpNxmvCn/+Y7aIB0ab3SH9PGVpx/1X1+v/o1rZCJOCc4hIjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfiOS762pyygVK3f+K4zkQ6xvXzyIUf57P7PGbS1yj5A6zDlB4
	QVKVTbPA+9leJnbR0LIG3qOwhCLNMa1CqVcCAfOQHy/G4MmOtt4p
X-Gm-Gg: ASbGncsJNLAwRQB6b1IuVBBV6FuXpdileG9hp7F76j2pOwVfuAP4oMN/ixoMJ6X5dDY
	OgjBkaE5dkkaRbG6ukVKd1ikygUr0WSXwtiGhYCv8p6kafSuPoaRMt4YQtyw9hlxdGcHB5yYT/I
	qfVsxMbc/cPXQeJJUCVvUBYHhy8DJKichk4KN+S/VHjMw2uJ0aDRXZqQG6yIM1miI+8rFQ4Ybo1
	FbA8FQ8fuIXo0JjHz1BNCBcfkgT4LWquP37wMTLDTS0RBL7zZ3S/ZAzqk09eXNdO9TOXGdXoMve
	g73WzQZ7Dxp7ytoEOfWTNvFXVqUSnHpupnZLsBRIn1wAagjDzKEpIJZ0MRri3hA++UJUSQQ=
X-Google-Smtp-Source: AGHT+IG0+bqK8uWDDwg4kvTaDay13P59qHVKN2qH7CUeZ1LSC34EsRYNlmUz3zdEqAm6DQcIz3izpA==
X-Received: by 2002:a05:6a00:3984:b0:732:56a7:a935 with SMTP id d2e1a72fcca58-73b9d40bdf1mr6760256b3a.12.1744124654437;
        Tue, 08 Apr 2025 08:04:14 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea097asm11068474b3a.90.2025.04.08.08.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:04:13 -0700 (PDT)
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
Subject: [PATCH v2 1/2] cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate()
Date: Tue,  8 Apr 2025 23:03:53 +0800
Message-Id: <20250408150354.104532-2-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408150354.104532-1-bsdhenrymartin@gmail.com>
References: <20250408150354.104532-1-bsdhenrymartin@gmail.com>
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
V1 -> V2: Use `if (unlikely(!policy))` instead of `if (!policy)`

 drivers/cpufreq/scmi-cpufreq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index c310aeebc8f3..944e899eb1be 100644
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
+	if (unlikely(!policy))
+		return 0;
+
+	priv = policy->driver_data;
+
 	ret = perf_ops->freq_get(ph, priv->domain_id, &rate, false);
 	if (ret)
 		return 0;
-- 
2.34.1


