Return-Path: <linux-pm+bounces-29480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0005AE7D02
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 11:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0C216D815
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 09:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB802EFD88;
	Wed, 25 Jun 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="o61iw4TZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C22E11AF
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843402; cv=none; b=Qk/Lvc3K/7zWY9B6uUov54SSA0Nh3iLigB6D3lJMSk5B5fdMfYjMZUXOlIPzAqDkO+jVBkUrv5m9PtBGPgBv9m7fiVOKMMJdWskhqVVkxGsWJSwOpZqurUx5e0HM21dBZY9ubcweJ+fDEBwfZaWAT31U31UIJhTqoaryDXRr2Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843402; c=relaxed/simple;
	bh=a9FLQid58ZrqwhwDBssnIOsYiwypbHIyY+vO7BVtkJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLF2bo4IVQK5X9nGo3uEvKLDRR5VZcj9Ho1kVpYQ/p39gIEHMYsaARHnG6IFypKmeRH1ItofI+L90BVvcC1FrlnFpck+g2qSVgeSSnAGd6uAIWGl1WaGx3wF1aTuyaWT0kX85d9f9Y9bFtCuDg67zZznPagcKEwJbMXSpp9/UzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=o61iw4TZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-addda47ebeaso282522166b.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 02:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843394; x=1751448194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFd2WA4jaSsi6eBpJft54R30VZiUHUNL0WjIOmacH+w=;
        b=o61iw4TZFyTkUIj7PoZHMG4mEEXTObVv8UmhymegOnr0oJbZOhDbz/N3MhtbVS+84z
         xBeAFOQadwVcJSYBQsAi0wnvAnopcfdR5Z5USYokbRvfT2Dz2Z/jq8VGofmftPZLZ1n7
         UiCGfLxSUFis697RiT/wcY2Q+rtRPdNzxoulxY2wZHZ0SUhXkrcOzrlWFdgUflna7wu1
         GIQjqluIjgCYO/UU2o8YBNx+LoFKZAru6S/w87lsmzFEoog144obDT0KNuvpjTp5G1A9
         n6jbMtQQb1NjDQk+8YREn09s/qo8G1KOIBdGQlQM9CFsubr97cc0zVjUJqXHp1g56Him
         VwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843394; x=1751448194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFd2WA4jaSsi6eBpJft54R30VZiUHUNL0WjIOmacH+w=;
        b=TfazbpYk87NgvERSwrL5dIJ8wCfFmOtP9aetx1fvQgJtCXPfI0j4GczZ7gtpo6Et2x
         4lbUXCWwEdyBxs/sAV3CwH6Y1Lv5bM7hcn7cIp8reVC1V6upj1xqUsTek1MgWQ7uXkbv
         R67ru2PP+oaXZaE+aT5tIr9EAyY/LCQIntKkDTqTmBFPcWIyvmmeLARjSLBZH2RnYsmr
         LwtbKV8mE6oaUBWprOn/85UskABk9OFKbpulHzQodfTTCRcX8wWPOJ/+3rPqKJwvO2Nl
         YQ8VOz5lsN4bfatWdRpB7dQ89aZOsBiSJXgobBcDv5AWUYXYC2CC7HvDqRsJCFRcHTbw
         1wHA==
X-Forwarded-Encrypted: i=1; AJvYcCUziAdZI9iXxAVBJCbRIYa6aiyTdBeggE3XdkNP5hb0I6Kc32hn1yz5dlobV0N3BhyBXjMgvjBPQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0saJTpYb5w/f4lfgjajrDZnR5YFsOfcEku0NWxq6H3W0QEZ5i
	XpNEs+ullNXnqo1gQgriCgcXIC6wuR0+lkBwjdEW+QY90XvfToedl+bfM4cefyAh9jg=
X-Gm-Gg: ASbGncvqXFqjg5JjQxBNBlaWnUelGNMLOFaJfHcxGeri0lNXnQmoMCUrwnuLnBgSXuQ
	V1+22k3LsbtGnv2UL8iXA7NTdhejkxFMDdHEkAZWDt7dWshRY5Cs09vK6fpSimIA0AAVBqup/nZ
	ec3T7DRpWc6H1F7rBdbqMisbUqYC5K7X8d65hc1gQhFa42mq83yjSZVtloovQCgX5InJYLGylUr
	rlA/6e9Dvh2PnmbOZ0Zp5utg5EcJV05mV3pRpcVItp1wMvAztMPAeFhcuDgbQaJzUapYWnFpH3t
	OQOVj5hbTm/nl5t+/qkwEJ89SZ3vlalFJsbJvxhs5LR/UrbPCWYDniPLvMuL+V8Pe+vTirvVC3x
	oJ9NhizCfOzxS1uYGFnheyQibugqJOMzE
X-Google-Smtp-Source: AGHT+IFjoA9LH+UlMYELvwOrDva8TbPECUBoKhrTSDmX1S6yeylMCFiLfASmbkP/9St1GzH8r2022w==
X-Received: by 2002:a17:906:6a12:b0:ad4:f517:ca3 with SMTP id a640c23a62f3a-ae0be88335cmr241931166b.20.1750843394339;
        Wed, 25 Jun 2025 02:23:14 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:01 +0200
Subject: [PATCH 06/14] dt-bindings: mailbox: qcom-ipcc: document the SM7635
 Inter-Processor Communication Controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-6-d9cd322eac1b@fairphone.com>
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=857;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=a9FLQid58ZrqwhwDBssnIOsYiwypbHIyY+vO7BVtkJA=;
 b=M++/VIb7y2T3gKskIlMpYOFvxwe+pfbHdhyU9gVdbfRegUxNj4iL+n141nUA1eMcP60CaNCwr
 IDMwEV8uYYeB8lGGvP/UKlrX7LWLDpIcdln/9pd8d17sYlzfKKWktV/
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Inter-Processor Communication Controller on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index f69c0ec5d19d3dd726a42d86f8a77433267fdf28..6e86ec36a82254ebd73c3067de495795c36c6bee 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -34,6 +34,7 @@ properties:
           - qcom,sdx75-ipcc
           - qcom,sm6350-ipcc
           - qcom,sm6375-ipcc
+          - qcom,sm7635-ipcc
           - qcom,sm8250-ipcc
           - qcom,sm8350-ipcc
           - qcom,sm8450-ipcc

-- 
2.50.0


