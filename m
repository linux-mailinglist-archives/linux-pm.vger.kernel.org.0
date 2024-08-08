Return-Path: <linux-pm+bounces-12008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8779D94C4A0
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 20:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C4B288BD7
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 18:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD0F158DDD;
	Thu,  8 Aug 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="j7OJFMVX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [95.163.41.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5ED15350B;
	Thu,  8 Aug 2024 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142494; cv=none; b=rqe2EcnQEyE/5EjFY6EksHj8n7ppFAkf5k52x7fI8xo057YpFBBaiezfdBwoAQ35R6V4N3RYLoE7mTlGXe4F1SBYRTnigigtTl7teGJv5dQ7l/SAQO4DEtZbmVoye6C65kZumy5c8nm8ORXF3L4I2N56vLoVufUfbAP5qhcUwB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142494; c=relaxed/simple;
	bh=tH6J7ZrbOS+iKupyOxU+CUkltyoadmFP0RdvNc7tphc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQSc5AmfVBpB/4aaj+WvuoMqyk+9zYO43DN7opGjbd8rMKnDCVAg8lCM71tglHu/x4FQqs1Gzs5KtYOG+MJwzq3r6jFpRvFW3yzGIcOsHmuFWwIx9EPulWI660u9ErDOAoXECjeo0MoEIh+lPIe0wAI4ovmMYl/1uaQYLNUOCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=j7OJFMVX; arc=none smtp.client-ip=95.163.41.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=onwwrJHtlLia9J6z4xZR7OTS7xIwrBFZ20zq9AEUUvw=; t=1723142492; x=1723232492; 
	b=j7OJFMVXJACq9Z5fKEqsWTbt4xIV8j4bCnKz16mL3y44vrnstyjlFQnByTiRqaFrryyGX0EiWwP
	Rw7ryitbUkGgyIntLFNc0bCA1mn6Ii6om0kHBBTvoi1QDiXKL2pYrA2bQQsWG5Pd7S9ADmVJJgHKa
	/EIN796xSNjxhq5nIkg=;
Received: by smtp39.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sc84m-00000001fDW-19M0; Thu, 08 Aug 2024 21:41:28 +0300
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
Subject: [PATCH v2 05/11] dt-bindings: soc: qcom: qcom,pmic-glink: Document SM7325 compatible
Date: Thu,  8 Aug 2024 21:40:19 +0300
Message-ID: <20240808184048.63030-6-danila@jiaxyga.com>
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
X-77F55803: 4F1203BC0FB41BD9D9DED0FED0530B21E99D4A78A7C7A01591FF82C61940A2B700894C459B0CD1B99FD0A5C016C6F4813E60E583875EFAA478F2584431C07ABCB940E011F974308A4C6784DEA8096F07
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7370F4F695FFFC24BEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006379428F6EA0D091379EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B043BF0FB74779F36DB154CE132E0834CF890E47D01697F561A269424625208ADA471835C12D1D9774AD6D5ED66289B5278DA827A17800CE7ECE82AE7387CF2AD9FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3E478A468B35FE767117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF6804EF05EF4ADF2A3AA81AA40904B5D9CF19DD082D7633A0C84D3B47A649675F3AA81AA40904B5D98AA50765F7900637EF1F32DBCCB8E3DECD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B658CDF7FFE3EBBCC0089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5F890E6E9140F61065002B1117B3ED696A68F4817F676A94D4869453249F34FA4823CB91A9FED034534781492E4B8EEAD528DE7AA5F2BD788C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF693DC40D190BCBCF394932D1BE7238B66D949360FE73BD93B803E75D6A7E91EB1EB2640544212C895CC6C73BB6D1AD5361A7CFE52EB4E1B7A8EF8C92EF10C188DE10B1B5F89DDD1CF3ED94C7A551C90002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojnAZp9Q+n/0Mbmc8e34QHJA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981C177C754692666014825860F061DF2146B5C970B38829161D833FFD16BC388C32C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

The SM7325 is the closest SoC to the QCM6490 and is also identical
to the SC7280. The SM7325 also requires both UCSI_NO_PARTNER_PDOS &
UCSI_DELAY_DEVICE_PDOS quirks.

Document the PMIC GLINK firmware interface on the SM7325 Platform
by using the QCM6490 bindings as fallback.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 4512390f90f0..2d3fe0b54243 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -30,6 +30,11 @@ properties:
               - qcom,sm8450-pmic-glink
               - qcom,sm8550-pmic-glink
           - const: qcom,pmic-glink
+      - items:
+          - enum:
+              - qcom,sm7325-pmic-glink
+          - const: qcom,qcm6490-pmic-glink
+          - const: qcom,pmic-glink
       - items:
           - enum:
               - qcom,sm8650-pmic-glink
-- 
2.45.2


