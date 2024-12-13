Return-Path: <linux-pm+bounces-19165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD629F0244
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 02:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1FB0188DF32
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 01:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF6025771;
	Fri, 13 Dec 2024 01:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvkN9xTy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07535433AB;
	Fri, 13 Dec 2024 01:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734053552; cv=none; b=i5QAj46UYxC2hSNgIiUeQeXQj08HA2775Ddeu2nYO5BKvF1vjSjIDzpHEiqOcdjG84BMjIoMS7sSN+m8MQX1g9CRQyArLjcXowsmZ8wwBlJ5qdqLh2bqXb0pNIL7wErIL7n0MFE2Bk5VuM4AGGAx2eijeqXpS13M08+3rA7SNvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734053552; c=relaxed/simple;
	bh=1QiW/NSUcgjlhzv/5XzNVi8czftPGVa54G+aDwKTygc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBDgJdss8bIh95djLxYuzxxLWXvVH4oKsCV3koNJnHrrBjAW1GKRh8H+52+sZp+jStu0pEfkSvbfxthrKORro2jFALaWxYqDCfkFPyETl8RkWtrxlBfZflsrODrELYrlEJtNbxcAl/PxxNvf1JQ6tJnQfA8MRmQpXwSBBVjPYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvkN9xTy; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-844e9b83aaaso12921239f.3;
        Thu, 12 Dec 2024 17:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734053549; x=1734658349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8ryccMdFQBwG+eWGXmJJpmNQrQtDTsM6+lw/gJKoKs=;
        b=SvkN9xTy/wYm9+411p3/JtzflTILNj7Bq9O13619ln8J29caP6h6XIos6I1YBuhbwg
         WY1rkjYbhzSyi2+V1CTZCJmM5huRtPE6xQkCPw1zFZAnfp7BzHo1kVqZDc7EIWvz1agD
         vTJTnyXRW9zXXxvC3k60ayv7E/sFPEeTO/FuUMGg1dXZQS/kDwBAxFSIGtmD9f3HCOxD
         gGOBukr1K0Rt2xdecpj4yIhrlR50uhhceHqBLRN/hh5uZHmyTGTvRvm8vojZhLpwaJ1D
         CtoluoRRPiB48PeXSag5RhBNI4ix2lTPktoQIgs+XImm+FL4CRUkw1f6o2fbycI9soz0
         bXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734053549; x=1734658349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8ryccMdFQBwG+eWGXmJJpmNQrQtDTsM6+lw/gJKoKs=;
        b=qcGBl2zl+XTwmcoMkeGNncqQKNjaxP3Oz1n4zBWGqmJSdO1XAs3n/mSKy7pgl6qRzQ
         Wz0SdB16rh+TCQr3JYvHWk2TPwbSJIeGN1rcnwwLAXfP3wxLZ9LxbX2y/9UXanvxd+Pn
         unznXx5irFzCu+mEICvm5UdIF0XGuuKezLmQ4IhDD1Wz3HlELdEJbYzFhlmi8TO2mxKt
         oXqACiRrQK4nLSKi0rgHtukIkgal2bE7Deb8LMm+bD9a5qT07bQ0vtAQTod8qszgtw6n
         RKQJWy925I04IhjsdVK6dMI5Z5cpIbxeiDCatcwjTQ/H591+ZkRyKYZW7Hf266hnoOfE
         XGxA==
X-Gm-Message-State: AOJu0YwVs2rIXJOgTFrijcQ1Y4l+dIdYHdOiHnnRJi8tB9c8D6Li8iE6
	bC47r5EPrTJh3oaTNO0ml3AIe6ZaCBw6c+FlhbtBUuNtW+mg0iHILG+f9g==
X-Gm-Gg: ASbGncvYelKbhUmod8N2K4u7ZHd8wmIBA7rNtDQ51VV56aIWRdOVMpgTa+bNuAcAQVC
	hSw18RgJ5dTlSvGPNcPyU36iMwYG4v5ENYdZvkdMOic8XvMsaS9P00AO0/Bsy0JTG5xlKU/TwUT
	XB5tM4dcqz8+AUeH5mTm9bTw7imH2gy2S4eLsV+mB0BL3BnGx0+XT2bGv+tS7/r+scw9ciWyR+N
	MHTg9d8rp59uuivEvLGf4+i9HgfEnLpLz5SGkofIZF4TZBMGexMXDD1o0rlanedNQSqIrgwRgmE
	W0h7uvn0sk168DQpNhsDQRz1Low=
X-Google-Smtp-Source: AGHT+IETAcTXptH0ksA75sp+neFX799jNjq9W2GjDUPB/2elQD/95eoBuQ5XddYUCrQmtcSPaFqpxA==
X-Received: by 2002:a05:6602:14c3:b0:83a:9488:154c with SMTP id ca18e2360f4ac-844e8aa65dcmr96564639f.3.1734053549592;
        Thu, 12 Dec 2024 17:32:29 -0800 (PST)
Received: from localhost.localdomain (65-128-205-244.mpls.qwest.net. [65.128.205.244])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844e8194e3csm16069039f.23.2024.12.12.17.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 17:32:28 -0800 (PST)
From: Shimrra Shai <shimrrashai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shimrra Shai <shimrrashai@gmail.com>
Subject: [PATCH v1 2/2] [Draft] dt-bindings: arm: rockchip: Add Firefly ITX-3588J board
Date: Thu, 12 Dec 2024 19:30:51 -0600
Message-ID: <20241213013051.11095-3-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213013051.11095-1-shimrrashai@gmail.com>
References: <20241213013051.11095-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Shimrra Shai <shimrrashai@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 753199a12..9ee96acdc 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -190,6 +190,11 @@ properties:
           - const: firefly,firefly-rk3399
           - const: rockchip,rk3399
 
+      - description: Firefly ITX-3588J
+        items:
+          - const: firefly,itx-3588j
+          - const: rockchip,rk3588
+
       - description: Firefly ROC-RK3308-CC
         items:
           - const: firefly,roc-rk3308-cc
-- 
2.45.2


