Return-Path: <linux-pm+bounces-17845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D55039D4932
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 09:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961E9282D51
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 08:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24BC157E78;
	Thu, 21 Nov 2024 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfnvXKyZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47FAD2C
	for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179173; cv=none; b=uiUYVeCCvqhY+RIPjqAUYoSQVMOVviH6ZYzxcgzmzsSssWozORe1voXn/BUWuL7i9csICqnK4u6m5ngYORbvXBuQpEjMUjCBu/Pn0mfy+cXrFTZ2lAt+xaBz+k9Jp1xX90koXvtEt+2i1adoL8a/oVS+6tAV5DvZ5oNiIi8pEk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179173; c=relaxed/simple;
	bh=NRGX8nLWYrM3ltoP7C44QRwGHamZ4XdhvJzKB2gqzBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X5pImledHkSjskcCs5ciFwuCxMk3PtAGlPuJzoWz4MBztE7Kg7QAEGDHyMPkwixrb8NgIrUIfhKvQyBml4NQWdQZPb3FaYQGKzVoLEa/9+HltYKjhneT2guGASk2jtiZdef5orP+T0Mxazq4QtZ7TxjqsXlWSZRDxMrnvfByR/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfnvXKyZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732179171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ysxQtuuPsMDFWjUHBsJ/HbQemfY0qYeO4cd2SaJSr6o=;
	b=KfnvXKyZ28N35squIl43xOA5TYrHjHe17DGsFdqmbymIqAkuJhyAaXqnMCnkjfBrG5sKEu
	8h6166/7F2CPt+ZBjZ8idbUmPP6Hc0Cd1FGBX+jR3E7jHV6rdq9ef/ZxBpPEom525qPdEE
	Z1+Ms0UDC/axhdc2nok5RaIJl4UKyoY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-pHxWcqsQOTaMrJRrBf9E3A-1; Thu, 21 Nov 2024 03:52:49 -0500
X-MC-Unique: pHxWcqsQOTaMrJRrBf9E3A-1
X-Mimecast-MFC-AGG-ID: pHxWcqsQOTaMrJRrBf9E3A
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38242a78f3eso374637f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 00:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732179169; x=1732783969;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysxQtuuPsMDFWjUHBsJ/HbQemfY0qYeO4cd2SaJSr6o=;
        b=duL58Piegpmz2t6HJSPxFXvgkTvZHi7uH7ls1NCVC79HrJGPLBHvBjMun088h0Gd2I
         lcUAx+as18KnrPhjm4eN2nj68sGao1vwBGGhOxkB5GPSx66m8TaM6YGq3khjKyMWGMQ3
         Bor1oATPNj9IAOSmffohHqvB0vAMuJ4oFVDAXzUXkFtcrj/cZSRBDEkm0FBRTVQRAJin
         yrS4ZavDagHaBu7L9E+JiiYjmnThK0CyAdCfuqqPuiyUMaAf6lB4kSlIcDxSkuiJeM5k
         EOkULgc6u0SgnDt4ruoJA2MmBgPmFFkaMikqiiyrruHVBIyNBQUJDDgC8EQgs9/sIWl7
         d1Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVH7Qzd3PMW9L+iN5bKyiN/Ywi1WWdKBUzxmzMtv0Nd2b5vm/O+nIiaMKGPXp58q7E4g1VXa2wDGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnd4W/UkF4RqRY9VBqKbYCDe72hQtkQfmr5brv8mAU1RKFruOR
	2EaRt4P8nQB0uZ1Kk22TbPyEXuR1AYNbNQ37y8qdFu84CbhUVtNkjSL00fDnnH6adE5Oi/OfUff
	RofVg1lPnbkPEOAYO/E0fHJo0ZcO8asvAt7FVM/v1ydzv0frwAVd31KA6
X-Gm-Gg: ASbGncsq/EvdmTreLYZdGkkER1+/heRpmmzChduQ6p/4rlNo6+yJSUH+QZyPVtjQydf
	Lc9ngBvDhQ05BluYZD/fdgC/bn04M7If5XiZcU8stZblVp8zRmiP76UHzzMB/LWzd9hWsEY07ud
	beM7aTf2nroyNBRlcly6F3ihs6I0Qts0zu7CH1XOXtJGjYMzutJjAVsieY9B43ICW7ufY+5DjyZ
	+0WypM/UX16asfaO2/F84FcfpwdQPOLohX+yf8+cFLspIWjp6gjniBqc93lI0Zo93+tcGuZISU9
	I8XzOiwoaHpyTHzasCVquC0a0cZu+do6
X-Received: by 2002:a5d:59a3:0:b0:382:41ad:d8d1 with SMTP id ffacd0b85a97d-38254b29189mr4342720f8f.53.1732179168734;
        Thu, 21 Nov 2024 00:52:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmHkyTJQsvPBIeNQ4O0n/PRklEe3/aJpR0EagZekMNQVtDIV70aAaQfYCxqvTRmmw76q/KRg==
