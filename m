Return-Path: <linux-pm+bounces-19245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852539F2218
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 04:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1F51886993
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 03:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766EAC2C8;
	Sun, 15 Dec 2024 03:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4ktkdxA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88521BC3C;
	Sun, 15 Dec 2024 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734233242; cv=none; b=bp78FFsi4ps3xF4cpg7vdueiJdBHbIDbEIAIw41HRKRBGsPAOZPgi9JZ5l1QET5sKnMvzVW9ai0mj+ZVi7BQQ8uCr8f9r7lv3gGdlYBNOrigRi+KnKdG+PvYGzzWk2+IlnYFP5l4EtE/LAeyXChhTbo5/gRPLojVrvV8O1hV6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734233242; c=relaxed/simple;
	bh=7rjZVsbfWjF2wLqBGkmygQvDJZSZqjUr8FwzLNkH5ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4VvEWsFyDiaAq1jPu4yY3gyrmvSgBqAb8upu5rOR5PuhGIvz0j6I7P9qMsmMpFqnmVc7/JmCOZjS2WC74oY59s3sQCY+g+voqOjS2JZ4kbHHEgHHqklFdJtJjqpm52HllwvcXltbPG3bPntHJJKjdkCbwLsg3XSo1reQVsOjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4ktkdxA; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a761a622dcso24923975ab.0;
        Sat, 14 Dec 2024 19:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734233239; x=1734838039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GU+0R/zCIoCNC2OYdjkWppKJT9H70D+WolgyqGUuDu8=;
        b=N4ktkdxAlx1fPw6DzpY15bkOY1bgE6VBT364+iEUIomn4lZYx/Dtjm+tGQVcfxF7XM
         EKxkwtBZ9aFDrHV4Uf5fhDN3lqtUrh3eUf+Sl+ABLMJIVJ5EkKJryWYmx1ZgXQOMmwLk
         gTai7kVkpIw+kwouN+vmLpsx88sf6nOPpCpwuDfj6tzfY7Srjy9O6cQwOE8P8BgfGdjz
         xV2GWBSjlBrCJX5Pz+6kkiI4Vvz4qp12IV7DRAeMK6xPJlDP9rNfvaSF5WuE4cD5Z7lk
         Mq6QwYvMb5xY6/Bx15z4EZ+rR4p4CdZHlDUhDJSu5oBWzbvSsOq++qKSv7wLaVxzPlQZ
         vozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734233239; x=1734838039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GU+0R/zCIoCNC2OYdjkWppKJT9H70D+WolgyqGUuDu8=;
        b=GLD+/rr3aD2MvNptMQSV40VTABUF8+O+LWwNdmhn41xHmMB3Pmbw74QRPPSMeEj6dH
         HnWULbsVz10n2XXqW7mhBSvNTacMbf9snRt4lFI95aDASJ2nmQmo6TctOAAUNKQqdH+L
         9T3YXn1Dy0i84vzz0TTbiFDHwR+ERpHJjkvlhKlWC9xy0ZcsEcSkM9ihQ4tnQpzSjBDy
         XO6CgJQnoNur7zlh6u6bFkbiOSNb8MdtbQ/DdGPJJGV8NDnALE3qXff6jYr6ozr2xPea
         6j9RzD+b+azQKr+87Vh4N8OZB4fgvQOwNE8meiX7XyK2CcY38l2iAdHjk1eEEe5XX1dm
         VpzA==
X-Forwarded-Encrypted: i=1; AJvYcCUlvd/p4TuRhuwdjsq30i7AviuHo/T6ykdHbkQbHtdT7JyqRO/rjnjYyxXVOmeB3IDGcjMH1ztPwvf2@vger.kernel.org, AJvYcCVvNp2gOsYVDqJrohyYL993BXpP3rcI83ejq5CysiNMzwoiIK6hUefN+QVmaEIkjh/9wB/peoQYmU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqp9TuHyuTWCTUQ0pSufjWYe4OgweMOcda0yPY3bUQfqTnB+xD
	B7TUkkRLob88J/mQ0ayJR3WV89d/DPdfxH/5da3/s4WboXnbkQKhqh8H/Q==
