Return-Path: <linux-pm+bounces-42008-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EjMM/h7gmnAVQMAu9opvQ
	(envelope-from <linux-pm+bounces-42008-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 23:51:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D62ADF611
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 23:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DE2430A916D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 22:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54136A03A;
	Tue,  3 Feb 2026 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwcq5ALi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE4D2E2DF3;
	Tue,  3 Feb 2026 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159076; cv=none; b=OjsFQ6SHYU37sgWJ4x5avL00QcYABmNp8DGzyYywUjbodxToJbJHOAoGZ150H7nL3bpSGKcZkZ3eme0MdhD6P1l7zMJSP9nW2NvtkkNqsizosDiCAytjd8ZAacOK6O9wCWVv989yGyoHxHz+c+ES0p8kgBFOdpqXCGhXI7mGpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159076; c=relaxed/simple;
	bh=X91nXiYbk2aQj3hTKjb9O56r5Vxnbn/eV6DtlpDzA8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sPcPoekdt48NU4MdNuF5DIuQsnd1VjlrO+BkAhkr/Lmh8ir5r4ws2CKZ/DR089TB6DHEojrpnPUj3ZkuGjqLAPcVv2jh9FGbm62zM3OiqM0agToTtCQ1jA0yPr6V6TgILHCsPgsk0pRs4e/8hY5VZo+ZARq5beiMuFZU0REI5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwcq5ALi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23749C2BC9E;
	Tue,  3 Feb 2026 22:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770159076;
	bh=X91nXiYbk2aQj3hTKjb9O56r5Vxnbn/eV6DtlpDzA8Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lwcq5ALiB+OesFqKvXvjJGqKqOTw5MtaYfUki/k4eFuthqEyuvSoTwvoqLWGQ+0v7
	 u07J0Fgx31qXN6MzMuwBdyX8B1fITA+/O4SL1j9sfDdDM2FUZlIreRmp1RVcV2eFGh
	 ZTPaNlVwfkqK9L3vZ7Z18oVXwLj5uYRzaiSmcJ5gUgpjbRZRBfR8CCwl3awcG/UBtu
	 QRJbA4rkqVQ6mjFm5QLmiMWmXpFocLYQH0/PHKkBWSHVUU2Ry+MBqO8K2qWI9u1+d/
	 XEFiv3Yv0eqS5Jp+Rzmz60PjwTH9cEqKhY2F8gKmCpaV8TxtMFgu/AABq0DnYhtpBN
	 +VI+1oXB3UAwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB35E8B37C;
	Tue,  3 Feb 2026 22:51:16 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Tue, 03 Feb 2026 22:50:28 +0000
Subject: [PATCH v5 2/5] dt-bindings: usb: maxim,max33359: Add supply
 property for vbus
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-max77759-charger-v5-2-b50395376a5f@google.com>
References: <20260203-max77759-charger-v5-0-b50395376a5f@google.com>
In-Reply-To: <20260203-max77759-charger-v5-0-b50395376a5f@google.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770159074; l=1332;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=qjOKPP6fH2LqYd2U1uPm5o7hj5uICSO7E5/ipdyMADM=;
 b=YRz56XUmrW3hJ51fTWbWJBHEqUxLf7rdB7vONG+KoIlUJ8W8akgzcJXY0QXf54c+pH+jBIDy2
 CDY4TPj5s5eDzwPGwhEvnMjjvC6bE1TlkXiH/eA7dBLZyQ8xmGXakvC
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42008-lists,linux-pm=lfdr.de,amitsd.google.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[amitsd@google.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D62ADF611
X-Rspamd-Action: no action

From: Amit Sunil Dhamne <amitsd@google.com>

Add a regulator supply property for vbus. This notifies the regulator
provider to source vbus when Type-C operates in Source power mode,
while turn off sourcing vbus when operating in Sink mode or
disconnected.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
index 3de4dc40b79192b60443421b557bd2fb18683bf7..e652a24902eac93396fc61281cc9e2cb1d37a390 100644
--- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
+++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
@@ -32,6 +32,9 @@ properties:
     description:
       Properties for usb c connector.
 
+  vbus-supply:
+    description: Regulator to control sourcing Vbus.
+
 required:
   - compatible
   - reg
@@ -53,6 +56,7 @@ examples:
             reg = <0x25>;
             interrupt-parent = <&gpa8>;
             interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+            vbus-supply = <&chgin_otg_reg>;
 
             connector {
                 compatible = "usb-c-connector";

-- 
2.53.0.rc2.204.g2597b5adb4-goog



