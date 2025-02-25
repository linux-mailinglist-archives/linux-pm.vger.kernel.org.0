Return-Path: <linux-pm+bounces-22892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A264CA440BB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 14:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A151624EB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 13:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6D82690DB;
	Tue, 25 Feb 2025 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afghwKL4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5006257420;
	Tue, 25 Feb 2025 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489929; cv=none; b=tSh2RgLvvrEACc9kifMqA/u7CNbzsZT+nuF2cW7jmKoBqORZyIwgteWLuK32OTp0HHkeuYs4QsvEsaAUTZddMWonq65YucSCfH+Yz+BsZnxCE30dcufhZI+Gq/W0x696NIu4s7JrLTRneU8cz3YY2Kpdu/rLIdfzE91OiQO/b/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489929; c=relaxed/simple;
	bh=MQ/HzIihWeJrPqBPMrEmNmq8jxK9pS+ZfIERMDAVCWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/Na0dcnGrKGqxrSsyMSDEXM8+jgGUh8FINROKSsFHLjMh25dyd1G6rg7Q2iBnE2wgKp0qwlGMBNjLe25+4qg29l55Jz/o8fHWxjm7DLfJAosVkJVz0bJTWJiqs8yh2I48Vv8SFclXJXPEyv4oYJ4WBcBQy3XThjEKsTilk7TBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afghwKL4; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-546210287c1so5713297e87.2;
        Tue, 25 Feb 2025 05:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740489926; x=1741094726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S290suCX82CQhBBsqJd9GKbce+6amsZtyfvkT5bRDu0=;
        b=afghwKL4XzJ6i7UDrTtWE74Q0fgNHfkvzgxD9DfCgeYSMbRxLbchToyzoJaPVC9eUl
         UP5/wBzmIeA82O03Ksz4u/HQshQcRJV7uL6eDT5ByCFdE+rdSqKULAIwK0DeQORr0OCu
         tY3cdCaB9uvf7hJ9y/sYyk4Wal17rFR+jLxcadvTafdIUqWYM0axNMDgU/H/QFt9mytG
         WMGZ/yA/cJY/JHP8wKxmZgDzXmXu+aS82mgpHxMNDlY6/Z30wGmoOqlmr5W708h8ow/N
         E1yO8UL94sZ4gYTGQ7D3FwtLe/cMBzxjGO0KFWeKMo4IPvZJRgbsW+oUSfWJBpvQhyB4
         tNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489926; x=1741094726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S290suCX82CQhBBsqJd9GKbce+6amsZtyfvkT5bRDu0=;
        b=LuLa5vWGAeyqNN+y+3qiWqSlhGCqyYiaC9VUcgjwbII1cxDVtREYGAdd8kS4ampjgD
         Zv3u6/BheHuKNHv6pZkUmxfmLJjDe71UHIzbC/T7X/7kbOfcGYfm4WT2RC8UnLivEPih
         8Wjeryf2MmXnY+jN6SMnTufQ2+JaA/2DEIUjAPwnUTNaWaNnrf6+opETYo3/nLojBLIj
         xU5CLv7hVd1aoiMX/KvtY8QpaPsFpCc64UTbvj7NyFIQh121CaRmK67IODw0NUbgrDC9
         w4jsOH+YnVQVv7QyPywFBqfPJVOkn405tj+ttVOz6B+fdD/EzVlOgRVrJUa/Jm/g62Tr
         /Cwg==
X-Forwarded-Encrypted: i=1; AJvYcCVvm8VzuWGGhyeumdzU8qrk2qvNSuF+6ibqhsy+Mmg/s+ZElTkXQ6TdZAZr4WjM4WiXScnRL/kGuN1X@vger.kernel.org, AJvYcCVzKVwUVMVpqQtWOiGTN5JI/tzs3ICCvn77zFZyhAHwhHEujElbzq/sDSUV1OC5DxRTRTpiyldnwxYi2ZI=@vger.kernel.org, AJvYcCXKKf/3IrkF5OhneC1HiQWVtFVAYXCJieV+rNZ1Nnnenxb6Ac12gsdsOHNtM5VbFp4ciqAG3xK8A8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9f0HpOTi5C2x0xMPc7qk21SuWm7oLb/VIM1fU/g/BkhkR8pLv
	FYMfYFRSuMnQAPzo+oCgcExG7tCn/TLZnzdKyYHcAvum79QmtBn3
X-Gm-Gg: ASbGncv9Nveqs+Pc/mpirR7u5kLi2SJHXMqLfoOYIiJGFQteQLsCoD5PDSRE0fKzZ/n
	FjdQ9NJnbp3xAPysn7Ei73BSSYfw/c9QDXf5dHKvO7wcXtjiQGi07gD4KBi689jj0DYLWKeXGUe
	o3eI+ro2obmNkHfKim8Hno83XAM+uyfvZjAqqWAm/kulVEU2A4AGnKIYvG/sowHdttUJsRvpMCJ
	YuwPyPtpHhnYc5xNIoPHl1itsyVvYwHZdPFgSB3pVvDgirM4Kmo+NAIBuoZUuAHxkDxvWmYbaso
	XOo5r+gd7Z+4Hjon7hoWesWxtK0V5L6B+M9SKhM=
