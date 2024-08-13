Return-Path: <linux-pm+bounces-12177-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C499A950CDE
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 21:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EAA1C238FB
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 19:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848DC1A3BD7;
	Tue, 13 Aug 2024 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="R+AXSjNJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55A19AD5C
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576132; cv=none; b=QNC+6JsvGPxc3yxU/wI3rSSuFsR60dGp2tBLoEPOmBEq9Ql6WWWwFrchZheWQpT0wmE4vxdHHu5dxFzcrC0AU0hNCHHXJBYOC2TceK0hez7uPA1AKpEQ6u3jlKR7Sh+F/mJUAxK6fk8PwGSwGt/qu+92YlzrPi5uW/aEqjem0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576132; c=relaxed/simple;
	bh=s4cJTfsBzdk1b3XKClR3HSsskXkICRtwtwGFKEoNPNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMycp2t5HMEgDrSmKKfXyFSRDkXe38EL2g17KSFomA2MydItuz8YsO5c0WvaLDlf8ocWDnCBe1Ofj1TbdedvqxohgjB/LXkbjvSa80yKyVoZKZeZc+xQVz1EkAphAIMUUCdWn+lc3Je8QAv+qdLfYO+7s+HqcrrKWPqP0kammgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=R+AXSjNJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4281c164408so43643005e9.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723576129; x=1724180929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gzd2WQEPbi76EewxsgExBbg7SSpfOstTUQtB3VYZHx4=;
        b=R+AXSjNJvHvYTKugun2H5zMyBOfFDHP6HwUEQ5HgspIjJHn97NaYAL1My0kM1AhpUT
         F2e/GtlNXycvnTAaFJXokwsTezevPuTjTPgdO4HjpaBt2n3BtJsS3M/x/X8cpWkpQ12D
         8KsxET2d94OGivxBSts8i88AYV/xmeoBpfdg0vonCSRwqFdTF7U1zR/UVbBYN4NoDMPc
         lf055F0tT+awr9cCtU4cFaE61Xk7U1uhZJu2xeUTkvZe7Xswm2uXzWcVfm/EGKsj3KYD
         MnCUcwIqAClW7GgZ20MMg3R7t8d9cjYy91h3eAKeydMPRQfV21w3GC0TZ11lBtOwozxl
         kR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576129; x=1724180929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gzd2WQEPbi76EewxsgExBbg7SSpfOstTUQtB3VYZHx4=;
        b=BZ3JZb87xCIvKx7ksGlk+6KKYFTRXopcY47ajLAOA/Lf3a21vjqR3dPESaUTWL+v4s
         58xtu1RDRNwE4gkbCWFVGMmPUfNvTtTZy7qx9EUXGXRhho8zd0Dix6KxnIFy8g0c05PZ
         mnXvOFR2v8pcUMQTsfGHbxjMjG8vif2VzzmivX11ZIo7eo227ExgwpiuDZ+Bu3N8of8l
         Oa+tu6VEO/+gX4pWjx1F5t1CL9Edfnqz+l4VKxELlLmWdFwPbbf4Pt9rFrQD2LMvWTj/
         2HkoQVo4QKyyeBpYLxp3Oo7FVc16G6XWmdipSyfsSO+JU/WxqR8PW0PJBl3ZOrEJ/jQx
         oKQQ==
X-Gm-Message-State: AOJu0Yx+ZCl4mHKJWC+VgRaejL2WM69OsRXQ1ww5UQ4WHRJ2fF1CbZU4
	Izwgal+mmGut1KtYaAUpj5oJJqvGYVqSop0xTxXEs0EDvRyjqQCuGUfCTxwLdI/W8+ZGkP3g9gW
	pZIY=
X-Google-Smtp-Source: AGHT+IEyw3mjTHGbp9qFCFT1cBcoZdO98/5jJCQg/huq6xNx0nQ8NfRJvyX9iu0PWcmG4d4J317a2A==
X-Received: by 2002:a05:600c:444e:b0:427:ac40:d4b1 with SMTP id 5b1f17b1804b1-429dd25f5a3mr3449535e9.27.1723576128644;
        Tue, 13 Aug 2024 12:08:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738d21sm233431805e9.12.2024.08.13.12.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:08:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] power: sequencing: qcom-wcn: add support for the WCN6855 PMU
Date: Tue, 13 Aug 2024 21:08:41 +0200
Message-ID: <20240813190841.155067-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konradybcio@kernel.org>

Enable support for controlling the power-up sequence of the PMU inside
the WCN6855 model.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
[Bartosz: split Konrad's bigger patch, write the commit message]
Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index d786cbf1b2cd..e897df0ac082 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -198,6 +198,13 @@ static const struct pwrseq_qcom_wcn_pdata pwrseq_qca6390_of_data = {
 	.gpio_enable_delay_ms = 100,
 };
 
+static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn6855_of_data = {
+	.vregs = pwrseq_qca6390_vregs,
+	.num_vregs = ARRAY_SIZE(pwrseq_qca6390_vregs),
+	.pwup_delay_ms = 50,
+	.gpio_enable_delay_ms = 5,
+};
+
 static const char *const pwrseq_wcn7850_vregs[] = {
 	"vdd",
 	"vddio",
@@ -314,6 +321,10 @@ static const struct of_device_id pwrseq_qcom_wcn_of_match[] = {
 		.compatible = "qcom,qca6390-pmu",
 		.data = &pwrseq_qca6390_of_data,
 	},
+	{
+		.compatible = "qcom,wcn6855-pmu",
+		.data = &pwrseq_wcn6855_of_data,
+	},
 	{
 		.compatible = "qcom,wcn7850-pmu",
 		.data = &pwrseq_wcn7850_of_data,
-- 
2.43.0


