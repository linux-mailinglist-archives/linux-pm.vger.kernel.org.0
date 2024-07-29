Return-Path: <linux-pm+bounces-11572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAF993FC9F
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46BC1C21B62
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F4B181B83;
	Mon, 29 Jul 2024 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6ZEg9mu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D015FA68;
	Mon, 29 Jul 2024 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275272; cv=none; b=m1+ppU35UoZeKXlWmKxxA77LxXxSbgXUcHBwSbGLZmV3/AgwlNPT83WxtMKe8cHuGIDl8trsfGiJP69VNGG5dnIlmDT7ZjPS8sX84lvF/kFJx559qFsobMKTkjGx3cP8v9Vj44kPfBx6jLAq+s8wiHEEKPHGrp+uz3wo3sty+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275272; c=relaxed/simple;
	bh=XiA66QrY1cKpyMYoVlkQgoD3V8kx0+u1J/F4sMqHt7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRHuz/wlATzl+vF3P4yQwBMLdgW/oyotzx2i0y53M2txQqtCoUcdVIW8LAIFmFxA+7B5RBl5UdKDkB2SDUjQxhJEiXOeyXZd2ON/cErwGFiDrdb5D8/JvUCkAtAupA3MQmBi+Q4aqBX5HlRuh315zpqbgqVHAIFIurDKdVU+T/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6ZEg9mu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280bca3960so19634085e9.3;
        Mon, 29 Jul 2024 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722275269; x=1722880069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkEdD4X8B8T7oknY6aCSNjWcx7qQc569zwNW9DTeGn4=;
        b=I6ZEg9muA0MZM2d9RXtDPdrlgP5On34sKZW3wR5mZd+PJNesUnmtCdt1e6wwzldgYc
         HR8DO2yeo2BhV6TRWD/cwWWIntMRA4SU+GctBDzavEzt4NM6KyG5ig7DyqV8IMLvpx/E
         5uaD8THrmUqZZS4suqFw3k9YxmKD4WfH7+nAGTWvevOPvwuq6n19RuK/GYfAw0NCkIPB
         o25iCc4OjJUElwVo2w+woWJhfxbk711bVGbJMhMiI0jped20+execOJzX8BPrx1Xcbpo
         pIbECyn+Gm6wGDwqwrp5EleH2VSY+jIIFc09IBa2qN9Q69bcxn6nNe8pymAeFtGzHfxp
         8Lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275269; x=1722880069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkEdD4X8B8T7oknY6aCSNjWcx7qQc569zwNW9DTeGn4=;
        b=Ul+d9qZztZCdSxBFQVlJoTolqfoeYtskugJ4SbscBxBf4pkzwZRtTlEnBwMcf9GmVo
         H0XVY2QTGgKwYOSeCJ17SqkAlenKYLUZagjGVJh30doGENpAGkmmDicAhzaLmtQWBxyo
         ZhddR+wN4tkrAwtkvd/YRv6xuKOTutPfsG4nK3nxMzu2loITUtxjTg8vJWMJI9zFyHoO
         UEwXGbYRyC3Ayh5gSZErsgrmPBi64PIkioFZY7Y7gb6YVidSl8wH6eUXXmHB+43mtfMH
         5BTjRUmeciF5pvHLuHlSW34+F9gGWt6dkDY4trE9cAvSlOOnaDmT1nMDXVD+EgJkA3+B
         GtyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ5qlbqvYtEEpXseHIJDyi7Hca4WV9YTTayOdFEDw2Y5ToY3CBzsEe1LuG2dr7Uv6VDq9PAg6z7plwxM5HDOQ/dztwjgnQ/pFbi6riW1uhP6gLs9j0cDdO5SuHibm0GFGMsxhz30uq2yQA2IZdm1YdDd+uhw1WIkxFNKHOl3X+twTA3KUGSIi9+fyeSHHs4SN+NBu57wjZGRAsdStcHyYGajfwlco=
X-Gm-Message-State: AOJu0YxB8ldUBTB3F924HWBx6T8/mtx6MtexYlJe4GhE13nFLglVS8K6
	tSwl6s8/zldOzyiFPX/r4KN6oqP8LW0672rcx8uoeGfbfVCr/gd3
X-Google-Smtp-Source: AGHT+IHFzA3benq6KmvJSdWIZUCEBHfwHUXl0n3vqkbeclIfATIrtxzc4QgIEKoGiKCBOyXFMfqm7A==
X-Received: by 2002:a05:600c:3111:b0:428:151b:e8e with SMTP id 5b1f17b1804b1-428151b1210mr49714045e9.10.1722275268565;
        Mon, 29 Jul 2024 10:47:48 -0700 (PDT)
Received: from tablet.my.domain ([37.30.0.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc8a7sm12716550f8f.59.2024.07.29.10.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:47:48 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 29 Jul 2024 19:47:35 +0200
Subject: [PATCH v3 01/10] dt-bindings: power: supply: max77693: Add
 monitored-battery property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-max77693-charger-extcon-v3-1-02315a6869d4@gmail.com>
References: <20240729-max77693-charger-extcon-v3-0-02315a6869d4@gmail.com>
In-Reply-To: <20240729-max77693-charger-extcon-v3-0-02315a6869d4@gmail.com>
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
 Artur Weber <aweber.kernel@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=XiA66QrY1cKpyMYoVlkQgoD3V8kx0+u1J/F4sMqHt7Q=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmp9W+hyYirrvSUUSF/Ig46ckgslOodqZNCsTXs
 HIu6j1uHgyJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZqfVvgAKCRCzu/ihE6BR
 aKdLEACEQ9fwZeu3U1x9GzFDQA1ODMTVTblEzeQV40qOmlcuUnUymB1ZCfwC9jtoV6D0YMFm6dQ
 WGScggQQzjgIIpnY8M14jStpnw8AndMqgNJaU//aH5veKVjH0QFRCsp7Z9aSFxuJHJlt+tTwhC4
 n+bOFdOOzwHFHJe02AKohvRLQxb2/EvWGlOMXnxVJJ57SoPBoLgpZGKGOWp2MWd+lI516sHiSD9
 xzUtI6YkUN92UqD3Vllno85lhJYjtHBt9L6XvmWlHiUSjVn4x7uSlWQjNy5QJH9AITNHpF7RMcu
 +Kx7rKm+2gyhmUnBVFVFzJqjcorolgjQ1zDpjTiKhHPFqcJPH/9XcPxXrvrOKyADBMosdgAkG6a
 TnTR7D68egq+iIntelaLLKQ7z2ha53ToJi4Lj9XTH84OWpU93pMq4tFhyASZYZHV51OJQOH1TQO
 6xYvl1bXJ3o7IFCPe67ITcB9W5Q6bslun+sPvii9Nb0TM8MJOk/ggPi1JlG/OyXPToUNoWWmDOT
 Qsx5VRrsEFGB/Q45VAo2gNXlx8hhSJQGZ6msiq4u9SEn2qvyJSD14ooCys9v1ICgcHQF0U1ItU7
 Exuo42lFDdtVb03bg8dLoUJ7zO9ZBiKhFle6I19/G/gZHoPosmJPtaNu+c5alDerneGhPI4nbBR
 LRajcvaq+/TmC1Q==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Add the monitored-battery property, so that its constant charge current
property can be used to specify the current limit to use for fast charge
(when plugged into a wall charger).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


