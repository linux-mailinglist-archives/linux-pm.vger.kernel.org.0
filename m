Return-Path: <linux-pm+bounces-31308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90491B0EB46
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 09:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D9E1C81A2D
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 07:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A590026E70E;
	Wed, 23 Jul 2025 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqzKK+cq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279AF12FF6F;
	Wed, 23 Jul 2025 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254400; cv=none; b=ZXfQCXkouk5+PNDnGBxCHeWkA89DblH5PP2teaofClN3JRBTBrSWEAJ6GWxchTO1uWC8LZ5ZVA+Z6nCBYidcJH4GrkUT1QHbwgh27H6wn3A8q9No6sJ9b4ICkU18fXJlargGENLW+JK9nFNH3o9jg3tEZGbn6STJNROpfKQl7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254400; c=relaxed/simple;
	bh=H/ykRQohnCJBy42fi3mylO+fbnAZqRuU8bziW0Xu+Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=na5IVjeU0iWAl7ORq+Aijl02FWKgsdTiD2xUN4h30UBthNLJrheifzTgT064ZXG4448vYdrK/lrNE/x2p6HKT9ii4Qaif1/6Y3rd4x+Nh4Udq6cTQPWKTgpcEK9PfKlAAVm2xJutvVEhhE8iK0vw72AGhWdCf8ZqxkyTiQxey0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqzKK+cq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23f8d27eeeaso14647005ad.2;
        Wed, 23 Jul 2025 00:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753254397; x=1753859197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xSfEfvb8afuE48CtYIaScUPPOzcOQyPW2QSBJb+hCQY=;
        b=nqzKK+cqi7U/DLXy6NvYeGoizE83gSmc+oljkOS2tPutggj/89Tv7oEY+aubG+J0zZ
         wmSxshbdk3b+nH1WkujLcxxt2y4hpaLIfF3C3CT3qzZC/W6pa54fzuT5SfbjjizGj/qX
         gHMZT9LlBVMz0ESPgstHevtLYVYF5HxfTtOx19F+pINOU4FWDth8+PYNiM0v6SbwwBZL
         fkXKJnzlnAsVdi/4+wHcQMjonv3+4SZalfy6ug17Jo4n7swblZNprQtvwWG11cOj913t
         nhxNMBRv5Y0YfaV9jHz95er85tEtnSucLgimHlCy+B/v6UorhS1RiXZ/lA71unxA6dhk
         fXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753254397; x=1753859197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSfEfvb8afuE48CtYIaScUPPOzcOQyPW2QSBJb+hCQY=;
        b=fOs+VbduNmG8iWNH+o9N1LcIukutANNxjBzLsa4a02Ce60KH1VSjE4h2L+5Z5kyzBI
         qP8/DLzhCLIK+rwHrONgXRaLm2y5FHDU03Oa8AcCHW2ssP56LlqwBzPFmG6J1ZoUa3X4
         ERcBCFtsF684j3DBn8KFHGTrQAABcpmW5fKuzdwHn5di96xoExjDrvsYzh5GvnlsNIhA
         GW0YF4e8oaHQryNyJIFbjyGMvqX/SQi0UyE0sXePZf9ngEDUhs8lSfxczQUcO2ukkG9G
         fCAIrXSAC+jnriBV9zHiXYbVn9YXtMz4WF150fpYLzG15ue573MxbyfGsDFPscqow8DZ
         oS4g==
X-Forwarded-Encrypted: i=1; AJvYcCWX+418JViZnZHt1/cnM//4YwV3dAJ1fZKyQPtGKWBIfVIp5HnLQrnacDS6xB2yj9693R3CVLkJcn9UaBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPSA1cwLf1uG5mk2E+k2MZh/Ebgh50cuqriDSVeU0qiGiQjlDk
	Poiq+b+yovzBe/8IHknLGfwCkxb/gY9E02mHGlwttu/m1RbKzjsecP30
