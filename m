Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867D6424151
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 17:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbhJFP3V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 11:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231671AbhJFP3U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 11:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633534048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQJVG/EGfE2G57NymaxMKQIMPNI/sV59x/LAV/vdHp8=;
        b=eYgMCCO95MEXW93QxFKCQusOe5cURXJfnAQ9r0p/474NDIQDCjyyb1wRi8moyJb5wL4tjR
        HiE/YRa4knRNzT6dwufUbEs/SdZ7q4xTN0FSYnSD9l/FKnS+ZvSWDBUDSZxUQ53vDnwFSh
        wWit+mjFtNHNo8E6oL0Q/H1FVl8FvrM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-xU2_3P_PPn6kwFvpB3iTMQ-1; Wed, 06 Oct 2021 11:27:25 -0400
X-MC-Unique: xU2_3P_PPn6kwFvpB3iTMQ-1
Received: by mail-ed1-f69.google.com with SMTP id x5-20020a50f185000000b003db0f796903so2953546edl.18
        for <linux-pm@vger.kernel.org>; Wed, 06 Oct 2021 08:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CQJVG/EGfE2G57NymaxMKQIMPNI/sV59x/LAV/vdHp8=;
        b=3YBefcc8HGeEDj3VOPyGYJboagTeJ9uHvrjvi59tomAmMt7iUZvcJXGByvFIcr6Jml
         /7FY0ojARRERPAn1IaTDXP5Qj8RxFqP7/wVzhyFPKWqOBgaC84BVSe0Dq6m3QKbZ4Zk+
         9sOVpHVjStCmmPA2Yn73nVQrmmoLuXHTxFBBMVmRyGVg3s/fTjl99AJItK2SpS88j8BZ
         +OcJqwFP+/z+IhqWfMEbMyECp2P9cl9LHwaAIBXoQSilMSCghzuvGekant9y+uWgPVKS
         Ao+Zq/2YijCtob5v7pz47vzpLCYwZbp7kKhD7Kl4Xt9KDT9CEQZ0gK6Bs+CzSIPCNXzz
         IThA==
X-Gm-Message-State: AOAM5317nxHtKPZC/ruIKYZr8rj2SOwXNE4RHi1qACpxwTROPbu4TMol
        8mfIR0L7rfszaj4nw/C9HHVrvyHP5ey9UYN5EhI79ZrCuD1fFeGpIgM+zSKOu8Ia+QvwKsQNhl7
        4ZZWFXXKD7erzpXzdoZk=
X-Received: by 2002:a17:906:154c:: with SMTP id c12mr34643354ejd.76.1633534044133;
        Wed, 06 Oct 2021 08:27:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxj728KC6yVTbMjGm5m87qqw9jueUSC51MSImhgYlPs/wpf03ShkwTSo5RDuYe5L3zxqV3skA==
X-Received: by 2002:a17:906:154c:: with SMTP id c12mr34643333ejd.76.1633534043964;
        Wed, 06 Oct 2021 08:27:23 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id p23sm10883249edw.94.2021.10.06.08.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 08:27:23 -0700 (PDT)
Subject: Re: [RFC] add standardized attributes for force_discharge and
 inhibit_charge
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@weissschuh.net>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        =?UTF-8?Q?Nicol=c3=b2_Piazzalunga?= <nicolopiazzalunga@gmail.com>,
        linux-pm@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Thomas Koch <linrunner@gmx.net>,
        "smclt30p@gmail.com" <smclt30p@gmail.com>
References: <21569a89-8303-8573-05fb-c2fec29983d1@gmail.com>
 <77e39b3e-fa51-54fe-1898-4f43895ac2c6@redhat.com>
 <20211005162352.emaoveimhkp5uzfw@earth.universe>
 <06fa7a23-4dec-cba9-4e00-c00cf0bf9337@redhat.com>
 <20211005220630.zurfqyva44idnplu@earth.universe>
 <8cbf7671-d9ee-6bfc-d8fd-d360ccb2c595@redhat.com>
 <f2e99c38-2e2f-4777-8318-fb4dae6e8bf1@t-8ch.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <04693bb2-9fd1-59fa-4c21-99848e8aa4c4@redhat.com>
Date:   Wed, 6 Oct 2021 17:27:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f2e99c38-2e2f-4777-8318-fb4dae6e8bf1@t-8ch.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/6/21 4:49 PM, Thomas Weißschuh wrote:
> On 2021-10-06T10:10+0200, Hans de Goede wrote:
>> Hi,
>>
>> On 10/6/21 12:06 AM, Sebastian Reichel wrote:
>>> Hi,
>>>
>>> On Tue, Oct 05, 2021 at 08:01:12PM +0200, Hans de Goede wrote:
>>>> Right, force-discharge automatically implies charging is
>>>> being inhibited, so putting this in one file makes sense.
>>>>
>>>> Any suggestion for the name of the file?
>>>
>>> Maybe like this?
>>>
>>> ---------------------------------------------------------------------
>>> What: /sys/class/power_supply/<supply_name>/charge_behaviour
>>> Date: October 2021
>>> Contact: linux-pm@vger.kernel.org
>>> Description:
>>>  Configure battery behaviour when a charger is being connected.
>>>
>>>  Access: Read, Write
>>>
>>>  Valid values:
>>>
>>>  0: auto / no override
>>>     When charger is connected battery should be charged
>>>  1: force idle
>>>     When charger is connected the battery should neither be charged
>>>     nor discharged.
>>>  2: force discharge
>>>     When charger is connected the battery should be discharged
>>>     anyways.
>>> ---------------------------------------------------------------------
>>
>> That looks good to me. Although I just realized that some hw may
>> only support 1. or 2. maybe explicitly document this and that
>> EOPNOTSUPP will be reported when the value is not supported
>> (vs EINVAL for plain invalid values) ?
> 
> Would that not force a userspace applications to offer all possibilities to
> the user only to tell them that it's not supported?
> If the driver knows what is supported and what not it should make this
> discoverable without actually performing the operation.
> 
> Maybe something along the lines of /sys/power/mem_sleep.

Good point, but something like /sys/power/mem_sleep works
very differently then how all the other power_supply properties work.

In general if something is supported or not on a psy class
device is communicated by the presence / absence of attributes.

So I think we should move back to having 2 separate attributes
for this after all; and group the 2 together in the doc and
document that enabling (setting to 1) one of force_charge /
inhibit_charge automatically clears the setting of the other.

Then the availability of the features can simply be probed
by checking for the presence of the property files.

Regards,

Hans

