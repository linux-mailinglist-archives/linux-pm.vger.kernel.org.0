Return-Path: <linux-pm+bounces-13833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8DB9701CC
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 13:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B095B28453A
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 11:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0167F158DC4;
	Sat,  7 Sep 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5IOV2FB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B41494A5;
	Sat,  7 Sep 2024 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725707270; cv=none; b=c+VgL92jqNoMt1RrnXDStXArsz4l5JZcfTqGwmLByxnRcflRwEdUUFcWRuLQAC7x5ZFZ9wxMEbm2EL+RjgGeT8CRMc8Zp/2EQ+iskcZCM59RIUI0oR6Kr6Qe+H7QkdPWVsVqIUfcpfomfXcEy6v7RGeFBbbNl68o2FTJmjjHXUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725707270; c=relaxed/simple;
	bh=R6qJtdYpTEwJLIYy53ByPsU+RFK5XSWQ0eOuYm1IJlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8dsf/oKUuVBkGaQz+kF0bOqrEJVAIw8VxFtsArJsde6qrze/8fdnLLWTK7f2/SrPy0pM3cJR8E+sDHENyk3g8ObZYuTmJOrLMI2IwUCH0/7XjrEarTk4M4FL9L/CUK9syE9bzYMuf2FG+7ximsQVS3bBnwj1vTP8JmettgctTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5IOV2FB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42ba9b47f4eso15781595e9.1;
        Sat, 07 Sep 2024 04:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725707268; x=1726312068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZqH8/VSdIZjoarJlumv8oYCXdCtI6nJjgyT6bq+i0k=;
        b=Q5IOV2FBsxt2kZkuoQaNtsDnfGB69FEIevysSXCiBaN5ygNrBifDRVZv/+EmJr33U8
         eZKrIdUMlAefKIUzOmsPwcV00657m0o05OZrXV70n80yyf6s1cg4kt1ou1kc1YSxZZI/
         DHt4i6Mjhvvcr7Ecz/Ea3nozQp/M0eFpAQ1zIX/Y9uw7Ly8KI9fWWRVf5h6lvVoAGy/H
         wdKlokDDxtxk3uB5cRWQT8TPBW41rRDcU0SQd3c8K39VTXgAgcN8VUjqO9e10HI2k33p
         ZBucjO1VqRdjdWJCXo7NyLrKMTzjyxORpjo+OIRzgEJo9gguVG748Cs1IIGP3R8JTLNi
         O0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725707268; x=1726312068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZqH8/VSdIZjoarJlumv8oYCXdCtI6nJjgyT6bq+i0k=;
        b=ZYq2OCYuiMXjvNoZE8XcRPHFz2hhhwvv+cqo5FOzUZh11A61aQ1d1JLB6X584pDI/d
         /TzMuqmFx04lRpjTTIpfNizoDQwvgzDCY+ufvJhvpDMktBvH4l4s8M8+joqR7ry9W022
         4ugkvSX49qMvs0TnS70go5O410ov6wM53nrvtQHu19hPNSpjRMqhNce2YxjrdA2YU+rh
         5G/KdXAwre75Va66/CKE60+4ewyBl719cOORu01B6HKJgKGASdVOkLbYc28XGiqsi7jZ
         YN2wyc76gwoea+D18JV2CgNdFsm90fxIM8dSI23wq9u/aALGhMTkStqp1w/2vU6pFxv6
         mQiw==
X-Forwarded-Encrypted: i=1; AJvYcCVzEdkc8eMwtnnNFMnVnZIwYTr4nSHQ0ve46hhH36L8AJVDx8XSuFQgk8TtcWNSih3indTqUYEwZrFk@vger.kernel.org, AJvYcCWKkiAON6LHXec8Tp30DD01QFeJ3zU/Yc/6sWSBahgj2Oj69IjWka7RBuhOo2PtK21BLQxcv49x/Y1JzvyP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8+cJHYVYbXzFxTOIGwDAq/f74+e9s635e1IyuTfLwrjo1QvKL
	7y0khS4h/glF8tMO28e8dbhrTIU7R8KcfDPJeYwxNY7PSLuMpof+Mv7NCxa5
X-Google-Smtp-Source: AGHT+IHuXcy2qenL5ZGasWsC/+uDIaV/+cayUg7F6FLgmV9JQIWh9OQtQc1T+VKLS6mAdKi9YtOIlg==
X-Received: by 2002:a05:600c:444f:b0:424:8dbe:817d with SMTP id 5b1f17b1804b1-42c95b39e54mr75203285e9.10.1725707267652;
        Sat, 07 Sep 2024 04:07:47 -0700 (PDT)
Received: from [192.168.1.130] (51B6DC2A.dsl.pool.telekom.hu. [81.182.220.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb444b0sm13719415e9.21.2024.09.07.04.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 04:07:47 -0700 (PDT)
From: "=?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=" <trabarni@gmail.com>
X-Google-Original-From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 07 Sep 2024 13:07:45 +0200
Subject: [PATCH 1/2] dt-bindings: power: supply: bq256xx: Add
 omit-battery-class property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240907-bq256xx-omit-battery-class-v1-1-45f6d8dbd1e5@mainlining.org>
References: <20240907-bq256xx-omit-battery-class-v1-0-45f6d8dbd1e5@mainlining.org>
In-Reply-To: <20240907-bq256xx-omit-battery-class-v1-0-45f6d8dbd1e5@mainlining.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725707265; l=962;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=R6qJtdYpTEwJLIYy53ByPsU+RFK5XSWQ0eOuYm1IJlo=;
 b=h8L5jgwZf+2kJRUPrq6ZE8XiRCmXquDCr2MBTQqrfJvK3qjJ35eDpWj/jX3Op3tYUwlbliq/r
 mAUnKo+FwvpD/2+K9JdRTvlEqeUscQN5oT29UPce7jZtzCZ2wvOYfva
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add omit-battery-class property for avoid system create a battery device.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/power/supply/bq256xx.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
index a76afe3ca299..744f5782e8e7 100644
--- a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
@@ -62,6 +62,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: phandle to the battery node being monitored
 
+  omit-battery-class:
+    type: boolean
+    description: |
+      If this property is set, the operating system does not try to create a
+      battery device.
+
   interrupts:
     maxItems: 1
     description: |

-- 
2.46.0


