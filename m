Return-Path: <linux-pm+bounces-11594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BAF93FF4C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 22:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76F91F21E75
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 20:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2E418D4AF;
	Mon, 29 Jul 2024 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="hULJhNaj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp47.i.mail.ru (smtp47.i.mail.ru [95.163.41.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2D1891C3;
	Mon, 29 Jul 2024 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284406; cv=none; b=OD9MfU4mqV1OvF5MmGwC9enrqtl5YboI2fQVU9GZKUD+OFwYCTKM+C6HNa3RWTuA5bC1LxDvH2NZKtJrSDB6wWPtaCCJCi2RLYLhLjHmpt+ly+qcSft4xMgdtuOdf6kVTCup/g3RNQvzlh0kk13JbABtEMXzACYmUbOCHHTue4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284406; c=relaxed/simple;
	bh=jmTidnUbo0ritnqtIrNaINZ3ZwgiBt/JxGFYb22/rLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVNkFFKo2xwgZDSx8LCaWzIE/B5EENvHcjaieFz+f7hVi/lN3twK9HRhdzW22vNNAJ4wdxy2+LjScUVx2ooyi/bYM2V8X04kObwLyibukeVPokkrTpzWNFhMXbIeDmAa7iMgIEu5Tp3wW9+nm5W0GF1KkKgJ8RHurr8NlLFXEmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=hULJhNaj; arc=none smtp.client-ip=95.163.41.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=V6zEkutVaauIyOW52lBwswvvCpyZWKyLHApPr3RVpZk=; t=1722284404; x=1722374404; 
	b=hULJhNajd0jp99EKlKksvgvjbpQ/2pYWqYOlnofJowxBSbGZ5ir0MvbaWop4iNmHw2rvbePA9xM
	Ej+6WmepTwSya+wgK1jX3c8jbkiTiUBCr8QSwtTx+dab0VsdwoGGbz6O1ebGLWFG29VcA+0cNFPCY
	R2g9K2czds2+ufzBWMQ=;
Received: by exim-smtp-868bf69f6c-8kchf with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sYWqd-00000000CoU-18sS; Mon, 29 Jul 2024 23:19:59 +0300
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
Subject: [PATCH 09/11] dt-bindings: vendor-prefixes: Add Nothing Technology Limited
Date: Mon, 29 Jul 2024 23:18:16 +0300
Message-ID: <20240729201843.142918-10-danila@jiaxyga.com>
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
Authentication-Results: exim-smtp-868bf69f6c-8kchf; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9000B6812E77BE1C65A930543BBC4734D041C3986E7C2C1D2182A05F538085040E81C17C53CF485E13DE06ABAFEAF67055D0A22D2A060F7079EC546CAE4A36CAC784ED878CF4C7D9C
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F65C230EDDCD559EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006378957B77C126D2D948638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D85AE5ABF81521A345580E18DF0DBB563DB82EE30546E9DAF8CC7F00164DA146DAFE8445B8C89999728AA50765F7900637AD6569683AD07375389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC89E541A154B51D14BF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C4B1E592663965C8B2D242C3BD2E3F4C64AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3376A2C75177259C1BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7BEE702378D8A34C7731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A53710E06A7BF8ADAB5002B1117B3ED69642EDF317E2A7959E1E49B01306B5E3AD823CB91A9FED034534781492E4B8EEADC24E78AA85F86F6CC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF096CAC60B9597205E649F6DABB4B7A1DD8A31A5D3438E252F4B1C36BAE171A24963129249CAA680A67C7AAC6E25A208617684771FA5A780C633D7FB3044967C2EB1CC2378804A6D561A41C79C593F3F002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6WpK1qe+RMVFw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981FAF4174D7AEDC04ECE7DA15FCD53A2210882EBA1432D171A332F9F1AE3C7D1D92C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Add entry for Nothing Technology Limited (https://nl.nothing.tech/)

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a70ce43b3dc0..b50c6080424b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1041,6 +1041,8 @@ patternProperties:
     description: Nokia
   "^nordic,.*":
     description: Nordic Semiconductor
+  "^nothing,.*":
+    description: Nothing Technology Limited
   "^novatek,.*":
     description: Novatek
   "^novtech,.*":
-- 
2.45.2


