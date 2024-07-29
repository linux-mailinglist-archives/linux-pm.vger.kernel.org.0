Return-Path: <linux-pm+bounces-11591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F9B93FF35
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 22:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67761F226F7
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 20:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2298819007D;
	Mon, 29 Jul 2024 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="CXIxt5tt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="To0zMsok"
X-Original-To: linux-pm@vger.kernel.org
Received: from fallback25.i.mail.ru (fallback25.i.mail.ru [79.137.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A1418FDB6;
	Mon, 29 Jul 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284383; cv=none; b=mbo5kXTtW3XANaYceBRwDqLD74avaaFkA1YWxmJ57Zpe631KKP506ojaY25deyNOR8g9DH7rtHKJkVpXOF87WdYFsbcXcZWYh7MH5KeapbMHjLmw27PxImaJT6M47hTHZboGGoOYiz6OLaK/V/EantGLgO8qWsd8G1d5DPc4iTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284383; c=relaxed/simple;
	bh=HzeYqA0fiWDqans3Pc8S52H1M6eL1Cp3zBvETxm9aEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwbZhkAyEJIB8ELHUhlW/9CoHnbyNItDL2eT98VjTWcZhqfqyoH8AZaLRjdwtu/mqL655t6bqNDDYlAKYeqslV/yT/4P/0idQnDMs7oFPvHVZX5slSvkYrK2G/oMpTU4x8B13xbupfxcsRqJqT0u0QlHqG8ONqpVnJ1XspphYSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=CXIxt5tt; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=To0zMsok; arc=none smtp.client-ip=79.137.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=GgJZIOOdqDS548hXS4ZOn351AZlQdqljirRcQZhUvLQ=;
	t=1722284380;x=1722374380; 
	b=CXIxt5ttlMaUvtQA632coxfD4ivvZ3Gr0uaHsfmzR5cpivJKiCJkN10F16kbCrPoYM7PUsjNWo6d3aPVCBGG8XGcu+MlUGs8hBVzKU0ymiM5DNwJM5liNnC47ut67z3+1d+fIf+QA702ONBe2Ks4G/BKtuUDUHZ5GO58jipmuEs=;
Received: from [10.12.4.31] (port=40768 helo=smtp56.i.mail.ru)
	by fallback25.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1sYWqG-00HJPm-Uy; Mon, 29 Jul 2024 23:19:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=GgJZIOOdqDS548hXS4ZOn351AZlQdqljirRcQZhUvLQ=; t=1722284376; x=1722374376; 
	b=To0zMsokpmQw75STF+AF/5zU7rS4GwTWAzRGMO7lUSveKMQ6AUsOOPV7FH3F32/ESgU/2LeSKOA
	297hyNlSRauz8RTfyCAKC3R0GSa5gDQre5CPRfn3AhCKqMbEqIY1sNNY+6dZToOu9gDfI8SK2zY5X
	TXTvMGiI+plMNAAmLFw=;
Received: by exim-smtp-868bf69f6c-8kchf with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sYWq1-00000000CoU-19O7; Mon, 29 Jul 2024 23:19:21 +0300
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
Subject: [PATCH 04/11] soc: qcom: pd_mapper: Add SM7325 compatible
Date: Mon, 29 Jul 2024 23:18:11 +0300
Message-ID: <20240729201843.142918-5-danila@jiaxyga.com>
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
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9000B6812E77BE1C69019ECFFCCC204324D7BC83486271641182A05F538085040CC0E9159EF56F8113DE06ABAFEAF6705C05102CA8872F7799EC546CAE4A36CAC5A3E3A1F90AE8952
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C2204D4F9A221771EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637040380BD28C1B15C8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D89E6A9EA7A5A69626580E18DF0DBB563D05434D056C78BB2BCC7F00164DA146DAFE8445B8C89999728AA50765F7900637D0FEED2715E18529389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8989FD0BDF65E50FBF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C4B6F6234D9065C972D242C3BD2E3F4C64AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C356F5B1E582025211BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE74F0F518E68DBD4F843847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5B2B9259083C9702F5002B1117B3ED696493AA0E4DA71AC34C66B2B37046EC955823CB91A9FED034534781492E4B8EEAD0BC323893F80E328C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF9F41F314557EF7B470C54136BB27849A8636453C98B3C37A4AE8B24AE54109EBE781F4E203C5707867C7AAC6E25A208684E4384B219FC97D633D7FB3044967C2FCE265D3B5101F4461A41C79C593F3F002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6UaQMlFKV//ZQ==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981FAF4174D7AEDC04EAA70CB78A12CDBB55E1C316C5344B936E3F8F959B040918D2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B431B8944160407DD0C32ECD32B9294E2344D2BBFF7BBF02C868F3CF0E9FE49B69543DADA4AE4E3247961B9D277DA66607DDF18CBEC26ABCA3E3818FC9C47ACC6C
X-7FA49CB5: 0D63561A33F958A5C51AE974FFC8727ECAAC110B7DDFA61C4AAD531C5438CE2A8941B15DA834481FA18204E546F3947CEBAEFC6015046CFCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063749305D2801D13566389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3B43B7A57207DBF0735872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6XdWtpyZj+FBg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

The Qualcomm SM7325 platform is identical to SC7280, so add
compatibility leading to SC7280.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/soc/qcom/qcom_pd_mapper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/qcom_pd_mapper.c b/drivers/soc/qcom/qcom_pd_mapper.c
index a4c007080665..7a35a548c21f 100644
--- a/drivers/soc/qcom/qcom_pd_mapper.c
+++ b/drivers/soc/qcom/qcom_pd_mapper.c
@@ -539,6 +539,7 @@ static const struct of_device_id qcom_pdm_domains[] = {
 	{ .compatible = "qcom,sm4250", .data = sm6115_domains, },
 	{ .compatible = "qcom,sm6115", .data = sm6115_domains, },
 	{ .compatible = "qcom,sm6350", .data = sm6350_domains, },
+	{ .compatible = "qcom,sm7325", .data = sc7280_domains, },
 	{ .compatible = "qcom,sm8150", .data = sm8150_domains, },
 	{ .compatible = "qcom,sm8250", .data = sm8250_domains, },
 	{ .compatible = "qcom,sm8350", .data = sm8350_domains, },
-- 
2.45.2


