Return-Path: <linux-pm+bounces-30266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB03AFB0FC
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 12:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A831892B06
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DEE29615D;
	Mon,  7 Jul 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="AIXjJ/YY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E472918D5
	for <linux-pm@vger.kernel.org>; Mon,  7 Jul 2025 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751883505; cv=none; b=hK0KMO+cTT7RsYCFgIWjCfMVLK44fc3UTST1dk2yo5dxoAtz0bEqjkp2Iy50FDHsGMg6zZOfARqcr4OKo37zuvQQNLCXAVMi3CaRhXsQLewu1Xlp1zXAStu1em2ZW20cDkanr7/h5IST2HZ+qG9r7yOtdjW+tYW33EI2SbujXpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751883505; c=relaxed/simple;
	bh=USNSTCPLUh43NQYfIkxLRz7CFdTqWhFh5EABG/L6WQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qsT746T+oR8tpbCHcQ5Y1YL6EgO+B0Ae54t8FSrRanMoyfsQWJOoBdnqpxaJ/5na2Lor3ftig8SG6tCvVH7oFYGJD9v8n0wD3d1wfpsTGf8oIlzSNUJsyu6bODuggxLuhAk5QopS8qvvwWJ1YPwgrYS3eXdnae+zYlQnhW8fDLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=AIXjJ/YY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0df6f5758so464406866b.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Jul 2025 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1751883502; x=1752488302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwDPYiBu47NkXEsxkYg8SaVSkTFBC8WInMrYQOtCz9o=;
        b=AIXjJ/YYkNf0vqpc+DODRUCm52MFybIEXskug5RR0d0Y1jj9JTc2TRqNiiDpRvmmV+
         oQPR/NU2SGkA319LpB94kDqHA49oRXgiq3kPU06qdUgLarSk2XXUgGNdW6w3rzXqbHbP
         hwu2Utl9181OMLIY8krLNpl8ys62/D2H/a848fbwzSAuFJZghG5Hav/eank7EooNWEQk
         Q2K2AhkTudPUg7xpsqe4MYe6fPCIb8fiFhvPb4rCiZi3YH8hkS7pgXUxZD6Od5JlNpNY
         mQez2q+jtif00Vpjr7TNA8Nwmy4ybn/DdBH4lQ2T3EeXKMxjEyfLDSR9N+W753z8dXxh
         QgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751883502; x=1752488302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwDPYiBu47NkXEsxkYg8SaVSkTFBC8WInMrYQOtCz9o=;
        b=eT7XGWOvF30m15J9r9NMKydamhV4e34I0yr7OiwM3ArCE0CAsgF3TuzAhC3tpt5Ix6
         g6yY2AvRnN1ArFVX1LQv4D9/mGQV0TbOIZz6t/nFVHkpku7K0aMGpqINlMXTnGTe1y+U
         eUy+MKxrwURxyLPPvrfhXJhpFva+swbjO2Z8MHOe2moIbOMp1MypzkPeF6lCYH3ZQzDp
         YSnh/X+szRtirOabJPHWrGt2RkSzZZYjyA/PYwY6O0fkswGyowo6CcXksytFRqahjwot
         o05Eh/Ujmg48SO1jbduH3KJl+A3P8En9wIgLTXroUPtG1znmYDHhIGJuREI2IBS74ANA
         Qlkg==
X-Forwarded-Encrypted: i=1; AJvYcCUzmqDREaCUaOx63E61rBFCZQdjl6R6SYbhtjYTDt9jglzDAYoExOl78vyOYtgCYqh5Ljbs8NG1Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyscuwPDoB4F9H9sxVVxdIRuF0zWo6O9mCQR4rVEA+2LSKHS6oQ
	fzVMAT3KKY0TEmUwIvqtzvYu0+yHkVNYT5meH/PA4zBXq6oesO/U4mDJPGqE9de2pHU=
X-Gm-Gg: ASbGncvbWDF/ZuhVYgPTOUDWitFIIM8HWXk0dqaKlFxehNMl1wN8LzyvF3KSogtGDNH
	Md2E3A8IQR4A3kR+Ark4sBrqO0K6Fe0rtVRtYKi6sAVeC0KxvjUEqsTPx9QCsQEKpWOmre3fzEp
	Zzo39ojYZTUVuxoO8s+tqNTQVuvNnbOA4jxsMAXrXyn3+yxAYFhobDjqzUv+wr3qmAn8U4pgvge
	vcKpsDZGJpTXJouA1KcmMbei+WfquftR2+OyHBcT9aEEQ9OWbnNX0cmn9UTBX9Wj8X6biOayAur
	RMSCSx6XMU2uOHQD/PehWJBQYwFDWeCiCEMg8UPKqCJCGD4DlA4FebDcu5bMYM8t6oJ7mIJShTq
	3s5v6ab1/gmn3yp1ACmohPn4VPZmxYTy6
X-Google-Smtp-Source: AGHT+IECdSkbHIUqu1f22D6ia6KrC1dwzv8RgmgMKoqy6VDd5PnWxJxxIPxs600Xqmqg+R6EgQGyTQ==
X-Received: by 2002:a17:907:3faa:b0:add:f0a2:d5d8 with SMTP id a640c23a62f3a-ae3fe457c81mr1062729066b.11.1751883501706;
        Mon, 07 Jul 2025 03:18:21 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6bb1edfsm671711766b.180.2025.07.07.03.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 03:18:21 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 07 Jul 2025 12:18:10 +0200
Subject: [PATCH v2 1/2] dt-bindings: power: qcom,rpmpd: document the Milos
 RPMh Power Domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-sm7635-rpmhpd-v2-1-b4aa37acb065@fairphone.com>
References: <20250707-sm7635-rpmhpd-v2-0-b4aa37acb065@fairphone.com>
In-Reply-To: <20250707-sm7635-rpmhpd-v2-0-b4aa37acb065@fairphone.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751883500; l=820;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=USNSTCPLUh43NQYfIkxLRz7CFdTqWhFh5EABG/L6WQo=;
 b=vsTJjejP4J+3gjvbXlOXjY+EF6KQyuFHQhJ9Z0xOXy8+okpV+61RofXRDOqVEv/zX1t8RShst
 lsrQjJdAzSyCdgo5/TU31uLIKDCgMJk5hdW0VUkHaBcQzuz0EmaoABc
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the RPMh Power Domains on the Milos (e.g. SM7635) Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 1bf65f2a583ab70ac313309f917aaabb75dc3f85..7d4394a3ccbc79b1ee998a29187f30d2d3c4da51 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -18,6 +18,7 @@ properties:
     oneOf:
       - enum:
           - qcom,mdm9607-rpmpd
+          - qcom,milos-rpmhpd
           - qcom,msm8226-rpmpd
           - qcom,msm8909-rpmpd
           - qcom,msm8916-rpmpd

-- 
2.50.0


