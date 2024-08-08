Return-Path: <linux-pm+bounces-12010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735B194C4AD
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 20:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF83288D37
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 18:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5C415ECF9;
	Thu,  8 Aug 2024 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="xydEJmJw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [95.163.41.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F549479;
	Thu,  8 Aug 2024 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142506; cv=none; b=AEPJTjcW84EM9/KZENwA4fQQHVGPfsRdEdCPytUDVBSQ8br0haqLv9HS5VBHEtwjNdrDgURWl1L38YkgepHA2srChe058qpMcEuWzTr6CT9rUcls/Cy4fmv4rU+gQFl6sveAr8gtzUahZNbqal1VXytA/nMnEFFok0+cSrcv5xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142506; c=relaxed/simple;
	bh=2ZWqKQ+dIlBUSw4cwANo+Jvw2mfuZwMqmJOo2QoPaBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=us2/DuRj7txsf1Ao7qKSauAz56d+HJRsSw/j9/dV4MTSllbgUEqT49VNZwFhbTCZjA/t5cQd+BKtPoWAIv9+hGiUdFZ2FayL91X0SgKQ9czWACQNJLEWlY8MODf7EHt/fK3EqLvWCocaE3hpqrUV3B5HRVtY50mIN+rJfCxq0u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=xydEJmJw; arc=none smtp.client-ip=95.163.41.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=fcPS/y75B6ghgCrjZ4wEZ/bP4lAIstuMDrzb4BHoEYM=; t=1723142505; x=1723232505; 
	b=xydEJmJwsQ5I6qOMTayMJsMq7vywpUY7oX8sLqVq81DUw/U1BxhwOYNXF2t9vxAKiASRK7Ymnkp
	30vmx0yKS/FxGAMHoA710nTBW2NZPOH7+rmfwrjTmGnqVNxwhZvInbp/SYeUgXBsGIr0dybOL0vwd
	zhC6jCW/2d0H07++OuM=;
Received: by smtp39.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sc84y-00000001fDW-38bE; Thu, 08 Aug 2024 21:41:41 +0300
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
Subject: [PATCH v2 07/11] dt-bindings: arm: cpus: Add qcom kryo670 compatible
Date: Thu,  8 Aug 2024 21:40:21 +0300
Message-ID: <20240808184048.63030-8-danila@jiaxyga.com>
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
X-77F55803: 4F1203BC0FB41BD9D9DED0FED0530B21D5CEFA8193EAC1B119F3FFB6EDB7E89700894C459B0CD1B949F0A42799AA32FF3E60E583875EFAA469D05BBB2321F7F7C5D9A4B825735016BC2FBDE9E7577831
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70B8ADF238913687CB287FD4696A6DC2FA8DF7F3B2552694A4E2F5AFA99E116B42401471946AA11AF23F8577A6DFFEA7C05B79473340BE8368F08D7030A58E5AD1A62830130A00468AEEEE3FBA3A834EE7353EFBB553375665BD9920017B18EC94EAC5D3BDA2D0251E0DD7CE86BC5F090C8C534E2F5DFBEE2389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0ADE7667AABD2F12D8941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6E954A0C70C50C109CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C22498DCC26588BACB72876E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B7C51812D886B32CE3AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E7352629B07FD02F83A6C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A51C46FD735E32C7095002B1117B3ED6961F49FFFD108ABD74E772F934B9BCD185823CB91A9FED034534781492E4B8EEADADEF88395FA75C5FC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF8CEB2581FFB9850CA00F7C413A6573FA6D07940BC6CB85BF1F43566B97DE296EA8F268452FA2DF715CC6C73BB6D1AD5302BF4B3475FCF236A8EF8C92EF10C1881142287FA664D0FB5218470B7D3CD69A02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojnAZp9Q+n/0OJEvKXU/PsEQ==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981C177C754692666010B9BF4F79351F757F22A937B5A3C214C75AA50C825F1FF3B2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

The Qualcomm Snapdragon 778G/778G+/780G/782G uses CPUs named Kryo 670.
Add the compatible string in the documentation.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


