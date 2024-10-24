Return-Path: <linux-pm+bounces-16396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42119AEACC
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7594C283398
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CFF1F76D6;
	Thu, 24 Oct 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irZuRXDg"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25EA1F76BC
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784490; cv=none; b=lPi0/d70eb3AgkT95MVHJrfMgWy4mGwVTQWt03PLIk+3xO/PmHBGNbMWThAhK+Z6M0EAS0vHlRsmS7EFVrCNe4h5+wgaDnDPtTO15AEmmxa/uzqbO33e8o7Ivdj+ZI2ZvU+ii1fH55zppLOHe0iy/sjXsOx4CMeqwDmJSIGp9ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784490; c=relaxed/simple;
	bh=gLW0fh8PPs+BaOn5rkVzGVDEOg0uLVSjRbyJUCDLGBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSYcsCPsahm/uRrpHbkilSfwl+lHmO3gzbj6WRIoGVmrKGrXJuu4ERIxEzGMLg+ho8lUj+P+d1Aj+8FC4DI65l1eHhUoWTqmRchOTsrapsXOgEK9S66pmd6SKm5JBg56Q9GuwYKSHcD8BEP7h952iVL2VoDdOQCXzDC/diHza4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=irZuRXDg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729784487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61B9Jq2TL9i1+pERa497eTJdtZBmCcAzgGgAjZWiZfs=;
	b=irZuRXDgWACWRCTNXIsFKYyMMCr3EPRKYbhiHL1UW52GoAGZN5MEWelG/v4xAVk+UMtI7g
	kXx9oTO7GheK/qR/KwBJWglXBOuJelNScLCX9FXUXjEdGqEn1pEmqJptc0I4dFj+SGpZ+g
	1SF6IUqwKvlGVLfR19taLFonfWkbkow=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-_t0g0PPSM1mRCah7stR7qw-1; Thu, 24 Oct 2024 11:41:26 -0400
X-MC-Unique: _t0g0PPSM1mRCah7stR7qw-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-84b28b879bfso252499241.3
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 08:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729784481; x=1730389281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61B9Jq2TL9i1+pERa497eTJdtZBmCcAzgGgAjZWiZfs=;
        b=eqky9eIruyR3oVJd4/ns7Z0zDp1j7qt7oStJPeiKcM5Qa/mzdzj0UKlP26nle+IcmB
         xf4rOlRYH8kov1vKiXmRg+sPShNeow87RAysH269kU6L4P8GahkkghLkZjT1fKvYQ7qD
         pBa212hzZF3C25NfP9bP0/T1WEYPqKv6bYeKLL0AEtOLer3ZbMG9H6wmS1HbAWaf8BZ2
         wU3GmZO/UdF6pyZsFTxp0jOOoQRWMTjjrk5eEMYS8Km1pvv5cSGGaNLM9fZW2hBj7rs7
         duFekvCZiXx5iWVP59aQNPnhLi95pstUgg4t11NpnyzwpIWB1j0Ud5NmRaY7XTr5Zf+v
         BJdw==
X-Forwarded-Encrypted: i=1; AJvYcCV3/JvLk0puLfy8Lj+PDFLhXjQCr6j7huguJQ51Tt5Kknh7DXyfoKmUeSwV9dV5t0KFxL9e4qvwgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJEFVymEjb/bD6OsspoWPIvjjUP4gvetTgYZZbDlMv7Q5NjXQT
	8Hi2cr0gwtiMrwlEeRwoS/1wWLSpdhWH7QLvXRkX6P8x5JKqo2ToJEAUvhNhZdattH8K3QwqodG
	Y6aNmVX3U1iFUlRGj32EFrroQWcggshJTGHVYpaJtXVyApd896rvQCHHT
X-Received: by 2002:a05:6122:3c52:b0:50d:4257:5bde with SMTP id 71dfb90a1353d-50feafaf2cfmr3108141e0c.5.1729784481027;
        Thu, 24 Oct 2024 08:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOjcqYJKGQfUcpv5jcBoHcpWCXghuty7VZY+BBqG0fKgtkBaCSWPzjKiT1o+ltrBGA2G2CTQ==
X-Received: by 2002:a05:6122:3c52:b0:50d:4257:5bde with SMTP id 71dfb90a1353d-50feafaf2cfmr3108126e0c.5.1729784480567;
        Thu, 24 Oct 2024 08:41:20 -0700 (PDT)
Received: from localhost.localdomain (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19f5fad0sm1364301e0c.40.2024.10.24.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:41:19 -0700 (PDT)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v2 3/3] power: reset: nvmem-reboot-mode: fix write for small cells
Date: Thu, 24 Oct 2024 11:40:50 -0400
Message-ID: <20241024154050.3245228-4-jberring@redhat.com>
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


