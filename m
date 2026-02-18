Return-Path: <linux-pm+bounces-42827-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFKTIYsClmnQYAIAu9opvQ
	(envelope-from <linux-pm+bounces-42827-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:18:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDC8158A62
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4BD23021E92
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 18:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48CB346A01;
	Wed, 18 Feb 2026 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQ8wRE/R"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8812130AABC;
	Wed, 18 Feb 2026 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438581; cv=none; b=Z1NoDQSnDbC+GyoBd6UDfOV37RDk4mfz/iXmUOMRxjgQymB3KH43thAzVjaybxRCNJzzOuRJA4Xt86/B+h+IaAALm7J13HGxwjTvwA++1HkrkbRQIZdWyWssPVSPtxOrvfeVK705tjb/ZhVplOIrk16MeAPqOdSWCZNq6bNQWtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438581; c=relaxed/simple;
	bh=a05snlq6Y0wUIyGYFKz6Aof2Ecgn10TWqXHZr/LmJdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WkhCECHEm253U4BkwtwthYy1fyUvxjGzgvzCE/babTX4zv6v03pnHuBrgf1vdL4eTG3hF7JuD8FIX386rgX2mbOiQtMacJgVnPVcDsDH2T5stroLHF69m9kqJXGdg5pUiXqVORPbFd83BcGnVOYx18T7vuDiyh9nwmXjV6s/pfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQ8wRE/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32E9FC19423;
	Wed, 18 Feb 2026 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771438581;
	bh=a05snlq6Y0wUIyGYFKz6Aof2Ecgn10TWqXHZr/LmJdY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HQ8wRE/RY7DBOnZ4s5mPPRQ5bsbEfPXEZZ54USKtr9Rv30O5X91c7Q5SCCrdPAcq3
	 w0bL5VOnL8uPYQ4OA5taFgWxcAHkPZ4YkI6ztS7vQVoZ50HLXhFVoy597l73l2S+Hb
	 gwgtU97LDPODGPIzME6AtDJGvsEXWsb3RR6u0ptP+kIwkVn9M+tX+XlKEDRR+WxCZC
	 FEga0uSlip/ozYFtcTjFQSRXU/4nJz95ZJCioopaZIAYR6obzCyCF5PCazjo/3KZ0d
	 k3XiKKniy8Hv5yRuQ+bXJBtQpvdh+bGfuSh50M7ooaX/zpK93z6E0nYsRT4kfG1ZSo
	 2nvrK55j50MyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D32FE9A047;
	Wed, 18 Feb 2026 18:16:21 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Wed, 18 Feb 2026 12:16:18 -0600
Subject: [PATCH v2 1/3] dt-bindings: interconnect: OSM L3: Document sm8550
 OSM L3 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-sm8550-ddr-bw-scaling-v2-1-43a2b6d47e70@gmail.com>
References: <20260218-sm8550-ddr-bw-scaling-v2-0-43a2b6d47e70@gmail.com>
In-Reply-To: <20260218-sm8550-ddr-bw-scaling-v2-0-43a2b6d47e70@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771438580; l=897;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=QL4QtlV1mkUECwvUyM6TwRVGqKLGQYeQGpH9Y7qGjM4=;
 b=MPZfDr/vlSXG8c8OTZEeBIXBCkRI2FikGcYjpKZttCkgoRZKuTJvHcMR3TxO6VYE541zP1+Sf
 1WvZfT1x9X8BYvMHwqTXPxTKA87bD1fieyQE4o0JFog/aEpNqvd2kPK
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42827-lists,linux-pm=lfdr.de,webgeek1234.gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[webgeek1234@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BDC8158A62
X-Rspamd-Action: no action

From: Aaron Kling <webgeek1234@gmail.com>

Document the OSM L3 found in the Qualcomm SM8550 platform.

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



