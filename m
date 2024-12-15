Return-Path: <linux-pm+bounces-19246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365C09F221C
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 04:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 576037A11FB
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 03:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CC2101DE;
	Sun, 15 Dec 2024 03:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYOmxKWC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170F92940D;
	Sun, 15 Dec 2024 03:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734233248; cv=none; b=mlBJlzdL/tJonXAZlHylx3HLNctvl8ae2gtN13koTStmG57LfMs9aLl6afoLU9AdlarplsjIudcAcJJgFIZurXRXSTtwZemYQvkWjVYpqKOhImfGVEVMehUpySvlnmH46rsjBHW5kAWzuKOaBdIh0vgDYXvNyesPtqV5EYH7zbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734233248; c=relaxed/simple;
	bh=nWMqBh6v7cRgm+XJUOPQB1YJclxvbH+Y2uWnFBbVcJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDS8xGC24FftsqO4N6BvkcTZSJL75bjBvzlWdvErIA7oKs/I6MSOTecBncR8OVxqcrT7kUhZhwNd8uAS4USxms1d3R7v5Rtj1pk/OtxSi9Ow1ZY+CYe67PJd+y+8+SvX1Q9Vi8Utu/FU/0lBQ4faRsFPoEsywZiKTgGmYAxQk9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYOmxKWC; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844bff5ba1dso225434039f.1;
        Sat, 14 Dec 2024 19:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734233246; x=1734838046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMKOxO+QQQnpK/gqTmp5of8X6K9CuNI4LFknE1hYc2M=;
        b=SYOmxKWCKf+30mCsZbL2phmry4pNdL2KNMjvIKd13gHFBlIhQusDt0I9zCUlZX2nLV
         DaLjX40D9Ez18RRxFVO7EEY30HxJHauJ8OlcB8Yw3oyy9qFJpGCGI3vJqsSSBkFNjpdp
         28kT9RrvPgRwR14BwBO7W2Vq0wjkuTlorgexQo4500i7A5F8fMzPzoTOjIL/NgwKXTCx
         BiF+33ldPvGefPGU5jvkOOiDQ/LPLEBtoKQDJYpGlD1Y4HQccRrSrWV/tkD11RFlU368
         6uca7PNUEUbPfJ4b3BSej6LT7I/c4MCtokwnyhd6H7iVKQA0JBkMFVO1A7VcTGtnHa9n
         gbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734233246; x=1734838046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMKOxO+QQQnpK/gqTmp5of8X6K9CuNI4LFknE1hYc2M=;
        b=IY5rodvXd8iGiDHBSz+bzTZ3RAaka7c6ujr91KmRbxA0EOYStAidXZKl874v2lLjnY
         LRDMKxSZrx53gJgUX/AvL06nt+PCb0FopycUITdLs7FZbEV/1ix8LGlNR3Npud0JWCIW
         URCBKU+X+00INtlkS5sZiZGEsUdD+p03tjjRBZK8P6A8I5fClfqd70NB3MAkEms7UIVs
         d2QuL0rP2P/B7M21h86SbAxmCGWlQeg8QagpiiUEmHRs472ARKXpw5+RwqMGN6g2Yw5k
         6dwfoY9RTJufVuK9BvbTF/w4GlbZd1mt7xoGPG+ikVjUsFatcf65xEEbd20kFPgAbW9a
         5oxw==
X-Forwarded-Encrypted: i=1; AJvYcCUyXa4FKsrjT/SQ6wevTXkIfM0GdvjfPUKNymHNzgyCStAeHA9xRgiSfYrouFdS5lj1pZGHNen2vMbc@vger.kernel.org, AJvYcCWK2rSvjsZmufhqUqoh8c/F4ZCQICIraWN0kq/sOlW7bK3MZ8U2t6l7+70EOWX5Sz3kQzIlhcmv5qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC/ws/TPnkhdkYDoyuKbwhAlUhQ4injuc8s+zuxhqdrk6uAP1S
	mmMm68e8s/OPopBZstPUHNgfY02DzlcfvrQQp8FfVtNlsGIKxPAd9oCanA==
X-Gm-Gg: ASbGncv69FnybscfpOEk6ySGbFdcxW4SM7ojZVg0HKDQtBdpeKGASHUMP5gQx0EXYXR
	GVfJq2+1mGyFeYAaYg825r07LsRzVYIvTQIJzh/dbAkmfhcluFaqS+sIZ4o7hoDCLEuRm9znrKI
	qZrn6MFPHc3zvATV3VK/NtvEVETjlNgw0dIxBREOX5m0dxmltDfpQO+Ocuj+AxaEP/SI1xPRuU9
	sUbHC2Q6LvqhHYQhU4qP9Ayu+4U4uxiddDh60IujFULXHsoTlDlDF3ZmyhA4/xtKiucQVlRiNPn
	2oNiKh8VnDJbUg3mbmJb2D5FXCs=
X-Google-Smtp-Source: AGHT+IH/Ga5WHa4WgsKsLSKgbEehuyqvn8KfLn7YekgXK2iiDYMjq8AZzP29aqVzMkcLbvuitLywqw==
X-Received: by 2002:a05:6e02:3308:b0:3a7:fe8c:b012 with SMTP id e9e14a558f8ab-3aff8c92a85mr86513735ab.18.1734233245607;
        Sat, 14 Dec 2024 19:27:25 -0800 (PST)
Received: from localhost.localdomain (65-128-205-244.mpls.qwest.net. [65.128.205.244])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b2482298c6sm7755575ab.31.2024.12.14.19.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 19:27:24 -0800 (PST)
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
Subject: [PATCH v3 3/3] dt-bindings: arm: rockchip: Add Firefly ITX-3588J board
Date: Sat, 14 Dec 2024 21:24:55 -0600
Message-ID: <20241215032507.4739-4-shimrrashai@gmail.com>
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

Updated DT binding documentation per @Heiko Stübner's suggestion, to
reflect the bipartite nature of the board.

Signed-off-by: Shimrra Shai <shimrrashai@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 753199a12..fc7ee86e2 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -167,6 +167,13 @@ properties:
           - const: engicam,px30-core
           - const: rockchip,px30
 
+      - description: Firefly Core-3588J-based boards
+        items:
+          - enum:
+              - firefly,itx-3588j
+          - const: firefly,core-3588j
+          - const: rockchip,rk3588
+
       - description: Firefly Core-PX30-JD4 on MB-JD4-PX30 baseboard
         items:
           - const: firefly,px30-jd4-core-mb
-- 
2.45.2


