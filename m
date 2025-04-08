Return-Path: <linux-pm+bounces-24967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E128A8161D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 21:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A054C5C5E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 19:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B0524BBFA;
	Tue,  8 Apr 2025 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmZ9s3+S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A4F2417D8
	for <linux-pm@vger.kernel.org>; Tue,  8 Apr 2025 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142075; cv=none; b=TRVzmHHQR2X2/qQJPSiS/94X28sFyy7YyvunwqlMc7TrnACKefGNr/j3+VZ9K9bnObyACa1edqh1fPmHgyuqFu0wXULq2VeortjHfpZKZEsxHtw/jbhWtYcBTbNhTvKkJ5xwYBOcEQtZtqrV8Un786rIgPtZOSARneJnHRrx838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142075; c=relaxed/simple;
	bh=+4iqyUTi0E7UltQIdQPFstwrYJASj34CNxi5y1rMv0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPxpAL+mkC3kH9yeTOFE54G72xTYiwBm5uAYmFZ+T+KcznYQGPi8EIuPa1SuvD/LlXYHfK4GvK1UO2WirMBS4S+NYLDhH3m+4HnXtUORXcW/2jNVy1O/AYWcxf8kUScewV9bGUw0vhJUJq94MswjrVsyBIx5ZwCc+5MMqAYex14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vmZ9s3+S; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736b350a22cso5359526b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Apr 2025 12:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744142071; x=1744746871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBGk/fKPNmRqrd1bCAlViX+nWV4o6WwNupDuItfdSOI=;
        b=vmZ9s3+S7EREsPsSVrlOEBDS6ovxDIM8zv2M7+p5KvY852nXt6gFq+mHBnZ/tmwE03
         NgtHB2y+8XQva5+aPDhsPp4ZbQbrkbShNBPDyvuPiCr0O7Pcq+QHWw9yYsfc95S1O+C0
         r9uSZgpFJjYk/TEoQq2+yNLercrBz+EBTT6jl36PjcVWHhDkdpQyiLg30UZHR0OjO2d8
         pQAruMWN+nRDtFoOSVMSRd2cMyn7fk/4T1GLp4h+KvKJdlkVAcEfI8/X+pn6GBow/pQX
         OMlP2dwz0GhXkXeiNGzebKC6KcP2tlW/QkZVEcgQQeN2iOhejDVAVou+Z4WxoHdUuFBT
         F1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744142071; x=1744746871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBGk/fKPNmRqrd1bCAlViX+nWV4o6WwNupDuItfdSOI=;
        b=bcBHce1kztnsxV5T0iWdvVhMEHADQaYnRy3JhuliFvJ6a9qFtU0RiuzVtO8jyiMDbk
         WjK53FaKb6e+K5AQVzKehGxdvxlQC2dfmoLtFYscpZt1js+SNAPl/y2rz7p7yByVNYgK
         bvErlwwdpqVGWGb/qGDkbRKZPkKSRDTVpBwhYHDrteYfl2ZBTsAu85rK48VB1z7MOTW8
         LL1PCwxB8kqcGxqpGd9b9fNfJda7yOW4jGf4BayU4jRe83Yg+nfBbaQClHwErSkoM+lw
         Vor0mBGK03lJYkoBcr3oQVKFjSk0IZHScC1YF+Tlets4w3/VKbw6t64FgCPqnBxkxJiO
         NOzw==
X-Forwarded-Encrypted: i=1; AJvYcCX58+jRgK9UyNoBetdtvUq52pz+8Uy0Sox/69OXKGP5rJBWXSmt977Et+aCuiKPoUjeDk4oC80rCw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8x3h1EzJtNG577sv5Cp8yE6z09jkLB2z528/ln/hX20w+XqOa
	wOrKxvHKoqR3Jf7SkAg2PWZuZiXNs90C9/aUmN0TA7Arwfl3JRPFbmzT6xl44A==
X-Gm-Gg: ASbGncvptkHwt09MSzQFfYoGr94mWXN8KaqyctbGFNNTVduJnpAYB2jp7QZa0j7+D6k
	W7A4k88XVYqN5iWtykMArhqd/QvFCPmgP1FrgTzfHgLGtZISzXf4pqSfduJWpVc+EhqzeE/oeiz
	bE/i8KfTtDtHSVWZxieaCWBdBqnx2ZSNEDErmd/GEi0jcnCr1a0vRET1/uW3ITz1jVLlckAhrLt
	5d65NpHSAeKxQHT8LszVwmlySZ190XzoFVISzu4F8R/g+6RY3o5R5tCHyJLgm35nGHBrotE5gVC
	CTEog7I27YfvOzEVe8r8kHwsbTDZz7gyrVf7DNcqhh0JVsJfqmqYMmAU+xmf/jy7lB3iBw8kk9q
	Ql379ytC1l1kvT4AmxOAbDgAMXMz+oEBkDKxxCzsr+DI=
