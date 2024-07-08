Return-Path: <linux-pm+bounces-10762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A4792A28E
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 14:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CA71F22094
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 12:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3356682869;
	Mon,  8 Jul 2024 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/gIXr8W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D6681219
	for <linux-pm@vger.kernel.org>; Mon,  8 Jul 2024 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441384; cv=none; b=NS9Y/X+8vdyc9JTbzZB17UYEi6FD4rc/ULq78cahirkTDvjLMnWJsLE6fxsWkldMSz0cTc194OoqVRq6FGv0Spn6Oifj3T0yo7sUpe6yoQD/+KaIelHyDRV9hYywaZFCIh6t1Y9+GJAm6ItnHSX0t2I8tES/L9eX9KWeGPCSBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441384; c=relaxed/simple;
	bh=YS331u/IScHChATk8p7aL3JRzn+3f0/zhE16HH8SRSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HdjdwP6u3D0o691hBtJ/01tCm+cAdRJubZWP+s/hsTwXzAZmGn26EDvQVAU5RHetDuusPJRQ/3b1qsCzajfw6E4tMnQZmJo0RapNJiTQ+mn/4m6BCSJ+wb7Lir2hq632OlwQXwZ5gmD+RznSdwzH6Fl/5+k7QDC/bPu6QQqPd9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M/gIXr8W; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a75131ce948so465355766b.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2024 05:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720441380; x=1721046180; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuoGIEtLY+sG9K81klkUtIfsNH9bTZF+T0WBDkLiP+Y=;
        b=M/gIXr8WAFooNn7+uWmO8b2rRBTL4a7nYJmhoZUGMukLF9UfZ+sHiATOGF3z8Ykooq
         hCOs+FQyicG4eQIjFKd1JmB3WQUKwTN2DX4ySFgqEoELa4iKtWC4RPU6UKjO3eR2rfaO
         pI9m/qS9sK/GJ5KnT9rSckYd/2ffBTc5v5QN6UwHMhMdhmA2jt9TGonDAgQKUXWKzENv
         FGEvdLfdqETkgOzpEw9H1ilGJo6eYGUmdQoZ7ul0Yym3sQp2lWmvIPc1gKSeKxLyhiUD
         bXgfkIQX5nOqcRMPdkoDK8HN96X8IcH4kIKfx2RWF2Mp0wo51dGCam8ed+ImqPFsLwFF
         DNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441380; x=1721046180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuoGIEtLY+sG9K81klkUtIfsNH9bTZF+T0WBDkLiP+Y=;
        b=RgoqSMDy8Yb75kNZfrf+49RqYWd/eMv5CbfEEXYuwOjzR9ihLy8NU8YMgU935fEoq4
         yIP3H5NEpK0tPysWSBBwm+nXqn7Xj692zcdxDl5A879eJoKGG9lekjO7nt56qucchp08
         wRwjiHUf3UMONNLX/UnfT6aO9nV8zIzHY2hF9N7SenxLITZ4mLUhJIb08eWhfftvaFsy
         4bNYsjTgTs5h4H/1sC0p4FX4GTAPDOsA6w30Mie1k4y7dTwXuLPfpGZmVfpOZqoILfbo
         gfsQmfnAwBV5/qa5n5EavTdwKJrbsSSNt84E0soQDH6mVtEi/zdJ0GL1Lfejz0YXKmXD
         8wVg==
X-Forwarded-Encrypted: i=1; AJvYcCX8gDLymmtU1dinJvyQgPGkwi+GUfm/RFWbRGxnZccQS+h27kFvhUU8fWF2qWC+hFTIvXMZIfx1e+g7KIU689PLK7JkZxGP7/A=
X-Gm-Message-State: AOJu0Yx8KznJYdODizpY7mBRB2k462i1gVfs2A22KTnDiKTcs/oikm5b
	Uc9jsm7rbjnePFmZsQNzO6nBbcYOPH/ueFk+IqUcOwXPDQel0KXPOsi+RweiSow=
X-Google-Smtp-Source: AGHT+IFsv0xnzPRSLt3WVV1W7Q5iYcFTyqb19d+OrVEXe8LFZ/SMKdneIgEa59nbjfQgeGZ1WzSZDQ==
X-Received: by 2002:a17:906:b11:b0:a77:db36:1ccc with SMTP id a640c23a62f3a-a77db361dbcmr561338666b.24.1720441380037;
        Mon, 08 Jul 2024 05:23:00 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77e52ccf19sm208983666b.147.2024.07.08.05.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 05:22:59 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 08 Jul 2024 14:22:33 +0200
Subject: [PATCH v15 02/10] dt-bindings: opp: v2-qcom-level: Document CPR3
 open/closed loop volt adjustment
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-topic-cpr3h-v15-2-5bc8b8936489@linaro.org>
References: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
In-Reply-To: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Niklas Cassel <nks@flawful.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720441372; l=1573;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=YS331u/IScHChATk8p7aL3JRzn+3f0/zhE16HH8SRSg=;
 b=uNRqYMh/GkR9tuyunemDFYhU/xn9vIoAkwNKZTtZ5batuz+sXQqmlvlrnW0DwTRPo0MvR9slD
 8EjaugTz36YDu9o6x6nZj536R7z0ZkcUzz5gAvMEgu6ZL9IiR5sv1Kk
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

CPR3 and newer can be fed per-OPP voltage adjustment values for both
open- and closed-loop paths to make better decisions about settling
on the final voltage offset target. Document these properties.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/opp/opp-v2-qcom-level.yaml         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
index a30ef93213c0..b203ea01b17a 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
@@ -34,6 +34,20 @@ patternProperties:
         minItems: 1
         maxItems: 2
 
+      qcom,opp-cloop-vadj:
+        description: |
+          An array of per-thread values representing the closed-loop
+          voltage adjustment value associated with this OPP node.
+        $ref: /schemas/types.yaml#/definitions/int32-array
+        maxItems: 2
+
+      qcom,opp-oloop-vadj:
+        description: |
+          An array of per-thread values representing the open-loop
+          voltage adjustment value associated with this OPP node.
+        $ref: /schemas/types.yaml#/definitions/int32-array
+        maxItems: 2
+
     required:
       - opp-level
       - qcom,opp-fuse-level

-- 
2.45.2


