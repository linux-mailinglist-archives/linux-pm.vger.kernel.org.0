Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62841D425C
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 02:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgEOAsr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 20:48:47 -0400
Received: from mx1.riseup.net ([198.252.153.129]:52540 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgEOAsr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 20:48:47 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 49NVCL3zfvzFfym;
        Thu, 14 May 2020 17:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1589503726; bh=7SOSWVn0DgNQFYknXarS1OGvoQXvfWLX4YqUUceqERM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CQijsDMTJp3yvinSZxvVP52/S362knRXOQ/E5vkL6QVNro0GNdmmfYZQOPvNhz+0K
         U4FjBcVFBB1DW0ysjHBvUcGvEhE23mSKQ7o3p7YEgItk0xhSfr1udxL8etRhUczyKg
         S0Fl8pmZaU9W0u9qHTE2Bpxqcyke8vPT0meD5iaI=
X-Riseup-User-ID: C96C279AFD7B7060B8EA31CDDB86C231BFE047804274BA9CC84DA16DD6137CBB
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 49NVCL16p0zJmg9;
        Thu, 14 May 2020 17:48:46 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>,
        linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        chris.p.wilson@intel.com,
        "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com
Subject: Re: [RFC] GPU-bound energy efficiency improvements for the intel_pstate driver (v2.99)
In-Reply-To: <10201092.tPqIMJ2V0o@kreacher>
References: <20200428032258.2518-1-currojerez@riseup.net> <20200511105701.GA2940@hirez.programming.kicks-ass.net> <874ksmuqx6.fsf@riseup.net> <10201092.tPqIMJ2V0o@kreacher>
Date:   Thu, 14 May 2020 17:48:57 -0700
Message-ID: <878shut43q.fsf@riseup.net>
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

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Monday, May 11, 2020 11:01:41 PM CEST Francisco Jerez wrote:
>>=20
>> --=3D=3D-=3D-=3D
>> Content-Type: multipart/mixed; boundary=3D"=3D-=3D-=3D"
>>=20
>> --=3D-=3D-=3D
>> Content-Type: text/plain; charset=3Dutf-8
>> Content-Disposition: inline
>> Content-Transfer-Encoding: quoted-printable
>>=20
>> Peter Zijlstra <peterz@infradead.org> writes:
>>=20
>> > On Mon, Apr 27, 2020 at 08:22:47PM -0700, Francisco Jerez wrote:
>> >> This addresses the technical concerns people brought up about my
>> >> previous v2 revision of this series.  Other than a few bug fixes, the
>> >> only major change relative to v2 is that the controller is now exposed
>> >> as a new CPUFREQ generic governor as requested by Rafael (named
>> >> "adaptive" in this RFC though other naming suggestions are welcome).
>> >> Main reason for calling this v2.99 rather than v3 is that I haven't
>> >> yet addressed all the documentation requests from the v2 thread --
>> >> Will spend some time doing that as soon as I have an ACK (ideally from
>> >> Rafael) that things are moving in the right direction.
>> >>=3D20
>> >> You can also find this series along with the WIP code for non-HWP
>> >> platforms in this branch:
>> >>=3D20
>> >> https://github.com/curro/linux/tree/intel_pstate-vlp-v2.99
>> >>=3D20
>> >> Thanks!
>> >>=3D20
>> >> [PATCHv2.99 01/11] PM: QoS: Add CPU_SCALING_RESPONSE global PM QoS li=
mit.
>> >> [PATCHv2.99 02/11] drm/i915: Adjust PM QoS scaling response frequency=
 ba=3D
>> sed on GPU load.
>> >> [PATCHv2.99 03/11] OPTIONAL: drm/i915: Expose PM QoS control paramete=
rs =3D
>> via debugfs.
>> >> [PATCHv2.99 04/11] cpufreq: Define ADAPTIVE frequency governor policy.
>> >> [PATCHv2.99 05/11] cpufreq: intel_pstate: Reorder intel_pstate_clear_=
upd=3D
>> ate_util_hook() and intel_pstate_set_update_util_hook().
>> >> [PATCHv2.99 06/11] cpufreq: intel_pstate: Call intel_pstate_set_updat=
e_u=3D
>> til_hook() once from the setpolicy hook.
>> >> [PATCHv2.99 07/11] cpufreq: intel_pstate: Implement VLP controller st=
ati=3D
>> stics and target range calculation.
>> >> [PATCHv2.99 08/11] cpufreq: intel_pstate: Implement VLP controller fo=
r H=3D
>> WP parts.
>> >> [PATCHv2.99 09/11] cpufreq: intel_pstate: Enable VLP controller based=
 on=3D
>>  ACPI FADT profile and CPUID.
>> >> [PATCHv2.99 10/11] OPTIONAL: cpufreq: intel_pstate: Add tracing of VL=
P c=3D
>> ontroller status.
>> >> [PATCHv2.99 11/11] OPTIONAL: cpufreq: intel_pstate: Expose VLP contro=
lle=3D
>> r parameters via debugfs.
>> >
>> > What I'm missing is an explanation for why this isn't using the
>> > infrastructure that was build for these kinds of things? The thermal
>> > framework, was AFAIU, supposed to help with these things, and the IPA
>> > thing in particular is used by ARM to do exactly this GPU/CPU power
>> > budget thing.
>> >
>> > If thermal/IPA is found wanting, why aren't we improving that?
>>=20
>> The GPU/CPU power budget "thing" is only a positive side effect of this
>> series on some TDP-bound systems.  Its ultimate purpose is improving the
>> energy efficiency of workloads which have a bottleneck on a device other
>> than the CPU, by giving the bottlenecking device driver some influence
>> over the response latency of CPUFREQ governors via a PM QoS interface.
>> This seems to be completely outside the scope of the thermal framework
>> and IPA AFAIU.
>>=20
>> >
>> > How much of that ADAPTIVE crud is actually intel_pstate specific? On a
>> > (really) quick read it appears to me that much of the controller bits
>> > there can be applied more generic, and thus should not be part of any
>> > one governor.
>> >
>>=20
>> The implementation of that is intel_pstate-specific right now, but the
>> basic algorithm could be made to work on any other governor in
>> principle, which is why it is exposed as a generic CPUFREQ governor.  I
>> don't care about taking out the generic CPUFREQ governor changes if you
>> don't like them, and going back to some driver-specific means of turning
>> it on and off (though Rafael might disagree with that).
>>=20
>> > Specifically, I want to use sched_util as cpufreq governor and use the
>> > intel_pstate as a passive driver.
>>=20
>> Yeah, getting a similar optimization into the schedutil governor has
>> been on my wish list for a while, but I haven't had the time to get very
>> far on that except for a handful of hacks.  The intel_pstate handling is
>> going to be necessary anyway in order to handle HWP systems gracefully,
>> at least in the near future until schedutil becomes a viable alternative
>> to intel_pstate in active mode on HWP systems.
>
> FWIW, work is under way to make intel_pstate in the passive mode work on =
HWP
> systems.
>
> I have a prototype patch for that, but it can be improved.  I'll post a n=
ew
> version of it for review, possibly next week.
>

Looking forward to that, feel free to CC me on it.

> Cheers!

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXr3m+gAKCRCDmTidfVK/
W0/gAP0T+OHYIjOClcoTQZwv4uhseNP+fgblEwVRGCcRnok0dgD/UWqvORP9z/xr
OeEtsNwkbv8fgaxGJZkYZbI9Z/qXcrk=
=WEOL
-----END PGP SIGNATURE-----
--==-=-=--
