Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9225259BEAE
	for <lists+linux-pm@lfdr.de>; Mon, 22 Aug 2022 13:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiHVLja (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Aug 2022 07:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiHVLj3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2022 07:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA341B7BF
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2022 04:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661168365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dn7qcf5LVqUeHOtrJWDm7qcKmL26xaaKCkuxvydggKA=;
        b=PKpOWbqb/o9DJLUHR11xph00VeNCJ6sl67OV7tu6u0hWX7VSMtCaDcWTVOXxXcdoJ+RGSW
        8XoVaH9nnvD+Ehyz9w449DzoDlBSvUfOOTjf4JcaAi5NxlS8p0hHRtMCgKJVnGk8fCXina
        yD1gi/CDXyvGPglHpdUCuTILAFdnEXI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-OZ6FDANkOO6ohEHLXS7m2Q-1; Mon, 22 Aug 2022 07:39:24 -0400
X-MC-Unique: OZ6FDANkOO6ohEHLXS7m2Q-1
Received: by mail-ed1-f72.google.com with SMTP id q18-20020a056402519200b0043dd2ff50feso6756478edd.9
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2022 04:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Dn7qcf5LVqUeHOtrJWDm7qcKmL26xaaKCkuxvydggKA=;
        b=NWHs4nCe4wAkHan0JUeHK5VkNsypgmBf9ORunFF8vtfZtfY+4VUAGgP6mWhQPzFON5
         rpz0riwgXjTGxD08O/ZK2PBKkAsfjxOyi5L9ecS62DG1gdR6gnL27JODgYSXBU6k++v3
         zTMV0++giulUsr+KsGLLc5UJP9LKRDWQxVW1DR9upJULSaqL2bpptKOQysOV0zU6rG73
         SlEYCu3bW8kQCdb6uTU5QQ47sJuMYHhC4CrvYfRaC6t7PDK0cYWkrD8tObzL6bNK8+g1
         2RrIoRR/RQmD/BzuT+Wu3Tr0keA8H9h+DAH3jVaOmhjsLzA3jcR0a1B+QKmYFT/6/5Ai
         +NMQ==
X-Gm-Message-State: ACgBeo2Zv2axIjJfa0lN7QT0qMSAFVPRVNXk3nbu9eFmTdVaXqf96rKa
        3kaRyvsEmT6eySBCzVTWiV2Xj8ujLn7Ff0Xfsensb39BYpoa5B+dMTXQJBahH5gqrxlVwqZsp9S
        jst4NdJXnkDlyzMcS/60=
X-Received: by 2002:a17:906:fc6:b0:72f:d080:416 with SMTP id c6-20020a1709060fc600b0072fd0800416mr12453621ejk.1.1661168362463;
        Mon, 22 Aug 2022 04:39:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7EslOwiB8PFirhCnGpfUKcQPO9I3vNXx6R3lb7mRftIJYrbqJm5XJ7V+bp4oyG6JqO2ADh4g==
X-Received: by 2002:a17:906:fc6:b0:72f:d080:416 with SMTP id c6-20020a1709060fc600b0072fd0800416mr12453594ejk.1.1661168361905;
        Mon, 22 Aug 2022 04:39:21 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id h23-20020a50ed97000000b00445b5874249sm8030356edr.62.2022.08.22.04.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 04:39:21 -0700 (PDT)
Message-ID: <2ddade8b-7260-8497-12f2-c8b13cf35e6a@redhat.com>
Date:   Mon, 22 Aug 2022 13:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] [RFC] platform/x86: Fixes for Toshiba Z830
Content-Language: en-US
To:     Arvid Norlander <lkml@vorpal.se>,
        platform-driver-x86@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Cc:     Azael Avalos <coproscefalo@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20220821200821.1837460-1-lkml@vorpal.se>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220821200821.1837460-1-lkml@vorpal.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Arvid,

Nice to meet you.

On 8/21/22 22:08, Arvid Norlander wrote:
> Hi,
> 
> NOTE: I had some trouble sending this with git send-email, I only managed
> to send one copy successfully! Sorry if I managed to send it multiple
> times.
> 
> I'm new to this kernel development thing, so applogies in advance for any
> mistakes.

No worries, I think you are doing great so far.

Thank you for the detailed analysis and for all the work you are putting
into this.

