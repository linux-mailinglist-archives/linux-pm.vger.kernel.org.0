Return-Path: <linux-pm+bounces-15887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C4C9A2806
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 18:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87431C20E83
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18D51DF250;
	Thu, 17 Oct 2024 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZJ1z1a2"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F33C1DD0D4
	for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181376; cv=none; b=c0Q3LY/erkM4SAckATNN1ikNZtP8ohl0eoC2359zWDfiMxL6zyCRoaAsUuGRvcleXhW+psxTyK3Kg4JEULaMhUXInMgwESHIH8CniNfP5PvVKrauTQPZcpsF/lgUF2dAF3C87Ihy+X5emb75QI4Wh7ttd1ExzMY/GoDMYirPTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181376; c=relaxed/simple;
	bh=80JceXAUMBc0hDJiSFQQcdD4iRPY5w96kB8lL1EKvV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQzFc0eUbEZ0WMdOlDkGzj76tPht0zkWjaHnBLgYadiDLUMhH2xhmefx+4gERZeQDqXWJl5Lr1tC8igZZd7jirzq8FOdbBBGrol1jgr8tNVmd4V6GX6JUivkSssTSL/kerUaVKahjphtjSMVts+kQco2A+dulwk2D+UxuSau1O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZJ1z1a2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729181374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3KIi5jhT8XRqt3YLNgG/2PEMhK9NfLcor1EN1FC7Zw=;
	b=FZJ1z1a2IuUwiGqmkn8GQoBaebgiYrF5v+uBA5vIpgArT/3GMmDI25f0JE32w//iMIvsKj
	P3UnSxeEVQB0lQlWQBzIWUsPRGD6WrtkytKDfbED8VzveMgrpWmNvHdUdqZHAxtqW1xhUL
	jL8mErqocGqobwBrD28+mXunPJ5SCXs=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-AF2mjVwSN5SWVRDVEiqjLQ-1; Thu, 17 Oct 2024 12:09:33 -0400
X-MC-Unique: AF2mjVwSN5SWVRDVEiqjLQ-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-50d374995b3so478988e0c.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 09:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181372; x=1729786172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3KIi5jhT8XRqt3YLNgG/2PEMhK9NfLcor1EN1FC7Zw=;
        b=GU3hZub6kput10lillIbrDnzJW5MRcuIcIG5iqiXatq4Pr2O5jNCjDyy55cslKJ7fB
         UECXgEZ/WEhZl3SCYtj0nO+/35xThaqrgcglJk2E/9gvYXVQVbrMEhy2lwJy0WFYepKl
         /LR56qTnXExihaB+0Ld+xx3kz7V6M7fUEzahscW2i3j0jVEz1VUls3GA6TdVLujPKT+z
         t6TFYZAIvoG59hzvVdWoSZU0Q88tslz/mEu9YXbdd5YHdscaSEEsvL0Zbx2wzHXRjoVw
         GF9OUpMoZAyK6GpN+mGDK/HPSrkWFTGRMiuR7PB1101A+GolZtjuAqDgDc2j1lTlwlHV
         vL3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqe/miUd2RDsSS27ZUycHPPq2cQf28V65Utq3f5VzevA9lQneRVKiLkTO5Dm6XrC9f1bOqStTQhA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1H9swyq9eE9ZIGN4Nq79/t7Is0diYmDyvg0FNQ+fcbNGoXI1L
	KyXiFChiuSxojE9MWnXLVrjpBc24M1U2DzOU85aILVIo33aR2Y23YknL+FlzuXsca2m4AvF8Wg5
	U9oDRGiNVkOa+EBkZACi0Qtb4lUO4nkWFbQJSSJSLwYEKv5tPXWwJJQxx
X-Received: by 2002:a05:6122:c98:b0:50a:49d1:f1f with SMTP id 71dfb90a1353d-50d1f5c24dfmr20606216e0c.13.1729181372331;
        Thu, 17 Oct 2024 09:09:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER4G+Fz95k/I+hdY6XGfAQyo/Vj4u+zF8RuE5gYuvHARx4+3Zp7k7he+8cYNhe5n804JdQAQ==
X-Received: by 2002:a05:6122:c98:b0:50a:49d1:f1f with SMTP id 71dfb90a1353d-50d1f5c24dfmr20606187e0c.13.1729181371993;
        Thu, 17 Oct 2024 09:09:31 -0700 (PDT)
Received: from localhost.localdomain (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50d7b2a5a67sm881914e0c.42.2024.10.17.09.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:09:31 -0700 (PDT)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH 2/3] nvmem: core: add nvmem_cell_write_variable_u32()
Date: Thu, 17 Oct 2024 12:09:03 -0400
Message-ID: <20241017160904.2803663-2-jberring@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017160904.2803663-1-jberring@redhat.com>
References: <20241017160904.2803663-1-jberring@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function allows nvmem consumers to write values of different sizes
(1-4 bytes) to an nvmem cell without knowing the exact size, akin to a
write counterpart to nvmem_cell_read_variable_le_32(). It discards the
higher order bytes of the passed u32 value based on CPU endianness as
necessary before writing to a cell smaller than 4 bytes.

Signed-off-by: Jennifer Berringer <jberring@redhat.com>
---
 drivers/nvmem/core.c           | 24 ++++++++++++++++++++++++
 include/linux/nvmem-consumer.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 74bf4d35a7a7..6f7aa2beb457 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1816,6 +1816,30 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 
 EXPORT_SYMBOL_GPL(nvmem_cell_write);
 
+/**
+ * nvmem_cell_write_variable_u32() - Write up to 32-bits of data as a host-endian number
+ *
+ * @cell: nvmem cell to be written.
+ * @val: Value to be written which may be truncated.
+ *
+ * Return: length of bytes written or negative on failure.
+ */
+int nvmem_cell_write_variable_u32(struct nvmem_cell *cell, u32 val)
+{
+	struct nvmem_cell_entry *entry = cell->entry;
+	u8 *buf = (u8 *) &val;
+
+	if (!entry || entry->bytes > sizeof(u32))
+		return -EINVAL;
+
+#ifdef __BIG_ENDIAN
+	buf += sizeof(u32) - entry->bytes;
+#endif
+
+	return __nvmem_cell_entry_write(entry, buf, entry->bytes);
+}
+EXPORT_SYMBOL_GPL(nvmem_cell_write_variable_u32);
+
 static int nvmem_cell_read_common(struct device *dev, const char *cell_id,
 				  void *val, size_t count)
 {
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 34c0e58dfa26..d3ede6916ecb 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -56,6 +56,7 @@ void nvmem_cell_put(struct nvmem_cell *cell);
 void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
 int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
+int nvmem_cell_write_variable_u32(struct nvmem_cell *cell, u32 val);
 int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val);
 int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val);
 int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val);
-- 
2.46.2


