Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B58929E7B9
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 10:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgJ2JrA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 05:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726830AbgJ2JrA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 05:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603964819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4juQfAx3LxBzTcqekjK+MOSoDZx1NTXS/wKZYQGOXo=;
        b=bZ+EizmdusBAs9eMH+VnmStqKP35hI/ftRtfIeluz455oHtItu6RJd8Oi1cdUUPLgM1rN/
        XxSFgu/Ds25Zv/JbJgKsRfFQXPl7gHZu2QVnjUNJhvxAP96gUj72ZwMfoSTxJQAkZzyzlk
        bGRNxWNADx/dxFV6VQvfCaWk415L+uA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-hkdN7Ma0NdClriaqKiTC3A-1; Thu, 29 Oct 2020 05:46:56 -0400
X-MC-Unique: hkdN7Ma0NdClriaqKiTC3A-1
Received: by mail-ed1-f69.google.com with SMTP id cb27so944809edb.11
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 02:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v4juQfAx3LxBzTcqekjK+MOSoDZx1NTXS/wKZYQGOXo=;
        b=bnvoQ7wzpYoPY9wPi9PoH1Il6ab+4bppI2Q0RThdGnSoBAhgHZ1hBNwWKHqyXfowJ2
         996mPBl0Me6LrN7V7FE+b3WmuTC86si0Vh6Xd2EvpfBYHIeLfFdvTyVr9ZvZX6kEgCRm
         4c6jvDz298uf/HKoGNaGVXZZSQ0RlxIX6RJnOtmxRNM+1eAts6nmre9lG5olUtZjAx0T
         9hRfZysomijlUXVcfWUoK22skomkhydW204CPqYNR/iE7CtB6TkGz6mv8YNOUPdwsNb3
         6QtCyek4CmU/iSDbk7JXXMtYzDiDBXMmZ4hf2cxB8xsnA7EKNWZDqU/L89Xz6lukLYwV
         kw+Q==
X-Gm-Message-State: AOAM531v2lc04GMWd/RmBJaQRwxeGQ24hq37EkFrIL/3qnIT2QjJI/Ib
        lZ/Riebj1XmXSSCDGQQxAqMtOB3VFt73MsjZbXbj4YBXxCMEx1QD24UHjrh4KOmsqNy7D4PVjLd
        sZ6Fw0hoGcMSJeCAln+0=
X-Received: by 2002:a05:6402:1691:: with SMTP id a17mr2984354edv.264.1603964800377;
        Thu, 29 Oct 2020 02:46:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKE7w0otUI+gbsHiZO1jXP8ILglLHS0/NREeyAFavkgmdFK4zjz2UD5PtGB/B2pPdy0w21NQ==
X-Received: by 2002:a05:6402:1691:: with SMTP id a17mr2984338edv.264.1603964800185;
        Thu, 29 Oct 2020 02:46:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id p20sm1140405ejd.78.2020.10.29.02.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 02:46:39 -0700 (PDT)
Subject: Re: [External] Re: [PATCH] Documentation: Add documentation for new
 platform_profile sysfs attribute
To:     Mark Pearson <markpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>
Cc:     dvhart@infradead.org, mgross@linux.intel.com,
        mario.limonciello@dell.com, eliadevito@gmail.com, bberg@redhat.com,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <markpearson@lenovo.com>
 <20201027164219.868839-1-markpearson@lenovo.com>
 <5ca1ae238b23a611b8a490c244fd93cdcc36ef79.camel@hadess.net>
 <d5f0bcba-5366-87da-d199-a85d59ba6c1c@redhat.com>
 <b3e61ee4-3fca-ce06-2216-977586baae4e@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ebeec472-3310-c560-e8bf-2b33c480333b@redhat.com>
Date:   Thu, 29 Oct 2020 10:46:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <b3e61ee4-3fca-ce06-2216-977586baae4e@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/29/20 1:55 AM, Mark Pearson wrote:
> Thanks Hans and Bastien,
> 
> On 28/10/2020 13:23, Hans de Goede wrote:

<big snip>

>>> Is there another file which explains whether those sysfs value will
>>> contain a trailing linefeed?
>>
>> sysfs APIs are typically created so that they can be used from the shell,
>> so on read a newline will be added. On write a newline at the end
>> typically is allowed, but ignored. There are even special helper functions
>> to deal with properly ignoring the newline on write.
>>
>> Regards,
>>
>> Hans
>>
>>
> OK - does that need to actually be specified here? Or is that just something I keep in mind for the implementation?

IMHO it does not belong in the sysfs API docs for the platform_profile
stuff. But I guess it would be good to document it somewhere in some
generic syfs API rules/expectations document (with a note that their
might be exceptions).

Ideally we would already have such a file somewhere, but I don't know
if we do (I did not look). So if you feel like it (and such a file does
not exist yet) then I guess a patch adding such a doc file would be good.

Regards,

Hans

