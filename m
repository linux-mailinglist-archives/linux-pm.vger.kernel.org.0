Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77F4535120
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 17:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiEZPBr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 11:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiEZPBq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 11:01:46 -0400
X-Greylist: delayed 91341 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 May 2022 08:01:43 PDT
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C8428E3E
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 08:01:43 -0700 (PDT)
Date:   Thu, 26 May 2022 15:01:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1653577300; x=1653836500;
        bh=5P8QIJOOMnot0qfq/tW9v++oM8/Lf86PgjdkO5qWmHk=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=C6g1XPjvHQz89eKaRRlIuNfStIJ/FoclZ/z0mr4Lok4h/Hh9mGxfkLzypITHSlSTO
         eMgDC+uXZz5hTnKEX4yyVqmcsiHjFvtFtxNFanfy+gz2jmI/g8FQSXj03Or199h/oC
         USPmQJfYvGQZiDlUBeHUpsDAseJHXNbc7RG8vhEhGfYyo2ayh7z3ENWpkTHROkh3Gb
         D598hXRr+D+PU3b4d8Ca6/+bJOAFKpBUKnPzGz5GOeSmbBfmfuLzWJK3EhWUSzxec7
         dyqEwICjc9lUU38z5KWZd0C2SgATd00JObWxWSHWmcBnqC11M9qYipbkZKaPal6Tua
         hq+LsGDp0Hb2g==
To:     Viresh Kumar <viresh.kumar@linaro.org>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     =?utf-8?Q?=E2=80=9CRafael_J=2E_Wysocki=E2=80=9D?= 
        <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: Re: 'schedutil' (possibly) aberrant behavior surrounding suspend/resume process (timing/delay/run-away CPU issues)
Message-ID: <B6Vf9ZGyW3CDcuxpGzU6WbTq7cEi6z-3zrd0JIlop56-d5R3JiD1eQPrLcoM41xDz8_WYWTvQhodW7NLSDURsXl4cRpzsk-UhF17J5Mu5j4=@dannyvanheumen.nl>
In-Reply-To: <20220526032600.dlbrrppqovizwpvs@vireshk-i7>
References: <R6AlCxZca3GET8vtwpOAkzQ4Y9SX-NOVQ05FlJAKDUvNTYCAhsWy1e0q5soCkapaviI8SS-9eC51nwJj6yn6n1rFAlwndEqYqlr_hqz4C_U=@dannyvanheumen.nl> <20220525052804.rvnp2jinpmz7vukx@vireshk-i7> <34KkbDDzdEpklXuY3YwJi95cgyhc44xzV-xQVDRRuKctbmHUdH8Ddm2LMcSUVNVmwtGUaB73-yOqIijCnMFRfh3aYxlKOKcrrRyCHb2uOPw=@dannyvanheumen.nl> <20220526032600.dlbrrppqovizwpvs@vireshk-i7>
Feedback-ID: 15073070:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

------- Original Message -------
On Thursday, May 26th, 2022 at 05:26, Viresh Kumar <viresh.kumar@linaro.org=
> wrote:


> On 25-05-22, 13:39, Danny van Heumen wrote:
>
> > On Wednesday, May 25th, 2022 at 07:28, Viresh Kumar viresh.kumar@linaro=
.org wrote:
> >
> > [..]
> >
> > So the fact that 'schedutil' is not available but the other governors
> > are, is actually meaningless?
>
>
> Cpufreq core in the kernel has two separate entities: drivers and
> governors. Drivers mostly decide how frequency is read or updated on
> the hardware and governors decide on the policy, i.e. what frequency
> to go to and when.

Understood. No surprises here.

> When intel-pstate is set to "active", the governor algorithms from
> cpufreq core are take out, i.e. files like
> drivers/cpufreq/cpufreq_ondemand.c or cpufreq_conservative.c or
> sched/kernel/cpufreq_schedutil.c. Instead the driver, along with help
> from the hardware, decides the next frequency by itself. In this case
> we have two policies available (these are still called as governors in
> userspace), powersave and performance. These two tell how aggressive
> we need to be, but again the governor algorithms are gone.

