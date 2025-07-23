Return-Path: <linux-pm+bounces-31344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD70DB0F6EB
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 17:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E9D3B0D1B
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78A52F5C28;
	Wed, 23 Jul 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIyBMyF9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242F2EA47C;
	Wed, 23 Jul 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284260; cv=none; b=UfjcWlydIGr1TYZH7uj64+uFzkwIItFSWeJJqEVeb/o+IFNDZjcbZzzzboR1Btc81GzwIqB1rzE/hiUPNDeXa70YyDf0pjLJJyg6z8fKy5usJSBH8gmizzKMnAowfvbJU2hlBQuLAOxu5+bGJLE8Zmra4mSPrLbrOfCGtvN1HRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284260; c=relaxed/simple;
	bh=wFEIE9VSNvWmkbW5qAZ2gSwhI6+Fb9AYepbdUVCFWAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPDC/WE+SeXAB9mt5l+yQLEToP6C/ed9JoD8Y5VrR890hF9UpW2nhMNvahFU9bAOlEeQE96PCUcYgAJuHUNK8IRcBCyMQ0gDO8qGl7H2Ab5DPDLPV9+juOE0Nv25Oe73e2+4OJXqrdj4Rm8wHDBdxPlXYUX4I/+ngicik7lQkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIyBMyF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7261FC4CEE7;
	Wed, 23 Jul 2025 15:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753284260;
	bh=wFEIE9VSNvWmkbW5qAZ2gSwhI6+Fb9AYepbdUVCFWAM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UIyBMyF9b0+YcURO5ngVPdngZeZooDp/9n6bY7RXp8kguVCZq8x96aAh01+AbUjsY
	 0dIqkpkR4Vgrg/hI/MZQkbTBTJN+AI48gJqmAO4CtVq2wy5Zk7yQTHl5lgBNE5u7gw
	 OtDN0x+1T/pIfj5f4q0p4bcZvxCNlU2JdOuLP+dqXzKsR7LNkCtYxSE3AAEJQcblJP
	 kM5Bu26gwA9WcZpXBppOOq+GpohxmJ1A5zNgGw4vWIJ+7Ge0BBtFv1ZVT1frnZVH7f
	 DUWOL4Ku3RXxxFRKEtHgVLWdTULiGds9N7CUWMWbZDr2HKuIbEFNzPxBtFlWC3V37j
	 oTXFuMlPTWEJg==
Message-ID: <f6d1097a-9c45-477d-96e7-b297d29db4e6@kernel.org>
Date: Wed, 23 Jul 2025 18:24:11 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] interconnect: qcom: Add Milos interconnect
 provider driver
To: Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250709-sm7635-icc-v3-0-c446203c3b3a@fairphone.com>
 <20250709-sm7635-icc-v3-2-c446203c3b3a@fairphone.com>
 <d8955532-9a3b-451f-b5c7-549cee7d749e@kernel.org>
 <DBHKBSK14XHM.E3ZUQMEJKEOJ@fairphone.com>
 <DBJ9QNML12CU.1RONWUJAZHQK7@fairphone.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <DBJ9QNML12CU.1RONWUJAZHQK7@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luca,

On 7/23/25 10:50 AM, Luca Weiss wrote:
> Hi Georgi,
> 
> On Mon Jul 21, 2025 at 9:42 AM CEST, Luca Weiss wrote:
>> Hi Georgi,
>>
>> On Mon Jul 21, 2025 at 9:36 AM CEST, Georgi Djakov wrote:
>>> Hi Luca,
>>>
>>> On 7/9/25 4:14 PM, Luca Weiss wrote:
>>>> Add driver for the Qualcomm interconnect buses found in Milos based
>>>> platforms. The topology consists of several NoCs that are controlled by
>>>> a remote processor that collects the aggregated bandwidth for each
>>>> master-slave pairs.
>>>>
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> ---
>>>>    drivers/interconnect/qcom/Kconfig  |    9 +
>>>>    drivers/interconnect/qcom/Makefile |    2 +
>>>>    drivers/interconnect/qcom/milos.c  | 1837 ++++++++++++++++++++++++++++++++++++
>>>>    3 files changed, 1848 insertions(+)
>>>>
>>> [..]
>>>> +
>>>> +static struct qcom_icc_node qhm_qup1 = {
>>>> +	.name = "qhm_qup1",
>>>> +	.channels = 1,
>>>> +	.buswidth = 4,
>>>> +	.qosbox = &qhm_qup1_qos,
>>>> +	.link_nodes = { &qns_a1noc_snoc, NULL },
>>>> +};
>>>
>>> It's very nice that you switched to the dynamic IDs, but please use the
>>> current style of links (like in v1), as the the NULL terminated lists
>>> are not merged yet. All the rest looks good!
>>
>> Is what's in todays linux-next a good base? Or what branch should I base
>> this on? But correct, I currently have v2 of dynamic ID patches in the
>> base for this.
>>
>> Also If I send the next revision by e.g. Wednesday can it still go into
>> 6.17? Just wondering how quick I need to work on this.
> 
> In case you didn't receive my message on IRC, your icc-milos branch plus
> the following patch works fine:
> https://public.lucaweiss.eu/tmp/0001-fixup-interconnect-qcom-Add-Milos-interconnect-provi.patch

Thanks for the fixup!

BR,
Georgi


