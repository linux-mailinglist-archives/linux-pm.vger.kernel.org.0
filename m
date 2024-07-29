Return-Path: <linux-pm+bounces-11590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AF193FF2F
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 22:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C12FCB230E1
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 20:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327F518FDCF;
	Mon, 29 Jul 2024 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="bsxHU3Qu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="ldW0s8/n"
X-Original-To: linux-pm@vger.kernel.org
Received: from fallback16.i.mail.ru (fallback16.i.mail.ru [79.137.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0E18C329;
	Mon, 29 Jul 2024 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284381; cv=none; b=mE8Cs+fsIvzLmCMAqWI5+aB9OzYui5Jrko1Zm9parvJRvyngtDfm9tAHzv7tz2Pyu+WgSYAqJy7vYWrwBvT6udp9N25h58CHgaLmvZcqGAN8ezsy5f1yEvSZgzg4tvfvITJoj2MopAlDE8Ru5SPiqTpRQC9vTWWWGgoehbztG+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284381; c=relaxed/simple;
	bh=GX6sZvLOYNXwusGjbDmdIkRv5/Xrvolop0/vZl+O8oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpJZuifmzWXWsVqyauUB8uUjh6V9pw5BibxOGUPxWtKwD6/y939uFpvYqY6WhitNK3OwPOJ1pu3Ta/K2ni3SllJW8bFGZh3p5j8uBvbN78udIw2ZHkMnbE9irGQBP1+OD/bO9NsnYCX5RNcQo0ipp0QqdTVCML3uCoChnQUhLUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=bsxHU3Qu; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=ldW0s8/n; arc=none smtp.client-ip=79.137.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=w8s+h2YWMx2A67bmuuiwKB8nWQpU/wTSazZJjHAgZfw=;
	t=1722284379;x=1722374379; 
	b=bsxHU3Qu68rjEhLueN/C5JXVhuqgFygqc4FhbCSh7K/5YpujApTJU6739H54sGJrnZ+Pr3gTA3iE4nVo7Qmr3hXT5GsM9OV2gOAkF0cH5fzGv5CWuJw3DcKJJJkAbr+3uZqZnUoF52nyuRz4CkuGV3OPb2HvlCBUPJux0aXhJuE=;
Received: from [10.12.4.33] (port=55868 helo=smtp58.i.mail.ru)
	by fallback16.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1sYWqA-002EwT-Rs; Mon, 29 Jul 2024 23:19:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=w8s+h2YWMx2A67bmuuiwKB8nWQpU/wTSazZJjHAgZfw=; t=1722284370; x=1722374370; 
	b=ldW0s8/ntQeFr+i3H/fjXi+yy+g3MyUA9+EiUdufPUx+G9TUstlsDGS82fmHlpLCPed/pVWXQTq
	z5Zy4HwB1UB0f9s560GLAfrumGEYWClKJi0BLRfc1c3SVpA/pyta1xmgpCQnzrQ2gzNiicCtQXl6E
	gqfsyighUnfu09DX0jU=;
Received: by exim-smtp-868bf69f6c-8kchf with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sYWpu-00000000CoU-1Bg7; Mon, 29 Jul 2024 23:19:14 +0300
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
Subject: [PATCH 03/11] cpufreq: Add SM7325 to cpufreq-dt-platdev blocklist
Date: Mon, 29 Jul 2024 23:18:10 +0300
Message-ID: <20240729201843.142918-4-danila@jiaxyga.com>
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
X-77F55803: 4F1203BC0FB41BD9000B6812E77BE1C65D76B8F852291B0932227566A3E75779182A05F5380850400671ED386D6E1AF33DE06ABAFEAF670534D889C79A50E07B9EC546CAE4A36CAC9FE7245B80CF8774
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE71BDE6A359BD5B800EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F91103FA893F53AB8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8A53B3A4CE6281CDD580E18DF0DBB563DEBEDA402DE8CF99BCC7F00164DA146DAFE8445B8C89999728AA50765F790063741F7343E26298569389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC813BDA61BF53F5E1DF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C4B6F6234D9065C9703F1AB874ED890284AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C351CCD24836465D6CBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE74F0F518E68DBD4F843847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A57D50CBF3688615FD5002B1117B3ED696B453289E73FC88C3C66B2B37046EC955823CB91A9FED034534781492E4B8EEADEF0AF71940E62277C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFB63DA0EC3E08BAAD8E4D86D1BB9933729FA001A3BC0254E18012222FDB6C519E7BCAC92FCA26627067C7AAC6E25A208673F50144DEE87964633D7FB3044967C2840EB95E96F56A2E61A41C79C593F3F002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6U4m+wxJbpzmQ==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949811F832B91E20AE7E2A7CF1FCFAF80C0E921946DC0BA1AC5EB61E42B65DC7B31912C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B431B8944160407DD0C32ECD32B9294E2344D2BBFF7BBF02C868F3CF0E9FE49B69543DADA4AE4E32477CF2D6E7B0005BEC4843A3A9402B03493FF2F5CF96BAC7D2
X-7FA49CB5: 0D63561A33F958A5EA8405C63B72C8A3AFE9EEFC5FE380D2C16E91E0A76270938941B15DA834481FA18204E546F3947C809A55E64550A2B6F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637FC170453F675FFAC389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3C839A5C92C19B5C335872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6UkGLrFapLOdg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

The Qualcomm SM7325 platform uses the qcom-cpufreq-hw driver, so add
it to the cpufreq-dt-platdev driver's blocklist.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
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


