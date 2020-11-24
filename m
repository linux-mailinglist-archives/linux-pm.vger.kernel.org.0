Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C7D2C25D5
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 13:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbgKXMiU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 07:38:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387480AbgKXMiT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 07:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606221497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Pe4Fv9SOw/e9Pc19WnvG+q2V/PwddrUiSjsAligT8s=;
        b=PYY390RdHpNgI/HfK1qWbtuU23E5nm/01Bgt2FRr2w2Dz8MXCYEjspQD506buSDx9G7JzX
        0Itoud00pGi9q3GzysMR/2OOZ+M2eWEC6t6Ahj3fHckUQIStvmnexjeQ8Z9pN40wayBCXT
        wbHlDhrrPN3g8g6h3wx6lfK5JJTlUPk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-WM3SYKYTN4aEUNbqfjv0hg-1; Tue, 24 Nov 2020 07:38:15 -0500
X-MC-Unique: WM3SYKYTN4aEUNbqfjv0hg-1
Received: by mail-ed1-f71.google.com with SMTP id dj19so7888315edb.13
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2020 04:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Pe4Fv9SOw/e9Pc19WnvG+q2V/PwddrUiSjsAligT8s=;
        b=HVEOwHGb00On5zba++Wyo5sIwxgYCjO4Sh/Kb6q/lSU7TWI4dFjt4yA1elS6+WEVmT
         2PtwjDKmN2k6z/8gx2T64GKREYFd/IzzLOSnn6zYZVCdI4QbNlLVoqzHyGyeB895MfEx
         LvVAY3A4Gpyt5l+AhELnG10w5NGxYgTk4GyQKAyAW9clxuGNROUIGmZ3wU9m8jXEatx7
         c8Q8HmHaQMEd443nv41y16buIiFRTv1u7F4ICdhnT68f3EGs7pCLZqtXNYHTytbJf0e7
         NqO7rXLUaQXgqvpchr5yZ+pUcw/UemI4SbA65+B9uerWIpWsggPM89/C7eEqYV+FyI6i
         3xJg==
X-Gm-Message-State: AOAM530K8yzBTpWrlAvmZrlpoZaQgJvCDbVbox0TQ7l1vXnFsSAlBa7s
        nhHPezBz3LchprKiFrurK6SWWnFF0WUYNr3TJyB0OmBIgoZ/FZgPil+/C14sYSFSs1e9RxzzDD8
        U6RuNeAqKAr1xVgTdLCM=
X-Received: by 2002:a17:906:374a:: with SMTP id e10mr3782111ejc.246.1606221492970;
        Tue, 24 Nov 2020 04:38:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxM9XH8pp5RxuCGvxaI1xqztYV9K1vRQ8/VpIVsgbGZ0rBU3yXQkahFLaFO8cValalDav12BA==
X-Received: by 2002:a17:906:374a:: with SMTP id e10mr3782094ejc.246.1606221492739;
        Tue, 24 Nov 2020 04:38:12 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id k11sm6849380edh.72.2020.11.24.04.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 04:38:12 -0800 (PST)
Subject: Re: How to enable auto-suspend by default
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
References: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
 <X6p6ubTOoMPUPPXi@kroah.com>
 <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
 <20201110172517.GC2495@lahna.fi.intel.com>
 <30957f1a-1fe5-5d9a-101b-25f12fb93907@redhat.com>
 <20201111143143.GV2495@lahna.fi.intel.com>
 <30aa8c96-1809-8c5f-2305-5e39fbeba434@redhat.com>
 <ecd964af-efdb-99c6-45cb-4979397fb324@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cfcc7c09-b8c7-c2c9-be0a-84949969d8be@redhat.com>