> I have an old Toshiba Z830-10W laptop. Unfortunately it doesn't
> work well under Linux. Fortunately I spent some time figuring out what was
> wrong. I had documented my findings below. I have also included patches
> (see the next few emails) for some of the issues.
> 
> I would like advice on how to proceed for some of the more advanced
> problems though:
> * Do we want to expose all these features that I figured out? For example,
>   how to set the boot order on this old BIOS-only laptop from user space.
>   Or various other settings accessible via the BIOS.

I'll try to write a short reply to each feature separately,
I think we need to balance the worth of a feature to end users vs the amount
of code to write + maintain here. E.g. adding support for non working
hw buttons is generally considered worth the effort. Adding support for
changing the boot-order not so much.

Note there is a generic interface for changing BIOS options from
within Linux, so if you can change all (or almost all) BIOS options,
you could consider implementing support for:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-class-firmware-attributes

That has been implemented for Lenovo Think* and for some Dell
models, but by the vendors themselves and the used WMI APIs are
actually guaranteed to work on multiple models / generations hardware
making it worth the effort. Also this is something which their
customers want for managed rollout of these devices in big
companies.

IMHO for these Toshiba laptops I still think it is a lot of work
for something which won't see much use.

It would be good though to:
1. Write some generic documentation from an end user pov for toshiba_acpi as:
Documentation/admin-guide/laptops/toshiba_acpi.rst
see:
Documentation/admin-guide/laptops/thinkpad-acpi.rst
as an example

2. Extend the doc from 1. with toshiba_acpi firmware API documentation,
including your findings on protocol bits which we won't directly
implement/use so that this is at least written down in case it is
needed later.

For 2. you can actually just copy and paste a lot of this email,
I believe that having the info in this email in a
Documentation/admin-guide/laptops/toshiba_acpi.rst file
will make it a lot easier to find in the future then only having
it in the mailinglist archives.

> * For the hardware buttons I describe below, is a solution specific to
>   toshiba_acpi preferred, or should additional effort be spent on
>   investigating a generic solution?

Ok, this is interesting there actually is a specification from
Microsoft for this:
http://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/dirapplaunch.docx

And there was a previous attempt to add support for the PNP0C32 devices:
https://marc.info/?l=linux-acpi&m=120550727131007
https://lkml.org/lkml/2010/5/28/327

And this even made it into drivers/staging for a while, if you do:
git revert 0be013e3dc2ee79ffab8a438bbb4e216837e3d52
you will get a: drivers/staging/quickstart/quickstart.c file.

Note this is not great code:

1. If you do:
  ls /sys/bus/platform/devices
  You should already see a couple of PNP0C32 platform devices there and the
  driver should simply bind to those rather then creating its own platform device
2. As mentioned this really should use the standard /dev/input/event interface
  for event reporting and allow userspace to change the scancode to EV_KEY*
  mapping. You can do this e.g. by using a sparse_keymap for the scancode to
  EV_KEY* mapping which will give you this for free.

> Before I start coding on these more complex issues I would like advice in
> order to avoid wasting my time on bad designs. In particular, on how to
> proceed with the "Hardware buttons" section below.

I believe that sending the magic command to make these keys generate events
should be part of toshiba_acpi, combined with a generic PNP0C32 driver
for actually reporting the key-presses.



