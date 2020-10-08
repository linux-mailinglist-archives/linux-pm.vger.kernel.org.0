Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DAA287A38
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 18:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgJHQmE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 12:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgJHQmE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 12:42:04 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615E1C0613D2
        for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2020 09:42:04 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id w25so3389694vsk.9
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2020 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BXYCRPdwwjw5+VNxRy5P5amHnYR+JOarFfXCXf3ZLpg=;
        b=TZ7MWLebOTz3kwvrBEUeoSXXXod8vpl13gzzpRz39XaxB3fxdqucLF5raubPC1guCk
         0fLXPJXRPYSixyiEOWdbso3K2oY5R9x8n0ktZ8FX7ZUhPoDiwD+pKEMOAR3cqqG4Y4q0
         0sRdov3++8tm+B9lOGzY5nDNuUY31NZFrrvQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXYCRPdwwjw5+VNxRy5P5amHnYR+JOarFfXCXf3ZLpg=;
        b=gv4hIqUsVhK/3aZ1ZZe2jV4gL/fBeJ9GTsrm2WiV2DwbCn20Tyt5QmtGdvo5YB+3fj
         3Sl7w8oJdY7ObVfp0jlDcCbyrCNVW3CdBOZ7HxAdErlrI3yxiYFG3kyi2SDroCMb3x0a
         MjHHNSs9b2gC1MJQTU2Bgmghj88A9rd0jyjBmnvgyIzaOs5hpxgTITFE2fzdI9lWLw6k
         Qw6BznObS8tBilHaR8kvzHWXysVS8oPq5qyFq3xxqWKwtRLTXvwQH1GW4DwPZvNgPGGu
         TG2fUyJSrSoRwej22Ceb3qu2u7dsWzVbZ/9HD3tLUjOYrVIHZy7uFEgpYLTAva0DUzNS
         rXFA==
X-Gm-Message-State: AOAM531+eJ2yjDyYr2aomEbNh5Kg3RdJRmSCdsahY9v+HgmDTc7Awf7O
        ZSotqSzD+MoBNnZfFhooPgpHwoQm2jXGPQ==
X-Google-Smtp-Source: ABdhPJwzACPEDKJux0VBwZWEdave++DHdyplGVtwL3HBQRTwxHXmE+WLtDZqIXf2GcGzx6/tB3Dwbg==
X-Received: by 2002:a67:6b84:: with SMTP id g126mr5040089vsc.35.1602175322798;
        Thu, 08 Oct 2020 09:42:02 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id p130sm766983vke.14.2020.10.08.09.42.01
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 09:42:01 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id w25so3389637vsk.9
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2020 09:42:01 -0700 (PDT)
X-Received: by 2002:a67:e3b9:: with SMTP id j25mr5335450vsm.37.1602175320772;
 Thu, 08 Oct 2020 09:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201002114426.31277-1-lukasz.luba@arm.com> <20201002114426.31277-4-lukasz.luba@arm.com>
 <CAD=FV=UbNP5-G1z95F37Fmv8=n0JPSSwnPQO_K==WpAc4vAHWQ@mail.gmail.com>
 <e9b6fc5a-45d3-168d-db38-6c068da26f6b@arm.com> <CAD=FV=Xkg1zpsMW5rERbibnjrgY6opZi8Z9DUFkWebb7NHtU5w@mail.gmail.com>
 <bc5d21c1-ea84-9132-2e52-ae84fbb0515a@arm.com> <CAD=FV=VfA8AB3BZk8Ykkhigv9eGijzu4zuA6KdXk0K5UG0yCCQ@mail.gmail.com>
 <CAL_JsqJ37TVk4=E1DyZuhfH1jZ7wyauGLucSH7XW9wkeT3PSgg@mail.gmail.com>
 <CAD=FV=Vy641h5KNLKipC1n=tgjp7a3HGHw0odY9fNpwdqorrAg@mail.gmail.com>
 <CAL_JsqJ=brfbLiTm9D+p2N0Az-gcStbYj=RS2EaG50dHo0-5WA@mail.gmail.com> <CAD=FV=XF_kqr0=vBqHVT4RWB8NWx0kHoFnap-smxtv_m+GQvSg@mail.gmail.com>
