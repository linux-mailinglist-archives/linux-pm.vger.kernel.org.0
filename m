Return-Path: <linux-pm+bounces-11600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B847493FF94
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 22:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D618E1C22845
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 20:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC88D1891B8;
	Mon, 29 Jul 2024 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="S2VUT3yF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="eMUChc4n"
X-Original-To: linux-pm@vger.kernel.org
Received: from fallback20.i.mail.ru (fallback20.i.mail.ru [79.137.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DD712E1CA;
	Mon, 29 Jul 2024 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285303; cv=none; b=UhRum1+PxvtUPdKh77/AziNQ3nhN0IYTUwKwwxurR6dRMGNM29LYMhgSCe2PttkwOnyV0vREWMMVTEhxlvDZi7WQiBuL356wWhVNWb1//6IEBFBbF9Be8lLXmsOb+rneFnITCzyAJntUyVqd0Gr4THdBxoRLXHRUMbjfB+JnVEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285303; c=relaxed/simple;
	bh=GdbCW8yfs7NU4Ath3sI9bWpx8oN5qfhos7iiIICwEkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sgpra+QViWe+sR2tV4WXUhOv8w7GYMDubFEqMkP04JPfQaArn42FtU/lg/vk5kuc1GbFmB+1JspWeRPsYwBOrapzjYCabt+vGiUKZ+QEmV6WoiMEdsZU3woJki3M23tO+py1xNn8i95BEkyypLyB1lx6a/LTS1sTPg26GSwnOG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=S2VUT3yF; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=eMUChc4n; arc=none smtp.client-ip=79.137.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=PRwFNUCW6HLzjmYD6OmkiUMz1f6/t3zFdmxJHB+Zzek=;
	t=1722285301;x=1722375301; 
	b=S2VUT3yF+v2WzkzHPNtnWtqq9jfC3jO5syau11BPT9Eso6f/QKbLAyu7+3uuURcGv6gbBr3WLJLCvUEqcLy5nCmOmAZHT45D+uIUr9qgwheCmTODccdyLisC2tG5B2lNZFigQs8OkwT3+qOCbQABWDwftawL6ax9ud9pqjALcwg=;
Received: from [10.12.4.7] (port=47502 helo=smtp33.i.mail.ru)
	by fallback20.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1sYWqU-008rYT-5i; Mon, 29 Jul 2024 23:19:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=PRwFNUCW6HLzjmYD6OmkiUMz1f6/t3zFdmxJHB+Zzek=; t=1722284390; x=1722374390; 
	b=eMUChc4ntuaI8bZTM13VZlyHxfEDFjwD0nQzZqiVR++P4MCOhKyemPDFWwrKeP7lPJp2c/2rQik
	x0OEIvRjGFgXrRVXva7llJPBx6WPWHts0E5dacfyaWREt/IVMEzfy2FM0JGZtW/kHTjCTBysrJOAa
	f/NkrA5MBRiaQvp5UH4=;
Received: by exim-smtp-868bf69f6c-8kchf with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sYWqG-00000000CoU-2AwV; Mon, 29 Jul 2024 23:19:36 +0300
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
Subject: [PATCH 06/11] usb: typec: ucsi: Add qcom,sm7325-pmic-glink as needing PDOS quirk
Date: Mon, 29 Jul 2024 23:18:13 +0300
Message-ID: <20240729201843.142918-7-danila@jiaxyga.com>
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
X-77F55803: 4F1203BC0FB41BD9000B6812E77BE1C6854AF46E97D2152892C6A59DA105ADB3182A05F53808504056D9A8BA6CE25AB83DE06ABAFEAF6705D5E8CE795B9E2A679EC546CAE4A36CACE41C5801A3FD0B27
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72F22E6DC541F75D9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006373D58C44ED3182E498638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8EE98B1FEF21BC586580E18DF0DBB563D0AE5DD95BB4D8FBACC7F00164DA146DAFE8445B8C89999728AA50765F790063773DCDF0198120BE8389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8744B801E316CB65FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C4B6F6234D9065C9703F1AB874ED890284AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C351CCD24836465D6CBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7CD707F342D9BDC98731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5C51AE974FFC8727E5002B1117B3ED69640D8B7EDAF6397385B6221DB6D7A72AD823CB91A9FED034534781492E4B8EEAD2B25D9E4C92BC8ACC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF12CB06653A7A692481EAE084A2A9EA7ACF204439F4020EF3366D572410DCF7786E47D229C2E76ED467C7AAC6E25A2086A6122B4070C61B59633D7FB3044967C26EB9446556239C2761A41C79C593F3F002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6UWSwoxnQ2Vdg==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981FAF4174D7AEDC04E91CF6C6A8F7D6EF668F95DE10021557FF36D9822101B95872C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B431B8944160407DD060012FAD082D5410A9D1C5B4D1E7A14468F3CF0E9FE49B69543DADA4AE4E324721ED5EF4A8E8E4C767E18FDC5BEC4521BFD86A0102466338
X-7FA49CB5: 0D63561A33F958A56F9DEE02FD3D0B3E0A7ABB603960FF4F2E899DE97C0F60208941B15DA834481FA18204E546F3947CEBAEFC6015046CFCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063749305D2801D13566389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C337AFB176E5F8DA0635872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6WsSBIyas9nJQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

The SM7325 Linux Android firmware needs this workaround as well. Add it
to the list.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 16c328497e0b..80fb04473617 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -294,6 +294,7 @@ static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
 	{ .compatible = "qcom,qcm6490-pmic-glink", .data = &quirk_sc8280xp, },
 	{ .compatible = "qcom,sc8180x-pmic-glink", .data = &quirk_sc8180x, },
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = &quirk_sc8280xp, },
+	{ .compatible = "qcom,sm7325-pmic-glink", .data = &quirk_sc8280xp, },
 	{ .compatible = "qcom,sm8350-pmic-glink", .data = &quirk_sc8180x, },
 	{ .compatible = "qcom,sm8450-pmic-glink", .data = &quirk_sm8450, },
 	{ .compatible = "qcom,sm8550-pmic-glink", .data = &quirk_sm8450, },
-- 
2.45.2


