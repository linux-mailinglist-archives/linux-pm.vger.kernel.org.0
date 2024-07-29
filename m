Return-Path: <linux-pm+bounces-11593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B8793FF44
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 22:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1269B22A2D
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 20:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CCA191F7E;
	Mon, 29 Jul 2024 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="aVMasQIR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp44.i.mail.ru (smtp44.i.mail.ru [95.163.41.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0DE19069B;
	Mon, 29 Jul 2024 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284390; cv=none; b=Kq71MlBx4J67uBozkAA9Z1xNB+4apg0A2khVXvCixWgF+6FxZrvnlcuOgjD4cunGqLOQXInIiY3KR8g239s2htfkyteCs/ak+oTAk6+6836OQ71IzBlmV+92Tl1JNr4qWwpYe7XL2GCGCTSoaZWwfj6ZcOU4m9MmOsKK5/SJw2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284390; c=relaxed/simple;
	bh=ROyarofGDQN8cJSpjcdklmHoCrjXccBsQaET0Ua+uRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOzqNULZVw3BFnFRINkaUlUpouti+Ef3haf23zGMxO2GPJ6j6GQbqp6WQp0ZmFMpoYDV4eoJVtFCCbUIe+GeXRa4ZW/eJR6cc8Nbs3k3ka2ym4RnYPjrZJxdewvos0ErzoBPZO2CRQAb5aITxyRQtuhVETG2BTx/M6Krnn4pLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=aVMasQIR; arc=none smtp.client-ip=95.163.41.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=9dKk+8pAddrkyIDI2QVr8ilPWUd22AmwrS/Irw3Olx8=; t=1722284388; x=1722374388; 
	b=aVMasQIRRIVWwjuQaz8nylbjx5yQIA+XjYlMPSKBORmP22jAV+JY8Bh9LYXbxAXB9/nUCtRj9Mh
	oSA3MWTFaWcaJ1zE7f8GST4QW+f4L2nUNVcsE7cHUC9A3rmLR2A6NNXtt96I8legFgwnxrgiZoQsT
	CTDgiWwwtRM65EscqBM=;
Received: by exim-smtp-868bf69f6c-8kchf with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sYWqO-00000000CoU-0heU; Mon, 29 Jul 2024 23:19:44 +0300
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
Subject: [PATCH 07/11] dt-bindings: arm: cpus: Add qcom kryo670 compatible
Date: Mon, 29 Jul 2024 23:18:14 +0300
Message-ID: <20240729201843.142918-8-danila@jiaxyga.com>
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
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9000B6812E77BE1C6854AF46E97D2152892C6A59DA105ADB3182A05F53808504034B40D4108C2ED383DE06ABAFEAF67058ECC5E4F9F563CD79EC546CAE4A36CACDC39866218C5191E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C579B1C3ABE6C709C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7F35A5D86BDFCC4EDEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B043BF0FB74779F360FD453A066BEF4E6FAF42C0DC8CB880F9C307324BB7D1BC8A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE7820CF4CC0E318EFB9FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3BD39A56654533F91117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CFFF9AE5E544BDEAB7BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B627A44A7985839C7B76E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7C5B09DCDDD98ABCD243847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A589A97B8FF25196595002B1117B3ED696DABB3F7B9C3FFFE892212597CCBD6D77823CB91A9FED034534781492E4B8EEAD6A17C1D737525568C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFEB3E8DBEE632BC0D540E1E5E7EFFDD8FB1B31E7D224F0995822A127798DA005D025CA78FE36D225767C7AAC6E25A2086D7203E0889132D45633D7FB3044967C256A56A05F9888EAC61A41C79C593F3F002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6UNqRPXTTQTsw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981FAF4174D7AEDC04E95D4C5B18C328FC04E19D9FE6830EF030CCEAF700ACC610F2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

The Qualcomm Snapdragon 778G/778G+/780G/782G uses CPUs named Kryo 670.
Add the compatible string in the documentation.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index f308ff6c3532..2bf9501b3b0d 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -202,6 +202,7 @@ properties:
       - qcom,kryo560
       - qcom,kryo570
       - qcom,kryo660
+      - qcom,kryo670
       - qcom,kryo685
       - qcom,kryo780
       - qcom,oryon
-- 
2.45.2


