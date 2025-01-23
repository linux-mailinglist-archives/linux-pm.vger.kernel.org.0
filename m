Return-Path: <linux-pm+bounces-20869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE8BA1A378
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A4C3AF6D1
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788582185B3;
	Thu, 23 Jan 2025 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXWcqgCo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF1218AAA
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632395; cv=none; b=ljjE7lgE9xMsBXtym2PNhMJdqhBeOtiy54IvMYDYeQ7C6xM/Ijz58VSGrwcUwb3Ho3xBwzBzZtTpVct+oVSDmDywM3dLpOuM3EL4viwCN1UPtNr3c4urysq86JNARmsHvvarfd8fy1GPrk9BICGDA5LUgiaVWcjHDVdE6kSo5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632395; c=relaxed/simple;
	bh=VN9IacOPeI5nUxWK7zWMJWorTJy+PSNeXSys/yXQA0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R6xrcnGBE10rheBO8plIg2fg+yGQLVst8GfMtf0xitnMNrhBpfK6rsPxAIxB9smRmgM9dj331jz4sKyh8jXfScceUeic6AQ0g1MuvIeL2XrK63+WiJXuIPdhoSBeYcmGM7mlNMGMaaoeT2TM2RwSML1znvT7czhqLkcC3Ma8IsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NXWcqgCo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21631789fcdso26135365ad.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632393; x=1738237193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpR6CUvCRb/ja749qvOp/VQU58xavrM06pOATjKwG2I=;
        b=NXWcqgCou+EvQapK8HIFRDQa0eZ8aNmFAhBILPHZsqT/awlQjFmwKP5256Xs8sJN/O
         g6TWhCENVKHsT9OwuMYxsfKPnnU94t5wXQBASPMA70jjmAfiXOZXhV/o+RrRLgXewft4
         7aXyh+uO8Vb2eu85NYUlcs2G1xWUSbz8z68s+4Oda6FK0YEJiurtxyNdHZWpM5ExNmxe
         PwEO7FktE6I5ZdZYQtuy7zQB3MeTMRsBn+eSIzrqngbtmI8W3/P5WHlLYDUqb2zk9DW5
         tU/hbMx1GUJkte7j3RqXBKZ5TLPoveuNwbAGBQjB6H3E5O+Amj7lbt/t7eaYcafcq5z3
         i8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632393; x=1738237193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpR6CUvCRb/ja749qvOp/VQU58xavrM06pOATjKwG2I=;
        b=dokc7cPuP0VhYjRfHrvE9y0/u5gXVOc62Bjjg2Nc6NQZ62fF7VRDxzLNI7VedU4Ar8
         IELinMXjLlnfc7agUacc6zvjStVBPHQAtMUvIN5z8Bqbaoq4gotG35MvRG2b/LnoG1Dm
         813S9JSv9htGgVXaVzKke0R8oWMw/Uifn1+ItrU2YThtUm1GHEdBsqrRzCLqvMubyAnO
         3caVzocJc4gp3CIs+8pXFHaoveOYG7+yO85NAGVRJz6nB1D9XYFm35gUdPPwIerutuGp
         ZiJj3bbBiTEo+fwiuvmB0E5UtNHCGaf60nlxAfaAffQDqz4tgxaS4QWve32BzC5jtXUV
         sa8w==
X-Gm-Message-State: AOJu0Yz8lCPVktoAcPT/4r5EMKS8ixsttwFKek1bLZ98/jDDOAHofEa3
	hfAaTzxMbVpa9VJyLOZrvTTVESiRHSAIs6pZVQdGgRUOqSiqH8qA8SrEW4/DXOw=
X-Gm-Gg: ASbGncukafznyJHYkny1SxoA4Fek6YD172NtVunD4USv1p8/ijwgXbIbjWU32Pgg/k+
	98FAvkZ0giyKVTO4E/eY7sgF9ExMX5PnD1YF9Es25triWbgdZyYFT2H2zTzMS6tnOvR+WsPCob4
	wAxHmxwjfgy9dNtvCWvf+dIH1iDnh3r3mPlIsNnKwEtZb1nR8kSKOiZFXLmBKBbwmEBTIxTwjjC
	YAEPo40+mxgpQLMn22oNjgT+Vj4kmzA/SuvXz8kSMS9MS4cKg3nVsaMaeEJDbWcr4uPk5lv53gF
	yzYOvHM=
X-Google-Smtp-Source: AGHT+IGo++1b7/8/COkEZYhpLDYX941EcGajeBPmeTjsJgAikmQ5GvL8OOkXH/im95bhumUzwE6Bwg==
X-Received: by 2002:a05:6a20:3948:b0:1ea:f941:8d8e with SMTP id adf61e73a8af0-1eb6978d3a5mr4736487637.16.1737632393186;
        Thu, 23 Jan 2025 03:39:53 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdd30cdecsm12394311a12.57.2025.01.23.03.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:39:52 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 33/33] cpufreq: Stop checking for duplicate available/boost freq attributes
Date: Thu, 23 Jan 2025 17:06:09 +0530
Message-Id: <320e85838d2f19f6cbd5a66aee934cbaf4f60016.1737631669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737631669.git.viresh.kumar@linaro.org>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

None of the drivers set these attributes directly now, remove the
unnecessary check.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 973bd6e4bdd4..2569f9980d2c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1076,13 +1076,6 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
 	/* set up files for this cpu device */
 	drv_attr = cpufreq_driver->attr;
 	while (drv_attr && *drv_attr) {
-		/* These are already added, skip them */
-		if (*drv_attr == &cpufreq_freq_attr_scaling_available_freqs ||
-		    *drv_attr == &cpufreq_freq_attr_scaling_boost_freqs) {
-			drv_attr++;
-			continue;
-		}
-
 		ret = sysfs_create_file(&policy->kobj, &((*drv_attr)->attr));
 		if (ret)
 			return ret;
-- 
2.31.1.272.g89b43f80a514


