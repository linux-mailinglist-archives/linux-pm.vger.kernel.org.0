Return-Path: <linux-pm+bounces-29440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163BDAE6905
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 16:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601BF188EF0A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9652D5C80;
	Tue, 24 Jun 2025 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TETDxPIL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C672D4B67
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775555; cv=none; b=ePf7ZV/tx/uwUTcxufE2opapRudyJBils2c7SVsqyqxr18cKd55/t5RzE0fUyW3Bt/oDgoKBXB4TVUAXeNnpZlEDCSph1B2PQOmmuiyWE0TvMMY4e8EzoovfgI88Cdb091Ja2xKd3ZNlZgGkybKGn7jMxDEsegW+u+2NAxlab2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775555; c=relaxed/simple;
	bh=tcNUMicj3q2TZD7z9sDFdteTWDh+GHAvsTNL8/OskaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIJNmXyiE+9Bjc1/uCiE7UMZEKGncCyR+QF6tD07w0719OwcinJX88pzSFQ4O3FCDeJgUj3RNkT4aXfMRvigLYlxTn7FzrQx2BqQ4yQpvnhVMUtVFYA9PWBNtkBV8JsV1cmQr5rOChxUgGYuBSAnZuEwzDyOa+n5pA4ZVX1Z+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TETDxPIL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-453398e90e9so37287985e9.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 07:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750775551; x=1751380351; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uw4x1TQGrA/MBrQhecsgMke6peLxrAZP3r5KIxkbAtg=;
        b=TETDxPILO55Ud+j3nze9oeolKb6BqHKX6phmmNUG7U+lq6UFdqPhhRjsy/SJv0HTI/
         SpVIJ5oIVWSCSSwhMDjtQGGekrRJAEw51PyVu2JFjrgYNbnKOpCqlD3oX2QQDuI3Mtfx
         PIs4qzhBQXH+fBVBMgvbk149rlVz5LDYKEB/n0PIzFkA+O1E0Udy195M2ShyFwLKbrRG
         DEwqPkRVHIjb9sEcF0me9IZpyTGRV/Fb9MeTER0V6APYOELWmxu4lRzqGX8iwaJCddwR
         +kdDiSy+HBixZ+18KJzCc4nU0w9xTwH+kolAH/cxXbdHlM4icORE6aPCDnn5kjH/7e4W
         ruHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750775551; x=1751380351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uw4x1TQGrA/MBrQhecsgMke6peLxrAZP3r5KIxkbAtg=;
        b=AkOBlLSCa0ACidINT9V2wMCtDNKDH0XcUhop1JUnk4fonQmpdIjkHubVyPhi/MUIR4
         0DdmcQsNKiNykdDjkxgcuGOAHYCOzuNyVr2SPPzWUdRiXLVxe9a+M3ivdARCs67DJ/BK
         ZQ/mZvbCxwayhtpajerOBCS2ZgdNhgTze20aELy/hnueh1UJKuk4FE/4wJM7SqzLbZkk
         h14pyVQsRxbpfuui40sCFgfqNFHPUIYWuB/dxs1ziHHyrOcPzap2d/Ehcngku8/chM6g
         rEzSHepsyviiMiUkaqA8xgtzhndwOt2vP7i51bOP+lDZhXZwa5XYtw5IA5hs7/7UpjQj
         Vt1g==
X-Forwarded-Encrypted: i=1; AJvYcCWVLeNQKmNwe2s8w8dXLRp9Q3b7J5dmOZMVUyw793g14o58MRHb2IwE8Ku8beBiffdY0VjuT/kR2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFy1+zLIz6djzJwk2StBfeXUu9NP/ekMPSQbM4prbe3zg2GB+D
	Mbfx+RcOI6OxbJzgb+g8CtzpVTQChKpfu2TYkftS2PJrYJTlnHLWQXHGmsMVVDxs/sCsByVEMnU
	HPjNNzVU=
X-Gm-Gg: ASbGncuXX97yCSPfhcYfZDlS8weB4pezSmwMGPNwfZSfX43uVLC6IKd8yBgpcFxOH7T
	BhPNFTMP4JDMRuP3CREpo/ulmQnKDZBETSn9lS76lLBV4RM7sC49R9ODS07UiQCuPUFAXSfvILp
	RSvsslEik03yiZIc08TFN3kaiZLPRc+HYN0go5wahSSdHNU2zIWpI/LtPEx24+bj6kZihNWhXWQ
	EoUstJX60I4rJgl7iTHuZTt+sFb0X8Av8dfaKc4X5RpR1p1sESrXSZTEDZ+kXLpPuPMZqG8hp3H
	uQ9dG97GEo6QbHqGsB4Zv22Fwip5tx9j6ZxVxS183iWMmP8xW335aAgMzxS/Le0yjRc=
