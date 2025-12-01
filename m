Return-Path: <linux-pm+bounces-38951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA63C95B7F
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 06:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60B0A341C19
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 05:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D651E5B71;
	Mon,  1 Dec 2025 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxOQF9fq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F636D507
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 05:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764567642; cv=none; b=GPwYm86J4txYlVw1sL5uNMyGY9GAlEHWzHzWfrERhTn+65frbLhtQQf//n7D8hOJNZ0r8iGppMskYw7Bj0+dTr9hK6Vq/7fKx2g1TwZxEyj6UwQEzBgueeCHRnmtRzLUiOFM1XmOk9geCV6s85SNA+hnY6nG/zkAxaRx4o60xxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764567642; c=relaxed/simple;
	bh=i84UjIwB/xaOLefwSmhSEoWc+88dc35YUoTbp9vboFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ST8IuAhwnbowq/RNF0zkMvwIjVQh9IumyooEVm8AtidtGPx1v89t7CdZLJneT8VWhSKFuMvPNcFd+SGAmjaXerKjbEV6/mAp7x/yWf+N0Uwg0DU31XKNLFveKxq+qSTujvrpi76rH/HDkWH+VEpZMznKbhSBRajV5Vq24aLCpOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxOQF9fq; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ed6882991aso30623301cf.1
        for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 21:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764567639; x=1765172439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oODZ4jjUfe8LH6AMdKLLAyWgu+6E+7Ez0x3Cvzx3FaY=;
        b=KxOQF9fqdhlhhaKiBaVIm2vrxzPLADKodjlIdjyHtoOnx11OlLvx60AhDKUmVm9TFR
         ukOL2Rzoy9jsg/EQ72c40wM6Q1dguIV1UDFVk94Ids+V4rpi5UynogCrjqFSs8ogBwq4
         Ozdm0vKtZhtgJC2q9+RFRnaVSnxEZQALVXX+ZhU0fWwQCIhv6xAePuIF6gHuIdhfUpZ1
         qzLYLwnz9+FoBiYMeZLr1Z1qtuiZQgrIRfPCRdgXxarIe4pmCg4Yc8JA3CApayRNN1VS
         u9bwMicJmXPnv45vri6a/p/rzVNqsKpo+lpGxNpI5mxUXDvq/OL7ptPSnORklGzyYMd/
         VgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764567639; x=1765172439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oODZ4jjUfe8LH6AMdKLLAyWgu+6E+7Ez0x3Cvzx3FaY=;
        b=XZuQnNjgbzk4dXiEpJDxcgQnBnVJHjC8OE2pQKr22ws8vFCj2x3U+VSZXB51agUIYi
         FMh7BUx4IrNLxHHukWjvDz5Cz2n6biRXhdzbLIY+tERcqrB+g1z1zBmr0r7yKcHsVC0u
         ywlM0MKUCv8VDn//EoSuYvlv9dvuKsCG66I++N00t+WziduaHV0EPTl8ishLhibCWj0e
         VRd9ZamGjD3beOGl9ac0JfGU4B4FgVulpyFtMuxP18I7lwoJ6PDZ2C2t5db1e6ioHvg9
         6Le+TaEucCaMl3EK9tkNoEHFaMCL+VK3p8c+vTNNv6X0d8y0HI1d6qEXG6UWDUKdNpdk
         7JKw==
X-Forwarded-Encrypted: i=1; AJvYcCXqkxfK++I2mget8IrwTNSLyyZgfxFOHJP2m5k+x1Hwh7mcGdZ7oqcFgx/WKwjtWDjQ0hNviZgS4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEILj5FCKlJGbWl9EDTqn/UNXB5USyn6cIlOhhmFExF7fwMRUt
	U26MPrVWpskiwZnjU9HuukD6yMi8GgaZ4AlTgMVCuNgTmFsMykAFiihU
X-Gm-Gg: ASbGncttJ7aKIU1JAHbemGcXGxLpwwZv5AH3BXk2Ftt3NNAmqvi5E+8t83R7zTaiGmA
	hLfitMQPS5JUobHmh7kbb/ih2quRWpPpkmx/8IhjN9AsG2r3QUjLUIQlNAN+fyM8Owe/tM8uIOU
	GeTgqNwVkoMKFvB2iGm/xWURhGvSWjGX+9lgVYEHqB0seOzR1SEzLArenIKhcNjk0sWykpdAVPc
	9CB0kWY41lqHuUkVi0jsWRgXDSQE7v66OBDCa41LTH0BUwgtLHl/RJi/odzpXnrUXnXxnhwyL1X
	wFv2ahSi8lK8kJQZjGxeUYIEVVuSJk/6kSPlV4gv5Esx5i3/MAvQYG30oAiMh2ZxpFnlVia+gG2
	gcxAh2ukfyTLemwGO6SHuGle6nnSj/8t1RRIp63aMYBcGOd2fkW8XWN9nfE382T7zkT13RFehDy
	q9b4hR9K+Mk03av/15p1AK+ELl9lYOxY5SlusailUcux8ocfNCD3mO4Q==
X-Google-Smtp-Source: AGHT+IF73fkM/rUnS9ThMfsr9brgN0vdiKzPkhghw/hdBJlUXZhFDmRq5tEHmX10jjMnY4Xt7cSilg==
X-Received: by 2002:a05:622a:1998:b0:4e6:df3e:2abe with SMTP id d75a77b69052e-4ee4b444841mr550393971cf.9.1764567639483;
        Sun, 30 Nov 2025 21:40:39 -0800 (PST)
Received: from kernel-internship-machine.. ([143.110.209.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efd3437a5fsm68118811cf.27.2025.11.30.21.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 21:40:38 -0800 (PST)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vivek Balachandhar TN <vivek.balachandhar@gmail.com>
Subject: [PATCH] thermal: max77620: fix kernel-doc for max77620_thermal_read_temp
Date: Mon,  1 Dec 2025 05:40:36 +0000
Message-Id: <20251201054036.2143455-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building with W=1 reports a kernel-doc warning in
drivers/thermal/max77620_thermal.c:

  Warning: max77620_thermal.c:47 function parameter 'tz'
  not described in 'max77620_thermal_read_temp'

Update the kernel-doc comment for max77620_thermal_read_temp() to match
the current function prototype. Replace the stale @data entry with @tz
and describe the thermal zone device argument so that all parameters are
documented.

This fixes the W=1 kernel-doc warning and keeps the documentation in
sync with the code.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/thermal/max77620_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 85a12e98d6dc..8d37a04eb5a8 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -32,7 +32,7 @@ struct max77620_therm_info {
 
 /**
  * max77620_thermal_read_temp: Read PMIC die temperatue.
- * @data:	Device specific data.
+ * @tz:	Thermal zone device
  * @temp:	Temperature in millidegrees Celsius
  *
  * The actual temperature of PMIC die is not available from PMIC.
-- 
2.34.1


