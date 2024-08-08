Return-Path: <linux-pm+bounces-12013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE7C94C4BD
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 20:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3851D1F2839D
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 18:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B29A1586DB;
	Thu,  8 Aug 2024 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="CWmoONqy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [95.163.41.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723A6156F3F;
	Thu,  8 Aug 2024 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142528; cv=none; b=au3TkDvBS6E8lOCVGd6DUttzyM6gKHLRpCYrh04gzd0okVneWtHt7i2NnNkdjuduAfVTrKzoGrg9MGMCfwAuaZBJzaDMZrty7vzPCM1P3AlClM7F7Md6GUM8BYvMUZO0mkAxCMQv8or1qIhq8FRyQGCOHIVplnz8qv8ujTupYA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142528; c=relaxed/simple;
	bh=X+u5WG+Td2fYLPhAKFLaM5WHEY+rMXvkosaXie+Z52g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmssQAOOrUaw1twakoWRxQTM2aeFzSU8cnG1/vacs7rsXe4nzwGiafoUhQ1w2leKNG++UrbYaLA5VLemB2EJDiD2jTCuCz+lHMCDJVzGqCqh5jLbsLAcdwOwmpVlJkToLptbu0l4lQw7JOoFDsa+9yTOrjt+z3PVi/9BstsJwj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=CWmoONqy; arc=none smtp.client-ip=95.163.41.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=mNKAMhaJO30l6wjuFGsVe9p07yv7pN41/KYYTksJ94k=; t=1723142526; x=1723232526; 
	b=CWmoONqy7wsEHwmrb/Z2i+In8hBCjAOHhoWERHablu6+zLMVIizW65RsdwwBQDW97t0OrZDG1nk
	dWiTOA5SJE8RJpoLk3fpGdoeq7DK4/R7w3Zxx3IQOTGlN+65qEGGmSnGqBj1acCQkqmshlrlky5Ya
	o1V5Jb9E2UzbRddZWMI=;
Received: by smtp39.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sc85J-00000001fDW-1MN2; Thu, 08 Aug 2024 21:42:02 +0300
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
	Danila Tikhonov <danila@jiaxyga.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 10/11] dt-bindings: arm: qcom: Add SM7325 Nothing Phone 1
Date: Thu,  8 Aug 2024 21:40:24 +0300
Message-ID: <20240808184048.63030-11-danila@jiaxyga.com>
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
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9D9DED0FED0530B213292B666DFB78E8227A37E5D37071C0700894C459B0CD1B92F9E722CB67397043E60E583875EFAA4437C5C447D4CCA0EC5D9A4B825735016B92CE970A8DCB349
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE74ABD1465354149F7EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063726CA83C7ABDB938E8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8FB2A57BFEC02F5B89889FB57C2C458C24060DD37578E69FFCC7F00164DA146DAFE8445B8C89999728AA50765F7900637AD6569683AD07375389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC80839144E5BB460BAF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CDA7BFA4571439BB2AD7EC71F1DB884274AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C30F1327A8DDF03E57BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6D082881546D9349175ECD9A6C639B01B78DA827A17800CE7D699F3A2029486C7731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5512EC0880C9A1BB85002B1117B3ED6967E4EC9C20FEAD2A5E99897350C7C491E823CB91A9FED034534781492E4B8EEAD2B25D9E4C92BC8ACC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF09AA364616DE276E6D643006C7A8724CC894D7139EF7ED7C993AD4A64E37CA66182FB9261F6240E85CC6C73BB6D1AD53DB4D75DB244C7FC1A8EF8C92EF10C1886DA63E0195D1AAC55218470B7D3CD69A02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojnAZp9Q+n/0NizRHzsVHFHQ==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981A52D9F19D561BC9E364022C9811FBA4E86DD105C723F0302452E44D03157C12C2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Nothing Phone 1 (nothing,spacewar) is a smartphone based on the SM7325
SoC.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 4ef456cefd6c..ea7b51740e64 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -76,6 +76,7 @@ description: |
         sm6375
         sm7125
         sm7225
+        sm7325
         sm8150
         sm8250
         sm8350
@@ -988,6 +989,11 @@ properties:
               - fairphone,fp4
           - const: qcom,sm7225
 
+      - items:
+          - enum:
+              - nothing,spacewar
+          - const: qcom,sm7325
+
       - items:
           - enum:
               - microsoft,surface-duo
-- 
2.45.2


