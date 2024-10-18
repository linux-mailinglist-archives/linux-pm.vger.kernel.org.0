Return-Path: <linux-pm+bounces-15926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467489A382F
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 10:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764921C2012C
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 08:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA2318E74E;
	Fri, 18 Oct 2024 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9DbTrRu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9049F18E37F;
	Fri, 18 Oct 2024 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239109; cv=none; b=Paik8rJgU8WeWuU08yUA891YfYu4Yth2u8BXiM/bBTC4aC0kAmRfBkxzTMa6QV+uAIlFBdxyDX6J7QnqBEWkvpGxEnpgwvIvRmBzFxMHhjA0qbA0JTH5mmFqw+YjfJfqarxLmcxR9MAKPPsZ/cHz8Am0aGqSCWOGaIbur/oiM3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239109; c=relaxed/simple;
	bh=mEfJTEbJRz/tvY8ZbNfUuNkM15kwjnY7jB84YevfdTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBS/1iRNIpVSxHgvAWGh4H7kATt/CAuKEk95WZdiDANI0pK5pq0tSDRhm9cLtFECw2Bqzgnrk0CQStD4dJBmF/r06Rqw5Rc/UBkApHa+CSpMBij1d+QPAe9gjk00xJoqdFOaXyaFSMM+D1HVbKwU2LLke6zQLdDD9zrJjJYEbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9DbTrRu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9932aa108cso264521666b.2;
        Fri, 18 Oct 2024 01:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729239106; x=1729843906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApvJO6d5QNNF3xPCBagvaYSTGXu+2K2cOSJlqV2xdXM=;
        b=P9DbTrRu17nZxiRmKhMkWC1fop0Os4lzfUNYNa1tWhZNdNwfCt0rUuq1JEcX1ZXeg8
         BWOkh0txMqMoght2EdZUTn3PPin158BruHDEDQUb2VmL/oMymsIFupJN2bJ7MqYm5zBY
         n3d46MqQC4O2mHfiTUrtOCP4UeCWrM02hmbOluWS1lV9z+UUhv1gqIbAxyHTe6AvlEWX
         Z/a0YD8t0Bv4xj0YM8tuJ7Z1sebzitmu49CJV0hKlxIeL4lRC5X26dKPde4ObN7QQ0sV
         ONEwYtHP85YG0mb337JJjO8YwzmBgnICUAyJGBcs1TLkvFSon7k9P//N9IDG9dnEucR+
         EMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729239106; x=1729843906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApvJO6d5QNNF3xPCBagvaYSTGXu+2K2cOSJlqV2xdXM=;
        b=AJ7A7jbHnCWEYfO5pOot+3yGdGQrHiADmtL9e0bHyVcmdljeT6lGwn0xbEaxMQ2j5g
         FswjYL7dcUXvPxGYYHW5QsZhIaheSxt2rvLOuoS5zT/Nft26fneTETob86506JvfCSPm
         Yv5zcUzyR09MGG0jlO9DSXmVYA5jqNp5RxmiRivHZ3HuSmhUxo4aAl2+nGXeaitMLcDO
         IYfKzVpXLs3FXHzeZ3bd760ckOF6l6SqRiqFu0fZS19gjBeFIb4H7BHArdx/MyAuU+eJ
         T3nSqTkQWT58iEYxbwjrUfBDhSyeT52YoTQaKUNCWULH0O1AyeSLlODOznfpjP3jdg7A
         nNIA==
X-Forwarded-Encrypted: i=1; AJvYcCU/SDd26PhEMxonNLtbUYKKB7fStQt0OH2d3XtO30DAeLyVe6Cfb8UBIG+ui9WnhTsQa9vLuysEVmw4@vger.kernel.org, AJvYcCVaM+PZm82SstdClq0PisZ+2YhLBTE44VCAe6PQBXoueym9Y5xlu8cauYOhsUst5xsOrnXsqfoYtSmnmrc=@vger.kernel.org, AJvYcCViL1xGjouT5WdQQySFJuQtwT4RZQY+rjNHa8+gMMX9TZ9wWGKLeMc5ZM0cBTeZEFFJjMuQDKeYLX/IJeBS@vger.kernel.org, AJvYcCWihxiWljPA2OAYuliswSM/u8NxMoemRoJgHdnpEzALfczBBu1PwEhYIHuBozpfWC6m+QJF//YQ8dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR0aLPk4MRKmGLtR3vukxr++0NrpG+Yj4ttvjTpRjQLTrOdHY/
	QtjTTqmrpERaq6WnIzYwTAhcb0qPAYMlIv5NO9POxhOLCJCmOe08I/rr2HgC
X-Google-Smtp-Source: AGHT+IHpgy+ZvIS+CmXt9F8h8DxgTe7oDeEKUVy4LrsM1AJZIkYp9J3mz10ihMJQWs5+U1Tp5bM3GA==
X-Received: by 2002:a17:906:478b:b0:a9a:3705:9ad9 with SMTP id a640c23a62f3a-a9a69c98d93mr129677466b.50.1729239105439;
        Fri, 18 Oct 2024 01:11:45 -0700 (PDT)
Received: from zenbook.agu.edu.tr ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68a8e734sm61129666b.24.2024.10.18.01.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:11:44 -0700 (PDT)
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
Subject: [PATCH 2/6] dt-bindings: mfd: mediatek: mt6397: Add bindings for MT6328
Date: Fri, 18 Oct 2024 11:10:44 +0300
Message-ID: <20241018081050.23592-3-y.oudjana@protonmail.com>
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

Add compatible strings for the MT6328 PMIC.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index 466566ae7f103..6a0e66fba53c4 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -25,6 +25,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt6323-keys
+      - mediatek,mt6328-keys
       - mediatek,mt6331-keys
       - mediatek,mt6357-keys
       - mediatek,mt6358-keys
diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 95e9566fc535d..224b9b1bd629d 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -35,6 +35,7 @@ properties:
       - enum:
           - mediatek,mt6323
           - mediatek,mt6331 # "mediatek,mt6331" for PMIC MT6331 and MT6332.
+          - mediatek,mt6328
           - mediatek,mt6358
           - mediatek,mt6359
           - mediatek,mt6397
@@ -85,6 +86,7 @@ properties:
         oneOf:
           - enum:
               - mediatek,mt6323-regulator
+              - mediatek,mt6328-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6397-regulator
           - items:
-- 
2.47.0


