Return-Path: <linux-pm+bounces-27570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1A9AC2442
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E294A1C06F42
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63297295DAA;
	Fri, 23 May 2025 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VAdVPC02"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F3F2957DE
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007659; cv=none; b=VC3qzHUhJ/6b3N6hx89ZUe/wLdq/8Uopa0cHOouqYbI6QGDgRQFjujViaFd5BsDDL7HnBah57qn3IcBCi0l/76yDB/phrjKsigHzk0DEuILtHvHukaodrpIbH9XWtXZ/g42YPJYPwZdOUh0/3T7oY4e7Vw2NYYbCxsLPXg5d0x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007659; c=relaxed/simple;
	bh=T1xgNZltAjtmifp4jfz/spATibuE2uO7MlAk8LyXjGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzOLhbg54dEfK12euCH7gEOYEWqA7djUci/fGxy/5HAMrUTlQDBlj7ecF6w+Yj3CO67KXpVV6W9l8lROhOtj24x/8HWsQTsHuKsyyCeNVMDMqYwQ5Pwe9yl1lISObBIyH1sgWwFy82VvDsyBUAmhki8aJRXGgVprSVjxvBn8jyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VAdVPC02; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-551eb17123cso9062456e87.1
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007656; x=1748612456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dLO5FUnZLNVebsG8JkJQYms3itDlHs2qdSFPmZ+ETY=;
        b=VAdVPC020GdSrjcE+qXPZG+A9jWKcqn+AQMO5uiC6J6suxmRFaz4yw4sCnXZy2PWbo
         K67MM4GuQSKFXDAAw9aYssCOQxb7rBHe12DOxvZuIPlbOcm/br+Kq79pFIGRk9+7QD/C
         3f4T8m1TRE5KkjXJP+lDQAoECjgMb59Q978sNqCxIZ/cs/L2l74JFyaO3ICkU7dWKJYj
         aJG2IHAOeIb6Ee2CDY/k1pjnfSIuLJIr00q4Aik1UIXn8CrStMWqeYA8pyNedrOGS7cU
         Hq1nCodUf2IYTBg6ubGxW0b3dKJGRKJOfhCEfLJaGchmxyoxNz4cMERHkSObl6R/0MUK
         gx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007656; x=1748612456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dLO5FUnZLNVebsG8JkJQYms3itDlHs2qdSFPmZ+ETY=;
        b=es1hK8PnxjKLn8OxSk6ihnZH+OVs/sPs3DQ6TI1/rRRN5m/jRbW1XbPuBJ3CeYRTRi
         3GLre0c3jTj91Xek/bjb1xlOvZMTspjs/M6GuUsi5vPTTx7gQkJpHTVTdlbredP9o5sb
         E3WiHzEPOvSCxWnDVnp/5oQeNODX/6M+vEX3m+MeS1AWK8z38W2CKLloksRLklZceNg0
         kqkYzxPNE/r2ovJeh/jKsIvCTAm9SFuSoGFbsAUbwh8rdRYTKKLCV+eDVXkl1BezkZ3c
         wMVAnC2Wwc1FE2rk5ZbO7+jpYm0iYOu7ANFJoPa9isLUTfZ1LMTxXfnEK64UmMyy8oKa
         o0qg==
X-Forwarded-Encrypted: i=1; AJvYcCWP+vjb+pnkNDnBff1KrrHNNv71rNPHNLswWey+UqmNE7NJ2RH1IUum5SFNf2ZLM5f/Hd6dzek9DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIlPpm+nPg4759YIr/COgIDaJYODvUfo8GtA/NiSJJgKUUQ1Pz
	kMuo2QKKE3sy2DsP2wfvdJAhbXhloqv+v8p/3fpbknVfIgLSKA6nRGeqUbfhJ9GqXiA=
X-Gm-Gg: ASbGnctwziHIe1QDl1b8Y9ks0AULtp0GSTgIDIYyke7p/i8G1OWpiOV+xSVNHDvqfev
	cr4S+XzdmJPfTWA5xcoT8nfWwDpOqzGFn0OQFCNXpYNRWjQuOouw34y9vMsUj1+GFe6R5B9hdxb
	+N1lyKVVFDEI1EoNk6Miaa3FvxBmK8aH53aNbw2U6mWv0ayEY29pBcnUIAj1bp4yOA5yi8OtEN7
	FaKG/UxYdf8YVHvNm6T4CMYv3q3w5nAR5W2pg9nsj4Ns+aAZ3zF7rSY3lphWYWm2x4xNoIvdanv
	Cu1Qm9RJKDhuJE8jXku4Jv6HGxQbZ5jXvFFywwnQLF49xpeK8NZy++WC5tey2vLBKGgGq1Rtu09
	e/nXeotpzHpOE05/swZEYapFlOA==
X-Google-Smtp-Source: AGHT+IFf5shMU44TNKwf2RFfAZvM/E6/6pPkbDTOgxsF8Wrk3SQBud7p3rswM2Pdzq/U1CzVLKmBdw==
X-Received: by 2002:a05:6512:31d2:b0:545:3dd:aa69 with SMTP id 2adb3069b0e04-550e7245310mr10207937e87.36.1748007655625;
        Fri, 23 May 2025 06:40:55 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:40:54 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/21] pmdomain: qcom: rpmhpd: Use of_genpd_sync_state()
Date: Fri, 23 May 2025 15:40:07 +0200
Message-ID: <20250523134025.75130-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523134025.75130-1-ulf.hansson@linaro.org>
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make sure genpd tries to power off unused PM domains, let's call
of_genpd_sync_state() from our own ->sync_state() callback.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/qcom/rpmhpd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 078323b85b56..d9ad6a94b3ab 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -1027,6 +1027,8 @@ static void rpmhpd_sync_state(struct device *dev)
 	unsigned int i;
 	int ret;
 
+	of_genpd_sync_state(dev->of_node);
+
 	mutex_lock(&rpmhpd_lock);
 	for (i = 0; i < desc->num_pds; i++) {
 		pd = rpmhpds[i];
-- 
2.43.0


