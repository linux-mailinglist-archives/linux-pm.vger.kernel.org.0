Return-Path: <linux-pm+bounces-11408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E21B193C722
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 18:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0871F20FB5
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 16:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD9619DF62;
	Thu, 25 Jul 2024 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4dHQQw6"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599E19922A
	for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924898; cv=none; b=AJArCfbMqizzWDXqwke+2eKceweSDOwlOBPB7kX07kVzJMSjuRoifV+xaixjQlyMDhyVRom1NRXDc5++K+8Ozhbb0bVFNzYnYwIUHWa4aA2GH5P6RAx7fUmGBBA/m9ByUwB2kipjz968OhdTJF7m3s8ncT4IdsQNCbBSRcjZeE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924898; c=relaxed/simple;
	bh=Fy3kYahgwmE/GH4851HLgNpm3At9MaQwpO/m3ngJEhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lvcXg+FUocAoQ/i+GYbuhsE1pELTieIx51znPZyUouXmsQroA4cs7Zn4l8tHbS92d9iT36Inb9laBH1Ji4CpYaissZQQ6Wxo3etOOBPnUQp5tm5sne8+SrY4Zt6w4ppTf4IBf/1+a/R9nIPpBFeogu2Cyq2IhBdDBDZo+AFqweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4dHQQw6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721924896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cZ+wQu25/ua22FV3hTgwYKgkP5cYl1BWWCM6PQeMbuQ=;
	b=b4dHQQw6jBmHrJNbyi1HrhGlDC21gi0ecIkEcbJFRb3kSQDaHzQhIv57kIaLxLJgEgO9xG
	TN96z1dtKn2VIjjvDMW1oN81kK5KyQESZ4J9VwmWUiqVRC8w7RRMVCnlkXKKY1VMvKQ6+K
	l+VVwn1xCRuK4I7mqnHEVQnHMmdEoCs=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-m03ZE9g7Mxa5E0He9gLyZQ-1; Thu, 25 Jul 2024 12:28:14 -0400
X-MC-Unique: m03ZE9g7Mxa5E0He9gLyZQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3dabbbfbff8so27065b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 09:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721924893; x=1722529693;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZ+wQu25/ua22FV3hTgwYKgkP5cYl1BWWCM6PQeMbuQ=;
        b=EHEQ3LxAOYRvsgsfjlAtZ8I5EXqdf7AzidPF88n5NMGU+UpNEeNGJeGF/lq/JjxMeO
         otOIH4r8pAkJyuWLIMvfiMowplYN/OhyDOfUq+R3AwhCfByWbOsQRzpgOHUGwGRuSGIk
         89KtRaElLzmvu13XSxs/Hono1vcQA+zpY/4BG9BQ9soTcQ1pY6HdlhF2L9To4YOhNV9h
         Qrja607u2219o3l1pFoDcGH4m+8v/2Bu876iVtTw2DP9LWRz5NJpu+7cNPTMx8JpkNcx
         VGuow88x6qpItKsOa4Eh/XbTRjIS4pBRGE+kBodw3ni6YQmrY2VTyz58ZxWqtpDID3tV
         8H/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlD97bvYdjTg8ygowf9IHLRs/h0jO8XV7h18Qx30zXjZNu37UEeORTT24K/8i8vjOrWdbxy8fY/3MBcyfWAWs7t5fTuELnLAQ=
X-Gm-Message-State: AOJu0YyZ2o0Jksgq2kMrf4CK0h568IbELv9q4YGTCG3IVhBloLEldiqU
	SPIXPltAOlhe9Fe59Uk7PJfEudoWVqmE+YY1LvSBDCRPrn3Z6vXpnlHlc4xpJkrzd4EXy8Xd2UJ
	R53rYM44xaQoEKWqz+6sdCWcKNIsbJCKnGO6OykFzyvSjhg3B9+HoW6Yf
X-Received: by 2002:a05:6808:181d:b0:3d6:53fc:e813 with SMTP id 5614622812f47-3db140bff2cmr3159250b6e.27.1721924893350;
        Thu, 25 Jul 2024 09:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMAqQVsztQReopcibpry4r4T/+OwZn5ktiSNKQro8eLj3uPSHdhUfG11WU01ulpVQ63n41VQ==
X-Received: by 2002:a05:6808:181d:b0:3d6:53fc:e813 with SMTP id 5614622812f47-3db140bff2cmr3159220b6e.27.1721924892887;
        Thu, 25 Jul 2024 09:28:12 -0700 (PDT)
Received: from [192.168.1.111] ([2600:1700:1ff0:d0e0::d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d82c2sm8781806d6.16.2024.07.25.09.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 09:28:12 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Thu, 25 Jul 2024 11:28:07 -0500
Subject: [PATCH] power: sequencing: pwrseq-qcom-wcn: Depend on WCN36XX
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-pwrseq-wcn-config-v1-1-021dce9f2513@redhat.com>
X-B4-Tracking: v=1; b=H4sIABZ9omYC/x3MQQqAIBBA0avErBswSYuuEi3KRpuNmkIF0t2Tl
 m/xf4FMiSnD1BRIdHHm4Cu6tgFzrN4R8l4NUsheDFJhvFOmE2/j0QRv2aHYtNbjpoyWAmoXE1l
 +/ue8vO8HghHL7WMAAAA=
To: Bartosz Golaszewski <brgl@bgdev.pl>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.13.0

This driver does sequencing for the hardware driven by WCN36XX, let's
make it depend on that. Without WCN36XX, we're sequencing power for
nothing.

Fixes: 2f1630f437df ("power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
I *think* this makes sense, but if you disagree please let me know. I
was sorting out configs in fedora and noticed this was being asked for
builds that didn't have WCN36XX enabled, which seems odd to me at least.
---
 drivers/power/sequencing/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index c9f1cdb665248..a4765cb33a80e 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -16,6 +16,7 @@ if POWER_SEQUENCING
 config POWER_SEQUENCING_QCOM_WCN
 	tristate "Qualcomm WCN family PMU driver"
 	default m if ARCH_QCOM
+	depends on WCN36XX
 	help
 	  Say Y here to enable the power sequencing driver for Qualcomm
 	  WCN Bluetooth/WLAN chipsets.

---
base-commit: 2347b4c79f5e6cd3f4996e80c2d3c15f53006bf5
change-id: 20240725-pwrseq-wcn-config-0b6668b5c620

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


