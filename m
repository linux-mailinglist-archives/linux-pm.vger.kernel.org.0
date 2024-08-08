Return-Path: <linux-pm+bounces-12007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B3894C49B
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 20:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC6628246B
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 18:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38D014F9FB;
	Thu,  8 Aug 2024 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="v46zc7or"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [95.163.41.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DDC14A08E;
	Thu,  8 Aug 2024 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142488; cv=none; b=iFA5cpn3C1rGTLEF2/QoalX3jxVIxLP104+NQDYbBJwjP5sgwDbBnQ1gpiIHyQ3MO746T5Pnf3hhdSNTeWDYuxPquSwiPOOfewzBZ/Y1/MWOHj743ViwwhqsiQZJzIapSRMRTygJAadQ1hXfUhuWxw3G/UUneb8VJ99BZtIEWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142488; c=relaxed/simple;
	bh=8bsRBwdfINbKKcJE1UpIyJQT0MqVMdCtqdZLwH572Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOHRfaJIDa8csRGYjWlhQd/DeOGn/oYSO6tCHC3UkZaf9pybUc197IXp409xeeQJApaSYlTcdUVG2hMPVkiIZcPvYrL7FJSifZh8IQLr10o1vXoErrd91+DlgsRH5KxgYThKE8/FqECrX6aNXiVzTJ1Qfs0EEu3ZMCo0LRexvrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=v46zc7or; arc=none smtp.client-ip=95.163.41.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=LzXmoVVtzEbB/DrqleyHfJ1WFP32Reu/fwsT6W9+6tQ=; t=1723142487; x=1723232487; 
	b=v46zc7oridI4SgrUEPHzb7zz+XFIPFSeoFJE0xPHF0FspCrmnfj/xMHNV5r2ZukvqSsZnJ9A29F
	8OygnVDfAZ4Yg6E2+653CvBq5eQyqUqnXIYT1m5enUA2JkfbOwOkf0Pv6wMGU2oG4QU67veOFzRyL
	hnAUOjYVj0xS8XKwHKQ=;
Received: by smtp39.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sc84g-00000001fDW-220j; Thu, 08 Aug 2024 21:41:22 +0300
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
Subject: [PATCH v2 04/11] soc: qcom: pd_mapper: Add SM7325 compatible
Date: Thu,  8 Aug 2024 21:40:18 +0300
Message-ID: <20240808184048.63030-5-danila@jiaxyga.com>
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
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9D9DED0FED0530B21DEF104963D1327227D064FC465F3DC1300894C459B0CD1B921CEA001C38A77CC3E60E583875EFAA40D45EC7D9FC4BF9EB940E011F974308A35AA1534FA60CA86
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C2204D4F9A221771EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637FACF2191C0719DEE8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D837688F81326EDA299889FB57C2C458C2BE334A99029F1FB1CC7F00164DA146DAFE8445B8C89999728AA50765F790063706586D6E6283AEAE389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC878444BBB7636F62AF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CE3786DD2C77EBDAA6E0066C2D8992A164AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3832E772DE64BCD96BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE71D0063F52110EA4A731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5375AB1E57F1BA0AC5002B1117B3ED696DF836F546510B023108A05421C070DB8823CB91A9FED034534781492E4B8EEADB0A1B66E9F5C9ED4C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF2DBED0220F6EE3011B8DB5075FE19121D3D786899F62960711C5E0FA74D11D240E472C501BDE4CA35CC6C73BB6D1AD539DAE4E514125F707A8EF8C92EF10C188BFACD0FF1D135AB2F3ED94C7A551C90002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojnAZp9Q+n/0MSCCL/LbtrqA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981C177C75469266601EDE2FBCE1621770ABDF670BAE3BCE9C254311C67670C54C02C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

The Qualcomm SM7325 platform is identical to SC7280, so add
compatibility leading to SC7280.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/soc/qcom/qcom_pd_mapper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/qcom_pd_mapper.c b/drivers/soc/qcom/qcom_pd_mapper.c
index 9afa09c3920e..e8a881977e73 100644
--- a/drivers/soc/qcom/qcom_pd_mapper.c
+++ b/drivers/soc/qcom/qcom_pd_mapper.c
@@ -539,6 +539,7 @@ static const struct of_device_id qcom_pdm_domains[] __maybe_unused = {
 	{ .compatible = "qcom,sm4250", .data = sm6115_domains, },
 	{ .compatible = "qcom,sm6115", .data = sm6115_domains, },
 	{ .compatible = "qcom,sm6350", .data = sm6350_domains, },
+	{ .compatible = "qcom,sm7325", .data = sc7280_domains, },
 	{ .compatible = "qcom,sm8150", .data = sm8150_domains, },
 	{ .compatible = "qcom,sm8250", .data = sm8250_domains, },
 	{ .compatible = "qcom,sm8350", .data = sm8350_domains, },
-- 
2.45.2


