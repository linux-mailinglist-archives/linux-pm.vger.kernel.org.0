Return-Path: <linux-pm+bounces-11445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EDC93D946
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 21:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989031F24127
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 19:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C0F5C8FC;
	Fri, 26 Jul 2024 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0IPe2r5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD693BBC1;
	Fri, 26 Jul 2024 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023540; cv=none; b=AFopdWFF5BAvfwknE453qipqaMLiB3tIVfzWJ2dGJ33m8hBzJldY+dWh9tEB5573wMojEsyjckYgp6MujDpN4SrY4fl9tn9JJRsxlTq5p34VNDcu2Y7QCAEKI85V8vevgU4TwyfIM5nJQoy7sKetX4JN2JGOfxL+cpOLMM0UC4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023540; c=relaxed/simple;
	bh=5562yB6GG582jQ2FjweWBJG9xmyG/AzopD+FehW3LLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ck3kXwN4OHVEDmH+IuayMBCkvdszFfmrAhh3FkohCWcISjxdbHUZsURx0l8vTKtgg3esDyiYKlAwnuF6SxkscaQpSiLVomIRJ2g1baT9Iy1nbXn+s9eJGVTDMoW8k3Iw5lOH6rNCsg08v4SwkAmrtCGkR+gzn9+mpMsnF/abWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0IPe2r5; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-709340bd54dso675310a34.1;
        Fri, 26 Jul 2024 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722023538; x=1722628338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+k3gjF8BoooWUfXQn49JWorftRpntAb8sxIAYpbdwo=;
        b=h0IPe2r5YA74DcOnYwXCzAFXj46uJsGSvmpfXnH0VNtnGTQGREGXAScPSUWoi7jF3s
         +mZhdoigLhR2pzlRqgpuNzqO1bVZ4XC3DymeQIbcaaifOxI0cJ7seBnVkPJJfpj0MkqJ
         LoQOGHdbgoGZuGnWiLlWEK75wwpA54Ervk8zrEXiG4L9sUCiP/5my/BxPYwQknwxr/yD
         T3DFTr16gp3+WKgXKpGVt9695m09qScBCUj3+bjeP6YYxyDJl50HX2dKScamUild02z6
         9KuVdVBDmmZJoyx2UEYcBTV3VcX70zDBffEim86MluyPPsPazZwpkcSY5DfMuTn+Jg10
         AUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722023538; x=1722628338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+k3gjF8BoooWUfXQn49JWorftRpntAb8sxIAYpbdwo=;
        b=V1QY9TFRia16MBm9WPscofXU0yO7aEJ/J3utsic36yA1pExUzp+eJne0r0vVygsd7v
         JhkSlv50Ys2tFnNDcZjYYhMikmGfAZYgxC/nHRHjTZjUDIl+OZkR+yhSGUUdG3RrJuSC
         OXDjUWBwbMXtCtNvQzRlJoOuyKAeXJdK2Ajb41g7lbwrap5Kbf9+3Pq5/CFRQO9x4EB8
         x67p0AO9yOpELB9Ey4PVSCrRORpBp8ZrmGCOQUk4xN/ThxmcIobJzx4kLvWel1RHRwdD
         eFms3Dit4xVdlz9Kq1Gs45TBAxDOTueEiTwPPq1xtRnVijBwc4+HqxRIUk8TuRGx736A
         IHYw==
X-Forwarded-Encrypted: i=1; AJvYcCWN/PmQW4XKuSYRrtVT/QnKPslKZREsuPHko4IacvR6d2cGyEiGWI8hWiazX8QRrEOFW8334HPGYK7E9fpkCujg3kqdMb5kZodFXA==
X-Gm-Message-State: AOJu0YzyoXUjpp/I1ApmJFTWQ2pSZyvdve4J4JPF6fP7KNwnN7X2exw3
	fJbNrdLhu3clYgTYEIj+WGmR3SDdLLos+7KvSRUHaPjGC5EsvABK
X-Google-Smtp-Source: AGHT+IHuz8TrULo3PxDivHC7WO52EaKTYugZpCRax3nUL6uYgAUk3XLu9b73tQtTCA8ceOKeHGVvbQ==
X-Received: by 2002:a05:6830:350b:b0:709:41c4:6a5 with SMTP id 46e09a7af769-70941c40c40mr158952a34.3.1722023537867;
        Fri, 26 Jul 2024 12:52:17 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:c1f3:7caa:bc8b:ab10])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70930778069sm889972a34.59.2024.07.26.12.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:52:17 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	jagan@edgeble.ai,
	andyshrk@163.com,
	jonas@kwiboo.se,
	sre@kernel.org,
	t.schramm@manjaro.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/5] dt-bindings: power: supply: add dual-cell for cw2015
Date: Fri, 26 Jul 2024 14:49:44 -0500
Message-Id: <20240726194948.109326-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726194948.109326-1-macroalpha82@gmail.com>
References: <20240726194948.109326-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

According to the datasheet for the cw2015 the device supports dual-cell
configurations. Add a new device tree property for this condition so
that the voltage values reported to userspace are correct.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../devicetree/bindings/power/supply/cw2015_battery.yaml    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
index dc697b6147b2..0e7866d42cca 100644
--- a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
@@ -34,6 +34,12 @@ properties:
     minItems: 64
     maxItems: 64
 
+  cellwise,dual-cell:
+    description: |
+      This property specifies if the battery is used in a dual-cell series
+      configuration so that the correct voltage is presented to userspace.
+    type: boolean
+
   cellwise,monitor-interval-ms:
     description:
       Specifies the interval in milliseconds gauge values are polled at
-- 
2.34.1


