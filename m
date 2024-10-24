Return-Path: <linux-pm+bounces-16395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D664A9AEAC8
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B741C226C7
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195521F668E;
	Thu, 24 Oct 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdB3uGLC"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F011F5836
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784485; cv=none; b=ZV6VbHSCSEjoA5gELRoB9bj7m8SdBBsMFKr0bFdbUzg3i5L5/v6zN1BlLKXLOjq1aDbbrPVxWmX2hsw1ZX7XPO8WD+/5vhnT4SPVWYuli/vhMV+SfcMzW5q2GPEOg2fcLNBlcQvDXiZG751KvT9kM8iQkw9DGyZRYNgz5oWMTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784485; c=relaxed/simple;
	bh=Vq0hwZOE+pwsen4g/SemCbnquuCGs6MC9R+dxIZBdGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMPkA6VS9OTc8gZHZPxdo3E7QdVYRhIi+gAugOssrjoOyeqFvDB+e3J3LS8TkBQVxPVVV/BZL6qhJs6IiVpyMD86/7tz2S7Sfepexu3e58ICeOIcCTeBTWhw1KMwG/jG2k4vA2yU1F39r2fihNf4gOpJ+kLcnT2cWf0WSMMqXss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdB3uGLC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729784482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MvysEEBZ+T8FmbTZPAMUhj3c6tELoccFnLFV1SGbJM=;
	b=YdB3uGLCNBCoTFjfLT1LyhLmwpfG3wNanT0UMn4oAXzklhnXbsnfeGEUOvOtzKvU8q8cl4
	ie6tW61govnQwJHkGFMcMGeJquKvrxPhJgOaWrihUF9W9EX4quznGOL80x1ZXrfuMIotaR
	asxRS6BNGnZgQKhF3T7EZk7YkvEiN5M=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-iukQlOkNNBK73-Qbaup-8Q-1; Thu, 24 Oct 2024 11:41:21 -0400
X-MC-Unique: iukQlOkNNBK73-Qbaup-8Q-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-50d6bc46348so314435e0c.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 08:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729784478; x=1730389278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MvysEEBZ+T8FmbTZPAMUhj3c6tELoccFnLFV1SGbJM=;
        b=kOrgvmv8nG08u6/HUkOJZCDo3hn2FWnCouLmoyqo0dBWSU+wr9+T056r5sEFgkxilK
         NDkIPJR333+nCv++WqkSemt8FWbG5vkb6fQ6DnuX0yFqXd9X+SNmX2zAFsRbPXf1MngJ
         +74Jl0bZp9BO5C54JDzL6L+518eCn9cPiMvYlZNKK+CzMW3IKLH4zoDNjenR4CVOGmQy
         tgBMaXrj4fsN8VxYTGGzi3nUHiOwYitSndBe7481BNmNvkcunCkAH6Hb6NQNGCxBBooF
         dIVMhLpVgdaKsLoo4aI8yUJCNO2HZWjuVO3/aJlBO1Fo4KtR9qgipsQtJ2p5j0mOzl7r
         SW4A==
X-Forwarded-Encrypted: i=1; AJvYcCWPgK+MEAVJTEw/06+iNB4u+9r+RAWzBfgvIjbmGRwIMywE52l6wDN+fZWod5LREBQ1XIh80XALNw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2lleq16RYeM4gd8EDHNpW1Jn+PPTTX2f9dlCr23n5nSDxW0WH
	XqmACK/NI5lt5FyvTHIR0vp+m3RnO6gozEa6jSET5m7mLxH3pqhiStTCg8nR+Wvs1wXW46fgcLB
	ptAmhKJ+PbWYzU8e4UeN0idDEqU14ZG27ptvqqJMlTrn34YDRSVBfMnYY
X-Received: by 2002:a05:6122:3108:b0:50d:5f75:f7d9 with SMTP id 71dfb90a1353d-50fd0328be1mr8094120e0c.9.1729784477786;
        Thu, 24 Oct 2024 08:41:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd4qMACX9LG+miS3COD2mtSEKu3z3IOg5e0itCY/rx1mnKITe4J+oT57bQeldmULjWLlgWyQ==
X-Received: by 2002:a05:6122:3108:b0:50d:5f75:f7d9 with SMTP id 71dfb90a1353d-50fd0328be1mr8094092e0c.9.1729784477455;
        Thu, 24 Oct 2024 08:41:17 -0700 (PDT)
Received: from localhost.localdomain (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19f5fad0sm1364301e0c.40.2024.10.24.08.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:41:17 -0700 (PDT)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v2 1/3] nvmem: core: improve range check for nvmem_cell_write()
Date: Thu, 24 Oct 2024 11:40:48 -0400
Message-ID: <20241024154050.3245228-2-jberring@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241024154050.3245228-1-jberring@redhat.com>
References: <20241024154050.3245228-1-jberring@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When __nvmem_cell_entry_write() is called for an nvmem cell that does
not need bit shifting, it requires that the len parameter exactly
matches the nvmem cell size. However, when the nvmem cell has a nonzero
bit_offset, it was skipping this check.

Accepting values of len larger than the cell size results in
nvmem_cell_prepare_write_buffer() trying to write past the end of a heap
buffer that it allocates. This patch adds a check to avoid that problem
and instead return -EINVAL when len is too large.

Rather than unconditionally checking that len exactly matches the nvmem
cell size, allowing len to be smaller when bit shifts are involved may
be helpful because some devices have nvmem cells that are less than 8
bits but span two bytes, although no current devices or drivers that do
this seem to rely on nvmem_cell_write(). This possibility can be handled
by nvmem_cell_prepare_write_buffer() because it allocates an
appropriately-sized heap buffer and avoids reading past the end of buf.

Fixes: 69aba7948cbe ("nvmem: Add a simple NVMEM framework for consumers")

Signed-off-by: Jennifer Berringer <jberring@redhat.com>
---
 drivers/nvmem/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 33ffa2aa4c11..74bf4d35a7a7 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1767,8 +1767,7 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
 	struct nvmem_device *nvmem = cell->nvmem;
 	int rc;
 
-	if (!nvmem || nvmem->read_only ||
-	    (cell->bit_offset == 0 && len != cell->bytes))
+	if (!nvmem || nvmem->read_only)
 		return -EINVAL;
 
 	/*
@@ -1780,9 +1779,13 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
 		return -EINVAL;
 
 	if (cell->bit_offset || cell->nbits) {
+		if (len > cell->bytes)
+			return -EINVAL;
 		buf = nvmem_cell_prepare_write_buffer(cell, buf, len);
 		if (IS_ERR(buf))
 			return PTR_ERR(buf);
+	} else if (len != cell->bytes) {
+		return -EINVAL;
 	}
 
 	rc = nvmem_reg_write(nvmem, cell->offset, buf, cell->bytes);
-- 
2.46.2


