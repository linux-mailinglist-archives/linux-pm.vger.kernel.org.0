Return-Path: <linux-pm+bounces-24278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0F8A68A03
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 11:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DB53BD2C9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B18E253F2A;
	Wed, 19 Mar 2025 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT+MkH9s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9AA1AB50D;
	Wed, 19 Mar 2025 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381554; cv=none; b=on8WxoteXQKqEoYTyHui8drkCqSo9HR70rNKDlJ7OKJVJ2cI6qCjOMqDCm+/HybCva9Vy3RnZMElJyN2cC5zmuolvX7F1YPy4ChV1V5ACuHJrM8/UdjXS9MoscPyeJHZl3W/W3/1LZyxeSYlmPKwMIzC/LGQd5gTYHmmBvstqyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381554; c=relaxed/simple;
	bh=+5eTk3CDk04yPhTVw10VH3x7l3f52TYJyRYILkkWgC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IA9kwcJBeLww+6Lio/qt0IsMMtnWt13PFqYnMFiRGwzkqynhDIjNLz7vh+IhZ2onVhrwVOmZBC6+J9IHP6uMB4TlL5qt9Th0OhNPL7oWB9Xp3/UPcTzL6njkUet9m//zHCcfjKZfWD7jwRhBhk5lfQShtNZa8ZKrFz/huxv3Row=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT+MkH9s; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so25888515e9.2;
        Wed, 19 Mar 2025 03:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742381552; x=1742986352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkfEnVzrLtFpzAFUzBpVtGSfYkdoQzRCMy1gAhvRfu0=;
        b=cT+MkH9sLhSDuyQGwBaAMQcry+YWAToe9ibchiZ/2S55PtdcsjIxpJUkN2tdCkfkAP
         U1qq20lNbWjRDurGFAIJGpouhbXiPDNFtCQEsmH6MwsNmLd7Wu8qsfgOBaFnkrFFZH1G
         nEr2ngpP66kHleFwXwkdZtNhInIYHQMs7rC1l9gQZCK+mtVgyjFBMpEWyiUjbCyErajM
         cWgyLM3wGqsogK9/2xroLzYr9/fpWcg4ZticicVkExBStAqlGA+r+ZYQUGXrPYyhaCmL
         NmWCbOl93ql8a0h48dQI8heaWlxZjs2UAiqPa19s1Up5GvtpK5nCpRFL9oM0OQmz6bBX
         sU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742381552; x=1742986352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkfEnVzrLtFpzAFUzBpVtGSfYkdoQzRCMy1gAhvRfu0=;
        b=hRo0QyFGu92Z6jIBNvjhQZox14DnvcybpMnUI9hm2nqndkl8TxUE5hsQJXZ7d/nof1
         bdCv9YR7SWCE8i7cmcZ8FfSIqlQOko1sdyu7CvKCgHvzkJbX6sgwtMreATyY0kuEhRD1
         PANe3/R7fi/DvUSWE7v7Q7n8RCi4JmhTTyuqpTatQmUs709DjNiczrN7yQEfRyFAe/UA
         rNxS70qADRqRVFBNfp1YVFdrSEZP0tZIYpdD5IVpcu0l7QxDsKQtMoBW/Xk/3LjTx4gF
         BdmUF1Fz+ZfXqx+hMgEgH54taiUp4+Ogy7FG+edR56JFynxq80GxQKjWC+0jjVLBBNDw
         R60w==
X-Forwarded-Encrypted: i=1; AJvYcCUuw/VBOqZzoI/9/w9+F0/thCWaJeBq9AepOWVLMXBCObcgEW7cCZYtdpGzxJq+LNPAXQThDEg0jpmnCP0=@vger.kernel.org, AJvYcCV4zl3TZ9JBkEGg9UEzOXjJwvf1Sc7gjDUDuTT5yG0GSFzgdnvyhw7JYC3TEzz/uhC5PQJ1n7eU+9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEdn4iSBCDV6wZgLJ1ntjmmQa2ltQD+sY3Bi3+13QB0tvPkCi0
	/yXhdN44mRD0JDsMut1cyW+KDymtRHkr5PpohW7qY2I7caa3mUU/VAJjDLNQ
X-Gm-Gg: ASbGncuMBr5b6K0ciTev1vO0Mz2AG3Apne5CficaNFBieqc7+7tNH5IFdCSsLXsBh/Z
	rqXaNvW4Ilr7hH20eDh6saNY98HzCM2B4u3qZg0/6DZkTqiZPneqaRGEd8p5hBiilWzjWOAS6Ty
	kK8OG3znD21yGE+740HWxem2LlaVEOm25cfEWD909oKv9e9LjfM7lkwuhe23Th74Kb6dAFpAgyG
	KXoKcPG+wqCQtJ9uC+8iPBSHKUu6gsacbYmLDu4WRTDxNeQX5ZPs7XdXH4shHsuL9Z/zsRtVjqH
	WRWQsD6gHR1cZXcMitzpbzTWvuywaR0LCnHAelivRXmjPw==
X-Google-Smtp-Source: AGHT+IEd9/0IBL8t/0Qgn7szi4bB58I7aKT97sS07YD26qyjHn0iSKVmrOiygpfZeBPPbAcam7oG7w==
X-Received: by 2002:a05:600c:1d85:b0:43d:cc9:b09d with SMTP id 5b1f17b1804b1-43d4384218amr20157315e9.20.1742381551448;
        Wed, 19 Mar 2025 03:52:31 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f43cbasm15017845e9.9.2025.03.19.03.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:52:31 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] power: supply: rk817: remove redundant null check on node
Date: Wed, 19 Mar 2025 10:51:53 +0000
Message-ID: <20250319105153.775155-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The pointer null is being null checked immediately after it has
been assigned at the start of the function and not changed afterwards.
The subsequent null check on node is redudant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/power/supply/rk817_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 945c7720c4ae..1251022eb052 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1088,7 +1088,7 @@ static int rk817_charger_probe(struct platform_device *pdev)
 	rk817_bat_calib_vol(charger);
 
 	pscfg.drv_data = charger;
-	pscfg.fwnode = node ? &node->fwnode : NULL;
+	pscfg.fwnode = &node->fwnode;
 
 	/*
 	 * Get sample resistor value. Note only values of 10000 or 20000
-- 
2.49.0