> 
> Best regards,
> Arvid Norlander
> 
> Table of contents
> =================
> 1. Short info on the laptop and methodology
> 2. Background on Toshiba ACPI communication methods
> 3. LED: "Eco" LED ................................ [implemented in patch 1]
> 4. Battery charge mode ........................... [implemented in patch 2]
> 5. Hardware buttons ...................................... [Advice wanted!]
> 6. Panel power control via HCI
> 7. BIOS setting control from the OS ................... [should we bother?]
>    7.1 Setting boot order
>    7.2 Setting USB memory emulation
>    7.3 Display during boot
>    7.4 CPU control
>    7.5 Wake on LAN
>    7.6 SATA power control
>    7.8 Legacy USB
>    7.9 Wake on keyboard
> 8. Other features .... [nothing actionable as of now, for information only]
> 
> 
> 1. Short info on the laptop and methodology
> ===========================================
> 
> The Toshiba Z830-10W laptop is a so-called "Ultrabook" dating from 2011.
> It has BIOS, not UEFI.
> 
> The Toshiba Z830-10W laptop has several features that don't work properly
> under Linux. I have performed reverse engineering by tracing ACPI calls
> with WinDbg using the "AMLI" feature while performing various actions to
> determine what the Windows drivers do. My user space tracing on Windows
> has been limited to determine which programs interact with the driver so
> that I could kill those that I was not testing behaviour of at the moment.
> 
> I have then tested these features using the "acpi_call" kernel module on
> Linux to issue the relevant calls under Linux. In the following sections
> is a feature by feature breakdown.
> 
> 
> 2. Background on Toshiba ACPI communication methods
> ===================================================
> 
> This is a short summary of the general protocol. This is already
> implemented in the toshiba_acpi driver. If you are already familiar with
> that you can skip this section.
> 
> Almost all vendor specific features work via the \_SB_.VALZ ACPI device
> defined in the DSDT. There are a handful of interesting methods on this
> object, but for the purposes of this write-up only "GHCI" is relevant. This
> method takes 6 integer (32-bit) arguments and returns a buffer 6 32-bit
> integers.
> 
> The general format of queries is: {OPERATION, REGISTER, ARG1, ..., ARG4 }.
> The operation is one of HCI_GET/HCI_SET or SCI_GET/SCI_SET (plus SCI_OPEN
> and  SCI_CLOSE). This allows for getting and setting various registers to
> control features or read out data.
> 
> The data returned varies a bit, but is /generally/ on the form:
> {STATUS_CODE, REGISTER_FROM_QUERY, VAL1, ..., VAL4 }
> 
> What is the difference between HCI_* and SCI_* calls? The only important
> difference here is that for SCI_GET/SET you first need to call SCI_OPEN and
> then follow the get or set with an SCI_CLOSE call.
> 
> Much of the rest of this write-up consists of documenting registers
> previously not handled by the toshiba_acpi Linux driver.
> 
> 
> 3. LED: "Eco" LED [implemented in patch 1]
> =================
> 
> The toshiba_acpi driver has support for controlling some LEDs including the
> "Eco" LED. Unfortunately that LED works differently on this laptop.
> 
> The toshiba_acpi driver checks for TOS_INPUT_DATA_ERROR and tries a
> different format. On the Z830 the error returned is TOS_NOT_SUPPORTED
> though the different format still works.

This looks good I'll go and merge it into my for-next git branch
sometime this week (I usually merge patches in batches).

> 4. Battery charge mode [implemented in patch 2]
> ======================
> 
> This laptop supports not charging the battery fully in order to prolong
> battery life. Unlike for example ThinkPads where this control is granular
> here it is just off/on. When off it charges to 100%. When on it charges to
> about 80%.
> 
> According to the Windows program used to control the feature the setting
> will not take effect until the battery has been discharged to around 50%.
> However, in my testing it takes effect as soon as the charge drops below
> 80%. On Windows Toshiba branded this feature as "Eco charging"
> 
> In the following example ACPI calls I will use the following newly defined
> constants:
> #define HCI_BATTERY_CHARGE_MODE 0xba
> #define BATTERY_CHARGE_FULL 0
> #define BATTERY_CHARGE_80_PERCENT 1
> 
> To set the feature:
>   {HCI_SET, HCI_BATTERY_CHARGE_MODE, charge_mode, 0, 0, 0}
> To query for the existence of the feature:
>   {HCI_GET, HCI_BATTERY_CHARGE_MODE, 0, 0, 0, 0}
> To read the feature:
>   {HCI_GET, HCI_BATTERY_CHARGE_MODE, 0, 0, 0, 1}
> 
> The read may need to be retried if TOS_DATA_NOT_AVAILABLE is returned as
> the status code. This rarely happens (I have never observed it on Linux),
> but I have seen it happen under Windows once, and the software did retry
> it.

Hmm, this is interesting if you look at:

Documentation/ABI/testing/sysfs-class-power

You will see there already is a standard API for this in the form of
adding a "charge_control_end_threshold" attribute to the standard
ACPI /sys/class/power_supply/BAT*/ sysfs interface. See e.g.
drivers/platform/x86/thinkpad_acpi.c

For an example of how to add sysfs attributes to a battery
which is managed by the standard drivers/acpi/battery.c driver.

I think you can use this standard attribute enabling eco charging
for any writes with a value <= 90 and disabling it for values
> 90 (90 being halfway between 80 and 100).

