Return-Path: <linux-pm+bounces-23892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26266A5CF8C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 20:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6574117C040
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 19:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE695263F3C;
	Tue, 11 Mar 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPHR3Y1e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17D217591;
	Tue, 11 Mar 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721854; cv=none; b=E/0rne3FAJz9AbP+b+xw32fvzl7HFaQ7nu79QjcgjqMdPXSxlEhcLx98K270L9MALUIz4JK4dcr5+G0U0hKP4+xOTleUtMLNStkQGvR7aPd36NwIVN771q5F6JCDgwIP0uVACLLEGnqD60v2GINjf4fA5scNfkqjnAegbDt3RxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721854; c=relaxed/simple;
	bh=Yc2i634TtfKAU01+EBlX/aQoXrMwveeOrOozCJkjfiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzYVaNa060oLYsMZ4OxnLfGH6urXx9MfCvGcjpnVjbJBwi+FyBMlpFgO0xiM1ZWznEWcgjCrFAbQit/rCblPcjOWX96FV0Lyj0ptNY/jaV6NMUlJKyV0251mrzBQnJY6OBhAUD9rlo4KMIG0tdfC3INeS7iHl99I8nGmb3viXNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPHR3Y1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF55C4CEE9;
	Tue, 11 Mar 2025 19:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741721854;
	bh=Yc2i634TtfKAU01+EBlX/aQoXrMwveeOrOozCJkjfiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPHR3Y1egQONi48/xm/BuFYagZfsmreotCtMwE7G4o6s2ME2E6/ydVRDZ2yenrczm
	 9nmPFc9K/O0gecZI8q5+XcS4JPAx9RX89FStrEuxRqCzcCVGb+XEc47UUbBhCe8WOv
	 toUP8ck5dxlyiuL7f7m5MN4rAJW2NmCPwITO230xYvq5f1zZqHxlxSEA7uJUqd3INK
	 wLoU2wu+bz4OhG6S4lAoEBkjBl4OYnHqRstfBl7Tv3z0sZiFDkKI7cAU95qtwMnObJ
	 C+WYDwGowLNGjTi42mjWe2EN4F3EN9tsvKl/KnmtZNrT9X0fxoWHVOJZDsi91Fhwmm
	 rxFKfTwCv9SgA==
Date: Tue, 11 Mar 2025 14:37:32 -0500
From: Rob Herring <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: power: supply: Document Maxim
 MAX8971 charger
Message-ID: <20250311193732.GA4183071-robh@kernel.org>
References: <20250310080237.7400-1-clamor95@gmail.com>
 <20250310080237.7400-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310080237.7400-2-clamor95@gmail.com>

On Mon, Mar 10, 2025 at 10:02:36AM +0200, Svyatoslav Ryhel wrote:
> Add bindings for Maxim MAX8971 charger.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/power/supply/maxim,max8971.yaml  | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> new file mode 100644
> index 000000000000..d7b3e6ff6906
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/maxim,max8971.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX8971 IC charger
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description:
> +  The MAX8971 is a compact, high-frequency, high-efficiency switch-mode charger
> +  for a one-cell lithium-ion (Li+) battery.
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    const: maxim,max8971
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  monitored-battery: true
> +
> +  maxim,usb-connector:

Just 'connector', so when we have a 3rd case, we don't have a 3rd 
vendor.

> +    description:
> +      Phandle to a USB connector according to usb-connector.yaml. The connector
> +      should be a child of the extcon device.

'extcon' is a Linuxism. Is there an actual requirement here that's not 
*current* Linux requirements (which could change)? I assume the 
requirement is to have vbus or some supply?

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        charger@35 {
> +            compatible = "maxim,max8971";
> +            reg = <0x35>;
> +
> +            interrupt-parent = <&gpio>;
> +            interrupts = <74 IRQ_TYPE_LEVEL_LOW>;
> +
> +            monitored-battery = <&battery>;
> +            maxim,usb-connector = <&usb_con>;
> +        };
> +    };
> +...
> -- 
> 2.43.0
> 

