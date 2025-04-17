Return-Path: <linux-pm+bounces-25644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AFEA91F97
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 16:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73ED3463AE4
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 14:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0303253B55;
	Thu, 17 Apr 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nnmAvIuy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED9D253953
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899950; cv=none; b=GEBikMXw2GvDNTTCtBhcab1tO5GkX8hhNY2TnwdqGWjvfBaH4BXa7XZg3J3OWIlVXR9a1eHdJmHkj2Jb52ToNPnY8pY4ivXLmo14e9qiXiAUcw17rI8jnYbH5Pnr7RuhK1WARnLjn8tVjsSXG5vSaqt+m+dkPyYwh9a1ygCU88I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899950; c=relaxed/simple;
	bh=fVOeMtkqjek3/va66TnjrcaUKzQdloU7XDRJcBxC3H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbBDcxnrTHsRKYZYvcYfxNdFIZBN0IxKGXeuyZ6kEzNZmGPk7s9H6sPRlHb2vFfMTSzVkzisu8QhBfPDpisZx5DmBkiSmd52+H47M1QmXPCWhd+6E903wTu7bJl/5ck8R+OX2Wh7BojdO3a4cnVSRQ1Fvx2/pVxjYpg94RKK9fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nnmAvIuy; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5499d2134e8so1015255e87.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 07:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744899947; x=1745504747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBLgNziettBNC+dAZgZIrrnObr0T+wTrJghaGzbU3RM=;
        b=nnmAvIuydCXtWwD1grDsFhp5Le0cw/ICVu9Jg9bwodajYV3mxUyFSNwKAzesCEWuCp
         Uy4rTmyBY2Q7FyAr8FoSFRTsY78LxQk8yDSmlzR3DdYQvQmIdYsAKkSDPfiJkTNneefb
         fW07slVpTB9dm00NnYDi7PTnuoZuEOflitANXNbtuFkKmdcvqofNRa4L9oLt8LaEiO48
         qjdoNOFSmAH+ZFaSLEKylhdj+k1fCydVXWPoxEjR2MFEI9B3OUxAo+1zRaREGB5F8PyB
         pF/MBU8iNgwKco3p6Q+3JH3U2rfyH2xsEwzSNszluEsBZz/B/EjSq0QsaecxRP//iR2i
         STQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744899947; x=1745504747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBLgNziettBNC+dAZgZIrrnObr0T+wTrJghaGzbU3RM=;
        b=Xpvv/otSFDrPO6ojPtsKd6C5gZkP4XUQ22F8M6BYEy62s2PUXVm4EJzoPvZzaGI7kG
         OWiGqFEDVUGP5ytFw28i5SztrRjQO/CiHa2mM8uAQU/wtt3xmm5p4sf94MaqkX8H0Vts
         kALLGPgvJ1NB9HyWp5ZfXaXxTSBx+qHMHFuPFNL9kdlmL5JbrlD43gErr4h7DG4Fq4St
         aWq1zzXZf4gnNubkmFOAfsacvqcivYXzJEro8EzbxpIHwiTEHEZTOaxBlsW5KCgS6xRb
         VOrpaf7EEHpit+BAAU6nlHUn+VLJWVFT9lq1RJQH3h8phwBl58Jckmh7sJy3e2w50rqp
         Drsg==
X-Forwarded-Encrypted: i=1; AJvYcCX6gu4QIN5hifGjxuzP18wy0PMNjfbPkRi+VrjKqQpRFTEZUcaq7cWpXGhfvhv1+BKkhJ1Xi5SVfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyO6xNaSltHzXgvmkGtelcTw+l8P619QdWvS0uhTiKD1OreBg7t
	0daStTUkFuAdkFQ4+/eqIFN5p5iWPRPJh9g5WZDzxro+E0q+aLR85O3yezGucXo=
X-Gm-Gg: ASbGnctZ6pjZyMofb7+DLcYZS+aJJuRQZCCtPl6GDQPrYjD22G0leqQU2MgeVMwMsoV
	vokUY41FcIpYfXB2nf6SnnTVJ+egL6y9y2xcuTIKAajLOUSl8VL/wsxVBz3WmZz9baU80ubeVFG
	8HVikzL1IXgqv34ZCUnLrQPbI7CYt3/059/sstw4huhcqpVavHaskZnKcwKJPB3acXkbpexXQN7
	2+tLKbQm+ZzJUzAlwoVqp2Dy2XmrR9A7+60TAg+lmECvIWrfWeZa0d5yH+PRGFWb0DThDUwsRhw
	+8kB9Gtx4mJUlgBNh8bWCiC5tLx/phMcABH+jMKxLHtkt14b/6GldQgPO28nE+2lCEjfRVaEUS4
	rIgH1RHTQ186M+sg=
X-Google-Smtp-Source: AGHT+IGdzxUvJDdD8yKezIscrWK2RHUkT2/k01YPoiwp/s9fHB9GDRUF1BZX1s3xswvvS2oLa5JAdg==
X-Received: by 2002:a05:6512:2206:b0:549:8b24:9894 with SMTP id 2adb3069b0e04-54d64aa65bbmr1947682e87.15.1744899946966;
        Thu, 17 Apr 2025 07:25:46 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d65e43647sm370096e87.58.2025.04.17.07.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:25:46 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] driver core: Add dev_set_drv_sync_state()
Date: Thu, 17 Apr 2025 16:25:07 +0200
Message-ID: <20250417142513.312939-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417142513.312939-1-ulf.hansson@linaro.org>
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saravana Kannan <saravanak@google.com>

This can be used by frameworks to set the sync_state() helper functions
for drivers that don't already have them set.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Note that, I have picked this patch from another series [1] that are about to be
re-freshed.

[1]
https://lore.kernel.org/all/YG6lhT7vuiCNvvDg@kroah.com/

---
 include/linux/device.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 79e49fe494b7..544523d48cd4 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -955,6 +955,18 @@ static inline bool dev_has_sync_state(struct device *dev)
 	return false;
 }
 
+static inline int dev_set_drv_sync_state(struct device *dev,
+					 void (*fn)(struct device *dev))
+{
+	if (!dev || !dev->driver)
+		return 0;
+	if (dev->driver->sync_state && dev->driver->sync_state != fn)
+		return -EBUSY;
+	if (!dev->driver->sync_state)
+		dev->driver->sync_state = fn;
+	return 0;
+}
+
 static inline void dev_set_removable(struct device *dev,
 				     enum device_removable removable)
 {
-- 
2.43.0


