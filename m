Return-Path: <linux-pm+bounces-20811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5AEA19403
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 15:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8A816BB3D
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225B72144B0;
	Wed, 22 Jan 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqPZROcw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8A145B3F;
	Wed, 22 Jan 2025 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556505; cv=none; b=BkTVjxaz0pASB1CTmlHpjhdwhz4Xe/8FTjVeMHig9wzQfQzd1qDE69M7XNxBWavW7vdmnV9B4GkPQhmrYIH55PmPKBdOZJV5WhJsFdgximjuhDrP4T6JxJIqf7+mtChgCS4EeoObYNsy/EjYQo798yHxmCicxbEcI0zfcwReY4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556505; c=relaxed/simple;
	bh=/zc7nJ13i8YoePoCGiFuYd9n1VxZBkfmyWc3oz9lhAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3wANZQSAvcIh3hWVQ+1QVqYTnM51QfTgNrSo3E3LTq/2pdWXwESqpgeOLSumSq851qqqO86Is3Fdz/HCOjz/UDy6gNyHF5r7VIdLrwc4pM22e065sRPK2UrBkJunn6GyCmrYFi3jd4lKRw8kiP76IIsj+zfPGzpVceQWElmGC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqPZROcw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166f1e589cso169667835ad.3;
        Wed, 22 Jan 2025 06:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737556502; x=1738161302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UD/hOD7dnOzkI0AcrPnTvmmxoAg4czs6626IqId8g/A=;
        b=SqPZROcwCdOj8oftrR3wITth5IbeMBrvJbCUQi+GC4pa+dB2jReOEDPK5KXbwEV0/N
         mk3wqEaESnkowJqi6PmtLhVp5mM8QlBxWvDkcVGO1VM9ZPw2qC+VilCqqPxt5RH02pFm
         T4RcOOyPJqrAI9P7XY9csUNVwJ9GzzH/1CM10k1+Wlpl4sN7OsY2e2dhZuFnxZM9fwEO
         PJTs+OfTfhMr1oPLaNO9KbhFo+EHs+8Z8SiqMfA4t0rFpUfYCzAVB0boeKlHVizaytWE
         rKF2aJN+AS653u/bHGpen1DXrMMF3CQEFbRNg/QPAGyqiyiXrfCG96dIpyi3FlNGUYyO
         0p9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737556502; x=1738161302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UD/hOD7dnOzkI0AcrPnTvmmxoAg4czs6626IqId8g/A=;
        b=H8EuXxOJ+kQ8VYCM1KemiLZpJTauGH7uy4jI4IFJgoZs6XNSN35pRs5+hD+zZcNgql
         +sim0VtAkSk2Bo0RM/+SlM7gL4kYYMbcI6RQKR7ffIocpdfzr9cF5roBMBMa4A+Zpnm7
         97N0dEI4R1JkKPKTPwPCSRzMYmoqC4CsiI3D8WEz2yb12PngBloD91T9vKJZxb+j9yBq
         tBmVPT1pICtOfrV5GHeiOBddMroiis5eu7vtcxAMM9oWArreVcDw10timXv0/+qWV4gu
         grkJ7CKZsTxoHIz1PHvHx4Pd2Srzbu/F57y6pGtaQXT5K/W1imRsfYqjWsybC65MN095
         aeCA==
X-Forwarded-Encrypted: i=1; AJvYcCVsfH0fPJj/DyGxrs6WwptZZj1dVLSp0knZ9BY/VRZ93JEunPVo8Hu/ZmjXuemfiNUcgTfRwxsJKdYIDQ==@vger.kernel.org, AJvYcCWQnlHVpIhxFOofFCxaibR9AJhXTiPYeDw46sZhILiriARgbr9vr7//AZDYFjAhYYAxKmxZ77TlXAc4@vger.kernel.org, AJvYcCXCtsGv4PNTOgABgyFUmU9Q1Gav4XanmOKdpvbxfpUG7YdBXxgBLElNWjWVPafzsm3rdpY00ouqrrgK2msL@vger.kernel.org, AJvYcCXVaiRFp2pJRQRh7qjH39PJrodd4zFmZVVuWBzZV4Zj7CENdYoemjYnztV7EZWyhvMuDpfakQuTvXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8AxhMCPaQBm7LpdixM4/YRqBdv0jj718jGsqo6M4cKyJ8coUz
	W10iuE+NiuoNNaeN6AM0+JcSfmkpFscv9xAGz2VmQ3unUw219Fc+
