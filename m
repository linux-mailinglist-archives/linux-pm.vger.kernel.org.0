Return-Path: <linux-pm+bounces-902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 139F980D3EF
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 18:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BD1282029
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 17:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DF14E60B;
	Mon, 11 Dec 2023 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q99BuM+Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80BFFD
	for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 09:34:59 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3334254cfa3so2665113f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 09:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702316098; x=1702920898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gstntUJJhuUruQ6CLNsepakisEqtUTeEbOuI9lM82/A=;
        b=q99BuM+YhGN4lKfpf3MGaomsJifhCbtczimCixr3f6qWNcTug2KRXhqiZgm4qKk1pm
         D6lUOVIyjQYDL6chdWBNsYypi1PRs41p/26LtIeR5zqa3l2xEIDRyoU9HgPOVaptvyt6
         +e73dW48t7eyConI/pXcdcm7VnxO3L+/liSPNb/o6pAVJqL/g21LEoo306UgBn+CsKB0
         58wxMYb4PxUH1s690OLgIbo7UVquXJ+uj38Fk6gGJrxJlrR05MXMlSlNnv1uipwC2KF4
         aY5/FbIfRoXOvbHfkZFzdWX11P3R7eNDVO5z4QcvciMilv5E+yuJ0Tv7fgllNi9gzL0i
         mYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316098; x=1702920898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gstntUJJhuUruQ6CLNsepakisEqtUTeEbOuI9lM82/A=;
        b=M/KZMkVd2DtF9CFPgvnrgqGzCMYWA7wCmcSA11fR5QqkwwUERQgWLt+1MvZV24uaei
         uqrHfcD2sHZ2VghFzYomvPYZ7dgivpSAFRqa0vyhBdig5Bhl5aRcxNTHwCrUS//NU2WB
         NN9QYgTC7BxKF02+0gwN8tdNlsP9EPDVlIOZaKJFn9mH7l0RITWghusHecfuPV1U+W4/
         Tng5QGwNhFdH+dP8GqzNuO2UbEMDyR/g5a7OwGGqgeZL06XA7ULGJgpfF3PFkxJTBv7k
         XTPKYW+fjKzuNpHGM5awKVRwhqOGAbFlFJxLYZ1GZnJTsv+vJMzPQyMlEZgaOQ3k5Iu9
         IUnA==
X-Gm-Message-State: AOJu0YzsjtPNj6WOVfhr49if/QGwI8Fp9HmMhd1XI2exXghNOOoWZyST
	xYbABk8kKQN/BkOT/nd3dZQZrxNthE4Ow2DDiRY=
X-Google-Smtp-Source: AGHT+IE1Y4VjQWuMP84YdtKDSoXd37/lYS2QFZAq/+DEf2E0klWmPSB2zntnCZYi2oLFGBPADo4Fqg==
X-Received: by 2002:a5d:4712:0:b0:332:f501:8b56 with SMTP id y18-20020a5d4712000000b00332f5018b56mr2572878wrq.23.1702316098228;
        Mon, 11 Dec 2023 09:34:58 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id g3-20020adff403000000b003335ddce799sm9046899wro.103.2023.12.11.09.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 09:34:57 -0800 (PST)
Message-ID: <535558f8-096b-4917-92d2-b0defed42b15@linaro.org>
Date: Mon, 11 Dec 2023 18:34:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] thermal: core: Make
 thermal_zone_device_unregister() return after freeing the zone
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1880915.tdWV9SEqCh@kreacher> <13414639.uLZWGnKmhe@kreacher>
 <0a0d5dd4-6b7a-428b-8ef1-bb6aff76fb51@linaro.org>
 <CAJZ5v0jebeWzUb-q-_xThRwZgUzaUfqS4YTGmsvbsOPrqFcYTQ@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jebeWzUb-q-_xThRwZgUzaUfqS4YTGmsvbsOPrqFcYTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/2023 17:42, Rafael J. Wysocki wrote:
> On Mon, Dec 11, 2023 at 5:28 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 08/12/2023 20:13, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Make thermal_zone_device_unregister() wait until all of the references
>>> to the given thermal zone object have been dropped and free it before
>>> returning.
>>>
>>> This guarantees that when thermal_zone_device_unregister() returns,
>>> there is no leftover activity regarding the thermal zone in question
>>> which is required by some of its callers (for instance, modular driver
>>> code that wants to know when it is safe to let the module go away).
>>>
>>> Subsequently, this will allow some confusing device_is_registered()
>>> checks to be dropped from the thermal sysfs and core code.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>
>> Definitively agree on the change
>>
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Thanks!
> 
>> Would it make sense to use kref_get/put ?
> 
> Why and where?

Well it is a general question. Usually this kind of removal is tied with 
a refcount

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


