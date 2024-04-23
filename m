Return-Path: <linux-pm+bounces-6949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABC38AF5E5
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 19:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71560287C24
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 17:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC75E13E3E4;
	Tue, 23 Apr 2024 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o07N9ecy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2007B13E03A
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895122; cv=none; b=pOpnQPuT5dLCIZuVZ37nrC3mYO2gO0edc2atsNJO77s7ipS6skkZjNI1i7R+8duLo5uar4pirmoH7OG+lIg7PGxiYJ/g8BGPAkPOW3YLysxLOIxGST2a16GuG83wZSh1qJEonsVigiu6VrbLvnIqZptruSrRt2M8Bbuf+NnbGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895122; c=relaxed/simple;
	bh=dd+JeMwnI5oUS4+G0VV/w8a37ey100fY6+ic7TXAsH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOx5iM0hRJdiky2wXRCE+tGGAO4dls2/BQvzPCnN/9K4Q6Rxt/Euj0Jc1Hm0cjc7WEv0jr0U8qC0oFlx7pTnkgHB7iIUjlegBA9D2i7vamxRJuucxLrrWFtAzSUUCBhuW6UO0kdkOKLj/8GseKHxw60s4WE1tzoDTjlCKMlHgtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o07N9ecy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41adf155cffso3446325e9.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713895118; x=1714499918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IgRbrsMGiUIlEz9TTE6qVqcHJ+EG6dlP4R0WOrU0AXI=;
        b=o07N9ecytWgJPZwENySqx8oJIg1gyF8i8Mg99zMwAqSkwXDKp+466GEU7P2bZpY9Ep
         rMmFD4w90zKsK3THE5PQCQ9i23Kr+C3l1cad1+SFwVnwxBn+HDuTusK2CKv4z6wFBmJk
         JGisxbeLKXaYIPKunBXrAt6NTAVQFdpXM2veiOZt2kgy36R47Vk+pRk44IqVckWXpMET
         uCYZss8PN4T0rya7skLrnfrnPvf2O/7DNHaTN21pnLXMy3rPULvFeQYGaRAkXT8sx679
         dvj6fKLNE/SglNdD+RMhlK42G3Ly0V5tkzhej/hsu+CbhqLgfRb5JEj57qs6GyD5T/8M
         ioKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895118; x=1714499918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgRbrsMGiUIlEz9TTE6qVqcHJ+EG6dlP4R0WOrU0AXI=;
        b=FNSWTseHkEDhdWThHSKaoEnpT5nEIuCurKKzzzGNYJRe5nFhE5Rl+n10A88ERe82I6
         Ue/1irnxJAdVYpvIXK2ajJRzVy651gO5wYbhevxXsx0mrNOhVWw5rUKOIjC54Tx7wOHi
         evZbYxKHwURXK0APoSovnC6MnvyC5qN3uyBrClbM0kazZqrO4dbtCpo1xdtUSMRKpDBe
         o0x60pOEqHvQox25kXHHB22Pdxk+5rxE+USGvbBXy/bJUu9H9w13LHNChyMwUbfZFlFH
         X2zRTdIbGVugbDNzqHsQwsZMVVimvd7Y+BmyTscUD/S1YH746rtUYIYtQiua51vxrDcs
         WG5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtr309ngCAHPHEkmeAfLrr9etL8+HmoCwluBkhXEtoC3hmHSG/Duzu76RA5Y1yb8OHXLCXR9BDL0wg3vxGFA7fBuED8779ggI=
X-Gm-Message-State: AOJu0YwE/bjyKbxqFiclGaS3Am0JtF8wmY3AvXr6kFn4SWPW/vxda9Hv
	ES5iL85pAKyc7tJWRn3RfLwE988DVzHYJnpMwxSyZytym3a5s4vyEFnYA4/tpWc=
X-Google-Smtp-Source: AGHT+IEg8a5zVa87KQciw+DOQLgzGEJoPscxi47i8ZciqJoIshh+lMq1AzoW5459X2elbie9GPlIUA==
X-Received: by 2002:a05:600c:3143:b0:41a:afe1:6d77 with SMTP id h3-20020a05600c314300b0041aafe16d77mr15647wmo.11.1713895118348;
        Tue, 23 Apr 2024 10:58:38 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w17-20020a5d6811000000b0034a2ba13588sm14055862wru.42.2024.04.23.10.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 10:58:37 -0700 (PDT)
Message-ID: <3c169af3-e9c3-47c0-b343-48f699680009@linaro.org>
Date: Tue, 23 Apr 2024 19:58:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/16] thermal: core: Introduce .trip_crossed()
 callback for thermal governors
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <2009494.usQuhbGJ8B@kreacher>
 <9f45fd2d-f1de-437f-ae8a-75ad51a5c061@linaro.org>
 <CAJZ5v0ggUSk43LGgXLU08svxtdUDbAvX+4Ca0DNTAH0H85i7Rg@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0ggUSk43LGgXLU08svxtdUDbAvX+4Ca0DNTAH0H85i7Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/04/2024 19:25, Rafael J. Wysocki wrote:
> On Tue, Apr 23, 2024 at 7:14 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 10/04/2024 18:10, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Introduce a new thermal governor callback called .trip_crossed()
>>> that will be invoked whenever a trip point is crossed by the zone
>>> temperature, either on the way up or on the way down.
>>>
>>> The trip crossing direction information will be passed to it and if
>>> multiple trips are crossed in the same direction during one thermal zone
>>> update, the new callback will be invoked for them in temperature order,
>>> either ascending or descending, depending on the trip crossing
>>> direction.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---

[ ... ]

>>> +             if (governor->trip_crossed)
>>> +                     governor->trip_crossed(tz, &td->trip, true);
>>
>> Is it possible to wrap this into a function ? So we keep the calls at
>> the same level in this block
> 
> I can send a separate patch for this if you want me to.

Yes, sure


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


