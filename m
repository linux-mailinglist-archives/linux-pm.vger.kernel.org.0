Return-Path: <linux-pm+bounces-9233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5019099CA
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 22:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6518A282EC2
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 20:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BA9179A7;
	Sat, 15 Jun 2024 20:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mob/YZsc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A91DA22;
	Sat, 15 Jun 2024 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718482190; cv=none; b=GqnmUd4blnzBlrwPcbCm/JeVxoKFBNUyzM3TNS+aqfF+xxXh0wbugn46X5RBvpycVCEH9mnCdedkpeEGVJfD13AQDhEmv8/AS7c6QrBlMbTBlIe+XQWcdnTQ0KwTa6v/MuFpo1HcfA5UpgtmdR/Ch6CSSQON8KDgEERzBKUBJR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718482190; c=relaxed/simple;
	bh=102A/KOEpDDo/TLDjfeWsbMTt2xvPfW/81dCfzVuQXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iBABZei+0m8jnHtMvUM2Xpd3kQO0V9d2+xbdJ+W2RMeZCLQWU5Z2N7YXCCJpqObzssgoyGVhKs2rw1JVx4E81crrRq/htoYTTA6j93+r6GizPfiUtj9klw0/WdpxSAIDW3Z96ift6MpjOWvqbhXbn+JNMiIO4F4CwFVJdIhDBfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mob/YZsc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421bb51d81aso25276665e9.3;
        Sat, 15 Jun 2024 13:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718482187; x=1719086987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qekzv1Pjxa21XjTH1rMq/F/4yoyBM4XQ1KDN2ub6Y3U=;
        b=mob/YZscfoQYSP5M1Rwqluyrnghy1iwe891M+31lCdyxT1UNo0nMx7eYi5FvktvTX6
         5mCNJ/amXCats0ZQ3hljSuaqnVjINzkMaoo3jueosl0tPDy1xyQpbZ82fTAQYBPh2K5E
         dq5TyiVHk5isJQN0pOw40l3cvlNNbA+wIogwmph9oz1JaJQFnOzf0kIH/90up+Smalod
         8meiCZeFd4dWahpH/QJ0w0wd65CjMyfXHf/G3jEgj2KILQDCRGxynOaqmwgOvX7K7fs7
         SAYNHGubYfsQkuJ863QDUldDJ8bIh92pbuCBvMnV5cQd5dUqF8lAUiFmHgRUTimuS3Ix
         9o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718482187; x=1719086987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qekzv1Pjxa21XjTH1rMq/F/4yoyBM4XQ1KDN2ub6Y3U=;
        b=U5ijr8xA1/FutBro1IhZuMykAJ6bv09e2kTaS4dM2whPk38VxJrj7LKQSJ2KO9r4DI
         FkAgfZfFzL4DpquCQhoFN68RQwgpXfOWAM/tKF+x7UOOBVMkIrZz3c/8RJbInR2Y8QT8
         eSZE2nDSBOph5Cb5BvqsNzS8j1oqaiufFYVeGHFCFEbrHTfcjBl4XQB8PAgVtWGeWncs
         NNIoYE2p67efVOcHp7fL1xVq6FX9/CvhzQrYAxT3ayr76HhzoRdBodpy8kipxpukonCF
         9scfpbESqXNPocrhVxcQgGDEptEvRncOnB+chQ9AQRmp7lMD/n7DcSKkktdngXlxCtWP
         p43Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtgm+8lR3LDqwDNFv1NrgE5Md0H4Xx0l/gzR6iNKELG9r6cgovEeZU1xOpIFxuvA7RZ85gaj/bYtxd8dh4LqUowAOkso2YSSvQH3ZLC+OnU+reQT+pd87C9d+enxZlVeCNRr+RbqQ=
X-Gm-Message-State: AOJu0YxmVBb1WsV8oXxjf/o0r/8jjN5nCy8QAQcnQoBbWgEUhWvGaUXc
	tgv3tHKVm6GL+eZE7jzZe9aKQ2fpZlv3HmhePEmPiFCue0+Q7h9p
X-Google-Smtp-Source: AGHT+IF8AwdNHvMmXmn7ytfp7ciNbNtue8N3TYSErskeTv5MR7yIMNh2ZDOSZA+ono5j9A31KVZ/kQ==
X-Received: by 2002:a05:600c:1e20:b0:421:dd8c:3588 with SMTP id 5b1f17b1804b1-4230482c204mr41595885e9.21.1718482186892;
        Sat, 15 Jun 2024 13:09:46 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a666sm108510915e9.45.2024.06.15.13.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 13:09:46 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/2] power: supply: add support for MAX1720x standalone fuel
Date: Sat, 15 Jun 2024 22:09:30 +0200
Message-Id: <20240615200933.162394-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes to max1721x_battery.c:
  - reading manufacturer, model name and serial number is only possible
    when SBS functions of the IC are enabled.(nNVCfg0.enSBS) Factory
    default is off. Manufacturer is "Maxim Integrated" and the model name
    can be derived by register MAX172XX_DEV_NAME. Serial number is not
    available anymore.
  - According to the datasheet MAX172XX_BAT_PRESENT is at BIT(3) not
    BIT(4). Furthermore the naming is misleading, when BIT(3) is set the
    battery is not present.
  - Removed DeviceName, ManufacturerName and SerialNumber from struct
    max17211_device_info

Dimitri Fedrau (2):
  dt-bindings: power: supply: add support for MAX17201/MAX17205 fuel
    gauge
  power: supply: add support for MAX1720x standalone fuel gauge

 .../bindings/power/supply/maxim,max1720x.yaml |  51 +++
 drivers/power/supply/Kconfig                  |  12 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max1720x_battery.c       | 324 ++++++++++++++++++
 4 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
 create mode 100644 drivers/power/supply/max1720x_battery.c

-- 
2.39.2


