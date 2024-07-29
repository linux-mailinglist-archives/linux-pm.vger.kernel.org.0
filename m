Return-Path: <linux-pm+bounces-11588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE64093FF22
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 22:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E247F1C2254D
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 20:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80EB18F2FF;
	Mon, 29 Jul 2024 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="e8K2pUDQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="Am9580LH"
X-Original-To: linux-pm@vger.kernel.org
Received: from fallback16.i.mail.ru (fallback16.i.mail.ru [79.137.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB0818F2EB;
	Mon, 29 Jul 2024 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284378; cv=none; b=eThByjLQqYgZlKoM107EVN1AtisvQQSYIyvqKUSIT7rBuBaB0hRg0CkMfupHi8SVSCJGGc7XdcMteY3vLjAc1ixT8cv+PCtGwiu1oU4ldsuuIRPvi/f/Dzq3ZbWSvMVO8ZlNGL8I+GqALybpLwlugFAeGJ4ENlGj5LdFxW+LxPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284378; c=relaxed/simple;
	bh=02zmu4QGqEIJ9BZlLAlY9ysjTaK07RL+tKCwmB+40+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olGWGFhqsopSdtI1SO/pEbeThwMGeER8T+y0VzFw2NuSfrVrCA4tFQKjC70N3LMu7BVD5bLr8F1V6MZv//gJNYoQUcSW9HHIeRqDf53nxBeVxjk6jh2vjEsFzYCYJgJ44dO/DnNR1JIv/v1vLIGuXrI4Xg15XlyxIOsRv3+C1Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=e8K2pUDQ; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=Am9580LH; arc=none smtp.client-ip=79.137.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=xMFsu2kH/oDLzBeUKz4QeUQTwOlMOGENjz2MGaejVzg=;
	t=1722284376;x=1722374376; 
	b=e8K2pUDQ2AM7PTvOQ/F4a3diCf2mGjoqPTEsHBLOf2d70sMWOEc/sInN4gk8pN2eH1kaYR+X9zKcuQNusYu5CGVTHzdQOD0qtKD/zw4a2CaIWfCJS1ZrxhWkiwUpcowDBeHy7ApTsmmHPpELpE/Ch/RRzdR2bZ8S+7lIBpER440=;
Received: from [10.12.4.14] (port=54164 helo=smtp39.i.mail.ru)
	by fallback16.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1sYWq8-002EvE-7I; Mon, 29 Jul 2024 23:19:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=xMFsu2kH/oDLzBeUKz4QeUQTwOlMOGENjz2MGaejVzg=; t=1722284368; x=1722374368; 
	b=Am9580LHkwQKGL6MdFghiYYsJ//Pa+o+H2NxAC2XxtqUEH4h0xWPBwSGs9zNvgj6vITFTDsSy4t
	DACrD9yi1VmvdHNCudBrGIQdeoIrbvx/teDd2gCGb1fmPdum1Qu+G/CnOQnB73veQNZaIRC3rcaxW
	n2bPZn93cOr94EmLFwo=;
Received: by exim-smtp-868bf69f6c-8kchf with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sYWpm-00000000CoU-41yt; Mon, 29 Jul 2024 23:19:07 +0300
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
Subject: [PATCH 02/11] soc: qcom: socinfo: Add Soc IDs for SM7325 family
Date: Mon, 29 Jul 2024 23:18:09 +0300
Message-ID: <20240729201843.142918-3-danila@jiaxyga.com>
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
X-77F55803: 4F1203BC0FB41BD9000B6812E77BE1C6854AF46E97D2152892C6A59DA105ADB3182A05F538085040B8ABAA5C580993D83DE06ABAFEAF6705954007E54438538B9EC546CAE4A36CAC16B5ACA2CA2E2F10
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE716FAD50E497B9C14EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637E16D8B060A9A23898638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8AFAA5D22035B4804580E18DF0DBB563DBA77BF50F16291B7CC7F00164DA146DAFE8445B8C89999728AA50765F7900637D0FEED2715E18529389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8B861051D4BA689FCF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C4B6F6234D9065C976E0066C2D8992A164AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C302DEEDFCC97348C4BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE74F0F518E68DBD4F843847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5EFA8F4968A493E435002B1117B3ED696256586B6C84C5F8319AC5B239BAD4335823CB91A9FED034534781492E4B8EEAD220496FFA5CD4785C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF524F6EC23856C4E0875A53886354E6736C0578DFD32527A35C66AE413C21C3ECD917AD9EEFBA970E67C7AAC6E25A2086C15A8E95E874BBCD633D7FB3044967C2BC71DB4567420C8061A41C79C593F3F002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6VEtr452/yI2Q==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949811F832B91E20AE7E24825860F061DF21452521A2B93C10F15113C06E07DA8AC682C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B431B8944160407DD0B313328ABEDFD6F43944198D198D480C68F3CF0E9FE49B69543DADA4AE4E3247B4326F77E427F336479B2EAC155EFDE2DD6EEBEDD7AC8187
X-7FA49CB5: 0D63561A33F958A591B612254AA1B903E77F14220E91F7D53D055AAF7A6EEE438941B15DA834481FA18204E546F3947CAD7102AF51AFB197F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063794CA976D7634B470389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3C839A5C92C19B5C335872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6WIFy39HdQshA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Add Soc ID table entries for Qualcomm SM7325 family.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/soc/qcom/socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index d7359a235e3c..f4e5f7a62206 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -401,11 +401,13 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SA8540P) },
 	{ qcom_board_id(QCM4290) },
 	{ qcom_board_id(QCS4290) },
+	{ qcom_board_id(SM7325) },
 	{ qcom_board_id_named(SM8450_2, "SM8450") },
 	{ qcom_board_id_named(SM8450_3, "SM8450") },
 	{ qcom_board_id(SC7280) },
 	{ qcom_board_id(SC7180P) },
 	{ qcom_board_id(QCM6490) },
+	{ qcom_board_id(SM7325P) },
 	{ qcom_board_id(IPQ5000) },
 	{ qcom_board_id(IPQ0509) },
 	{ qcom_board_id(IPQ0518) },
-- 
2.45.2


