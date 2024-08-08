Return-Path: <linux-pm+bounces-12006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F5694C495
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 20:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BEA71C22A04
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 18:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E13F155A59;
	Thu,  8 Aug 2024 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="H1vbDPCJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [95.163.41.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F51553A2;
	Thu,  8 Aug 2024 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142483; cv=none; b=n+TWx9TlR3st1MX7DWeB1/0iYotjIizglXHzCYrP2yEkzCvmpbGWz5KLoE9sLG2lMIhQZkpYYQxjkqrQEbvUmob4cfuAmg4ck7q8pGaoHFRvQx0Goi039TtzHNO3m7RoVo4DzdyohZmUYdrokrKBStPp3uCSbcm9TNPsSWnhA9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142483; c=relaxed/simple;
	bh=msDKE+qf1eRBcr6z2PkhNT9cnjYmM8rqpU30V5OqHX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eqn/C9cLjib2xBoBGUwN7Z6uu1sioFZEfF7K80A78DUfaajo/pch38YIPIzKDLVp3rMHarYn83ZjcDkT/auU7007XT867MO8/SfG9AFfYiEPSF3Pu1Eo3CIAwYx0ZJh2QbZKmJCYqtouOedyCMZQQYK3ApyED12RzO3vMtVPiD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=H1vbDPCJ; arc=none smtp.client-ip=95.163.41.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=XPix6KdciMNJaMC6hZiqUINQtwxQR6ZmOXUpHQ2getM=; t=1723142481; x=1723232481; 
	b=H1vbDPCJO0Df3QW1TRLoyaNjUdyz+JOVdt7JWmoJPdNHaFOxKeA/i8cIQHNTvW+ppPncdWiZvqq
	lMjfi6Ba/G2xsYJjs5w1fdPtexGpofSB8brscbsxTl2DtkUdcpTxT4V+3Q86WqLPtzUuTnob14dQU
	uBEw6Wd7BBQ2YIt3YwQ=;
Received: by smtp39.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sc84a-00000001fDW-3kET; Thu, 08 Aug 2024 21:41:17 +0300
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
Subject: [PATCH v2 03/11] cpufreq: Add SM7325 to cpufreq-dt-platdev blocklist
Date: Thu,  8 Aug 2024 21:40:17 +0300
Message-ID: <20240808184048.63030-4-danila@jiaxyga.com>
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
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9E801DC166143581E863B19F466B9B6CBEADD4E4D2E713AEF182A05F5380850404C228DA9ACA6FE27EEE104B4AAF274029487ABAC94A94B54616A30358A7541FBB8412F9ACF21FEA2EEE6E0A67F8F2F94
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE763424119D34F5CBFEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063786F1F539FBE87B778638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8A2222D78241F672C9889FB57C2C458C2F82BC0DA4F7DB292CC7F00164DA146DAFE8445B8C89999728AA50765F79006370BDD70ABAC747F53389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8A816C540FC8EEC30F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CE3786DD2C77EBDAA6E0066C2D8992A164AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3832E772DE64BCD96BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE77DCDFB3399A2F72843847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A51C8695C7E8195D255002B1117B3ED6968AD1E0EFBCE699A6484B8D70797403F6823CB91A9FED034534781492E4B8EEADADEF88395FA75C5FC79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF8FA5AD84F764879363DAF7F892F7AA4D132C993D388DF06EFA9FE4A6AF475F4716D5D591715857EC5CC6C73BB6D1AD53CBE820ED61AD2325A8EF8C92EF10C188936C70B3FCF9FD5EF3ED94C7A551C90002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojnAZp9Q+n/0P5aSIup4S9tg==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981C177C7546926660187A35C9C7BBE74BEF86BF60A0EBE2C226CD0D2698B4FD55B2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

The Qualcomm SM7325 platform uses the qcom-cpufreq-hw driver, so add
it to the cpufreq-dt-platdev driver's blocklist.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index cac379ba006d..18942bfe9c95 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -166,6 +166,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sm6350", },
 	{ .compatible = "qcom,sm6375", },
 	{ .compatible = "qcom,sm7225", },
+	{ .compatible = "qcom,sm7325", },
 	{ .compatible = "qcom,sm8150", },
 	{ .compatible = "qcom,sm8250", },
 	{ .compatible = "qcom,sm8350", },
-- 
2.45.2