X-Google-Smtp-Source: AGHT+IFpX171nkKO4/pkD9or/PTfHZTRPoVBCZggU+DSor2BZJYvT8pJQsh9q1mKL13bLo8q2/aXiQ==
X-Received: by 2002:a05:6a00:4608:b0:736:b101:aed3 with SMTP id d2e1a72fcca58-73bae4957c5mr347163b3a.1.1744142071138;
        Tue, 08 Apr 2025 12:54:31 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:4da8:81cb:274b:fff0? ([2a00:79e0:2e14:7:4da8:81cb:274b:fff0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97f3719sm11009549b3a.71.2025.04.08.12.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 12:54:30 -0700 (PDT)
Message-ID: <4e96d3ba-043c-4707-9bb9-8987d8c53025@google.com>
Date: Tue, 8 Apr 2025 12:54:29 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] power: supply: core: add function to get supplies
 from fwnode
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Sebastian Reichel <sre@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
References: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>
 <20250312-batt_ops-v1-2-88e0bb3129fd@google.com>
 <Z9rMiONSFDJInPYM@kuha.fi.intel.com>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <Z9rMiONSFDJInPYM@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/19/25 6:54 AM, Heikki Krogerus wrote:
> On Wed, Mar 12, 2025 at 04:42:02PM -0700, Amit Sunil Dhamne via B4 Relay wrote:
>> From: Amit Sunil Dhamne <amitsd@google.com>
>>
>> Add a new helper function power_supply_get_by_fwnode_reference_array()
>> to retrieve a list of power_supplies associated with the fwnode's
>> property. The property can contain multiple nodes where each node is
>> associated with a power_supply. The list of power_supply objects will be
>> stored in an array supplied by the caller and the return value will
>> indicate the size of the resulting array.
> I don't think this API is necessary. If I've understood what you are
> after here, the batteries should simply have the Type-C psy(s) listed
> in the supplied_to and/or supplied_from.
>
> So you just need to make sure your battery nodes have the USB Type-C
> node(s) listed in the "power-supplies" property in your DT, no?
Thanks Heikki! I will evaluate between this approach vs OF graph 
approach (as suggested in previous review) and implement it in v2.
>
> thanks,
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> ---
>>   drivers/power/supply/power_supply_core.c | 60 ++++++++++++++++++++++++++++++++
>>   include/linux/power_supply.h             |  5 +++
>>   2 files changed, 65 insertions(+)
>>
>> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
>> index 76c340b38015af0a67a0d91305e6242a8646bf53..df1a52f85125748c4fdcb10687aa7ed2f626ded1 100644
>> --- a/drivers/power/supply/power_supply_core.c
>> +++ b/drivers/power/supply/power_supply_core.c
>> @@ -593,6 +593,66 @@ struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
>>   EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
>>   #endif /* CONFIG_OF */
>>   
>> +static int power_supply_match_fwnode(struct device *dev, const void *data)
>> +{
>> +	return dev && dev->parent && dev->parent->fwnode == data;
>> +}
>> +
>> +/**
>> + * power_supply_get_by_fwnode_reference_array() - Returns an array of power
>> + * supply objects associated with each fwnode reference present in the property
>> + * @fwnode: Pointer to fwnode to lookup property
>> + * @property: Name of property holding references
>> + * @psy: Resulting array of power_supply pointers. To be provided by the caller.
>> + * @size: size of power_supply pointer array.
>> + *
>> + * If power supply was found, it increases reference count for the
>> + * internal power supply's device. The user should power_supply_put()
>> + * after usage.
>> + *
>> + * Return: On success returns the number of power supply objects filled
>> + * in the @psy array.
>> + * -EOVERFLOW when size of @psy array is not suffice.
>> + * -EINVAL when @psy is NULL or @size is 0.
>> + * -ENODATA when fwnode does not contain the given property
>> + */
>> +int power_supply_get_by_fwnode_reference_array(struct fwnode_handle *fwnode,
>> +					       const char *property,
>> +					       struct power_supply **psy,
>> +					       ssize_t size)
>> +{
>> +	int ret, index, count = 0;
>> +	struct fwnode_reference_args args;
>> +	struct device *dev;
>> +
>> +	if (!psy || !size)
>> +		return -EINVAL;
>> +
>> +	for (index = 0; index < size &&
>> +	     !(ret = fwnode_property_get_reference_args(fwnode, property, NULL,
>> +							0, index, &args));
>> +	     ++index) {
>> +		dev = class_find_device(&power_supply_class, NULL, args.fwnode,
>> +					power_supply_match_fwnode);
>> +		fwnode_handle_put(args.fwnode);
>> +		if (!dev)
>> +			continue;
>> +
>> +		if (count > size)
>> +			return -EOVERFLOW;
>> +
>> +		psy[count] = dev_get_drvdata(dev);
>> +		atomic_inc(&psy[count]->use_cnt);
>> +		++count;
>> +	}
>> +
>> +	if (ret != -ENOENT)
>> +		return ret;
>> +
>> +	return index ? count : -ENODATA;
>> +}
>> +EXPORT_SYMBOL_GPL(power_supply_get_by_fwnode_reference_array);
>> +
>>   int power_supply_get_battery_info(struct power_supply *psy,
>>   				  struct power_supply_battery_info **info_out)
>>   {
>> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
>> index 6ed53b292162469d7b357734d5589bff18a201d0..3f062607e5cd7c7f04384e34128ae0953e25d981 100644
>> --- a/include/linux/power_supply.h
>> +++ b/include/linux/power_supply.h
>> @@ -820,6 +820,11 @@ devm_power_supply_get_by_phandle(struct device *dev, const char *property)
>>   { return NULL; }
>>   #endif /* CONFIG_OF */
>>   
>> +extern int
>> +power_supply_get_by_fwnode_reference_array(struct fwnode_handle *fwnode,
>> +					   const char *property,
>> +					   struct power_supply **psy,
>> +					   ssize_t size);
>>   extern const enum power_supply_property power_supply_battery_info_properties[];
>>   extern const size_t power_supply_battery_info_properties_size;
>>   extern int power_supply_get_battery_info(struct power_supply *psy,
>>
>> -- 
>> 2.49.0.rc0.332.g42c0ae87b1-goog
>>

