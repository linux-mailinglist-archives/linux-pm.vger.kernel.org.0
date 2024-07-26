Return-Path: <linux-pm+bounces-11448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 882C093D94E
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 21:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D2628517B
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 19:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B39143759;
	Fri, 26 Jul 2024 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7XcyCSf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2833BBC1;
	Fri, 26 Jul 2024 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023542; cv=none; b=s/0WlYMt7z0oC+pLbQ2NOeS2uC19D5Z3D8mo3MRSa1ES1fmKDT4RPdho8AMQ9a3W9FEi1MJGcwQMmxR4pDuh5oXUimRcTtjQDnszhA8zjwMQK9NxKdQVp+d/52RUj+EwxrVWNe8bipr9IvPG+ENotCuFJ+Dl9tF+JihQMA7Pz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023542; c=relaxed/simple;
	bh=gIetfDeVvAKFROU3FU4BaYItI5DB23RvX5/OVYo/aqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lY+WXNt8UMhT/KU81eb8xXmzGrotUU2/uXYUHMXXFi9sgwdWWfSRThDoY3qfUBqbjNR/JfTyyQGH1CkFBKjd4+IOJnWokm8mAN43oadEOzhNqf/3QBvaj9/NOLqEjSgxLTattj0QfThcNV6OCJ1ihEBz5AB40jE9BkJd9Gv4QOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7XcyCSf; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7093f3a1af9so358377a34.1;
        Fri, 26 Jul 2024 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722023540; x=1722628340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1/2W8RcQjiqKYDLwnvQA5GcanCOKJKq8/U5bOmJErk=;
        b=G7XcyCSf1JXLLVKMnUAx80Kl6wsjATra2OJU9iLl6vRWTRcpJLZBEYyK/uk/IwMMia
         7tCRPveGWaEPCXa4HYuNaDmbZSs/cxdpc6QpqoQQbQHQ879HcqJ9+kT2/inJcQxoupeb
         cj9rl/Ag56RgxPaIPhuLRHH7orcUVpBKQOsN78rlkt7CVbNULPBMMAVEuhWEsTbbl4r4
         /zki9N7YsR3aoQbcGIqgZRoMBj+3XDJNOSFS/QqbFiSF6mbnPZulGdZORyJHlGu6cVH7
         x3LeeHYadezwSc2Zv/s2/l4rZ1yh3F+wf5AKWe+Y3zADl75juQEHS6a7Rol2DLb1nUhf
         dr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722023540; x=1722628340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1/2W8RcQjiqKYDLwnvQA5GcanCOKJKq8/U5bOmJErk=;
        b=PPBoWpIz4Y811V/3z/4N8FnmqrxM+I3zU/GRMr8gmpy0rKLAOPRyEU0eGz/JUomsod
         nAS+jCrVpbppHkwwX1smB/Ls8cihrjKn2XYCofYQaSaZfJf/hVGOL9qwCyLVq0r15P8p
         8qSuR2Wn7y+XB8uiDkVx9Ww30M8d9hLx6cOEoItJfV4bpmgTIdVo1ofAqAVf9tnncREI
         HFpSLI5CUQndS5bo/iCOny8ovmyxPw3pxVkjh6mMNRWegGDu1pD+LFBYpP8O505dmHlm
         6fnzLWMs5nJEPdXARHJQHUTpzIZyidfc0uhUptGRUP/U8Jn97Dk6vkiqoE6abIWBX24j
         MlLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU66kdBhTtLmSQZHVTzN9UhOQ4k98JBjcn2rk9sKQ+QtzU3Cav3pIoEyJ1RCY3jyfEJqRtoJN/1ao6H1HpxtseV/8Z2jL1Gp6Ixtw==
X-Gm-Message-State: AOJu0YxDJiP4KaxejcbPb7ZIbHIktAgw/HdVihGRO72ffL77VWB1Y9rM
	xbxAQgy0ghlxAMgCcFeSPHC0xzBNUA3Sw70Urb1VudTEbHg5M0AF
X-Google-Smtp-Source: AGHT+IGFD8UcnUWfAtOrktYS3XPLNwRusDiWDkC1Xvsjj1zIrmYzOL1G4rpSrpvg425XDPJUWhxSfQ==
X-Received: by 2002:a05:6830:6e04:b0:707:e28:58d2 with SMTP id 46e09a7af769-70940c0b3d6mr919254a34.2.1722023539885;
        Fri, 26 Jul 2024 12:52:19 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:c1f3:7caa:bc8b:ab10])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70930778069sm889972a34.59.2024.07.26.12.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:52:19 -0700 (PDT)
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
Subject: [PATCH 4/5] dt-bindings: arm: rockchip: Add GameForce Ace
Date: Fri, 26 Jul 2024 14:49:47 -0500
Message-Id: <20240726194948.109326-5-macroalpha82@gmail.com>
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

Add devicetree binding for the GameForce Ace.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1ef09fbfdfaf..a5a2621404ae 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -255,6 +255,11 @@ properties:
           - const: friendlyarm,cm3588
           - const: rockchip,rk3588
 
+      - description: GameForce Ace
+        items:
+          - const: gameforce,ace
+          - const: rockchip,rk3588s
+
       - description: GameForce Chi
         items:
           - const: gameforce,chi
-- 
2.34.1


