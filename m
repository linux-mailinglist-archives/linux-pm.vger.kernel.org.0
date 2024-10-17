Return-Path: <linux-pm+bounces-15886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1548F9A280B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 18:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94026B22295
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 16:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49921DEFEA;
	Thu, 17 Oct 2024 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRkt+j3e"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508CD1DE4CB
	for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181371; cv=none; b=mX2O325qQE6bjU3JAEl0pdVqpeUB3wru5s4txFCN6K9wPqvUB4piMbUr1+msDer1BXwISpnBqfgZwIF/zE+wy2/FV5qNuP6cXZvsB9IKBPSGHqXd15dvCe6mdCOfw54+YCaWA1SzKETBPWSC2mJrW35JHpvq4ZJcj3skJkneX7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181371; c=relaxed/simple;
	bh=XWK2CQKBoDnkFJt4/MwIKSAF02nWN2yyjN0bWXOENEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mRPwJ1e009rK6qwAqr4zHDICs35Sv9Dy7AIuVHCNWt1azNBn/ayJjvs42G2CWmbKWDbiu0nram+eMG7QNnc6Tg0gc8hsUoIYh/nZtFoisIAvWoNxEZ91DL6+zbWSOgxheb9Qj12mg6CP/GGRy8zZdOyylzKl81rqERqpc48rg+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRkt+j3e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729181369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DkS5RbL+ncBye36HbvV2swXtYfvhlqwDI5lNtBAyr/g=;
	b=MRkt+j3etiA3uCxQHE7ZvUAxeLmr23xDwr79ke8bO+TAMGe0/29tEUu2ZR9AZEufnCh1K0
	ycVNF6tbnEyik6htw3yvcjbmzSSNkj0KdklDiDooEwwaBd5tmKeWu6uY16vMhxUnN4Q33M
	uWMuKzWPVW4KaBTH71nxfXjGXdUOCXs=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-zj-J-moePWONCe-OcFKsgA-1; Thu, 17 Oct 2024 12:09:26 -0400
X-MC-Unique: zj-J-moePWONCe-OcFKsgA-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-718107b2091so906403a34.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 09:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181365; x=1729786165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkS5RbL+ncBye36HbvV2swXtYfvhlqwDI5lNtBAyr/g=;
        b=tIa9hI7mdH/qhTyASmkUTMBq8iwDy3uVPah9HNWWrKFkW8rr2seBBM8kYXXBVnwQDZ
         al4QB0xpoxKLNSmsJUOZ0d/2dy6KFzhe2KiO9y2pLR6HVL9G5UAm5wFXAs74i7Rd91ba
         opbr27fkd37PRjxN61LnD3pKnELdK0SzI6flHv8rSpw8yqPgRKEtSwrDpKUk3bo9+Mgm
         RptwxchP5RtEzbnJLEWYroxbegfYDLTpMyS6iR7qJFh3VzBkFxDcyNgRKdnyNquFCuHF
         3iTphL8NCiDn+L0RpMOkXdW6LgseOMOokT7bTl/Gd7wP/aplZjDXZii5WG9a0z1J4aBj
         ijvg==
X-Forwarded-Encrypted: i=1; AJvYcCVkmwSsqAo8R24v7HaUyTV4Ug4AkEkKw4zdcAgd/bLgxypth/gRhHzkG6/X7vbvmAMUoEQmLvVMHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx43IO4cPSZ7WeJef3rPjmgg6Yp4JykwVic0Q+5XstCFIuffxxj
	b9vetR05yrlnWigxwQGHRS9pBI5QupsKhtT2PI9YAEmLVL3Y55jgeKCRsjH84D7+IusVFtWNC+G
	d/f/e2gxX/AIu/XdB3nIXK934b4uEHaWobhD0/osXvPCPFg9NIiF4yEPg
X-Received: by 2002:a05:6358:9490:b0:1c3:75c6:599a with SMTP id e5c5f4694b2df-1c3784bf6admr683541055d.21.1729181365635;
        Thu, 17 Oct 2024 09:09:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfPycPZTZP+D3KLarN8Q1dwMVP6y29vgjcgbThfVJWEkcsbXkg/dm4qCNq6FkIFwCOC2vr1Q==
X-Received: by 2002:a05:6358:9490:b0:1c3:75c6:599a with SMTP id e5c5f4694b2df-1c3784bf6admr683537955d.21.1729181365317;
        Thu, 17 Oct 2024 09:09:25 -0700 (PDT)
Received: from localhost.localdomain (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50d7b2a5a67sm881914e0c.42.2024.10.17.09.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:09:23 -0700 (PDT)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH 1/3] nvmem: core: improve range check for nvmem_cell_write()
Date: Thu, 17 Oct 2024 12:09:02 -0400
Message-ID: <20241017160904.2803663-1-jberring@redhat.com>
X-Mailer: git-send-email 2.46.2
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

base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
-- 
2.46.2


