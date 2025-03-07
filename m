Return-Path: <linux-pm+bounces-23609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A83A56205
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 08:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D390E7A875B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 07:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816151AA1EC;
	Fri,  7 Mar 2025 07:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYvq0+LU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD01A3168
	for <linux-pm@vger.kernel.org>; Fri,  7 Mar 2025 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741333823; cv=none; b=jFDX+20uZFm4l/RixcRN3WKgtt/21ovd+pbbHkHMROo+SEzZKonr166Ev0YZTMSCrdCVjATnf6Lgble76IHrq7lUB3vvF1hnId9xU1O2OHBc/ClKDCuHo8oh4nm7O3qmm8QKFOMv5tI3bHiCxSR2cgEKqm7D5xRoBnv5wx6ZIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741333823; c=relaxed/simple;
	bh=bqH27dhm4vqCW2KMETRfbzKIt9nb2UJ9bHwplDfeGC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fqhqyNy6hG4q6gT8YtpR1B2BRWsxSSHr/n/eAP47TsDPf5WUE0Jx3UGFRmMo04y1U+BP0tKSs5bywVvbxqLqkusB3c8JV65B8pxZzz1btJpG6ZDj59U36fcLVwjfJvC9zUsG9fENeRQUNjDo7KKU0x/ABjFlIADeMcDAB/YNjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QYvq0+LU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so2287507a12.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Mar 2025 23:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741333820; x=1741938620; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zfctkjh729cDVPkdN9atc8gq/aSrxKUuXnRIylg+etw=;
        b=QYvq0+LUYtGaowqmWUKGU/PorqKBuQ8FMqyEF+ZXfW3s9dXwYO+ZbqJE70zIQLS4G8
         x6a94RRKWTJnTDWZA4rQ7ZaUQaDLJ6PhdYoLJWeQZGxUQvWvXbJIlxJFumJj9gjCTPIb
         6vX94fDLoC9bm0Bkw32EIUnzNRmmpeDPH7wJ7XNrL7HevfW5zswsha0gi3VoL0yFB4Gs
         Jq1fhrZe7IWnxU8bAMIZabIlfZT+AHqgcv1T3qM+0M0OU+Lh6ZPNuhitvku90kn9Oj/i
         fl3xXs+b9CGc+b5unLvoai7EeFcSoTDbT4jn8Ye/vNvj/heSQy+4esbaMTCQrNVBMkRf
         vWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741333820; x=1741938620;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zfctkjh729cDVPkdN9atc8gq/aSrxKUuXnRIylg+etw=;
        b=Oat9B4ZkiqgTWGq/gAFd/Ql3jpaQIVCAWBpfQssZKfh1LglO221pTvIRC6qY3KmB8q
         Y4hj0aajRG8HAX0Hu0lllwgIIHcEdvmNw4Xgcl5eAS4E9JxdST9MuAHTGFVCvX2NwA0y
         ZDV1y/5fiL4fdmRQn9NDCMqTlAI1+dDFXZcnvKpX62QzLUXiQOE3ZlapkIZHY/buX5lD
         ld0SIJ1vZ//uHJAeax5Se4RIzzpReYuCiphHpiDtC58YxCQn0oUQsLGLlnm/2+WEgPdH
         mggZ72xWwN6x8DP3TqmUmeK8vMsfW7kN9NufxbUCRk3R1E/y3DOZAPs8z2eg/Jlv+Ku2
         VG+w==
X-Forwarded-Encrypted: i=1; AJvYcCX/dO/ciQtxUPNvoG4If+Wcexy1k42Rd/mSgPMHOyDbzms7Nu5S+hpe0r+dxRxVF1eufrhs/J5YBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yywr5TYfuOlDG5e4PW6g742QAFWj4/ZMnYBYIUsTPV/M0z+4hBm
	KKr48XYV5RkSzv/EVcbzDQnqKduZkT20wUKW/j+GDa4IP+OBo3PfGGxyvawzFAc=
X-Gm-Gg: ASbGncvtn391HXGtRlQD8fcwqAr9wN797Jle07Y2Fcs2YtYXXPtr9yZ8O49dEXdTT+z
	wER4yQB+fHWgo0pGXN5zB2b1aZJTjNmEGyewi7Rg773R/IaVS13txnnCqw16WjXTu56q2fVbFjX
	tePzNwBU/jA5KfeigH4ScA/gpYGGCDDPP75zKBAjt68NjIVbT8/Vqp+3QX0P8ajY/Zbr+Yy/p6H
	TZk7csHkr6M+BUj3KBOmy6byOHqBxT+zPWc71uPqdYuYar4L/lHdDdKBDZZR4OOlzLRRWP/OQ8o
	w4iOIk6qu2kN0Dzs2A7BTY8kf5EBtOwHuOOAbSISArhkdozda80XbbHE2X5bpUtBKpua1YX+mc6
	AvFX+k3Z+YgjSGIrA/UR0xczl/6fD
