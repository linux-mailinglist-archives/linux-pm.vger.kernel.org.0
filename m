Return-Path: <linux-pm+bounces-11595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C7293FF52
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 22:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2662B22875
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 20:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6A018D4BC;
	Mon, 29 Jul 2024 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="OgEgnFBb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="iuKm+pnx"
X-Original-To: linux-pm@vger.kernel.org
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C47B18D4B6;
	Mon, 29 Jul 2024 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284413; cv=none; b=Fbt/j2E8d+UiFVMT2eg7jkwu8im3De/GJPcjyVmAJgBG+mO4BzmUi9SmUtwvwUpEm37dIbjpcdnLU9EjoGozVEVsXT7muCzd+NnXegxTPrqZUPiSAJh/UqLIfi3Auq09ESDKpH9cjFfkMl/OloLpQSlsNlHItTgU93UB2QPyiyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284413; c=relaxed/simple;
	bh=W7Dkhmqr8IrZbwA4Hy7mdHM/QH2p+Gh9CnxSXGrrBuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+1NAzXsBKb+5DlrP25XCQS38ozaXf0oaidrIFdgsmIMTKogvCf03BWSxWIPuWbn4JgN8K62RTljgXO7CvBZyz9XNNEWi4cw9xtdHOeeM4YN/fjSFiEc1NRZFoQhzD9+0bmn3Pd0OClnqzHstlfEfnZGldGPsk1Ajrv2liHgoeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=OgEgnFBb; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=iuKm+pnx; arc=none smtp.client-ip=79.137.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=uR1s25oNPQSr6V6jf3gDIkABHV6oW1o+YbMvOB8hd3E=;
	t=1722284411;x=1722374411; 
	b=OgEgnFBbaXpXbnRhEktgsYkqXqp4OhzVNcXqDybIFkSfJ9Vbfct9MyleW8aSLe2NKNSb/uf9WGDb1J4nB+p8Uaio+/thhzI4eDvAHIZtGoG/fZqVsSsAl9RjEZv21PX+4BflEFBafvj4QyZIjM9jraijH9EbC0BOxa9+EaGJtF4=;
Received: from [10.12.4.25] (port=52982 helo=smtp54.i.mail.ru)
	by fallback1.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1sYWqm-00GdB8-L1; Mon, 29 Jul 2024 23:20:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=uR1s25oNPQSr6V6jf3gDIkABHV6oW1o+YbMvOB8hd3E=; t=1722284408; x=1722374408; 
	b=iuKm+pnxy5ozziDGxkoJ/9xBr1WUOpGXAIWHs8RTdzKsm5EvnvTnwcqvrKJIBnGWcm1fqiacKcE
	edMg22hKIURzqpNFew1JibCbCiIad+EZ/8AJBp2LMpxYf9OPk+gGA0Ec9ZLrTJp12JWhyyTPnsmpt
	KczM0wTv59FzMbyQ7Us=;
Received: by exim-smtp-868bf69f6c-8kchf with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sYWqV-00000000CoU-2ter; Mon, 29 Jul 2024 23:19:52 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	kees@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	sudeep.holla@arm.com,
	quic_rjendra@quicinc.com,
	andre.przywara@arm.com,
	ulf.hansson@linaro.org,
	davidwronek@gmail.com,
	neil.armstrong@linaro.org,
	heiko.stuebner@cherry.de,
	rafal@milecki.pl,
	macromorgan@hotmail.com,
	linus.walleij@linaro.org,
	dmitry.baryshkov@linaro.org,
	johan+linaro@kernel.org,
	javier.carrasco.cruz@gmail.com,
	quic_kriskura@quicinc.com,
	lpieralisi@kernel.org,
	fekz115@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux@mainlining.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 08/11] arm64: dts: qcom: Add SM7325 device tree
Date: Mon, 29 Jul 2024 23:18:15 +0300
Message-ID: <20240729201843.142918-9-danila@jiaxyga.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729201843.142918-1-danila@jiaxyga.com>
References: <20240729201843.142918-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9000B6812E77BE1C6F0D221D1B7CB84E2160E2B5FE815AD3B182A05F538085040E82E17C5F9BA39B43DE06ABAFEAF67051EE0F3327AAA305F9EC546CAE4A36CACDC8D45F6CF1587E7
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE723F2EBA4AF3D39F8EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F757A79C3007ACA28638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8F07133BD0FB1A8C5580E18DF0DBB563D1B48B1A5EA69CB6DCC7F00164DA146DAFE8445B8C89999728AA50765F790063735D2385A5E2B3AC3389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC80CABCCA60F52D7EBF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CE3786DD2C77EBDAABA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B65218A6880B2A9D023AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E735D028CC0B556B22BCC4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5ED6B12E7808532395002B1117B3ED696430C97132C82A4FD6E5F408120975D33823CB91A9FED034534781492E4B8EEADC0A73878EBD0941BC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF993A04C4A94D9F808E6E4A889A1E90787E37B916ABC62BABEB693FF5C22CEA4AF02FE508BB13AAFB67C7AAC6E25A2086424CB4C5AE4E85B4633D7FB3044967C2A2EEA2A9C5460AB961A41C79C593F3F002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6W0kdmJn6G3rw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981FAF4174D7AEDC04ED85FDC519B836460F0899C787A5A9009AFFECE93525E07562C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B431B8944160407DD0C2EAA1E6BA7F9BE034EB9672DF358C7268F3CF0E9FE49B69543DADA4AE4E32474F08BF4A0051E7C897887149318D0F8432D432F506B47C13
X-7FA49CB5: 0D63561A33F958A561F4E863BF649CBB4A5D64E9A777A20D8A33E389C1FE3F708941B15DA834481FA18204E546F3947C05B7D4054DE234C1F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006377B3E3CA19E3E440B389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C30F754AD15E8417F235872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6U9GqIQJV52uA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

From: Eugene Lepshy <fekz115@gmail.com>

The Snapdragon 778G (SM7325) / 778G+ (SM7325-AE) / 782G (SM7325-AF)
is software-wise very similar to the Snapdragon 7c+ Gen 3 (SC7280).

It uses the Kryo670.

Signed-off-by: Eugene Lepshy <fekz115@gmail.com>
Co-developed-by: Danila Tikhonov <danila@jiaxyga.com>
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
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


