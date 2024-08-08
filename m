Return-Path: <linux-pm+bounces-11999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE64F94C2D3
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48921B292A0
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C1B191F6D;
	Thu,  8 Aug 2024 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="Snv7pVN5"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873B51917D4;
	Thu,  8 Aug 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134844; cv=pass; b=k5M9DkYgba3mE3RsJBOXWyCOSuGFD0uM0WbjW/L+6Px9eO0tdT+WX6QsQL+rBFfRA4CRT3UJ4n5U/LuAg0EUpxNGiyXEv3T9fKP97Lx5iyv0xTbZlsZ49rezqknu8DvaNOFPVenHLTjPuvDmIEYgsEwM66m2d6d946EvoMGASkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134844; c=relaxed/simple;
	bh=TmXhq8Z9zdF+EcftMWkcPqg6cC8NKV7O84Q2Ne4BGxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5YTFVuz9pvLtOWMUafnqs+5GPhzqQE9zYYqmDIx4E32KAGvNGSAWCzp4CqP1bB7y+9+91xYOipkPXB9strMHMiF8w6P94AO6+pllKOvrO2l7Nuw0ZEnVqKovEmEFcgmkNO4A86BZZkPmYK1jMFulqHc3cXnsZL01Vnpc9tiEnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=Snv7pVN5; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: detlev.casanova@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723134818; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WEU/cEHl7no+OufB895Wcx4cmnUUFZXcE9N7ppbGThVX6q2ExlZamXmtNjFBNktLoixBaPNOfAUq4nkJGvLlJFjUEspeY9b7VEStwnTDtHOoMZPlwBnaR85gHrNiMoEh8gYOQo7JyXtc2sRHHlV3sw2VQqehJ69XRwhaQfUOH5E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723134818; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RyCepvyWzhp8Bg9hhu049ivfAGgOO+ujHi0U3uQVpzQ=; 
	b=ZVy7caFIR1AptdRp/7y5Vuw18m08/jEmdj7hXpezUdFMQi7Ks1mMQ/DuZKDEuDWzbNXupklQC1Y7FNA0cLvI2BPH67C0cVCVozeAEV12qNKRQ6BIgX/LkfFFeCXs6NhISHHsmwLj+LQuVvneFnElmJ5Rrk59SrsUOuP160qdW0Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723134818;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=RyCepvyWzhp8Bg9hhu049ivfAGgOO+ujHi0U3uQVpzQ=;
	b=Snv7pVN5ww1a7qVUz0RvQepSkMx5/QlMLoO8X/c6BNNWIadNyjQjLCqg21DUllBo
	N1c1lAcZEhmgMi1uxO9Eza7WkO/NEFH2MbqAw9IDjSUuJoR6p8AD1d0jWZjRpMe6yu2
	zNB9KQQutdVrXXoGS7y6Uk/DbxXdaiFjwb5hnifo=
Received: by mx.zohomail.com with SMTPS id 1723134816403244.22942005210552;
	Thu, 8 Aug 2024 09:33:36 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Arnd Bergmann <arnd@arndb.de>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v2 1/2] dt-bindings: power: Add support for RK3576 SoC
Date: Thu,  8 Aug 2024 12:31:04 -0400
Message-ID: <20240808163451.80750-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808163451.80750-1-detlev.casanova@collabora.com>
References: <20240808163451.80750-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Finley Xiao <finley.xiao@rock-chips.com>

Define power domain IDs as described in the TRM and add compatible for
rockchip,rk3576-power-controller

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
[reword, add yaml]
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 .../power/rockchip,power-controller.yaml      |  1 +
 .../dt-bindings/power/rockchip,rk3576-power.h | 30 +++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 include/dt-bindings/power/rockchip,rk3576-power.h

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index 0d5e999a58f1b..650dc0aae6f51 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -41,6 +41,7 @@ properties:
       - rockchip,rk3368-power-controller
       - rockchip,rk3399-power-controller
       - rockchip,rk3568-power-controller
+      - rockchip,rk3576-power-controller
       - rockchip,rk3588-power-controller
       - rockchip,rv1126-power-controller
 
diff --git a/include/dt-bindings/power/rockchip,rk3576-power.h b/include/dt-bindings/power/rockchip,rk3576-power.h
new file mode 100644
index 0000000000000..324a056aa8512
--- /dev/null
+++ b/include/dt-bindings/power/rockchip,rk3576-power.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+#ifndef __DT_BINDINGS_POWER_RK3576_POWER_H__
+#define __DT_BINDINGS_POWER_RK3576_POWER_H__
+
+/* VD_NPU */
+#define RK3576_PD_NPU		0
+#define RK3576_PD_NPUTOP	1
+#define RK3576_PD_NPU0		2
+#define RK3576_PD_NPU1		3
+
+/* VD_GPU */
+#define RK3576_PD_GPU		4
+
+/* VD_LOGIC */
+#define RK3576_PD_NVM		5
+#define RK3576_PD_SDGMAC	6
+#define RK3576_PD_USB		7
+#define RK3576_PD_PHP		8
+#define RK3576_PD_SUBPHP	9
+#define RK3576_PD_AUDIO		10
+#define RK3576_PD_VEPU0		11
+#define RK3576_PD_VEPU1		12
+#define RK3576_PD_VPU		13
+#define RK3576_PD_VDEC		14
+#define RK3576_PD_VI		15
+#define RK3576_PD_VO0		16
+#define RK3576_PD_VO1		17
+#define RK3576_PD_VOP		18
+
+#endif
-- 
2.46.0


