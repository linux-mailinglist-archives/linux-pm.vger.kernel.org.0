Return-Path: <linux-pm+bounces-40082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F0ACEB73A
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 08:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 555F1300A3C9
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 07:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC08B312810;
	Wed, 31 Dec 2025 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxDdke0d"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C8312807;
	Wed, 31 Dec 2025 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767166545; cv=none; b=gY0C7htjFr14BrJFWtkUIBkkPYsTB4l3+erbTTo3UlPFjxtxwcSJhZud/4fPvv0ycgHuAfA+sKiMVfoxeb7NNUggvXqXN6F/902HbhWYY5eYCVuVmgwUGqZotM/L0wkUFOihiAZfPa7UOMaq2v5POLmSCXC6apAYBoeFsNcqjmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767166545; c=relaxed/simple;
	bh=1AenhKR4d8hspoZcBaphYi5N/OZ6PG2k0sT1YnE8T60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjDCfEFl08uPCtMbRofT/TdluxnPPYfFCXvyxZa+jxGj1Shes8FY1ct77MdMDTSjLI23tHTsUHyxTOyj93R1m4na15v6RDEVf6MJh0CN9MywUPYFTiKu6F6LX3SJP0gwK1di1Wzf0Nr2XR5JLmpKJrncH+p3D9z+iy69P6mu7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxDdke0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62972C113D0;
	Wed, 31 Dec 2025 07:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767166545;
	bh=1AenhKR4d8hspoZcBaphYi5N/OZ6PG2k0sT1YnE8T60=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HxDdke0dbgv/hIfKX3LAf7+mwhRYkKxwzzMfML7GnvB9zpn3VZN2ZxsXhppveG7iu
	 fdfDoxGlJKhCxllakM0EBTFijOL2q4biGY5EX634cmBOn1r0yRSdNgplspTvhRSYpb
	 iFB8dzZrj6Bv5a8NnD/3vmXTPaT6eaPsLTQyMiT5TFcYraY6L0Yah+CP8XggkL9Awc
	 pHxSYMudkp1AzBiEn+r7dKLzmfyJNAh0GFY9inrtPhPRlRWn3NYbTpk9zp9X71PgJ0
	 3mYsgtg/bUWzAsIlcKfvK5nzZx9jbtUpbiePLZ4ftIM6S92JfQdHCw/8ODcLVr7CPr
	 lJ8uukcEUKOig==
Message-ID: <78ff2456-adb0-4368-9654-79e01e7157ce@kernel.org>
Date: Wed, 31 Dec 2025 08:35:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
 rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
 amitk@kernel.org, mani@kernel.org, casey.connolly@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com>
 <f6bd1bda-6aab-4d4e-9981-f55cce03f70d@kernel.org>
 <3fc177ca-0260-471d-b7a4-bd479f5e5855@oss.qualcomm.com>
 <60653b06-38c4-4276-a6e5-4a5900ba19d4@kernel.org>
 <74b33eb5-a75b-479e-92b3-cb6e094e5610@oss.qualcomm.com>
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
In-Reply-To: <74b33eb5-a75b-479e-92b3-cb6e094e5610@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/12/2025 07:42, Gaurav Kohli wrote:
> 
> On 12/24/2025 3:54 PM, Krzysztof Kozlowski wrote:
>> On 24/12/2025 11:08, Gaurav Kohli wrote:
>>> On 12/24/2025 2:27 PM, Krzysztof Kozlowski wrote:
>>>> On 23/12/2025 13:32, Gaurav Kohli wrote:
>>>>> The cooling subnode of a remoteproc represents a client of the Thermal
>>>>> Mitigation Device QMI service running on it. Each subnode of the cooling
>>>>> node represents a single control exposed by the service.
>>>>>
>>>>> Add maintainer name also and update this binding for cdsp substem.
>>>>>
>>>>> Co-developed-by: Casey Connolly <casey.connolly@linaro.org>
>>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>>>> ---
>>>>>    .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
>>>>>    .../bindings/thermal/qcom,qmi-cooling.yaml    | 99 +++++++++++++++++++
>>>>>    2 files changed, 105 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>>>> index 63a82e7a8bf8..bbc82253f76b 100644
>>>>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>>>> @@ -77,6 +77,12 @@ properties:
>>>>>          and devices related to the ADSP.
>>>>>        unevaluatedProperties: false
>>>>>    
>>>>> +  cooling:
>>>>> +    $ref: /schemas/thermal/qcom,qmi-cooling.yaml#
>>>>> +    description:
>>>>> +      Cooling subnode which represents the cooling devices exposed by the Modem.
>>>>> +    unevaluatedProperties: false
>>>>> +
>>>>>    required:
>>>>>      - clocks
>>>>>      - clock-names
>>>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..90b46712d241
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>>>> @@ -0,0 +1,99 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>> +# Copyright 2023 (c), Linaro Limited
>>>>> +
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/thermal/qcom,qmi-cooling.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Qualcomm QMI based thermal mitigation (TMD) cooling devices.
>>>>> +
>>>>> +maintainers:
>>>>> +  - Caleb Connolly <caleb.connolly@linaro.org>
>>>>> +  - Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>>> +
>>>>> +description:
>>>>> +  Qualcomm QMI-based TMD cooling devices are used to mitigate thermal conditions
>>>>> +  across multiple remote subsystems. These devices operate based on junction temperature
>>>>> +  sensors (TSENS) associated with thermal zones for each subsystem.
>>>>> +
>>>>> +  Each subnode corresponds to a control interface for a single instance of the TMD
>>>>> +  service running on a remote subsystem.
>>>>> +
>>>>> +definitions:
>>>> defs, look at other code
>>>>
>>>>
>>>>> +  tmd:
>>>>> +    type: object
>>>>> +    description: |
>>>>> +      A single Thermal Mitigation Device exposed by a remote subsystem.
>>>> Missing proper formatting. Please do not send us code written by LLM.
>>>
>>> This patch is based on older series
>>>
>>> https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/, did some manual changes to remove unusable code.
>> How? This is v1, not v2. How did you address other comments? Where did
>> you provide proper changelog? Why this is not correctly versioned/
>>
>>> let me fix the formatting. This is not generated code.
>> I do not believe, because this:
>>
>>
>>>>> +      phandle: true
> 
> 
> As i have mentioned in earlier reply, we are including below series:
> 
> https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/,) 
> as this is client for remote proc cooling.
> I was seeing this error while using older yam files.
> 
> ('cdsp_sw' was unexpected)

cdsp_sw, not phandle.

> 
> from schema qcom,qmi-cooling.yaml
> 
> So to avoid that, i have added phandle to avoid this error. will fix 


Why? AGAIN: SUCH CODE DOES NOT EXIST. Why do you introduce code
completely different than everything else?


Best regards,
Krzysztof

