Return-Path: <linux-pm+bounces-16350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC749AE16B
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 11:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016D61C21DD0
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 09:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBCD1B85EB;
	Thu, 24 Oct 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LyoA0BLL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C351B3939
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763388; cv=none; b=ZAufMs1GJAOrijaTSxoKAoIToFewXlG4aqTMKPLq/O4DZpvCA1KEj95oxRqhB9Ed4FuNAV1r75KvKv3S8WlDlqb6FDmqQCKIISgdm6BWZf5ErYsCF3wQ7/17t64DnskoV5jh9VdtNnI3npKEMHQXSAvjaNzxwlbqxw3t2xBSEJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763388; c=relaxed/simple;
	bh=sfzqqT3D5kVBFiYY9+bS5W7N8XOEpbnrlwG0ljKgZyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nwyDVm7KrW92sCbL7gKVC/OUGv6IbQHffzR+z5RXMO8xfpLr6z3MYQZlhWIArddUMGeeOTUv/fzNtEaLtR87D7lTjEsFvKZGS84ykmmNpJpF71R+Srt0Qy7tIeaVOkS5I6txK8INi6ZGpKxJIZ0FFFI7C/qpTeCSTCsJxNYjB8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=LyoA0BLL; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso878596a12.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 02:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1729763384; x=1730368184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/FW13s10cjrJ6xBnvvtPrQKRLAFq+b81IIrkXP7L0g0=;
        b=LyoA0BLL8vbD8ZC7Eu/CYXLXuh/kFEKA/oeDwP/9SWMkQ/AZKOqXemmPeDDgWgarNh
         PZTjBqBsXuCTHG3q3ofd1JkOnCbU24rId6XrGMTbmkAu/uC7mLAdbKwzwoO/ctgSvYdX
         hctT8exVs/FKiQ7CISzqdnJXdEpiFzPM67wYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729763384; x=1730368184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FW13s10cjrJ6xBnvvtPrQKRLAFq+b81IIrkXP7L0g0=;
        b=hFzORCZuWCZR9fQ6RSxsqPC2BPQE5x/dWlzoLKZfy7tNPRKK4Ffe7zbD6E2uepmkzX
         XNjHTprSIw3w8nuiWZHLJMKalVLOEE+hmy9C+9K4RvjJDWSTfFIbChk3OSwNshW6XgJg
         JJGOdqlakjjT8QH+Msjbtq8JLldW5FpiQdc+JWwVtvy6xpjdZyGcIIa49ggLMN1MHJAQ
         idvjvzmDVfnDyHX2r9uRd9AdDCU7741BDUcOvha1yZiAh2LmDaNkUwmbf/5H4TuwQhEz
         Tu1LJvJA0Q6bC4903tlgoSokifnm3pBdqV3DByw2WmTsjWdS6ZLgAHAyQbKeiIokxnt4
         QoWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuN7Mn+RFD3/Ia481uR6BxfVhVA3xAe84MN+h7yXFk63JPJTcIzDc0629bjMOpYM7lqGSLDhgVjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAhrthKzuMwi53wNq2Uev0IqmiZk20EhbRk8XyEuduvXoQm+3R
	OY23jiU4iPJlKopnudmCDgvT80n/dyxuRjSfwiMH/y06h5czdlBdvAcJVjNON28=
X-Google-Smtp-Source: AGHT+IFVeQ54olqulFSEmUbhBkaP2nl+nxzVLONvwRPdHeqidkUJ/1eVmOBIT93TMx3XDJIFOixDmg==
X-Received: by 2002:a17:907:9494:b0:a9a:f82:7712 with SMTP id a640c23a62f3a-a9abf92f3e4mr515408066b.52.1729763384359;
        Thu, 24 Oct 2024 02:49:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:f79d:49dd:b804:3f48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6360sm593159066b.29.2024.10.24.02.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:49:44 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH] pmdomain: core: fix "sd_count" field setting
Date: Thu, 24 Oct 2024 11:49:18 +0200
Message-ID: <20241024094930.3221729-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "sd_count" field keeps track of the number of subdomains with power
"on," so if pm_genpd_init() is called with the "is_off" parameter set to
false, it means that the power domain is already on, and therefore its
"sd_count" must be 1.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/pmdomain/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 5ede0f7eda09..2df6dda98021 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2221,7 +2221,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd_lock_init(genpd);
 	genpd->gov = gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
-	atomic_set(&genpd->sd_count, 0);
+	atomic_set(&genpd->sd_count, is_off ? 0 : 1);
 	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
 	genpd->device_count = 0;
 	genpd->provider = NULL;
-- 
2.43.0


