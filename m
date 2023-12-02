Return-Path: <linux-pm+bounces-634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C84DE801CBB
	for <lists+linux-pm@lfdr.de>; Sat,  2 Dec 2023 13:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050D41C209A8
	for <lists+linux-pm@lfdr.de>; Sat,  2 Dec 2023 12:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F6B179B6;
	Sat,  2 Dec 2023 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvzB+4SV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96959184;
	Sat,  2 Dec 2023 04:52:03 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1915034144so343829166b.0;
        Sat, 02 Dec 2023 04:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701521522; x=1702126322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TpM4rIE4qqT65pAaY9eqEHRHauyEUGalgmDwr8uKk4=;
        b=DvzB+4SVvaZ5E7kgZq/vNnIrEy7ZKY1oIecH8mwiuMSBafsNMYf8C/8SPTd8e6gCHO
         W686GAE2pYDYdj7Y7XO00+4TsjmVUthBfuWdYmoXch4GXhMrIBc3EjxeuVUI/EMQM3Xv
         OCG9ogq4RZFyPoDX4qw3NTss7qFo8/ZYlbRE7T6oYk68wH63r+QSDDYMoF/hhIHH1d30
         bPYVTPE+iyRqaGxPrjVa18J6bu1GBFp9gsmt5Tqu0bXKyZkf5FGyU2dumFe4dZXcMga1
         l54PUu3uyfgX3yaRjSJ4jWlZ0sZZPmiNm6XcTnqenPcqcIkc1UgtlxNJZnBoHInHubxY
         ja0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701521522; x=1702126322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TpM4rIE4qqT65pAaY9eqEHRHauyEUGalgmDwr8uKk4=;
        b=nPk3HkSMg7+1xTS1nnWztwXE/TSmfEjMJCLJ3yz4oXoyrDf0HqIu7/zQmQWecnzqsf
         bSVYGQ4deXZ03OTIRcZCjqGivuggr0lbmQkUqWJ3nprl2gr6dn+KcVDrRnte9ifLgA/Q
         mOqxvCFyKqOE58bqmuqWW2d5oDeJ8PfS9JJAd/+O5xkA4tEoEbh5I1aw9jijIeAj2Bsq
         BA81wbji/07e/SxfwoV8wK1i+QJkQFzI9B5JwYEwiyQZSx/c6wSXC6Bp6AmMWVn40Hel
         nZfoCQw8DWiI82BLP+PmpfIeW6ks1S+LXd9WQtTfafuXR51GClah0OASa2nJCzs4iPLd
         YtjA==
X-Gm-Message-State: AOJu0YzTcR93AN9jRRVR2d4hnB5YUxnxl+mgR0jgKhoom1xz/Dmy6Ex2
	xM4AmqNqvujgh9nAra4Ty8oFniz8yQ==
X-Google-Smtp-Source: AGHT+IEyleq1fwiEbFjEWs4F50ggLLxGB/KOmVoOHqA2365tzKaQw281kj2swtpYsUJqACRktkUtTA==
X-Received: by 2002:a17:906:3b43:b0:a16:92f1:2f47 with SMTP id h3-20020a1709063b4300b00a1692f12f47mr1536630ejf.57.1701521522024;
        Sat, 02 Dec 2023 04:52:02 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:908e:b829:354b:f8ee])
        by smtp.gmail.com with ESMTPSA id g5-20020a170906198500b009c5c5c2c5a4sm3018161ejd.219.2023.12.02.04.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 04:52:01 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/5] dt-bindings: gpu: mali-utgard: Add Rockchip RK3128 compatible
Date: Sat,  2 Dec 2023 13:51:42 +0100
Message-ID: <20231202125144.66052-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202125144.66052-1-knaerzche@gmail.com>
References: <20231202125144.66052-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK312x SoC family has a Mali400 MP2.
Add a compatible for it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index 0fae1ef013be..abd4aa335fbc 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -29,6 +29,7 @@ properties:
               - allwinner,sun50i-a64-mali
               - rockchip,rk3036-mali
               - rockchip,rk3066-mali
+              - rockchip,rk3128-mali
               - rockchip,rk3188-mali
               - rockchip,rk3228-mali
               - samsung,exynos4210-mali
-- 
2.43.0


