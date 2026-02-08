Return-Path: <linux-pm+bounces-42257-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GECfMCtgiGktpAQAu9opvQ
	(envelope-from <linux-pm+bounces-42257-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 11:06:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C951084EF
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 11:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21111300B775
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A1933CEAF;
	Sun,  8 Feb 2026 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liWewoni"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870338DF9;
	Sun,  8 Feb 2026 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770545192; cv=none; b=NzPDIoeOA0xJyRxjxZ6jh3Aak4pLzG2B7R0BclsI3ctlfGptYGHf+vkFr8b1ifRQEs20DGjGCKPg9uQWvObnzWZLOyjuc7DiDrs27FmP4NfWQYBFZUeavlpmxCKFlM9V+IAt+Cig/aeVFYoPGJYhUsY4z8MpwclOTAGXQazHQIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770545192; c=relaxed/simple;
	bh=/+sR5eQuNf6DfxGVY8NJs9rtxBg82DyCHLCcjJQKYYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upmiMs6N9/sfJD7bbwdCl1xDx9CzEusqePYqxPCt/VWwUamPzCUn8mgqcf7FWWD5lxyxV39yMRgPrtMLjhLSV7uOYrFGwfMrtZNQblpomxHu8IA+bZTceJXhJEm9xYNjCaQcm0rO/FWRpCYIGGsbAGlsQJ9nzDsZbNrzt5mCOb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liWewoni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDFBC4CEF7;
	Sun,  8 Feb 2026 10:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770545192;
	bh=/+sR5eQuNf6DfxGVY8NJs9rtxBg82DyCHLCcjJQKYYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=liWewoniNCTe1uyynIQvxMGNX7D3JITKyThZ7D6v6y7uISyy25T+qxl7OAYTymnU7
	 yYpQgklG1Ho9ho7KW79Sl8msGuBjJ8FDbGFTn500ohf5Y13FHYz/79rmMIAX8jBEwJ
	 tLkUr74ZIlrhxxK5mUciXceFQ0R6Wrd3/947uOw2ijDXIvePZlqLJuDdrD4ar5ANiE
	 KPc9dgQYJIVxNeYxiCaz7c9RehHnZYFkkDoTYU4JXhEzQNHe7T+WbOpVUz8XGbhrFm
	 dwVaRnb6oif2Dlz6UnTLJmgQm0uiDu86CvVWMRl+1Lf4e0aMfzc5zKY62Wt2fAAt2j
	 KkHJ3Uy8FNTeg==
Message-ID: <546faeda-d896-403c-a449-5c9b0cd7159e@kernel.org>
Date: Sun, 8 Feb 2026 11:06:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
 casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 manaf.pallikunhi@oss.qualcomm.com
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
 <20260127155722.2797783-3-gaurav.kohli@oss.qualcomm.com>
 <20260128-whispering-caracal-of-respect-a26638@quoll>
 <36706481-2549-4716-8e6d-0e4db42591a2@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <36706481-2549-4716-8e6d-0e4db42591a2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42257-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42C951084EF
X-Rspamd-Action: no action

On 29/01/2026 13:06, Gaurav Kohli wrote:
> 
> On 1/28/2026 4:57 PM, Krzysztof Kozlowski wrote:
>> On Tue, Jan 27, 2026 at 09:27:16PM +0530, Gaurav Kohli wrote:
>>> The cooling subnode of a remoteproc represents a client of the Thermal
>>> Mitigation Device QMI service running on it. Each subnode of the cooling
>>> node represents a single control exposed by the service.
>>>
>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>> ---
>>>   .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
>>>   .../bindings/thermal/qcom,qmi-cooling.yaml    | 72 +++++++++++++++++++
>>>   2 files changed, 78 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>> index 68c17bf18987..6a736161d5ae 100644
>>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>> @@ -80,6 +80,12 @@ properties:
>>>         and devices related to the ADSP.
>>>       unevaluatedProperties: false
>>>   
>>> +  cooling:
>>> +    $ref: /schemas/thermal/qcom,qmi-cooling.yaml#
>>> +    description:
>>> +      Cooling subnode which represents the cooling devices exposed by the Modem.
>> I do not see the reason why you need 3 (!!!) children here. Everything
>> should be folded here.
> 
> 
> Thanks Krzysztof for review.
> 
> Each subsystem may support multiple thermal mitigation devices through 
> remote TMD service.
> 
> Because of this multiplicity, introduced separate binding file.

This explains nothing. Subsystem does not matter for the binding. My
comment stays.

> 
>>> +    unevaluatedProperties: false
>>> +
>>>   required:
>>>     - clocks
>>>     - clock-names
>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>> new file mode 100644
>>> index 000000000000..0dd3bd84c176
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>> @@ -0,0 +1,72 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/thermal/qcom,qmi-cooling.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm QMI based thermal mitigation (TMD) cooling devices
>>> +
>>> +maintainers:
>>> +  - Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>> +
>>> +description:
>>> +  Qualcomm QMI-based TMD cooling devices are used to mitigate thermal conditions
>>> +  across multiple remote subsystems. These devices operate based on junction
>>> +  temperature sensors (TSENS) associated with thermal zones for each subsystem.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - qcom,qmi-cooling-cdsp
>>> +      - qcom,qmi-cooling-cdsp1
>> What are the differences between them?
> 
> 
> Some SOcs support multiple CDSP/NSP instances. Each instance requires 
> it's own
> 
> compatible string to distinguish.

Why? What are the differences?

I will not ask third time, but just respond with NAK.

> 
> 
>> Why these are not SoC specific?
> 
> 
> They are not soc specific because the qmi thermal mitigation interface 
> exposed by CDSP is architecturally
> 
> identical across multiple SOCS.

I have doubts on that but anyway if you want exception from standard
compatible rules you must come with arguments in terms of hardware and
firmware. Above is not enough. Everyone claims that.

> 
> 
>>> +
>>> +patternProperties:
>>> +  "cdsp-tmd[0-9]*$":
>>> +    type: object
>> No, you do not need childnode. See writing bindings (covers exactly this
>> case).
> 
> 
> Each subsystem may support multiple thermal mitigation devices through 
> remote TMD service. So
> 
> need childnode to distinguish for different mitigations.

NAK



Best regards,
Krzysztof