X-Google-Smtp-Source: AGHT+IGnv9OAm6kU3yC9OQdJrsGHg+VSoZWXLELg2p5G3m4MaLGEgPnmo4tXgJNKP087uSEZKo6VwQ==
X-Received: by 2002:a05:600c:1f0e:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-453659ec182mr147580495e9.21.1750775550906;
        Tue, 24 Jun 2025 07:32:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:34d2:109c:3293:19e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ead2a84sm178512935e9.32.2025.06.24.07.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:32:30 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 24 Jun 2025 16:32:20 +0200
Subject: [PATCH 3/5] pwrseq: add defines for return values of the match()
 callback
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-pwrseq-match-defines-v1-3-a59d90a951f1@linaro.org>
References: <20250624-pwrseq-match-defines-v1-0-a59d90a951f1@linaro.org>
In-Reply-To: <20250624-pwrseq-match-defines-v1-0-a59d90a951f1@linaro.org>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=J8hhxEPGTDWzHxMDIGZhdqk+RbnXtaJ73h/HNS5w2Tg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoWrb6545ElYvrc1gET2OFrM9gsPHxKk7OK16+E
 9Xxp5PPJKOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaFq2+gAKCRARpy6gFHHX
 cldDEAC9QFYvQdgFCGmN1OsF83q9dP6J3ttzdmws4vnanU/xhmtw5AvNBLkGJnyf4wiuUnhY9mS
 LsUBGrVxyeZlPf3WACN8cUMUqb3hhQY55Qszvh7fRvs0I2OF/OCai/HLPvzX0v92HIYJ+iSR6We
 3MpJmzSDBWEXsEG8Hhz0bNys37m9+IL+PlWbQ68d0LfokWAUpfXTwBUa4+jwQMKVJcrGCyTnu8r
 hpHAEEwMRHRMsWt2i/ifysJANuqldhaThp6Rny0pK0Ymwa28RP445JPMWqGK43wjhO/e6y3RX21
 ZvM9Qs4uP/EEzMDEVzFGfRYfq4GpNP63Q9efcGYe/tohWCydW2dBOYVD1ZZ2tVu4bauoHpamPyB
 64HT0qbLoZA1CIUYyXpwY+q3zUwaHeJcKlK8EdM3R+PJnSjXb1x2BB2V/CqC+01JQ8nJG/CFzR0
 pop1bz38H32jBaud5py5CTPMwkztfda0zwstBFJuW+YyZk74gs2wRroCbE4hVJKtbSvZShBpC61
 d1+S20Sp7XJphn2nm8HNpOIm6T8WlSdpgwfNHJyKY5p2obqwPJhvS/tNbKKVkGNE/MO/Nov3kkG
 XmEonDNdAVE+6z+Z7zXH4Y6rLyOJ0MjOygcURMP+OB+XJvBdzjJcX/JgdMYzQ7ehCkr0JWgeXgq
 +V4Rib0enUeuJFg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Instead of using 0 and 1 as magic numbers, let's add proper defines
whose names tell the reader what the meaning behind them is.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/core.c | 6 +++---
 include/linux/pwrseq/provider.h | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 0ffc259c6bb6c8333ba1fc5e6ab43e42ba0d3524..190564e55988557940206b059fef52981bd49e5b 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -628,7 +628,7 @@ static int pwrseq_match_device(struct device *pwrseq_dev, void *data)
 		return 0;
 
 	ret = pwrseq->match(pwrseq, match_data->dev);
-	if (ret <= 0)
+	if (ret == PWRSEQ_NO_MATCH || ret < 0)
 		return ret;
 
 	/* We got the matching device, let's find the right target. */
@@ -651,7 +651,7 @@ static int pwrseq_match_device(struct device *pwrseq_dev, void *data)
 
 	match_data->desc->pwrseq = pwrseq_device_get(pwrseq);
 
-	return 1;
+	return PWRSEQ_MATCH_OK;
 }
 
 /**
@@ -684,7 +684,7 @@ struct pwrseq_desc *pwrseq_get(struct device *dev, const char *target)
 			       pwrseq_match_device);
 	if (ret < 0)
 		return ERR_PTR(ret);
-	if (ret == 0)
+	if (ret == PWRSEQ_NO_MATCH)
 		/* No device matched. */
 		return ERR_PTR(-EPROBE_DEFER);
 
diff --git a/include/linux/pwrseq/provider.h b/include/linux/pwrseq/provider.h
index cbc3607cbfcfeb5acbc94908a1eb4a861159dc41..33b3d2c2e39decafac6c6fca9254ad4329d90e94 100644
--- a/include/linux/pwrseq/provider.h
+++ b/include/linux/pwrseq/provider.h
@@ -13,6 +13,9 @@ struct pwrseq_device;
 typedef int (*pwrseq_power_state_func)(struct pwrseq_device *);
 typedef int (*pwrseq_match_func)(struct pwrseq_device *, struct device *);
 
+#define PWRSEQ_NO_MATCH 0
+#define PWRSEQ_MATCH_OK 1
+
 /**
  * struct pwrseq_unit_data - Configuration of a single power sequencing
  *                           unit.

-- 
2.48.1


