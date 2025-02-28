Return-Path: <linux-pm+bounces-23189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7470FA4A115
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 19:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D423AD0C4
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 18:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C7D27427C;
	Fri, 28 Feb 2025 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drsSSEV1"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5826F44B
	for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2025 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765896; cv=none; b=Kz3sDgGHTOV2/lU4xlnge2oQk9yrG6iZ1sz6B4XD7FGHzMErya/umWN8U/XXod25dH2ru7ctIkooB2lfALkju7zoaya28q+w5zqsKAyI0HnIjtjnc0D6ZN7rN0tP7Nuoiw6jq+y1MAmBLSXfiefpdy4q7GZTPcMuNoR8yfiSql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765896; c=relaxed/simple;
	bh=scfmeAIOAJYjZm7Jb+84QkPQyC4V8osgVIoJao20Z88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdeC4dz9mQX3y+QMVrlBBQPwtcosHNYVmoWophj1bUFiMjCg5Tb/yOEXze5leL/KvGLbq4hm6ZVcf5Izcv2LGlnWgUo+2r+2oMzwlgRNqNb3ubsTTcr91h6M41NBgZcLDTCKMxqQpd2t2dyt6CfoUQToRS77oIS3mAt5K+kmwa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drsSSEV1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740765893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAMkimjaX5T169DBm7Y9jGqkQ+vg8U81DkhhnBduopw=;
	b=drsSSEV1sT9mw7otbLgCY28AShbwzlYWTgBZSZRVl4CidTmSTzXJQWA1Pt+CiIKjR+1Pj8
	WmqSkRxLpJnEVUcuoUh9lmuVJoxklvcvmf5xrQfMEhOffg/bI8gtFh+tMXVN2uoM+3k1rl
	HzJfiNjRHo8fu307nNXm8eLh2pZaYUo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-QV0NJ457Ob2XSTgXHAigfg-1; Fri, 28 Feb 2025 13:04:52 -0500
X-MC-Unique: QV0NJ457Ob2XSTgXHAigfg-1
X-Mimecast-MFC-AGG-ID: QV0NJ457Ob2XSTgXHAigfg_1740765891
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0b9242877so579904885a.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2025 10:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765891; x=1741370691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAMkimjaX5T169DBm7Y9jGqkQ+vg8U81DkhhnBduopw=;
        b=ckolvxkbB9A/uxwBzjtT0zbHNJmiZF5rCdpIYSVw6/Moite42svcHf0X47G5Byti9r
         QacmDJcrUWgg00VtzsFQMBjOUxoKxq/5yHwXGQsn48QFuXxztoFLjiTLL6WbvgTJa0GF
         hfGKoL4cW+9Iq7pyGnvnlh73pfzPdwuWrF9slYPvUNiezXPyU0d5n6y84mqqyDq5XkNo
         7vhauHoU4VEBD6nVvpCJOB2JrMjpCUagt0g7mzvSSJWLTwH27l6Fy4RysnrVxsOfRXn1
         qKuOk0AjB2GpWfFZRkIglnyuU8g3p2U/H3h8NEm2LgoJmTGfOwDsAjZyOz1LBXRQ3YW/
         hiMg==
X-Forwarded-Encrypted: i=1; AJvYcCU3JjCwDrXNIG7J5zia+YMXxfDTAyJAgBGV27hiR0ZX9H72rDyI3vOWJdToXNxA8p1l50yoGqgQ9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw97bdDlKz9zRFqok/nCaPb5fYak6TDJ6A+93tvFTGvxd9W+iCh
	vuOgO769yVKky4sBsls2ciEpve2l8Z4Pc9m1AAAsjLlJhaIqI+XD0Wg58cYdMohg1PUK0sn8Ynn
	Cayb23gXDmFMT9RnFfMGld2j/jdG51Qa8C3t1TKpAekAA0VcZ/CEyu24N
X-Gm-Gg: ASbGncvHpeyl9DDH6aMkZXUGe/YkDm6vorEbaNoFMGCjKKtqsKy9pY5A/9I8My3kMdu
	jzJkqzq9GcU823BK0OX4vU4fs/LG/XDtF9e5yTqmn1GAcDG0EsdGHphyKNCi799x+LIT7GBI3hX
	FSJ0Vhlub2kRmoJgq58qrVFOc4uXAKrackinkL+BZL2QIAW1kgtMBWFtcGgzidn28sve/QActUN
	DHEcasL9QPWWmhmqGfARcPFVPXLg5Fc2b0m7E6aIj0N1peEdZC6BhwaM7620nQ4Bbje9SNa2vxw
	IZdkMznSgD7mjIbUVcP5fWY6yjygAgXuvd/ARHfAMXfE3FZj2yT/Xe8pSGkCE/Awv7rLvYrpgHM
	=
X-Received: by 2002:a05:620a:394e:b0:7c0:ab10:1132 with SMTP id af79cd13be357-7c39c656e05mr626151785a.38.1740765891362;
        Fri, 28 Feb 2025 10:04:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTh85sVtk5oi8HSf7ZrK+kyN9/o2F13SCQKm1m3pZ9EncsS4obYl1hjRjtWWMtTxJIGo4z9g==
X-Received: by 2002:a05:620a:394e:b0:7c0:ab10:1132 with SMTP id af79cd13be357-7c39c656e05mr626146785a.38.1740765890866;
        Fri, 28 Feb 2025 10:04:50 -0800 (PST)
Received: from rhdev.redhat.com (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fee8a08sm274654485a.6.2025.02.28.10.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:04:50 -0800 (PST)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v4 2/2] power: reset: nvmem-reboot-mode: support smaller magic
Date: Fri, 28 Feb 2025 13:03:26 -0500
Message-ID: <20250228180326.256058-3-jberring@redhat.com>
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

Some devices, such as Qualcomm sa8775p, have an nvmem reboot mode cell
that is only 1 byte, which resulted in nvmem_reboot_mode_write() failing
when it attempts to write a 4-byte magic. Checking the nvmem cell size
and writing only the lower bits of the reboot mode magic is needed for
these devices.

Signed-off-by: Jennifer Berringer <jberring@redhat.com>
---
 drivers/power/reset/nvmem-reboot-mode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index 41530b70cfc4..112e6cf77d1b 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -20,11 +20,18 @@ static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
 				    unsigned int magic)
 {
 	int ret;
+	u8 *magic_ptr = (u8 *) &magic;
+	size_t cell_size;
 	struct nvmem_reboot_mode *nvmem_rbm;
 
 	nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
+	cell_size = nvmem_cell_size(nvmem_rbm->cell);
 
-	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
+	/* Use magic's low-order bytes when writing to a smaller cell. */
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) && cell_size < sizeof(magic))
+		magic_ptr += sizeof(magic) - cell_size;
+
+	ret = nvmem_cell_write(nvmem_rbm->cell, magic_ptr, MIN(cell_size, sizeof(magic)));
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
-- 
2.47.1