X-Received: by 2002:a5d:59a3:0:b0:382:41ad:d8d1 with SMTP id ffacd0b85a97d-38254b29189mr4342706f8f.53.1732179168335;
        Thu, 21 Nov 2024 00:52:48 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490cdf7sm4282202f8f.42.2024.11.21.00.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:52:47 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>, robh@kernel.org, arnd@linaro.org
Cc: linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>, Zhipeng
 Wang <zhipeng.wang_1@nxp.com>, Maxime Ripard <mripard@kernel.org>,
 javier@dowhile0.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH] cpufreq: dt-platdev: Fix module autoloading
In-Reply-To: <20241121071127.y66uoamjmroukjck@vireshk-i7>
References: <20241119111918.1732531-1-javierm@redhat.com>
 <20241121071127.y66uoamjmroukjck@vireshk-i7>
Date: Thu, 21 Nov 2024 09:52:46 +0100
Message-ID: <87iksh3r4x.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Viresh Kumar <viresh.kumar@linaro.org> writes:

Hello Viresh,

> +Rob/Arnd,
>
> On 19-11-24, 12:18, Javier Martinez Canillas wrote:
>> This driver can be built as a module since commit 3b062a086984 ("cpufreq:
>> dt-platdev: Support building as module"), but unfortunately this caused
>> a regression because the cputfreq-dt-platdev.ko module does not autoload.
>> 
>> Usually, this is solved by just using the MODULE_DEVICE_TABLE() macro to
>> export all the device IDs as module aliases. But this driver is special
>> due how matches with devices and decides what platform supports.
>> 
>> There are two of_device_id lists, an allow list that are for CPU devices
>> that always match and a deny list that's for devices that must not match.
>> 
>> The driver registers a cpufreq-dt platform device for all the CPU device
>> nodes that either are in the allow list or contain an operating-points-v2
>> property and are not in the deny list.
>> 
>> For the former just add a MODULE_DEVICE_TABLE(), and for the latter add a
>> module alias. That way the driver would always be autoloaded when needed.
>> 
>> Reported-by: Radu Rendec <rrendec@redhat.com>
>> Fixes: 3b062a086984 ("cpufreq: dt-platdev: Support building as module")
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>> Posting as an RFC because I don't have a platform that uses this driver
>> but I'll let Radu test since he reported by issue.
>> 
>>  drivers/cpufreq/cpufreq-dt-platdev.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>> 
>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
>> index 2a3e8bd317c9..7ae7c897c249 100644
>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> @@ -97,6 +97,7 @@ static const struct of_device_id allowlist[] __initconst = {
>>  
>>  	{ }
>>  };
>> +MODULE_DEVICE_TABLE(of, allowlist);
>
> This is fine obviously.
>

Yeah, this part is trivial.

>>  /*
>>   * Machines for which the cpufreq device is *not* created, mostly used for
>> @@ -236,4 +237,16 @@ static int __init cpufreq_dt_platdev_init(void)
>>  }
>>  core_initcall(cpufreq_dt_platdev_init);
>>  MODULE_DESCRIPTION("Generic DT based cpufreq platdev driver");
>> +/*
>> + * The module alias is needed because the driver automatically registers a
>> + * platform device for any CPU device node that has an operating-points-v2
>> + * property and is not in the block list.
>> + *
>> + * For this reason the MODULE_DEVICE_TABLE() macro can only export aliases
>> + * of the devices in the allow list, which means that the driver will not
>> + * autoload for devices whose cpufreq-dt will be registered automatically.
>> + *
>> + * Adding an "of:N*T*Coperating-points-v2" alias is a workaround for this.
>> + */
>> +MODULE_ALIAS("of:N*T*Coperating-points-v2");
>
> How does this work? This will autoload the module for any platform with
> "operating-points-v2" property in the DT ? The driver though works only if the
> property is in the CPU node, while now we will try to load this driver even if a
> non-CPU node has the property now.
>

Will autload the driver for any platform that has a Device Tree node with a
compatible = "operating-points-v2" (assuming that this node will be a phandle
for the "operating-points-v2" property.

For example, in the case of the following DT snippet:

cpus {
        cpu@0 {
                operating-points-v2     = <&cpu0_opp_table>;
        };
};

cpu0_opp_table: opp_table {
        compatible = "operating-points-v2";
...
};

It will autoload if OF finds the opp_table node, but it register the cpufreq-dt
device only if there's a cpu@0 with a "operating-points-v2" property.

Yes, there may be false positives because the autload semantics don't exactly
match the criteria for the driver to "match" but I believe is better to load it
and not use for those cases, than needing the driver and not autoloading it.

> I am not sure what's the best way forward to fix this.
>

I couldn't find another way to solve it, if you have a better idea please let
me know. But IMO we should either workaround like this or revert the commit 
that changed the driver's Kconfig symbol to be tristate.

> Arnd, Rob, any inputs ?
>
>>  MODULE_LICENSE("GPL");
>
> -- 
> viresh
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


