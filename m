Return-Path: <linux-pm+bounces-2731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D06D983C236
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 13:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8181C22C55
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8BF4502D;
	Thu, 25 Jan 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvkP7mgH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C94376E1
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184692; cv=none; b=p2AUZvlzWdJqPpURQ0WejL9Jg23nmW4IUkd4OF3EYz9ECK+G52PChCPOK5km6tlDgw6sEFW/FGEaL4IQaNIsBcbEjKxU4cEtbZ5G405n28+tnEnVHMOmFcFMkBubvAlMTBF58ABsUXY4jBkCAGxgTSbJrH2wLl2zGP3gdvTg7nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184692; c=relaxed/simple;
	bh=ZPr6E4c1CKD0WVJLVQoqbaMXnDZAUQSUX250E823OTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DQ84SYCYTNKgArzFxiYYO3hxv46/wi1n2R3dPDEbzCw0w2D+fs69uyFRqxbmGDMtzrLcREjm3+ay8JZYR0q4ccGqfBZxz1FJixLW+fNXrEtb4w66D2IsV/d6oBt7zT2XuakY0lFlKIpxDA3cfx8oMF4VFT5bQOIaFGalaE1oGIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UvkP7mgH; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50eabd1c701so7643035e87.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 04:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706184688; x=1706789488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yB2oUZTJxFBXmfGYTP34odt/VQAw3YcB9sjxxvoA4rY=;
        b=UvkP7mgHpzs612whY5LImcD0LMgRQ756HnNzbWZKQ5QR8elIritTmOGJXmkMJHgSkn
         5gaOkINnZyuZFuk2LyhdaQvGgDjUf9qs2jC3ZvI63txBVPbJWPkaQ/AqVBo7i/CMrthW
         RU5OdxpASB/pLMqZ5THWg8u0t2ajjO+n5HBfMsv1FaF/GFMt13bPMySUoEJOySqWqKXi
         IiM9hazFRIajMdRJcv5Fwalr0dq7tlFGsvfi1vaen9EdZIHLZbi2pRBmtq+0DExrg/mq
         GabOITeVrTHW8tOYOXySvYkjUMuzXEtogEB20v1JV1/1gz+tJqKEvRPNSKfDxup0CRsW
         ykrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706184688; x=1706789488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yB2oUZTJxFBXmfGYTP34odt/VQAw3YcB9sjxxvoA4rY=;
        b=Iw7QuNXVNWwrDYP/rifwlFlQqaoa5nUy7FJY80aWWPeCpBkSEpWLHZARuI8eCSJ/Ux
         japLRHh2HaiifsBli+zu+pI15fxoosYcmA/4PN9EjWPvDr0DF7lLrknyjWWEBaiq/WVM
         ScziUOEogUTTKqJQd5xUeRvZucGyaDrpPmJY7yv1N2QrweIHubj66egVmHgGxW2zYALP
         hGYkdasHlPHz15ibnRXEXVKQuModl/ehVZRfRWomHTbnbawZQjwZxf0bZqv11kNOgfUJ
         ChW6ZMkf1Ick4UOiuyknBXzL+31SKlnx6hpb/ynDYbDLCan9M6BHb4zVuGIq9I9UvsSM
         TB7A==
X-Gm-Message-State: AOJu0YxJ/hG8HE1lIIkC9oAn1KrJGbQNqDnb+70fkE4xNISDLStjnk7J
	KpNy92KSPSCwLqphM243Q1+lFvYMvET9OywZNQ6Lp5JY12DcNz0lrS+itEivSHA=
X-Google-Smtp-Source: AGHT+IGJ9Ulfs3cW+fmPeCGH3QcncDosCorfFRPWC8zOqkEkU5iEvWfN4BRmkCwx0JY3N+ie1eIw6Q==
X-Received: by 2002:a05:6512:ea0:b0:50e:a6f8:aacf with SMTP id bi32-20020a0565120ea000b0050ea6f8aacfmr820110lfb.14.1706184688088;
        Thu, 25 Jan 2024 04:11:28 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y20-20020a196414000000b005102188d154sm21221lfb.108.2024.01.25.04.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 04:11:27 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 25 Jan 2024 13:11:15 +0100
Subject: [PATCH 1/2] dt-bindings: thermal-zones: Don't require
 polling-delay(-passive)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-topic-thermal-v1-1-3c9d4dced138@linaro.org>
References: <20240125-topic-thermal-v1-0-3c9d4dced138@linaro.org>
In-Reply-To: <20240125-topic-thermal-v1-0-3c9d4dced138@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

Currently, thermal zones associated with providers that have interrupts
for signaling hot/critical trips are required to set a polling-delay
of 0 to indicate no polling. This feels a bit backwards.

Assume 0 (no polling) when these properties are not defined.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index dbd52620d293..68398e7e8655 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -228,8 +228,6 @@ patternProperties:
             additionalProperties: false
 
     required:
-      - polling-delay
-      - polling-delay-passive
       - thermal-sensors
       - trips
 

-- 
2.40.1


