Return-Path: <linux-pm+bounces-19351-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D319F3CED
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 22:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BBF7A3D57
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 21:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20781D63D0;
	Mon, 16 Dec 2024 21:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsSLw/5C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2712B1D516A;
	Mon, 16 Dec 2024 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385384; cv=none; b=mvPlAeSyZK0JPXgZOesxDjrQQenTuNPs1xtnj2eVvXYpP/oODFqhdjKiU3k+Q1pLyqWVoAwWM6hhRcAFfNIHqnh5vwHszXdL5p3EpsSZqKXLVe9Fc6jk/Xs92XwEt3z8HVu3qlxUx1LY9OWLfO9I6mIWJej30oPGc4stQIre4NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385384; c=relaxed/simple;
	bh=bu6G/1vzR6H6z9pe6hBZwbz/gRYSdsV53CqgIjxWzb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXxOwfSHKYwCbUHYpZ09H/OU29GSUo/9L/d7KHkG1Qfekvacr6zovgBXGSMhiktX3cs19+DxCChQggDSZeUv/HC6UQ4NLgSs3D7pjd28ZlUn0tlm9NwbpjWKE99mGipqbEepmjBbP50WtWWVZ/1dsvDEbupTcouhICiu8TpN5Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsSLw/5C; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-844d5444b3dso165028639f.1;
        Mon, 16 Dec 2024 13:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734385382; x=1734990182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJGC5U6NyEZfHZAbEKwFZDzPBWxvDuzsYdPOHW5lSGU=;
        b=jsSLw/5C5Y4vQhSX2G1emvUIXqEKym98rcEpY36+GpxCJ5nIGIY+IcDVIrw77lFBm5
         miMhYKxNB7HYfszdp/Vx8xWGWFM96ZpCOsDvG17piXN1gA6bXPgWb27wfmrjLIuGT/n0
         Qznt+CiNOCx9rqIRLmSmvuRlTKwEj4/L94bk7FU5ddIRfscuAHNo1hT/w6KD2ynYzTRt
         9ARU+uudOK6DdLYDoF8ZXu9Q2hOnTXtvNWSmuMZyPe8d0QDjZwuGr0AOumYxsIipZk7K
         iYZv2Oho7b6QpR8GtBDqxye1EqgdRCE1nfn2u1ZO8LjbWEdUPncH0kyzsWou9WpuHNZ4
         QGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734385382; x=1734990182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJGC5U6NyEZfHZAbEKwFZDzPBWxvDuzsYdPOHW5lSGU=;
        b=kPrMQghyf8gJBRMHRR3nAwvxH8zUEeqAqvM+oXeaYIKzej1IeYSuUlAaD6CMeB3T2Z
         /60wzW22WGPom2FEueviLgJN9KRq+4IoPcjZwfcM67R8XWLAzdZDfxWmSBjXNNcXH/uZ
         lCgtyd1naFEQvFfYuj4xuhvW3sL3/8LxsxYWpB2aV47UP29/04v5HLbmfqXUIz9CIA0z
         umkajo6HPCYL1+o9IP4s3IdDsQ72F41+J1VcoYRaGJL+yzNpGbBFZGlAJsOtS04yObqr
         tkWXee6P3z1SM0COcGIimrmZf7hMDTP3NRFz6qiJ0UX80p3SK5Ny249s1E6fZgf3Gvzd
         hvYA==
X-Forwarded-Encrypted: i=1; AJvYcCWmZdOsm5N8OW9YTNayGFMfGRPgyQ05POFtMqmzP11qsNqn8kSFMHp436LiTcFcu7ejYCBJFmCASHIK@vger.kernel.org, AJvYcCWycbY9PvnufvhY4v00WKfegoyxVXjjnUbDqDBSYmAJWHEBQw+3oPtEJsy5jc7DruoHZ/kqNgeeRig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXMrhv2IGicLEXvd7X2OvEDmt5h7yMezyHnO7XffbsReB6bMHD
	tQlJtizUCTBlyEz2xl4wloh/yayGjoAdFsonyHoao9hI+JJ9o4hgJUvaMYX6
X-Gm-Gg: ASbGncvtLiPPNFSgvYj36vAzDQakdEY44JSOgTJiOvdxV+tFDCK3Hiz65a3lH/Yk0EO
	DcTwzgo4ovBdHX/7Y4Nk+nhotiK4fuxRGDtFr3wgAr744wck9m2fhkTsqFdcHYh7QgB1gM6tStc
	gbCc0g7j8/fd1RHSGHJnhEsiX7CcPvXLlg/Vdf4a/R164T7R01zHjFxWoROAYaaSxQcVWfODdRK
	S0PBL8tvyYklU8amnzpCtCv67C98pp7o6lhN3A7fhtW9yfUkspqHQaT648Yai6SZZpjb8hAcCP+
	0tweH6KObZNPi6IS+MaPD+4dLWc=
X-Google-Smtp-Source: AGHT+IGGL+T7hHbT0CUdKvIQYbiW0JKuL6n1e24a8GhUs3rIydemyYi24k0v3/J7YQcbUHUUNpcXrg==
X-Received: by 2002:a05:6602:148e:b0:835:3dfc:5ba5 with SMTP id ca18e2360f4ac-84747e25760mr101114239f.5.1734385382055;
        Mon, 16 Dec 2024 13:43:02 -0800 (PST)
Received: from localhost.localdomain (65-128-205-244.mpls.qwest.net. [65.128.205.244])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e32a342asm1426777173.89.2024.12.16.13.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:43:01 -0800 (PST)
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
Subject: [PATCH v4 1/2] dt-bindings: arm: rockchip: Add Firefly ITX-3588J board
Date: Mon, 16 Dec 2024 15:41:51 -0600
Message-ID: <20241216214152.58387-2-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241216214152.58387-1-shimrrashai@gmail.com>
References: <20241216214152.58387-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document board compatible bindings.

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