In-Reply-To: <CAD=FV=XF_kqr0=vBqHVT4RWB8NWx0kHoFnap-smxtv_m+GQvSg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 8 Oct 2020 09:41:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U1FP0e3_AVHpauUUZtD-5X3XCwh5aT9fH_8S_FFML2Uw@mail.gmail.com>
Message-ID: <CAD=FV=U1FP0e3_AVHpauUUZtD-5X3XCwh5aT9fH_8S_FFML2Uw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: thermal: update sustainable-power
 with abstract scale
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar.Eggemann@arm.com, Quentin Perret <qperret@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, Oct 7, 2020 at 2:40 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Oct 7, 2020 at 6:26 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Tue, Oct 6, 2020 at 8:17 PM Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Oct 6, 2020 at 3:24 PM Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > On Fri, Oct 2, 2020 at 12:39 PM Doug Anderson <dianders@chromium.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Fri, Oct 2, 2020 at 9:40 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> > > > > >
> > > > > > On 10/2/20 4:47 PM, Doug Anderson wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Fri, Oct 2, 2020 at 8:13 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> > > > > > >>
> > > > > > >> Hi Doug,
> > > > > > >>
> > > > > > >> On 10/2/20 3:31 PM, Doug Anderson wrote:
> > > > > > >>> Hi,
> > > > > > >>>
> > > > > > >>> On Fri, Oct 2, 2020 at 4:45 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> > > > > > >>>>
> > > > > > >>>> Update the documentation for the binding 'sustainable-power' and allow
> > > > > > >>>> to provide values in an abstract scale. It is required when the cooling
> > > > > > >>>> devices use an abstract scale for their power values.
> > > > > > >>>>
> > > > > > >>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > > > > > >>>> ---
> > > > > > >>>>    .../devicetree/bindings/thermal/thermal-zones.yaml  | 13 +++++++++----
> > > > > > >>>>    1 file changed, 9 insertions(+), 4 deletions(-)
> > > > > > >>>>
> > > > > > >>>> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > > > > > >>>> index 3ec9cc87ec50..4d8f2e37d1e6 100644
> > > > > > >>>> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > > > > > >>>> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > > > > > >>>> @@ -99,10 +99,15 @@ patternProperties:
> > > > > > >>>>          sustainable-power:
> > > > > > >>>>            $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > >>>>            description:
> > > > > > >>>> -          An estimate of the sustainable power (in mW) that this thermal zone
> > > > > > >>>> -          can dissipate at the desired control temperature. For reference, the
> > > > > > >>>> -          sustainable power of a 4-inch phone is typically 2000mW, while on a
> > > > > > >>>> -          10-inch tablet is around 4500mW.
> > > > > > >>>> +          An estimate of the sustainable power (in mW or in an abstract scale)
> > > > > > >>>> +         that this thermal zone can dissipate at the desired control
> > > > > > >>>> +         temperature. For reference, the sustainable power of a 4-inch phone
> > > > > > >>>> +         is typically 2000mW, while on a 10-inch tablet is around 4500mW.
> > > > > > >>>> +
> > > > > > >>>> +         It is possible to express the sustainable power in an abstract
> > > > > > >>>> +         scale. This is the case when the related cooling devices use also
> > > > > > >>>> +         abstract scale to express their power usage. The scale must be
> > > > > > >>>> +         consistent.
> > > > > > >>>
> > > > > > >>> Two thoughts:
> > > > > > >>>
> > > > > > >>> 1. If we're going to allow "sustainable-power" to be in abstract
> > > > > > >>> scale, why not allow "dynamic-power-coefficient" to be in abstract
> > > > > > >>> scale too?  I assume that the whole reason against that originally was
> > > > > > >>> the idea of device tree purity, but if we're allowing the abstract
> > > > > > >>> scale here then there seems no reason not to allow it for
> > > > > > >>> "dynamic-power-coefficient".
> > > > > > >>
> > > > > > >> With this binding it's a bit more tricky.
> > > > > > >> I also have to discuss a few things internally. This requirement of
> > > > > > >> uW/MHz/V^2 makes the code easier also for potential drivers
> > > > > > >> like GPU (which are going to register the devfreq cooling with EM).
> > > > > > >>
> > > > > > >> Let me think about it, but for now I would just update these bits.
> > > > > > >> These are required to proper IPA operation, the dyn.-pow.-coef. is a
> > > > > > >> nice to have and possible next step.
> > > > > > >
> > > > > > > I guess the problem is that Rajendra is currently planning to remove
> > > > > > > all the "dynamic-power-coefficient" values from device tree right now
> > > > > > > and move them to the source code because the numbers we currently have
> > > > > > > in the device tree _are_ in abstract scale and thus violate the
> > > > > > > bindings.  Moving this to source code won't help us get to more real
> > > > > > > power numbers (since it'll still be abstract scale), it'll just be
> > > > > > > pure churn.  If we're OK with the abstract scale in general then we
> > > > > > > should allow it everywhere and not add churn for no reason.
> > > > > >
> > > > > > IIUC he is still going to use the Energy Model, but with different
> > > > > > registration function. We have such a driver: scmi-cpufreq.c, which
> > > > > > uses em_dev_register_perf_domain(). He can still use EM, EAS, IPA
> > > > > > not violating anything.
> > > > >
> > > > > Right.  He's going to take the exact same "abstract scale" numbers
> > > > > that he has today and take them out of device tree and put them in the
> > > > > cpufreq driver.  Doing so magically makes it so that he's not
> > > > > violating anything since "abstract scale" is not currently allowed in
> > > > > device tree but is allowed in the cpufreq driver.  I'm not saying that
> > > > > he's doing anything wrong, I'm just saying that it's pointless churn.
> > > > > If we're OK with "abstract scale" in one place in the device tree we
> > > > > should be OK with it everywhere in the device tree.  Then Rajendra
> > > > > wouldn't need his patch at all and he could leave his numbers in the
> > > > > device tree.
> > > > >
> > > > >
> > > > > > The real problem that we want to address is with sustainable-power in
> > > > > > IPA. It is used in power budget calculation and if the devices operate
> > > > > > in abstract scale, then there is an issue.
> > > > > > There are two options to get that value:
> > > > > > 1. from DT, which can have optimized value, stored by OEM engineer
> > > > > > 2. from IPA estimation code, which just calculates it as a sum of
> > > > > > minimum OPP power for each cooling device.
> > > > > >
> > > > > > The 2nd option might not be the best for a platform, so vendor/OEM
> > > > > > engineer might want to provide a better value in DT -> 1st option.
> > > > > > This is currently against the binding description and I have to fix it.
> > > > >
> > > > > Right, things are already broken today because a SoC vendor could
> > > > > (without violating any rules) provide their SoC core
> > > > > "dynamic-power-coefficient" in "abstract scale" in code and there
> > > > > would be no way to for a board to (without violating DT bindings)
> > > > > specify a "sustainable-power".  ...so, in that sense, your patch does
> > > > > provide a benefit even if we don't make any changes to the rules for
> > > > > "sustainable-power".  All I'm saying is that if these new rules for
> > > > > allowing an abstract scale for "sustainable-power" in the device tree
> > > > > are OK that it should _also_ be OK to add new rules to allow an
> > > > > abstract scale for "dynamic-power-coefficient".
> > > >
> > > > Didn't we beat this one to death with "dynamic-power-coefficient"?
> > >
> > > We did?  Where / when?
> >
> > https://lore.kernel.org/r/1448288921-30307-1-git-send-email-juri.lelli@arm.com/
>
> Thanks for the reference.
>
>
> > > I'm not sure I was involved, but right now
> > > both "sustainable-power" and "dynamic-power-coefficient" are still
> > > defined in the device tree to be in real units, not abstract scale.
> > > Are you saying that we beat it to death and decided that it needed to
> > > be in real units, or we beat it to death and decided that abstract
> > > scale was OK and we just didn't put it in the bindings?
> >
> > The former.
>
> OK.  So I suppose this is a NAK to Lukasz's patch.  It also means that:
>
> * The power numbers that landed in the sc7180 devicetree violate
> what's documented in the bindings.
>
> * While Rajendra can fix this by moving the numbers out of devicetree
> and into code, it doesn't really help us because there will be no way
> to allow boards to specify their "sustainable-power" in code.
>
> * Anyone who is using the "abstract scale" provided by firmware or by
> code is in the same boat.  There's no way for a board to specify
> "sustainable-power" that will match this "abstract scale" without
> violating the devicetree bindings.
>
> Obviously the easiest way to fix this is to just move everyone off of
> "abstract scale".
>
> If someone else has other bright ideas I'm all ears.
>
>
> > > > That is the abstract scale because I don't think you can really ever
> > > > measure it
> > >
> > > That's debatable.  it's not very hard to get reasonable measurements.
> > > Matthias provided a recipe earlier in the thread.  See commit
> > > ac60c5e33df4 ("ARM: dts: rockchip: Add dynamic-power-coefficient for
> > > rk3288").  In that case he used a machine that could easily measure
> > > power on the CPU rail, but if you simply keep all other rails in the
> > > system constant (and/or run a long enough test), you can easily
> > > accomplish this by just querying the smart battery in systems.
> >
> > Okay, yes, you can measure and then calculate something. But the value
> > is only meaningful within that platform. There's no standardized test
> > to run. What the power rails are could be different (e.g. CPU RAMs on
> > a separate rail and shared).
>
> I think in this case the dynamic-power-coefficient is supposed to
> describe the CPU cores only.  Presumably for a given SoC the cores
> will behave (to a rough approximation) the same from board to board?
>
>
> > > > and because vendors don't want to advertise their absolute
> > > > power.
> > >
> > > That is certainly true, though after a device has shipped it's not
> > > that hard to measure.
> >
> > Can you tell me how to measure the CPU rail on my Pixel3?
>
> I've written a script to do this and I'll share it soon.
> Unfortunately the power consumption of little cores when running at
> very low frequencies is pretty miniscule and sbs_battery doesn't have
> that fine of a granularity.  I tried running where I spent 10 minutes
> at each frequency and it was still slightly too noisy.  I'll run it
> overnight where I spend 30 minutes at each frequency and see if my
> numbers are accurate / consistent.  Since I'm running on hardware that
> hasn't been released to the general public I won't publish my numbers,
> but I'm hoping my script will be good enough that you should be able
> to run it on your hardware and get real / consistent numbers.

OK, I finished writing my python script for this.  It's not massively
pretty, but I at least tried to comment all of it.  This should make
it easy to get "real" power numbers on any hardware that has a smart
battery without too much trouble.

I ran this on my board and got reasonable-looking results.  My smart
battery wasn't quite as smart as I hoped (reported wattage for the
same thing increased a little), but given that the numbers made sense
and were reasonable I'm willing to believe they're at least in the
ballpark.  To test, I charged my battery up to ~95% and then ran:

powernumbers.py 6 120; \
powernumbers.py 0 120; \
powernumbers.py 0 120; \
powernumbers.py 6 120

Running twice and 2 orders helped me account for the smart battery
seeming to report larger numbers as it drained.  If you wanted even
more accurate numbers you could run it until the battery drained and
take the average all the way down.  ...or find a better smart
battery...  ;-)

