Return-Path: <linux-pm+bounces-19203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFD29F14B6
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 19:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D09188E327
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 18:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51481E32A3;
	Fri, 13 Dec 2024 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0fNbn+X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B02E62B;
	Fri, 13 Dec 2024 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734113408; cv=none; b=qTppu5bFNPrx5X3PCip/htOjYSN7CLvgx1XW4BXJNqWCBopqaJN0gFYrFkoPKszHUCsPSFj2wWrVlTKQRDyRMvzzwsXr3ix06Nqj/Yh0wt4HvzKQNOd6Xzo/MKgRQa1hZoGXvSLdmripMn6qiR5563vTWztFBwxC4Yr1DKx9BMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734113408; c=relaxed/simple;
	bh=Sp15gpzV51tDfhfppbLq6aK8glX6u5u00Igfbyv4PB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g1VS+MvkkL4gpFZQJQ260cb7V+HQx+2JMW5i29jRoQocYg2CfR9/u7SbGpbBJdT+xR/U+vRw68zP5KKtVjzRDYERT/g0+F4Si7pqro+A/TD/EE91xZXINgfFQTM4B/sW9yzSmDZQzjZ2VAon4aHvnmbsfe8dTZIUfXScQs1Lapc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0fNbn+X; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a8c7b02d68so16299255ab.3;
        Fri, 13 Dec 2024 10:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734113406; x=1734718206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaUJxyWODTPt/EHA59a8Xm+chAdP/ldBcjz3rSODr3s=;
        b=I0fNbn+XX9to1j2K5ohAGGqduT7bTkmk0Xlyruwa7o5cy75jurEZ/GEHIVs4ro3R8D
         IEKgZ8zRembWliVJGEe3ROf7qU0FX/PlRvNiCOebk0Cw4+3VQUwL5SXxRU67Aq/QbFdZ
         i8GsLsQnPa8saQYMUQbRy0NH5dYUdy+iKXJDogDz4rETmF5wsflqPDZNvA50wfmCueWP
         yK1M28/HiPqfpxsPTNFDDu5PK9mHM6HQBmTORddSPGSlUDtSzEA/uyZOxzteuGZH3Osz
         PiUvInEgMexrZq8GM7fHcgf5yyU/KtG48np4DqtioCZZm0vw07yNIbWrAomgAJN1R+qB
         Rudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734113406; x=1734718206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaUJxyWODTPt/EHA59a8Xm+chAdP/ldBcjz3rSODr3s=;
        b=fYsuQ8KUgrMZrwsfPH6ZYcUFiWtKPzRUlKp6+SSBov2130ivCBY2BKwkzxpqEpIJ/8
         9vSA7qtIgxs5eiFz9c8J7/tJvzNziAP4zYFd94nK8ian5mfZZYLyxetWSUthE8P31QuF
         DCFi2WoSt2/WSLIDftaUc2bL9xKLsfVWFZ8x9ypIA3o/ZfUIbojg4H7l7kdXTe10xYur
         0GRULGnjUXBEeMdfxlyCiBuovdgPOkWsfjVEJg9ucAYJpEW+1AE0nXnt6ewicxSsMDuD
         MDfmuSdz8EoHcu8deROem8UhkXTnnlyrtDQ4b3OKSkYyfDUMX0MqzF6ZaMSAc0sNP6qp
         7ZxA==
X-Forwarded-Encrypted: i=1; AJvYcCWkUgezQtNKzgHXgP0l8G2OdWSB6tpL+OMrSDe7Q+/1uOQc28e2Z2/yT4IX3CegvbKE0T11XDVevcQ=@vger.kernel.org, AJvYcCXo9x7JHRdrCfC9lbKfZH2NTFv9plDJESXCJpYh17vkHiPIFHmOX2loahQgzS4YFm8oxMbelkBQ8D9v@vger.kernel.org
X-Gm-Message-State: AOJu0YyHOwdxL+xrotGiSiLqcOWdcZnfVbeysZksC1fujwlCGsdJCf0Y
	2h0dHw2DdvNaXxA1489s2WKKYiTnKOisns9HGjsnKkqXHvstlllK+XyauQ==
X-Gm-Gg: ASbGncs3Dc4Gt3cwwzfvqCW39q0QDrBoSPPtn0vgeIF5/63uPqhwwRF6NSX/JtJcvh0
	TjPiEUujmFrE2IfrU8ZcFnVk+REHhXx1zBYBpGS0w/+KHzK8/8h+2bHU9IwsA1DhglCcouRiRDf
	c3Z50g9WwgqPl68HqJ73LNnrqy/q8M08xcYZoXkjO7httjr+QqWk28/GuAjOeDi5Xu7uXVFjatT
	pkGf5hdujQ1/QfbAjIAAefTeHREziHlzC7X5pXa3vQySKt7KsXCWMg4JlZ3S2E9yZv3MV/eu2Ya
	5YwdlLDj8mKumLxkgWxYIyO+wsI=
X-Google-Smtp-Source: AGHT+IH/MEREg6rxAa0/RtNlAsBMr5UpSbMTYOPeTSadT3t2wf9euEA3XWXtBYuE66GNqav6oNdK0g==
X-Received: by 2002:a05:6e02:1aa8:b0:3a7:d84c:f2b0 with SMTP id e9e14a558f8ab-3aff50b340emr43862345ab.8.1734113405813;
        Fri, 13 Dec 2024 10:10:05 -0800 (PST)
Received: from localhost.localdomain (65-128-205-244.mpls.qwest.net. [65.128.205.244])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2baf714cesm2922533173.101.2024.12.13.10.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 10:10:05 -0800 (PST)
From: Shimrra Shai <shimrrashai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Shimrra Shai <shimrrashai@gmail.com>
Subject: [PATCH v2 0/2] arm64: dts: rockchip: Add Firefly ITX-3588J Board
Date: Fri, 13 Dec 2024 12:08:53 -0600
Message-ID: <20241213180855.16472-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NOTE: This is a resubmit of a previous submission with corrected
recipients list and some small changes to make it more suited for the
general kernel (e.g. eMMC is enabled now).

---

I am proposing a Device Tree Blob for the Firefly ITX-3588J board.
This is another Mini-ITX form-factor board for the Rockchip RK3588
SoC, along with the ROCK 5 ITX. This version still has some outstanding
issues, however, so I am unsure if it is ready for incorporation in this
state and I have not yet found a fix for them as of now. I invite any
comments.

Issues outstanding:
 * Suspend does not work.
 * The USB-C port does not work.
 * Unsure how to get control over the main LED; the commented part
   seems to cause a failure.
 * Audio output on the back green port does not seem to work; but I
   found this may be due to slight inadequacy of the still-new ES8323
   driver - can suggest a patch for that too separately.
 * Not sure if there are other board features that could still be enabled
   with the present kernel drivers.

Thanks,
Shimrra

Shimrra Shai (2):
  arm64: dts: rockchip: add DTs for Firefly ITX-3588J
  dt-bindings: arm: rockchip: Add Firefly ITX-3588J board

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../dts/rockchip/rk3588-firefly-itx-3588j.dts | 1133 +++++++++++++++++
 .../boot/dts/rockchip/rockchip-pca9555.h      |   31 +
 4 files changed, 1170 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-firefly-itx-3588j.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rockchip-pca9555.h

-- 
2.45.2


