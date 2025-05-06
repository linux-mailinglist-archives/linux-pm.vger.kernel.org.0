Return-Path: <linux-pm+bounces-26742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A1BAACA62
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 18:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5AB5250E6
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 16:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4991283FDB;
	Tue,  6 May 2025 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCOMCUnS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328C927FD6F;
	Tue,  6 May 2025 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547367; cv=none; b=qRD0KhG9901gFYQ6vdDZ7bnY19LI4WvVij/utrtZ3xs2ELO1wOU7k/QP58D8kweZ1cuUbCQwVET/0MPVK9Pvxv93p+roQ12CTRFv497O6Hba7wOoVqUTZolbvWzzxfccAm0YTU5URrlqw20pu7zrOg05zkJG5Xkp+XwVA/m18eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547367; c=relaxed/simple;
	bh=qv10xryQ+mAog3l4VvbVHJ0HbMIQA75QU5IkGTZPA3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HaDRH8D4G3J8aac8dvSgSvuoGSiVyJKCmerUScrYTUuTR3mFPCKSXJ/OJZacj1PzncDU0mDq7D94rmZWAqQ/NJEd+opUbBalNb4yZq3ioXBngBv/Qco1jntbafp1mRYV82Qewwn8EPgIifr4c2KKZlm3/IGXWtYJ9hBdDjW43og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCOMCUnS; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30a89c31ae7so1085964a91.2;
        Tue, 06 May 2025 09:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746547365; x=1747152165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UxqQI7I56Bh3kt4m+ML+aSANba97iFsyz6IRsFIn500=;
        b=WCOMCUnSglpj+1OMRc3c//01ybXU+np3fhMbod2RBBCxCxdn06b+7bsWKMVeQAgrny
         IVsCICzw3bFmJbvwhAKrcv4SN4PhP1G5wr7NJkzRsfd7JaoM4Vb+6+ViAvRHyyHxjVEb
         9sKiajRRL9wnYVvYsb6SW/YpMag022LYwtQ8AU8ROSpJfTqyMA4Ftkjkq+feUWmmc/uS
         L5cPjyY7PXIPlZqVzi0Fhc0pSAfslSvZYRXWKYv2t2+wl2VJ6Iw+Z/P4My9h1wwFK0U7
         MvWjCLE/46jTBWZo0y+qZNH2fqx6Ixj2vKDLVWYeS6zeqt4oinrrXpN+i8Wz8P4QMt3h
         CM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746547365; x=1747152165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxqQI7I56Bh3kt4m+ML+aSANba97iFsyz6IRsFIn500=;
        b=b/coxJkqNUOx/c+Hwhr6bl1eZIWDwkhjR1oeL8jx63XP+4e5jkaxPdao6HjgZnRVN6
         v8wXG5cv0aBcvXxo38bOt9IZRQuHNgN0dBlKz7SGNyEUuZtvfZ5IqToPFPgKkd+8shuK
         s5fpKEKVji4qLElIrnGBVXB5OLcxeiTygTx3OUfobTs4q9zx/3+lzGdGw2p6YLn/Cw7D
         a9EtnXobOGlBhwN0+HqOojIdB69y/+Gi3MDkQhHMsdkugO+4sA3M/ueJpbKQ+6i2OSjT
         ACOmDYmne3TLEWTYkoP8jjpweOf5wypJklnV2e2DBFQ89MpYVOa2GdpOvPFueohCH7ay
         cWGg==
X-Forwarded-Encrypted: i=1; AJvYcCULfVmXLqjm20zOYcymBOslP8zXHI0ov7l6OiwQHPN2thyrzRogktlLYKtQTtITAd+CU7iTulprTY0=@vger.kernel.org, AJvYcCUjdJuzmhthWDKwgYisqbEtU7nVV951Yd4/+ckCytRaWoP+iZRMLOvl0bV2NbDquQB/bUHp8mB8QAwDqPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQPjIV2qoNyUyISJpVFu9lMer49dPCDh4S9Gi/3GAXwOy+Os1h
	MPBykp4rVimDlMLFsdCjpCYecZGRop7YkuowqCHAqP3SsdkxrW6O
X-Gm-Gg: ASbGncsYllLbT/6yDQ9PZ3lfQkAJDdZolaVoURkn3Bnugjp8X53yCJ4Ss2QPkH+u/lQ
	L5ylMPrkgFbkwDVzRAySFvnj+CjRPIw8/CZZrHzQuuiT4xFZYZEu8r0iH43OLM+uVmi9a0MSf1G
	GTxtNlLgRrhEeTqCFOeP6yx18WQWlquhjyJBVUqKhtGenmBDRgXoQ83IZcZWecTPsZc1rTelN4c
	XxMQGbVupqa8nLFMjX+urMF5WbSqcGyZXko5Gu8qTE3WVC3G5DT4aHDp4OJ91gn6FC4E9AT3Wng
	3W1RyYOk8AEDtq/GIqcY1HnwwBULyAvbSelkCLV6Fd3XcUZ5+DhUKS6bhTIiZr9/V0J0WE4fSYV
	vHIX5SNekAn34yViM+sq0RUyQL2OoIfLocnI=
X-Google-Smtp-Source: AGHT+IFevtUyWuSHvitYA7wFMvLwVik5JEG9Cmh0lTuhNVyWsmzQmvCZvPNXnXAFKtjlJybF/J+4yg==
X-Received: by 2002:a17:90b:3c0b:b0:2ff:58e1:2bb1 with SMTP id 98e67ed59e1d1-30a61a6f700mr15118582a91.32.1746547363134;
        Tue, 06 May 2025 09:02:43 -0700 (PDT)
Received: from server-kernel.moonheelee.internal (d173-180-147-14.bchsia.telus.net. [173.180.147.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e3b56576fsm15996285ad.47.2025.05.06.09.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 09:02:42 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org
Cc: len.brown@intel.com,
	pavel@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [PATCH] docs: fix typo in energy-model.rst
Date: Tue,  6 May 2025 09:02:29 -0700
Message-ID: <20250506160229.3720-1-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a grammar issue ("than" -> "then") and changes "re-use" to
"reuse" for consistency with modern spelling.

Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
 Documentation/power/energy-model.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index ada4938c37e5..490ddd483f46 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -230,7 +230,7 @@ Drivers must provide a pointer to the allocated and initialized new EM
 and will be visible to other sub-systems in the kernel (thermal, powercap).
 The main design goal for this API is to be fast and avoid extra calculations
 or memory allocations at runtime. When pre-computed EMs are available in the
-device driver, than it should be possible to simply re-use them with low
+device driver, then it should be possible to simply reuse them with low
 performance overhead.
 
 In order to free the EM, provided earlier by the driver (e.g. when the module
-- 
2.43.0


