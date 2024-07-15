Return-Path: <linux-pm+bounces-11103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE0E931500
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 14:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB601F21AF2
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE23E18D4B6;
	Mon, 15 Jul 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrWptQsk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECAC18D4B8;
	Mon, 15 Jul 2024 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048116; cv=none; b=MCih89CR0MXx9InIzQ0qzU3FIKG2lgBhUVmH2S8tWyHbinFnM+yjsL7wwpitEwOJ9pbB4xyIXiHTSPfcBWCY/CXYa+N+aWz+kzh0x//cbsTv27FMyIxHEeU/tXEJszI63FWuGG/dH1Ln11jU/1z0tRxTBZ2vfBgyytiUyY0sJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048116; c=relaxed/simple;
	bh=Sep2YFazyIuwJAAWmtMhPpLW3/gwTfw1XNyWXLhamO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q7ZC9c12sjniTvq01iMKV+s8U16YaEN81dsmVuffCPNGqXqOdJ5BkcZ3fWtAvQ0kku9vcuEe5k30SRNtPyLIbVv+6411Dhk/OLTrZQfqrnpM+liQF32rPeSRoU1SpYqxdBOb977k0SwV5iXud6IcZ/LxyvuNDHgGSGx1OBd2qyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrWptQsk; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eebc76119aso47977991fa.2;
        Mon, 15 Jul 2024 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721048113; x=1721652913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yy4EKK2MMNMVFHHJLnbyF0PIFup9QUbwgUbkF8k93AY=;
        b=GrWptQskV8HS4ww1ce+YEx+l0JwSZT3Alrp/PfApLsGKDAy6qreWZDyggcHxnwCPgF
         GRTvHe+5pnGQW5niajJ43iV20KV3d6bgG3xiYDdOmPhqDQJktSvdCan7/hKRHHyhH0oq
         fLCWTSP923x+GqlKFfFidBRWk9kKiIJvQVT7rAWR3EyreDQDcjThumDH/HCsiV6W9rNz
         fmhg6i2evQmNL70qThC4lE33QebvrU5hipfEAOJCwYjdNrsJpniaSAWMBKG6q3w7/S6R
         Hy3SWuuA6Wk8E8gcja5NoH/L4wzr37pkLXLJif2a+OrToInLSE1geKyxIxCUyICzkYtT
         ahBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048113; x=1721652913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yy4EKK2MMNMVFHHJLnbyF0PIFup9QUbwgUbkF8k93AY=;
        b=OiMUjhCKQwPrJNE5sJ2orszf+eTnOqvKSEqDFVQMqCxARZcHB/8u3ToWzLXVP5LlQR
         M/5AbEwu2N9b005RbNTdl4VcAiRgdXH3rusW2Th9nlNco6C91Tj3GD/Y4a1OLESoTg5U
         3Lre5tUnt515vFCcSadPEiizbX809H0eIP17tW2lbFIWfrBrCKed6qnePr70gYnp2rgy
         4kDDluLPdXn8ytCvPuBqpC0sRopPMEU/dnPnTenxZpncbIryyKkcgIrxrDEOwRo9+81I
         3x/IVCoAZVTkUjsZKTFRB7+cFmVEvWDRuSYWChrxLrHqvkv6yG2MujmDqkjzSMKAgtvw
         yRLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqFoaefrTxIEi20D4hQOhv7IEfC/A1hZ88FoO4fdOdE784XzNzjXclQisEpeCKDA+05Z3AlibQLf/ZauSeNCWtOe8bsrYFrajpDJmI/DG33VeByVuhYdEsaAKRlZEEOMRJGaKD3JQ6GLdxkWJBjxKVx76bT5ZwXn/PkBd+hH9YZdFNnaL7zRTdoqUBq2jI/FQqUG0a02N2HGRsHePvFZ2OJ3F8hUM=
X-Gm-Message-State: AOJu0YzpKmuEZcNxJLA54Ej6febO6y5wpH5BHSIZRB2HGv64Cjwg0EQ0
	upHSwaX15FW9HTciEzfOK6d+nzdL4ZN7598QrRIvW5T55qmK9VjwPogRdUyq
