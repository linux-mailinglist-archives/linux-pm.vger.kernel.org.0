Return-Path: <linux-pm+bounces-5437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E73B788CD5B
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 20:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C111C34C62
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 19:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC8613D25C;
	Tue, 26 Mar 2024 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LmKiGdEJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C4713C8E8
	for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2024 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482165; cv=none; b=hKwsNfEdHafmEynBDfIk1UKsx7ofdJ/oXJDUI9UOvAZ96bBrV9fNOPBIpkY1xFT8+3zEudKW7rLl6NS9oq+3uLLsrK9CEPHrXb/n16lUMhjJ3nmSfWEb5ksblWq96ZmwF1T1Pc9fP4YYGksqGfiJ5OYrnp5CzK89YHmfc52QSaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482165; c=relaxed/simple;
	bh=X5eISBc2PLqIh+p+lHXdUkFfFUleuSw5FP9QyKR+L1E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kKTooBOIEjnSIcHKB7LjV6gpJ6+flyVs4McygsnX2kwaAPY/o1mkcjTstCfKP3BbLC76IK7QuDaiL732uiU7NVJLU3AhfEtvlvunthQrVtuebFCy4WcfBZBhZ0Nmrms0T9ndSS3cfJxQuSAanAR/lgh7ypyjowor+TxAj5NbAic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LmKiGdEJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso711933866b.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2024 12:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711482161; x=1712086961; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+FLLYge6NbdKEYy+G+suSg2kjSLt/AviYxduzdPM1A=;
        b=LmKiGdEJmVEtvXa7cYLs0mN0HvOiQmAdt0GUsrCNcdg8T4lTF2SBV092OubzBO2Ync
         OZc4LPaOoRORmiLA6RDqZfZ5h5nwdN9Q1MiWwrMPLLUJI2d8dPrR4Mol92LgpG/nrLo8
         qxrPRAWp0Pu0H6+WzK0zGAi7584VA+l0S0xAdOhbF3aF6kXx3U0aYY6fQCcXtuwp38ks
         GQygQdas+BQ3hS97Viuu71q/Lm5gBZUW5Fzb1f3Qt1eiFOZYVYSSdNrRqYvNvNQuCrtH
         EwT+66PgqXpf1iFy03Qntt7PkmCM8/p3D7WIXncFuOd6ylkgonnP6dZNPpy/fDPZJcSV
         tSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711482161; x=1712086961;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+FLLYge6NbdKEYy+G+suSg2kjSLt/AviYxduzdPM1A=;
        b=d9K61mZO1AgnXEG6wcDuSmaCMIugOJ2XKGbrKA/zlFeDAo69tfqs3Zv4s1GrdJmRp2
         ThUTzAFxnJSYPkcAOmpEsGgzTShehOwx86rHEOgi5mIw+HbBk2hdiDuM1ykTpviCes+R
         qT13aE1/YWQglj9zAP2O0fkOvbgeC7uwP/KYiB/UG7WGt4jqagzNLGhCQL0B8dsFT21h
         MUkJfZJ5t7txMxvAZXVsKC3V2w6T8VKWnSKD+ab1c4JIYF4yu3bI4cmWaa/ZTxPseojT
         ZeCFAyRLnsRWsUuByd/d0JGocgMOxN4uJpoYpHEOn53YYPZITad8RWecg16b918mNg+6
         7tJw==
X-Forwarded-Encrypted: i=1; AJvYcCWOjX+gk+vLi0/mIwp/ZiF+WUgbiaXEEVOijPb7JejF27Ug8ZUnYqgZzAP6SSODCoEBjQjbgGUXY7aPE+3YkGecwxb2U4eyepw=
X-Gm-Message-State: AOJu0YzeHN7W5goMDS6VfWs5MYH47ceK61eS6vdOX+93EG1jBeJqBdzv
	3n8CkmDZqWu8eJN0dyq79IZZ5ygMMoui3mHiLa+GszySvf2xW7fcwTNLpQ+68E3v+qyuc4tO5AL
	p
X-Google-Smtp-Source: AGHT+IFPxh6FOZGNOEjJDQk6RkcRUUw9MrQkp1TXDM+6rygMlPxYEmDXWljceRUjnnnXMmnAPWoAbw==
X-Received: by 2002:a17:906:f10c:b0:a4d:f5d4:fb30 with SMTP id gv12-20020a170906f10c00b00a4df5d4fb30mr2212506ejb.49.1711482161482;
        Tue, 26 Mar 2024 12:42:41 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b00a46d4e26301sm4523807ejk.27.2024.03.26.12.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:42:40 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/4] Rework rpm-icc QoS settings
Date: Tue, 26 Mar 2024 20:42:31 +0100
Message-Id: <20240326-topic-rpm_icc_qos_cleanup-v1-0-357e736792be@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACclA2YC/x2NUQrCMBAFr1L224WaqLReRSQk261diEncWBFK7
 27wcx7Mmw0qq3CFa7eB8keq5NTgeOiAFp8ejDI1BtObU2/NBd+5CKGWpxMi98rVUWSf1oJhGsb
 zYKyZ7QjND74yBvWJlvaQ1hjbWJRn+f6Dt/u+/wC99uCSgAAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711482160; l=1605;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=X5eISBc2PLqIh+p+lHXdUkFfFUleuSw5FP9QyKR+L1E=;
 b=lrjsL5IP/4RGTqohZFWdgHOgrFIXpU790yBKBilc+nmS4y24JDPb0nZVAeSn8T2PZIsTn4T66
 r0LMENF3o8nAm5r+nkB5qflmjz+dGeV61X6zoYuCisnNAIE0Y8I7m92
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Currently, the QoS settings take up a lot of space and are scattered all
over the nodes, even though the config is only applied once and it's not
a direct property of the nodes themselves.

This series aims to make things better in this regard and contains some
fly-by fixes.

More fixes and cleanups uncovered after the making of this coming soon..

Didn't cause any spontaneous explosions on 6115 and 8996.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (4):
      interconnect: qcom: sm6115: Unspaghettify SNoC QoS port numbering
      interconnect: qcom: qcm2290: Fix mas_snoc_bimc QoS port assignment
      interconnect: qcom: icc-rpm: Make simple functions return void
      interconnect: qcom: icc-rpm: Remodel how QoS settings are stored

 drivers/interconnect/qcom/icc-rpm.c | 187 ++++++-------
 drivers/interconnect/qcom/icc-rpm.h |  13 +-
 drivers/interconnect/qcom/msm8909.c | 268 ++++++++++---------
 drivers/interconnect/qcom/msm8916.c | 153 ++++++-----
 drivers/interconnect/qcom/msm8939.c | 157 ++++++-----
 drivers/interconnect/qcom/msm8996.c | 517 +++++++++++++++++-------------------
 drivers/interconnect/qcom/qcm2290.c | 416 +++++++++++++++++------------
 drivers/interconnect/qcom/sdm660.c  | 393 +++++++++++++--------------
 drivers/interconnect/qcom/sm6115.c  | 242 ++++++++++++-----
 9 files changed, 1251 insertions(+), 1095 deletions(-)
---
base-commit: 084c8e315db34b59d38d06e684b1a0dd07d30287
change-id: 20240326-topic-rpm_icc_qos_cleanup-bd8958232f39

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


