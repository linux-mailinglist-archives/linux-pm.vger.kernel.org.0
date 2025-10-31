Return-Path: <linux-pm+bounces-37226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E57C268C8
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 19:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E60423CA7
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 18:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3FF354ACD;
	Fri, 31 Oct 2025 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TzgpNHyK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CEH3HQeM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TzgpNHyK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CEH3HQeM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580FB351FC0
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761934931; cv=none; b=lySfGlWgVzo32ieA3/Bt7SOMrjuTZiK8MgjQD6PW6h/RQwSGzW1eS+t7iUxl7oZU0XlYsLFtAU/VtTj8KbNlnrIkvP+KB/fd7wiiZm/eLmh0fUxc1AsQSnVvkklfcdKSJqqh4DIyc3TZ3YpdopRAegzaW6VBxclowcb/6OdaiFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761934931; c=relaxed/simple;
	bh=ivxC6rH3aWZdDf91ZyEVWpF+MAQfTwbgZSJgH5XVPfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahNQR1Djh2THpg/CpADH/jk8c8YMl6qHDTzjkMYX5DqUjlblqATB7pMoS1+0iiyAlZhrmVMEWjbS6B9oYjdKberLRFxairvhECDp2DW/VaB2T/cEIVNZs1NuiduxH+xZZLlyXX90HtXXA8es3bs19C3VtPlo5iaJ1v1tKPOT6Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TzgpNHyK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CEH3HQeM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TzgpNHyK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CEH3HQeM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 433DE223E4;
	Fri, 31 Oct 2025 18:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761934926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jessRx6TNC0QixhPKRj2h5XBAo+ylMyAf01j+QDGZrw=;
	b=TzgpNHyKZcFSDWwunMLd2X71Jgz9ba03UiBxZQcLzDelaJP6atFhs4LA0UDe8oMvUnDgwp
	PXC4sOOnEzEEwiKdsskYEq54s11zaGrTZsRRvvU0ig797fLdg+pXn4i0rHIPxMGOQUoN6l
	l6wrLEjXKj2RmV1xsZ8efQstlGY02JY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761934926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jessRx6TNC0QixhPKRj2h5XBAo+ylMyAf01j+QDGZrw=;
	b=CEH3HQeMT3rUTyh+KA1JIrTOUkOIE/w2GWcujKzHW1fp1rCI2mIJMdd52lszF9KohAiG1t
	YyI7HhGigbhCIZBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761934926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jessRx6TNC0QixhPKRj2h5XBAo+ylMyAf01j+QDGZrw=;
	b=TzgpNHyKZcFSDWwunMLd2X71Jgz9ba03UiBxZQcLzDelaJP6atFhs4LA0UDe8oMvUnDgwp
	PXC4sOOnEzEEwiKdsskYEq54s11zaGrTZsRRvvU0ig797fLdg+pXn4i0rHIPxMGOQUoN6l
	l6wrLEjXKj2RmV1xsZ8efQstlGY02JY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761934926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jessRx6TNC0QixhPKRj2h5XBAo+ylMyAf01j+QDGZrw=;
	b=CEH3HQeMT3rUTyh+KA1JIrTOUkOIE/w2GWcujKzHW1fp1rCI2mIJMdd52lszF9KohAiG1t
	YyI7HhGigbhCIZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A086D13991;
	Fri, 31 Oct 2025 18:22:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1SBoJU3+BGn3bwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 31 Oct 2025 18:22:05 +0000
Message-ID: <309707dc-43e6-4c2c-9547-cbfce2e9e1fb@suse.de>
Date: Fri, 31 Oct 2025 20:22:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: soc: bcm: Add bcm2712 compatible
To: Conor Dooley <conor@kernel.org>, Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-pm@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Lee Jones <lee@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Willow Cunningham <willow.e.cunningham@gmail.com>,
 Stefan Wahren <wahrenst@gmx.net>, Saenz Julienne <nsaenz@kernel.org>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20251031102423.1150093-1-svarbanov@suse.de>
 <20251031102423.1150093-3-svarbanov@suse.de>
 <20251031-icon-woozy-58061dd3d4b4@spud>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20251031-icon-woozy-58061dd3d4b4@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,broadcom.com,kernel.org,linaro.org,gmail.com,gmx.net,suse.com,raspberrypi.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Hi Conor,

On 10/31/25 5:04 PM, Conor Dooley wrote:
> On Fri, Oct 31, 2025 at 12:24:21PM +0200, Stanimir Varbanov wrote:
>> Add bcm2712-pm compatible and update the bindings to satisfy it's
>> requirements. The PM hardware block inside bcm2712 lacks the "asb"
>> and "rpivid_asb" register ranges and also does not have clocks, update
>> the bindings accordingly.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>  .../bindings/soc/bcm/brcm,bcm2835-pm.yaml     | 38 ++++++++++++++++---
>>  1 file changed, 32 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
>> index e28ef198a801..ce910802ee9d 100644
>> --- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
>> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
>> @@ -13,23 +13,21 @@ description: |
>>  maintainers:
>>    - Nicolas Saenz Julienne <nsaenz@kernel.org>
>>  
>> -allOf:
>> -  - $ref: /schemas/watchdog/watchdog.yaml#
>> -
>>  properties:
>>    compatible:
>>      items:
>>        - enum:
>>            - brcm,bcm2835-pm
>>            - brcm,bcm2711-pm
>> +          - brcm,bcm2712-pm
>>        - const: brcm,bcm2835-pm-wdt
>>  
>>    reg:
>> -    minItems: 2
>> +    minItems: 1
>>      maxItems: 3
>>  
>>    reg-names:
>> -    minItems: 2
>> +    minItems: 1
>>      items:
>>        - const: pm
>>        - const: asb
>> @@ -62,7 +60,35 @@ required:
>>    - reg
>>    - "#power-domain-cells"
>>    - "#reset-cells"
>> -  - clocks
>> +
>> +allOf:
>> +  - $ref: /schemas/watchdog/watchdog.yaml#
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - brcm,bcm2835-pm
>> +              - brcm,bcm2711-pm
>> +    then:
>> +      required:
>> +        - clocks
>> +
>> +      properties:
>> +        reg:
>> +          minItems: 2
>> +
>> +        reg-names:
>> +          minItems: 2
> 
>> +
>> +    else:
>> +      properties:
>> +        reg:
>> +          minItems: 1
>> +
>> +        reg-names:
>> +          minItems: 1
> 
> This else has no impact, was it meant to be maxItems?

Oops, yes it should be maxItems. Sending new version ...

~Stan


