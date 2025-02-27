Return-Path: <linux-pm+bounces-23137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD889A48BDA
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 23:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F331892324
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 22:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949DC26FA79;
	Thu, 27 Feb 2025 22:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXWwAvvQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71A623E33B;
	Thu, 27 Feb 2025 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696046; cv=none; b=dnRb6yYGNuMufJFM6c7ieF79nhVSfjjV/gRL71rCKV7c9UN6Q1vDdDp5L/xRNj7+lnMo+xbamTsM3JiQhaLHJVPdtwSoPzSJpu3Al1zY+s4BpQ6DCq5w1pPOYFXOjXQN1fxIxxLV9Ba4MHhmtyvrdiEdbailrDxKLVqo/7Agj1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696046; c=relaxed/simple;
	bh=4FpztWJBkYzLbgpzrZ8kFBwYl/EaKs00lCTCkSKF1yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c2V7rmJ5gNk1Q2M06eLw2M1e7/5LZ8GEbgKqUFPHW6hNK48lB8EdaKZvEozIe6XQiCSxMiVRPZYtCyHZwZzIqaKRTl79jpPKjSduoDwVCISMtM9FSiuSWbwDKnLZMfGhzuxWWxSm8Mg70IGAwnOl1uK+HGtE5rZvcMDEvcZPvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXWwAvvQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43989226283so10125625e9.1;
        Thu, 27 Feb 2025 14:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740696042; x=1741300842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NUl8XE7+Pcoi1nYpApiKySL0TeiutYm0CffFrTI9E/A=;
        b=BXWwAvvQrGvMIef/3qMddsNW150v0BgZDKGR3V58PnlwZ8qGXKKq5y4AykkoDUaiGb
         mxMysUJ1IxsBBeXVHnyhsFzV8sE0c7xZVRicB0HFWYCfLmr84qzXL3O+sULnzoXDvMh5
         0HX1C+8uDzDEMRIairmeY9mzWU/BVnUXp74o0A6XrpItd5nsGjcbOry0/pdja+uwNTCu
         aadFOuZaa6ot99SCEXjq2oqa/eNmkvq2LYXyh9ViV8cvUZ5HO7Q2VnoPUeOJh2aL177n
         +n5rQHHaJmKT4813y6Ypah0mt2WSB2s9jIrp6XnhZ6VbLTo4vvqmrJQbanDI77rppFWY
         pO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740696042; x=1741300842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUl8XE7+Pcoi1nYpApiKySL0TeiutYm0CffFrTI9E/A=;
        b=JVf7y4Tsdeesj/gvHacFJUxv6VET7woB+t8iN/nZFYhPqAcQEcRYC190H1clfKi7gE
         JYLNW6Z7c3Ay0o4nY+LhP/1crynjSasotCyCVThgrVzK2gQwaBBm+jFuLfDLMJDZN+vc
         PzH/1ntLp68T826rxA11joRsSZabmChFGifjzV++yZL2j4fKy35n81vAqvM5nQUs+4S0
         pwDGT9et7i/zBy/heskDHoapN5pknY4RQhLCs6857WNGteSuhwv61iFu8tPPydBx1KnZ
         GFat0zes+KN38hvZRXSY1gTosWKvqujflSUJDOTkkB6+BMtbOE062RrYSdqsfEX9soQn
         QRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0OPGAQnJthISaNo79g0ovTOo5IyqmEbualGJK+A/dQKfBbq0J3Zu3ZhvGuTMGcAtCPPfSa6Au3uikVV0=@vger.kernel.org, AJvYcCWSoZk/X9OtmPbK/ksnwk65plNTq4WWlJ0eqYbi9Jb+ajlcMg0E1QXwSLkuq0HGQPP4/StPkrsPSF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyRALnDWBT19Gk1vibt6mgsDXA9eIInAAzjSX/Y1t2fnF/WL1m
	Pai45HWy4ewGV9pTOZ4m+CaCK8aou1WzZBvWjnlpiBwMtxoGc8/S
X-Gm-Gg: ASbGncs54W1HRNL4GSZSR+JMSIYKmBUHs792IKxQv4tdsX6HmJLKkJRJ+Qhp5ZW/zPN
	IV0sapIVdD34GVaP+YgA8fDepbCW6FIwLKsCxl0EeYpadxnqsAT0+da3ZGPi+NoYd8RDjnUtNTs
	GLoC+ON+Xn784p3jQqPlFO9iWamVv6NgkRp5Pu/c5535vfpOqMk7Caerq+gIB7xh0tjztnljz6v
	GgWa5zsO4JdZb+kTIqhXPbA0LOJhVsEPqf73Jkmbsb7GOwikUJwnoCDfHVnxPOG4DKf8bthbent
	35sSQ9pveBXPk9xQm0Xh/BiUnQo=
X-Google-Smtp-Source: AGHT+IHM6HEvjXh4zM4c1gmC8eykfelcPVykYPxPWzXLli1VTTBj6qkEd/hrQ+pc2XQ0Fu0UniZbLg==
X-Received: by 2002:a05:6000:18a7:b0:38f:31fe:6d23 with SMTP id ffacd0b85a97d-390ec7d25edmr844668f8f.23.1740696041892;
        Thu, 27 Feb 2025 14:40:41 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e484451fsm3340895f8f.63.2025.02.27.14.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:40:41 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] thermal: core: Fix spelling mistake "Occurences" -> "Occurrences"
Date: Thu, 27 Feb 2025 22:40:06 +0000
Message-ID: <20250227224006.660164-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a seq_puts string. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/thermal/thermal_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
index c800504c3cfe..0cf26ea63370 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -319,7 +319,7 @@ static int cdev_tt_seq_show(struct seq_file *s, void *v)
 	int i = *(loff_t *)v;
 
 	if (!i)
-		seq_puts(s, "Transition\tOccurences\n");
+		seq_puts(s, "Transition\tOccurrences\n");
 
 	list_for_each_entry(entry, &transitions[i], node) {
 		/*
-- 
2.47.2


