Return-Path: <linux-pm+bounces-1241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9738158DE
	for <lists+linux-pm@lfdr.de>; Sat, 16 Dec 2023 12:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6406E1F21FD0
	for <lists+linux-pm@lfdr.de>; Sat, 16 Dec 2023 11:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DCE14A97;
	Sat, 16 Dec 2023 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3Sg+LYa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4095E15E80
	for <linux-pm@vger.kernel.org>; Sat, 16 Dec 2023 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a1e2f34467aso123644666b.2
        for <linux-pm@vger.kernel.org>; Sat, 16 Dec 2023 03:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702727854; x=1703332654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sasmTE3kn4ottVMB01j7/uruXUS+ZP27vW8db5V0zpc=;
        b=S3Sg+LYaMIUS496jsVeG7ZdrRD8Kf6vUdxJA5QWBdIkT1ukDYhn8c+aDlSHKfee0VF
         /dr222su9eWkD4mjg5M6dn8mk46JFAlG6963drajsw4v0ckXJfPYRcsACuCbENDo/ya/
         ehkGPpfdyAS7hif+x0N3nUT4he6JrSWcawe8a+DFztnyKyzMV4eUlq0+nVB2PDOJLAZl
         CB9YSiDjDCU83XBhEbKs3GyrJMyYmBH0legeq0mBYW6kmlF9qGzAM6s7l1dUNq1F3Rcf
         pWpKruIXsooeAmW0roQS7OVSca8hSuqKb02CouDCmG7NfGoPffczSEBvUjdzddxDTeuu
         uQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702727854; x=1703332654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sasmTE3kn4ottVMB01j7/uruXUS+ZP27vW8db5V0zpc=;
        b=U6ivlIPBbgCTHotkUnvDF7/qQ9/QYQsqoAXl2qCNppHYmS+1U0u6n9VnRveMTRmUG1
         s+jCjB9mwDEMPT/KgRlTwpqcosSjfuuIfovdw2cGoxYrGD9PLoReQsEXWS/aXOEbO2Q8
         BlQi+YHflCXeUur3MIzM3G7Vpe7CUmGAX2WVAWO/yRihygGf3CdvIGJNxLsfJEa6zU8z
         /402JTfCjgCiWzMlJULKjAGahz7QWF2CMnHKs2TxwCKPLY1fZmodswaXxG4w2TD7kwS8
         Jo5smjs9dpo/NjRCRJQaJ83Ki8tDDlQwlfAP7nsLRwg/gUpPOqnWQbfFBfs3hFI/od6P
         2bYQ==
X-Gm-Message-State: AOJu0YxaRNBSNwvcVGsczKFpj4Zwv7QI5J1HnqW5qIWNGtWoE2tf6BXI
	eiq6RlWYC6UR8W+dRIb3Piw=
X-Google-Smtp-Source: AGHT+IHkWNtBEfMdX0PJDRnaW0ZYCZLEPw+7mXrxjlk0MJeKsgVnlWpdkf/mD5BRRMhEn890wwRxMQ==
X-Received: by 2002:a17:906:d6:b0:a1f:a0f1:ec60 with SMTP id 22-20020a17090600d600b00a1fa0f1ec60mr6918767eji.14.1702727854290;
        Sat, 16 Dec 2023 03:57:34 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id tx6-20020a1709078e8600b00a1fabca52f5sm8045910ejc.154.2023.12.16.03.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 03:57:34 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org
Subject: [PATCH] PM: Remove the mention of freezer_count() in comment
Date: Sat, 16 Dec 2023 19:57:17 +0800
Message-Id: <20231216115717.2285930-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The freezer_count() has been removed by commit f5d39b020809
("freezer,sched: Rewrite core freezer logic").

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 kernel/power/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index f6425ae3e8b0..768c07155d53 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -61,8 +61,7 @@ EXPORT_SYMBOL_GPL(lock_system_sleep);
 void unlock_system_sleep(unsigned int flags)
 {
 	/*
-	 * Don't use freezer_count() because we don't want the call to
-	 * try_to_freeze() here.
+	 * Don't call try_to_freeze() here.
 	 *
 	 * Reason:
 	 * Fundamentally, we just don't need it, because freezing condition
-- 
2.39.2


