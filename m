Return-Path: <linux-pm+bounces-20585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E979AA14282
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 20:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0353A4265
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 19:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4AD233532;
	Thu, 16 Jan 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MShopdcz"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27D14AD2B;
	Thu, 16 Jan 2025 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056698; cv=none; b=VFq+TRJLJG6Y5YBaUY4gtakT2UiOTOnigGlvWsmOPQp8BEs21t/JZcelPmrPutISIRr6FewrKnIZRaD9r4uG6hs0j7oFRsd5h/9o8aHyS9j+lrM4mkskNVnYx6oCCS0Wjcd3Q/+epMZGVHTzChLQnXT0rC521fMC0hcJoDZdtB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056698; c=relaxed/simple;
	bh=kn6/zBHCGJlt3wXOC8g6H3w523YCtAh1W1ztNmBm9Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sB3EXudOZuBnwv6oV4Dx5yFq0vwxEp6HB/u9luQ0vCHAIlVLdqAzEo/Qr86ZHpO4II5ekjWVTJxQ/MQoelAMKyuXwMjD8rbJHTXRTzADzjXSFV9WqEaqhADEZ8GaStlQBjdPxBxSdNlqdwq5lgRAO8Grv39IK2VyA4R2n5gk6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MShopdcz; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 2F909C002825;
	Thu, 16 Jan 2025 11:44:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 2F909C002825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1737056690;
	bh=kn6/zBHCGJlt3wXOC8g6H3w523YCtAh1W1ztNmBm9Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MShopdcz8biVW8zFqwZe0qtX6eNczDdICj2aaD4fXFOoD4/uVywuGvb0jUf7f51RQ
	 C06deVf6pb9fiYdfsqMcwLa5o8x/3sEuJmJusmOyBDqs8vzUCLn4yvF5Cvt+aknL96
	 /6sSIciEhRAuZ73J5eASsOSdKNqDOfchjdb79sPk=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id B0C0218041CACA;
	Thu, 16 Jan 2025 11:44:49 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE)
Subject: [PATCH 1/2] dt-bindings: thermal: Update for BCM74110
Date: Thu, 16 Jan 2025 11:38:41 -0800
Message-ID: <20250116193842.758788-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116193842.758788-1-florian.fainelli@broadcom.com>
References: <20250116193842.758788-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the binding with the BCM74110 compatible string which denotes the
first device we need to support in a different process node requiring an
updated thermal equation.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
index 081486b44382..2f62551a49c1 100644
--- a/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     items:
       - enum:
+          - brcm,avs-tmon-bcm74110
           - brcm,avs-tmon-bcm7216
           - brcm,avs-tmon-bcm7445
       - const: brcm,avs-tmon
-- 
2.43.0