X-Gm-Gg: ASbGncuWP11WJSP3vvvEipDQ36fPWok8ta4eOHiyvBir05sUjZkFfsMs9xviDdoINiY
	/OJGSF+KwFFv/9lCuz3+bXC8TbzfkSiJwbTzw012k7qR9MXCFRnDt0hgKYCRcZDLGmjGMw2NhMa
	s1pKATe1kzexD9I4iHtQtFe44wBm6pqve2SBcCg+DrX8o/tZKas8qemBUHcQ6FQ7YVRpqxCDFCg
	2njFY4Pk5eIRLlXVi6LgyQUxFHi3wFCZGEdRRYevaDFvvFUr9aCtCmW1vKuVqKnddSGNdezw3tQ
	xw51jvSobRtGlfFMGIS45LtyP8pBoK/MEewIeylSzA65GaH6EuEorJufLo+T+17qTUsiPaGAMy7
	GnL30o7mzu+05j83iST1LmITc1i2cJmQQWx9288qWRjSTqoiw97ytDI21skN4Pr7kR11FR4P5J9
	vxP0Gv
X-Google-Smtp-Source: AGHT+IFefdirCzH5nMP0LOZIgRw3WIB0n3LunUIKHLBVyYlwoO7rUssyGOsIglA2MVE3IsZShp7xEQ==
X-Received: by 2002:a17:903:944:b0:23d:dd63:2cd9 with SMTP id d9443c01a7336-23f981d2fa9mr26782205ad.46.1753254397238;
        Wed, 23 Jul 2025 00:06:37 -0700 (PDT)
Received: from SIQOL-WIN-0002-DARSHAN.localdomain ([122.170.64.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e51a66c33sm912153a91.28.2025.07.23.00.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 00:06:36 -0700 (PDT)
From: "Darshan R." <rathod.darshan.0896@gmail.com>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Darshan R." <rathod.darshan.0896@gmail.com>
Subject: [PATCH] power: supply: Clean up spacing for better readability
Date: Wed, 23 Jul 2025 07:06:59 +0000
Message-ID: <20250723070659.12784-1-rathod.darshan.0896@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixed some minor style issues reported by checkpatch.pl. Mainly adjusted the
spacing around operators and type casts to match the kernel coding
conventions. For example:

- Changed `gpios[ndescs-i-1]` to `gpios[ndescs - i - 1]`
- Added space in `(u32*)` to make it `(u32 *)`
- Cleaned up spacing in a `for` loop

No functional changes — just making the code easier to read and consistent
with the rest of the kernel.

Signed-off-by: Darshan R. <rathod.darshan.0896@gmail.com>
---
 drivers/power/supply/gpio-charger.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 1b2da9b5fb65..2504190eba82 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -79,7 +79,8 @@ static int set_charge_current_limit(struct gpio_charger *gpio_charger, int val)
 
 	for (i = 0; i < ndescs; i++) {
 		bool val = (mapping.gpiodata >> i) & 1;
-		gpiod_set_value_cansleep(gpios[ndescs-i-1], val);
+
+		gpiod_set_value_cansleep(gpios[ndescs - i - 1], val);
 	}
 
 	gpio_charger->charge_current_limit = mapping.limit_ua;
@@ -226,14 +227,14 @@ static int init_charge_current_limit(struct device *dev,
 	gpio_charger->current_limit_map_size = len / 2;
 
 	len = device_property_read_u32_array(dev, "charge-current-limit-mapping",
-		(u32*) gpio_charger->current_limit_map, len);
+		(u32 *) gpio_charger->current_limit_map, len);
 	if (len < 0)
 		return len;
 
 	set_def_limit = !device_property_read_u32(dev,
 						  "charge-current-limit-default-microamp",
 						  &def_limit);
-	for (i=0; i < gpio_charger->current_limit_map_size; i++) {
+	for (i = 0; i < gpio_charger->current_limit_map_size; i++) {
 		if (gpio_charger->current_limit_map[i].limit_ua > cur_limit) {
 			dev_err(dev, "charge-current-limit-mapping not sorted by current in descending order\n");
 			return -EINVAL;
-- 
2.43.0


