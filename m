Return-Path: <linux-pm+bounces-40180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73414CF2F3E
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 11:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E540302412E
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 10:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4B6313263;
	Mon,  5 Jan 2026 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XVT72kka"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f228.google.com (mail-oi1-f228.google.com [209.85.167.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B532F4A1E
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608274; cv=none; b=FSdqdlK/jvbaRb+3xcDHSUE0AEI4lpSNc++YMqCVuvYOQL/hhjkr9ZxW2qBvTYWEmrK9MHLhOYykICrAef3x9xLHT1aieNuc4tbkYWFij3Sn4IK5vvWuFiZKxipXhTYk/GEoHFleKU6HkXGnTO45ckWAAdosBL79YyOnvBdk/NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608274; c=relaxed/simple;
	bh=QY3HTEVaHPlfhfn0LQXxca+zyPZhcAwhzUarq0fwl9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I+6zxD1arlQODn4ptzQ4bn0ORigdGN2JzXLM+oTN5GgtaNZvURdauVHr96mTA2TvH8m0zpKzE42F+OB+Qh5XvmDOa3uZbAs5q7IbhU+mY+plDwAUzJzbtFBIuZwK6iNZFBm8xynvaSHPHpoGWgcwcV08n0bERK66h3Brx4HI0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XVT72kka; arc=none smtp.client-ip=209.85.167.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f228.google.com with SMTP id 5614622812f47-455bef556a8so9428158b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 02:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767608272; x=1768213072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDEZfxXGKUHqnD6uzu3JESKT0vdq+bi9ssWL2yPlp2w=;
        b=kIU5qSSfKlA4W4U5OKgdVnD7t0zAJjpvYuJsAboCSYK6YYzsGV2UIs6YOURcOGtJR0
         HaO5FmsaCkmmHxATMpK8LtmDhJDk6qDO0oSqVTxrD560HFp6uDZlLNhss+AihbNnXyvv
         JoPGoEM1TpiMYqVZF9igSMaqCTGO4c3P0C97dKmF9Pot3fsvkK9Pa6QALt1jugzPsKqj
         oIa5Z774idQmmmwQoHnzGTEnAPdYbSARGbSFobO5k03kp9gQRLFP4sRgW6IgY6vUMRcN
         Mcj1xouiEyeUprZIH9IJGylce18jBUXpzXOEYgzdZ6xxRD+PNRrnbIs6njRQtRmWzEQv
         aYZA==
X-Forwarded-Encrypted: i=1; AJvYcCWqgvh9tOAL0ajHXeHTfNKYMBuaS3qPANbs6AmJjsU/8Aghv7fyFsfHatDy+DhwtXrOiYG4jv1qIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlKt8Vceg6LFVoJuMEOi5bDxmDg0zdT10X9Pzr1epLhHNbmdjZ
	PEKyxi8MTakUI2hCSc8gXXj6At+Y0vALel+W2daGWaC5h9uWAonuJKo/GYlc5qSlrj6jjIs12O9
	IWHKMd06tzoZTbwO9Tq6tVQjNEGChch4+ki+9GH/7DUQz+h3+mm1xiGScLbNyMld++LqRob/7v6
	3B//jaC0+Lc35mmHeEKbXhhrXi7YBdpwJhlO70XjnHE185gzhvcp1Do02IdDqrZOFZFcDpQUAOi
	wwFMYEKXXvetRU6WGFr
