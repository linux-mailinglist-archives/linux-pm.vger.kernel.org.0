Return-Path: <linux-pm+bounces-13960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE3E97419A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 20:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DCC2869EA
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 18:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB5D1A4B73;
	Tue, 10 Sep 2024 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qR7sE07K"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60081A0B0D;
	Tue, 10 Sep 2024 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991535; cv=none; b=oFQgPUIQ2YHqDnqlbmSZ9qUmLOay/pj0cmfDUaHZ9G3wC8WNuHXUeazVSngTPIkhu4kLFss39aDUK0mgsncTHQC1OuAplhB3i+EWutze3ocwCMcAVjy+WfcnnX5mK3Zn+6TWvtdpIoq1VDHe5REtU2Y1xDNzdfDttq6mMGw8q5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991535; c=relaxed/simple;
	bh=nYIXU5OMRZPbwJcZmX8U4VoDzIL/uNNlSUscY2JAgo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbP1El/dh7YHOwr7u7xeFgdXKsXkyLRe/EsWFnWTiXfEbidjYQpenKb7Cjo5ByL/WDQcYUvCaTM/2UHGxRD7eTtxUvFaNDtXgU7kiaTvWRivoV4VArGFlxhCVQhQ6kVNSo6HzJCzcyoE+VTygzkYtr8IAobLbQEeSfQ6V3PgdcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qR7sE07K; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725991532;
	bh=nYIXU5OMRZPbwJcZmX8U4VoDzIL/uNNlSUscY2JAgo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qR7sE07Krxu7zZ6l4JFvuRom0n4KtPs3RlU8SV7QS/rUt1AIxR3XX+8j/FQu458Qo
	 86mGDvgxPIOWCyYMcogx1lGbzXx8uT4aiznaUbXEhj0SViHasmezKWDqbM15KoC+HO
	 jil1lkp0F6VtjgemgE3gFosv+gtj2Zlc+hcOPouFTOzuuB3ljTQsnwKKcVQJTgLK+m
	 hlMpGsbCPiaxBahYOWgyc5IfL/KdRX3nlOgxM3z039HWuc9gAt4YH5kdrsnbNvgI27
	 1XYygrNTIer6p0LOKo0Va8HAkVDvlCQxcbwFpUXgvdaQVYcfBr3GbbyN0UIWSBpho4
	 72tznkFzGag4g==
Received: from jupiter.universe (dyndsl-091-248-215-127.ewe-ip-backbone.de [91.248.215.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D37A617E35FE;
	Tue, 10 Sep 2024 20:05:31 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 91E174800F8; Tue, 10 Sep 2024 20:05:31 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Elaine Zhang <zhangqing@rock-chips.com>,
	=?UTF-8?q?Adri=C3=A1n=20Mart=C3=ADnez=20Larumbe?= <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v1 4/6] dt-bindings: power: rockchip: add regulator support
Date: Tue, 10 Sep 2024 19:57:13 +0200
Message-ID: <20240910180530.47194-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910180530.47194-1-sebastian.reichel@collabora.com>
References: <20240910180530.47194-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add optional support for a voltage supply required to enable a
power domain. The binding follows the way it is handled by the
Mediatek binding to keep things consistent.

This will initially be used by the RK3588 GPU power domain, which
fails to be enabled when the GPU regulator is not enabled.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/power/rockchip,power-controller.yaml   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index 0d5e999a58f1..0b4c5b174812 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -131,6 +131,9 @@ $defs:
           A number of phandles to clocks that need to be enabled
           while power domain switches state.
 
+      domain-supply:
+        description: domain regulator supply.
+
       pm_qos:
         $ref: /schemas/types.yaml#/definitions/phandle-array
         items:
-- 
2.45.2