X-Google-Smtp-Source: AGHT+IFejrBBfOFcU1sAJrwx6tnm7K9qw63EN5U2xbDg42R9CV9q19QCV8RsbFYG3hE/AEwYlTUIUw==
X-Received: by 2002:a05:6512:3b82:b0:545:2335:6597 with SMTP id 2adb3069b0e04-54839263d23mr6441551e87.50.1740489925388;
        Tue, 25 Feb 2025 05:25:25 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514f4d7dsm171988e87.174.2025.02.25.05.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:25:24 -0800 (PST)
Message-ID: <bf74173f-ccd9-43c0-a190-68512c6f63cc@gmail.com>
Date: Tue, 25 Feb 2025 15:25:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] power: supply: core: get rid of of_node
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Hans de Goede
 <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>, Samuel Holland <samuel@sholland.org>,
 David Lechner <david@lechnology.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-1-d5e4369936bb@collabora.com>
 <491e20bb-5ab4-40e9-bb35-5e05dc7bd46c@gmail.com>
 <ocbwzuqk56yx34kc5vp6aaxnhxqd4zp2wixlv7p3mex66ibntu@ahigikrf5cg4>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ocbwzuqk56yx34kc5vp6aaxnhxqd4zp2wixlv7p3mex66ibntu@ahigikrf5cg4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/02/2025 15:11, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Feb 25, 2025 at 01:14:03PM +0200, Matti Vaittinen wrote:
>> On 25/02/2025 01:21, Sebastian Reichel wrote:
>>> This removes .of_node from 'struct power_supply', since there
>>> is already a copy in .dev.of_node and there is no need to have
>>> two copies.
>>>
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>> ---
>>>    drivers/power/supply/power_supply_core.c | 17 ++++++++---------
>>>    include/linux/power_supply.h             |  1 -
>>>    2 files changed, 8 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
>>> index d0bb52a7a0367a8e07787be211691cad14a41a54..11030035da6f121ca76bebf800c06cfd5db57578 100644
>>> --- a/drivers/power/supply/power_supply_core.c
>>> +++ b/drivers/power/supply/power_supply_core.c
>>> @@ -200,11 +200,11 @@ static int __power_supply_populate_supplied_from(struct power_supply *epsy,
>>>    	int i = 0;
>>>    	do {
>>> -		np = of_parse_phandle(psy->of_node, "power-supplies", i++);
>>> +		np = of_parse_phandle(psy->dev.of_node, "power-supplies", i++);
>>>    		if (!np)
>>>    			break;
>>> -		if (np == epsy->of_node) {
>>> +		if (np == epsy->dev.of_node) {
>>>    			dev_dbg(&psy->dev, "%s: Found supply : %s\n",
>>>    				psy->desc->name, epsy->desc->name);
>>>    			psy->supplied_from[i-1] = (char *)epsy->desc->name;
>>> @@ -235,7 +235,7 @@ static int  __power_supply_find_supply_from_node(struct power_supply *epsy,
>>>    	struct device_node *np = data;
>>>    	/* returning non-zero breaks out of power_supply_for_each_psy loop */
>>> -	if (epsy->of_node == np)
>>> +	if (epsy->dev.of_node == np)
>>>    		return 1;
>>>    	return 0;
>>> @@ -270,13 +270,13 @@ static int power_supply_check_supplies(struct power_supply *psy)
>>>    		return 0;
>>>    	/* No device node found, nothing to do */
>>> -	if (!psy->of_node)
>>> +	if (!psy->dev.of_node)
>>>    		return 0;
>>>    	do {
>>>    		int ret;
>>> -		np = of_parse_phandle(psy->of_node, "power-supplies", cnt++);
>>> +		np = of_parse_phandle(psy->dev.of_node, "power-supplies", cnt++);
>>>    		if (!np)
>>>    			break;
>>> @@ -606,8 +606,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
>>>    	const __be32 *list;
>>>    	u32 min_max[2];
>>> -	if (psy->of_node) {
>>> -		battery_np = of_parse_phandle(psy->of_node, "monitored-battery", 0);
>>> +	if (psy->dev.of_node) {
>>> +		battery_np = of_parse_phandle(psy->dev.of_node, "monitored-battery", 0);
>>>    		if (!battery_np)
>>>    			return -ENODEV;
>>
>> This reminded me of a change I once did to power_supply - but maybe never
>> got it further than RFC stage. Anyways, do you think it would be possible to
>> decouple the battery info and struct power_suppply (while at it)?
>>
>> I believe that the chargers and especially fuel-gauges which are designed to
>> operate with different batteries (and which get battery details using static
>> battery nodes), would like to get the battery info _before_ registering the
>> power_supply (to avoid sending bogus values while operating on defaults,
>> before the battery info is read and before things are set accordingly).
>>
>> I know this may be a bit much to ask, but I believe it'd be an improvement.
>>
>> Other than that, looks good to me.
> 
> I was thinking about adding an init function to power_supply_desc,
> which would be called directly before psy->initialized is set to
> true in the power-supply registration phase. I think that would be
> the right place to setup device registers based on battery-info data.

Hm. I suppose that would work.

> But it's definitely not a thing for this series.

Fair enough. I thought that might be the case but decided to ask 
anyways, because, AFAIR there were no real problems what comes to not 
requiring the struct power_supply for reading the battery_info. But yes, 
I can see why killing the of_nodes is a big enough series, even without 
added complexity :)

Yours,
	-- Matti

