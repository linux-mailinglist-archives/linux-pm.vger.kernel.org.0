Return-Path: <linux-pm+bounces-13781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD1996F036
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 11:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9DB2819B0
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934C51C8711;
	Fri,  6 Sep 2024 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMFXEiSW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A15C603;
	Fri,  6 Sep 2024 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616328; cv=none; b=OkyvqnaDvjJ9c/HPaNyTuyF96jb009hHWLXy4x50V9obuYClgQ3M7VG8UN9l6j1CjLvzpuhNtYxPLZtmxUdlfGNVGbWG6V2bUUPefNBYpxZCtEV7WCz0NJ7FN8/gVuHnAshuZXKwwXGFSirE4ZKyP66V8JS8Bow4FGRLVhZERzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616328; c=relaxed/simple;
	bh=zlPe96qEkYTI2oOKTLt2ru4+cI3fHrOB1XnOtIqa46c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuybONoUX5xp8LQPJVeJ5PF3x/Dsl8LbAMctGzehEUkqS/mkF2YxGBM/neFur86VnZ0OyuqpOquVLphJhjN9pqJ7r1YziW0hNbKqvjAV4vuczsFd9L5emUCH8IFTq6znM2t19vJ6awzTyj6zvIDPsWAYEvWhWz46QD/nXBnRXTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMFXEiSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574A7C4CEC5;
	Fri,  6 Sep 2024 09:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725616327;
	bh=zlPe96qEkYTI2oOKTLt2ru4+cI3fHrOB1XnOtIqa46c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oMFXEiSWY2Gdc6v5SGUXnEqwwCtdBs0E97TS2iKPWUC5T739RhbBJZRLLMle24zVt
	 pbSeaPWwtb+gvswzNd4PRApEeE2KToG2YjYTpPgYJphVKVywwDuM9o1lf+HarJQm0n
	 dp+HuePYLJDm+IwT4ivrq3I6AdhzyyaZBAEjgGiZ6wm6C2H23xU0xQAMEa0B9bV688
	 2VTppoOGmaaPmPYhcrc4OO/XQCohJrL+9/4vO8D39Cv/3Wo7w7ooOEsa0iVYhUlAD7
	 nVYZKiV0CB1ZSb26GJFHBwRH7MXQz3JJVWlzvi96skhD9RXo0cWMYkx4SFI3TCdXCV
	 A5I6W+4Q5iGYQ==
Message-ID: <dbc6af20-886a-46fb-a16c-dbcb5861478c@kernel.org>
Date: Fri, 6 Sep 2024 11:51:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] dt-bindings: Add documentation for Photonicat PMU
To: Junhao Xie <bigfoot@classfun.cn>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Heiko Stuebner <heiko@sntech.de>,
 Chukun Pan <amadeus@jmu.edu.cn>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
 <20240906093630.2428329-9-bigfoot@classfun.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240906093630.2428329-9-bigfoot@classfun.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/09/2024 11:36, Junhao Xie wrote:
> Add device tree binding documentation for Photonicat PMU MFD, LEDs,
> hardware monitor, power off, power supply, real-time clock watchdog.
> 
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
> ---
>  .../hwmon/ariaboard,photonicat-pmu-hwmon.yaml |  40 +++++++
>  .../leds/ariaboard,photonicat-pmu-leds.yaml   |  41 +++++++
>  .../mfd/ariaboard,photonicat-pmu.yaml         | 107 ++++++++++++++++++
>  .../ariaboard,photonicat-pmu-poweroff.yaml    |  34 ++++++
>  .../ariaboard,photonicat-pmu-supply.yaml      |  55 +++++++++
>  .../rtc/ariaboard,photonicat-pmu-rtc.yaml     |  37 ++++++
>  .../ariaboard,photonicat-pmu-watchdog.yaml    |  37 ++++++
>  7 files changed, 351 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ariaboard,photonicat-pmu-hwmon.yaml
>  create mode 100644 Documentation/devicetree/bindings/leds/ariaboard,photonicat-pmu-leds.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/ariaboard,photonicat-pmu.yaml
>  create mode 100644 Documentation/devicetree/bindings/power/reset/ariaboard,photonicat-pmu-poweroff.yaml
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ariaboard,photonicat-pmu-supply.yaml
>  create mode 100644 Documentation/devicetree/bindings/rtc/ariaboard,photonicat-pmu-rtc.yaml
>  create mode 100644 Documentation/devicetree/bindings/watchdog/ariaboard,photonicat-pmu-watchdog.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ariaboard,photonicat-pmu-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/ariaboard,photonicat-pmu-hwmon.yaml
> new file mode 100644
> index 000000000000..c9b1bab20c31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ariaboard,photonicat-pmu-hwmon.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/ariaboard,photonicat-pmu-hwmon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Photonicat PMU Hardware Monitor
> +
> +maintainers:
> +  - Junhao Xie <bigfoot@classfun.cn>
> +
> +description:
> +  Board temperature sensor on the Photonicat PMU MCU
> +
> +properties:
> +  compatible:
> +    const: ariaboard,photonicat-pmu-hwmon
> +
> +  label:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: Label for hwmon device

