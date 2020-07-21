Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E1A228C90
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jul 2020 01:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbgGUXOs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 19:14:48 -0400
Received: from mx1.riseup.net ([198.252.153.129]:45742 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgGUXOs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Jul 2020 19:14:48 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4BBDvW5l4BzDsyq;
        Tue, 21 Jul 2020 16:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1595373287; bh=xTMTPC9hzFXTn074+lx+RG5xa8F+eokxN3Wm7v/sl5w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tWan2osbkTAhw60D6EEvW6y1Sia0ZrAnYPzzghqfAXoRNpVy9Cios+mIuALUru9lT
         YSibRGi5JuuTzKlyGI0e/JZGpjoCYPBmxY3Mhs1cIWqMLAKlcSuldVRoJkHXv+3qKD
         4kZ5LY1Dt0oaUt/6s58z/9bhgGVOfZM/iSV5G3AY=
X-Riseup-User-ID: 5D3B783D35A34F52B7A96CE5A467C9284C412353663B0286B37FB04230C3A720
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 4BBDvV6VbhzJqp6;
        Tue, 21 Jul 2020 16:14:46 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
In-Reply-To: <babeff29a60d3fadb5515eaf57f7bb42a1c9c792.camel@linux.intel.com>
References: <3955470.QvD6XneCf3@kreacher> <87r1tdiqpu.fsf@riseup.net> <CAJZ5v0jaRm-wv+ZKhOyGJrrKZAsTKc3sq2GYyv0uerTTe3gXbQ@mail.gmail.com> <87imeoihqs.fsf@riseup.net> <CAJZ5v0hhLWvbNA6w0yHtzKa5ANR9yF++u63dh8wWAgkhbtLXXA@mail.gmail.com> <875zanhty6.fsf@riseup.net> <CAJZ5v0g2U+1wD5rUQwJ4_x9sQyvGyGiBiLFs7MA-xdhRBX9zBQ@mail.gmail.com> <87mu3thiz5.fsf@riseup.net> <babeff29a60d3fadb5515eaf57f7bb42a1c9c792.camel@linux.intel.com>
Date:   Tue, 21 Jul 2020 16:14:42 -0700
Message-ID: <87h7u0h34t.fsf@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:

> On Mon, 2020-07-20 at 16:20 -0700, Francisco Jerez wrote:
>> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>>=20
>> > On Fri, Jul 17, 2020 at 2:21 AM Francisco Jerez <
>> > currojerez@riseup.net> wrote:
>> > > "Rafael J. Wysocki" <rafael@kernel.org> writes:
>> > >=20
> {...]
>
>> > Overall, so far, I'm seeing a claim that the CPU subsystem can be
>> > made
>> > use less energy and do as much work as before (which is what
>> > improving
>> > the energy-efficiency means in general) if the maximum frequency of
>> > CPUs is limited in a clever way.
>> >=20
>> > I'm failing to see what that clever way is, though.
>> Hopefully the clarifications above help some.
>
> To simplify:
>
> Suppose I called a function numpy.multiply() to multiply two big arrays
> and thread is a pegged to a CPU. Let's say it is causing CPU to
> finish the job in 10ms and it is using a P-State of 0x20. But the same
> job could have been done in 10ms even if it was using P-state of 0x16.
> So we are not energy efficient. To really know where is the bottle neck
> there are numbers of perf counters, may be cache was the issue, we
> could rather raise the uncore frequency a little. A simple APRF,MPERF
> counters are not enough.=20

Yes, that's right, APERF and MPERF aren't sufficient to identify every
kind of possible bottleneck, some visibility of the utilization of other
subsystems is necessary in addition -- Like e.g the instrumentation
introduced in my series to detect a GPU bottleneck.  A bottleneck
condition in an IO device can be communicated to CPUFREQ by adjusting a
PM QoS latency request (link [2] in my previous reply) that effectively
gives the governor permission to rearrange CPU work arbitrarily within
the specified time frame (which should be of the order of the natural
latency of the IO device -- e.g. at least the rendering time of a frame
for a GPU) in order to minimize energy usage.

> or we characterize the workload at different P-states and set limits.
> I think this is not you want to say for energy efficiency with your
> changes.=20
>
> The way you are trying to improve "performance" is by caller (device
> driver) to say how important my job at hand. Here device driver suppose
> offload this calculations to some GPU and can wait up to 10 ms, you
> want to tell CPU to be slow. But the p-state driver at a movement
> observes that there is a chance of overshoot of latency, it will
> immediately ask for higher P-state. So you want P-state limits based on
> the latency requirements of the caller. Since caller has more knowledge
> of latency requirement, this allows other devices sharing the power
> budget to get more or less power, and improve overall energy efficiency
> as the combined performance of system is improved.
> Is this correct?

Yes, pretty much.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXxd24gAKCRCDmTidfVK/
W4GXAPwIcPQpg2P5WEtcbZXe6xj58DHrm74yDbNuqQ97/+QnOQD9EinC1l0jSaqa
oDWAREm4nOKPJuHFuljv0ghORZ+GI6I=
=aUj6
-----END PGP SIGNATURE-----
--==-=-=--
