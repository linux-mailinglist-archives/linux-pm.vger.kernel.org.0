Return-Path: <linux-pm+bounces-37035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3010AC1B05F
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 14:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E1295A8E26
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 13:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4C430C609;
	Wed, 29 Oct 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou1VjCWO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558EA302161;
	Wed, 29 Oct 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744826; cv=none; b=BBspC1ngBHAxsZ79Djil4H/CRYgMOf2diltm3E9skpwMVN+8qnzQTXO+nOTt9Eime1pxi/E5uOSb2cJw/VdCDofYoNIo125zZdM1j0ddHaN6bdAa8ZpTC3RoEi6CDwvgJhTyO02+B2yTgu8kddrY4drLEVCPqUCi5BCzN2icuIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744826; c=relaxed/simple;
	bh=ZHmNvpRE/27NOb0eEnH0tbeTut2ItrA5+TdUUFpGM7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blT7SeGxknvoDOgCUWRw1MXmnYjAQPPeXzgTUU0nXX4/0hLbguuFLh/Wn56SI6jAXCRakPuTwh4HzbmDMEWQGe0IQtAtoiTcrvJ1KGr5Kj2hq9JooXH2vKIEOEi2ldh679ICRalEnqSE5AvxfCdykTNe1wwqAIZel9coKGDlFI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou1VjCWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078FAC4CEFF;
	Wed, 29 Oct 2025 13:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761744825;
	bh=ZHmNvpRE/27NOb0eEnH0tbeTut2ItrA5+TdUUFpGM7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ou1VjCWOsp1l3s9vFI6F5hFO11knjGvnOej6wvPkNlcz5O9trZBuWS6cxW8obzWkb
	 bMx37vdpUgjTmxB1gh1eVoiWHzy9/LiGlSL5LwAwAnGCSci6axkvgrSmx3KVIvRbxQ
	 IYMNOrwm9nD8i7eRIW/WLbIs7RFi0pynXPTtFmRhO0WpmqOi9pwHNWRfUkMcm59dDr
	 1DE6Df080zlVN+aRrOSPvvPx/0CyqeYw/EleSE9D7UKDMpMfH4tb3kBC/qRvroBooU
	 LcYu8vzysBKt0so2mGg1SLT7NK+fR2PoP9EpZlRpeFx4hWkqjS/6m859KMB9Mj428o
	 8GPcdUi8cgYWQ==
Message-ID: <b81502cc-d91d-4801-ad72-034c20b1c72a@kernel.org>
Date: Wed, 29 Oct 2025 14:33:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] dt-bindings: Add trickle-charge upper limit
To: Linus Walleij <linus.walleij@linaro.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Andreas Kemnade <andreas@kemnade.info>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <b13b733e7e0fba05652f49f727412fed9e0ceb02.1761564043.git.mazziesaccount@gmail.com>
 <20251029-adamant-mamba-of-patience-cddb65@kuoka>
 <a81fba66-adf0-440f-96e1-bf3a83d504d8@gmail.com>
 <CACRpkdZcszMZEU2Wzx8kaoR46ytziqtedmCrsjEL3QOrDtDgzg@mail.gmail.com>
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
In-Reply-To: <CACRpkdZcszMZEU2Wzx8kaoR46ytziqtedmCrsjEL3QOrDtDgzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/10/2025 14:26, Linus Walleij wrote:
> On Wed, Oct 29, 2025 at 7:22 AM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
> 
>>> But I believe this is wrong. Trickle charging does not switch to
>>> anything more, there is no fast charging after trickle. You have some
>>> sort of pre-pre-charging, which is just pre-charging.
>>
>> There is trickle, pre and fast-charge phases. Furthermore, the
>> fast-charge is further divided to CC and CV. Finally, if my memory
>> serves me well, Linus W did explain me that some chargers use
>> 'trickle-charging' as a _last_ charging phase for a full battery. Thus
>> the term 'trickle-charging' is slightly confusing - but it is already
>> used by the existing bindings...
>>
>> https://lore.kernel.org/all/20211116001755.2132036-1-linus.walleij@linaro.org/
> 
> I think we need to refer to a textbook or IEEE articles to get this
> terminology right.
> 
> As you say it appears "trickle-charging" is ambiguous.
> 
> Maybe what Krzysztof suggest to use: "pre-pre-charging" or
> "empty-battery-charging" or something like this is needed.
> 
> But we really need a trustworthy academic source here.

Trickle charging is accurate for both cases - pre-pre and top-off -
because it just describes very small current. That's why I found it in
many TI datasheets - mostly for Li-Ion batteries describing Matti's
case, but also in at least one case for Ni-Mh describing top-off (or
maintenance).

I am fine with the naming, but I want to be clear that this property
will describe trickle only in case of pre-pre charging. Termination
voltage simply does not fit the top-off/maintenance mode.

Best regards,
Krzysztof

