Return-Path: <linux-pm+bounces-17751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A999D24B2
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 12:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5726B22396
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 11:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD0F1C3302;
	Tue, 19 Nov 2024 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OueN2wXK"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432E61B0F2C
	for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015170; cv=none; b=jU4yrg8Q/J5l2YWlFjIQwfmubgulwiorOZ9WV58jm5OqDpoGzuUfnFQgJR5N0YwT7s8iqiYhVzk2VoxxY4F3kh8/dOkg8JAaM2O3EtJtfnoouKyIUZtjQ7OrpPbKpM1e+HZ1hccrk2tET1GL/yzrLIN7r6XUJnMfG9RmoxWTAvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015170; c=relaxed/simple;
	bh=FTk3to+APvZ2K4SiX8JXEK+u/kjewSu/nPStFnJMHcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hDrCgjGw4ToVvJys1JscuTJEPCaQFSKoHS06AfLpGiHep3wagfhToK5AdRUgcRunYXaHAPDzarLIiq/NvMFbL0THdeR8bIykH9QFqVa2ZBnn+RB27lfrg+9Lgr3vJAdr8NDn8wkIi4HJyxDCIZh2B9nDfdgIbs4HbSLCdOMeOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OueN2wXK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732015167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/bbQUZ4g/AMfEyINJryBtDXPUexxWYGnnHWUD7zB68U=;
	b=OueN2wXKTLFfmVZOcoesfeTfcbczOuK9yzTpEQCiHihvrPlYutaT8CS+CbUojrZaO+S9SJ
	BLg79E27Of8vmthgPuFupk2uOjSCQ6dwxHx4vZru0pTp8MLO6NqOq7deKma4jH70e5cpGp
	W7l7NqGyFOScilDX53yF6fq6DUwSFw8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-bDYnHzlgMze-oT_q5qs2tw-1; Tue, 19 Nov 2024 06:19:25 -0500
X-MC-Unique: bDYnHzlgMze-oT_q5qs2tw-1
X-Mimecast-MFC-AGG-ID: bDYnHzlgMze-oT_q5qs2tw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-432d9b8503cso27823485e9.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 03:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732015164; x=1732619964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bbQUZ4g/AMfEyINJryBtDXPUexxWYGnnHWUD7zB68U=;
        b=R44pQDTcxjOWYUpjJvim0EKzRltgT2idWGWA0BDGtN8T2TjiNsPKlzuhGn7WYT59bk
         I1IYDLjkRY8zVp5X2523c/imq6uWS+PeLvy+f8qIZx7v+ViouTS0P2SJjSzTwxEqLvVv
         spJv/AgEippDr0B8YIEYXBrP3LO3eaeioNtRt25Kn7ut8W7q0WAAEF5O3/RkCJyye2tY
         9VSX988sPsIBRBpgB9yDODFrYtf0KQU/Et2vE/V7ZvOggSc7MEB5CUss3VoDVZmYVvAK
         7NyZ83zeTeYmBEFenab2A9nc0M1fJfsoVbR38GmP2gkN1MAxO+cw6qLghlEMlCtoIHiT
         FePQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOPyGawwOEH/RYfuDkg9qxIuamn3c0YDoaYljxu94BAguXo1dV4gTvjRGX4TKq/wvTYnvFcGDu8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQI+6WvsvW7LoVEdU0ZRDHd39A9NBunm79l2kEw/XWDj2MJCS
	q6uVdgo9oFFD/oUQxV4FwnecyN+GZD4sWVHs88b0SeB7JhG65Ow24v2sex03Zuk/BPWv+okirgV
	UVY06Ki9kaEdpBpmH6E/ORslaSGZwmQh490ahENpDXGLu9F1ENypVpWB7
X-Received: by 2002:a05:600c:1e23:b0:431:7c25:8600 with SMTP id 5b1f17b1804b1-432f579dfa1mr21216415e9.2.1732015164602;
        Tue, 19 Nov 2024 03:19:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnO+P6Y3L3RleitGgCW2feaObroQXDR14baW5GwWQWlh1l+rapLy0YUc43rfD7/yjVZP99aw==
X-Received: by 2002:a05:600c:1e23:b0:431:7c25:8600 with SMTP id 5b1f17b1804b1-432f579dfa1mr21216255e9.2.1732015164295;
        Tue, 19 Nov 2024 03:19:24 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2982fasm196865525e9.36.2024.11.19.03.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:19:24 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Radu Rendec <rrendec@redhat.com>,
	Zhipeng Wang <zhipeng.wang_1@nxp.com>,
	Maxime Ripard <mripard@kernel.org>,
	javier@dowhile0.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH] cpufreq: dt-platdev: Fix module autoloading
Date: Tue, 19 Nov 2024 12:18:22 +0100
Message-ID: <20241119111918.1732531-1-javierm@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver can be built as a module since commit 3b062a086984 ("cpufreq:
dt-platdev: Support building as module"), but unfortunately this caused
a regression because the cputfreq-dt-platdev.ko module does not autoload.

Usually, this is solved by just using the MODULE_DEVICE_TABLE() macro to
export all the device IDs as module aliases. But this driver is special
due how matches with devices and decides what platform supports.

There are two of_device_id lists, an allow list that are for CPU devices
that always match and a deny list that's for devices that must not match.

The driver registers a cpufreq-dt platform device for all the CPU device
nodes that either are in the allow list or contain an operating-points-v2
property and are not in the deny list.

For the former just add a MODULE_DEVICE_TABLE(), and for the latter add a
module alias. That way the driver would always be autoloaded when needed.

Reported-by: Radu Rendec <rrendec@redhat.com>
Fixes: 3b062a086984 ("cpufreq: dt-platdev: Support building as module")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
Posting as an RFC because I don't have a platform that uses this driver
but I'll let Radu test since he reported by issue.

 drivers/cpufreq/cpufreq-dt-platdev.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 2a3e8bd317c9..7ae7c897c249 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -97,6 +97,7 @@ static const struct of_device_id allowlist[] __initconst = {
 
 	{ }
 };
+MODULE_DEVICE_TABLE(of, allowlist);
 
 /*
  * Machines for which the cpufreq device is *not* created, mostly used for
@@ -236,4 +237,16 @@ static int __init cpufreq_dt_platdev_init(void)
 }
 core_initcall(cpufreq_dt_platdev_init);
 MODULE_DESCRIPTION("Generic DT based cpufreq platdev driver");
+/*
+ * The module alias is needed because the driver automatically registers a
+ * platform device for any CPU device node that has an operating-points-v2
+ * property and is not in the block list.
+ *
+ * For this reason the MODULE_DEVICE_TABLE() macro can only export aliases
+ * of the devices in the allow list, which means that the driver will not
+ * autoload for devices whose cpufreq-dt will be registered automatically.
+ *
+ * Adding an "of:N*T*Coperating-points-v2" alias is a workaround for this.
+ */
+MODULE_ALIAS("of:N*T*Coperating-points-v2");
 MODULE_LICENSE("GPL");
-- 
2.47.0


