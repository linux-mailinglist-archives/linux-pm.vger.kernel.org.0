Return-Path: <linux-pm+bounces-14131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57192977C46
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 11:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA44F1F27EB8
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BEC1D6C6B;
	Fri, 13 Sep 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADHNJSSe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EEF175D45;
	Fri, 13 Sep 2024 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220261; cv=none; b=YHYObShzlpergT6N0RSbJ9RE0q8LunxqMGxi4BbF3fOAdfFrVC59N43j/iDVbDrix1eevFsa26dWmeREOECEIxGeWIS7YFixrCH6bFmidkaTBTlwLqmdmOvC9fasRwi87rx9F+Cp2bf48IU5ubAqp/CCv15liPzWSRJvqRXvUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220261; c=relaxed/simple;
	bh=Muc8CTJ6tUBeBmqYfUSLjI05P6c+7aACxxpXBvHZK3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RiC/IVXBmEhQdW1kiFkioDWvRgOvPUXgP0vcRKI8oQAozpzhcK1LW0orWB455mQEIWapoTJ3XE5wghND6eEtzB8xY4GgzXMrGxa4RAWpV20+x/16+UBw4ghzjk0pPxux8d1wrVlroIC/mqcBK7G9it8MkL+89gyptpo4eTB48dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADHNJSSe; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53661ac5ba1so2068562e87.2;
        Fri, 13 Sep 2024 02:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726220257; x=1726825057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=poNRBe+GqBqtFV5yIuKftcM+UDfFRe/cSM7MSFErS7k=;
        b=ADHNJSSeKzR8q5Xokl7KOsGHY9bEXVEC6Lfhm+zhflJscS8OUZyzPguvvCw2hnCPAD
         YFB1pBIccoqbbchh5J8YAyouV7JCZ3t3I2Pf63B9HXMPv2FCbQyaBp+YUvYgQmqOmyZ5
         EHmx5lbz54QDxtiJ6aUNMkW6Yu3BUvbnFLdmHBPXW0/Tsv22mDfOVtWkoezPvihyWQFj
         x27aivG6KXcJh0hZPDtcgC42z9Nve5jzW8a5Ma/8W55nZmL9Z5GrqY3/5nPdkQl6rURb
         AEx42KlEWt0vBIcS95q00JHgufvs4QFNdJdFgBV1eRL9LQRFTBAE3q5DI1ZtTSfe/XYk
         2l+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726220257; x=1726825057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poNRBe+GqBqtFV5yIuKftcM+UDfFRe/cSM7MSFErS7k=;
        b=hkVG2bxZQTMGUDhfFh2qIGEXcfJMv+ZOR14h+D+R/HTAOBEwU0+miLZHM874G5Njpe
         e1R2Te+ZHX2+Uk8gMNFyU9JC2+qh8hK+Q5n6jiPK6wIYUNrPAZiodF4t4PJTXCTW38mX
         gZKB48NKtjU0WLxRnzJGmsnx6ZepKhI0c0zh3VxfAMbbiDrCXj5mIKUoQ0IUfJ2/tucK
         7Zb7BLL1c+EHuKK9o7+3ggVhmvLnRut6ewY7b0GEu5/W/qtEoHhsoUuC2xVzQW+Q2w0X
         xdG4qUP1Vo0/RuZ1/T6XcY0fSt2iLN6By2TEio8TQ0pN7qix97qm+hk6zdL4+Zd+hhFA
         Rz6w==
X-Forwarded-Encrypted: i=1; AJvYcCVGID/F7GcvfiBgaXKsdk6Oqhwt55dD7rFvjZkm2D+Dav6yr2HVpiccEopn1TiXXXASjbxv8alAkL0y0Yo3zkM=@vger.kernel.org, AJvYcCWpwg5cDsh1hGC7hecahiQV0GnkICojpIIaCJnH0F3gp+e4MvfYtzS6H/BLQj+T6eFhX/H/kn58+7F9og==@vger.kernel.org, AJvYcCX/uqkMhVpnZxWx6B7ogAf/astLx5Oao6+vRz2uvutwREHO+vON9Px0Hdn3t2Jj6Rpx+s79ruNsyuVQ33q0@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqlXtUfBth+JipXHqfh5NSQ6wQzmfRolr8et9ll2ZWTn6ce3d
	ls+7w6vXyFOMonm1RFeRynp3Pqy5V3X0Vq6TAGeEIB0AC3cLUXJ8
