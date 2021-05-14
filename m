Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8982638139E
	for <lists+linux-pm@lfdr.de>; Sat, 15 May 2021 00:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhENWNr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 May 2021 18:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhENWNr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 May 2021 18:13:47 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7A6C06174A
        for <linux-pm@vger.kernel.org>; Fri, 14 May 2021 15:12:35 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id t11so264022iol.9
        for <linux-pm@vger.kernel.org>; Fri, 14 May 2021 15:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZMndnk0T1uTjKIdZ8gA20TvCc8i9uHipdNCN8I7bSE=;
        b=VUmg4Ex+eKEwF5VKUcH/ujoG6JcjCuJ0zGB5+OIXqcHbLmCt0eCgACXtirFrtF8W41
         qbKpF/7sXH0hzK6mjMTeISJ6NNh57jahyLXdAUpM8MLM2I4W44QYA5kWXJcC39l4tL3X
         v1Bk3CLdvdFCcjWgVVN+hvnmSj2qBfdAz/hxZF01gXF5JMrVKx10WuWWACY05i6YiGT9
         vFA61sAQeWOOSn+18nhmNiKQF2eLf0F2x7WvrdSpvuls4rT0CymJdC8+ST/+aRCv7Uwx
         xVr5kafehUxaVZpIT09Mf61JV5VuPG4hDNKQO2+QuW+Tqrx7lU8wga6s/jGB4GdekPde
         10Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZMndnk0T1uTjKIdZ8gA20TvCc8i9uHipdNCN8I7bSE=;
        b=ZcrT92J/2ARqhdVO8F1/2k4yBtmdHOvZzQ0WHeFVzgX8gYH+qGWB48znRwlr74+8Qx
         D9VH6J1MSdUEQiKJHUkwVMQfiT7IdePIJk3WQom5h/dEGLF9JFvSOulU/4LEDZkSIguo
         wApNyRXhEua7RH+5oRSBLIbqbL275wqgiUyVsOnAyp6dFfJ9b9JYYmDD0xCbO5hv+zZf
         RS+5zxTtVsvo1naFixmVde7fBw5M8IBT+lT7u9B7nCNk38KHD4RzW3ET3MLoltA0HRWU
         tGLKcDnd+Slu8f8mLSD+5mMixBYCrBZzBbEEqJpnOjW5a4tv6p+WGR+dwkrROoghAfrz
         RF9w==
X-Gm-Message-State: AOAM532BPh7ILaTkKLZWWA3QFzlGNYRW27cK240Xp/ZYtnbYZ2kTZCCB
        guiOLPQ0VPB0xarQtMyQZVH0eoWAWUTvWhf3tliMjLPoNKomsVZ/
X-Google-Smtp-Source: ABdhPJxG4E9bc+8tnH9GPoUVS4PvC6gplyn4zWhN22jL6nWcJLIGUclw2CUF55y9tIEhlYc8yzN0dE55zeN0hmGvCqQ=
X-Received: by 2002:a05:6602:204f:: with SMTP id z15mr15400564iod.99.1621030355132;
 Fri, 14 May 2021 15:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com>
 <20210513132051.31465-1-ggherdovich@suse.cz> <CAAYoRsUcyFsFWDE=r+aMgDBa6hcgXgtE2jJ_NHas5e4TdgiBTg@mail.gmail.com>
 <067ee60e47a0350d01f0c3f216c1032818044b36.camel@suse.cz>
In-Reply-To: <067ee60e47a0350d01f0c3f216c1032818044b36.camel@suse.cz>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Fri, 14 May 2021 15:12:25 -0700
Message-ID: <CAAYoRsX0xJf1mm1a_YUCzDy86r8q4QE98iVtS1AMLaUx+KTgQQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Add Icelake servers support in
 no-HWP mode
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 14, 2021 at 1:33 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
> On Fri, 2021-05-14 at 08:31 -0700, Doug Smythies wrote:
>
> > Can I on-board to this patch or do you want me to submit another?
> > I want to add COMETLAKE (tested), as below:
> >
> > ... Doug
>
> Hello Doug!

