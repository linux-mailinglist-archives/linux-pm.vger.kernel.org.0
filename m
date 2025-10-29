Return-Path: <linux-pm+bounces-37034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 044EDC1B07C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 14:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D10CC5A8C1B
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399CB2BD5A8;
	Wed, 29 Oct 2025 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkV/Gxeo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF526B761
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744821; cv=none; b=aV64ZKKgFHRAUgJXlYjXii3lthzR0+uq52oJNPxuLI1PuEhwWo9odAq1cN4wSpcK0UEaSnMVnHWCkpVB10szz3rwEhfE5SL1yURXFVJoNT2mtMoIH6IPlt7p9Iyg2hUUaBDQycs5+aNtYmdCQZ4NQdEpdT79kRinFnYUyYQWkCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744821; c=relaxed/simple;
	bh=vXi16BNEwPDhB+DYxWaToOjAjArYvikCAmJrEk3ZCNE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beFGWxrtcQPma9E0dLK7nfCc+46AQ59C6zvidtmvD+74Xv913CXUozX+BX7sT1jtBOkp2f8yw3VFyKAxiwog8WITVWdLimaNza2/EZqELeV6+D8ucha7xgi7VyQTqObO91SHE0gstCxyMxVIC/7p3Mcmle/8S1DkanySYGw9JHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkV/Gxeo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4711810948aso54740725e9.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 06:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761744817; x=1762349617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejAKzCqfZfWu/e72WP9qMaUTCxYS6k1xLG7nI61sF1s=;
        b=AkV/Gxeox+PNQ+JrbWpNL7ok6ANGb1fsF+xD7qaGrFHYs2gIgLrmkDga57eEIZ5ey0
         MidumrXVyX1zsH4fd6ws40S5VZsE/tO/5+Pogfn6jioGpudAiW/33WnZYEZlILLGZisA
         PAtPkrXR9+MbP8Pv0jk4qWkE76h8QhZZ1fecm7mhHwPSGI+Z6qddAYjaE2hKbad/OeXO
         /yLeNx0pNoT6r+12tbUtYmoUPEvZXrY5ZIlLm1Snh8D/AO4N7fFlAQ734T9pbwfaHGnk
         NmGl8dQ9vKp0xOck6WNfv1D7BYHbI87eEwoB/TDil4MwX+IvuO7DgLWQAj/nWPMvXdMV
         pe3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761744817; x=1762349617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejAKzCqfZfWu/e72WP9qMaUTCxYS6k1xLG7nI61sF1s=;
        b=h8Hz4fXADC2VU7bJBcMSQvJbc3yoGfVKgeFBVDNOeKd6GJobxegH2tRmxjKUO20pkV
         i6YmIP1SYWasvdgViMHbTDyip6AwyuLf554Uh/oaGZGk2nc42jstTbwtLKek+YKVYYFi
         Qpq7LhjW7xfS4qper9nee1GvCWA53urr9BxNFO99Qf6E6eD5P4et7k7UJeeG236K4m7M
         mida2Xs24ynkcpxKvrPqcabPmaZpkRgHf87nZ3IkGdOHHnchwmn+tHxNMn+cjQI9eSwb
         ic53iodK55XK5sbU7fNAAIV0G/HBAOyabp25oLNaRLGCq3YIjSGspcIX4VDC76Zo61DJ
         VAWA==
X-Forwarded-Encrypted: i=1; AJvYcCWEbvGwXlyE/jtv+eMaExcZiQSkcTbz4kdpTE5nIuL7JdsLjjXs/MOjCbm4Hzc4O/Msaifju7djbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YypCMO+1/q7CJM9huGw4h31Qi+JuAa55PWNO8cR6VJUobHlLWox
	uI/cN8IZl7GfDfGQV2U3w9EE590dMWKs4b5Nl3ytmiPDMCgBFiWRV6gg
X-Gm-Gg: ASbGncsLaa8sv+MEHeHzNPmzDdqWnfQLt7Zht44nArGAhOiZdVPrvO/ltgkZGRpJMSi
	tD5ZT1PpP/9QrY1K/0V9IULU2Skqd7rTD1Qv9Br6/lzfnl7GKdHovYtewgHRMETt30MhrF1Rz1U
	m6+5v0JMbr/Gh0HQiW8c1cB/L497iyInfJsUeW5Qae9fV2Y7MZuC0j9oIloM54JOYk8Q9uNDUXB
	nJ3BuSCORzvl6I8Y0SWVYAq1sbWVuwS3Sz5JdAe8jqJsLPwvQXBuwm5H84pPIgvwvTq2xzI3n4A
	TX7Eh+G7Nl13S5jPBBr7TrGK9zJ7hfQ8+6JmDHctH20XXABbIHDogRNg7kRK0NKXPlzV7cxQwWL
	0L6w5PNK7flC3KrWCuENkGVHEIE2YrwkKf7mqJv0J90sogIlSODS0bZQwMvdHMp2JKWttc/87wn
	mrMtFguSr9XNzB0Y3JDNy6RL70d0ffJJRiwW3T3ygS
X-Google-Smtp-Source: AGHT+IG5nprewpaK7QE0B0Udbvr55RWv4aB/ijDliukEsohwdJEsjj4f9YaWPAudLvQV2KfTtvDreQ==
X-Received: by 2002:a05:600c:4e8e:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-4771e333a2amr25410075e9.15.1761744817126;
        Wed, 29 Oct 2025 06:33:37 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4771e387a14sm47955195e9.3.2025.10.29.06.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:33:35 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM
Date: Wed, 29 Oct 2025 14:33:21 +0100
Message-ID: <20251029133323.24565-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029133323.24565-1-ansuelsmth@gmail.com>
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
case for some Google devices (the OnHub family) that can't make use of
SMEM to detect the SoC ID.

To handle these specific case, check if the SMEM is not initialized (by
checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
OF machine compatible checking to identify the SoC variant.

Notice that the checking order is important as the machine compatible
are normally defined with the specific one following the generic SoC.
(for example compatible = "qcom,ipq8065", "qcom,ipq8064")

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3a8ed723a23e..c88a79a177b1 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -257,8 +257,8 @@ static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
 					     char **pvs_name,
 					     struct qcom_cpufreq_drv *drv)
 {
+	int msm_id = -1, ret = 0;
 	int speed = 0, pvs = 0;
-	int msm_id, ret = 0;
 	u8 *speedbin;
 	size_t len;
 
@@ -275,8 +275,21 @@ static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
 	get_krait_bin_format_a(cpu_dev, &speed, &pvs, speedbin);
 
 	ret = qcom_smem_get_soc_id(&msm_id);
-	if (ret)
-		goto exit;
+	if (ret) {
+		if (ret != -ENODEV)
+			goto exit;
+
+		/* Fallback to compatible match with no SMEM initialized */
+		if (of_machine_is_compatible("qcom,ipq8062"))
+			msm_id = QCOM_ID_IPQ8062;
+		else if (of_machine_is_compatible("qcom,ipq8065") ||
+			 of_machine_is_compatible("qcom,ipq8069"))
+			msm_id = QCOM_ID_IPQ8065;
+		else if (of_machine_is_compatible("qcom,ipq8064") ||
+			 of_machine_is_compatible("qcom,ipq8066") ||
+			 of_machine_is_compatible("qcom,ipq8068"))
+			msm_id = QCOM_ID_IPQ8064;
+	}
 
 	switch (msm_id) {
 	case QCOM_ID_IPQ8062:
-- 
2.51.0


