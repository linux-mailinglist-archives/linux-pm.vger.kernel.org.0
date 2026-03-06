Return-Path: <linux-pm+bounces-43747-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zcRuJxiFqmkdTAEAu9opvQ
	(envelope-from <linux-pm+bounces-43747-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 08:41:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B66B21C8EF
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 08:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4A703006B5B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 07:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C7F3783AD;
	Fri,  6 Mar 2026 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="M5Va1dFz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m19731113.qiye.163.com (mail-m19731113.qiye.163.com [220.197.31.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E2137757D;
	Fri,  6 Mar 2026 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782866; cv=none; b=GynlBJ8/QfiCe17x7aRygLx93blV4eoh4OWgncf69H2zhOjiq5JZpQJNaUJAHzk+XKUts1lh0ifwaeuTNublw9+NXIzAXVcKEk3dQEbcCH4RlaFLMPnF8m3Yt90PxA2dzMjhRZnOsUcpO72tkFzH629xJNoWqNmNzfS4PzVy1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782866; c=relaxed/simple;
	bh=/Zx5NSkX3NRNUg+5Dv1UgnflpXo0uGtK62/ZMZKXRTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NJhGjOZIaqO4U0xcm6z13ToRce7Hq2vAWeYf2s0uHQ9hTf4hhMZHH3/kyv7sBT4+XY75amdlAhKlSgrX3LrqvDsEPDACKJi2M/Nlzf+JlTThvcqnoPuEVOq/X6jX8bbPM2CIr/ZVmLUz54zSD2M/3wdjggcnS/WT44uZ9SfC1d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=M5Va1dFz; arc=none smtp.client-ip=220.197.31.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 35fcf41e0;
	Fri, 6 Mar 2026 15:40:53 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/3] dt-bindings: power: rockchip: Add pm_shaping support
Date: Fri,  6 Mar 2026 15:40:30 +0800
Message-Id: <1772782832-216867-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1772782832-216867-1-git-send-email-shawn.lin@rock-chips.com>
References: <1772782832-216867-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9cc2179bc509cckunm7894a4e01405bae
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh8fQlZPGk8YGhpMSk4YQx9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=M5Va1dFz3mu/y6ZmZEf1wX2ciJ/Kp0ID7vuoLAZBWbwZA/pz8456FJi1M2KS4IKK0kKM7bNEbMQmvkEMKUMmg+AEh5hQ5VkjyToeaG2HF38pRe2i7TFp+YK6HUWqMvCBgfeKiGgibvyir5PUEiWc6G+FKcjizpQcawEGp/3MwJQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=38mHrnKAJ0MkRyoXR99jAy7rm6c8iWvbAfXMlBLrGfY=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 9B66B21C8EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-43747-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,rock-chips.com:dkim,rock-chips.com:email,rock-chips.com:mid]
X-Rspamd-Action: no action

pm_shaping is introduced for some platforms to throttle the outstanding
burst requests of each IP to prevent bus monopolization. Add a discription
of it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 .../devicetree/bindings/power/rockchip,power-controller.yaml      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index b41db57..4af6c30 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -147,6 +147,14 @@ $defs:
           A number of phandles to qos blocks which need to be saved and restored
           while power domain switches state.
 
+      pm_shaping:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        items:
+          maxItems: 1
+        description: |
+          A number of phandles to shaping blocks which need to be saved and restored
+          while power domain switches state.
+
       "#power-domain-cells":
         enum: [0, 1]
         description:
-- 
2.7.4


