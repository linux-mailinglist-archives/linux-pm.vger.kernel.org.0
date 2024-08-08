Return-Path: <linux-pm+bounces-12015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D79594C500
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 21:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8465B223A3
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 19:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54267146A9B;
	Thu,  8 Aug 2024 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="z7vUqXfG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="OXLq62fL"
X-Original-To: linux-pm@vger.kernel.org
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3473398E;
	Thu,  8 Aug 2024 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143684; cv=none; b=t4HxzOXearHthEcI5XCp7KtuQqqW+91/n28Mg4wCZG1OtTD7tgVOyzsP/Yb+FXvSU8yEVn7QWGhotG1exvhdkT8DAxV7AfoFKZUnZl1dpFbqjvLLiTXLw2A18iE1F7f9sex+G7G8bMa1oi/CfVHPt2LYyaVYaF7eGCVTJGyL+bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143684; c=relaxed/simple;
	bh=HyYuyzJUShtLfpdlVkv6OnZ4cDF9ONZfxh9KIPr6BYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHTqFvUzqtxp+baPeTQG5/9g6oj2tLj7wCStmvaMpkO9Q52/NOm4JM8RID7eArWcKvEU2FRM1xUZg3E+2RAkS9EiIwUfP0WJeQXuvmmGNM0MnaPxsKNJv4ack/gQmKaPs8qjIxTIdk6VHFe8Kf5yHM1WPAG1Cowwd3aLP7Ve8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=z7vUqXfG; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=OXLq62fL; arc=none smtp.client-ip=79.137.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=m+3nk6YEu4yEB7y330lXwS+SNLOx2xkYXN7EsA5vzyM=;
	t=1723143682;x=1723233682; 
	b=z7vUqXfG0Zc7Mm5ER71w5jzpIyVD2iNGgopuqnw76zr2HaypqmaemGIZw5aalSSE1dTETSXUlowwPJaFzCEtIJfopriUIDf7SjxaM5Ut8XnWtQ3pS+5Q9lYZarZ7Lbs5xskuSLBtNOXJiNh9DF4XPpXNIKemRXtSQsQ881WqbYI=;
Received: from [10.12.4.14] (port=57036 helo=smtp39.i.mail.ru)
	by fallback1.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1sc84h-00ETRX-Lr; Thu, 08 Aug 2024 21:41:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=m+3nk6YEu4yEB7y330lXwS+SNLOx2xkYXN7EsA5vzyM=; t=1723142483; x=1723232483; 
	b=OXLq62fL/eFQ/qpT5Eu7aF+0xTQ56/sdALcI/hFu9UcXB18msZbWBEmBkNsEvsMb832mENINbT4
	Dm2hPhI55GlyE0SqI+dPPNrgVKGfZZHJ0G36Km297ed/pp6VF8VsU6IznYrN9pL9TDpYV+aJT7jfL
	YT6jQepMerOmRQQKNGs=;
Received: by smtp39.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sc84O-00000001fDW-0KEt; Thu, 08 Aug 2024 21:41:04 +0300
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
Subject: [PATCH v2 01/11] dt-bindings: arm: qcom,ids: Add IDs for SM7325 family
Date: Thu,  8 Aug 2024 21:40:15 +0300
Message-ID: <20240808184048.63030-2-danila@jiaxyga.com>
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
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9D9DED0FED0530B21D5CEFA8193EAC1B119F3FFB6EDB7E89700894C459B0CD1B985D9F43B46AB494F3E60E583875EFAA4248991B65DA0A463B940E011F974308ADBBA668AFD329EE4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72F22E6DC541F75D9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AB1265E79AFCDEF58638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8216FCEC48F2B4CCA9889FB57C2C458C272C67C5A1C27ED72CC7F00164DA146DAFE8445B8C89999728AA50765F7900637E5FAC37A846F0F679FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C362968DCAA3E4B45B117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF0E6BD793C670A4DDBA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B68DCC26588BACB72876E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7C0B02670E5FEECA50C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5B3E6D3FFB57480535002B1117B3ED696BF1F1D988BE72C2519AC5B239BAD4335823CB91A9FED034534781492E4B8EEAD5DF1C2DF01CE7211C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF9CCA36FF7621B92EB426B62AC12617D0B3E00B0FFBBEC1EF8C2D2BD8A79B0A6FB0F06D2F9487D0FC5CC6C73BB6D1AD53C5ACB3EB9DBF26EDA8EF8C92EF10C18856AED59392FB10865218470B7D3CD69A02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojnAZp9Q+n/0MVR+tgRlZRhw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981C177C7546926660195D4C5B18C328FC0B7DCF6CD6D068E44DBF63CD049736B9A2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B407A8A08320DA9DA2781ED034E45463FA69D8F21B1C5167D468F3CF0E9FE49B6992E62AFD1D37EAB811896E53ED2BB1F2432A6D8A0ADDE0805224FA8928AFF2A5
X-7FA49CB5: 0D63561A33F958A5C7EEE58D32ABA9778F2740ADEB9D3D074A521D9EF4FF2D8C8941B15DA834481FA18204E546F3947CBCE93E57B23BAFF2F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637716746CC581C57CD389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3BAD564E72A87595935872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojnAZp9Q+n/0NRrV02IvJBCA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Add Qualcomm SM7325/SM7325P (yupik) SoC IDs.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/arm/qcom,ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index d6c9e9472121..a4315872049e 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -234,11 +234,13 @@
 #define QCOM_ID_SA8540P			461
 #define QCOM_ID_QCM4290			469
 #define QCOM_ID_QCS4290			470
+#define QCOM_ID_SM7325			475
 #define QCOM_ID_SM8450_2		480
 #define QCOM_ID_SM8450_3		482
 #define QCOM_ID_SC7280			487
 #define QCOM_ID_SC7180P			495
 #define QCOM_ID_QCM6490			497
+#define QCOM_ID_SM7325P			499
 #define QCOM_ID_IPQ5000			503
 #define QCOM_ID_IPQ0509			504
 #define QCOM_ID_IPQ0518			505
-- 
2.45.2