X-Google-Smtp-Source: AGHT+IHPJDR3vrgdy7/5HudOfik7GjSbGIw/RQHKxVrRjeXrJNFMhS6eIKZWgtPsUyW4DKS7qLG5Ow==
X-Received: by 2002:a05:6512:230b:b0:535:6d34:5cd7 with SMTP id 2adb3069b0e04-53678fb2001mr3195481e87.11.1726220257027;
        Fri, 13 Sep 2024 02:37:37 -0700 (PDT)
Received: from void.void ([141.226.9.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a340sm16347128f8f.24.2024.09.13.02.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:37:36 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Eduardo Valentin <edubezval@gmail.com>,
	Keerthy <j-keerthy@ti.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] thermal/ti-soc-thermal: Fix typos
Date: Fri, 13 Sep 2024 12:37:05 +0300
Message-ID: <20240913093713.12376-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h   | 4 ++--
 drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h | 8 ++++----
 drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
index d1b5b699cf23..1402b8c44c6b 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
@@ -74,7 +74,7 @@
 /**
  * Register bitfields for DRA752
  *
- * All the macros bellow define the required bits for
+ * All the macros below define the required bits for
  * controlling temperature on DRA752. Bit defines are
  * grouped by register.
  */
@@ -125,7 +125,7 @@
 /**
  * Temperature limits and thresholds for DRA752
  *
- * All the macros bellow are definitions for handling the
+ * All the macros below are definitions for handling the
  * ADC conversions and representation of temperature limits
  * and thresholds for DRA752. Definitions are grouped
  * by temperature domain.
diff --git a/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
index c63f439e01d6..3963f1badfc9 100644
--- a/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
@@ -32,7 +32,7 @@
 /**
  * Register and bit definitions for OMAP4430
  *
- * All the macros bellow define the required bits for
+ * All the macros below define the required bits for
  * controlling temperature on OMAP4430. Bit defines are
  * grouped by register.
  */
@@ -48,7 +48,7 @@
 /**
  * Temperature limits and thresholds for OMAP4430
  *
- * All the macros bellow are definitions for handling the
+ * All the macros below are definitions for handling the
  * ADC conversions and representation of temperature limits
  * and thresholds for OMAP4430.
  */
@@ -102,7 +102,7 @@
 /**
  * Register bitfields for OMAP4460
  *
- * All the macros bellow define the required bits for
+ * All the macros below define the required bits for
  * controlling temperature on OMAP4460. Bit defines are
  * grouped by register.
  */
@@ -135,7 +135,7 @@
 /**
  * Temperature limits and thresholds for OMAP4460
  *
- * All the macros bellow are definitions for handling the
+ * All the macros below are definitions for handling the
  * ADC conversions and representation of temperature limits
  * and thresholds for OMAP4460.
  */
diff --git a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
index 3880e667ea96..b70084b8013a 100644
--- a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
@@ -56,7 +56,7 @@
 /**
  * Register bitfields for OMAP5430
  *
- * All the macros bellow define the required bits for
+ * All the macros below define the required bits for
  * controlling temperature on OMAP5430. Bit defines are
  * grouped by register.
  */
@@ -101,7 +101,7 @@
 /**
  * Temperature limits and thresholds for OMAP5430
  *
- * All the macros bellow are definitions for handling the
+ * All the macros below are definitions for handling the
  * ADC conversions and representation of temperature limits
  * and thresholds for OMAP5430. Definitions are grouped
  * by temperature domain.
-- 
2.46.0


