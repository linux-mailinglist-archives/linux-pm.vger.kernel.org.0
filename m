Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809C72C25CE
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 13:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbgKXMfg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 07:35:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:52789 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387530AbgKXMfg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Nov 2020 07:35:36 -0500
IronPort-SDR: H53SCl4JPQVVhId37oOeFXqR274E6UhpIl8vzNkvDO4jj/chI7U1HIY4v6FGFTpZ8T9HMrhUDZ
 6gIDZOz5zx2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="190060628"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="190060628"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 04:35:35 -0800
IronPort-SDR: /VW7t1HEueGL6TMTcOaGlcfZ3+047NqtbZMYZsQlPCcv+yS3N8ky8H8smVbj4nMeafmgnj0745
 GeBP4bshzFLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="478483431"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga004.jf.intel.com with ESMTP; 24 Nov 2020 04:35:32 -0800
Subject: Re: How to enable auto-suspend by default
To:     Hans de Goede <hdegoede@redhat.com>,
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
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <ecd964af-efdb-99c6-45cb-4979397fb324@linux.intel.com>
Date:   Tue, 24 Nov 2020 14:37:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <30aa8c96-1809-8c5f-2305-5e39fbeba434@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23.11.2020 15.54, Hans de Goede wrote:
> Hi,
> 
> On 11/11/20 3:31 PM, Mika Westerberg wrote:
>> On Wed, Nov 11, 2020 at 12:27:32PM +0100, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 11/10/20 6:25 PM, Mika Westerberg wrote:
>>>> On Tue, Nov 10, 2020 at 04:02:33PM +0000, Limonciello, Mario wrote:
>>>>>>
>>>>>> On Tue, Nov 10, 2020 at 11:57:07AM +0100, Bastien Nocera wrote:
>>>>>>> Hey,
>>>>>>>
>>>>>>> systemd has been shipping this script to enable auto-suspend on a
>>>>>>> number of USB and PCI devices:
>>>>>>>
>>>>>> https://github.com/systemd/systemd/blob/master/tools/chromiumos/gen_autosuspen
>>>>>> d_rules.py
>>>>>>>
>>>>>>> The problem here is twofold. First, the list of devices is updated from
>>>>>>> ChromeOS, and the original list obviously won't be updated by ChromeOS
>>>>>>> developers unless a device listed exists in a ChromeBook computer,
>>>>>>> which means a number of devices that do support autosuspend aren't
>>>>>>> listed.
>>>>>>>
>>>>>>> The other problem is that this list needs to exist at all, and that it
>>>>>>> doesn't seem possible for device driver developers (at various levels
>>>>>>> of the stack) to opt-in to auto-suspend when all the variants of the
>>>>>>> device (or at least detectable ones) support auto-suspend.
>>>>>>
>>>>>> A driver can say they support autosuspend today, but I think you are
>>>>>> concerned about the devices that are controlled by class-compliant
>>>>>> drivers, right?  And for those, no, we can't do this in the kernel as
>>>>>> there are just too many broken devices out there.
>>>>>>
>>>>>
>>>>> I guess what Bastien is getting at is for newer devices supported by class
>>>>> drivers rather than having to store an allowlist in udev rules, can we set
>>>>> the allowlist in the kernel instead.  Then distributions that either don't
>>>>> use systemd or don't regularly update udev rules from systemd can take
>>>>> advantage of better defaults on modern hardware.
>>>>>
>>>>> The one item that stood out to me in that rules file was 8086:a0ed.
>>>>> It's listed as "Volteer XHCI", but that same device ID is actually present
>>>>> in an XPS 9310 in front of me as well and used by the xhci-pci kernel module.
>>>>>
>>>>> Given we're effectively ending up with the combination of runtime PM turned
>>>>> on by udev rules, do we need something like this for that ID:
>>>>>
>>>>> https://github.com/torvalds/linux/commit/6a7c533d4a1854f54901a065d8c672e890400d8a
>>>>>
>>>>> @Mika Westerberg should 8086:a0ed be quirked like the TCSS xHCI too?
>>>>
>>>> I think this one is the TGL PCH xHCI. The quirk currently for xHCI
>>>> controllers that are part of the TCSS (Type-C SubSystem) where it is
>>>> important to put all devices into low power mode whenever possible,
>>>> otherwise it keeps the whole block on.
>>>
>>> Note that there are currently some IDs missing from the xHCIs which
>>> are part of the TCSS too. At least the id for the xHCI in the thunderbolt
>>> controller on the Lenovo T14 gen 1 is missing. I started a discussion
>>> about extending the kernel quirk list for this vs switching to hwdb
>>> a while a go:
>>>
>>> https://lore.kernel.org/linux-usb/b8b21ba3-0a8a-ff54-5e12-cf8960651086@redhat.com/
>>>
>>> The conclusion back then was to switch to hwdb, but I never got around to this.
>>
>> The reason I've added these to the xHCI driver is that it works even if
>> you are running some really small userspace (like busybox). Also for the
>> xHCI in TCSS we know for sure that it fully supports D3cold.
>>
>> (The one you refer above is actually mistake from my side as I never
>>  tested Alpine Ridge LP controller which I think this is).
> 
> Ok, so I'll submit a patch adding the 15c1 product-id for the
> INTEL_ALPINE_RIDGE_LP_2C_XHCI controller to the list of ids for which we
> set the XHCI_DEFAULT_PM_RUNTIME_ALLOW quirk. To fix the much too high
> idle-power consumption problem on devices with this Alpine Ridge variant.

Thanks

> 
>>>> Typically we haven't done that for PCH side xHCI controllers though, but
>>>> I don't see why not if it works that is. Adding Mathias to comment more
>>>> on that since he is the xHCI maintainer.
>>>
>>> If we are also going to enable this for the non TCSS Intel XHCI controllers,
>>> maybe just uncondtionally enable it for all Intel XHCI controllers, or
>>> if necessary do a deny-list for some older models and enable it for anything
>>> not on the deny-list (so all newer models). That should avoid the game of
>>> whack-a-mole which we will have with this otherwise.
>>
>> This is really up to Mathias to decide. I'm fine either way :)
> 
> Ok, Matthias what do you think about this?

I don't think we are ready to enable runtime pm as default for all Intel xHCI controllers.
The risk of xHCI not waking up when user plugs a mouse/keyboard, making the system unusable
just seems too high compared to the powersaving benefit.

The powersaving benefit from autosuspending the TCSS xHCI is a lot better, and we, (Mika mostly)
has been able to verify they work.

So I propose we for now continue adding TCSS xHCI controllers to the allowlist in kernel.
For others I think a userspace allow/denylist makes sense.

Long term goal would be default allow for all, with short denylist in kernel.

Thanks
Mathias 
