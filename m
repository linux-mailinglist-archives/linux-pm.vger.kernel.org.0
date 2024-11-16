Return-Path: <linux-pm+bounces-17667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 415C89CFE9A
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 12:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0AC5B28B53
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280F1ADFF1;
	Sat, 16 Nov 2024 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxPiKG2E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7166422338;
	Sat, 16 Nov 2024 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731756691; cv=none; b=JdyIGhH4jU4UwUA44V5AmhvpxKm/vYvOX4ep+EVtj+Z98xFtOnJg3K1GzbQHYoBENCkkvCByU5FDIrLWko1rBseVrILkFBLSpuYDBNZvRFYvzY2UEQnjzffW+OoajIKRp1X38Yqgf6kbBueJm9ipx8fgbN5aUQ6Ao3JS3KKtg2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731756691; c=relaxed/simple;
	bh=6FtOTp2L33sndUrL9nlXHnk0jTq9STErg2JadJb+OKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lcKqmKPZKasHnJJsxTy4EbhJy+kdBhZOmspWQCg5Av0vIbjQlfnyGMEtMkMlzD5TVUzRw9TIkJ98/9QFfQ6SZeBeikd5WXBZ+iXgaARP8IGQAgiwPk/2UHXzCM7XTEXFLAwN3xGnENGuhYFvnP5OlvOjY+OV6wtNKrbVQIOzHro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxPiKG2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44312C4CEC3;
	Sat, 16 Nov 2024 11:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731756690;
	bh=6FtOTp2L33sndUrL9nlXHnk0jTq9STErg2JadJb+OKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZxPiKG2EO9LNH47zhy9ZWhD+Ch7FUKd1oLFzbvR+Gg3T6gGUTms+GKIdOxbyQQe2L
	 1XZg4O9gqTx+6RY+2LQmpJ22pJNqxRt4l05cadYhPoPrBn+y+52HJmH7X1gJEqt+zk
	 0g7v9dQ8xMnNQ9GM8ivYe37xrigynU0hmM1BTvkSrMSFJnSUTz4SFTmv1tFYQPJ+Pe
	 VAN7IWHUVN5sVMOmc+XmEXudLgxm9BX//UcvACa0RjxZkNuAQtA8he/IGzeaTay99j
	 RxCTl0tJJpWigaEdOhK4r7iHDfFMETIE5WAec4FihiFdNrkNT5mSP2uTOSQNBWQ+Mu
	 XiqNu6HIhdD6g==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Sat, 16 Nov 2024 12:31:18 +0100
Subject: [PATCH 2/2] arm64: dts: qcom: sc8180x: Add a SoC-specific
 compatible to cpufreq-hw
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241116-topic-sc8180x_cpufreq_bindings-v1-2-e7db627da99c@oss.qualcomm.com>
References: <20241116-topic-sc8180x_cpufreq_bindings-v1-0-e7db627da99c@oss.qualcomm.com>
In-Reply-To: <20241116-topic-sc8180x_cpufreq_bindings-v1-0-e7db627da99c@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731756678; l=1018;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=rDzXnBO2BTwNVQR9ieAv61yGPCGBlgCfXDXJN72WymA=;
 b=QQB9FzhVW8PFMgl8/iQ6qvPpyZYaSA0ByQhAkXXKGd5AJPAIWAifaroNrwMjS7Bj/kGhHZuk2
 EcrF+0cD4vVBLGG53XAxSZKvCAxD0Nix+8FZSxfTLa3fdHq1d56VCBJ
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Comply with bindings guidelines and get rid of errors such as:

cpufreq@18323000: compatible: 'oneOf' conditional failed, one must be fixed:
        ['qcom,cpufreq-hw'] is too short

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 717ec4ad63f3035b839d85fb1dd375fac9b0a2b7..745a7d0b8381046dda40dc31e61df905824d6388 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3889,7 +3889,7 @@ lmh@18358800 {
 		};
 
 		cpufreq_hw: cpufreq@18323000 {
-			compatible = "qcom,cpufreq-hw";
+			compatible = "qcom,sc8180x-cpufreq-hw", "qcom,cpufreq-hw";
 			reg = <0 0x18323000 0 0x1400>, <0 0x18325800 0 0x1400>;
 			reg-names = "freq-domain0", "freq-domain1";
 

-- 
2.47.0


