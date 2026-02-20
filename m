Return-Path: <linux-pm+bounces-42902-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDh5KBzel2mp9gIAu9opvQ
	(envelope-from <linux-pm+bounces-42902-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 05:07:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A913164775
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 05:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E39513007BA1
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 04:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CED82F39A7;
	Fri, 20 Feb 2026 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLYKULV2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4AA280329;
	Fri, 20 Feb 2026 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560471; cv=none; b=CsWdov0eQYCculIXivcWd8qFNZD/c1yimb4ylNg1FFZGleoSkRA+6B7hqaHqX+6d5e0VWsVVXyMsmiFdYbz7uIYea8liA3haOK08Eww35BIERnrrd8FyygApS3T6drZm6H1wK4WFTKKYfAajHn7IEcRuGW5UnGE53s/5GmMONHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560471; c=relaxed/simple;
	bh=d3BMFHQQ7Wm5U1K7f4Js78tuhSsi2nCUMZJpy2YaTb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GACEESQLaFawIIGkIXGw4+RVT/bfjkvR08yG5Dw84KBPGu8jfhvTD2F6Wi5+kyvo+15W4y5AD/Mwu61A+NLT9KG4CQajk2RUHopCt/GmdlfzdRszHeNzps0h/uNFDOUJBAhaRqrlXyv+ibswZRZ9iMyPFStmalt6JPbeKSBeWtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLYKULV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9134CC19424;
	Fri, 20 Feb 2026 04:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560470;
	bh=d3BMFHQQ7Wm5U1K7f4Js78tuhSsi2nCUMZJpy2YaTb8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FLYKULV20UHWcQl9K92rImoIIOWkoJr9Bq1LTuaNMbxvr116Fes8A7x8sBDb1XYw1
	 OGoqndlWn2pjiHY57JfBldBFoAHvB8rUSXM777FLqdJwkzlEtYSULJEj7nDVxWOyjN
	 PkXUV1/0HMHoYbyE/pK7Kjto2vY/AjV13DzQE9/P+twoDr4jsSG7QA0bSsL3UoYFO9
	 xhX05hlFMp8klAJNLD6B9ewQ1DCt68sgFAInf0xSPfcEM4IjRBq92LAwmyTBEuhKTS
	 1lbJ9/gkJRauDyoNsOAnUDT1A38nnqoZtWKVkKW12e3OpuDNMSYt+27bsUw5St/fSY
	 EfLzWFt/q+VWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE5BC531E4;
	Fri, 20 Feb 2026 04:07:50 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 19 Feb 2026 22:07:39 -0600
Subject: [PATCH v3 1/2] dt-bindings: interconnect: OSM L3: Document sm8550
 OSM L3 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-sm8550-ddr-bw-scaling-v3-1-75c19152e921@gmail.com>
References: <20260219-sm8550-ddr-bw-scaling-v3-0-75c19152e921@gmail.com>
In-Reply-To: <20260219-sm8550-ddr-bw-scaling-v3-0-75c19152e921@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771560469; l=967;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=mS8M/OvCSyCfH2FPOESQBHGwPnDgZXk2BMAopHCtTqQ=;
 b=RhWnrH18WLVa+J8yF9CdvqHnkwgxX4ZUsl8GrEPH5ECxH908m89IrCg+QGufUTt/UyK7BWVOf
 gEhMmRW8XdSACIp3jeAnszkaEjQBHpqpJdYDscokC0e84Byj2Amyir2
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42902-lists,linux-pm=lfdr.de,webgeek1234.gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,oss.qualcomm.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[webgeek1234@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A913164775
X-Rspamd-Action: no action

From: Aaron Kling <webgeek1234@gmail.com>

Document the OSM L3 found in the Qualcomm SM8550 platform.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 4b9b98fbe8f22258c209e8337bb4517e5f5888e8..3cbe2c3701f77d5d70082092043f2b2ccbd64905 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -34,6 +34,7 @@ properties:
               - qcom,sm6375-cpucp-l3
               - qcom,sm8250-epss-l3
               - qcom,sm8350-epss-l3
+              - qcom,sm8550-epss-l3
               - qcom,sm8650-epss-l3
           - const: qcom,epss-l3
       - items:

-- 
2.52.0