X-Google-Smtp-Source: AGHT+IHSTYkSFpMW1RFfKaWXb1ATMwztSGSZ5Ez0LczLYAG6rFexYL/a+DB0sXugidVUGNZyN8XuBw==
X-Received: by 2002:a17:907:9705:b0:abf:7026:13a2 with SMTP id a640c23a62f3a-ac252a9e2fdmr207923666b.17.1741333819756;
        Thu, 06 Mar 2025 23:50:19 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239483a18sm228224166b.43.2025.03.06.23.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 23:50:19 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 07 Mar 2025 07:50:18 +0000
Subject: [PATCH] power: reset: reboot-mode: better compatibility with DT
 (replace ' ,/')
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250307-reboot-mode-chars-v1-1-d83ff95da524@linaro.org>
X-B4-Tracking: v=1; b=H4sIADmlymcC/x2MzQ5AMBAGX0X2bJMq4udVxAH9sAcqWxGJeHeN4
 yQz81CACgK1yUOKS4L4PUKWJjStw76AxUUma2xpclOxYvT+5M07cDQ0sG0KoGisq5FR7A7FLPf
 /7Pr3/QAg3/T6YwAAAA==
X-Change-ID: 20250307-reboot-mode-chars-294ee492d8e1
To: Sebastian Reichel <sre@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

This driver's purpose is to parse boot modes described in DT, via key
(node name) / value pairs, and to match them to a reboot mode requested
by the kernel. Unfortunately, DT node names can not contain certain
characters, like space ' ' or comma ',' or slash '/', while the
requested reboot mode may.

This is a problem because it makes it impossible to match reboot modes
containing any of those characters.

For example, this makes it impossible to communicate DM verity errors
to the boot loader - DM verity errors trigger a reboot with mode
"dm-verity device corrupted" in drivers/md/dm-verity-target.c and
devices typically have to take action in that case [1]. Changing this
string itself is not feasible, see e.g. discussion in [2], but would
also just cover this one case.

Another example is Android, which may use comma in the reboot mode
string, e.g. as "shutdown,thermal" in [3].

The kernel also shouldn't prescribe what characters are allowed inside
the boot mode string for a user to set. It hasn't done this so far, and
introducing such a restriction would be an interface break and
arbitrarily enforce a random new policy.

Therefore, update this driver to do another round of string matching,
after replacing the common characters mentioned above with dash '-', if
a match hasn't been found without doing said replacement.
This now allows us to have DT entries of e.g.:

    mode-dm-verity-device-corrupted = <...>

and so on.

Link: https://cs.android.com/android/kernel/superproject/+/android14-gs-pixel-6.1:private/google-modules/power/reset/exynos-gs101-reboot.c;l=144 [1]
Link: https://lore.kernel.org/all/CAAFS_9FuSb7PZwQ2itUh_H7ZdhvAEiiX7fhxJ4kmmv9JCaHmkA@mail.gmail.com/ [2]
Link: https://cs.android.com/android/platform/superproject/main/+/main:system/core/init/reboot_utils.cpp;drc=79ad1e2e9bf1628c141c8cd2fbb4f3df61a6ba75;l=122 [3]
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/reset/reboot-mode.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index b4076b10b89376a71ff6f6c3ba807b20e673de86..fba53f638da04655e756b5f8b7d2d666d1379535 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -23,20 +23,29 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 					  const char *cmd)
 {
 	const char *normal = "normal";
-	int magic = 0;
 	struct mode_info *info;
+	char cmd_[110];
 
 	if (!cmd)
 		cmd = normal;
 
-	list_for_each_entry(info, &reboot->head, list) {
-		if (!strcmp(info->mode, cmd)) {
-			magic = info->magic;
-			break;
-		}
-	}
+	list_for_each_entry(info, &reboot->head, list)
+		if (!strcmp(info->mode, cmd))
+			return info->magic;
+
+	/* try to match again, replacing characters impossible in DT */
+	if (strscpy(cmd_, cmd, sizeof(cmd_)) == -E2BIG)
+		return 0;
 
-	return magic;
+	strreplace(cmd_, ' ', '-');
+	strreplace(cmd_, ',', '-');
+	strreplace(cmd_, '/', '-');
+
+	list_for_each_entry(info, &reboot->head, list)
+		if (!strcmp(info->mode, cmd_))
+			return info->magic;
+
+	return 0;
 }
 
 static int reboot_mode_notify(struct notifier_block *this,

---
base-commit: 0226d0ce98a477937ed295fb7df4cc30b46fc304
change-id: 20250307-reboot-mode-chars-294ee492d8e1

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