I'd be super curious if anyone else wants to run this on "released" hardware...

My hope in writing this is to prove that these numbers are _not_
secret nor hard to obtain on any hardware that's in the general
public's hands.

One note: in measuring on my board, I found that the ratio between the
dynamic-power-coefficient for the big and little cores didn't match
what Qualcomm provided.  I'll kick off a task to ask about this.
Specifically their numbers (in the public DTS) show bigs have a
coefficient of 405 and littles of 100.  If I understand correctly this
means that Qualcomm is claiming that bigs draw roughly 4x more power
if run at the same voltage / frequency.  My numbers showed closer to
3x (if littles were 100 bigs would be 313)

In any case, without further ado, here's my script.  Hopefully gmail
doesn't mangle it too badly (I tried to keep away from long lines and
it just uses spaces for indent):

===

#!python3

# NOTES:
# - You have to muck with the config (in code) below a bit.
#   It shouldn't be too hard, I hope.
# - You have to manually get the frequency / voltage mapping
#   and enter it below.  This is _not_ secret if you have
#   access to a device because the kernel needs to know it.
#   See below for at least one way to obtain.
# - This assumes you've got a battery that can measure current
#   that is reasonably accurate.  The one on the Chromebook
#   I tested seemed OK.
# - This doesn't cleanup after itself (leaves CPUs offline
#   at whatever freq it last tested).  Reboot after using.
# - You need to have "dry2" in your path (dhrystone).  This is
#   the canonical program used to benchmark.  There might
#   be some variance between the 32-bit version and 64-bit
#   version, so the 64-bit version is preferred if you want
#   to compare your numbers to others.
#   - I git cloned drystone and ran 2.2
#     https://github.com/Keith-S-Thompson/dhrystone.git
#   - I think I had to make a small change to includes
#     to fix compiler complaints?
#   - I compiled in Chrome OS chroot with:
#     LFLAGS="-static" \
#     CFLAGS="-O3" \
#     CC=aarch64-cros-linux-gnu-gcc sh dry.c
# - This is whipped together code.  It won't win beauty
#   contests.  Sorry.

