Return-Path: <linux-pm+bounces-5486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D9688DB53
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 11:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFEB61F2BA6A
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 10:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE1A14276;
	Wed, 27 Mar 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJFWIV8b"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C413B4EB41
	for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2024 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535799; cv=none; b=e49BHvGRStiEAJYDrzo8l1A9LfHBymfxD+OB2HGonZa4Y/86wPUHDznDSPgnftXOExwY++yp/BoXW3MraEktwdL30P40Mym3EkdDK0QnUgk9MdnhAEUCjyr/0JIpRHYJDg2bESVnpiUMStJ4aUttEnRMygBql2WCrooTCBv9JLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535799; c=relaxed/simple;
	bh=XEp433VhhnNwlu79bpyjOldg952MtmkR6qNohpSTB9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6k/1gjDXurrFytGpvpVFUEr1FvGzdUEp7cH3IXfD1SrPV2z3qDMHQsPh3+hHw5b2SYDHfc9cP0a+mRWMUVkBOQ9WvndrhOe3+UmaIICwO43YLdW3jcyIEWA0FVn7+K7iIF9hLRb5LjVpRH+XzyTWiFNJRL7kRwl/XvNj9Vc/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJFWIV8b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711535796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGUgmAiaU2v/ONksowbWzodJ2NKOgb64oDRR6Sk5hgk=;
	b=CJFWIV8bQeXEOb0blqPOxRcoGkwYMq/9EIB0jFIJnFs4MFOzRf6ZV2IxOaBafC1tHvwMDB
	Eka0w+sM4JIGsQVo1QrXFafGDLJ+TXA6fc0B3Jeijzbnfj5g6fSDmdjgKpWjHmdhWvn9zh
	KlCQhy0U/BIarvCjo2ehMi+x2c1ltlM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-BJzob4OdOGK_KsY5CkRM2w-1; Wed, 27 Mar 2024 06:36:35 -0400
X-MC-Unique: BJzob4OdOGK_KsY5CkRM2w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56c0d3514baso1898394a12.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2024 03:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711535794; x=1712140594;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGUgmAiaU2v/ONksowbWzodJ2NKOgb64oDRR6Sk5hgk=;
        b=BDOA78cqdvSPTNKl0YhrhKl0w9WCnfn8bYUlVzp3+x2OpxQlhlqabtWecyUtpBEgau
         LhJybBNTEIezBGl1FcE2C6mzCZ5eSMnMhFRvTLMfBZXEhWBjNwiC6U+UAJ+J0FG9tX4C
         Q/JngZ4q8ZyIqGpvRLGyo/ZU/m/JpDg4IZUuutxcMqs4780Phbft5QDpzKbDDWCo3I4i
         NmuiKSlgh1/CSjS70m9GZ6YN8muhoBQsZTuLLbAzLpn6sLPhBa3pZ4z+a30YExycP2F7
         l4XRWYMOoVpI4shvBJ2NViDcNh79t8mpvAIG2v1HbznVLOSATd1iFsymRb6IG9xZe0sB
         6A1Q==
X-Gm-Message-State: AOJu0YxYetZCsaeRLOJ/gy64obyw+wAQoVG/1mbBdqNFfrPaUjnYpr3g
	rm+kP6v2fXAxkOaFTB2RyXKphAkrrOCPPmSxkwyrBsOw3HTM9hgaIaAcE8imkWm6qQBQIKZC8Jl
	egekBL6TKe9eiY6vciD67pAxxnYyVHwu04APeoDRt0AdaUUBt+eGgUJRs
X-Received: by 2002:a17:906:1358:b0:a47:535e:1dc2 with SMTP id x24-20020a170906135800b00a47535e1dc2mr1619540ejb.40.1711535794154;
        Wed, 27 Mar 2024 03:36:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH7ngVeH0pniStwJCtY+MKwAFE9hhBWQYw+PianGTWnmh3mdumzCWEDjJ1RgHYJ9n1CTm6RA==
X-Received: by 2002:a17:906:1358:b0:a47:535e:1dc2 with SMTP id x24-20020a170906135800b00a47535e1dc2mr1619395ejb.40.1711535788605;
        Wed, 27 Mar 2024 03:36:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ch12-20020a170906c2cc00b00a44180ab871sm5258891ejb.50.2024.03.27.03.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 03:36:28 -0700 (PDT)
Message-ID: <c217d7e6-5f20-4362-b59c-adb64bd54dab@redhat.com>
Date: Wed, 27 Mar 2024 11:36:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] power: supply: core: ease special formatting
 implementations
Content-Language: en-US, nl
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
 <20240303-power_supply-charge_behaviour_prop-v2-2-8ebb0a7c2409@weissschuh.net>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240303-power_supply-charge_behaviour_prop-v2-2-8ebb0a7c2409@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/3/24 4:31 PM, Thomas Weißschuh wrote:
> By moving the conditional into the default-branch of the switch new
> additions to the switch won't have to bypass the conditional.
> 
> This makes it easier to implement those special cases like the upcoming
> change to the formatting of "charge_behaviour".
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Link: https://lore.kernel.org/lkml/53082075-852f-4698-b354-ed30e7fd2683@redhat.com/
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/power/supply/power_supply_sysfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 977611e16373..10fec411794b 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -298,11 +298,6 @@ static ssize_t power_supply_show_property(struct device *dev,
>  		}
>  	}
>  
> -	if (ps_attr->text_values_len > 0 &&
> -	    value.intval < ps_attr->text_values_len && value.intval >= 0) {
> -		return sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
> -	}
> -
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_USB_TYPE:
>  		ret = power_supply_show_usb_type(dev, psy->desc,
> @@ -312,7 +307,12 @@ static ssize_t power_supply_show_property(struct device *dev,
>  		ret = sysfs_emit(buf, "%s\n", value.strval);
>  		break;
>  	default:
> -		ret = sysfs_emit(buf, "%d\n", value.intval);
> +		if (ps_attr->text_values_len > 0 &&
> +				value.intval < ps_attr->text_values_len && value.intval >= 0) {
> +			ret = sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
> +		} else {
> +			ret = sysfs_emit(buf, "%d\n", value.intval);
> +		}
>  	}
>  
>  	return ret;
> 


