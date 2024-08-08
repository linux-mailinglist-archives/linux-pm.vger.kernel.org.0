Return-Path: <linux-pm+bounces-12012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8166A94C4B8
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 20:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FE61C255FF
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 18:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6591649A8;
	Thu,  8 Aug 2024 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="W0sz8CEm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [95.163.41.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2976A149E0E;
	Thu,  8 Aug 2024 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142520; cv=none; b=fhMRq3bBu1lHeht5cKG8T1+6Rb4ri4MR9m66yYlhlNJdhLS9sAQV5ybT3vUDlXrmugsqlvcYc6QtrWjEUC4N+Q8G7fn0tKQYcvLRQdx4JbszWn+3hr9KqCYTq1kuUKBC74H0Z6zDU6zQC0p5Nek8EaiZ7f/g4+vITZEdl8gk2aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142520; c=relaxed/simple;
	bh=1XLYndXBqM02MFxgRDHO3eEZqeGZBLBFuUk50LRsZIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHtS8OmajNnDAurywDEEtE0NqpP8RBdyp8EY2K6AvJLTWR85OpGzBeSd2NeRexchI5X8w87xNWYkrkeeRQrEvq+WbA3OkJpys8N9FF/hVLENLla0utH6xGvN57reXVEA55ZSjRtOnC6c2Ib1fN4sn8LMu4xqj0KWMTISe4Zrv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=W0sz8CEm; arc=none smtp.client-ip=95.163.41.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=0NtHuzKZvaV7Gk1EsMZW4DBPbGqvfabnlLcHlGeso3M=; t=1723142519; x=1723232519; 
	b=W0sz8CEmX5estPJJmaH1bEWvq+RHZrIrzrfV5loAzF0Qh5iheSlg7JVnwoW5V0WpoLz2jGC2Kb+
	tfkEVGG04LmijfS/Hj3TJfr43h+ZXxyePxZMadGL71f/Uwoc5FkHFh+f6xF/6QptvY+AEMdxTdgF4
	s3D6UoegUFl/0lA3LdU=;
Received: by smtp39.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sc85C-00000001fDW-3Oz6; Thu, 08 Aug 2024 21:41:55 +0300
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
Subject: [PATCH v2 09/11] dt-bindings: vendor-prefixes: Add Nothing Technology Limited
Date: Thu,  8 Aug 2024 21:40:23 +0300
Message-ID: <20240808184048.63030-10-danila@jiaxyga.com>
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
X-77F55803: 4F1203BC0FB41BD9D9DED0FED0530B21D5CEFA8193EAC1B119F3FFB6EDB7E89700894C459B0CD1B91ACC7882E291640C3E60E583875EFAA450133DDA9523467EC5D9A4B825735016406EA159844E9C80
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7BC08626EA5717D14EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637CE6693660FA336BEEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B043BF0FB74779F36C60406EC290EF6DCF890E47D01697F567168D70E4AD04A67A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE79FEEBCD9E13F050E9FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3ECBEDCEC3CCF9A28117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF9DB465A7E1668C9BBA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B66EEF3AC259A6E0D676E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249D082881546D93491E827F84554CEF50127C277FBC8AE2E8BF1175FABE1C0F9B6AAAE862A0553A39223F8577A6DFFEA7CDDB9BF3B882869D543847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A58A056814E1438F815002B1117B3ED6962567EB64F38A6D197E0012C66AE17B00823CB91A9FED034534781492E4B8EEAD4ECBDE8281F904F9C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFD8189080F3CFBCFEBB7F65DD2847B325BFB93628550028F143555362380DCB10F6452569441AF3645CC6C73BB6D1AD535E83FCD9AA6E3A00A8EF8C92EF10C188C6E2B09D10CCE3BA5218470B7D3CD69A02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojnAZp9Q+n/0N8Cp9ZASaT0A==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981A52D9F19D561BC9E1F93A76BF6F7B0A6BC232D2356491C803CE571DCCFE0A2B32C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Add entry for Nothing Technology Limited (https://nothing.tech/)

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 12033629595a..6f4133e0c604 100644
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


