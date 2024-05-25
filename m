Return-Path: <linux-pm+bounces-8120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1A88CF085
	for <lists+linux-pm@lfdr.de>; Sat, 25 May 2024 19:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45091F212FC
	for <lists+linux-pm@lfdr.de>; Sat, 25 May 2024 17:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBFA127B75;
	Sat, 25 May 2024 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdfncoOc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697A127B5C;
	Sat, 25 May 2024 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659044; cv=none; b=roTrJBrpAi392Hgi/ngpOCcsrSmxt7gbPTFT7m04ZdMz/IHjAb6OFnMdMVjHis8Cgb9Xxxb84Elq1rD8J1d2U5lM/pvwkREX4Ir+rT5rGo54gY+u4S75T012NnZ6H2304nIKndMyzMOtiK8bBevVL5AvJzVV1Oa68cLbsKnRe6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659044; c=relaxed/simple;
	bh=HNiHtLdUEdjz0assJiHmGmiqtn89HULmn3jqnezzWXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZvy0AMxucMxRhtfqqZNPyFp9zPpbOTFFrB2nx3sWrjXUjnfa7TQZrSYR8DsG2URmS9xFev1Jt3mK1y16MDpnm+hhVvxcjncfA9MPKMegOvvNdD8y+W9zYNPpJbxMXX3s5C6jpmTVPoGmI3OjsuJfmHBn/xFLCqUXE1suECRiy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdfncoOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6011FC4AF0D;
	Sat, 25 May 2024 17:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716659044;
	bh=HNiHtLdUEdjz0assJiHmGmiqtn89HULmn3jqnezzWXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gdfncoOctOLFLGM6C69sr94DL8gYniadCepe+lLmLlVHVgv98lh4MeB/LMEXCNX4r
	 HjvbvvICeeiCKONUbsDs2HM9tcjlkd6aJtIQnk8npqZ70ooNU1JuiYxJOLzpZvdgNh
	 0VB/mJhPekdaiWtEdSChCOOG/xNOIxnYFyRJN5UNYaHhEhR78XDRSRe5cWdnNxnOL5
	 Vdhs8XncaRjnI8vcJKOfyhADFUkQZx0IUuHCEkI8GKt/fYup2fgYSndex8nFNG6jEq
	 8HY/VHkZIqFk6yc8jEBhQxbp7T9YLZZu98waUKCU7KYSV5yeqoY6bmHUMHs+LN3sfo
	 l3HVSOO6ySWZQ==
From: Bjorn Andersson <andersson@kernel.org>
Date: Sat, 25 May 2024 10:48:51 -0700
Subject: [PATCH 2/2] arm64: dts: qcom: sc8180x: Correct cpufreq compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240525-sc8180x-cpufreq-compatible-v1-2-febf0f17909c@quicinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=790;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=jJ9PlPAVPbDwptK3g1ut0SqhJtYZOjzmxrSBU2Uiy5g=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBmUiSCM798n6Sq+MRNBoZDwHH0PAiHXXn48slOF
 UX9uUPkz0mJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZlIkghUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcW+6g/9H2ptTEncCbj/RBuk7mTC8cHokNX8XFXBwRV3eq5
 MSWaR+RsKYTjz1cPy0k6Bh+FtyV9LssBkWT2L4RzH4XKiwIEFIpPOW1SdqX2Uc3mEWvwVRmTJXv
 jcDrOW6O7T01ysXVVELV3tVo+0qUVpXkahl/G8G5PRzZHCluWH62RsP4Ysee1s8oqDSjO0Sl/rT
 FxmIoKnXlv0dvbFvk+cGd5kR0k9EY9Gr5JJy39cwUmk1wi/ngPCfg99ithc6UkFl0ZAUb9zJMAU
 JB3fw/RqjFRZ6bHc/SRruIpHmVXi3E9E+M4OFkT9eBhX0pYBlDl5UED6JlM3LZlAE7KDKyN3tsI
 WwRJIwVHtGe4UOxVKDdIP86Ukzk8z9Yh7aTWtrpaVKghbCk/jhMJV+Ib5ehfmig0eVM1Km25CDi
 ZY4tAHI2wzzIIm7f9vdem1785hxpyaZ7Ad1m+lJ3skeIutQ5EpF8TQjf/YhgbkMDm94Dhrsj+ga
 tAwiLPWsU+qk58GgYoeliOJzLSM88YQRSwu/uHriK9JbpOlCPCURC9bvRTqqgHTbmLmG4JkMA+I
 plBRef4ihJKxY3tnqL0BMZEeJk1HbC9DoHD73AVGFW5AIAR0ANWIpPHC7eFH3QhJjFqavcK9Bdc
 nwY0dxEOP1fGWkVFOYwVte/HOQ32az1EicUhk7v3aiNs=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5

From: Bjorn Andersson <quic_bjorande@quicinc.com>

The Qualcomm EPSS CPUfreq binding requires a platform-specific
compatible, add this.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 067712310560..1f103cb54f99 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3733,7 +3733,7 @@ lmh@18358800 {
 		};
 
 		cpufreq_hw: cpufreq@18323000 {
-			compatible = "qcom,cpufreq-hw";
+			compatible = "qcom,sc8180x-cpufreq-epss", "qcom,cpufreq-epss";
 			reg = <0 0x18323000 0 0x1400>, <0 0x18325800 0 0x1400>;
 			reg-names = "freq-domain0", "freq-domain1";
 

-- 
2.43.0


