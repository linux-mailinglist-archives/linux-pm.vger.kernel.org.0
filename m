Return-Path: <linux-pm+bounces-11839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992A394602A
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 17:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559FE285622
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14563166F2B;
	Fri,  2 Aug 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ylTKnRoI"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403703DAC1B;
	Fri,  2 Aug 2024 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611823; cv=none; b=auFn6sSfJzdN6eYSB2t+Rh9wfUSijGVC5sztYZ2F593u339gsTFwJnU368lUoQBMdwq0IO0wFK5B5ol58IdLwVVgAmbE2yh2PCYKP/i+3kRq1NhP6qFiEAiTZ3pFPFCpOQPnuoBkCxHSPzptxSXoEsMCQj+1LsCNbnqBMO9TKRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611823; c=relaxed/simple;
	bh=afzM6zV4pT3/q5F2QE2NWtw3Nh7GCrj/opI1rta2Mgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvXyJN3x7o7N5u+RU/Lb9sydLysUZ2COcNkAnVrSOIVSDy0oPhRQ9IAMjkRvV1sZWsqZ6P3uHweZCWdn3Vma+sC9iPBr4gjCIgdZFJTnpTOwTQ61Pi5aCmVYmWaEgwadEgt09DvqYmIkgUhzKuKWIQFl6JW6KJmFvlG4a20rs80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ylTKnRoI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722611819;
	bh=afzM6zV4pT3/q5F2QE2NWtw3Nh7GCrj/opI1rta2Mgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ylTKnRoIIqtBEES4Wvp0f+eevYUIJVt9j4MBwm62gVYhVmX8njFbyTrEhJ7pBdMyb
	 h/nRyrc5hu1QPe7ZLT8G1FgJQTpghK5M0DwE5lXblio5x7OGDx4mw8j8oILIPAtP+1
	 GYC+QV+KfAzBsT+BF+yTOkUD6SgmoXDU8aXwhLbnb/dW6IfJh/0It3uRUFS5MQB/jg
	 Ed/JKgdKggW5TnWf9jiHka5707fSig2QrnwkFPMbe8PcBaK3q4cTOW68VyLCRDKWFo
	 hkke418bahdakJFKPx9a5/fraSGLjCdI2yN07CNY+4boRViqNBut/DMUZ6IsHqqN56
	 ZhBbwWyuI2MDw==
Received: from trenzalore.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 56D223782219;
	Fri,  2 Aug 2024 15:16:57 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: pinctrl: Add rk3576 power-controller bindings
Date: Fri,  2 Aug 2024 11:14:58 -0400
Message-ID: <20240802151647.294307-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240802151647.294307-1-detlev.casanova@collabora.com>
References: <20240802151647.294307-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the compatible string for the rk3576 power-controller.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 .../devicetree/bindings/power/rockchip,power-controller.yaml     | 1 +
 1 file changed, 1 insertion(+)

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
 
-- 
2.46.0


