Return-Path: <linux-pm+bounces-39092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 240BAC9C6B5
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 18:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78A6D4E3E34
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 17:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89522C1580;
	Tue,  2 Dec 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G287PnBh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C701F936;
	Tue,  2 Dec 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697001; cv=none; b=EH2YUr9y8HcpSfr50wqcJspDuJ2fKIqe2XDYxUsC+NvYvjL8J1ndIDaHRbKQuVkzOE+PzCXtOcXLPNAsLzw3M7AfS78NzLphp78C/P3EyRbK3ngXu4K0d+XwQH2NbaOcsG9MfZUg9dJr3tca2qf4GwA9NY6+xmvjhMX//8csQE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697001; c=relaxed/simple;
	bh=nuxSkvxO2++4wEFUB3aq8QvwtHq4l1cMskRICrLwwD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c0hLFemSs5VrgdoUc6XgmHkBSQgdXJjuuK3KkczqAwzyCq8qyER2HdPMqxqu4YtWtftRExSBmyKq2KzZecA7tTwum1ydhhZXViIKkl8i+JI9alJNG2z0Zx6D4MG/u9UZ74x1cQTkVJcHRVORdXkQK2wURkjfk1p7JwD8rf0fFVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G287PnBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2114FC4CEF1;
	Tue,  2 Dec 2025 17:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764697001;
	bh=nuxSkvxO2++4wEFUB3aq8QvwtHq4l1cMskRICrLwwD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G287PnBhDo/LpwzQ6r0U4c67wgHpWGpLdpBdBP0l6na763R3XEof/p2IvX42zQpXQ
	 /uJm2wYflQyghk74TAlbJLWZZ6uj3EU7Not0XgodAx6FXfiofUMSOBNpyRjh5cb2RL
	 GIrRU5EKuCTjcf+BY7hIHMFb3Jr0p7urncm6fv65tWtnx/dr9Zarrg9hwZXoV40MCu
	 aKsbT3+pBjiF3IGJrrHg7CfjDFZ02VsodYjj7t7UXAgq/zxsHbKhK3QP97xYSOABzq
	 HVnKa0RTcvfR/fIRGZihROd5pyszohAHFbR2EvVcZ1epZ+d3n+zK/YHE4H5OC/Uxox
	 z48Vm7gzN4B8w==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 02 Dec 2025 18:36:20 +0100
Subject: [PATCH v2 1/3] dt-bindings: power: qcom,rpmpd: Add SC8280XP_MXC_AO
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-topic-8280_mxc-v2-1-46cdf47a829e@oss.qualcomm.com>
References: <20251202-topic-8280_mxc-v2-0-46cdf47a829e@oss.qualcomm.com>
In-Reply-To: <20251202-topic-8280_mxc-v2-0-46cdf47a829e@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Imran Shaik <quic_imrashai@quicinc.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764696985; l=875;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=9qiVdT4EPzE8O7cEppagVeC3HgOKK44NPgNHRnjq/nE=;
 b=WcRkdwxMTjTE4SalDRambdua00Dtfp/MuAkTBW0fzKwlWO4rhP29pCkTIpefEr8l0Bxe0+pOP
 lOKoaybGNYeD/ZlER+dx7Zx3OaMicZr3Gr7fJH+//fRARVrccWWRjSG
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Not sure how useful it's gonna be in practice, but the definition is
missing (unlike the previously-unused SC8280XP_MXC-non-_AO), so add it
to allow the driver to create the corresponding pmdomain.

Fixes: dbfb5f94e084 ("dt-bindings: power: rpmpd: Add sc8280xp RPMh power-domains")
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom,rpmhpd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
index 50e7c886709d..06851363ae0e 100644
--- a/include/dt-bindings/power/qcom,rpmhpd.h
+++ b/include/dt-bindings/power/qcom,rpmhpd.h
@@ -264,5 +264,6 @@
 #define SC8280XP_NSP		13
 #define SC8280XP_QPHY		14
 #define SC8280XP_XO		15
+#define SC8280XP_MXC_AO		16
 
 #endif

-- 
2.52.0


