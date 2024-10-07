Return-Path: <linux-pm+bounces-15244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524A8992430
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 08:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5CFC1F22C89
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 06:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783BF148FED;
	Mon,  7 Oct 2024 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A6Z4Kp/F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBDA143736
	for <linux-pm@vger.kernel.org>; Mon,  7 Oct 2024 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281389; cv=none; b=SVhZyxzEmFd5r9LQ0cXe8eJp1bwd4uWwdjQg3ShkhCywunsVJjWpoVKnNnLd/YzMiqFH28247FOMkQgCZ2j4MxVUwYBJq7NOtF2VBME0Sui4oXJZ4/kVtGp2zsUREBHpTtKyq0eNh90w8kPfeMseinyadaTvq0deVzkNT6wE1Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281389; c=relaxed/simple;
	bh=2y8uH64yfzV0w3LNWnAsmQ9joLDzznVm6rctMixptTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kts/F/xB2CfJUUzvqCPWUM6cU2Yk95htKizDZjitI3FjoWlG4XLXsuo6XZvC44IyP9DQm+Vh4LuvGRMa+0K9t6Ro1yAumVlbMB8iy8ixdQt7JRtRS10KOizRNAW96b67/uyco05CN4s66JRz9e5XORES0ogV2ZzgRKblLz3LH98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=A6Z4Kp/F; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c8a2579d94so4838218a12.0
        for <linux-pm@vger.kernel.org>; Sun, 06 Oct 2024 23:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728281385; x=1728886185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAA9jPxU0BfqvqEkfgPpbiip1Qzle+GG2gZf/PhNMVM=;
        b=A6Z4Kp/FGDl/DLAbf7d4jHP3IJYM1licu/sVWI6iEmpS98Mvo8QSYQThtxumrplpzn
         IWO8iYPbIAsZg5lCoN7/QGiiGf30fSWpupFgItMcBhL7pkRdM3gY/H/69PWFqGkSFrkn
         F1ySskEInsKwaHuun9AsC8aDZAWzh62NdyOGBpLMzrGhuUER0AJ49bu9ClHWnRmp3Jun
         3OSV8Fk36yCnrg1EdjqL93FVtJlw+mTwGo9u2FB5XAWOe5/mwcDB49zRBYYwdXj9kNCD
         HUdgc7GzidOE/l1FGZK6K2ZnMTe5HPIeYDnnVGjg7zfOBLnW0NoSv5Urxdi6PMeqaCh8
         OV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728281385; x=1728886185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAA9jPxU0BfqvqEkfgPpbiip1Qzle+GG2gZf/PhNMVM=;
        b=iNz09Dnei1Bge1ZcsjBwcx89CxFU5UywrVTkVic/dNKg4O+uo7phMIo978oV/j19A5
         t0YNfkYAxvKUjMmGkjZkDtivNUKBtMfahq/6zEmCd/U5F3mNFUKW6f44mAh3X98K/d+4
         4Vmfrvo9ZR1UFUBjOmN0gNSkohhILU1jArBRuEBfBGCwtlBLiV9d+sF7gR0vgBrsCHOn
         S0FFjxuYvlVCiMlAqReNIPQumE9mqf5Vq43z5/Q3OZZEcyukSyj3QsdBrnGBzyZs4FNH
         gJ8JxT4YoPSYuhx+E+9w/hlrCiwyGtDcjFV1wSNsS8s62kCfAEC84doKl0vypbwuN7lO
         jFlg==
X-Gm-Message-State: AOJu0Yy9u1ZisUw3zcKDIFgMr1vDATooSTkwg1Mygp71fBlkraNSXQTi
	04fWzu/YNhA6LTDAKsE0HYZVrKoNio0896K16xOZbzShN/bnGzfeYEG9NwfVtwc=
X-Google-Smtp-Source: AGHT+IHhb+bk5P/hhsqwiz2jxOOW+vG1SmyFJlGritE2akoP/ChRbLdPyzWQcmKZOyMmcSrj0wYJbA==
X-Received: by 2002:a17:907:e647:b0:a8d:caa:7ffb with SMTP id a640c23a62f3a-a991bd73236mr1085273466b.29.1728281385567;
        Sun, 06 Oct 2024 23:09:45 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e623957sm337291766b.76.2024.10.06.23.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 23:09:45 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 07 Oct 2024 08:08:54 +0200
Subject: [PATCH v13 1/5] PM: QoS: Export dev_pm_qos_read_value
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-tisci-syssuspendresume-v13-1-ed54cd659a49@baylibre.com>
References: <20241007-tisci-syssuspendresume-v13-0-ed54cd659a49@baylibre.com>
In-Reply-To: <20241007-tisci-syssuspendresume-v13-0-ed54cd659a49@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Kamlesh Gurudasani <kamlesh@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Vishal Mahaveer <vishalm@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038; i=msp@baylibre.com;
 h=from:subject:message-id; bh=2y8uH64yfzV0w3LNWnAsmQ9joLDzznVm6rctMixptTw=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNKZq3mClun9NDvjU23pfk76t5yD3Fp30/IL+X3NBSoKv
 tpNIcc7SlkYxDgYZMUUWe5+WPiuTu76goh1jxxh5rAygQxh4OIUgIkc5GBkuHro5+0ZU450q2ul
 s0/vmTmrtHez4x+lYB6Jx6UPjguumMLwz3Kdz4K/Wc1bgmcv/yDDXvlXdY26/ce+Y6U577d2Vux
 v5QAA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Export the function dev_pm_qos_read_value(). Most other functions
mentioned in Documentation/power/pm_qos_interface.rst are already
exported, so export this one as well.

This function will be used to read the resume latency in a driver that
can also be compiled as a module.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/base/power/qos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index bd77f6734f14cda9f45c26538ee7ea7c3a0bc136..ff393cba7649696a6eb1c41993b26a90ff02e5c2 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -137,6 +137,7 @@ s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dev_pm_qos_read_value);
 
 /**
  * apply_constraint - Add/modify/remove device PM QoS request.

-- 
2.45.2


