Return-Path: <linux-pm+bounces-12011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FD994C4B3
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 20:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF201F27DEE
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 18:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191E2156879;
	Thu,  8 Aug 2024 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="H48TGpmA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [95.163.41.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A0156676;
	Thu,  8 Aug 2024 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142514; cv=none; b=O9KnSJj7yVB76Bce9RzeXJ4ry73QkMqtX81XUKcKn9KIbTkJR4K61/KKGw+DkrzVvdhDly+CT4kWBhYE3oEezpMHlsQrPYUmsls+UZOQJ15a8I4/uJMXE69QmvZ/7DAPfGTAy6K+Rlax5P/biKWhkbwYXiv7Opu1U0VHd+tik0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142514; c=relaxed/simple;
	bh=ZeDEQ7l/BbiB8CS5v/0yycZNwMG3SKnoVYPGXZmKydI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KB0PLnFavQDMcQ8x2947gHqr8BqtKuf+2K/nqYpDzpN2ayMcmzjSShNHiDauJP/GiHVKlWS35hJS90CPB3F/OeHHEXcO9t5W8zHXfOTVJ/3M/5Lc+JDXeM7iT0xC9R2DrnAcub4fQg31hcmMI3R2hMJFAvkGCeCJeoVH6/cSOms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=H48TGpmA; arc=none smtp.client-ip=95.163.41.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=ekEO8MmmzxHLEsGI035qztcUioQ+TLSBPtLnQmQmyAs=; t=1723142512; x=1723232512; 
	b=H48TGpmAEFrN838rNJE6Jfj/Eznlvq7PDs+ZFmrPCqPfybx2u9hpuc0pzuQKnvi3HuFtTes5N2W
	T4PZUFfDH+goaQHFnQwcd0syZUXXkxH350mHPhKDCZ7lrshg6duMCrrJUMguwsmX7SVNpj4ahUeTt
	b3dB0OmeGqTKshH4KnY=;
Received: by smtp39.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sc855-00000001fDW-2rrn; Thu, 08 Aug 2024 21:41:48 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	kees@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	ulf.hansson@linaro.org,
	andre.przywara@arm.com,
	quic_rjendra@quicinc.com,
	davidwronek@gmail.com,
	neil.armstrong@linaro.org,
	heiko.stuebner@cherry.de,
	rafal@milecki.pl,
	macromorgan@hotmail.com,
	linus.walleij@linaro.org,
	lpieralisi@kernel.org,
	dmitry.baryshkov@linaro.org,
	fekz115@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH v2 08/11] arm64: dts: qcom: Add SM7325 device tree
Date: Thu,  8 Aug 2024 21:40:22 +0300
Message-ID: <20240808184048.63030-9-danila@jiaxyga.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240808184048.63030-1-danila@jiaxyga.com>
References: <20240808184048.63030-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp39.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9D9DED0FED0530B211039911335079E8F258F98C4CB741FF500894C459B0CD1B9865521AC0FB3734B3E60E583875EFAA411EB69C6CBF594A0C5D9A4B8257350161E39E150AE5B0BE1
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78C1BD59EB4E0B0A6EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637603D0B7FC8E46DFC8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8C10B09FC4B71AEAD9889FB57C2C458C2CA7403AFB867F49BCC7F00164DA146DAFE8445B8C89999728AA50765F7900637A6F6611B2784C7A4389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8D166953D3EA3826BF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C6A1CB4668A9CA5FA6136E347CC761E074AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3434A9803D6DF6E63BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7994FE22CF3C16DE0731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A502F68C94FE9376A55002B1117B3ED696E42D4EBAA5A425A854BB1175C6E7DD94823CB91A9FED034534781492E4B8EEAD05E80F4396618BB2C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF086F4E273E70E434A139FC8C620773368E8984B961C9843B23E82E1E15049980696309706696DB625CC6C73BB6D1AD5313677F4CE41D62AEA8EF8C92EF10C1881BF1389D33A01131F3ED94C7A551C90002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojnAZp9Q+n/0N/wjtqPADbOg==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981A52D9F19D561BC9EAC4385294E02B5FB648CE314535486274C1A04A64D46420B2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

From: Eugene Lepshy <fekz115@gmail.com>

The Snapdragon 778G (SM7325) / 778G+ (SM7325-AE) / 782G (SM7325-AF)
is software-wise very similar to the Snapdragon 7c+ Gen 3 (SC7280).

It uses the Kryo670.

Signed-off-by: Eugene Lepshy <fekz115@gmail.com>
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm7325.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7325.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm7325.dtsi b/arch/arm64/boot/dts/qcom/sm7325.dtsi
new file mode 100644
index 000000000000..5b4574484412
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm7325.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2024, Eugene Lepshy <fekz115@gmail.com>
+ * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
+ */
+
+#include "sc7280.dtsi"
+
+/* SM7325 uses Kryo 670 */
+&CPU0 { compatible = "qcom,kryo670"; };
+&CPU1 { compatible = "qcom,kryo670"; };
+&CPU2 { compatible = "qcom,kryo670"; };
+&CPU3 { compatible = "qcom,kryo670"; };
+&CPU4 { compatible = "qcom,kryo670"; };
+&CPU5 { compatible = "qcom,kryo670"; };
+&CPU6 { compatible = "qcom,kryo670"; };
+&CPU7 { compatible = "qcom,kryo670"; };
-- 
2.45.2


