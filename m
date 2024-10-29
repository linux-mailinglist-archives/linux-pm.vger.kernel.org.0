Return-Path: <linux-pm+bounces-16665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2951C9B4DA7
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 16:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA50CB2587F
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 15:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDCF193416;
	Tue, 29 Oct 2024 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajC2I0Ul"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CA8192B73;
	Tue, 29 Oct 2024 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215352; cv=none; b=baBSYgFbt/BXkxkyGKGAiuT5w3eGtRmcYFlkGkjelf0Bl3WqzyaMQ/4PYAxqqA6gNo5W94TwdTuA0tRBEGdHYMXqxedBh7RepPkyk9fYt4lWOdC34lWpGuPp0Ww/KxgsrLdKc2axx+1cBLESHbcQ7XwYYEJJMMGErKVtImLq6P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215352; c=relaxed/simple;
	bh=fjjB39Gd7OtzC1AMtJMBwpe/HfzjmD6zgnb9K/eiouQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=K01OaCiGHDhWwloCH/NdCyAhbUM/X0NrL/ifHggVlACyOPdCstqXXlf3Q/TEPN6ggfNmTuNY6DkCcwROAsgDnpDYCyo0BUtWxUQ5gHx5AVU5eVs/n8kCcAK6WFkME46R2pSJaYOaUiU/4ish0Sn2p0/wC2pvG+okoPApulnm24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajC2I0Ul; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315abed18aso53021565e9.2;
        Tue, 29 Oct 2024 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730215349; x=1730820149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=awcNgOinq9mb8rRdpT9oztyZ0WKNu1hzxPR/YyKgUD0=;
        b=ajC2I0Ul6Zr5F+8TCm9HeBhycFQd8YCYa3WZL8b2df3tmuQ1GOGaUugN9RN9MUU+GQ
         z66m1yFlNmodjH2kcX1WZLiE0dLX1vy5saPalwIs9IxJekuohp4nKgtvbfqX2HtXsba/
         OPUccnnKXS3vW7FTn+gw6f1xb9YiwS1z2dRAhUl/lB0awlQfyVLzZGAehi9n18jhe0G0
         WiVoV9eN+j9KqMhtolNF61u1vELdrWTqoQ7s7FKm+CL8S8phDfglsKqtOejM3/6tZjJ1
         3YAZamnnoNhliqXaZ1kq+AFqU+6tv8RzmRsLyRlA4eyBRpxW6oklrgoTyOL1mYh0ENMD
         L9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730215349; x=1730820149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awcNgOinq9mb8rRdpT9oztyZ0WKNu1hzxPR/YyKgUD0=;
        b=wUIWFAPut6oGPA0Wj0/WdCXC4tVMeTMFa68OKQhbZOJu/BQw1/Dq0VTsBETRi0j8qR
         StiOfAoQLcpb7AEvhVXIz52tgqiswyWqFDqFN9TfCE6l0Wp3df9cNtGFWbGHLE9RzT+3
         Ig/NglOkq1BN3X8g1tzvxwgZKQIPzMx1wdeAIxWU8LUsHE3t1Qz5wyedCCteyB1NMAG3
         8yDkWi+/Ji4tk4ot41S9p4W1r+8iEeFNIXhchlbWkyJTOH5vvpD/IVxZm4kluS/XGfrg
         z6Y5PupDwPNqqhaUcRR8lbZE9fdgaIzVKRSGJn15gtYRWOQi4jXfHLqPG34CEoUJiKal
         zcxg==
X-Forwarded-Encrypted: i=1; AJvYcCVcWEs2BSy5u1FxcUg2x603HN7oGkiDYiCi+VsSpVKz20aXnQCFzPRR91zZrUbD5rLx04QcND36@vger.kernel.org, AJvYcCXgS4kOD20fmjEwquJ6CZGE2ar6YMv5uoNWjQpkc4U1L5zHSyHOrQQBkkJv+ym+HclM/c88K+GjCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHXoQP0tJ4FuNMm41ODhiwyGlyZxRQ1+IZ/i2ghkF0h4XvgYiG
	MkW6XR30OAw8W4x6kkkZT+ugRcrMQtrjx/hXqScz5mmeIJ4Y+XX3
X-Google-Smtp-Source: AGHT+IE9vFhqscMH2XH7WucYsm+7424jo51krLCV1bd7E3yubxSEK7J2dRuiCubpICZLlhVPhD3R8w==
X-Received: by 2002:a05:600c:3593:b0:431:4f29:9542 with SMTP id 5b1f17b1804b1-4319ac77f6amr85365695e9.6.1730215348801;
        Tue, 29 Oct 2024 08:22:28 -0700 (PDT)
Received: from localhost ([194.120.133.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b54303fsm177639455e9.7.2024.10.29.08.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 08:22:28 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Markus Mayer <mmayer@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Revert "cpufreq: brcmstb-avs-cpufreq: Fix initial command check"
Date: Tue, 29 Oct 2024 15:22:27 +0000
Message-Id: <20241029152227.3037833-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the condition ((rc != -ENOTSUPP) || (rc != -EINVAL)) is always
true because rc cannot be equal to two different values at the same time,
so it must be not equal to at least one of them. Fix the original commit
that introduced the issue.

This reverts commit 22a26cc6a51ef73dcfeb64c50513903f6b2d53d8.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 5d03a295a085..2fd0f6be6fa3 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -474,8 +474,8 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 	rc = brcm_avs_get_pmap(priv, NULL);
 	magic = readl(priv->base + AVS_MBOX_MAGIC);
 
-	return (magic == AVS_FIRMWARE_MAGIC) && ((rc != -ENOTSUPP) ||
-		(rc != -EINVAL));
+	return (magic == AVS_FIRMWARE_MAGIC) && (rc != -ENOTSUPP) &&
+		(rc != -EINVAL);
 }
 
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
-- 
2.39.5


