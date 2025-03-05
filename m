Return-Path: <linux-pm+bounces-23482-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF78EA4FDC3
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 12:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD027A4275
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 11:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57686241107;
	Wed,  5 Mar 2025 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNzwL2Ap"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D791C5F27;
	Wed,  5 Mar 2025 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174526; cv=none; b=XRTagposjHBZL8X2rD8uZUYfcg6VitBGVEo3LusLXvlsPCiWNnpKs+uL9llf4xVijhZ20xpPxlbRZZrPVV3PyP2o7g+vxVZsm2W3Fy0t97wSwBPslTaT78XzeyiMmBMcv0jLYyUOL2GkK62408jOLh1uBLDwi3dhN++KEe+JMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174526; c=relaxed/simple;
	bh=5wKZo1W3/KKJwo73d2ABuM4lG0wjBbXCHJqMn98euFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eR9OZKhc3kwjEo0bG7TO39EtaoQO1jOlzFANfFHagavY9r5MUX3tCfS9m2vc6ZArkKs/jfUShRfZNoqMD4JcqwpkAqm/+hltkJ/xDAhhhSMA5MS1wo/yiBN4KC8xjoqJCveS489c9NU7oR5+fNq75knjlILApjxZUzztFpsideo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNzwL2Ap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD229C4CEE2;
	Wed,  5 Mar 2025 11:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741174525;
	bh=5wKZo1W3/KKJwo73d2ABuM4lG0wjBbXCHJqMn98euFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HNzwL2Apz+ImWcI9E449fJ1uUCaPdrWT870QqZwQokeyeALzznCrATR+82SLgP5iR
	 PNTj+ohzDf0Us/J46qONWbe9bakWDrN1d/DSgee/1e3NhX4sFWZ/vAVhJk9wwHzW21
	 TmWMPE3apeOd993whfLADD6duv2C2uwBlf5MRjOuDIXMxf8tiWyj+Ft37yVK9ZrVPA
	 lUTpnlqwIbVv8M020yEbOpnF74F99Tu4zzBx1DFMpW0MzXg27I0BZ6MQoRE6sX6bkt
	 Vy48TaeHTxQI3sStfR6kbPjOeajO9cjOxotx/vyq8T5/lW+XWPmD2pOC8l5XjOZ/kQ
	 4bjv6EnaztQsQ==
Message-ID: <c7129d8e-87de-444c-be52-b2eedf03585f@kernel.org>
Date: Wed, 5 Mar 2025 12:35:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] dt-bindings: soc: imx93-media-blk-ctrl: Add LDB
 subnode into schema and example
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@ew.tq-group.com, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
 <20250304154929.1785200-3-alexander.stein@ew.tq-group.com>
 <20250305-dandelion-axolotl-of-excitement-05fa70@krzk-bin>
 <4414669.ejJDZkT8p0@steina-w>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <4414669.ejJDZkT8p0@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/03/2025 10:02, Alexander Stein wrote:
> Hi,
> 
> Am Mittwoch, 5. März 2025, 08:13:04 CET schrieb Krzysztof Kozlowski:
>> On Tue, Mar 04, 2025 at 04:49:21PM +0100, Alexander Stein wrote:
>>> Document the LDB bridge subnode and add the subnode into the example.
>>> For the subnode to work, the block control must scan its subnodes and
>>
>> Don't describe drivers, but describe the hardware.
> 
> Thanks, I'll rephrase to describe the hardware better regarding LVDS.
> 
>>
>>> bind drivers to them, do not misuse either simple-bus or simple-mfd
>>> here.
>>
>> I don't understand that simple-bus or simple-mfd statement. There are no
>> such compatibles here.
> 
> Same as above, the wording stems from 1cb0c87d27dcc ("dt-bindings: soc:
> imx8mp-media-blk-ctrl: Add LDB subnode into schema and example").
> I'll drop it to avoid confusion.
> 
>>
>>>
>>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>>> ---
>>>  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 51 +++++++++++++++++++
>>>  1 file changed, 51 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
>>> index b3554e7f9e76d..cd785111928bf 100644
>>> --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
>>> @@ -24,6 +24,14 @@ properties:
>>>    reg:
>>>      maxItems: 1
>>>  
>>> +  ranges: true
>>> +
>>> +  '#address-cells':
>>> +    const: 1
>>> +
>>> +  '#size-cells':
>>> +    const: 1
>>> +
>>>    '#power-domain-cells':
>>>      const: 1
>>>  
>>> @@ -46,9 +54,20 @@ properties:
>>>        - const: csi
>>>        - const: dsi
>>>  
>>> +  bridge@20:
>>
>> @20 looks wrong. Use 'ranges;' and try again your DTS...
>>
>> Binding is supposed to be complete. We have several examples when people
>> added children one-by-one, everytime with different reasoning about
>> child addressing.
>>
>> So please confirm: this is complete and no other children will ever be
>> added here... or you are 100% sure that all future children will be
>> unit-addressable (will have unit address and appropriate properties).
> 
> This block control is a collection of registers for different purposes:
> * MIPI-DSI
> * MIPI-CSI
> * Parallel camera
> * LVDS
> * CAMERA_MUX
> 
> At lease for parallel camera, another subnode is expected ([1]).


That one at least have MMIO as well. No I wonder whether the others will
come without MMIO one day.

Why this cannot be sent all at once? Entire device binding?

> 
> [1] https://lore.kernel.org/all/20240819024001.850065-1-victor.liu@nxp.com/
> 
>> BTW, I don't quite get why this is both syscon and has translation for
>> child addresses. Does it mean your child does not use the same MMIO as
>> parent, thus leading to unsynchronized reg access?
> 
> I'm not sure what the best practices are. This LDB has two registers
> inside this block. So it seems reasonable to me to indicate this using

reg is fine, but you added ranges which means there is translation
between child addressing and parent MMIO. Usually, although not always,
when child is expected to use parent's syscon, you do not have ranges,
because the syscon deals with that translation.

What's more, your @20 means you depend on one specific value of ranges.

I would just skip the ranges and claim there is no direct mapping of
addresses. Reg defines offsets within this device addressing and this
device will handle it.

> a reg property. On the other hand, access is solely done by accessing
> via syscon, so unsynchronized reg access is not an issue.
> 
> What I am getting from your comments this node should not have 'reg'
> property, as it uses syscon anyway.


> 
>>> +    type: object
>>> +    additionalProperties: true
>>> +    properties:
>>> +      compatible:
>>> +        contains:
>>> +          const: fsl,imx93-ldb
>>> +
>>>  required:
>>>    - compatible
>>>    - reg
>>> +  - ranges
>>> +  - '#address-cells'
>>> +  - '#size-cells'
>>>    - power-domains
>>>    - clocks
>>>    - clock-names
>>> @@ -77,4 +96,36 @@ examples:
>>>                 clock-names = "apb", "axi", "nic", "disp", "cam",
>>>                               "pxp", "lcdif", "isi", "csi", "dsi";
>>>        #power-domain-cells = <1>;
>>> +      #address-cells = <1>;
>>> +      #size-cells = <1>;
>>> +      ranges = <0x0 0x4ac10000 0x10000>;
>>> +
>>> +      bridge@20 {
>>> +          compatible = "fsl,imx93-ldb";
>>> +          reg = <0x20 0x4>, <0x24 0x4>;
>>> +          reg-names = "ldb", "lvds";
>>> +          clocks = <&clk IMX93_CLK_LVDS_GATE>;
>>> +          clock-names = "ldb";
>>> +
>>> +          ports {
>>> +              #address-cells = <1>;
>>> +              #size-cells = <0>;
>>> +
>>> +              port@0 {
>>> +                  reg = <0>;
>>> +
>>> +                  ldb_from_lcdif2: endpoint {
>>> +                      remote-endpoint = <&lcdif2_to_ldb>;
>>> +                  };
>>> +              };
>>> +
>>> +              port@1 {
>>> +                  reg = <1>;
>>> +
>>> +                  ldb_lvds: endpoint {
>>> +                      remote-endpoint = <&ldb_to_panel>;
>>> +                  };
>>> +              };
>>> +          };
>>
>> Messed indentation.
> 
> This is already from the original binding. I'll fix in a separate commit.

How? I did not see any '-', only adding here.


Best regards,
Krzysztof

