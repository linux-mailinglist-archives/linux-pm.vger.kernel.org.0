Return-Path: <linux-pm+bounces-24395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA101A6BF89
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 17:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC46F3BAF01
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC9C22A7FF;
	Fri, 21 Mar 2025 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRS2Kd/2"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D341E00B4
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573784; cv=none; b=XGsi1hIe5GQ4An3QmK8Cwg0tq5QcoeszpUz0OZsux8XpOKm3lp2bsGY/w6VhfBaQODEmprzKYpRug3naWM9dUDX6T/IJv4GcRNfmC7sn7N4xvy5bU0Z2782qHK8Bk2pjQM/mq/HOVLcqL8gEmRibNXxfay4RBPpOVx/m4niAEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573784; c=relaxed/simple;
	bh=pFeQIM0elSHXudDzaZqSa3sSLY7KBkvo9aowDlPa0tY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTVus50SfwjlTYEGPOPfrxWRhysGpvFeOzWTsbHxExheFNzH2uA3LwNzfH5wPIqCB2lAlZbLAW/iw+YecEXLPkD/5pxzGNqYE6EFlBJ0kdBB/pRrmhpRjIp6OJGk1Z01kvV0NWtzE5qhQgkLkmc2aBLlC1czuuS4UGxIzQDZup0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRS2Kd/2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742573781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mC48yAiQls1tllwqU0y43QmgvHaHdh/HKhHrXStRZ/Q=;
	b=TRS2Kd/2tcXJN1gFVKY79supQq6/2shlYtetOKIGyl+Ydzw8VRHhNy2eQMK8FcMBaW7Obh
	yNHUuM6N95K90NTkQ/dhW2nibZihtI34Kuq5n5oFSlD+45aEMph5gdEbYz+ZnclDO6pj8t
	skgRFvVwBNZjAcWkNe+gUeIZxvuvuus=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-GbTTVF2kNkSAYGCvxYMA4Q-1; Fri, 21 Mar 2025 12:16:20 -0400
X-MC-Unique: GbTTVF2kNkSAYGCvxYMA4Q-1
X-Mimecast-MFC-AGG-ID: GbTTVF2kNkSAYGCvxYMA4Q_1742573779
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b5875e250so224024739f.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 09:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573779; x=1743178579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mC48yAiQls1tllwqU0y43QmgvHaHdh/HKhHrXStRZ/Q=;
        b=ctGMg/vNLxQwNXVt+crjIJ+F448zouVY6+NGll8Bg5k26+XxC/TKMGkL+Xoz1QYCyf
         VYlCRU/Jd6/8DDiC69fjOy/5gcWNbaSFJ+TXL4hMkB6vlzDKXrp+VApyAxjag6QGJi3Y
         XmNCjDSzcHUUsymItE9OMnSXuv0EsbYvMWh7lBHwgYSTIl/RiR2NzHileNEF7FZUkBxN
         u70tGI+5+Q9tLlXBzbSwiJCY368A9zJF1QEJba61+sSYyhkGLrWa6nXY0t7YfM5kg3xf
         bHZYzOdEC4AOmDLRb2OCQnnJF8pjJMJfQXmgd2w8WkR9He8pyxnIzzQEQanZTTti12SZ
         UBPA==
X-Gm-Message-State: AOJu0YzQ2Nq3SWtsqO/8uKkBK+j9DWcs2AyqKbenqtgBA1/0hvzc3oPr
	zkcOdCvfw6MTmuu4fa4Au5YS0BDqORB3arhgvMf1gHpDomZ8K7SPVScABbcU+qU07VnTcbX9o04
	p6slnk+uCySge9/TfCByoh3FBeEfghCdTR6WJdH3+41nPgV9s9Tf5i3I+
X-Gm-Gg: ASbGnctr/OKkrRdniaRN0fRMywvY6zy1Xo9EHW6C5meHgU7z0gDoKKYPlUcQ5UA1LcU
	GBRNOhQvgaNsrOqnfyxAaIkU1+W7r2LUq2j9cUkPScKT2Odc/E1pebRf7mvQFfvshWQ/V7BvPL4
	NPI9sYAEPNosyBbtWJ13LOLxgFAZTGe2k4BJRlNqSz4qnhWMHVAhjMHLoKBj5LEz5gXY0tlb65N
	aKLJ90ZCUsgwBq4TZGkr928/y/HeDu++WlUh8ojoOog56D1RI0Y+Zv/p/FWQnz9RAJpFaLqmTH7
	3SdH+sfleWmkPOMg7TQHhVizzTz+/I9k68+J/1EI0655+65IWT5X2x4B9k3kU2ci2AfWkNGyNxE
	=
X-Received: by 2002:a05:6602:4088:b0:85d:b054:6eb9 with SMTP id ca18e2360f4ac-85e2cb417c3mr499150039f.14.1742573778734;
        Fri, 21 Mar 2025 09:16:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbaQHrqE43XUvLxfY1cyZCTiEOWEjd8FXpM95Z7lNYACE/IjdXtXMvElMRWZlz02YAI2fshQ==
X-Received: by 2002:a05:6602:4088:b0:85d:b054:6eb9 with SMTP id ca18e2360f4ac-85e2cb417c3mr499145039f.14.1742573778344;
        Fri, 21 Mar 2025 09:16:18 -0700 (PDT)
Received: from rhdev.redhat.com (2603-9001-3d00-5353-0000-0000-0000-1422.inf6.spectrum.com. [2603:9001:3d00:5353::1422])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbeb565csm495653173.131.2025.03.21.09.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:16:17 -0700 (PDT)
From: Jennifer Berringer <jberring@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v5] power: reset: nvmem-reboot-mode: support smaller magic
Date: Fri, 21 Mar 2025 12:14:49 -0400
Message-ID: <20250321161449.1175473-1-jberring@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices, such as Qualcomm sa8775p, have an nvmem reboot mode cell
that is only 1 byte, which resulted in nvmem_reboot_mode_write() failing
when it attempts to write a 4-byte magic. Checking the nvmem cell size
and writing only the lower bits of the reboot mode magic is needed for
these devices.

Signed-off-by: Jennifer Berringer <jberring@redhat.com>
---
This patch depends on [1].

[1] https://lore.kernel.org/all/20250318094716.3053546-5-o.rempel@pengutronix.de/

Changes v5:
- Switch to using nvmem_cell_get_size() from the above linked patch
  instead of introducing another function with the same purpose.
---
 drivers/power/reset/nvmem-reboot-mode.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index 41530b70cfc4..6be178be4a58 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -20,11 +20,23 @@ static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
 				    unsigned int magic)
 {
 	int ret;
+	u8 *magic_ptr = (u8 *) &magic;
+	size_t cell_size;
 	struct nvmem_reboot_mode *nvmem_rbm;
 
 	nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
 
-	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
+	ret = nvmem_cell_get_size(nvmem_rbm->cell, &cell_size, NULL);
+	if (ret < 0) {
+		dev_err(reboot->dev, "failed to get reboot mode nvmem cell size\n");
+		return ret;
+	}
+
+	/* Use magic's low-order bytes when writing to a smaller cell. */
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) && cell_size < sizeof(magic))
+		magic_ptr += sizeof(magic) - cell_size;
+
+	ret = nvmem_cell_write(nvmem_rbm->cell, magic_ptr, MIN(cell_size, sizeof(magic)));
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
-- 
2.48.1