# Before running, quiesce power and disconnect charger.
# You don't have to try too hard.  On Chrome OS, I did this:
#
# echo 0 > /sys/class/backlight/backlight/brightness
# stop ui
# stop powerd
# stop anomaly-detector
# stop metrics_daemon
# stop auditd
# killall timberslide

import glob
import os
import pprint
import subprocess
import sys
import time

### Config starts here ###

# Put a CPU number you want to measure here, or pass it in
# as the first argument.
if len(sys.argv) >= 2:
  measure_cpu = int(sys.argv[1])
else:
  measure_cpu = 0

# We'll spend this much time at each frequency.
# 2nd argument
# It seems that (at least my battery) slowly reports
# more power as it drains, so don't make this too long
# or it might skew your results.
if len(sys.argv) >= 3:
  min_time_per_freq = int(sys.argv[2])
else:
  min_time_per_freq = 120

# Path to your smart battery on your system.
sbs_path = "/sys/class/power_supply/sbs-12-000b"

# You need to fill in this voltage table for your system.
# Maybe there's a better way to get this, but on Qualcomm CPU
# frequencies you can simply instrument qcom_cpufreq_hw_read_lut()
# to print out a frequency and voltage.
#
# This maps Hz to uW
if measure_cpu == 0:
  voltage_table = {
    # FILL THIS IN.  See comment above.
    freq: uW,
  }
