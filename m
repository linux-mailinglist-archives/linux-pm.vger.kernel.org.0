Return-Path: <linux-pm+bounces-16970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA9C9BB8EB
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 16:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29935281E33
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235C1C3306;
	Mon,  4 Nov 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiJNeKvU"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C41C07FB
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733871; cv=none; b=kljKSfH8lRkUwAd5GkoN8gkY1Aq8YFw+yt9CHHMXu+sDefhQu0H7nV9fParXXBHD5Jbt1erY6aZ7d7o6SHerjVZpWSE3X4VCU73rtxzY7T1JCVS/LlfXARgA7ATIx3aNf0jxTnt8wsctAe3Jf7pZF31aUOYnkTA0DINfbinnbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733871; c=relaxed/simple;
	bh=gLW0fh8PPs+BaOn5rkVzGVDEOg0uLVSjRbyJUCDLGBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQlAFv80FOEC8/fDp8Kb2kLsU/s4Jp4o4UKz/GGdXdixrTKw66WUTR41MT0cQ1OTvT3pFHboMXqPz0Uqa+WIDW3br/xNoS1U2p5oSsfUsu1uFazx07u3C4XQI2mFsmZ1P4JUZpKWfowd4WD7VtfxIFinw5kjdL6AL6SY0NkP/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiJNeKvU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730733868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61B9Jq2TL9i1+pERa497eTJdtZBmCcAzgGgAjZWiZfs=;
	b=GiJNeKvUi75jzFA+suZqnCqTcDEWhQOQ81TXplqqCMNvTl646pgt369ORIl8bLiFeceXGc
	cvPZ3e6qdPf9hhoRz2D7TMFHiLQxr0ObFyvF3ah1o/l76rcLmabkyVPS+eBb+7CX5ECedD
	gnh3itAiVl17JR1ykQOu9McdlUGE/7M=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-swv6YNAXOFOfTffsYX58Ow-1; Mon, 04 Nov 2024 10:24:27 -0500
X-MC-Unique: swv6YNAXOFOfTffsYX58Ow-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5eb9c053637so3339891eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 07:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733867; x=1731338667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61B9Jq2TL9i1+pERa497eTJdtZBmCcAzgGgAjZWiZfs=;
        b=pZu7Rv6CUk6QP1xEa5vbG5gElxeYJNz2XMmllpLv4AZhx7Er4n8KZkIse3REP86Axf
         O9QFel43JGEforFIqBDg/zHGHKI8juAbbxpyJrF/kyaNIRIxPDSbOH7UYEHB8bnQQXs1
         GpmrLe/F9N9uQv2Ep9A1OMyG59C6r0BA4hZnHafIzp4MFe3b3Dv5zzdWb5D71nfRaE4c
         2nABFotlOO13jOKGPEjHZaMOL0CaWHX87JGHRyrH47WrM3iftOq/0sqJZ76iORPB68cs
         747R3M03CPQ5tAzhEmczZU3glrVwoRj/1JjSkZH9A1ulnAyFklVIjk3MF3s4SjRnXejT
         7ETg==
X-Forwarded-Encrypted: i=1; AJvYcCXv4/pxIJodaynB1Gj6KJV6L271Zc3xPZy0Upkjz/cI5lQKaEhkav9d2W8zWZN9UxvY6iBBbcC4mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbg5Q8IcTqGcx6nRFvYzG1FIMiYYf0ssiMOx6ETAcKvryXGFPq
	Ivw0mNFCTWZl9Z8BYcKVPL2pXynw4YMhyXSOtIXqexgmm8paJtbGCQz0WGxJ56J4W8gnaqpwuF9
	VsCj/uN0V9BjPgOkKru6wRRQXXHB5VWjTvr/TvSnN5B8AvCS6A/HYQhgW
X-Received: by 2002:a05:6870:e0ca:b0:278:c6bf:fd34 with SMTP id 586e51a60fabf-29051bdaef8mr27449244fac.27.1730733866955;
        Mon, 04 Nov 2024 07:24:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdz+LHCvEJnf6MEsvrtoajBkoyl90rdROWBh+jGnf8JMCALx0RuCy2tX6Sdh/r1DLTo3sGoQ==
X-Received: by 2002:a05:6870:e0ca:b0:278:c6bf:fd34 with SMTP id 586e51a60fabf-29051bdaef8mr27449221fac.27.1730733866650;
        Mon, 04 Nov 2024 07:24:26 -0800 (PST)
Received: from rhdev.redhat.com (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc59b45sm1980847a34.6.2024.11.04.07.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:24:25 -0800 (PST)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v3 3/3] power: reset: nvmem-reboot-mode: fix write for small cells
Date: Mon,  4 Nov 2024 10:23:12 -0500
Message-ID: <20241104152312.3813601-4-jberring@redhat.com>
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

Some devices, such as Qualcomm sa8775p, have an nvmem reboot mode cell
that is smaller than 32 bits, which resulted in
nvmem_reboot_mode_write() failing. Using nvmem_cell_write_variable_u32()
fixes this by writing only the least-significant byte of the magic value
when the size specified in device tree is only one byte.

Signed-off-by: Jennifer Berringer <jberring@redhat.com>
---
 drivers/power/reset/nvmem-reboot-mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index 41530b70cfc4..b52eb879d1c1 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -24,7 +24,7 @@ static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
 
 	nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
 
-	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
+	ret = nvmem_cell_write_variable_u32(nvmem_rbm->cell, magic);
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
-- 
2.46.2