While always showing 80 or 100 on read.

You should then also write a patch for:

Documentation/ABI/testing/sysfs-class-power

Adding something like this to the "charge_control_end_threshold"
section:

"not all hardware is capable of setting this to an arbitrary
percentage. Drivers will round written values to the nearest
supported value. Reading back the value will show the actual
threshold set by the driver."

(feel free to copy verbatim, but maybe you can do better)


> 5. Hardware buttons [Advice wanted!]
> ===================
> 
> All the Fn+<key> hotkeys work. However, there are some hardware buttons
> that do not. These buttons are:
> 
> * A button between space and the touchpad to turn off/on the touchpad.
> * Two buttons next to the power button, one is "eco-mode", the other is
> "projector".
> 
> The two buttons next to the power button both send Windows+X by default.
> The touchpad control button does nothing that Linux can detect.
> 
> To enable this functionality several changes are needed.
> 
> The toshiba_acpi driver currently uses
>   {HCI_SET, HCI_HOTKEY_EVENT, HCI_HOTKEY_ENABLE, 0, ...}
> to enable the Fn+<key> hotkeys, where HCI_HOTKEY_ENABLE = 0x09. However on
> this laptop the value 0x05 must be used instead.
> 
> This is not the whole story however, as these keys do not work like any of
> the Fn-hotkeys (ACPI notification on \_SB_.VALZ). Instead, once enabled via
> the above method they start sending notifications on various PNP0C32
> devices. These are currently not handled by Linux. According to a search
> PNP0C32 is "HIDACPI Button Device", so perhaps a generic driver should be
> created.
> 
> The devices in question are:
> PNP0C32 \_SB_.HS81 UID 0x03 = Enable/disable trackpad
> PNP0C32 \_SB_.HS87 UID 0x01 = Eco button
> PNP0C32 \_SB_.HS86 UID 0x02 = Monitor/projector button
> 
> Only the "path" and the "UID" value in the ACPI DSDT tell these devices
> apart.
> 
> The notification always uses the value 0x80.
> 
> I'm not sure what the best approach to implement support for these would
> be.

Discussed above.

> 6. Panel power control via HCI
> ==============================
> 
> The toshiba_acpi driver supports controlling the panel power via SCI calls
> (SCI_PANEL_POWER_ON). Based on the fact that the toshiba_acpi driver
> outputs a message about reboot being needed I assume this is related to
> panel power during boot?
> 
> However there is a HCI call that can turn the panel off or on immediately:
> 
> #define HCI_PANEL_POWER_ON 0x2
> #define PANEL_ON 1
> #define PANEL_OFF 0
> 
> To read/query existence: {HCI_GET, HCI_PANEL_POWER_ON, 0, 0, 0, 0}
> To write: {HCI_SET, HCI_PANEL_POWER_ON, panel_on, 0, 0, 0}
> 
> This could be related to some backlight issues this laptop is having where
> backlight control stops working after a suspend/resume.
> 
> Control via /sys/class/backlight/intel_backlight always works on this
> laptop, however, most desktop environment seems to prefer the acpi_video or
> vendor backlight controls if those exist.
> 
> I have tried acpi_backlight=vendor/native but that is broken in the same
> way. With acpi_backlight=none, the screen never turns on after a resume.
> However if I turn it on using the above HCI call, everything works
> normally after that. And since only the intel_backlight driver is left,
> the desktop environment controls backlight via that method.
>   
> I have yet to find a satisfactory solution to this problem, but I suspect
> the correct solution would be to fix backlight control from acpi_video,
> if that is possible. Suggestions?

I think this is another case of some Toshiba devices needing the
acpi_video backlight level save/restore behavior over suspend/resume
while leaving the actual backlight control to intel_backlight.

Quoting from: drivers/acpi/acpi_video.c :

         * Some machines have a broken acpi-video interface for brightness
         * control, but still need an acpi_video_device_lcd_set_level() call
         * on resume to turn the backlight power on.  We Enable backlight
         * control on these systems, but do not register a backlight sysfs
         * as brightness control does not work.
         */
        {
         /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
         .callback = video_disable_backlight_sysfs_if,
         .ident = "Toshiba Portege R700",
         .matches = {
                DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
                DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
                },
        },