elif measure_cpu == 6:
  voltage_table = {
    # FILL THIS IN.  See comment above.
    freq: uW,
  }

### Program starts here ###

cpufreq_dir = "/sys/devices/system/cpu/cpu%d/cpufreq/" % measure_cpu
freqs = sorted(voltage_table.keys())

# Kick off a background process to log current/voltage every second
def start_power_measure():
  p = subprocess.Popen("""
    rm -f /tmp/times.txt;
    for i in $(seq %d); do
      echo $(cat %s/current_now %s/voltage_now) >> /tmp/times.txt;
      sleep 1;
    done"""  % (min_time_per_freq, sbs_path, sbs_path), shell=True)
  return p

# Look at the times the background process logged and return mW.
def stop_power_measure(p):
  # Finish the program.  It shouldn't have output anything.
  p.communicate()

  # Read and covert to watts.
  lines = open("/tmp/times.txt", "r").readlines()
  pairs = [line.split() for line in lines]
  watts = [(-float(uA) / 1000000) * (float(uV) / 1000000)
           for (uA, uV) in pairs]
  watts = list(sorted(watts))

  # Take only the middle 3rd (throw out the outliers)
  num = len(watts)
  watts = watts[num // 3:-num // 3]

  # Return mW
  return sum(watts) / len(watts) * 1000.

# Make sure only the CPU being measured is online
open("/sys/devices/system/cpu/cpu%d/online" %
     measure_cpu, "w").write("1")
for dir in glob.glob("/sys/devices/system/cpu/cpu[0-9]*"):
  if dir == "/sys/devices/system/cpu/cpu%d" % measure_cpu:
    continue
  open("%s/online" % dir, "w").write("0")

results = {}

# We need userspace governor so we can pick the frequency.
open(cpufreq_dir + "scaling_governor", "w").write("userspace")

# We'll measure quiescent power first at the lowest CPU freq
print("Reading quiescent power")
open(cpufreq_dir + "scaling_setspeed", "w").write(str(freqs[0]))
p = start_power_measure()
time.sleep(min_time_per_freq)
baseline_mW = stop_power_measure(p)
print("Baseline power is %.2f mW" % baseline_mW)

# Now we go through each
for freq in freqs:
  open(cpufreq_dir + "scaling_setspeed", "w").write(str(freq))

  print("========== Measuring power at %d Hz ==========" % freq)

  p = start_power_measure()
  start_time = time.time()

  # Keep running the benchmark to keep the CPU busy while we're
  # measuring power.  Arbitrarily picked a loops count so that
  # it was busy right away at all tested freqs.
  while time.time() - start_time < min_time_per_freq:
    subprocess.check_output(["dry2 100000000; true"],
                            stderr=subprocess.STDOUT, shell=True)

  mW = stop_power_measure(p)

  results[freq] = mW - baseline_mW
  print("Took %d seconds, used %.2f mW" %
        (time.time() - start_time, results[freq]))

# We now have total system power for each frequency.
pprint.pprint(repr(results))

# Use the magic math, as documented in:
# ac60c5e33df4 ARM: dts: rockchip: Add dynamic-power-coefficient...

P1 = results[freqs[0]]
V1 = voltage_table[freqs[0]] / 1000000.
f1 = freqs[0] / 1000000.

all_Cx = []
for freq in freqs[1:]:
  Px = results[freq]
  Vx = voltage_table[freq] / 1000000.
  fx = freq / 1000000.
  Cx = (Px - P1) / (Vx * Vx * fx - V1 * V1 * f1)
  all_Cx.append(Cx)
  print("%d kHz, %d mV, %d mW, %d Cx" %
        (freq / 1000, Vx * 1000, Px, Cx))

print("Your dynamic-power-coefficient for cpu %d: %d" %
      (measure_cpu, round(sum(all_Cx) / len(all_Cx))))
