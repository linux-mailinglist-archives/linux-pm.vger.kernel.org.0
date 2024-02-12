Return-Path: <linux-pm+bounces-3791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBF885153D
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 14:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F711F21E58
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 13:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F343E498;
	Mon, 12 Feb 2024 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kD0FmYMT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D373B290
	for <linux-pm@vger.kernel.org>; Mon, 12 Feb 2024 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744133; cv=none; b=ND5F+BbtvJe0N9FUfFLNFnlg0aPqzHh1f546y3BSiXQ8THgkQkTsA6ThTNAgNPl6PLzGSmoCZqD9AwIDjTeCkh7XiIIsOPB2l70x/h2l8gbj7Q4NZBdxFxkO+bTDvqCLtcIn4j3YqDHDURF9WzkWv5JwK2RQ4jSKVWja/Dhml9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744133; c=relaxed/simple;
	bh=gUFUO9iusGmntxDZLEAmUKl4lzKp0f8CnkBErWMnJhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBAGd+hIx2yGaavBaZFhthNTHiXBC6ihhvl+ngFPuttfePNK3E51lN5eE6liFAvZgfoLhCXOwinISJX5wMPOAwOZDZqXD52wD0BdBjACUSgiKlcNwehcV4yTLKQoyF5FLnyoEbnU6qOxo7bcCsQH6OA88tn9AfvJol+WgrMBaPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kD0FmYMT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3cb228b90bso68596066b.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Feb 2024 05:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707744127; x=1708348927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwZff36T1I/LCHGsIKBrchvCl6TLE40Tpq9Mdew09mk=;
        b=kD0FmYMTJHV/xkITEBNGF0eVvju4++31BxOdsaMVkpFJGELz8PM8Xkp04vVpn1Pznc
         znDYWA8gv2/Ac3PqvklNomi4r4UKL4uqjMrPVBVJWDI5Lqv9igaYp3jvjt4Omj1G8QHy
         9ZS/GBKY6aLxHv0HI5nEAR5pVRURqfecHj5REckMqg4ywin+2/ng5O6wp7F/zfLhQ7YK
         85x2n8JIRFdZQIGkhcy0SLj8HA2TELQoLyHvPVt6f1pkCgkgMeoW4EocKhcbGOmO5aBT
         PQcMFOaZUiMwhuUA5B7r6D0JgBPRHmvvJ5racz9l5OeqEdU/0AqJCOUljZnZIUneFT7B
         MHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744127; x=1708348927;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwZff36T1I/LCHGsIKBrchvCl6TLE40Tpq9Mdew09mk=;
        b=vu818JD1/XsCOa0FnotbfGHNG4BbzqbsRYTu6JXjjxZzVGTDeVzJZLsqBzHTVJx9qi
         ro4auDP5KF02eWPURgh+x5CsAXgCQd5e3497S/fgTjAP2P2DD8YVObaCLYW82n/1nW4h
         orxzGC+D6I1ZAR9cr7NvvQtb7xeCn2pjjREkLRYASV7aOQMHmpwI9CgbxnveX9PLRmmh
         0fal9ScEmxbstCwNrggWYIukqZGc1sNvbDLih6VvYN/o6FAFS4kT+fcR9k6crIrMVopQ
         D6BK9bkTNNHb0tbMYcZixns33W6in11WuTyd6F/EkoHj9I7lpsU5z7f4WsgSX1YDAcWW
         cBiw==
X-Forwarded-Encrypted: i=1; AJvYcCXSec42X73box8pAd6BZexBbmEgdwRRXg0J5TUAgUizZ610pe6Qe9G0crhTPK700+ALgQbVJKF0hrMnQZDq5x48OJNICSYHo1w=
X-Gm-Message-State: AOJu0Yz/CUbb3YCsalbabjsspWIo1xCnR29YCE4AYLvPYXts1807aPYI
	ON4aZ4vXMqQCeu88sc80nc7hpQYgWfgAo2HJqQjdWwauvrpcIsmYk/zCbpK8Rqw=
X-Google-Smtp-Source: AGHT+IFKD7n58BP7ztMm3pvdIeaoRBnrc/V/tjWzqPfuKdoiMvXxXQX7nsAZQlD57/gb6NwbXD7lPQ==
X-Received: by 2002:a17:906:b855:b0:a3c:1070:8054 with SMTP id ga21-20020a170906b85500b00a3c10708054mr4479903ejb.10.1707744126806;
        Mon, 12 Feb 2024 05:22:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHgwjtNC1nvCZ3U/qOZVG6Qy+4AKhnkZInEvOTikYS1xjVivaa+CrG1rcceGZC8LUIdEs0NjjXGnisFXopJob+JdCOp3o7n/+LXpnV//ryBMEhZrXauoRGHrHRa6ngZRNsiScNz9760Cs7R7fogWe+mgCiWlQ1M7MlLeM96qNIzQ15CvJsLDahIOr5lAP2vYWkfLx649GABIA4L1N2gpfxk6kzMQvFZq+KFBuIqJipIL+HxoI=
Received: from [192.168.192.135] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id md21-20020a170906ae9500b00a371037a42bsm200533ejb.208.2024.02.12.05.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:22:06 -0800 (PST)
Message-ID: <7b33d9a6-8871-4234-8cb0-bf1c2c578210@linaro.org>
Date: Mon, 12 Feb 2024 14:22:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] power: supply: mm8013: implement
 POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Konrad Dybcio
 <konradybcio@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
 <20240204-power_supply-charge_behaviour_prop-v1-3-06a20c958f96@weissschuh.net>
 <2f244f9f-8796-4cad-8bf8-d0c3411588c1@redhat.com>
 <569bbc9f-1c34-40c1-a563-e7f6aecf63d5@t-8ch.de>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <569bbc9f-1c34-40c1-a563-e7f6aecf63d5@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5.02.2024 12:21, Thomas Weißschuh wrote:
> On 2024-02-05 11:00:01+0100, Hans de Goede wrote:
>> Hi,
>>
>> On 2/4/24 18:26, Thomas Weißschuh wrote:
>>> The sysfs is documented to report both the current and all available
>>> behaviours. For this POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE needs
>>> to be implemented.
>>>
>>> Note that this changes the format of the sysfs file
>>> (to the documented format):
>>>
>>> Before: "auto"
>>> After:  "[auto] inhibit-charge"
>>>
>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>
>> Changing userspace API like this is never ideal, but given how
>> new the mm8013 driver is and that this brings things inline
>> with the docs I think that this should be fine:
> 
> I agree that it's unfortunate.
> 
> However looking at the datasheet [0] it seems to me the driver is
> not correctly using the API.
> 
> Page 23 documents the flag CHG_INH as follows:
> 
>   CHG_INH : Charge Inhibit      When the current is more than or equal to charge
>                                 threshold current,
>                                 charge inhibit temperature (upper/lower limit) ：1
>                                 charge permission temperature or the current is
>                                 less than charge threshold current ：0
> 
> This is only diagnostic information and not a control-knob, which the API
> was meant for.
> So POWER_SUPPLY_STATUS_NOT_CHARGING seems like the better match.

Oh, that's definitely something I glossed over, thanks for taking a look!

I'll send a patch untangling this shortly.

Konrad

> 
>> [..]
> 
> Thomas
> 
> 
> [0] https://product.minebeamitsumi.com/en/product/category/ics/battery/fuel_gauge/parts/download/__icsFiles/afieldfile/2023/07/12/1_download_01_12.pdf

