Return-Path: <linux-pm+bounces-10730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6901A9297F9
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jul 2024 14:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDB91F21AB1
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jul 2024 12:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320D51DFDE;
	Sun,  7 Jul 2024 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3iSw9ML"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042C01429B;
	Sun,  7 Jul 2024 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720357191; cv=none; b=njXPwKW1XVtMh6cdmC8b1+DEAfGnmgUKniCzDXD0gHshX2PwmzsnOfUtVNzgCwYT5RH1pLzKmpHNqST10HoT0YH8TlSVtxya32YXLJoPsfpzvTjObRWg0VLvK6nj8l0TXQBUWQPQvHAUySFVbweFz3bHMWHc//PwwZDKur3cpVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720357191; c=relaxed/simple;
	bh=tiXMA8EECBkqN/vv2Nt4zH0sM+yAKEX9K1n1zCy7yDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmBgKvKaDldIx8MBmF0Mwp/wiYz5ceViNgpCH0XGmVFjtLhFbnZgtth0uS2x2gEIUO38gYGi9pTxvxhxR4cE2blaaEALpi58ns1XvV9wQIsifE8uhheK4M10XSbgLFgQq45x7T3eDfIRsGpNS/bvDut7uKgYkYEa2VzgiY8RjyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3iSw9ML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7056AC3277B;
	Sun,  7 Jul 2024 12:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720357190;
	bh=tiXMA8EECBkqN/vv2Nt4zH0sM+yAKEX9K1n1zCy7yDU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k3iSw9MLTQChGjG8cN9oUX2rM6wytHwmk+SoKRGOKGU/ZHJClzLXbtECPEb/LASPj
	 ikdewirGrr1ly6Q87+3fKOHS9tnk+fUz8d+uLhNY72wn26fIrSSPa3zgjknmdk2Gki
	 2beXfNiqkffUlNvmKivL3c1RkpdLrKQrdUDbiT1m8hnSARqZKmxMK0snepAisTX3K4
	 WdGiGIo+y+4nDycEKyjRfZIBdvqO9dWlfj+bOzFgashQCgnry77o0ygxkUUML6JyYu
	 g37Ercm9NIzl8M/Y/Zr+hsLqXgrCVVH+ZZUZP/FNwt1xm8FLa309qNqR/L/X1iQKJT
	 1cK4QyMCVNY7g==
Message-ID: <a4d08999-55ea-4674-bb0f-6d618b7bdea7@kernel.org>
Date: Sun, 7 Jul 2024 14:59:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: power: Add power sequence for Amloigc
 WCN chips
To: yang.li@amlogic.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com>
 <20240705-pwrseq-v1-1-31829b47fc72@amlogic.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <20240705-pwrseq-v1-1-31829b47fc72@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 13:13, Yang Li via B4 Relay wrote:
> From: Yang Li <yang.li@amlogic.com>
> 
> Add binding document to introduce power sequence of
> Amlogic WCN chips.
> 
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  .../bindings/power/amlogic,w155s2-pwrseq.yaml      | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/amlogic,w155s2-pwrseq.yaml b/Documentation/devicetree/bindings/power/amlogic,w155s2-pwrseq.yaml
> new file mode 100644
> index 000000000000..f99a775fcf9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/amlogic,w155s2-pwrseq.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/amlogic,w155s2-pwrseq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic power sequence for WCN chips
> +
> +maintainers:
> +  - Yang Li <yang.li@amlogic.com>
> +
> +description:
> +  The Amlogic WCN chip contains discrete modules for WLAN and Bluetooth. Power on
> +  Bluetooth and Wi-Fi respectively, including chip_en pull-up and bt_en pull-up,
> +  and generation of the 32.768KHz clock.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: amlogic,w155s2-pwrseq
> +      - items:
> +          - enum:
> +              - amlogic,w265s1-pwrseq
> +              - amlogic,w265p1-pwrseq
> +              - amlogic,w265s2-pwrseq
> +          - const: amlogic,w155s2-pwrseq
> +
> +  clocks:
> +    maxItems: 1
> +    description: clock provided to the controller (32.768KHz)
> +
> +  clock-names:
> +    items:
> +      - const: ext_clock

Drop _clock... or actually drop entire clock-names, not much helpful.

> +
> +  amlogic,chip-enable-gpios:
> +    maxItems: 1
> +    description: gpio specifier used to enable chipset

For entire chipset? Then enable-gpios

> +
> +  amlogic,bt-enable-gpios:
> +    maxItems: 1
> +    description: gpio specifier used to enable BT

Follow existing bindings for Qualcomm as example.

> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - amlogic,chip-enable-gpios
> +  - amlogic,bt-enable-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    wcn_pwrseq {

No underscores in node names, generic node names.

There is no device as "pwrseq". I also do not get what "wcn" means here.



Best regards,
Krzysztof


