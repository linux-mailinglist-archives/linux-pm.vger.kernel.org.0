Return-Path: <linux-pm+bounces-18986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913EA9EC589
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 08:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1856C168254
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D427F1C5F14;
	Wed, 11 Dec 2024 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esERtU2b"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70861C5F00;
	Wed, 11 Dec 2024 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902174; cv=none; b=ds17KKtDNwq3jRfqScR3YXpnWFTR3A8uQ7UbFusiZKHZh8DhFztaBt7fDsKej9I09VEf0aJhridCua6mbx0WlLZ6lW06kNjKTkEoNySRmzDUcWo0tk0QS1oDmpxAzlpmgVBQnlJvV7EAmbXXxYJkRxab8/LAtXzWnp8D8XOwVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902174; c=relaxed/simple;
	bh=9vAnAd2QwKydelMDaBCoKBb1aZfGFP/9QHN/QjRUQWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kQtrSu8XrHrHOfnACzhW3cvUyBpW+W8j/xBrPlGC4/d2hP9tbOQVQSKlMDM78EWbh9wPRS2Dkh6zGFpKza0iHB0E6tHdIZKZRbQvlzfYV7ZN42o4slyCqZHHAKF+I2AK1ovExUOToVJfX+bTJS5Iy2wiWCmNr9ljZXYjRvS1tvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esERtU2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36E11C4CEE0;
	Wed, 11 Dec 2024 07:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733902174;
	bh=9vAnAd2QwKydelMDaBCoKBb1aZfGFP/9QHN/QjRUQWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=esERtU2bYfpXYc0VQSkD9XSUIFlP23vO7DOlrnzPnxqZwqZWBRWKxpeUaI2lx7XeW
	 4nFv+t4HxRlKaY+4OpgPWFxiIHqP6BZUEaqrc/ncCWzoX9xuuHOQY+cPIYMeNIGNTm
	 aZFscoGwIRjhS3oyShsFpn5N0qQMt5dRChu70PZMZTUzCBJZCZEC0BmEm7YJ+Y40gl
	 LAwc7PkVgmw8ZLuL/fuuFm+ipDicIUND1XkDQpOKUM9c07UEX4eM9eKBL73k4KN9/j
	 fAavjTZ02H3qPs1DOd3S9CCcmQ/A2Exvlj+17umAb8faOGv0UYjGAkGNidoJYHfmSF
	 HMT4TOF45NBUQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13057E77180;
	Wed, 11 Dec 2024 07:29:34 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Wed, 11 Dec 2024 08:29:09 +0100
Subject: [PATCH 1/2] dt-bindings: power: supply: gpio-charger: add support
 for default charge current limit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-default-charge-current-limit-v1-1-7819ba06ee2a@liebherr.com>
References: <20241211-default-charge-current-limit-v1-0-7819ba06ee2a@liebherr.com>
In-Reply-To: <20241211-default-charge-current-limit-v1-0-7819ba06ee2a@liebherr.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733902172; l=942;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=Pxa2UR9+jiJf91z+v5TVU4+c8Xt5Dl0NVFgqfKJqVu4=;
 b=u37K86IYjQzBWwkt1ZG7stCRoxjAK/KU//ICWnpPcv+Gu3I/b2+JEDN6Lh4igcLFXsr7RXnsd
 W4WNCm1lSpwBRqlTf6uCAsr2J8P6h0DEqF9sJQDMOwgT2/tTYJ4/pR8
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Add binding for default charge current limit.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 Documentation/devicetree/bindings/power/supply/gpio-charger.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
index 89f8e2bcb2d7836c6a4308aff51721bd83fa3ba1..545fdd7133daf67b5bc238c5af26d0cbd8b44eae 100644
--- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
@@ -58,6 +58,10 @@ properties:
             charge-current-limit-gpios property. Bit 1 second to last
             GPIO and so on.
 
+  charge-current-limit-default:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Default charge current limit in uA.
+
 required:
   - compatible
 

-- 
2.39.5