Right, I see now that the set of governors is different.

> > Does that mean that setting 'powersave' vs 'performance' is meaningless
> > too?
>
>
> No.

This is clear, also by your explanation above.

> > If not, does that mean that the meaning changes (as in "determined
> > by") intel_pstate?
>
>
> What I wanted to say earlier was that if you want to pin point it to
> schedutil (I know you are just trying to find it out yourself as
> well), then you must always keep intel_pstate=3D"passive" and then test
> between ondemand and schedutil and see if problem happens or not. That
> way we can see if it is one of the governors or both, when the problem
> happens.

Right. Thas already was my intention. I have already done more tests. I
notice now that this seems to be a pattern such that if it occurs once,
it keeps on occurring.

I see patterns such as below, where first thermal is before suspend,
second thermal is immediately after waking up. Note that apparently
some intel driver logic prevents full suspend with temp > 50 degrees.
I have very similar behavior to that case, but with temperature confirmed
below 50 degrees.

Below is a quick test of about 3 minutes time.

```console
> sensors pch_skylake-virtual-0; echo 'mem' | sudo tee /sys/power/state; \
sensors pch_skylake-virtual-0

pch_skylake-virtual-0
Adapter: Virtual device
temp1:        +47.5=C2=B0C

mem

pch_skylake-virtual-0
Adapter: Virtual device
temp1:        +57.5=C2=B0C
```

```dmesg
intel_pch_thermal 0000:00:14.2: CPU-PCH is cool [47C], continue to suspend
pcieport 0000:00:1c.5: Intel SPT PCH root port ACS workaround enabled
ACPI: EC: interrupt blocked
nvme nvme0: I/O 1015 QID 2 timeout, aborting
nvme nvme0: I/O 22 QID 0 timeout, completion polled
nvme nvme0: Abort status: 0x0
ACPI: EC: interrupt unblocked
pcieport 0000:00:1c.5: Intel SPT PCH root port ACS workaround enabled
pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
pcieport 0000:00:1c.0: Intel SPT PCH root port ACS workaround enabled
pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
usb 1-3: reset full-speed USB device number 2 using xhci_hcd
OOM killer enabled.
Restarting tasks ...
mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound \
0000:00:02.0 (ops i915_hdcp_component_ops [i915])
done.
systemd[1]: systemd-journald.service: Main process exited, code=3Dkilled, \
status=3D6/ABRT
systemd[1]: systemd-journald.service: Failed with result 'watchdog'.
systemd[1]: systemd-journald.service: Consumed 1.844s CPU time.
systemd[1]: systemd-journald.service: Scheduled restart job, restart counte=
r \
is at 1.
systemd[1]: Stopping Flush Journal to Persistent Storage...
systemd[1]: Stopped target Bluetooth.
systemd[1]: Started Load/Save RF Kill Switch Status.
PM: suspend exit
```

This is just to illustrate some tries. I will continue to test, to
figure out if I can either trigger the circumstances without
'schedutil' (which clears my suspicion) or otherwise try to make it
more deterministic, reproducible.

The nvme errors in dmesg are new to me. I have not seen those before.
So I will also keep an eye out for those.


> > > Also I am not yet sure it is related to cpufreq right now.
> >
> > I am trying to figure out whether or not some problems are caused by
> > 'schedutil' vs it just being present. I guessed from the MAINTAINERS
> > index that you are probably the maintainers with knowledge on
> > schedutil. If not, do you know where I should look then?
>
>
> That's right. Me, Rafael and Peter look at the schedutil governor
> normally. You have the mail to right people.
>
> [..]
>
> > I wonder if I am taking a wrong approach in tackling these issues,
> > so if you have recommendations, please let me know.
>
>
> I would also try intel_pstate=3Dpassive with powersave and performance.
> The heating issue, if related to cpufreq leaving CPU at higher freq,
> should also occur with performance (which keeps CPUs at highest freq).

I described the approach above. I will try 'performance' and/or
'powersave' too. It does seem like temperature is not the driving
factor here. (As temperature is low enough even intel_pch_thermal.)
Maybe it does make reproduction easier.

>
> --
> viresh
