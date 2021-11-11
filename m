Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966D244D46F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Nov 2021 10:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhKKJ4O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Nov 2021 04:56:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhKKJ4L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Nov 2021 04:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636624402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+qvQtHczzG1MfYZk8oGNUIA3UOWGJnPKv08a/xUeA9I=;
        b=PHecHzDSYxYiYijSJ32BkD78J89sZ0ICr2xRbpgGaQVh3Z0aNJMpAcALff27p4eV0OKEWB
        Qd2oDO65Zc8ulo4+jtbcnC9t/21ZyHHJiIYUTERfbW7h4TJRiNs57b4QX/6rCNMeJr5NsP
        K2BfVc/se5a0rbQK041h7vU7ZXGAleU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-c73qDnVjNfuIphwNEBiBsQ-1; Thu, 11 Nov 2021 04:53:21 -0500
X-MC-Unique: c73qDnVjNfuIphwNEBiBsQ-1
Received: by mail-ed1-f72.google.com with SMTP id h18-20020a056402281200b003e2e9ea00edso4927162ede.16
        for <linux-pm@vger.kernel.org>; Thu, 11 Nov 2021 01:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+qvQtHczzG1MfYZk8oGNUIA3UOWGJnPKv08a/xUeA9I=;
        b=Se+8SUOj/u3tvFHL0z0ZuRRwxXe2Cf3SvVgRwccFQ6xA3ihsvKngcTBP4s6+1S+y90
         exONGFCmXV3KcuHTRClOmokt/xGTZCo/LhSsRjJl7qRhDOObLdxiuxI1PSxv5uRwPhZt
         1i0Atc+IgUKRQpuoeFEE5e7iHzQ9Vc8BKiAdPcX8rSrRm1ckLqJhGJYT4qg145zjZVjJ
         jBHM8r3bQvZLSYJLYKh6F5Qwohjgc6sskzU493zt7tDv0f9DJkHyx93368OiwpTRyR7K
         cjKxNEp4E+GofVaSR0xuhE9JHEG4JK6W39qSk8DS7CrpTSV3MWmmJZWVyBROIeH/9HDv
         ONtQ==
X-Gm-Message-State: AOAM530TK8UKT0ttcpOTZ41YUohkTUC42qRRPspWnU8QNM4JgDBmtZlp
        WGan/oo+UwJM1aqyJnQ0TcWUbNTNyL6GFR1sGRk1LQq8A8a8aqDdCJ0d9mQE+GQ8hEeGd4cYcn9
        AlA1/RF/ay2RtIkuYbgE=
X-Received: by 2002:a05:6402:190d:: with SMTP id e13mr8092821edz.339.1636624400201;
        Thu, 11 Nov 2021 01:53:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzp74fhV+A0BlicDRmgQzd2ZzPgKl37hWijytHEwGPVHnxogi3w6VW/NOe4TlP9qnF8BXHLNQ==
X-Received: by 2002:a05:6402:190d:: with SMTP id e13mr8092803edz.339.1636624400033;
        Thu, 11 Nov 2021 01:53:20 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id z7sm1258687edj.51.2021.11.11.01.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 01:53:19 -0800 (PST)
Message-ID: <27e86396-63cd-be69-e344-bc3229b91a9b@redhat.com>
Date:   Thu, 11 Nov 2021 10:53:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2] standardized attributes for powersupply charge behaviour
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        linux-pm@vger.kernel.org
Cc:     nicolopiazzalunga@gmail.com, linrunner@gmx.net,
        platform-driver-x86@vger.kernel.org, smclt30p@gmail.com,
        sre@kernel.org
References: <20211108192852.357473-1-linux@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211108192852.357473-1-linux@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/8/21 20:28, Thomas Weißschuh wrote:
> This a revised version of
> "[RFC] add standardized attributes for force_discharge and inhibit_charge" [0],
> incorporating discussion results.
> 
> The biggest change is the switch from two boolean attributes to a single
> enum attribute.
> 
> [0] https://lore.kernel.org/platform-driver-x86/21569a89-8303-8573-05fb-c2fec29983d1@gmail.com/

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  Documentation/ABI/testing/sysfs-class-power | 14 ++++++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  7 +++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index ca830c6cd809..2f58cfc91420 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -455,6 +455,20 @@ Description:
>  			      "Unknown", "Charging", "Discharging",
>  			      "Not charging", "Full"
>  
> +What:		/sys/class/power_supply/<supply_name>/charge_behaviour
> +Date:		November 2021
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Represents the charging behaviour.
> +
> +		Access: Read, Write
> +
> +		Valid values:
> +			================ ====================================
> +			auto:            Charge normally, respect thresholds
> +			inhibit-charge:  Do not charge while AC is attached
> +			force-discharge: Force discharge while AC is attached
> +
>  What:		/sys/class/power_supply/<supply_name>/technology
>  Date:		May 2007
>  Contact:	linux-pm@vger.kernel.org
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index c3d7cbcd4fad..26c60587dca1 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -172,6 +172,7 @@ static struct power_supply_attr power_supply_attrs[] = {
>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_LIMIT_MAX),
>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_END_THRESHOLD),
> +	POWER_SUPPLY_ENUM_ATTR(CHARGE_BEHAVIOUR),
>  	POWER_SUPPLY_ATTR(INPUT_CURRENT_LIMIT),
>  	POWER_SUPPLY_ATTR(INPUT_VOLTAGE_LIMIT),
>  	POWER_SUPPLY_ATTR(INPUT_POWER_LIMIT),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 9ca1f120a211..70c333e86293 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -132,6 +132,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
> +	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
>  	POWER_SUPPLY_PROP_INPUT_POWER_LIMIT,
> @@ -202,6 +203,12 @@ enum power_supply_usb_type {
>  	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
>  };
>  
> +enum power_supply_charge_behaviour {
> +	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO = 0,
> +	POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE,
> +	POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE,
> +};
> +
>  enum power_supply_notifier_events {
>  	PSY_EVENT_PROP_CHANGED,
>  };
> 
> base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
> 

