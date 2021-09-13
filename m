Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51004408E17
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 15:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbhIMNb0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 09:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241734AbhIMN2P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Sep 2021 09:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631539619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yHnbvY67LixK/m3a5RiMzLpIS0FmMbV1UsxlAIA/C74=;
        b=VhvmGJHxWvwvnawQrn6FQgQaSHUxjD62siD7J+40PCp3yi50BcJbSFHGaTsnc1puyZgncE
        Z1OFr5x0J4N+BGkUcwIzc924h2dtSSz2IEvn/dPAsWl47vhinloLCIM1wNCP6txki0D6mt
        wIhz+MfL6YvESPvcn3fmvoFRSCWyoOk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-eJj0knOFP4q7zZ7ZXzrasA-1; Mon, 13 Sep 2021 09:26:58 -0400
X-MC-Unique: eJj0knOFP4q7zZ7ZXzrasA-1
Received: by mail-ed1-f70.google.com with SMTP id y10-20020a056402270a00b003c8adc4d40cso4903527edd.15
        for <linux-pm@vger.kernel.org>; Mon, 13 Sep 2021 06:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yHnbvY67LixK/m3a5RiMzLpIS0FmMbV1UsxlAIA/C74=;
        b=mFlIZALi7DfCZf58j8J78dy9Wo18auGX6/XdzoPIspG25jOSiLQU13P8yvqc+jgLCX
         nxU6hWVe0bFvaXuC/+lKGLzOdgKuF4eLebO1HixKfW2hDvK2GhkfHuQRiX6+xrj/IlfH
         kVTTWAHBm/7PZPjGEZQc8+MDOsQX87ys2yMcAah/4fipG1MkKgdiNZwDYZeGcdVWn108
         ooi717787nEAt455iiyP33+mXfYG9HxXF4+SHXbeAslyLO8UQr4/jJXO5eycrOED3Ybh
         fvtQMeC6K5Es6GZyylAUvjDcWAfg2XoemZuiqoLwvrebwkGBnmTm29cHV1PuW+690EoZ
         mI4A==
X-Gm-Message-State: AOAM532kYLRCsnvQkSI3AxZH/Ewcz6sabZFsvPev7RYexwOYWSSDjJsh
        SEcear00nGo4NlP8Jif3xb4U3m943QEi9caViYjHHf7zBoq1PfzGNJeUfqeDXylXRs08aiNQQFs
        M1TAFnIn09jzL586XlHaiLVjm6qr/V8/SQG4xZMMysYnf6bix5uwk/WYu6aYEHerAh58cal4=
X-Received: by 2002:a17:906:3746:: with SMTP id e6mr9709516ejc.57.1631539616853;
        Mon, 13 Sep 2021 06:26:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSWbqbep2H8U+DaDSgIZemzqj0QJSnaWSP9cLK1/FDTNcpKzpfz6jpf2Im9tgS9lOAh7EknQ==
X-Received: by 2002:a17:906:3746:: with SMTP id e6mr9709489ejc.57.1631539616604;
        Mon, 13 Sep 2021 06:26:56 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id e22sm4078185edu.35.2021.09.13.06.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 06:26:56 -0700 (PDT)
Subject: Re: [PATCH] docs: ABI: sysfs-class-power: Documented cycle_coint
 property
To:     Bastien Nocera <hadess@hadess.net>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20210913120925.591608-1-hdegoede@redhat.com>
 <ce83276a3d7b0f838c983c77a7e6313b1a97f8f7.camel@hadess.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3f68b3c4-3820-dc31-e603-126d6b00f6ba@redhat.com>
Date:   Mon, 13 Sep 2021 15:26:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ce83276a3d7b0f838c983c77a7e6313b1a97f8f7.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 9/13/21 3:11 PM, Bastien Nocera wrote:
> On Mon, 2021-09-13 at 14:09 +0200, Hans de Goede wrote:
>> Commit c955fe8e0bdd ("POWER: Add support for cycle_count") added a
>> POWER_SUPPLY_PROP_CYCLE_COUNT "cycle_count" property to the set of
>> standard power-supply properties, but this was never documented,
>> document it now.
> 
> Thanks very much Hans.
> 
> There's a typo in the subject line, and I had a couple of comments.

Ugh, I already send a v2 to address the positive spelling error,
well guess I'll do a v3 now then :)

> 
>> Link: https://gitlab.freedesktop.org/upower/upower/-/issues/152
>> Reported-by: Bastien Nocera <hadess@hadess.net>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  Documentation/ABI/testing/sysfs-class-power | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-power
>> b/Documentation/ABI/testing/sysfs-class-power
>> index ca830c6cd809..643637c6bb58 100644
>> --- a/Documentation/ABI/testing/sysfs-class-power
>> +++ b/Documentation/ABI/testing/sysfs-class-power
>> @@ -480,6 +480,17 @@ Description:
>>  
>>                 Valid values: Represented in microvolts
>>  
>> +What:          /sys/class/power_supply/<supply_name>/cycle_count
>> +Date:          January 2010
>> +Contact:       linux-pm@vger.kernel.org
>> +Description:
>> +               Reports the number of full charge + discharge cycles
>> the
>> +               battery has undergone.
> 
> What happens if a device doesn't report cycle_count, the property just
> doesn't exist?

Right, that is how all these properties work, if something is not
reported by the battery the property is not there.

> 
>> +
>> +               Access: Read
>> +
>> +               Valid values: Possitive integer representing full
>> cycles
> 
> positive

Ack, already fixed in v2.

Regards,

Hans


> 
>> +
>>  **USB Properties**
>>  
>>  What:          /sys/class/power_supply/<supply_name>/input_current_l
>> imit
> 
> 

