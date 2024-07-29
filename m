Return-Path: <linux-pm+bounces-11592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14A593FF3E
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 22:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116A11C221AD
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 20:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8FE19148A;
	Mon, 29 Jul 2024 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="pLZi3eI0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="Xwez3yuA"
X-Original-To: linux-pm@vger.kernel.org
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807A419067C;
	Mon, 29 Jul 2024 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284389; cv=none; b=QKrcopDWhY3Ktlxb1KfDsissDpnOW2z2aLqVYTq4xsy1kapJVzgp47+R+S7lnx4QIIwkXQHsG0N35Rlrzhdg5rkuXxEdHdzYYe4LtZKnpllQ90wDsjRYG9LAnursd+rVBrmJcm0OvcAzgBlTcCXnuE5jEvChGkcuzCW8B9/F+8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284389; c=relaxed/simple;
	bh=4skDM4cZKteaFphz5UjAYnUr3Js0sWfC1ePFXs6d/Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOS4mPQ6QrnWfrdINpSyALNDCKu1jF93oNFC8QjI526zrlkAC5E/c+6/Lzhe3e3pds2Q8PcSMZjfs5uj21DXG4yMlPErD2emDCR92Chom755KGVnPlDEtTUF43djyAs6zU09eyhbIff6ZGNMZ/1VfHkWPoDwBQgGQ19U2Q3R2ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=pLZi3eI0; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=Xwez3yuA; arc=none smtp.client-ip=79.137.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=5QV0a7682nIdzUgd4l67a/WU1FPc1gaPaAhSUwmPni8=;
	t=1722284386;x=1722374386; 
	b=pLZi3eI0raQtsHbVmkXmR5D8pPtOyrqZdUqmBDMxliILhhF8KxOnj3WGUuDYOWZNfeHwWBxqUa3FRDdgo6HLbdbgJ8B2FSy4dX+KxtusAAoDJBpbLhy2fJdlOE0dk438mjTQblIglLplD+hTK5Uj6oykN57uuJh7MK69RF/cmyg=;
Received: from [10.12.4.18] (port=47134 helo=smtp45.i.mail.ru)
	by fallback1.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1sYWqO-00GbIU-0X; Mon, 29 Jul 2024 23:19:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=5QV0a7682nIdzUgd4l67a/WU1FPc1gaPaAhSUwmPni8=; t=1722284384; x=1722374384; 
	b=Xwez3yuA+sPk8c4W3g/FiG9+B+4N6kH0V8V/fpy25qqXdJ1msxPSaVHziHe4YORPcVwdzD+cEHY
	NIw7Hi2C6SR8NNkHzu2ySc/Dn1nES0/kZmNBzYq4oEusgvckfqxxj97d2/MLiu7a0Vb6JD8hMjJHL
	cGVdSYY4FOAKNC1J9r4=;
Received: by exim-smtp-868bf69f6c-8kchf with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sYWq8-00000000CoU-305T; Mon, 29 Jul 2024 23:19:29 +0300
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
Subject: [PATCH 05/11] dt-bindings: soc: qcom: qcom,pmic-glink: Document SM7325 compatible
Date: Mon, 29 Jul 2024 23:18:12 +0300
Message-ID: <20240729201843.142918-6-danila@jiaxyga.com>
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
X-77F55803: 4F1203BC0FB41BD9000B6812E77BE1C69019ECFFCCC204324D7BC83486271641182A05F538085040E84017C5D64C4D9A3DE06ABAFEAF67058F58DECD4AF701019EC546CAE4A36CAC3F8282B6C5816065
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE789805A6418246A1AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637A431CDDF496E6E598638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D87DF262F7A4DA1D9E580E18DF0DBB563D92A37EF0C9067899CC7F00164DA146DAFE8445B8C89999728AA50765F7900637F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F3E38EE449E3E2AE389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F79006379377B17FF374FFEDD81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE7B00C92F7EC6501DCEC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3517C622C16A6DF10089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A591B612254AA1B9035002B1117B3ED696C523F4857C499278484B8D70797403F6823CB91A9FED034534781492E4B8EEAD4ADCFBF7921B375DC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFF87FC13C188F2B35447E83094460B13515268536C7B2ADA49B65818A12189CC78135B9CF208C7BB767C7AAC6E25A20862BC028D7102BBEC0633D7FB3044967C22AFC29A6032C8B6E61A41C79C593F3F002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6WD66ER7ctBxA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981FAF4174D7AEDC04E77EA6416FFE467E1650BF0761E83A37351667BCF41A0F1F82C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B431B8944160407DD0B313328ABEDFD6F43944198D198D480C68F3CF0E9FE49B69543DADA4AE4E32472AD9B6174BF198F64120EA31CD276964CAB1E22A1027C9A2
X-7FA49CB5: 0D63561A33F958A589A97B8FF2519659B47A220D724E664E0F90543A656763D78941B15DA834481FA18204E546F3947CA09ADEE969FA4D8BF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637CCCC50C392BEB6A4389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3B43B7A57207DBF0735872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6UNqRPXTTQTsw==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Document the SM7325 compatible used to describe the pmic glink on this
platform.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 4512390f90f0..02c37c3137d2 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -26,6 +26,7 @@ properties:
               - qcom,qcm6490-pmic-glink
               - qcom,sc8180x-pmic-glink
               - qcom,sc8280xp-pmic-glink
+              - qcom,sm7325-pmic-glink
               - qcom,sm8350-pmic-glink
               - qcom,sm8450-pmic-glink
               - qcom,sm8550-pmic-glink
-- 
2.45.2


