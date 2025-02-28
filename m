Return-Path: <linux-pm+bounces-23187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6696CA4A112
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 19:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D603AC4E3
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B428426F444;
	Fri, 28 Feb 2025 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxJuChTO"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A5C1F0994
	for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2025 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765894; cv=none; b=HqHvCnTfFXHbbAYxotAwMvS/ZAP6TOI0aKsKQ2k8Oo3pWUd38VcaGrY/62Wy9xvcg96231fO7mkBAkuMvvZES9RmDesSOkabZd6B+Lns3rLrliQZGKj/M4t8MlkV1HafrkZ7ezxd3Ci03MggjNH9FvD0VkZgS5cl7AY7QkJ3dAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765894; c=relaxed/simple;
	bh=p5YNSl+tACPhKTbX5xBy7X2QQnkmsEDw2DUatYNaNT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVadKGmEBzAT4updzn/8M0RCId5tuk3eMv7p26iqQ7RJOWVZ/lXY4KwrOM1ToQlPPH1mA+dWIV2lMiQ+LSQdzUQVvT4/lx5P4zTCI/Bsjiv6osFkozCUEIQH/AVXu+ElQzcmK7T3DaZ3It+2ps2Z/djXVt1d+66OPBrX9eP+QJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxJuChTO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740765892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGAryNfhIHltDXBhImLJg9FkqIv+XeRGH9VzW685p/w=;
	b=HxJuChTOrgWrGB99PcTwZ0DsB1jjAiz129YOJ/eAy5iToHB/F+dCxG1rnLEpMP6xjxnlYL
	e1+gIeKGzOBxIsDuj/AP43aPzAy9qOkVUF7C6ubtLUC3e4ob0Ky7zPNQDNIsDDwWyt9JiC
	BA3ASyjdCyCwuNLMlR+d1Y/REp0Rjkk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-I4amUMQdPP2Gz7kOALm5Rw-1; Fri, 28 Feb 2025 13:04:50 -0500
X-MC-Unique: I4amUMQdPP2Gz7kOALm5Rw-1
X-Mimecast-MFC-AGG-ID: I4amUMQdPP2Gz7kOALm5Rw_1740765890
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c0c1025adbso541097985a.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2025 10:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765890; x=1741370690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGAryNfhIHltDXBhImLJg9FkqIv+XeRGH9VzW685p/w=;
        b=vNupE+MHMmOy0PPayxEi1nfW0bXbJcQXF3gGc0enAsAg4iIQAwUATOVJF7IPMIwZK1
         B+ouUxRWh4fwPXZQ/Oz4MP8YWEcULdlqiZdvGqnKVeF1ReJbqwG1CWpZiWBfUc8xvtCD
         RcPHCTB0BC/Wtv6D+TNe8paYGzUichNPrsGRrjDGg9rCIfU8n6JcgST2QloroJbxBAex
         vkcxppWW4zhwqET3/nZnJ5SWnDhrDVVVxm+snlEeT7ehhbp48u7pOzSTak4usTDxTDyV
         CMXcxk1iXvp4Zr746exf92UBD36b50w2HliYz5ACSicV1KSFRBAyKaFY58VGhXbDDQ0t
         ts/g==
X-Forwarded-Encrypted: i=1; AJvYcCUVnfFAOEE9glVrWA/tMMCb27U0yAEzl0DinugSWbR962Yyz3H0NRcFnvIWJW6EYw2Y6FvnJ96cdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWk4fguy+uUa676uv9cW/aY9O6XItVVyOU3bADh2/k1PrP8UxI
	tSNv0A8D4QOmGarN7DwhjS2bm8YrLfXpuAnFN0WF4Q///5arMJQ+jYaRKSOFvu4PWwomvm2NFhA
	h3Xb/C+y1I9TD+4MavWiRIwci3dchgBgrvm5iZ9Y08NiH1UeUHWuwq/cT
X-Gm-Gg: ASbGncu6VDDrUXRuoWMby1x0gZNFBgv/vciqI3ltFZM5jdtqZRlf87+KhwMIUEd0Bzx
	tqTZ4L+CBAUQ5Y2TDPwyLmvUR4Zfy8zCJwVn6s8Dab8DC4P9ig9cAxgHTBG72rmHhldkNxfbkeN
	ZJ7bWjNfqyMJGh9A7sJd0LzzT+S7t01aW6o/4dHCD1JfH+8nzh4lS17xON/2yBnGqUNDuuA1rJk
	Vyh/CAP3tjMOGiLvOaLdsmGuuCFmjzQ+fBtTN24kHbdNihfA4/hPlNxaD1QF+9LAoghkLeSuxjd
	RxLpexkE9ldzoTD9OxEIeOh0/m6lTO/v/ffVBETCQgOFoKfv9zwV7ttqrLaT4RCmikWccCVKOhM
	=
X-Received: by 2002:a05:620a:f15:b0:7c0:b523:e1ad with SMTP id af79cd13be357-7c39c66d27emr632612185a.47.1740765890046;
        Fri, 28 Feb 2025 10:04:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEj/2QsRAB/VCS/BBKQ2yHSEMwWhZUBp2Kj5DgJewvlBgCUKZXnHJSnP4yCZQbD/+GMC6zkJA==
X-Received: by 2002:a05:620a:f15:b0:7c0:b523:e1ad with SMTP id af79cd13be357-7c39c66d27emr632608985a.47.1740765889755;
        Fri, 28 Feb 2025 10:04:49 -0800 (PST)
Received: from rhdev.redhat.com (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fee8a08sm274654485a.6.2025.02.28.10.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:04:49 -0800 (PST)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v4 1/2] nvmem: core: add nvmem_cell_size()
Date: Fri, 28 Feb 2025 13:03:25 -0500
Message-ID: <20250228180326.256058-2-jberring@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250228180326.256058-1-jberring@redhat.com>
References: <20250228180326.256058-1-jberring@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function allows nvmem consumers to know the size of an nvmem cell
before calling nvmem_cell_write() or nvmem_cell_read(), which is helpful
for drivers that may need to handle devices with different cell sizes.

Signed-off-by: Jennifer Berringer <jberring@redhat.com>
---
 drivers/nvmem/core.c           | 18 ++++++++++++++++++
 include/linux/nvmem-consumer.h |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index d6494dfc20a7..4d0cbd20da48 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1624,6 +1624,24 @@ void nvmem_cell_put(struct nvmem_cell *cell)
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_put);
 
+/**
+ * nvmem_cell_size() - Get nvmem cell size in bytes.
+ *
+ * @cell: nvmem cell.
+ *
+ * Return: size of the nvmem cell.
+ */
+size_t nvmem_cell_size(struct nvmem_cell *cell)
+{
+	struct nvmem_cell_entry *entry = cell->entry;
+
+	if (!entry)
+		return 0;
+
+	return entry->bytes;
+}
+EXPORT_SYMBOL_GPL(nvmem_cell_size);
+
 static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void *buf)
 {
 	u8 *p, *b;
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 34c0e58dfa26..a2020527d2d3 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -54,6 +54,7 @@ struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id);
 struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *id);
 void nvmem_cell_put(struct nvmem_cell *cell);
 void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
+size_t nvmem_cell_size(struct nvmem_cell *cell);
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
 int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
 int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val);
@@ -117,6 +118,11 @@ static inline void nvmem_cell_put(struct nvmem_cell *cell)
 {
 }
 
+static inline size_t nvmem_cell_size(struct nvmem_cell *cell)
+{
+	return 0;
+}
+
 static inline void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 {
 	return ERR_PTR(-EOPNOTSUPP);
-- 
2.47.1


