Return-Path: <linux-pm+bounces-15144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAE2990371
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 15:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2A0283EB9
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D410120FABE;
	Fri,  4 Oct 2024 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="akpGldQZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D527157494
	for <linux-pm@vger.kernel.org>; Fri,  4 Oct 2024 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047100; cv=none; b=jKaZIaTxm+SiFvfRd1A3W7+oPuRVFoojHTWRI+N2H2hmUdUPqi2wh9RPV5Zm4U4CQcO3tqJTYa/mT79KhxP5sCSh5ibgQ16bWvSZGzQU4qvxmLSP7VfNbsvd5iciHpqRgt2Wsgel8JNd1QFF97JBC9Kn42LbjL6ePzydAeBCCDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047100; c=relaxed/simple;
	bh=qqSKowVgiExwCTKItsRXI5m6aV4meAX5YXyRU8P+ERY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJZt44bJL4ZTSfDm+bMLfWWjAymjdldztwvjzXDUYgcVCTdD59MbWo9AZ6HNZj3SUeIMoUzFiV10EV7fsr59qvWukuXH8sUWzMc59HFaJh3DsprDv+ecIyvUvntR3R1Ns+PXggEsnrJowqfNdz3McyhP7s9DBJTfwCyBFS+IgJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=akpGldQZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso18915195e9.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Oct 2024 06:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728047096; x=1728651896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NB+OTwv7KhCxQhNRfvwJ8makfTxQYrktnchDrBIeFU8=;
        b=akpGldQZyZ0zm4B3raC+7F9urMMEAsJgCRVtKI+7lRRC8n4z3hZJH5N28IBd0ahSab
         eCRt/PxwLO0nuS7bWC7ZUULqBeXQ6bQPA+XgPFYJZI/+MortBYq+rQFuOu+PYpGRPYCf
         fQiyanj6JoGyywxQsVLKpuplgoJzed25P9l83XzBUU19TGA7LKGCNOIl1xJJKVhYxGNq
         OfQln5BJU81Mi79pou1vWBn1IxX90IaICIsK2D1XVRGnuxSm0di8uRuzHAJTrIXkARSU
         G7pOdyrgPnuEVOOhnSGFSEB507QqqUgXKMJtDBeG5zrR/HQK5Wq5UOns3DiQkrV9IGUz
         9IVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728047096; x=1728651896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NB+OTwv7KhCxQhNRfvwJ8makfTxQYrktnchDrBIeFU8=;
        b=IgC+onf3LoHbuBaZ18jrLOT+O4sJF7Y1zfzet3JbBI/IM8ryYMTvfwcrLGqCOOnfAT
         ExQS5kP1/cUqff7mZleT06rpcafMGKbh9j46HOjEWTcId2NnCIoTYauPxbBHgoERJ0hQ
         sDggEk38ic3UgCBR23OS1DK/B7dKjdDaNI8IIXOdqjcDi2dqkepTXudQtwMBFjiIp9zd
         XAkr6cpjEYzorsdAwr0tw4Ig+8xBc60pXFmO9Px2HT/dU80qSHTZ0IhrMEj6ewmfw5++
         g7GZ+gMCRHYv4usjynoueWLVUT21QlXCnWr+hq4AFVWQ0zEG5KTwgb0GUAYQpUC9OOSF
         NlZA==
X-Gm-Message-State: AOJu0YzUFAHVlWq36JsTWKWqtXz9JIyIL+6BVpRTc85KHSka88Iji1To
	Wqj9U2pOfuXQ171du8V+2/bs8D/pWODC97OoeLYZmlCadtvRUVCyb2tzR2nMwoQ8UMf43AyIhA8
	v
X-Google-Smtp-Source: AGHT+IFvlYUaMQp7mO2HKne9Jf+cx0RUIFDz10F2F9W4zeht5Ec8QoZE0iLidX28kk1iLsnrlmOCFA==
X-Received: by 2002:adf:e541:0:b0:37c:bafd:5624 with SMTP id ffacd0b85a97d-37d04a783bemr4483343f8f.25.1728047095862;
        Fri, 04 Oct 2024 06:04:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:80ea:d045:eb77:2d3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d0822b94fsm3219041f8f.46.2024.10.04.06.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:04:55 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] power: sequencing: make the QCom PMU pwrseq driver depend on CONFIG_OF
Date: Fri,  4 Oct 2024 15:04:49 +0200
Message-ID: <20241004130449.51725-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This driver uses various OF-specific functions and depends on phandle
parsing. There's no reason to make it available to non-OF systems so add
a relevant dependency switch to its Kconfig entry.

Fixes: 2f1630f437df ("power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index c9f1cdb66524..ddcc42a98492 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -16,6 +16,7 @@ if POWER_SEQUENCING
 config POWER_SEQUENCING_QCOM_WCN
 	tristate "Qualcomm WCN family PMU driver"
 	default m if ARCH_QCOM
+	depends on OF
 	help
 	  Say Y here to enable the power sequencing driver for Qualcomm
 	  WCN Bluetooth/WLAN chipsets.
-- 
2.43.0


