Return-Path: <linux-pm+bounces-13020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8531B962381
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 11:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2281F21CCB
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 09:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C0A161321;
	Wed, 28 Aug 2024 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boAJWQv5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D063158DDC;
	Wed, 28 Aug 2024 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837692; cv=none; b=bOq7Q8yQNRoYmVHfq1ZiVoJNsiElj5PimJ29UP0w1GAOaBdTRqlwDHFioljTzQMLqb85mMVtPxTTlvK3BJTPw7Kid7EYY/afl75kQhAU7EF7OQlHHhFuJioLh//c5x1wqsY3FXUzvmQ+lUVczLgGOxmxPUFvPGSHnJ1DdU3SUag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837692; c=relaxed/simple;
	bh=IUnqRlbr0wiz0/0c6/AwmbAy7u1uF+9E4klP56kBXxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HZBY5rJhWeenJYITviWbRrfNY1G/Rl5ngaETmpOtlxgKsprwnbWVpUJLij//oH95ojFjN0lO2NQI/oIMyxC9CASYMkU38+ipitPO4HcMELe0KEPlFWJVJ3D2F+UdIv305hYptIrACfaFBu+FnN/y2FwQfyflvO/TRmaSf36YRY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boAJWQv5; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso2186665e87.0;
        Wed, 28 Aug 2024 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724837689; x=1725442489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xvOsbFqyxy/I/yBNj8feA5YCODboFCH7uLFBn1jcSpA=;
        b=boAJWQv5XIVI9RcXtBhkmlXUi8GuWfHqtzdNo3kAaE+kt6md8GuAgPqAzBf/DdpkcC
         Yd7bXrthv/ZqBb4A7k5tEqHQXiM8l76tCNVzUcqHor/PIotAeNDWOv6lxqjWIKoe41jk
         e/28NBnwrQQabr6LfYlZj5TQjWXju8BoQZDdhTV6ZI0fjZyrYOszDwV4AxqBpXIpP5L8
         xr8HoL5ukxMRVWBxlsAj7yc2tBtl3URsm1Ncn73voycqSgimWxlZwXrbTgWOuEcsu/Xi
         PSbIjixEiyOsgZKrtaKcp1tGqWpowWkLt9JgKgbw9YgVZpvTJ8TYqT0foF/egProjUme
         visQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724837689; x=1725442489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvOsbFqyxy/I/yBNj8feA5YCODboFCH7uLFBn1jcSpA=;
        b=Qhut62bqJdA/UF1fMd3QpQfmABxIg9jU61Hy1Gr+9IWA39ZB9WnRTOPA8Wf/PXnhyp
         FdBK7M0h5dDtO+PNV3sqBsKsaLTKLU5M56WKbKa39+W2WJ2qB2UORNF2fUGXrjRdJudi
         8JzU1+RvfQXhZ6N6VlptIsElsHEg7J1BiJaOGytYoQE6dC7Zad+IN863vE8fgrlD7SlR
         ZH2x7IV5uUcWhD/vvauJObP3lPj7XTsCRNjHlXYS6NwythlSc6PTz0Js53CKLz32oJzP
         X1NVP3Apx+IuLSN22hfokFKwmbql13Rm1RpaT7+Bdf5kSl/besKmeuywcNMWBXSTyApX
         e81w==
X-Forwarded-Encrypted: i=1; AJvYcCVLb/KxvQvplY/krRv81c3dJaCeJl32fzfkrQqjn+pMFAdje/261UHMmBbwpCyLHRS7JlfpJi3vNX7pdxg=@vger.kernel.org, AJvYcCWM9K4S8ivuTRohPdKncVRHm+tUFIuHt8eHmgdbwRY/YbYn7XMxwRPgG9ijDfvIWtvwNvHAPzYCH1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YycYhfoow28sxTaqBAn2DD2lk+dbXF5BpKxs4Vhyb9Cj+ihXSc0
	JqX2YrV8OurpAr6jGiliTUi5oCH0XszvPViUp2cRXEcWRtVldf4Y
X-Google-Smtp-Source: AGHT+IHqZY+GwoxSkVEtuDNFelr3AU2O0zp5bxBRDGF6GEE/fpskmq+uEcLqysuoVOlZepYwyix2Vw==
X-Received: by 2002:a05:6512:3187:b0:52e:f99e:5dd1 with SMTP id 2adb3069b0e04-5346c763522mr957117e87.47.1724837688773;
        Wed, 28 Aug 2024 02:34:48 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5885fdcsm217462766b.163.2024.08.28.02.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:34:48 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] power: supply: axp20x_usb_power: Fix spelling mistake "reqested" -> "requested"
Date: Wed, 28 Aug 2024 10:34:47 +0100
Message-Id: <20240828093447.271503-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 69fbb5861934..ab45ee6c283c 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -326,7 +326,7 @@ static int axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *pow
 
 	if (power->max_input_cur && (intval > power->max_input_cur)) {
 		dev_warn(power->dev,
-			 "reqested current %d clamped to max current %d\n",
+			 "requested current %d clamped to max current %d\n",
 			 intval, power->max_input_cur);
 		intval = power->max_input_cur;
 	}
-- 
2.39.2


