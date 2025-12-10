Return-Path: <linux-pm+bounces-39375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99192CB19E9
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 02:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E79D430DD389
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 01:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776FD2356BA;
	Wed, 10 Dec 2025 01:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="pcvSqt2n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47823313E
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765331025; cv=none; b=HOywEdlXmXT09Ba+OuoSMjOnfAcEModI7YUwqeuIazMHZMj5jB2Rlfk1MH20d6mtpgy/WlCnlQ26Y/zpjf/NQ0JFWX1YR6yBIcFKJs42mj4yfyfxG+GcFHHQbbaDpzSUtgDgzUOGUbyG/nA1Zu4w2uQORNAcYdfESFimgvj9mZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765331025; c=relaxed/simple;
	bh=i2fJ3oSJhw/ySwSUDxCvlBN2veS0HqsGf63LfSGR3lY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PVrIALLYdnatj7s4OZguTpZe51LYxANTThsn+oZFlXipeW5vAwxs15qLRlKtFBeo8NcrzhA9TnUINzNXwnejMFyQrnKKigxmou4SPZLSse9R0hYakaugpK7y9Jfr1pRsIBS3iKIpo/AE8ViExHe12RUw6qrawmpbaswASVRr8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=pcvSqt2n; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477563e28a3so3078315e9.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2025 17:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1765331022; x=1765935822; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FT1PuSSF/qNGP2vBlW8tIhEETokKmkXeWI2rZb/bUJo=;
        b=pcvSqt2nEgmPDOuZArN5hwfZIGgp4izgc2qvQU+/d5PaiW6z3sfTVwuB0OWNp74IQP
         pmVlM+tk+YaatGMoQrdhjiEyeba2Ha8rLSKP84qxQtfzWcWamN7umC8kbz0t+G1R/zQO
         roalzjG8LEe0kOAKpCQO+YAWMUp4+n87WNXQ25a2ncPyhEArTjO9Ok7m46o5skACnl8T
         5kDBhH6jqt2QisPyn0nuzYq5yFFVvcHa6Keo/Gl8ABVJk0MKotH0S9ZN4TDoRG9EkMAB
         fXveOV7dERT/0eL6WRgVQFQ3FItMm6uBZLOmEspHiVFQZi3XqgafGYs9eD1EHsi0UtN+
         j40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765331022; x=1765935822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FT1PuSSF/qNGP2vBlW8tIhEETokKmkXeWI2rZb/bUJo=;
        b=ImwnR0R9M1PlJe2kyxc6R2iQDZO5HzGYiQcjHk9TfrVDwqSL35jHR22zF8KDdVjDX3
         6/pOBuG8JB+OtaNrUsyfn+/6/6HOiQjwR0S2CThSaxjBVILNFQufDT8a4RIz783Jmbpb
         zeNn66mTfnRWY6VexiMX0FA8K+WoFkDSADXpJy/jB3Iyi3QiZjYdq42uTCu0fLX8oVmW
         2ci049oYn4MlsOaHVnN9BDtvslZkX/qtmRe1F/STETXSgAbTi7zoW8HwSi5CEZLvyDRD
         x/lc2WNCu4JzhoKKTcIhKXsE30QF1P9XP2LuAB9sxzVzAkwhjVtEtZLM97Jm3wpmuQvu
         byew==
X-Forwarded-Encrypted: i=1; AJvYcCX5LF0j1OoMeYE+W6+YGjnoKXBccjC9UadxLdOcFprZZGjSgGZE83EKUniGB6oA8v1iyQo3fp71CA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNpIE7EknqQeZChCqRX2iI6U4Hjn2V2jcBtLAivv74tocTQJRJ
	XsotToB4ajZPgtRFAj2gHRCbW8iHbdMkpo84zOmyav6pAr+98WiGX0osXWBcshljTLA=
X-Gm-Gg: ASbGnctd1vtx62LayymoCYb9GzoTh/6Wm9kTEXGhYYsx8Ji5+ancGp7U7mA99GEd0fE
	MLC4Z1FIJtbq/+rTBjWDwiULt6SGn3JM1Ww1P+7okEp9cYCH3Qnt8EMIwuhyG/fdKpj4eFnHZCv
	Erq3XV+zvbuAKGftILQZIEoYaDgeDZaD6+9AOtEcNE4rryM0Nxb6HG7KlTRpW9ArnCVNCaZxLgF
	4IuVDbBzkQ1Qe76Wi8wikw9ClYur0VGwJIIOpSDXEDEBywltAMqVZGqSQtcc2+zft67oE7vNYm5
	AmLzQNAJfWJsmD7SQC2goEX6M5Vz3iFO1C/6JnPRniBJBk8PE0HNnw6uJZYP7xMpBrvncmqpGKv
	jWJQv7yhXAeMpBbDAAN971rGN/wp/2OVq8U6aAz7O8rNdqr2+OoIk8dwwRd3+7tSH7LyHhDdhOK
	YnlA/esdHcSUSwA/ngCGN5F6nh7rHYc4sw3w5aSCGR4PaaC659zg==
X-Google-Smtp-Source: AGHT+IEBw/92gO6sgjRnYsvO6wdv2q1g/TUhOcjenuTs2Zh7ccxVbKZSVrtyYytk2eSeTYPplHLThA==
X-Received: by 2002:a05:600c:8596:b0:477:7588:c8cc with SMTP id 5b1f17b1804b1-47a7f91933fmr31692325e9.7.1765331021761;
        Tue, 09 Dec 2025 17:43:41 -0800 (PST)
Received: from [10.200.8.8] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a7000c984sm705234a91.6.2025.12.09.17.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 17:43:41 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 10 Dec 2025 10:43:25 +0900
Subject: [PATCH v4 1/9] dt-bindings: cpufreq: qcom-hw: document Milos
 CPUFREQ Hardware
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-sm7635-fp6-initial-v4-1-b05fddd8b45c@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765331010; l=1206;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=i2fJ3oSJhw/ySwSUDxCvlBN2veS0HqsGf63LfSGR3lY=;
 b=B6fM0qV+kskrVmWrQrdWrdJegC4lscc5t5rGLEmjxKdgwtQcYnqbU6yJ2+Vpsji8OYmgZzx3Q
 zOxdKXnTJnFALGIximQ+/5iJfIDmy7CiRbk3LF8mMSrBGYwC2Pw+dYY
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the CPUFREQ Hardware on the Milos SoC.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 2d42fc3d8ef8..22eeaef14f55 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -35,6 +35,7 @@ properties:
       - description: v2 of CPUFREQ HW (EPSS)
         items:
           - enum:
+              - qcom,milos-cpufreq-epss
               - qcom,qcs8300-cpufreq-epss
               - qcom,qdu1000-cpufreq-epss
               - qcom,sa8255p-cpufreq-epss
@@ -169,6 +170,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,milos-cpufreq-epss
               - qcom,qcs8300-cpufreq-epss
               - qcom,sc7280-cpufreq-epss
               - qcom,sm8250-cpufreq-epss

-- 
2.52.0


