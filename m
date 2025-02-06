Return-Path: <linux-pm+bounces-21448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 807FDA2A304
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 09:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF82B3A0736
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 08:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450A82253F7;
	Thu,  6 Feb 2025 08:14:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9707F2248AC;
	Thu,  6 Feb 2025 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738829691; cv=none; b=CK7znTscdhjJul/awVzEtFJKzuxL8MwwLZCARnb4CH6lGHZLNlkUJKEzjfChaxP4ioc+hSuL63Uj7hUt3/ZysOkguY9sFV7GwXTt4zJWTSevBo79YTp+vf6T80NKaQvi+9AxsPAalqUo5kYLdlJVtLORVhsF5OPXESy6yGe/Nxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738829691; c=relaxed/simple;
	bh=fZPJH3CSQdODZnXztNoSbNZTgj6pLu/fv3n0LbAubpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m8hylalT506Fm2rX8+pRMWepEnB3I0M8kAHMOKeoBp/pjw3BrlkCrCGjYCkd3Pl/w7fUXzJUoWtL8oBaNV279NxtREZnJpYSz8yayHhrWFwOyV7z32bgZse+c5p71JkrLZdBR5UmXnyOmXJFcJztLn38JVJoHJDBRe9K4MSKJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2164b662090so12596465ad.1;
        Thu, 06 Feb 2025 00:14:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738829687; x=1739434487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shv9SKnTKLaSrjwCnFD2VxR1ja3MKQ6r1lsFRhAb5Ak=;
        b=PDctM0uaUiYt1X0KnkmtoBZ1sjCN2YsB5maMPbCx6mfvAfmEIB/GtLSW3Ondt7R8QE
         nYAaDK+FQ7qim2/yfk3R1cnvYvttGHEaw3fab/+vXFPfDVCgv5Z1vH5D3JUXs/sASxje
         Axw6Jlgjh37dbcTB1BCCKGHE1Ah6LkF9qQwWTZ4dMFaY2ORndaV9B8ZmpEnPjJsX/QDf
         9TDHfIg32Ye0Ej6tv3TSOSirFPO4TqZ5Fn1MJw+8MJiWI0uJtYA1tsO93LdnUta29nSg
         9YMqz7hlcoNnLx1NV+VxaubQgIsBLYll727XNfxEUGaPuK6ppiC+kXa5aGfl8zjHQdAs
         HIvw==
X-Forwarded-Encrypted: i=1; AJvYcCUwB3Vn2WhJJXURUziVRAtlIf1FFxloJaykC/UmpJGr8pAY9u0FFD800FwVxFWZL+0vBkp7fAWcyZ1bYgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSernlf1Sg8XJkSwFH1hl7SayHFlnBL7/JLR882vhjJRsut08m
	+SKwj9s9bLzexikyy7DNLyENWRIlU2pbtSFaXH7qGrE3Na8s3m9q
X-Gm-Gg: ASbGncvvldY3NHKCjHPjjyMbnMHBGyJY1/Qw9uV5cHHnmdUAvkcvsBf/qB5p3ckmCjL
	K7EWehzGRVu0Gygx961XgsU+9hFiSGPziZji6bHsMDToXxIi7Ts1TbI9sGXmyk4w/TkDvfQPn+s
	s1DPYMizDqN+TXDBk1j0u/9LOrD/yUuIHHhSv8Ac68daBA+kmQSfNMsBPWbou4RUTLBq0GhNw78
	hA/AJ7UFpxUX0e9EGoxQaOPJWnx4dpo0N4jpaSGN6wQuX2KacVPi1LDJOPB2E2LcJDgrOmA0xxW
	uPNJTftpphdt1H2GFdgHRUc6veajYiXJk06B0iA=
X-Google-Smtp-Source: AGHT+IEZTeo1QpxSxkiB3PklNj/CzA8+OdYiqecMnSaS1V5XcJOXplVmCulJZztjBU6ix5vCqvUGOA==
X-Received: by 2002:a17:902:e74e:b0:216:7ee9:2227 with SMTP id d9443c01a7336-21f17ebbb5cmr102798745ad.36.1738829686461;
        Thu, 06 Feb 2025 00:14:46 -0800 (PST)
Received: from kylin-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653acfesm6786855ad.65.2025.02.06.00.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 00:14:45 -0800 (PST)
From: xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] thermal: core: Remove duplicate struct declaration
Date: Thu,  6 Feb 2025 16:14:36 +0800
Message-Id: <20250206081436.51785-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct thermal_zone_device is already declared on line 32, so the
duplicate declaration has been removed.

Fixes: b1ae92dcfa8e ("thermal: core: Make struct thermal_zone_device definition internal")
Signed-off-by: xueqin Luo <luoxueqin@kylinos.cn>
---
 include/linux/thermal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 69f9bedd0ee8..0b5ed6821080 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -86,8 +86,6 @@ struct thermal_trip {
 #define THERMAL_TRIP_PRIV_TO_INT(_val_)	(uintptr_t)(_val_)
 #define THERMAL_INT_TO_TRIP_PRIV(_val_)	(void *)(uintptr_t)(_val_)
 
-struct thermal_zone_device;
-
 struct cooling_spec {
 	unsigned long upper;	/* Highest cooling state  */
 	unsigned long lower;	/* Lowest cooling state  */
-- 
2.34.1