Also:
Toshiba Portege R830:    https://bugs.freedesktop.org/show_bug.cgi?id=82634
Toshiba Satellite R830:  https://bugzilla.kernel.org/show_bug.cgi?id=21012

You can see if the same option fixes things for you by adding:
"video.disable_backlight_sysfs_if=1" to your kernel commandline while
removing all other options. If this works, please submit a patch to
add your model to the list in drivers/acpi/acpi_video.c, or provide
dmidecode output, then I can do it for you.

> 7. BIOS setting control from the OS [should we bother?]
> ===================================
> Several of the BIOS settings can be controlled from the OS. This all
> happens via SCI calls. On Windows the "Hwsetup.exe" program offers this
> control. I'm not sure how useful any of this is (as this is already
> available via the BIOS).
> 
> If you think it is a good idea I could absolutely implement support for
> this. Otherwise I might build a simple user space tool on top of acpi_call
> for this. 

As discussed above I don't really think we should bother; and IMHO
certainly not something worth spending time on before the other issues
are wrapped up.

> 7.1 Setting boot order
> ----------------------
> This is a BIOS (not UEFI) laptop, so boot order could normally not be
> controlled from the OS. However here it is possible:
> 
> #define SCI_BOOT_ORDER 0x157
> 
> In this SCI register the boot order is stored as a list with each nibble
> indicating a device:
> #define SCI_BOOT_ORDER_FDD 0x0
> #define SCI_BOOT_ORDER_HDD 0x1
> #define SCI_BOOT_ORDER_LAN 0x3
> #define SCI_BOOT_ORDER_USB_MEMORY 0x4
> #define SCI_BOOT_ORDER_USB_CD 0x7
> #define SCI_BOOT_ORDER_USB_UNUSED 0xf
> 
> These are then combined as follows:
> 
> Set boot order to USB memory, USB CD, HDD, LAN, FDD:
> {SCI_SET, SCI_BOOT_ORDER, 0xfff03174, 0, 0, 0}
> 
> Each nibble indicates a device, with the lowest nibble being the first
> device in the boot order. As this device doesn't have a physical FDD I
> assume that this refers to USB attached devices, but I have not tested this
> (I do have a USB floppy drive if anyone really cares).
> 
> When reading the data out the result is a bit surprising:
>   {0x0, 0x8505, 0xfff30174, 0x5, 0xfff30741, 0x0}
> Presumably these other values also mean something, the boot order in this
> case is USB memory, USB CD, HDD, FDD, LAN, so the third value is the boot
> order.
> 
> I'm not sure what a suitable API for exposing this setting to userspace via
> sysfs would be.
> 
> 7.2 Setting USB memory emulation
> --------------------------------
> The BIOS can either treat USB drives as HDDs or FDDs for booting purposes:
> 
> #define SCI_BOOT_FLOPPY_EMULATION 0x511
> #define SCI_BOOT_FLOPPY_EMULATION_FDD 0x1
> #define SCI_BOOT_FLOPPY_EMULATION_HDD 0x0
> 
> To set: {SCI_SET, SCI_BOOT_FLOPPY_EMULATION, value, 0, 0, 0}
> Getting/existence query: {SCI_GET, SCI_BOOT_FLOPPY_EMULATION, 0, 0, 0, 0}
> 
> 7.3 Display during boot
> -----------------------
> This controls if BIOS/GRUB/etc is shown on just the internal monitor or
> if the montior is automatically selected.
> 
> Note: When changing this in Windows it tells me a restart is required.
> 
> #define SCI_BOOT_DISPLAY 0x300
> #define SCI_BOOT_DISPLAY_INTERNAL 0x1250
> #define SCI_BOOT_DISPLAY_AUTO 0x3250
> 
> To set: {SCI_SET, SCI_BOOT_DISPLAY, value, 0, 0, 0}
> Getting/existence query as usual.
> 
> Note! I have not tested the effects of this, as the only external monitors
> I have that are not in storage use DisplayPort, while this laptop has HDMI
> and VGA. I *do* have an old VGA TFT in storage if anyone cares though...
> 
> 7.4 CPU control
> ---------------
> I presume this is only for operating systems that don't manage this
> themselves, I don't know for sure. The wording in the documentation is
> vague, but I believe it controls CPU frequency behaviour.
> 
> Note: When changing this in Windows it tells me a restart is required.
> 
> #define SCI_CPU_FREQUENCY 0x132
> #define SCI_CPU_FREQUENCY_DYNAMIC 0x0
> #define SCI_CPU_FREQUENCY_HIGH 0x1
> #define SCI_CPU_FREQUENCY_LOW 0x2
> 
> Set and get as usual ({SCI_GET/SET, SCI_CPU_FREQUENCY, value, 0, 0, 0}).
> 
> 7.5 Wake on LAN
> ---------------
> Note! This only controls Wake on LAN when off/hibernated (and since this
> laptop has Intel Rapid Start, presumably in that mode too). It is not
> relevant to WoL when in sleep.
> 
> Here the Windows driver seem to query several possibilities until it hits
> on one that works:
> #define SCI_WAKE_ON_LAN 0x700
> 
> #define SCI_WAKE_ON_LAN_OFF 0x1
> #define SCI_WAKE_ON_LAN_ON 0x1
> 
> #define SCI_WAKE_ON_LAN_REG1 0x0
> #define SCI_WAKE_ON_LAN_REG2 0x1000
> #define SCI_WAKE_ON_LAN_REG3 0x800
> 
> To set:
>   {SCI_SET, SCI_WAKE_ON_LAN, value | register, 0, 0, 0}
> To get/query:
>   {SCI_GET, SCI_WAKE_ON_LAN, register, 0, 0, 0}
> 
> For example on this specific laptop to enable WoL:
>   {SCI_SET, SCI_WAKE_ON_LAN, SCI_WAKE_ON_LAN_ON | SCI_WAKE_ON_LAN_REG3, 0, 0, 0}
> 
> REG1 and REG2 give return code TOS_INPUT_DATA_ERROR on this laptop, but
> presumably they are needed on some laptops, or the Windows program would
> not be attempting to use them.
> 
> 7.6 SATA power control
> ----------------------
> This is another one that I don't know what exactly it corresponds to, maybe
> it is something Linux can control directly:
> 
> #define SCI_SATA_POWER 0x406
> #define SCI_SATA_POWER_BATTERY_LIFE 0x1
> #define SCI_SATA_POWER_PERFORMANCE 0x0
> 
> Get/set/query as expected: {SCI_SET, SCI_SATA_POWER, value, 0, 0, 0}
> 
> 7.8 Legacy USB
> --------------
> Controls Legacy USB support in BIOS.
> 
> Note: When changing this in Windows it tells me a restart is required.
> 
> #define SCI_LEGACY_USB 0x50c
> #define SCI_LEGACY_USB_ENABLED 0x1
> #define SCI_LEGACY_USB_DISABLED 0x0
> 
> 
> Get/set/query as expected: {SCI_SET, SCI_LEGACY_USB, value, 0, 0, 0}
> 
> 7.9 Wake on keyboard
> --------------------
> This controls if pressing a key on the keyboard wakes the laptop from
> sleep. Otherwise, only opening the monitor or pressing the power button
> works for this.
> 
> #define SCI_WAKE_ON_KEYBOARD 0x137
> #define SCI_WAKE_ON_KEYBOARD_ENABLE 0x8
> #define SCI_WAKE_ON_KEYBOARD_DISABLE 0x0
> 
> Set: {SCI_SET, SCI_WAKE_ON_KEYBOARD, value, 0, 0, 0}
> 
> Get/query on the standard form but with slightly weird return values:
>   {TOS_SUCCESS2, 0x800a, value, 0x38, 0x0, 0x0}
> 
> 
> 8. Other features
> =================
> 
> I should note that I did discover some additional registers, but I don't
> fully understand them yet. I have thus not included them here in order to
> not waste your time. However I did write a blog post about this which
> includes that information, which is available should you be interested:
> 
> https://vorpal.se/posts/2022/aug/21/reverse-engineering-acpi-functionality-on-a-toshiba-z830-ultrabook/#other-features_1
> 
> 
> Arvid Norlander (2):
>   platform/x86: Fix ECO LED control on Toshiba Z830
>   platform/x86: Battery charge mode in toshiba_acpi
> 
>  drivers/platform/x86/toshiba_acpi.c | 115 +++++++++++++++++++++++++++-
>  1 file changed, 114 insertions(+), 1 deletion(-)
> 
> 
> base-commit: e3f259d33c0ebae1b6e4922c7cdb50e864c81928


Regards,

Hans

