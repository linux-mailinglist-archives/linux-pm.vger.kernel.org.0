Return-Path: <linux-pm+bounces-16968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2D79BB8E5
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 16:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E221F2195C
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 15:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ACE1BC07E;
	Mon,  4 Nov 2024 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMRFl3tU"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AAD1BDABE
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733868; cv=none; b=Viql2exzSmJwX6y2w1JifrkeNAJ4q7Y2NI5sKImWkBoBz/B5EmU0Zu/EwXAeuIJOsxI36nm4uEf9HPHT8DqJRwcfJjrKFlUH0aOKHVKTOP4/54wkKG5YwT51MmT7V6iRn6p1WgsARnMHP7ZKnjHYBDjCYT+qy3fCxbTNvsW1l/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733868; c=relaxed/simple;
	bh=3YbKA7i8Hg/FH1ulhSK2wdg0qEoMyhdpnPYUaZ5A+hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxCgQ6axdEnLRo7Nfm7hu3NOW+4zIn3JROHA3e+xokfIzV1on5V//tGKwxnvEp5sb5hJTU4FE2W/o8eARQ3OFJX1hczY1iomf1a+5AhU++VlG9lyBpwU4Ns5suoSx1/nFPIKGDGLV5cMJyZ+I1MeD3xe17yB32vlVI2cqvekvp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VMRFl3tU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730733865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPAstAoRK19uFZHmiPTbsRc/dqP7WZfo+dg91IyOgb0=;
	b=VMRFl3tUped0xMFfDiiKFuhsL87reyiqe6DKY8ZRx+urXGpl0sgdd5xwxJjmBNQ33rM+WR
	/qnnQBNKB+O3KhGJ4CaotHVZo7Epm3hnF4qGVFO5aiWRV2GkpXZM9TMkppN0WsCG0aG43y
	00OHUfATDvL4iDdFybbj/Nww1tYz3/k=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-6J1ls_L7M7CViUQgPnhKSw-1; Mon, 04 Nov 2024 10:24:24 -0500
X-MC-Unique: 6J1ls_L7M7CViUQgPnhKSw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-71816436594so3519409a34.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 07:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733864; x=1731338664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPAstAoRK19uFZHmiPTbsRc/dqP7WZfo+dg91IyOgb0=;
        b=IZswiiE7vOMn9j7q1+XS/X2Oe33xD5YSxHL2qdyuGmWpdfGIuO5HFntTGvAJwUOqPh
         Y07g7sTrlHf4AY61F/5PrhVqYL3lJ/oIuRfWTC2GL/avOjXcd3VklVGo+rVsHD7FaAKj
         FIqPLT/pv3PkY3zH23K/5zvSl203qYQD80Rcu/4nKuRFYM9eMingn6xkX8CR/T86qxUU
         2Sdr1//Smpk/doH22w7xuQUB2SRgetQEk0bYmfs7+4Wq1vEy1Y8GfbXj0EgQ/fyVtn6/
         eQ2M8P8SoTipYqV0xhl/jKl/Kp2xDo3UE98/l4jVA/EMF2ZzxXa0tduW/ql6psrFzZ6k
         H1AA==
X-Forwarded-Encrypted: i=1; AJvYcCWtkYv8uhK5NvlqMXBrMjRgCLLz5mpx+uOouEt7+1trgXOORkJh+igOf58B3jzD/1BNbtMirqOAUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJcDyPsbFwiOHhApVffg7RuZ4RyGB1fGbFQ/lzoC2y+VcgLEYa
	JhDGRSNXsFe2zN571yl/b8/CtdPW9rvmnl4jh3DDS735CRnOJC0D63zfSsa8Ksk6MULDG9Zigl+
	TD0MPLj2FGe5XL1SxlYbQKKlrAXPU+jwc+Y/2LXoKm9QmG16FTMWp31f7
X-Received: by 2002:a05:6830:4486:b0:718:9ad9:3082 with SMTP id 46e09a7af769-7189d4a060cmr8138865a34.5.1730733863829;
        Mon, 04 Nov 2024 07:24:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEso+jw9fJAKQKBDcR1comcjsM6f+a0AKdQE2B08KoyHnQHHkZHbBPFR9MPYdc30JsDHmWDpA==
X-Received: by 2002:a05:6830:4486:b0:718:9ad9:3082 with SMTP id 46e09a7af769-7189d4a060cmr8138836a34.5.1730733863477;
        Mon, 04 Nov 2024 07:24:23 -0800 (PST)
Received: from rhdev.redhat.com (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc59b45sm1980847a34.6.2024.11.04.07.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:24:22 -0800 (PST)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v3 1/3] nvmem: core: improve range check for nvmem_cell_write()
Date: Mon,  4 Nov 2024 10:23:10 -0500
Message-ID: <20241104152312.3813601-2-jberring@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241104152312.3813601-1-jberring@redhat.com>
References: <20241104152312.3813601-1-jberring@redhat.com>
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
buffer that it allocates. Add a check to avoid that problem and instead
return -EINVAL when len doesn't match the number of bits expected by the
nvmem cell when bit_offset is nonzero.

This check uses cell->nbits in order to allow providing the smaller size
to cells that are shifted into another byte by bit_offset. For example,
a cell with nbits=8 and nonzero bit_offset would have bytes=2 but should
accept a 1-byte write here, although no current callers depend on this.

Fixes: 69aba7948cbe ("nvmem: Add a simple NVMEM framework for consumers")

Signed-off-by: Jennifer Berringer <jberring@redhat.com>
---
 drivers/nvmem/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 33ffa2aa4c11..4a5a6efe4bab 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1780,6 +1780,8 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
 		return -EINVAL;
 
 	if (cell->bit_offset || cell->nbits) {
+		if (len != BITS_TO_BYTES(cell->nbits) && len != cell->bytes)
+			return -EINVAL;
 		buf = nvmem_cell_prepare_write_buffer(cell, buf, len);
 		if (IS_ERR(buf))
 			return PTR_ERR(buf);
-- 
2.46.2