Date:   Tue, 24 Nov 2020 13:38:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <ecd964af-efdb-99c6-45cb-4979397fb324@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/24/20 1:37 PM, Mathias Nyman wrote:
> On 23.11.2020 15.54, Hans de Goede wrote:
>> Hi,
>>
>> On 11/11/20 3:31 PM, Mika Westerberg wrote:
>>> On Wed, Nov 11, 2020 at 12:27:32PM +0100, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 11/10/20 6:25 PM, Mika Westerberg wrote:
>>>>> On Tue, Nov 10, 2020 at 04:02:33PM +0000, Limonciello, Mario wrote:
>>>>>>>
>>>>>>> On Tue, Nov 10, 2020 at 11:57:07AM +0100, Bastien Nocera wrote:
>>>>>>>> Hey,
>>>>>>>>
>>>>>>>> systemd has been shipping this script to enable auto-suspend on a
>>>>>>>> number of USB and PCI devices:
>>>>>>>>
>>>>>>> https://github.com/systemd/systemd/blob/master/tools/chromiumos/gen_autosuspen
>>>>>>> d_rules.py
>>>>>>>>
>>>>>>>> The problem here is twofold. First, the list of devices is updated from
>>>>>>>> ChromeOS, and the original list obviously won't be updated by ChromeOS
>>>>>>>> developers unless a device listed exists in a ChromeBook computer,
>>>>>>>> which means a number of devices that do support autosuspend aren't
>>>>>>>> listed.
>>>>>>>>
>>>>>>>> The other problem is that this list needs to exist at all, and that it
>>>>>>>> doesn't seem possible for device driver developers (at various levels
>>>>>>>> of the stack) to opt-in to auto-suspend when all the variants of the
>>>>>>>> device (or at least detectable ones) support auto-suspend.
>>>>>>>
>>>>>>> A driver can say they support autosuspend today, but I think you are
>>>>>>> concerned about the devices that are controlled by class-compliant
>>>>>>> drivers, right?  And for those, no, we can't do this in the kernel as
>>>>>>> there are just too many broken devices out there.
>>>>>>>
>>>>>>
>>>>>> I guess what Bastien is getting at is for newer devices supported by class
>>>>>> drivers rather than having to store an allowlist in udev rules, can we set
>>>>>> the allowlist in the kernel instead.  Then distributions that either don't
>>>>>> use systemd or don't regularly update udev rules from systemd can take
>>>>>> advantage of better defaults on modern hardware.
>>>>>>
>>>>>> The one item that stood out to me in that rules file was 8086:a0ed.
>>>>>> It's listed as "Volteer XHCI", but that same device ID is actually present
>>>>>> in an XPS 9310 in front of me as well and used by the xhci-pci kernel module.
>>>>>>
>>>>>> Given we're effectively ending up with the combination of runtime PM turned
>>>>>> on by udev rules, do we need something like this for that ID:
>>>>>>
>>>>>> https://github.com/torvalds/linux/commit/6a7c533d4a1854f54901a065d8c672e890400d8a
>>>>>>
>>>>>> @Mika Westerberg should 8086:a0ed be quirked like the TCSS xHCI too?
>>>>>
>>>>> I think this one is the TGL PCH xHCI. The quirk currently for xHCI
>>>>> controllers that are part of the TCSS (Type-C SubSystem) where it is
>>>>> important to put all devices into low power mode whenever possible,
>>>>> otherwise it keeps the whole block on.
>>>>
>>>> Note that there are currently some IDs missing from the xHCIs which
>>>> are part of the TCSS too. At least the id for the xHCI in the thunderbolt
>>>> controller on the Lenovo T14 gen 1 is missing. I started a discussion
>>>> about extending the kernel quirk list for this vs switching to hwdb
>>>> a while a go:
>>>>
>>>> https://lore.kernel.org/linux-usb/b8b21ba3-0a8a-ff54-5e12-cf8960651086@redhat.com/
>>>>
>>>> The conclusion back then was to switch to hwdb, but I never got around to this.
>>>
>>> The reason I've added these to the xHCI driver is that it works even if
>>> you are running some really small userspace (like busybox). Also for the
>>> xHCI in TCSS we know for sure that it fully supports D3cold.
>>>
>>> (The one you refer above is actually mistake from my side as I never
>>>  tested Alpine Ridge LP controller which I think this is).
>>
>> Ok, so I'll submit a patch adding the 15c1 product-id for the
>> INTEL_ALPINE_RIDGE_LP_2C_XHCI controller to the list of ids for which we
>> set the XHCI_DEFAULT_PM_RUNTIME_ALLOW quirk. To fix the much too high
>> idle-power consumption problem on devices with this Alpine Ridge variant.
> 
> Thanks
> 
>>
>>>>> Typically we haven't done that for PCH side xHCI controllers though, but
>>>>> I don't see why not if it works that is. Adding Mathias to comment more
>>>>> on that since he is the xHCI maintainer.
>>>>
>>>> If we are also going to enable this for the non TCSS Intel XHCI controllers,
>>>> maybe just uncondtionally enable it for all Intel XHCI controllers, or
>>>> if necessary do a deny-list for some older models and enable it for anything
>>>> not on the deny-list (so all newer models). That should avoid the game of
>>>> whack-a-mole which we will have with this otherwise.
>>>
>>> This is really up to Mathias to decide. I'm fine either way :)
>>
>> Ok, Matthias what do you think about this?
> 
> I don't think we are ready to enable runtime pm as default for all Intel xHCI controllers.
> The risk of xHCI not waking up when user plugs a mouse/keyboard, making the system unusable
> just seems too high compared to the powersaving benefit.
> 
> The powersaving benefit from autosuspending the TCSS xHCI is a lot better, and we, (Mika mostly)
> has been able to verify they work.
> 
> So I propose we for now continue adding TCSS xHCI controllers to the allowlist in kernel.
> For others I think a userspace allow/denylist makes sense.
> 
> Long term goal would be default allow for all, with short denylist in kernel.

Ok, thank you for your input on this.

Regards,

Hans

