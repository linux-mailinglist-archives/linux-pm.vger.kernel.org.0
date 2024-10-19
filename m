Return-Path: <linux-pm+bounces-16013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBA39A4D64
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A2F7B23BDD
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 11:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA6A1E1C11;
	Sat, 19 Oct 2024 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="qGrCPH8l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68D81E1050;
	Sat, 19 Oct 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729338656; cv=none; b=GEZRbGEmxBZDWLy8mONhEeHBbOig9+11DvpiMubp8YgmcK45INuDAk5Ge2Eg5ZRcrkFJfhGFdlV7Pu7vhRmI+7yKnQ/y73hlJG2PHwjCql9fc7EG6IsAeDBiA9acMX5rOkWzC35MijBX26MW7Y7vMaTRG4t01CnA1SG7RhMnyWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729338656; c=relaxed/simple;
	bh=IRtvRWDOANUihN14f+/JFJ+TjYo+Ikv6z9bgXN7AQDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUWf6mQ/2Neb+8vkLAbfoNy7wDjjtRHDXLnK0cCwzVdJLzB4g0SBIYcZyiLmge3lZubDPCRgBERJgcNoT9CfXWaiUDCtWx+h0TvBRnV6VzNgpm7ZBFkC8pFIuDrqDFzlYebDY0vQYkUW2rocDgywQ1WrmILIwaeJd4XOVtd567E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=qGrCPH8l; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (51B6DD9D.dsl.pool.telekom.hu [81.182.221.157])
	by mail.mainlining.org (Postfix) with ESMTPSA id 19880E45A5;
	Sat, 19 Oct 2024 11:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1729338648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKHpg+U4gE4J6mrWua3GIqYVhtuoK9V1rqrrgqzuVrU=;
	b=qGrCPH8lehKF+IPaQbQsIOFO8HJKyTB5H6qqEEDwMSN+/vXsKyryhYcIUhB9XXh/S8OXe5
	DY/aomyV2/Y7+c2wsD8DvKawtIflnELE7e0JT8uKJF/cJw+98Et40J/AHER66gHBTKPqNO
	hXZUYdulfqTDgPYpx0IBvNCbKN9IXvAVmLCKBVw6eNuiDRw+nB03Cq1hGd2hiC2o6Qqfu2
	SEkkefdeR0NzXnE2cKk2asA4oefFka8WT/og4uDapZ+TgRQx1R3tgsX3Nw7Mb3wEUm2TAh
	pYV5H5UgCIO6710KDp5IxWbdrCpjG1SPm+ceRzxSw2njBD/9cVa0V51M93iJYg==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 19 Oct 2024 13:50:46 +0200
Subject: [PATCH RFC 09/14] dt-bindings: thermal: tsens: Add MSM8917
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241019-msm8917-v1-9-f1f3ca1d88e5@mainlining.org>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
In-Reply-To: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729338640; l=860;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=IRtvRWDOANUihN14f+/JFJ+TjYo+Ikv6z9bgXN7AQDE=;
 b=xYlQSXfyL3pitR6D3rsfA/xofcBFsujGkMfpMCUlWG2cSdI1Yb3l1nYwgqXNIFAi72eFKyJsZ
 c5vr5BK6zcHAYyJgpn0QFAPXP2MMlmbxZInICQCDlPN9gKdE+dV6fDT
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document the compatible string for tsens found in MSM8917.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index a12fddc8195500a0e7bdd51952a558890b35935c..9add4fdc21fa307cbe9be6dde30369777f1ef91c 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -39,6 +39,7 @@ properties:
       - description: v1 of TSENS
         items:
           - enum:
+              - qcom,msm8917-tsens
               - qcom,msm8956-tsens
               - qcom,msm8976-tsens
               - qcom,qcs404-tsens

-- 
2.47.0


