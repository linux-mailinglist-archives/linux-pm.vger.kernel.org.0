Return-Path: <linux-pm+bounces-17493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E689C760E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 16:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BA2B39020
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 15:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02C920697E;
	Wed, 13 Nov 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="JkAKzULE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D9206068;
	Wed, 13 Nov 2024 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510721; cv=none; b=CIUfPx7QykM7K3hDag97yk46SM+8quv1qeCw+c7U1y1nn012Y69wAvI/Mk29gy+NtPsMgdsdSmjOQ2ZcZPKogmAeSyAjzLR1MT9AuDmjKqn7qhIiCujYLSJ9jYJJN5nMsucLDbDJx3HExzQ+dJ6/ZYjZ+dBnZAua2wTYm5syn3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510721; c=relaxed/simple;
	bh=oSFXD5koz0bnImj9AwyYkdxZ8tPIPU4UsWyonhEengo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AJ8XQ1GnDmWthqZK6WN8p34giFtM5QYRV5M7hs1s0QaJYrd3dTmfMTBj5B1oz8YqbNdwOOlB2jMVgrYzn9XJtqqkl2ktsVtLAI8MhdDhkscT6SA12MxSEk6TTWYmapwzcj57fPGQgwax7e371iPfqAWcdtVaTMnHSGQREyS96Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=JkAKzULE; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.93.162] (254C230F.nat.pool.telekom.hu [37.76.35.15])
	by mail.mainlining.org (Postfix) with ESMTPSA id 07AB9E44F1;
	Wed, 13 Nov 2024 15:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731510718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8Y4yxwqnDss/PAt3TvJTQZaFUiFNkqCyH+WUzWqZ+0=;
	b=JkAKzULEKXe/evGoS8X1fXAuf2HNIVAR/h/UiOhn+sH4jt2DgZqYcoJcyC6c7J0+uK40bd
	xeJzajh+ysAS6QKT9l9sgXNWf89hNicFX8crtgikdvlJSaW7UtvF//4bAspQsZ/cuimQqv
	cKIlROOix4XixOv0N17ApGYP4W6056LYGmeTTKGH20U8iv9lwfzMptUsBjGHD2vt3FQVWQ
	bK9FCv7Se2BXFRM5/JdPkmY3/RM/jzydeTGXxmjnMin6SVMX65F8j/aWEbKZE1QlFk4eX5
	Zen4ok65Fj3EkVGNCclv6ESZBFa1I5eKiTZ9OzN4zPa2GxfEYQD9r2gjo5z1cg==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Wed, 13 Nov 2024 16:11:48 +0100
Subject: [PATCH v6 07/10] dt-bindings: nvmem: Add compatible for MS8917
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241113-msm8917-v6-7-c348fb599fef@mainlining.org>
References: <20241113-msm8917-v6-0-c348fb599fef@mainlining.org>
In-Reply-To: <20241113-msm8917-v6-0-c348fb599fef@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731510705; l=923;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=oSFXD5koz0bnImj9AwyYkdxZ8tPIPU4UsWyonhEengo=;
 b=i5Oje4Mmoe2/rWV7CU2x6pYHxNagSFd8X+okeVGrxtPCS/ztzS1hKi3g8ma8iPlRrSZGWi3dR
 LorO+vdz+ZKCIXNu0RagTzevVhGqDPijLASvI6av586pFkU6qQIR/fC
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document the QFPROM block found on MSM8917.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 80845c722ae46611c722effeaaf014a0caf76e4a..4d81f98ed37a3a12f01d444dbfa77badcc09c22d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,ipq9574-qfprom
           - qcom,msm8226-qfprom
           - qcom,msm8916-qfprom
+          - qcom,msm8917-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom
           - qcom,msm8996-qfprom

-- 
2.47.0


