Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A0C59FA1F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Aug 2022 14:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbiHXMkK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Aug 2022 08:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbiHXMkK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Aug 2022 08:40:10 -0400
X-Greylist: delayed 505 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 Aug 2022 05:40:08 PDT
Received: from vorpal.se (vorpal.se [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846D22B603
        for <linux-pm@vger.kernel.org>; Wed, 24 Aug 2022 05:40:08 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 34306140DD;
        Wed, 24 Aug 2022 12:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1661344297; bh=a6Zh9SBCFhFGc1GsGLLtFuXCqaoI5jOUYrl8x9jHXF4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rbr4JFQG7HNUcltQhXQYDLlOkSLEZ8Kfg+zbC1DBghEkuNgIbYOiqlvNIvXETShgP
         OsyFb/8vqwAo0W4n0zyCP4oViT5YlO2EPEP2D6nzci90InGinS9piaX8iQ90FIExOK
         KtHphwlOMjIC2Eh0ukoH1D5JSR9+kkVBGrjajieqDoWI66tIlHii6X/HpyqnK/01xf
         2t6w+gmcd227en5dyjDrabSQPjqcEXGPFCowPMB+2+/GUFL28adB4Zn6KBVu9Lilz+
         lpJvyprBGZUtVh9RGsYkzw6eGrOAZxqoqUpFn5xZYGBpVkvLy3JMgbRX9+KlQ4SxPv
         t+5aNYuToYzAQ==
Message-ID: <12a39cf6-1247-d2a3-bf07-51297e9b6640@vorpal.se>
Date:   Wed, 24 Aug 2022 14:31:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/2] [RFC] platform/x86: Fixes for Toshiba Z830
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Cc:     Azael Avalos <coproscefalo@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20220821200821.1837460-1-lkml@vorpal.se>
 <2ddade8b-7260-8497-12f2-c8b13cf35e6a@redhat.com>
From:   Arvid Norlander <lkml@vorpal.se>
In-Reply-To: <2ddade8b-7260-8497-12f2-c8b13cf35e6a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2022-08-22 13:39, Hans de Goede wrote:
> Hi Arvid,
> 
> Nice to meet you.
> 
> On 8/21/22 22:08, Arvid Norlander wrote:
>> Hi,
>>
>> NOTE: I had some trouble sending this with git send-email, I only managed
>> to send one copy successfully! Sorry if I managed to send it multiple
>> times.
>>
>> I'm new to this kernel development thing, so applogies in advance for any
>> mistakes.
> 
> No worries, I think you are doing great so far.
>
> Thank you for the detailed analysis and for all the work you are putting
> into this.

Thanks for the quick and detailed feedback. I agree with your reasoning,
it seems sound.

However, note that this will likely take me some time, as for me kernel
development is purely done as a hobby and it has to fit in between all my
other hobbies such as hiking, etc. Do not mistake radio silence for that I
have given up, just that I don't have much time.

> 
>> I have an old Toshiba Z830-10W laptop. Unfortunately it doesn't
>> work well under Linux. Fortunately I spent some time figuring out what was
>> wrong. I had documented my findings below. I have also included patches
>> (see the next few emails) for some of the issues.
>>
>> I would like advice on how to proceed for some of the more advanced
>> problems though:
>> * Do we want to expose all these features that I figured out? For example,
>>   how to set the boot order on this old BIOS-only laptop from user space.
>>   Or various other settings accessible via the BIOS.
> 
> I'll try to write a short reply to each feature separately,
> I think we need to balance the worth of a feature to end users vs the amount
> of code to write + maintain here. E.g. adding support for non working
> hw buttons is generally considered worth the effort. Adding support for
> changing the boot-order not so much.
> 
> Note there is a generic interface for changing BIOS options from
> within Linux, so if you can change all (or almost all) BIOS options,
> you could consider implementing support for:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-class-firmware-attributes
> 
> That has been implemented for Lenovo Think* and for some Dell
> models, but by the vendors themselves and the used WMI APIs are
> actually guaranteed to work on multiple models / generations hardware
> making it worth the effort. Also this is something which their
> customers want for managed rollout of these devices in big
> companies.
> 
> IMHO for these Toshiba laptops I still think it is a lot of work
> for something which won't see much use.
> 
> It would be good though to:
> 1. Write some generic documentation from an end user pov for toshiba_acpi as:
> Documentation/admin-guide/laptops/toshiba_acpi.rst
> see:
> Documentation/admin-guide/laptops/thinkpad-acpi.rst
> as an example
>
> 
> 2. Extend the doc from 1. with toshiba_acpi firmware API documentation,
> including your findings on protocol bits which we won't directly
> implement/use so that this is at least written down in case it is
> needed later.

This seems like a good idea indeed.

> For 2. you can actually just copy and paste a lot of this email,
> I believe that having the info in this email in a
> Documentation/admin-guide/laptops/toshiba_acpi.rst file
> will make it a lot easier to find in the future then only having
> it in the mailinglist archives.
> 
>> * For the hardware buttons I describe below, is a solution specific to
>>   toshiba_acpi preferred, or should additional effort be spent on
>>   investigating a generic solution?
> 
> Ok, this is interesting there actually is a specification from
> Microsoft for this:
> http://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/dirapplaunch.docx
> 
> And there was a previous attempt to add support for the PNP0C32 devices:
> https://marc.info/?l=linux-acpi&m=120550727131007
> https://lkml.org/lkml/2010/5/28/327
> 
> And this even made it into drivers/staging for a while, if you do:
> git revert 0be013e3dc2ee79ffab8a438bbb4e216837e3d52
> you will get a: drivers/staging/quickstart/quickstart.c file.
> 
> Note this is not great code:
> 
> 1. If you do:
>   ls /sys/bus/platform/devices
>   You should already see a couple of PNP0C32 platform devices there and the
>   driver should simply bind to those rather then creating its own platform device
> 2. As mentioned this really should use the standard /dev/input/event interface
>   for event reporting and allow userspace to change the scancode to EV_KEY*
>   mapping. You can do this e.g. by using a sparse_keymap for the scancode to
>   EV_KEY* mapping which will give you this for free.

I have yet to have time to look at it. However this seems to suggest that
these buttons should work when the laptop is off. That is not the case on
the Z830. They only do anything when the computer is on and I can't find
any settings to change that.

Looking at the specification it also mentions several different
notification codes for the button. The only one used on the Z830 is 0x80.
That is, as far as I can tell from the decompilation of the DSDT.

Thus I worry I will not be able to test any sort of generic implementation
very well, if the Z830 only implements a small subset of the functionality.

>> Before I start coding on these more complex issues I would like advice in
>> order to avoid wasting my time on bad designs. In particular, on how to
>> proceed with the "Hardware buttons" section below.
> 
> I believe that sending the magic command to make these keys generate events
> should be part of toshiba_acpi, combined with a generic PNP0C32 driver
> for actually reporting the key-presses.

I guess there is no way to figure out what the buttons are supposed to mean in
this case, and we simply have to leave that to the user to map as they see fit
(as long as the IDs are stable). I'm not sure how well that works with the event
subsystem, as when I test evtest it seems to asign some sort of labels to the
events (e.g. KEY_SLEEP, KEY_BLUETOOTH, ...).

> [...]
>>
>> 3. LED: "Eco" LED [implemented in patch 1]
>> =================
>>
>> The toshiba_acpi driver has support for controlling some LEDs including the
>> "Eco" LED. Unfortunately that LED works differently on this laptop.
>>
>> The toshiba_acpi driver checks for TOS_INPUT_DATA_ERROR and tries a
>> different format. On the Z830 the error returned is TOS_NOT_SUPPORTED
>> though the different format still works.
> 
> This looks good I'll go and merge it into my for-next git branch
> sometime this week (I usually merge patches in batches).

Awsome!

> 
>> 4. Battery charge mode [implemented in patch 2]
>> ======================
>>
>> This laptop supports not charging the battery fully in order to prolong
>> battery life. Unlike for example ThinkPads where this control is granular
>> here it is just off/on. When off it charges to 100%. When on it charges to
>> about 80%.
>>
>> According to the Windows program used to control the feature the setting
>> will not take effect until the battery has been discharged to around 50%.
>> However, in my testing it takes effect as soon as the charge drops below
>> 80%. On Windows Toshiba branded this feature as "Eco charging"
>>
>> In the following example ACPI calls I will use the following newly defined
>> constants:
>> #define HCI_BATTERY_CHARGE_MODE 0xba
>> #define BATTERY_CHARGE_FULL 0
>> #define BATTERY_CHARGE_80_PERCENT 1
>>
>> To set the feature:
>>   {HCI_SET, HCI_BATTERY_CHARGE_MODE, charge_mode, 0, 0, 0}
>> To query for the existence of the feature:
>>   {HCI_GET, HCI_BATTERY_CHARGE_MODE, 0, 0, 0, 0}
>> To read the feature:
>>   {HCI_GET, HCI_BATTERY_CHARGE_MODE, 0, 0, 0, 1}
>>
>> The read may need to be retried if TOS_DATA_NOT_AVAILABLE is returned as
>> the status code. This rarely happens (I have never observed it on Linux),
>> but I have seen it happen under Windows once, and the software did retry
>> it.
> 
> Hmm, this is interesting if you look at:
> 
> Documentation/ABI/testing/sysfs-class-power
> 
> You will see there already is a standard API for this in the form of
> adding a "charge_control_end_threshold" attribute to the standard
> ACPI /sys/class/power_supply/BAT*/ sysfs interface. See e.g.
> drivers/platform/x86/thinkpad_acpi.c
> 
> For an example of how to add sysfs attributes to a battery
> which is managed by the standard drivers/acpi/battery.c driver.
> 
> I think you can use this standard attribute enabling eco charging
> for any writes with a value <= 90 and disabling it for values
>> 90 (90 being halfway between 80 and 100).
> 
> While always showing 80 or 100 on read.
> 
> You should then also write a patch for:
> 
> Documentation/ABI/testing/sysfs-class-power
> 
> Adding something like this to the "charge_control_end_threshold"
> section:
> 
> "not all hardware is capable of setting this to an arbitrary
> percentage. Drivers will round written values to the nearest
> supported value. Reading back the value will show the actual
> threshold set by the driver."
> 
> (feel free to copy verbatim, but maybe you can do better)
> 
> 

This makes perfect sense, but I don't know if it is guaranteed to be 80%
on all Toshiba laptops. Do you know of any other Toshiba laptops that
have/had this feature, and if so, what the limits are? The Windows driver
for this laptop does not document exactly what the limit is. 80% is simply
what I have observed in practice.

>> 6. Panel power control via HCI
>> ==============================
>>
>> The toshiba_acpi driver supports controlling the panel power via SCI calls
>> (SCI_PANEL_POWER_ON). Based on the fact that the toshiba_acpi driver
>> outputs a message about reboot being needed I assume this is related to
>> panel power during boot?
>>
>> However there is a HCI call that can turn the panel off or on immediately:
>>
>> #define HCI_PANEL_POWER_ON 0x2
>> #define PANEL_ON 1
>> #define PANEL_OFF 0
>>
>> To read/query existence: {HCI_GET, HCI_PANEL_POWER_ON, 0, 0, 0, 0}
>> To write: {HCI_SET, HCI_PANEL_POWER_ON, panel_on, 0, 0, 0}
>>
>> This could be related to some backlight issues this laptop is having where
>> backlight control stops working after a suspend/resume.
>>
>> Control via /sys/class/backlight/intel_backlight always works on this
>> laptop, however, most desktop environment seems to prefer the acpi_video or
>> vendor backlight controls if those exist.
>>
>> I have tried acpi_backlight=vendor/native but that is broken in the same
>> way. With acpi_backlight=none, the screen never turns on after a resume.
>> However if I turn it on using the above HCI call, everything works
>> normally after that. And since only the intel_backlight driver is left,
>> the desktop environment controls backlight via that method.
>>   
>> I have yet to find a satisfactory solution to this problem, but I suspect
>> the correct solution would be to fix backlight control from acpi_video,
>> if that is possible. Suggestions?
> 
> I think this is another case of some Toshiba devices needing the
> acpi_video backlight level save/restore behavior over suspend/resume
> while leaving the actual backlight control to intel_backlight.
> 
> Quoting from: drivers/acpi/acpi_video.c :
> 
>          * Some machines have a broken acpi-video interface for brightness
>          * control, but still need an acpi_video_device_lcd_set_level() call
>          * on resume to turn the backlight power on.  We Enable backlight
>          * control on these systems, but do not register a backlight sysfs
>          * as brightness control does not work.
>          */
>         {
>          /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
>          .callback = video_disable_backlight_sysfs_if,
>          .ident = "Toshiba Portege R700",
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
>                 },
>         },
> 
> Also:
> Toshiba Portege R830:    https://bugs.freedesktop.org/show_bug.cgi?id=82634
> Toshiba Satellite R830:  https://bugzilla.kernel.org/show_bug.cgi?id=21012
> 
> You can see if the same option fixes things for you by adding:
> "video.disable_backlight_sysfs_if=1" to your kernel commandline while
> removing all other options. If this works, please submit a patch to
> add your model to the list in drivers/acpi/acpi_video.c, or provide
> dmidecode output, then I can do it for you.

I will test this when I get some time (hopefully at the end of this
weekend, after comming from a multi-day hiking trip).

> 
>> 7. BIOS setting control from the OS [should we bother?]
>> ===================================
>> Several of the BIOS settings can be controlled from the OS. This all
>> happens via SCI calls. On Windows the "Hwsetup.exe" program offers this
>> control. I'm not sure how useful any of this is (as this is already
>> available via the BIOS).
>>
>> If you think it is a good idea I could absolutely implement support for
>> this. Otherwise I might build a simple user space tool on top of acpi_call
>> for this. 
> 
> As discussed above I don't really think we should bother; and IMHO
> certainly not something worth spending time on before the other issues
> are wrapped up.

Makes perfect sense, and kind of what I suspected.

> [...]
> 
> Regards,
> 
> Hans
> 