X-Gm-Gg: ASbGncvzli4VWFMmw2UuHM95qWcBzS3ombko5a+e/9dBEDy05SdkH8eLe9XgkFv/EVx
	S9eS7ZKemnbyi+p8krX4NRbiXgbKy/2sOZEANL5fu2pU9gH+bDYE+3/JfwSRAoAu4YFTFAtaHG+
	V151C2LXwKC7UdnHS4YFPt2/zPN9Z77louLWaHMzYwHNoKoyAOW8AsoNcNdP3Jah/7LOq3oJysX
	faw5W/xNColWBesvx1WPyRiTC8Ak7M6nF1q8ZicwJAApRBbZYxY/aCEw/3GD84OlMhlCXiTBgpe
	4VdBG6bfmP1KdUMyDGyM4gpPjgE=
X-Google-Smtp-Source: AGHT+IGLuZuyUVQlqPr/ixxRq6aO17BEgow0JIL6t0cNgQQ/GGoVKqF15/txgg5gdcvquaAnaVX+HQ==
X-Received: by 2002:a05:6e02:168f:b0:3a7:d792:d6c4 with SMTP id e9e14a558f8ab-3aff972b7c0mr88949015ab.21.1734233239593;
        Sat, 14 Dec 2024 19:27:19 -0800 (PST)
Received: from localhost.localdomain (65-128-205-244.mpls.qwest.net. [65.128.205.244])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b2482298c6sm7755575ab.31.2024.12.14.19.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 19:27:18 -0800 (PST)
From: Shimrra Shai <shimrrashai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	Shimrra Shai <shimrrashai@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: pinctrl: add header for PCA9555 GPIO extender bindings on some Rockchip-based devices
Date: Sat, 14 Dec 2024 21:24:54 -0600
Message-ID: <20241215032507.4739-3-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241215032507.4739-1-shimrrashai@gmail.com>
References: <20241215032507.4739-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It seemed a bit disputed whether this was actually necessary, but I am
including it nonetheless. It makes it slightly clearer how the pins on the
PCA9555 GPIO extender used on the board are actuated than would be evident
from the numbers alone, since according to the spec sheets for it by NXP:

https://www.nxp.com/docs/en/data-sheet/PCA9555.pdf

there are two banks of controllable pins, IO0 and IO1, which are labeled
equivalently to the labels provided below.

Also sorry @Heiko Stübner for adding your name on it; I had cut this off a
BSP source file that was longer. Since this file contains only this
isolated section, which was written by someone else, I put their authorship
on it instead. Unfortunately I do not know who "daijh" is, only that they
used that handle on GitLab to submit this code piece and I got the
indicated email address.

Signed-off-by: Shimrra Shai <shimrrashai@gmail.com>
---
 .../dt-bindings/pinctrl/rockchip-pca9555.h    | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/rockchip-pca9555.h

diff --git a/include/dt-bindings/pinctrl/rockchip-pca9555.h b/include/dt-bindings/pinctrl/rockchip-pca9555.h
new file mode 100644
index 000000000..21ca99488
--- /dev/null
+++ b/include/dt-bindings/pinctrl/rockchip-pca9555.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Bindings for the PCA9555 GPIO extender used on some Rockchip devices, e.g.
+ * Firefly.
+ *
+ * Copyright (C) 2022 Zhongshan Tianqi Intelligent Technology Co., Ltd.
+ * Authors: daijh <djh@t-chip.com.cn>
+ *          Shimrra Shai <shimrrashai@gmail.com>
+ */
+
+#ifndef __ROCKCHIP_PCA9555_H__
+#define __ROCKCHIP_PCA9555_H__
+
+#define PCA_IO0_0          0
+#define PCA_IO0_1          1
+#define PCA_IO0_2          2
+#define PCA_IO0_3          3
+#define PCA_IO0_4          4
+#define PCA_IO0_5          5
+#define PCA_IO0_6          6
+#define PCA_IO0_7          7
+#define PCA_IO1_0          8
+#define PCA_IO1_1          9
+#define PCA_IO1_2          10
+#define PCA_IO1_3          11
+#define PCA_IO1_4          12
+#define PCA_IO1_5          13
+#define PCA_IO1_6          14
+#define PCA_IO1_7          15
+
+#endif
-- 
2.45.2


