Return-Path: <linux-pm+bounces-8119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9358CF080
	for <lists+linux-pm@lfdr.de>; Sat, 25 May 2024 19:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE6D1C20CD3
	for <lists+linux-pm@lfdr.de>; Sat, 25 May 2024 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53451272C4;
	Sat, 25 May 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/LyQBBo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A608C1272A5;
	Sat, 25 May 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659043; cv=none; b=UIblE4I8vxFiqsOUN3oE0oBnhCpXmOofRnJMx6JjphHbSk8X/cnfZjI0ixSiR6xTfgS6+f0JugsYiSpDK/tttRP8UAJixTshnCifeQAc0fU4rs9V/O+iqjkZIkInf6w7qUS2boid/NHa6qhUEeqZnZt4tUM5VsEK1Bzd6xBt6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659043; c=relaxed/simple;
	bh=P+vJCczUY3dk8/unavIL2fvZZqVUYcIJl5YLds9SMFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eh0owNgHa1/pCI5aWbhNwhc0sZm6do+ncxzyXcwaYh8Dh4YF+GtPqcsjN3DEYt3a7kmnBLAfAaMm7pz/Aibb/8lv7Jlu4RL5JjWZ/7pw8Ye/1jkYPmROdxq2L/sAethasz65fAoxPtadtM7dHfOFXSYnXVxvEjShAHdlLmVaNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/LyQBBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED83C32782;
	Sat, 25 May 2024 17:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716659043;
	bh=P+vJCczUY3dk8/unavIL2fvZZqVUYcIJl5YLds9SMFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z/LyQBBoqo8GMNRunZfsuL+F/NE1rMIztgS4AihWuP7G3Bm9q4yjX6GeYtX0L+sLv
	 iBVNKL5eS6QrVXsn26+ZbLYI4a5BQaeAGeXiUoFn0IEUa6GgCHXiA3YXg+fbHOwirl
	 vRZEDSvur46DiuFZYbh2/wJBngvjBOGs6E1gkOolpyvmqErBO/1Ufsxd27V/6939jS
	 kS+dU2fCZqLgL+1xqIfXDdr4m8UfcUJ1PBfmMlGYv0QiqlkXECdDJRga729EQ/MLp8
	 U9JLE7kmD8dvKQYt6LXANROv8J8h5ZnqVnJPp8lAf9IyN2pzv98B7pnU9PDAvdXIEv
	 bLohl9lILaf4g==
From: Bjorn Andersson <andersson@kernel.org>
Date: Sat, 25 May 2024 10:48:50 -0700
Subject: [PATCH 1/2] dt-bindings: cpufreq: cpufreq-qcom-hw: Add sc8180x
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240525-sc8180x-cpufreq-compatible-v1-1-febf0f17909c@quicinc.com>
References: <20240525-sc8180x-cpufreq-compatible-v1-0-febf0f17909c@quicinc.com>
In-Reply-To: <20240525-sc8180x-cpufreq-compatible-v1-0-febf0f17909c@quicinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=931;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=Awx9vuYaQbdLEk4RVNWSFP2WE+nYrg+P7w+DEF6Koiw=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBmUiSCOe2GaLz1XifiP3IoXFgwSYEOPLK5dutL/
 AjU88tY2jKJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZlIkghUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcWEQRAAtaa4fKmtHEO4Ww8Iog2PcLT8rMsM+I82efBCJJs
 CU0aFNvCsQw+wVwMinXFq8yasrEjO4fuzZVtO21dCzANV9bHQAFQvGLan+r1rYvvgek5DlZ16i5
 uY/7Gi1HqLMUllxPjmNPFy9AoEwJBUg9bKfb3ZR7d7luEYiLIow9cUuOVa0dzlL6k+peOlUDlkp
 Fg8Uegi6A8DuWeBwYwuQ0NoyJJvaJ1mmHI8k69vy4HyKQiOtAr4quqRtODkbQHrXU4Zb27VmttZ
 TRNDTvAsJM0CBbyF1JeTMhPdikCzuLeF1vAxm84Co+GGNAfAlmHZ8guPCc2Ewt/M+ZaPFruzyJY
 /XtdOEfA1YVHb993dMzyPGXYNrpkUwKOMI/zgpLCJ+oaUUiTmL8qBaerTky1/6gOmJSxga4HceM
 ef79RuEq/HlzywwJmdogK3dQFF7aTXEfvLmGM8l558MkCA/0CuwN6ojMBhfGYxzLRObrvg5mzM1
 lAZyt8FH+bU1T4r1Uea9D1Rs+EYUCX5HkqvYCDoFu+VdhRALug3w+DGFNfvR/XnRkuqAn8YcQHS
 j0HBcjOoC1x6RGRsawNYnu9ia/rU/8gEKttdZeyYTTRZWOgz6/RPXkLf3aGgw1rc4othsQB07OG
 AF1yzp3zEoWf5v9ZCTKKcHkv5WkfsJoUaq63SrcE65sY=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5

From: Bjorn Andersson <quic_bjorande@quicinc.com>

The SC8180X platform has a EPSS block, add a compatible for the SC8180X
platform.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 1e9797f96410..24c02ee33266 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -36,6 +36,7 @@ properties:
               - qcom,qdu1000-cpufreq-epss
               - qcom,sa8775p-cpufreq-epss
               - qcom,sc7280-cpufreq-epss
+              - qcom,sc8180x-cpufreq-epss
               - qcom,sc8280xp-cpufreq-epss
               - qcom,sdx75-cpufreq-epss
               - qcom,sm4450-cpufreq-epss

-- 
2.43.0


