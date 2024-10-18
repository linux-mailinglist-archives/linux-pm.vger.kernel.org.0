Return-Path: <linux-pm+bounces-15925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E2F9A382B
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 10:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80F69B231E8
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 08:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2A018E35F;
	Fri, 18 Oct 2024 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbEw6ZW8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F818E036;
	Fri, 18 Oct 2024 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239106; cv=none; b=MRupQJehMIWB/MCWXN+qJYis/3uncLzsSfzbFYrDNDxb1uSRnqaXQqyPepUDZf23Tg0Vy6Ni0KbUZsfaEIBvLBJEaTi3ab8kNXIm4xAVgYtMLnYrQwpUn/BoCM/m6H/BY4spmuplLzrfYpw+Bz0h0jsXHIvCdAdhMveaYkdoN4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239106; c=relaxed/simple;
	bh=wPBhfBZJtvqhptI8wCuWTJpsTMTquo3LrBFofFujk0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4kAaEUIXFQNVFShHz5D1SGzEYmXxI6j4NF0kWrMIioZWt0NYfF2I+aM4VTe8UlgoEj45KzWZtDas/jS3zaX8/SRaAKdJUMKUoAVx1B3T/icovqS9ByY4j0FK6QKB7cVHkmCNgGpcKQiL+FF6bPRRlXVhcaIGrkAG4+pd4Ie5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbEw6ZW8; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99c0beaaa2so286239366b.1;
        Fri, 18 Oct 2024 01:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729239103; x=1729843903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/zn5scuA4cBnjeDcZDLfq+bKDyVI2Q6beFukEjg47s=;
        b=lbEw6ZW8mu5/n1gn5y0Duk1kpeirwbcasSvTlF1mOyD5z6fs529PfnmFyzFWPVjqmi
         DjvYu9YBZM1tMRg7Moucsbpxt1J6nAHSEglLkA8zhv0N9AMEkcdSkW2eCn62rR8/dm9H
         JUInA30knnHZtsHkWKKYxzIsLmz4cA5NR9woS7QO5/EtKvFjvorDd7OFugakWwoV1Mkk
         RxQnG1a50g4ofSyHRFEYin0TUexlZjUziKLzn18hmyCCmYr924MX8hbG/6ZOI7EJektz
         7PyDmY1kVm2hTyISOROmy2aV/IQFqEu8+kQ7k8R9Hba/8bLfXCiw8S7uo0qikeAdSkJ7
         +v2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729239103; x=1729843903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/zn5scuA4cBnjeDcZDLfq+bKDyVI2Q6beFukEjg47s=;
        b=M2+nga9KRdIrMoY5zt88kx/PbAWFETquAFlodPSyOMRiIO5PSCPYh86OPw+0spa+dG
         f87fWB3ypfuqOlGMVdIm2bDhJNkte0+10bMJK3cEWuYQFjxi+tDNFicgvVOIgDjcbrje
         2vJPMpd7uOJuUAeQoP8dxQwukZOVNsCVdjMRSZU9Fpyi/MfKojyr3RLhItJuN53iTu4Y
         guYEPDXRGaPil6saA+gzrtjsyiJgnY9JE8Efxh5FwFmmDtVl3g0bo0GBZNKG3gvKBpMj
         V/HEGnZplLiyNvchw8FSGw9QmXZJjJ8YnNV+5eq4SnV4DtYWpbzLofnIYfsM/BVbfYOG
         ZYNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW++oHSb0yt+0P6zMybJ7NFeLfVrRnGVNYEGl5+CQldNa46yieOPb3pdKp0x+I4zMszjh8RWj/gReUM@vger.kernel.org, AJvYcCWV8klcDlKnObiLv8/3AO8XsoucTTQXtM0yOgP49i9lefZvsD35my8lPOu1sMfWf2azwZXt5h0M3bY=@vger.kernel.org, AJvYcCWh5/8ay5fLQSM0pLtKobm/huivblnZeTa1Un6Kx3UCdFBZ0wZjx3bIh17kuxxfGjnA2N603wpchjaYsezx@vger.kernel.org, AJvYcCX+Ev7DF4Ga/wkfcA0eOhnExioC70xkARho/uSaqFPVy/94KehaikcCQRdI9TNPnGjqEHJ2Q+0GHQp6jnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGxYAGKYKMqtQPHD7HP5EEygCe+g9RQ3E0ujqQ7pd9UhH8hL+p
	PbQFqLHuuml/WG9veoH3ERawrQPvG0ngWwJcWo1DeHrLTsvVpZgz
X-Google-Smtp-Source: AGHT+IEJndJ7T4QgNQNyzgKQM38xfv83GpmaPCAjcHMYMqbxlqndRz6v+yB2Ezb0u8Tsr5rWSpM9Wg==
X-Received: by 2002:a17:906:d551:b0:a9a:13dd:2734 with SMTP id a640c23a62f3a-a9a69bb59acmr139359666b.36.1729239102699;
        Fri, 18 Oct 2024 01:11:42 -0700 (PDT)
Received: from zenbook.agu.edu.tr ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68a8e734sm61129666b.24.2024.10.18.01.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:11:42 -0700 (PDT)
From: Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	Yassine Oudjana <yassine.oudjana@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 1/6] dt-bindings: mediatek: pwrap: Add MT6735 compatible
Date: Fri, 18 Oct 2024 11:10:43 +0300
Message-ID: <20241018081050.23592-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018081050.23592-1-y.oudjana@protonmail.com>
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add a compatible string for MT6735 PMIC wrapper.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
index 4737e5f45d541..d5965dd38df0e 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
@@ -31,6 +31,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt2701-pwrap
+              - mediatek,mt6735-pwrap
               - mediatek,mt6765-pwrap
               - mediatek,mt6779-pwrap
               - mediatek,mt6795-pwrap
-- 
2.47.0