X-Google-Smtp-Source: AGHT+IEZ/wluphxBn2a6YcKsiQTSr9JzIe+b2teGX2aiGb1mLWNivX+caxnotyDZOe8tkjXU+WzrGQ==
X-Received: by 2002:a2e:9d06:0:b0:2ec:4acf:97dc with SMTP id 38308e7fff4ca-2eeb30bc9eemr126107771fa.11.1721048112386;
        Mon, 15 Jul 2024 05:55:12 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-157-210.multi.internet.cyfrowypolsat.pl. [37.248.157.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f62165sm3333307a12.87.2024.07.15.05.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:55:12 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 15 Jul 2024 14:55:03 +0200
Subject: [PATCH v2 1/9] dt-bindings: power: supply: max77693: Add
 monitored-battery property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-max77693-charger-extcon-v2-1-0838ffbb18c3@gmail.com>
References: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
In-Reply-To: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, 
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1452;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=Sep2YFazyIuwJAAWmtMhPpLW3/gwTfw1XNyWXLhamO8=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmlRwpJjCLdx8HCWez4ml9uY6NIVfmATTP1DiqK
 sIjVobrj/2JAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZpUcKQAKCRCzu/ihE6BR
 aA+OD/wKoQpFNAsUIXuHULAyeJawNlA3bvCuREiYKFG7ppjjBd3+Nx6dCwCUfb1o75KDWzlZ2zp
 v/r8kICqtqtcoyqKffJfMsaImvev6dq8Bk2hebpwa86QvRiEs+ssMw1eViuJXLmP4nw6r7lku4f
 q6mbFW5qHLvpxI4CBgeuwY28y9y6NR/OgwcGsTx9CRGNwo/Vf5WGQG5TASW7DskE11ftwWVprv5
 6PIWKIg4EYWWwVqTsBPCc9bzk46dYMMO4sk0Q8fvkB4KUGGzI+0HMlj4bSDQdn/ZF2rPpJoow2v
 ba75TL3UVonJA/gCRZz14y+zdIc3Hpq0YObqOW7xDCa+GfPdc1QNyxd1p8+iyGhTPRk3Ix8kMWz
 lbH55+nzJ8jM8MGx//51mew6uWa8wzcA4GNA4NQP0pxoptfvcvu6NEBwqlJf/tpIp+eOc4G9OVV
 eqggCPYcLQuhrX+UuewKbxsigbH49om2D+Y3h+i3YZgZ8VokbmhdStE4aqddEcv9MVAmteM8DWq
 6X/KaCOtvopY9MCw57bXHgyitnxbi6kgy9gXa9S/KThHcEXxfJBtXw9l7+XW0UiS+D4czK3M5us
 86XTizBWbtRm0MfkNC0eyyx9QB5umLav+YaZLWYhojB6R6a2hmaYpK4AYdjwsmKyGL+8iO2mqS3
 PFg7DCJfY4Xde5Q==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Add the monitored-battery property, so that its constant charge current
property can be used to specify the current limit to use for fast charge
(when plugged into a wall charger).

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Switched to monitored-battery property from separate fast charge
  current property
---
 .../devicetree/bindings/power/supply/maxim,max77693.yaml         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
index f5fd53debbc8..2f4437dafdc0 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
@@ -16,10 +16,19 @@ description: |
   See also Documentation/devicetree/bindings/mfd/maxim,max77693.yaml for
   additional information and example.
 
+allOf:
+  - $ref: power-supply.yaml#
+
 properties:
   compatible:
     const: maxim,max77693-charger
 
+  monitored-battery:
+    description:
+      Phandle to "simple-battery"-compatible battery node.
+      The constant-charge-current-max-microamps property of the battery
+      node is used to specify the fast charge current.
+
   maxim,constant-microvolt:
     description: |
       Battery constant voltage in uV. The charger will operate in fast

-- 
2.45.2


