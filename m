Return-Path: <linux-pm+bounces-1647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC7F81F83B
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 13:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EAF2840F3
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 12:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B161748F;
	Thu, 28 Dec 2023 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKozO4cT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6014B748D
	for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso61919325e9.2
        for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 04:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703767413; x=1704372213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MLFqGgO5Rfo6D6SMVC6Pxe2bC2kc4jtbsBPp02xvsvc=;
        b=WKozO4cTv4JPggLCsuIZz/Y0bOUQnMRmCMuaUavpDRMZgJmPaiceTe+Fc4QawooPSa
         eIAsTYXfFp/S5mGS0gjVTyjrNGEZ9hI3dcloaO9YbvYVBU9GGHGNnIP7aaBvZ5kDoRd+
         9oloHITcOvwm3K4E5IV+0BLs9UTgSIcuH76DG3jL/0N26YvtMtHt52CplRTTjlz/EtZm
         mcNWPy9LVabHCWcNqYem9FaOh1DtJWCR5pwMYq9k5EHAlJvEYzWVwlftLAmecAwnogg6
         0rrNOELHQH9h4rZfXG9LqdTVaxkrojuyXiT3Zbdx8412G0g7oQgmIRw/mULK0fAuR3ZX
         Jxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703767413; x=1704372213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MLFqGgO5Rfo6D6SMVC6Pxe2bC2kc4jtbsBPp02xvsvc=;
        b=KQeL7WLn/goKUhk3IGQc6N3tmEpg0aoArcuhD9p/5F2SW1oYcwoPC2h8vxsonH8ZaU
         rMzmrgxlm3BsS9SzMaAB09feRbQr5FCkpbWrdVekjRshWswCUUyC+KgRZe/GWZZz2TkL
         8l+eRF4tV+RQsy8kBOEAfuvgk6CmW/H+/BS9QegNl3hTCoFPymDwfrMgj+f4U66cxU3H
         mpM1F0h4P7S746uy0zxVWBTVC9BsFxiqajeSw91ZnZYmXF/gqbp6XE3UeTU9CZnX4MTf
         W6cPPu2uNe6F4alBGSNiCDZRIHq+nyd7172jPjuITUHAeLX6Tq8t8Gss/iM8zrbTftSg
         h7wA==
X-Gm-Message-State: AOJu0YyKW1feOSyXnz+BpJwCmPN2FCb+3BWlYwbTiVyDFww/fWDVvcRd
	QuiPXGdrzp6UoFAP0a920YS6GO6TAcEoNw==
X-Google-Smtp-Source: AGHT+IHfsJHKnHc0x4DUPZ06hq8imSM6ayeTWyJLb/0sWsoLCeYm0wlM2oYQfZI+kG6SCf9LVQT4TQ==
X-Received: by 2002:a05:600c:3105:b0:40d:5ec5:de8d with SMTP id g5-20020a05600c310500b0040d5ec5de8dmr1108958wmo.61.1703767413382;
        Thu, 28 Dec 2023 04:43:33 -0800 (PST)
Received: from [192.168.192.23] ([37.165.193.16])
        by smtp.googlemail.com with ESMTPSA id f12-20020a05600c154c00b0040d18ffbeeasm27713742wmg.31.2023.12.28.04.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 04:43:32 -0800 (PST)
Message-ID: <b05aef23-edbc-4985-a5d3-7b9ff157bb28@linaro.org>
Date: Thu, 28 Dec 2023 13:43:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: netlink: Add
 thermal_group_has_listeners() helper
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org
References: <20231228100248.180721-1-stanislaw.gruszka@linux.intel.com>
 <20231228100248.180721-2-stanislaw.gruszka@linux.intel.com>
 <CAJZ5v0gMJFVZToWQPTNstQOpYF9+yDiMYk74dasGp5VWW_-ndA@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gMJFVZToWQPTNstQOpYF9+yDiMYk74dasGp5VWW_-ndA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/12/2023 12:57, Rafael J. Wysocki wrote:
> On Thu, Dec 28, 2023 at 11:49 AM Stanislaw Gruszka
> <stanislaw.gruszka@linux.intel.com> wrote:
>>
>> Add a helper function to check if there are listeners for
>> thermal_gnl_family multicast groups.
>>
>> For now use it to avoid unnecessary allocations and sending
>> thermal genl messages when there are no recipients.
>>
>> In the future, in conjunction with (not yet implemented) notification
>> of change in the netlink socket group membership, this helper can be
>> used to open/close hardware interfaces based on the presence of
>> user space subscribers.
>>
>> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
>> ---
>> v2: Do not return -ESRCH error when there are no listeners
> 
> Both patches in the series look good to me.
> 
> Daniel, any objections?
> 

No objections,

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

for both of them

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