X-Gm-Gg: AY/fxX4Waolj812JIDOlfdaPJp6gy4ZhoRO8EH5m0WWQIfMndIAuMCljpRoOq0R9UnI
	ZoGzn4sMD5IlSW2jI+SOdEXZBAvEKZiTHxUTe7t5fo9bL2fa7yYAY9Zo9PWjziaVRADRLZ/5xrN
	l9I9qSrJskfcXpRt34aOn4cMhjQqLYg/eCF/yCJE4+xquWD/Toa1zPYVhAAw9+SBuBwf/9hxJrI
	KduzQDCu6F3dLOG8Pb3Pgsjw5I0tIG3wJs4IS6pEVp6Etp+ppJhOboYS2Hp6l0DakyXcOyiFYQ+
	MCgs1j/UqA1/NvA0SCektH/nisbk3GQsfER1SZWRzwEEuGc7gbDA2xyxVbfuIykyvQoIMXr2kV3
	HvbFph2LnzLSocX6yyHr8nkhpDmAOE+fpv5rQ19Cj/a/FmvD4ZVsDseNsnG7vaUUqB6JwdwGyUe
	bxxXZKibLwWSqdP7YewKD3EgGKefwpRPar+HGPfBCbIyMDgw==
X-Google-Smtp-Source: AGHT+IGVq2gR61Fw3ME4VV7+Fo6NYVZX2GaO5jX/GsAalW8CGlSWafbQNl2H+73BFr/Z5OIkz5aZ+7RdnlwP
X-Received: by 2002:a05:6808:67c3:b0:44f:e4a7:74b1 with SMTP id 5614622812f47-457b1fc27famr17493177b6e.3.1767608271795;
        Mon, 05 Jan 2026 02:17:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7cc667d771esm6400354a34.6.2026.01.05.02.17.51
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2026 02:17:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34e70e2e363so31362705a91.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 02:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767608270; x=1768213070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDEZfxXGKUHqnD6uzu3JESKT0vdq+bi9ssWL2yPlp2w=;
        b=XVT72kkahmHtaf719+HMdZO37C3gfnmLQw4FyrAMadM2CYk3a4lhAJOeKTrdwNfv5W
         gzNHLCfteYMe/qZhuUZ/gG7ZnauTI9+wYtcgITdjvpX1JtUGeTwoxK7sfJZlfrrbTj5Q
         5s5EbShd9BYjVHhQvn7CNcjg4S6XdoIvJ11cY=
X-Forwarded-Encrypted: i=1; AJvYcCVotztYMKop538+HOXU9G1pMNa2SCaKaMwQXYhZmm7zGLFloVpnkIYqRZEC8+yugIA3IHl2uQoYWg==@vger.kernel.org
X-Received: by 2002:a05:7023:905:b0:11d:fd26:234e with SMTP id a92af1059eb24-121722b821amr43934364c88.16.1767608269932;
        Mon, 05 Jan 2026 02:17:49 -0800 (PST)
X-Received: by 2002:a05:7023:905:b0:11d:fd26:234e with SMTP id a92af1059eb24-121722b821amr43934337c88.16.1767608269346;
        Mon, 05 Jan 2026 02:17:49 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254d369sm170077924c88.16.2026.01.05.02.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 02:17:49 -0800 (PST)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Henry Martin <bsdhenrymartin@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate()
Date: Mon,  5 Jan 2026 01:57:01 -0800
Message-Id: <20260105095701.659420-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Henry Martin <bsdhenrymartin@gmail.com>

[ Upstream commit 484d3f15cc6cbaa52541d6259778e715b2c83c54 ]

cpufreq_cpu_get_raw() can return NULL when the target CPU is not present
in the policy->cpus mask. scmi_cpufreq_get_rate() does not check for
this case, which results in a NULL pointer dereference.

Add NULL check after cpufreq_cpu_get_raw() to prevent this issue.

Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI message protocol")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index bb1389f27..6b65d537c 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -29,12 +29,18 @@ static const struct scmi_handle *handle;
 
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	struct cpufreq_policy *policy;
+	struct scmi_data *priv;
 	const struct scmi_perf_ops *perf_ops = handle->perf_ops;
-	struct scmi_data *priv = policy->driver_data;
 	unsigned long rate;
 	int ret;
 
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (unlikely(!policy))
+		return 0;
+
+	priv = policy->driver_data;
+
 	ret = perf_ops->freq_get(handle, priv->domain_id, &rate, false);
 	if (ret)
 		return 0;
-- 
2.40.4


