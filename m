Return-Path: <linux-pm+bounces-11601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6616F93FF9F
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 22:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299DC2839BE
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B30C18A926;
	Mon, 29 Jul 2024 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="QR8x3eKW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="rhm/8nRp"
X-Original-To: linux-pm@vger.kernel.org
Received: from fallback25.i.mail.ru (fallback25.i.mail.ru [79.137.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081E6770F6;
	Mon, 29 Jul 2024 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285640; cv=none; b=a7KpGXXxC2QlBzSJCShzI16eTNH1X+Hri3/xq6SeaHI19gtpvnqYpPQ2TyhLgGW4man+JRVdj7QykNc9ClUWr60u6aGwfbyPkTE8iU4kc8xEeMxVdtZZ1bsUpJeJ5U/eMU4OLjSecZurmllY9iHiLs/jzNWBEmRiaJZMBWX7bIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285640; c=relaxed/simple;
	bh=2xGuj1EcnXJHjIihfjZNWPDE5gN8kfBrKuOY+513w/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNXIxjJ0FgZZK7vOkYTOqpiWQisO89ALSekGpcCSbivtkwlWbLlXhMEdu6Jp3XRCNhtFBUfPzem9UF6jbK03XkBmE00BdZTWNscdfSK4Ilml9KTVSDkSRgUfNEp4bVVGSLoXkwkcfvZeyBzpkDP34Kt2Rw4JUKogxQVe5qppitI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=QR8x3eKW; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=rhm/8nRp; arc=none smtp.client-ip=79.137.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=m4Ew8KrZrYKsUaKk3ZDy5i5wcTnnfA6ibh2GDmf++Q4=;
	t=1722285635;x=1722375635; 
	b=QR8x3eKWY9IqLqe+B9M4tWkuZgslNFc2IlxXzdfhGO2JDmCPxXvNRPsUuX4ss6V3FSZmHgeKO8HjVTyQOvJEOPymhMZmbVaTaP5SVaFnU7WSoqmLIg1gswgr6EIMOmkwt1TRw+Ub4egkPx+GeM519KzMV2Ne/97fnlmOGoVXQck=;
Received: from [10.12.4.4] (port=49848 helo=smtp16.i.mail.ru)
	by fallback25.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1sYWq9-00HJGv-Ba; Mon, 29 Jul 2024 23:19:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=m4Ew8KrZrYKsUaKk3ZDy5i5wcTnnfA6ibh2GDmf++Q4=; t=1722284369; x=1722374369; 
	b=rhm/8nRp9Sv6IAIgWm/RE/p8XC/boW/szdJT+FFrLY3ZEKssfcze9bkJz7Lb+39/dvRuZnq70le
	XByL8DMKmoNUkMkkN3DxpH7QZyu1kZgDO78vKVo3skzZt3zaDd4ZGipjYy3MY/fOZhO2XJvOJRcrW
	2lRtWuAySVch8NT3uf8=;
Received: by exim-smtp-868bf69f6c-8kchf with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sYWpf-00000000CoU-3MNQ; Mon, 29 Jul 2024 23:19:00 +0300
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
Subject: [PATCH 01/11] dt-bindings: arm: qcom,ids: Add IDs for SM7325 family
Date: Mon, 29 Jul 2024 23:18:08 +0300
Message-ID: <20240729201843.142918-2-danila@jiaxyga.com>
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
X-77F55803: 4F1203BC0FB41BD9000B6812E77BE1C65A930543BBC4734D0FBBE5E356D8E6EF182A05F538085040950A75D290E2C16F3DE06ABAFEAF670596622423B3054A419EC546CAE4A36CAC6C2BE0BE76D801B4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C2204D4F9A221771EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637968EC5F77C2942FE8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8B028AB9DD5109EF2580E18DF0DBB563DC38E727BDB8B55D9CC7F00164DA146DAFE8445B8C89999728AA50765F79006370277CA7F994D7EF5389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC821E93C0F2A571C7BF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CA6C7FFFE744CA7FB9735652A29929C6C4AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3A795DF33A22FB294BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE74F0F518E68DBD4F843847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A542E998A2BD83C9215002B1117B3ED696DA282D8F6061F1E4B74D9144D44E4FCF823CB91A9FED034534781492E4B8EEAD003C2D46C52F18F2C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFEED5208DB1ACF1AA1A6352E9FB21860AAE99D92905FF03A8BEE3C674A372843A257E6C4F5EEB673E67C7AAC6E25A208601960F90DC9714B9633D7FB3044967C2E7A874633C7B99BB61A41C79C593F3F002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6WpookEVvGCdA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949811F832B91E20AE7E29B464708D7791FD7AA3626E8081781B4359738D6C8F4BCA22C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B431B8944160407DD0C2EAA1E6BA7F9BE034EB9672DF358C7268F3CF0E9FE49B69543DADA4AE4E3247353B3A005E5413D96C61C261E32A59CD9729BAF73F2561CA
X-7FA49CB5: 0D63561A33F958A5B0996A7BCB441A3C5B256F73E931469BEC56E4AD89A49F858941B15DA834481FA18204E546F3947C809A55E64550A2B6F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637FC170453F675FFAC389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3C839A5C92C19B5C335872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6WD66ER7ctBxA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Add Qualcomm SM7325/SM7325P (yupik) SoC IDs.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 include/dt-bindings/arm/qcom,ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index d6c9e9472121..a4315872049e 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -234,11 +234,13 @@
 #define QCOM_ID_SA8540P			461
 #define QCOM_ID_QCM4290			469
 #define QCOM_ID_QCS4290			470
+#define QCOM_ID_SM7325			475
 #define QCOM_ID_SM8450_2		480
 #define QCOM_ID_SM8450_3		482
 #define QCOM_ID_SC7280			487
 #define QCOM_ID_SC7180P			495
 #define QCOM_ID_QCM6490			497
+#define QCOM_ID_SM7325P			499
 #define QCOM_ID_IPQ5000			503
 #define QCOM_ID_IPQ0509			504
 #define QCOM_ID_IPQ0518			505
-- 
2.45.2


