Return-Path: <linux-pm+bounces-15075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051F298E3AA
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 21:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 603A3B2363B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 19:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D239216A0D;
	Wed,  2 Oct 2024 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AQnN4uzr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB322141B4
	for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2024 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898300; cv=none; b=Cyje0v6MXCKUifbaXfhL1EVYqxr5PMZ509M7PJg05IW3BFZpM55JdFujcsOlwz4qjbdBJlYCzFjdaq7Mz8ghtMIbtpkgu3sJPKJrzdznyVO0aE11M/iZQS1EnPkGhn3HKFlPRLW45dSJl5yNVgA2KVAToI9k144kq3xxLKzY4d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898300; c=relaxed/simple;
	bh=wR03qyv3rnNLJ4+4W6CR03em8xujXadJ4svo+mPVpy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JGx+jfaO5eOxzkQV1kX1ZxKdrU2EzQjF17Y2J9jUnrjpEvFXltUqD/aMrHentqyKoy7vRCu1t3i5WRnoiIqckVF/OgGZvJfmy0/G3j7gyuMcTHMrTYYNFJhEIg9denYn38pax8lxFlzLctF86gqQk7KAjYELhBWmubgvefXRtfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AQnN4uzr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so937595e9.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 12:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727898294; x=1728503094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eaZBiLx4vvQaF78fB45OuDsdyRmEPlFfuMU6svXdEjg=;
        b=AQnN4uzrUqBroPS6kk2CUw1Ga+FN6puvtxCHF5LTwnQVpjcRk1TgWZwmdLMDOYut1i
         gBLKIdHza6SffT6I00e+EAywVQlEZHI0qzoQLdeDFeJvQRahhMA4iMOfBXRJhxpaK11i
         htvRxl87qG5KXSeQD/SD6MKlXPQ2Q3PUoibsYHQCIwDC7smIVXgfzPp3dWnjIG/QrVlF
         CLIuGjB7I2ou26W1fYKoqrQFJsvhhecCSnbbPgpqSUi+sn9k+03OiQoz3a9yhmRwr1QR
         MOLEVg7/hMglzxbUYQdEjFo47FPzaMH0l9Pw2grVz8YGEvKBTI44XPCmB0w6W+oMgnBe
         PLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727898294; x=1728503094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eaZBiLx4vvQaF78fB45OuDsdyRmEPlFfuMU6svXdEjg=;
        b=J2g+80wsEtjZhwlmrbIUM34cg7QrFnMRYDVV9IvL6ox5EfBKWz99WS6yK164t7UfOo
         pNAF9OBPeYcjPo3Yz0w3lQ6NmQq18ALFZCckhnFsILbL7TuwanQJw4nLc4wssBRE/C9G
         fsoaCR6UAqW1EQ6pLyommyp1IlIXnTY+8+ft1peHa/YuYwAHVXisOnBthrJsxT5BGJBi
         f+dMGqn36xv9BugEOoPU3LpbGaPIIt9HUXGuc4Jg7Pj1SZ8y7QSTqpQrTrFV17Bbk7Bx
         J2NtfVlIeM72/7WXIGJm/6UDm2WT1lldtXUT6qySZoummOBOk1i6YCezF/EwZb8kJYmq
         YzHA==
X-Forwarded-Encrypted: i=1; AJvYcCX3vAQOfe1hLnLoacLF4EUeLAf2r8GVjm8C8v0rH+BFgUgK5BdGpwHIQzDK4RedazAvvgKtz16f2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk+Y5cRmFnWLk4fAZRcUjY8U45M6OQH2uWifUk9N9s8//60v4Q
	nLkJQzDXJQJv01pM/pFuNnein127RamVtf9sszEm9lLcKPULUwUi345t2lDRfX0=
X-Google-Smtp-Source: AGHT+IGm5PMHhlLi5YFsfyGGNIixT6A3/mNucPlJSqwr+L1RehYxRKM+lc0KKtFad+lX3yUuzyGxVg==
X-Received: by 2002:a05:600c:190a:b0:42c:b4f2:7c30 with SMTP id 5b1f17b1804b1-42f777ee74cmr26207735e9.23.1727898294317;
        Wed, 02 Oct 2024 12:44:54 -0700 (PDT)
Received: from localhost ([2001:4091:a245:8155:f78b:11e0:5100:a478])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79d8d3c7sm27690725e9.4.2024.10.02.12.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 12:44:53 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vishal Mahaveer <vishalm@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2] PM: QoS: Export dev_pm_qos_read_value
Date: Wed,  2 Oct 2024 21:44:46 +0200
Message-ID: <20241002194446.269775-1-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Notes:
    Changes in v2:
     - Rephrase the commit message
     - Move the patch out of the series
       'firmware: ti_sci: Introduce system suspend support'
    
    Previous versions:
     ti_sci v12 https://lore.kernel.org/lkml/20240904194229.109886-1-msp@baylibre.com/

 drivers/base/power/qos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index bd77f6734f14..ff393cba7649 100644
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


