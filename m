Return-Path: <linux-pm+bounces-29825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60885AED8DE
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 11:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8446C1886441
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 09:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7EE246766;
	Mon, 30 Jun 2025 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z4FMDe5y"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39479244683;
	Mon, 30 Jun 2025 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751276197; cv=none; b=fEceNSYB1CO6eV19QDelqTZU3VxY5Eui5vYQH8oMCT/YK264LlsG0ZXfey/9PSkxTKgdSBujjFuVyAcxk/tuhHA7cOi+g+xb3TQhLqcZ2iE5AWIHMKuPyfeXDzjtAq6V+umJnyxopHhdFx4VoKOOvN9PCkVmpVhlrjuLyPvjb/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751276197; c=relaxed/simple;
	bh=u1wSOQ/c7/ofEu2h9hbQ/4iI7lWdBhtbLLe0jwM9Ou4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dzr9TBfTa36NdJ3ejjnS4L/ILreb41qBjRfzqw7s9fUYfkiYtCu6YH/PiH3B0bLbRaquDfca66kXkEfGYze0SOjOxUCjNoJ8fZYqlmS7I66IZwiDp8mFFM0ljz2uL4ui35HMC057vP1yTGi/iqwzplf0vx2mYFCNeuN0EGGmJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z4FMDe5y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751276193;
	bh=u1wSOQ/c7/ofEu2h9hbQ/4iI7lWdBhtbLLe0jwM9Ou4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z4FMDe5yXZNkebN+3Zo/Uj/Nqc7Zt1c/Vzh/95R+B15UKHo51B+khrudvuTItHBC8
	 SwXJacNZE16Pj0PkwP8/ySOz7KI5jlWd7sEbSS8792+SBk9JQ84KKfKeZVye5/fcQw
	 u7CjVh4/F9c04rTSg2aIh6YaheMdDXrdMY21iuHklz8GDFIaVBggjvTsMvoT/b7e1x
	 XJuRxI9ygnW59VOqoNSDB20+0rgfeY5x+bqL/UAhnAprZGxHhAJ3qg7WM6F5CnBjt7
	 hUhObydkS2dAVZ/Jquw3Y35aS6w4mCJO4ksHagkXS8IvznaP88k/yuXcM8u3ojtCkC
	 Yrbj0FQZx5zKQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6FF5317E0342;
	Mon, 30 Jun 2025 11:36:32 +0200 (CEST)
Message-ID: <e59b2bbb-ee1e-42b5-9516-f2e545dbf700@collabora.com>
Date: Mon, 30 Jun 2025 11:36:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/13] dt-bindings: power: mediatek: Document
 mediatek,bus-protection
To: Rob Herring <robh@kernel.org>
Cc: linux-mediatek@lists.infradead.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, ulf.hansson@linaro.org,
 y.oudjana@protonmail.com, fshao@chromium.org, wenst@chromium.org,
 lihongbo22@huawei.com, mandyjh.liu@mediatek.com, mbrugger@suse.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 kernel@collabora.com
References: <20250623120154.109429-1-angelogioacchino.delregno@collabora.com>
 <20250623120154.109429-2-angelogioacchino.delregno@collabora.com>
 <20250627201543.GA4171766-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250627201543.GA4171766-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/06/25 22:15, Rob Herring ha scritto:
> On Mon, Jun 23, 2025 at 02:01:42PM +0200, AngeloGioacchino Del Regno wrote:
>> Add a new mediatek,bus-protection property in the main power
>> controller node and deprecate the old mediatek,infracfg,
>> mediatek,infracfg-nao and mediatek,smi properties located in
>> the children.
>>
>> This is done in order to both simplify the power controller
>> nodes and in preparation for adding support for new generation
>> SoCs like MT8196/MT6991 and other variants, which will need
>> to set protection on new busses.
> 
> Protection like access controls? We have the access-controller binding
> for that.
> 

I was not aware of that - but that's *so* cool.

 From a very (very, very) fast look, it looks like that fits this case perfectly.
I'll check if that's right and will come up with a v2 for that.

Thanks a lot!
Angelo

>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../power/mediatek,power-controller.yaml      | 40 +++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> index 9c7cc632abee..2530c873bb3c 100644
>> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> @@ -44,6 +44,18 @@ properties:
>>     '#size-cells':
>>       const: 0
>>   
>> +  mediatek,bus-protection:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      A number of phandles to external blocks to set and clear the required
>> +      bits to enable or disable bus protection, necessary to avoid any bus
>> +      faults while enabling or disabling a power domain.
>> +      For example, this may hold phandles to INFRACFG and SMI.
>> +    minItems: 1
>> +    maxItems: 3
>> +    items:
>> +      maxItems: 1
>> +
>>   patternProperties:
>>     "^power-domain@[0-9a-f]+$":
>>       $ref: "#/$defs/power-domain-node"
>> @@ -123,14 +135,17 @@ $defs:
>>         mediatek,infracfg:
>>           $ref: /schemas/types.yaml#/definitions/phandle
>>           description: phandle to the device containing the INFRACFG register range.
>> +        deprecated: true
>>   
>>         mediatek,infracfg-nao:
>>           $ref: /schemas/types.yaml#/definitions/phandle
>>           description: phandle to the device containing the INFRACFG-NAO register range.
>> +        deprecated: true
>>   
>>         mediatek,smi:
>>           $ref: /schemas/types.yaml#/definitions/phandle
>>           description: phandle to the device containing the SMI register range.
>> +        deprecated: true
>>   
>>       required:
>>         - reg
>> @@ -138,6 +153,31 @@ $defs:
>>   required:
>>     - compatible
>>   
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - mediatek,mt8183-power-controller
>> +    then:
>> +      properties:
>> +        mediatek,bus-protection:
>> +          minItems: 2
>> +          maxItems: 2
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - mediatek,mt8365-power-controller
>> +    then:
>> +      properties:
>> +        mediatek,bus-protection:
>> +          minItems: 3
>> +          maxItems: 3
>> +
>>   additionalProperties: false
>>   
>>   examples:
>> -- 
>> 2.49.0
>>