Hi Giovanni,
Thank you for your reply.
>
> Wait, why you don't want to use HWP? It's such a fantastic technology!
>
> :) I'm just teasing you.
>
> More seriously:
>
> when COMETLAKE is not in that list, can you confirm that if you go into the
> BIOS config at boot, and disable HWP from there, then intel_pstate does *not* load?

Yes, already tested before my original reply.

> Does it say "intel_pstate: CPU model not supported" in the dmesg log?

That I did not check, but if I boot now with an unmodified kernel
5.13-rc1 (i.e. without this patch):

[    0.369323] intel_pstate: CPU model not supported

> The control may be somewhere around "power mangement" in the BIOS config, and
> may be called "Enable/disable Intel Speed Shift".

Yes.

> I'm asking because I've just checked on two Dell laptops, one Skylake and the
> other Kabylake, and the menu is there in the BIOS config to disable HWP,
> but if I disable it... nothing happens. "lscpu" shows all the hwp flags as usual:

Motherboard here is ASUS PRIME Z490-A.
CPU: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz

>     # lscpu | grep Flags | tr ' ' '\n' | grep hwp
>     hwp
>     hwp_notify
>     hwp_act_window
>     hwp_epp

Here, for some reason I have to do it this way (sudo) or your command
doesn't work properly. Results herein confirmed by looking at the
"Flags" output manually without filtering:

intel_speed_shift = Disabled in BIOS:

doug@s19:~$ sudo lscpu | tr ' ' '\n' | grep hwp
doug@s19:~$

intel_speed_shift = Auto in BIOS

$ sudo lscpu | tr ' ' '\n' | grep hwp
hwp
hwp_notify
hwp_act_window
hwp_epp

> and turbostat gives me:
>
>     # turbostat -Summary -i 1 : 2>&1 | grep MSR_PM_ENABLE
>     cpu0: MSR_PM_ENABLE: 0x00000001 (HWP)

Here:

intel_speed_shift = Disabled in BIOS:

root@s19:/home/doug#
/home/doug/temp-k-git/linux/tools/power/x86/turbostat/turbostat
-Summary -i 1 : 2>&1 | grep MSR_PM_ENABLE
root@s19:/home/doug#

intel_speed_shift = Auto in BIOS (the default setting)

root@s19:/home/doug#
/home/doug/temp-k-git/linux/tools/power/x86/turbostat/turbostat
-Summary -i 1 : 2>&1 | grep MSR_PM_ENABLE
cpu0: MSR_PM_ENABLE: 0x00000001 (HWP)

or with "intel_pstate=no_hwp"

root@s19:/home/doug#
/home/doug/temp-k-git/linux/tools/power/x86/turbostat/turbostat
-Summary -i 1 : 2>&1 | grep MSR_PM_ENABLE
cpu0: MSR_PM_ENABLE: 0x00000000 (No-HWP)

> Which is to say, on the Intel client machines I have, the firmware doesn't
> seem to be able to hide HWP from the OS. Buggy BIOS? Maybe, the fact of the
> matter is, I wouldn't need to add, say, KABYLAKE to that list, based on my
> experience.

My experience (hardware) differs from yours with respect to this.

> The other side of the issue is that, from my understanding, the
> preferred/supported way to disable HWP is to boot with intel_pstate=no_hwp,
> and that list is a sort of "known exceptions" that people really can't live
> without (it's mostly server CPUs, and mostly because of unfortunate firmware
> defaults). Otherwise you'd see the entire intel-family.h file in there.

I'm not sure how to respond here. Yes, I'd expect to see a big list
here, and in the recently added TCC Offset thermal stuff and in the
recently added turbostat patches to deal with a TCC offset. I do not
understand doing things partially only. But that is a bigger/broader
subject than herein.

That said, yes, "intel_pstate=no_hwp" is what I normally do. And my
BIOS normally has "Intel Speed Shift = AUTO", which is the default.

... deleted the rest ...

... Doug