No resources here. Fold it into parent binding.

> +
> +required:
> +  - compatible
> +  - label
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      serial {
> +          mcu {
> +              compatible = "ariaboard,photonicat-pmu";

Drop, no need.

> +

Messed indentation.

Entire example is redundant. Merge it to parent binding.


> +              hwmon {
> +                  compatible = "ariaboard,photonicat-pmu-hwmon";
> +                  label = "pcat_board";
> +              };
> +          };
> +      };
> diff --git a/Documentation/devicetree/bindings/leds/ariaboard,photonicat-pmu-leds.yaml b/Documentation/devicetree/bindings/leds/ariaboard,photonicat-pmu-leds.yaml
> new file mode 100644
> index 000000000000..6ccb0e691b09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/ariaboard,photonicat-pmu-leds.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/ariaboard,photonicat-pmu-leds.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Photonicat PMU LEDs
> +
> +maintainers:
> +  - Junhao Xie <bigfoot@classfun.cn>
> +
> +description:
> +  LEDs on the Photonicat PMU MCU
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: ariaboard,photonicat-pmu-leds

Your compatibles per device do not make much sense. You organized
bindings per drivers, but that's not what we want.

> +
> +  label: true

Drop

> +
> +required:
> +  - compatible
> +  - label
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      serial {
> +          mcu {
> +              compatible = "ariaboard,photonicat-pmu";
> +
> +              leds-status {
> +                  compatible = "ariaboard,photonicat-pmu-leds";
> +                  label = "net-status";
> +              };
> +          };
> +      };
> diff --git a/Documentation/devicetree/bindings/mfd/ariaboard,photonicat-pmu.yaml b/Documentation/devicetree/bindings/mfd/ariaboard,photonicat-pmu.yaml
> new file mode 100644
> index 000000000000..df16d9507821
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ariaboard,photonicat-pmu.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ariaboard,photonicat-pmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ariaboard Photonicat PMU
> +
> +maintainers:
> +  - Junhao Xie <bigfoot@classfun.cn>
> +
> +description:
> +  Driver for the Power Management MCU in the Ariaboard Photonicat,

Bindings are for hardware, not drivers. Drop it everywhere and explain
hardware.

> +  which provides battery and charger power supply, real-time clock,
> +  watchdog, hardware shutdown.
> +
> +properties:
> +  compatible:
> +    const: ariaboard,photonicat-pmu

That's the only compatible you should have. Drop all others.

> +
> +  current-speed:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 115200
> +    description: PMU Serial baudrate
> +
> +  local-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 127
> +    default: 1
> +    description: CPU board address

Address of what? In which notation? It's part of this hardware.


> +
> +  remote-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 127
> +    default: 1
> +    description: PMU board address

Eee, no. Your board knows its address. You do not have to tell it.

> +
> +  hwmon:
> +    $ref: /schemas/hwmon/ariaboard,photonicat-pmu-hwmon.yaml
> +
> +  poweroff:
> +    $ref: /schemas/power/reset/ariaboard,photonicat-pmu-poweroff.yaml
> +
> +  rtc:
> +    $ref: /schemas/rtc/ariaboard,photonicat-pmu-rtc.yaml
> +
> +  watchdog:
> +    $ref: /schemas/watchdog/ariaboard,photonicat-pmu-watchdog.yaml
> +
> +patternProperties:
> +  '^leds-(status)':

That's not a pattern.

> +    $ref: /schemas/leds/ariaboard,photonicat-pmu-leds.yaml
> +
> +  '^supply-(battery|charger)$':
> +    $ref: /schemas/power/supply/ariaboard,photonicat-pmu-supply.yaml

Why two nodes?

> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      serial {
> +          photonicat-pmu {
> +              compatible = "ariaboard,photonicat-pmu";
> +              current-speed = <115200>;
> +              local-address = <1>;
> +              remote-address = <1>;
> +
> +              supply-battery {
> +                  compatible = "ariaboard,photonicat-pmu-supply";
> +                  label = "battery";

Nope, drop label.

> +                  type = "battery";

No, there is no type property.

Missing monitored battery.

> +              };
> +
> +              supply-charger {
> +                  compatible = "ariaboard,photonicat-pmu-supply";
> +                  label = "charger";
> +                  type = "charger";
> +              };
> +
> +              hwmon {
> +                  compatible = "ariaboard,photonicat-pmu-hwmon";
> +                  label = "pcat_board";
> +              };
> +
> +              leds-status {
> +                  compatible = "ariaboard,photonicat-pmu-leds";
> +                  label = "net-status";
> +              };
> +
> +              poweroff {
> +                  compatible = "ariaboard,photonicat-pmu-poweroff";
> +              };
> +
> +              rtc {
> +                  compatible = "ariaboard,photonicat-pmu-rtc";
> +              };
> +
> +              watchdog {
> +                  compatible = "ariaboard,photonicat-pmu-watchdog";
> +              };

These are seriously redundant and useless nodes.  There is nothing
beneficial from the nodes above - they are all empty, without resources.
Drop all of them.

I finish the review here.

Best regards,
Krzysztof


