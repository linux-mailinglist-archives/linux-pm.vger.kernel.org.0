Return-Path: <linux-pm+bounces-20930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF26A1B22F
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 10:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC927A19D5
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE6121ADA3;
	Fri, 24 Jan 2025 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qFutLe9o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC0121CFFD
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709157; cv=none; b=pn6KILGMRrcfsI/kVc9XWLlyQbiRkogA5O4GVRTCZjASnDO5N9vUfVCKNbjiKGHmdKv9G9Z9OSe8sQccwAemYcndm9PSbliJKTb9sIUCl6vUyg+ycZyGxFLORRMnOHt/5bKsDt4wCo8jdLHa/qeAf0/2C8aq3KHKmxleIrcf0aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709157; c=relaxed/simple;
	bh=Gx5tAkuM3tQafFNc5Mhe6PmrPMAavPP6iPSppEjU5/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ryxmErbkjbMb8rF1PD/wKREXUoFyxCn3LuM7NOMNMEr+AsO1CzFeUoSPzDEi1kVq3gfTYFINc+CbPlnc/xpgG/GZTk4Ylkr9eMMwuXmB5lwm4FrvIJ15pXsHF4+m/GW6IGAabF/eNLlmsrvWK2TSxiONbb4g0lAe6/Izn3h/61Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qFutLe9o; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so2663009a91.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 00:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709155; x=1738313955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s94rBGytqIBo4tekti3AaboReTxXzjmT35D71HaGAY0=;
        b=qFutLe9oOhB3lpPmToxh/n6n6lHObAtWO+of6rVF1ON1/nxpLisgqaWc457GEgeoFr
         DWerTDRNEXWe5PbKGbgOfStRMaEG8kf6UbB1dZCGKLlQG01KTsG58fjqELWFgbhnkW+7
         PoZUO0doDyf4PN/11pwA3RbzVUOLMMAEO5aa3UGCDwGLH714hVy6RsiGMlG5DQiWLAzv
         HuVQrNE4eUamLKyEm4OLbXcFnQh+jZrGZhXFV6+UXUQ3kJ4Sd+XAUXoY+kb4oxru1kK2
         KX0/wSdgCgBoNICgLEgaZWGC9U2TxpSqAV6LnWvv882GQNIXPaqJWN8Di4rGq4WGTO7p
         5VEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709155; x=1738313955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s94rBGytqIBo4tekti3AaboReTxXzjmT35D71HaGAY0=;
        b=SThcnnYdxooHpzaO0JgIXqbsSuID3h0yeiMpIrBU9ETwcYjQPKSChqyXAGcdcxrZaq
         I+0dElXoxmMrQ91VzSJWPpnjrBWnLNZ1aOl8nlb72YGPyw05DvCTRlgbbzfiqs8coJXD
         bZLf6inCtjRG7h10QB4zSIchhYRvY76IqfV6R+lE2z+OW0qwUz7IUtt77zGObQZYOZHs
         UZu90c2j2M+Qlf7KwItZoPsGzb4PHG+4A15m0DmzTOKwUBV4IZ2MVn5U59rrmCLfW8/k
         +AsGQmKO66AYoR3gNO08w8dpgs6LDdO20ZW6Vcx2cJd2EzR98mbvlL5oCMW5XVKOstER
         X45g==
X-Gm-Message-State: AOJu0Yx+eW151cmWvDXM9Xic5Bu7eBpXa79T6aN3JPrmS/0C+hSJ4clc
	t4XH6Gi6FIADYdh82NKKA2k9kGvwQwvtbRV6AUY1ZYUQvsYntjpaNJzDfZJO3WQ=
X-Gm-Gg: ASbGncv2Ulc2V+KJjc6Up7xG5oYnlIKOR664ODsBt0f2c+hvxB9ureDW4X68yt+6U7w
	7dd0Men1jYneByuWMIdmGPPfaV74UrN/MRIW/LgtlozXKF7qdsxu16MxzQA7B45YNgvBll9doEW
	QRRgBoaqNyRlQ+A9x0voJWrgbsphUQmghMR2igZUpLc8VSbZSSBhpJD4Q1tLTotOBDU1RxANqKv
	Mil4iu/SqWWGRv4uPoKKut6C6UrJU6VCPG+sVzn5s423KzP1qvTYwfbPVjbsyoqz6tyAd3zwLSZ
	s0crr9ngUjZJJvguhw==
X-Google-Smtp-Source: AGHT+IGd324gk3vUxN6Dj/7u4RkiZpPJbthb1QKDynr38KHf328GZ4u/AOfJCn10b0DpZhUS9hZTMg==
X-Received: by 2002:a05:6a00:1412:b0:71e:4930:162c with SMTP id d2e1a72fcca58-72daf94f6a5mr41280675b3a.6.1737709155304;
        Fri, 24 Jan 2025 00:59:15 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a78e3e5sm1358044b3a.172.2025.01.24.00.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:59:14 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] cpufreq: qcom: Set .set_boost directly
Date: Fri, 24 Jan 2025 14:28:17 +0530
Message-Id: <c59085ea0f1e97791f5ecc255886c2bcfa7a7b34.1737707712.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737707712.git.viresh.kumar@linaro.org>
References: <cover.1737707712.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The boost feature can be controlled at two levels currently, driver
level (applies to all policies) and per-policy.

Currently the driver enables driver level boost support from the
per-policy ->init() callback, which isn't really efficient as that gets
called for each policy and then there is online/offline path too where
this gets done unnecessarily.

Instead set the .set_boost field directly and always enable the boost
support. If a policy doesn't support boost feature, the core will not
enable it for that policy.

Keep the initial state of driver level boost to disabled and let the
user enable it if required as ideally the boost frequencies must be used
only when really required.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 7d83d7d2ccc8..4b3b3dbc7d38 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -566,12 +566,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
-	if (policy_has_boost_freq(policy)) {
-		ret = cpufreq_enable_boost_support();
-		if (ret)
-			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
-	}
-
 	return qcom_cpufreq_hw_lmh_init(policy, index);
 }
 
@@ -610,6 +604,7 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.fast_switch    = qcom_cpufreq_hw_fast_switch,
 	.name		= "qcom-cpufreq-hw",
 	.ready		= qcom_cpufreq_ready,
+	.set_boost	= cpufreq_boost_set_sw,
 };
 
 static unsigned long qcom_cpufreq_hw_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
-- 
2.31.1.272.g89b43f80a514


