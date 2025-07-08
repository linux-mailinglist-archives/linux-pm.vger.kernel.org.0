Return-Path: <linux-pm+bounces-30352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84A7AFC6A6
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 11:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB083B981A
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 09:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135782BE052;
	Tue,  8 Jul 2025 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSVKbZoP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C562153ED;
	Tue,  8 Jul 2025 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965580; cv=none; b=ZuF6EzZ/G9Q261f2+qixUJLNXerDgg+3IIK3APRFI99xhlOpqVfYA4WucDCFWabd5bDS4FUTvsOcfdDMj1NAEOfccEv5abfMadKU1I3Y4NMv4hMjX7DyNk5j+Wh+Wts8jyh9VNrIsOUXvrKTcOMVR06x5/ZaBom7Xt8ra/5H09A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965580; c=relaxed/simple;
	bh=z9GjhbhLpj8HuAzEmQ+QGnCTk73YqSo5RaCd1uu3Zww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocxKcfMXpvgAGPrZG3F0OWVb/2vcQ6s5cVcx7oCgUQ94i9nlCXYr+XQB+aHPpB8sw0JwC1ucPD2tiNbzFuhFCXIxe3E9bBZ6vjzCT2m+IGoE+/XYUmMaqfnsw8QCVtfq66c+gZYNExjxbkBVb9MFOccRxnN71Zxpd8A/FnK2p8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSVKbZoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572BEC4CEED;
	Tue,  8 Jul 2025 09:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751965578;
	bh=z9GjhbhLpj8HuAzEmQ+QGnCTk73YqSo5RaCd1uu3Zww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XSVKbZoPcQ3H6csgG6oT2B6FqGhwMPMax2jxinoM4KMY5netYEKYfxXWS+hy/GRjW
	 Fbsci/ZtiXVNkkHwz6QcjA99vZjAAug/ox8e4c4FrBzyRFRKhhmGAqHmXxlCpnxI+v
	 jXu9kDwfGAA3A7hVxLai237kDUg9MfCfSZKK/XVewbg7qVCo1560t+x592NfQ/ExiD
	 saqxcIZMp2ZldIOb3kSF5bY0I7HvVrEVHC4VHWeMkfRXb8NddIo3wCFpmbqPb7PD7C
	 SFZa4uaDXejJvUfnqtbFLT5DGjV5nNKK8rXaL8fJsVbdEObhM5UYATBVFQyJ6vHv/W
	 Vdk7yUVwEeLmA==
Message-ID: <03211869-cd7d-4111-a7c1-3c69fccc4120@kernel.org>
Date: Tue, 8 Jul 2025 11:06:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: power: Add A523 PPU and PCK600 power
 controllers
To: wens@kernel.org
Cc: Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250627152918.2606728-1-wens@kernel.org>
 <20250627152918.2606728-2-wens@kernel.org>
 <20250708-capable-caiman-of-feminism-9dfef2@krzk-bin>
 <CAGb2v66SvNmWGYSfVdDfBdRjSz0mQ=f0HHFnQ9eSXSe7fVMEVg@mail.gmail.com>
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
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
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
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <CAGb2v66SvNmWGYSfVdDfBdRjSz0mQ=f0HHFnQ9eSXSe7fVMEVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/07/2025 10:55, Chen-Yu Tsai wrote:
> On Tue, Jul 8, 2025 at 4:47 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Fri, Jun 27, 2025 at 11:29:15PM +0800, Chen-Yu Tsai wrote:
>>> From: Chen-Yu Tsai <wens@csie.org>
>>>
>>> The A523 PPU is likely the same kind of hardware seen on previous SoCs.
>>>
>>> The A523 PCK600, as the name suggests, is likely a customized version
>>> of ARM's PCK-600 power controller. Comparing the BSP driver against
>>> ARM's PPU datasheet shows that the basic registers line up, but
>>> Allwinner's hardware has some additional delay controls in the reserved
>>> register range. As such it is likely not fully compatible with the
>>> standard ARM version.
>>>
>>> Document A523 PPU and PCK600 compatibles.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>  .../bindings/power/allwinner,sun20i-d1-ppu.yaml   |  2 ++
>>>  .../power/allwinner,sun55i-a523-pck600.h          | 15 +++++++++++++++
>>>  .../dt-bindings/power/allwinner,sun55i-a523-ppu.h | 12 ++++++++++++
>>>  3 files changed, 29 insertions(+)
>>>  create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-pck600.h
>>>  create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-ppu.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
>>> index f578be6a3bc8..b9f550994512 100644
>>> --- a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
>>> +++ b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
>>> @@ -18,6 +18,8 @@ properties:
>>>      enum:
>>>        - allwinner,sun20i-d1-ppu
>>>        - allwinner,sun8i-v853-ppu
>>> +      - allwinner,sun55i-a523-ppu
>>> +      - allwinner,sun55i-a523-pck-600
>>
>> Don't add items at the end, but placed in alphabetical order. Could be
>> natural sort if you insist, but binding does not use it.
> 
> In our other bindings [1][2] we have them sorted by family (sunXYi)

Sure, choose whatever sorting rule you want but then YOU must review
this on every binding, because we do not and we cannot know that family
information.

But if this is the sorting here, why "20" is before 8? In other places
it is after.

So yeah, you have chosen complicated sorting which no one from DT
maintainers gets and you do not enforce clarify...

Best regards,
Krzysztof

