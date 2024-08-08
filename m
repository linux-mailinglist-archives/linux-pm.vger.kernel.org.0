Return-Path: <linux-pm+bounces-12009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39CD94C4A5
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 20:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993EE282E87
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 18:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0C515AAD6;
	Thu,  8 Aug 2024 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="tuRnX+Qa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [95.163.41.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93BD155335;
	Thu,  8 Aug 2024 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142500; cv=none; b=TkgicTqzi14kga2uKJlfPG1rvii81L4dnpR2nfHd/s+/HHPGvWL2Mdz8cIoa/erJ5DEB3dY3vLJZHpOGLRJNtCMyOStRuqoP5gEBaeBvymRqz5LQRKYQb6xHjGcqlkFXwwvy/nDecENHMc1yqqMdmxVKlFbl93tvjCeTVCcCxS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142500; c=relaxed/simple;
	bh=oqRrXJ8CUISiH0+6MUAgBYbuxSjpyVTzwmPq6LFtB1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoTu4x8Trdi/+ZHyHjgenO/70n929kCApI0F4iEwgeKc6oMyA3S1n9/emJVnI/G7QGm0cCOd/vJlPM+ZJx6E44R/htAmxXMt8A6nER1DGmhGxehuZz4Ijhzzj9U5RDAtYYxaZLjyNneCZo4b35Y0Teh2fk/jaaefXqal2DQgpC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=tuRnX+Qa; arc=none smtp.client-ip=95.163.41.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=3RWNEzgkflnEQObOJCO+U1GwMf2lZ3z9OpwwVDJJmOM=; t=1723142499; x=1723232499; 
	b=tuRnX+QaTd2750ZqLN3oQMINtWRrcGP3p4nfVkvQCu0GyKHwqNYCpMrRwm7ApY1YnBdtH+Fb+SD
	OonjId9gaiEUBT2CzXTPrKC7GNCY1ZX5wS2x46vipFvndS0rLeRmrKSVOwRYvrtLSkdpvuRz1hpzI
	PF6VTO2uQmu6veHzAlQ=;
Received: by smtp39.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sc84s-00000001fDW-1prM; Thu, 08 Aug 2024 21:41:34 +0300
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
Subject: [PATCH v2 06/11] dt-bindings: nfc: nxp,nci: Document PN553 compatible
Date: Thu,  8 Aug 2024 21:40:20 +0300
Message-ID: <20240808184048.63030-7-danila@jiaxyga.com>
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
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9D9DED0FED0530B21D5CEFA8193EAC1B119F3FFB6EDB7E89700894C459B0CD1B9464F0E7320E002DD3E60E583875EFAA40D5072B2037778FFB940E011F974308A60DFE2D95CBACD2B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7FFA2A8BF6367A61CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006377F69ABDCCC31D2058638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D823E3A2C365B6759F9889FB57C2C458C239C2F3C65CF289E1CC7F00164DA146DAFE8445B8C89999728AA50765F7900637323E1896550E62E4389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8989FD0BDF65E50FBF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CCF7CD7A0D5AA5F256136E347CC761E074AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3D54606DEFE0495C9BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE71D0063F52110EA4A731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5996FB29906ABFFB95002B1117B3ED696C4D43FF832913BF01BDDAE3D1EA49BEA823CB91A9FED034534781492E4B8EEADEF0AF71940E62277C79554A2A72441328621D336A7BC284946AD531847A6065AED8438A78DFE0A9EBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF723E2695F986872089382DE5864B1765F17D2871EE8926992063137CE92F37890505AA998FFA684F5CC6C73BB6D1AD53EEFBBE84FB8522D8A8EF8C92EF10C188E7A7A7C0859ECD61F3ED94C7A551C90002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojnAZp9Q+n/0NH0pkM0CidFQ==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981C177C7546926660105E38EDE555C2806BD37446300EF067EB7C1B598849540DF2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

The PN553 is another NFC chip from NXP, document the compatible in the
bindings.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml b/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
index 6924aff0b2c5..364b36151180 100644
--- a/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
@@ -17,6 +17,7 @@ properties:
           - enum:
               - nxp,nq310
               - nxp,pn547
+              - nxp,pn553
           - const: nxp,nxp-nci-i2c
 
   enable-gpios:
-- 
2.45.2


