Return-Path: <linux-pm+bounces-8060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EC38CC94D
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 01:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E301F222DB
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 23:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C511494D2;
	Wed, 22 May 2024 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT/7ltvf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D55E8120D;
	Wed, 22 May 2024 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716418901; cv=none; b=EpdvFvHKEAzo2nkNuDe2d2XtO2XeUKLGUoEWI21glt5SMHzdG5dReuNo55WdVgf3XZPGgi/ZO+VdAdaeGP4OD554wfeDbnoZwdB1Q+dOhrBa9ei7wDZ0ih2eYgfrBN6BqD/hnWjiKwztoKO4rhzTJfVJEZ7jmontCiQhWsOjXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716418901; c=relaxed/simple;
	bh=pOvzFgVKP/kGa6+Oj4KEJD4+I3wsBQtRuG8wg87QWT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjgGv2vna6iBbl+BxoHfeGNme1rx3IhvhNuvnisNKbrZztQ3Z7DpfGYvIWpYL1UCBSgb1cDoWstyBA4dqpIn/ondMtzMsGLn7VLSdFAWiBDnu5BczwLIqsI00ayYfNbHmx+zcRZ19PtTDr9uFCmPQREo8OtwETf2Cdp6jujlZtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT/7ltvf; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f0f5633a45so2675135a34.3;
        Wed, 22 May 2024 16:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716418899; x=1717023699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2qTU9Hshqz6t1vKHlNCBK7tNf2KsTEuBaP1htzZOzY=;
        b=gT/7ltvfxaUAlR1T+OJSa4oSxMwKbX02rMic2e7EnLf+U1YmW836dqP8+hduGo3Mhq
         KduF2Lv5ot2+SiMKc5VezIxk5mmjtFVcx4RLVYkAzC05vMUKRaNftlGW0cZRZAKlNxgG
         4kIsU5pstvG3m97BJ+khWM5vB5BnaUSsBNL+gMihnwg0xeq3yVeoUnqvDiEfINEcojs1
         Vjw+p4R2zcw4fwTcUyG6OF75K3oQI5WrMEZryirKKW3TwdH7cvz4P7wjZu4177qQclSy
         TxnYi3QLDJIWZN21ty+2jmJJ3ERYYEx6UmMU1TJYhbnblrKnPRsMoRpDLGJq1cysZ0Ng
         rWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716418899; x=1717023699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2qTU9Hshqz6t1vKHlNCBK7tNf2KsTEuBaP1htzZOzY=;
        b=eCYhsIYLzGzTzAU1BqJSqRzxGXFUKhtbNv+58VHZy9f5yPJCNm7Rv3Dqohb/w619R9
         epqreF8Al+kHu/9t+udlFO9a1mlBYmip1StLi/J87lboKLHpmD4aRryakcktKa757mmg
         Bdf9OMaIKSzho9mgsT0SqcmNZHv9iTWe5QOCvXVyhEVoInOkdLwORt4HauCwk9/JNG4C
         8W3nu/P/pXrHiSur/Wt8oIXlKgtB/sD4OXaWWL5TnpbNR5kPUmVKwt7o60TDV5DYqUpD
         3MP+27vmAtGmPVs7Rzz1TlQmknj3tzsAHlvf9j0fp34ROIvyjGO92dNFFcosb38BUd3W
         hCYg==
X-Forwarded-Encrypted: i=1; AJvYcCUfXVgwWe4L/k2PLShn/JauaX0T6kaiCBshUwprgG8806EwEscAbU91gZYu6etTIVEcbbGkMItN/l3KyZs85GjK5WtbpM6z7AQ=
X-Gm-Message-State: AOJu0YwnZ0nq0PpQxvkloCpXEf9K9o8Ad5TX6ANM756bsSFNQblt7SPc
	7bHEZDB6ygdY9OT+e1zJcAHzchITWODhSpNnjc+MdgQ8tqYQY3gp
X-Google-Smtp-Source: AGHT+IF9XqDhOY3NBWbwuIvbwXqM3lJZa+22zq8hRhbKDUtdlxNWoBwWN/yX6ZfmEb9tQKYSYIuYpw==
X-Received: by 2002:a05:6830:22d0:b0:6f0:e79e:f1a9 with SMTP id 46e09a7af769-6f66518f653mr3454623a34.4.1716418899303;
        Wed, 22 May 2024 16:01:39 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0ff995ccdsm4155936a34.34.2024.05.22.16.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 16:01:38 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/4] dt-bindings: mfd: x-powers,axp20x-usb-power-supply: add AXP717
Date: Wed, 22 May 2024 18:01:30 -0500
Message-Id: <20240522230132.364915-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522230132.364915-1-macroalpha82@gmail.com>
References: <20240522230132.364915-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add binding for the AXP717 USB power supply.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index 34b7959d6772..a50c3bafa707 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
@@ -26,6 +26,7 @@ properties:
           - x-powers,axp202-usb-power-supply
           - x-powers,axp221-usb-power-supply
           - x-powers,axp223-usb-power-supply
+          - x-powers,axp717-usb-power-supply
           - x-powers,axp813-usb-power-supply
       - items:
           - const: x-powers,axp803-usb-power-supply
-- 
2.34.1


