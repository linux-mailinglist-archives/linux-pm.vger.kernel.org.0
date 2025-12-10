Return-Path: <linux-pm+bounces-39378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B05CB1A11
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 02:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68FA33021F51
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 01:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF60F2264C9;
	Wed, 10 Dec 2025 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="hKS6oCp8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1292264D5
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 01:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765331041; cv=none; b=jHd+DGSeqXV2ULnFeLswUSzHorr958sd4lodjEoP9mqdW0v3LrlY3kXE3J+pm9ANiTR5iNc3vYJYs7iWCxM5IWSrGRALIeUpvyN5GhMQ2RC9P+fDJ6C99jx4+mcE04H8Lb+uzGanrm+/JppmdQxgu13i/7jPCdbf6kvqbAetI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765331041; c=relaxed/simple;
	bh=Oj83634LuR0Sk6h6LV1CwwmH8/xA1oyqe0fNzBAzWv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nS9M/tReyGfE3O7T6FLcW21Ncbo/ZOSTyl4yYufpBkXCmZlrPa71mALaOIGSYvdfARrS7Eu+G6sYDut+ClLgo2JAA+ngvdPy2p9YlKvmj47S9Z+pZlwu7a51AEMTnxIJoM5UHzRxtf/4SR5DwV+fTtwHyT7zGQOGc//6Q3Ej9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=hKS6oCp8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47774d3536dso3717545e9.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2025 17:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1765331038; x=1765935838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umLdQ4Z0Oa1qrbBohYzZ1X9EBV4iKWUTwztaRyY6xyM=;
        b=hKS6oCp8m1f9thEctqo4PCFwr4b3BrEWMEXs0p/fhB4bGOQDmlNs9sTlQ1kx5zz9Bn
         VJV/1/UTftbaziYT/CEAJQcAnWPffAHfeFgomvOYOVrmf/G+uAbRmhbJRl6Pg2A4wR1/
         tGltNQtpBosKvd0TaRvGDp8lkrSMSj9W1lk/AprGgG3OL22EAj7SS8OVPPWX1i6AaI2B
         N5yZtKUMq9bcFmP1vJ43yQLAFXnZg6ZeAXc2OSanNQ01Ub2FK5a1yuhBliwPuJ7A7nTQ
         p6LritUo0UCZhkD17DCubEnPST4Em1834/cAKpvQFqYrcptuCPAAph476NjNLN8jR/8t
         ZJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765331038; x=1765935838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=umLdQ4Z0Oa1qrbBohYzZ1X9EBV4iKWUTwztaRyY6xyM=;
        b=fpFUgMvtQ0roOhL+TfBgrjQ4UduPyXF5gzv0RURs88pGIx7UKvUFlLt+v8oDAvSON6
         3zDES8ntfyzFRSCm6OyntCvkdgngFm0n4oxM5zhIQ2qFHOFVXLKpAbQl+WJF9fP4rvlA
         24jlRL62Hq+mYoIrL/SJlz1L/VfnFCFM9M0TZXKcxq1w/AJlLa07zftn6VaAaPZP9lcX
         2xFfeQAcxtXEAl3dgmH42SfMjxr+chvsdnQ6HHkPEIaSUGi+uyFtwPFRqy0aEg2a9kUc
         hyMNaMBR6WwsDEKUXCp8PmRsOUr1JjSSWbruYaTepsN79kLAMgMwiOm7CgZLxnS/nElA
         a8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJPI9zI5yPycmRqgETgsjx85+4hh9p8v3Enuusqr7+agpq1IQdAS8f+VvdfDchH2IhuyxnApRbQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQOFr3cBjHAdQ43n3t1BvnTQIjtQXoBBbjj4LskWHU5WMEiPlA
	IFU9BGpukbcY0QyhwV1qFPC5RN7Vw4thJp8TfvDEMFAt0Alf5mDwQjldMk5dMLnugsU=
X-Gm-Gg: ASbGncslKGTzz09r6cgkmV1noI9oMm1dOHxa8saRaJ3S9UvQSqvNhEzVOd/QfOGtnI5
	tcTnYdo4r8uX7SoSPJPSShbJkKTkxbbmD17SuZQGL38QLNiIoz+mvdzENuefgGO0vm5zyf3c5Oz
	bI7rL7Tr8tUnTo/do6M/t0RiP5Q73YaEoglwsAuikoZu0Fr5zaZ59ypF2dt5kbLr6t+goi328Aj
	iEv6qSBLggOM5EofAPf3nkVNNEdtL87IXYNAhE/QJImdntyZNXqMB5pNxf3T77jSKJghe9wdWa/
	dNR6klLyj9ZKhmQG5yMXAjBHJirbObJ+PcbRhY7O0sBirxxeV508bGiOVMiGw83toIfXZwzBJEb
	W955m4cDkNPKkgWRwFyNwTnUe8q2y6lqkpVXjtkIrFrBM1aUl7kmUCfNX7PZL0PugCVyft8zg8g
	fkJSLN4TE06wPN65xGnBtlyfhWZ+VxQk32Kx/H0tQZl0zYCgiZ+jsfRYb/bBya
X-Google-Smtp-Source: AGHT+IFxIH9jfV/RWAbce1/H/pLcaMN1DtMzvU66F5/t/lzbYkrchMrfDWq7ziyApOqmo0GYQ7+Rqg==
X-Received: by 2002:a7b:c4c1:0:b0:477:9890:4528 with SMTP id 5b1f17b1804b1-47a7f90f296mr22741845e9.2.1765331038494;
        Tue, 09 Dec 2025 17:43:58 -0800 (PST)
Received: from [10.200.8.8] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a7000c984sm705234a91.6.2025.12.09.17.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 17:43:57 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 10 Dec 2025 10:43:28 +0900
Subject: [PATCH v4 4/9] dt-bindings: arm: qcom: Add Milos and The Fairphone
 (Gen. 6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-sm7635-fp6-initial-v4-4-b05fddd8b45c@fairphone.com>
References: <20251210-sm7635-fp6-initial-v4-0-b05fddd8b45c@fairphone.com>
In-Reply-To: <20251210-sm7635-fp6-initial-v4-0-b05fddd8b45c@fairphone.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765331010; l=824;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Oj83634LuR0Sk6h6LV1CwwmH8/xA1oyqe0fNzBAzWv0=;
 b=EOx8pyQClbvxV0JmxPZtxhQaHpK3rsiOVVqGjOi/NNcSkhi4NB2293BkQWHtDObYSmVC6Frya
 Yl7gJHRuUU6DjCXJCKCgPEBBMffksNyiPLo6G0Z5+OwcMXj2haqKv0Y
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Milos-based The Fairphone (Gen. 6) smartphone.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d84bd3bca201..43d45fe95ed3 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -61,6 +61,11 @@ properties:
               - qcom,apq8084-sbc
           - const: qcom,apq8084
 
+      - items:
+          - enum:
+              - fairphone,fp6
+          - const: qcom,milos
+
       - items:
           - enum:
               - microsoft,dempsey

-- 
2.52.0


