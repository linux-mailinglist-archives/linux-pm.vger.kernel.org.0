Return-Path: <linux-pm+bounces-19163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4888E9F023F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 02:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8652826E2
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 01:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A59747F;
	Fri, 13 Dec 2024 01:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKarp856"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618411373;
	Fri, 13 Dec 2024 01:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734053539; cv=none; b=JJa9cJBNN+ssb4xwlN1FUigaRBSRZlXLJHrSnGYF1eU2RYUuU3jblaYptvla6b0gDpkSgP5eb5r7Jh8xq32SmoO1Nm+IKsEQJxJ0pNGDkkH0NP/AOP9qKc+zCvdAMJbMd6akBALKsvEnvq4THfVdekpCaOQF9QsZUZJCkHfBJBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734053539; c=relaxed/simple;
	bh=8MF+htgmVqadvE89nL+LoYxmwrYXuYFygeSlXaCKRD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lFLiG/7YJVg+1XcWQIhJZcs2GzqNNktPmO1wE8r+r0IzQxPV8bT/rOAVgBz5d5ztgz96h8Uf7sYSLk/9rKi5rSu/Oez5dclh4Z26LpdSeoWuMV1JBJIWksccdVqlbj5LL52vJmx9l6k+aryxiZdQFjwCY5xMQMx3JSXsAorufNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKarp856; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844d5444b3dso45196439f.1;
        Thu, 12 Dec 2024 17:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734053537; x=1734658337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YC2ubIXV2WONXzCpQJWlZ08KfW5UTrjL7U1HcTkb55s=;
        b=LKarp856EQip5rTCipzpzgGZJ5ViT2y/qRiW2x2h2/kezIbQ2v/ynh9qm0eZaPncxE
         KCuArlQQtMdDOQ7kkGKNUQiZUc6DPSQeM2Hyw7dn64jjaLPs7ggamZ+2v/I13OeNiWE2
         yJJxH2FRSaO9Gbk50ML6oQfGkCp5nvz3LsJJM1h4bUtcCyArxafr+B3T97qKRcLjq56r
         ahasbJaJdgWOmX13rEHb/KlTIL9y2P5GbWFb3T8pbvzdbT7insxxzOfP2Mr4qzRJJYP+
         xetdh71BSXnmXAj6xKABVeiWdGj3GWuUxYKZWFdS7qN//BBo8idrDx7z64IPTsF6HdDv
         BdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734053537; x=1734658337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YC2ubIXV2WONXzCpQJWlZ08KfW5UTrjL7U1HcTkb55s=;
        b=RP1vThe+iOkqeU0WnH7+p87hFgChDGwJ8TxjCeDoJkJlM1+cihNtWuVT9tN10aNMOZ
         nbcFzuKQGf78FfZ41NPUSonvznuGGw/e9e4egVMn+sXyQjnG3NlvlsuJRPNapUFby5+S
         9evR5wsJFXxfx37cXYcBKesg9RSdiIp4OtV3P2BZZafst6us3wdgR6Vu7HX1x5tZVa9Q
         5qF2jHtdU6XETfb1Uy7ipho5xswEBfUSx4al8jR6lBz3aJOpDyUMy3sX36jCPWMRMsdJ
         3Tfz/MRO8KOrZnEHu0uiZzIw1HAlLiBy+0Dgxvx2DcYwoyAXXp59+e7wk1dQDPSExr2g
         uQuA==
X-Gm-Message-State: AOJu0YxJUN7l4ZLc6sDpkOVs5J9Lj4Uppbhkh/+976oddZDTujNPf2Ty
	xjTNQ6leHvcDbSwzvY43jkGq5NHEJrF2PL4KR9vg3Bx0E+Q1bKdSVL2UnQ==
X-Gm-Gg: ASbGnctPH0lMzHoyfpFaGadCDTvN9Ki/GZDbpctOplKZZHYBgU+99yaFgEpmSOfS9qh
	zxzZ2lXmfSYp0g2qc5q7+8lhQclKjine88cUxTMlXHDKX5jKy9PFDajJKsxSuc4jn8rvravNejP
	H4as2DbLlP1JXXW01e4d+fMF9aGTKXjxTuxbI5AYjGM+rnqtQWlE3uysJ/6hkrF09axaBJuWn4h
	TBe4ZTgbeLvZaqZ3YRp4GNXfwrjgC2U3DY1poSRmmOqzaykDnbtNSh3KvkrgrsScJJwaKDzK7Zw
	3OLuxEy4M9gnVrd3Sekowse15tw=
X-Google-Smtp-Source: AGHT+IHtW3E0+W5TtBgUFoe0PFNh54Q/yIbxK5mnk3z+QloAiN3ROvRNlgYIrctW7ERpGQruamfNzg==
X-Received: by 2002:a05:6602:1693:b0:841:8345:5eed with SMTP id ca18e2360f4ac-844e95f52f6mr54467539f.0.1734053536644;
        Thu, 12 Dec 2024 17:32:16 -0800 (PST)
Received: from localhost.localdomain (65-128-205-244.mpls.qwest.net. [65.128.205.244])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844e8194e3csm16069039f.23.2024.12.12.17.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 17:32:15 -0800 (PST)
From: Shimrra Shai <shimrrashai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shimrra Shai <shimrrashai@gmail.com>
Subject: [PATCH v1 0/2] [Draft] arm64: dts: rockchip: Add Firefly ITX-3588J Board
Date: Thu, 12 Dec 2024 19:30:49 -0600
Message-ID: <20241213013051.11095-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi.

I am proposing a Device Tree Blob for the Firefly ITX-3588J board.
This is another Mini-ITX form-factor board for the Rockchip RK3588
SoC, along with the ROCK 5 ITX. This is so far a draft copy meant
for review and suggestions as there are still some issues.

It's also important to note this was originally being worked on with
a specific aim to include it in a UEFI firmware package; as a result
it has a few differences (like a pre-built "chosen" bootargs and
disabling the eMMC) that may not make sense in a final kernel tree;
I'm posting this for feedback and not as a final proposal as those
are relatively easy to reverse and so don't affect the tree
substantially.

Issues outstanding:
 * Suspend does not work.
 * The USB-C port does not work.
 * Unsure how to get control over the main LED; the commented part
   seems to cause a failure.
 * Audio output on the back green port does not seem to work; but I
   found this may be due to slight inadequacy of the still-new ES8323
   driver - can suggest a patch for that too separately.
 * Not sure if there are other board features that could be enabled
   for the present kernel.

Thanks,
Shimrra

Shimrra Shai (2):
  arm64: dts: rockchip: add DTs for Firefly ITX-3588J
  dt-bindings: arm: rockchip: Add Firefly ITX-3588J board

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 .../rk3588-firefly-itx-3588j-uefi.dts         | 1131 +++++++++++++++++
 .../boot/dts/rockchip/rockchip-pca9555.h      |   31 +
 3 files changed, 1167 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-firefly-itx-3588j-uefi.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rockchip-pca9555.h

-- 
2.45.2