X-Gm-Gg: ASbGncvKrMcdGARFk+aOxw8EaMmVJsIac2XdfeLdWmapIsHEWuQMrDuRo6S8bXBgrJR
	Bm669YH/DU76IIEX/TMx0K87kLxfESufeEV5lDFKFJzZ6D6K1gHavqnUZYRhF8UhIVsDQ80Ee0E
	5Xr5MWEKknl8jxkyv+ChOkAm4/8vR4M1znilnnX9opgKuXZNKcRHFVKTacZm9wEli+a3uIAtxJj
	R8a0mUbnPwS8RTUD73IK7qPx3qg1uQLxbFRXSKA6aeudleTCrrNpdPK3N+hJEf92wnllg==
X-Google-Smtp-Source: AGHT+IEG1l5ljRg9RQusRzE6aF9RDYHsrAxN6GN1faKlGG9qEGSApaDZkJ/YQhus0iOc6xCSSJPq8A==
X-Received: by 2002:a17:902:d492:b0:216:1543:195e with SMTP id d9443c01a7336-21c3553b227mr339324665ad.5.1737556502424;
        Wed, 22 Jan 2025 06:35:02 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceb9ad4sm96472645ad.78.2025.01.22.06.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 06:35:01 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id E2440420B71E; Wed, 22 Jan 2025 21:34:58 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Media <linux-media@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Block Devices <linux-block@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Rajmohan Mani <rajmohan.mani@intel.com>
Subject: [PATCH 1/3] media: ipu3.rst: Prune unreferenced footnotes
Date: Wed, 22 Jan 2025 21:34:54 +0700
Message-ID: <20250122143456.68867-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250122143456.68867-1-bagasdotme@gmail.com>
References: <20250122143456.68867-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2182; i=bagasdotme@gmail.com; h=from:subject; bh=/zc7nJ13i8YoePoCGiFuYd9n1VxZBkfmyWc3oz9lhAA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDOkTGfXX8N6v4Z2W+84wqsa2JHb6C710x8zC/kfWrzKfc QdUCT3tKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwESuKjP8lbou/uiV9f8r1m92 pjF4aW30qJC7OLkisWOflcuUKPbzAowMSx0vx3k/s3zoGeQhXXg5UujJVF5XOeUJWsaiHlzaCvu ZAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports unreferenced footnotes warning on ipu3 docs:

Documentation/admin-guide/media/ipu3.rst:592: WARNING: Footnote [#] is not referenced. [ref.footnote]
Documentation/admin-guide/media/ipu3.rst:598: WARNING: Footnote [#] is not referenced. [ref.footnote]

Fix above warnings by pruning unreferenced footnote to intel_ipu3.h
UAPI header (already referenced in its full path in "Running mode and
firmware binary selection") and by directly link to v4l-utils repo in
ov5670 configuration example with media-ctl (since the example is in
literal code block).

Footnote numbers are unchanged.

Cc: Rajmohan Mani <rajmohan.mani@intel.com>
Fixes: dc794d3d2424 ("media: staging: ipu3-imgu: Move the UAPI header from include under include/uapi")
Fixes: 34fc0e1bf892 ("media: doc-rst: Add Intel IPU3 documentation")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/media/ipu3.rst | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/media/ipu3.rst b/Documentation/admin-guide/media/ipu3.rst
index 83b3cd03b35c36..3a8c3d46304b7d 100644
--- a/Documentation/admin-guide/media/ipu3.rst
+++ b/Documentation/admin-guide/media/ipu3.rst
@@ -98,7 +98,8 @@ frames in packed raw Bayer format to IPU3 CSI2 receiver.
     # and that ov5670 sensor is connected to i2c bus 10 with address 0x36
     export SDEV=$(media-ctl -d $MDEV -e "ov5670 10-0036")
 
-    # Establish the link for the media devices using media-ctl [#f3]_
+    # Establish the link for the media devices using media-ctl
+    # (from https://git.linuxtv.org/v4l-utils.git)
     media-ctl -d $MDEV -l "ov5670:0 -> ipu3-csi2 0:0[1]"
 
     # Set the format for the media devices
@@ -589,12 +590,8 @@ preserved.
 References
 ==========
 
-.. [#f5] drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
-
 .. [#f1] https://github.com/intel/nvt
 
 .. [#f2] http://git.ideasonboard.org/yavta.git
 
-.. [#f3] http://git.ideasonboard.org/?p=media-ctl.git;a=summary
-
 .. [#f4] ImgU limitation requires an additional 16x16 for all input resolutions
-- 
An old man doll... just what I always wanted! - Clara


