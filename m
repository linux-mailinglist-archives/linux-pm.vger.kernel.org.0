Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97B5415B4BE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgBLXbl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:31:41 -0500
Received: from mx1.riseup.net ([198.252.153.129]:39554 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLXbk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 18:31:40 -0500
Received: from capuchin.riseup.net (unknown [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48Hwrr0byKzFcgd;
        Wed, 12 Feb 2020 15:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1581550300; bh=WQzsCAum3vot0OO8Rh5gld8CY5CoNUUA/bFibyS4ieU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dvLWRiZ+yZP9fsSGgpTkLNSIxZ4gb8/Si4JFx7w50EY66EqTCXlFEIW5/IKPF0sGk
         OYop+vuf4GiipGEti8boXkTX5OZSDPLd8x27VbTudQuvKclZtPkNMTcXc+tgwtJkay
         U6bziTPRrSb3gDqoITop1RZKczm3DMaSPPmpMPdY=
X-Riseup-User-ID: 6345BBB02EB95945EB8B95684DE7CC829012FB1D93E2AC17286A75F32F92C643
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 48Hwrq3kZkz8w8y;
        Wed, 12 Feb 2020 15:31:39 -0800 (PST)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU latency QoS interface
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
Date:   Wed, 12 Feb 2020 15:32:35 -0800
Message-ID: <87wo8rjsa4.fsf@riseup.net>
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

> Hi All,
>
> This series of patches is based on the observation that after commit
> c3082a674f46 ("PM: QoS: Get rid of unused flags") the only global PM QoS =
class
> in use is PM_QOS_CPU_DMA_LATENCY, but there is still a significant amount=
 of
> code dedicated to the handling of global PM QoS classes in general.  That=
 code
> takes up space and adds overhead in vain, so it is better to get rid of i=
t.
>
> Moreover, with that unuseful code removed, the interface for adding QoS
> requests for CPU latency becomes inelegant and confusing, so it is better=
 to
> clean it up.
>
> Patches [01/28-12/28] do the first part described above, which also inclu=
des
> some assorted cleanups of the core PM QoS code that doesn't go away.
>
> Patches [13/28-25/28] rework the CPU latency QoS interface (in the classic
> "define stubs, migrate users, change the API proper" manner), patches
> [26-27/28] update the general comments and documentation to match the code
> after the previous changes and the last one makes the CPU latency QoS dep=
end
> on CPU_IDLE (because cpuidle is the only user of its target value today).
>
> The majority of the patches in this series don't change the functionality=
 of
> the code at all (at least not intentionally).
>
> Please refer to the changelogs of individual patches for details.
>
> Thanks!

Hi Rafael,

I believe some of the interfaces removed here could be useful in the
near future.  It goes back to the energy efficiency- (and IGP graphics
performance-)improving series I submitted a while ago [1].  It relies on
some mechanism for the graphics driver to report an I/O bottleneck to
CPUFREQ, allowing it to make a more conservative trade-off between
energy efficiency and latency, which can greatly reduce the CPU package
energy usage of IO-bound applications (in some graphics benchmarks I've
seen it reduced by over 40% on my ICL laptop), and therefore also allows
TDP-bound applications to obtain a reciprocal improvement in throughput.

I'm not particularly fond of the global PM QoS interfaces TBH, it seems
like an excessively blunt hammer to me, so I can very much relate to the
purpose of this series.  However the finer-grained solution I've
implemented has seen some push-back from i915 and CPUFREQ devs due to
its complexity, since it relies on task scheduler changes in order to
track IO bottlenecks per-process (roughly as suggested by Peter Zijlstra
during our previous discussions), pretty much in the spirit of PELT but
applied to IO utilization.

With that in mind I was hoping we could take advantage of PM QoS as a
temporary solution [2], by introducing a global PM QoS class similar but
with roughly converse semantics to PM_QOS_CPU_DMA_LATENCY, allowing
device drivers to report a *lower* bound on CPU latency beyond which PM
shall not bother to reduce latency if doing so would have negative
consequences on the energy efficiency and/or parallelism of the system.
Of course one would expect the current PM_QOS_CPU_DMA_LATENCY upper
bound to take precedence over the new lower bound in cases where the
former is in conflict with the latter.

I can think of several alternatives to that which don't involve
temporarily holding off your clean-up, but none of them sound
particularly exciting:

 1/ Use an interface specific to CPUFREQ, pretty much like the one
    introduced in my original submission [1].
=20
 2/ Use per-CPU PM QoS, which AFAICT would require the graphics driver
    to either place a request on every CPU of the system (which would
    cause a frequent operation to have O(N) complexity on the number of
    CPUs on the system), or play a cat-and-mouse game with the task
    scheduler.
=20
 3/ Add a new global PM QoS mechanism roughly duplicating the
    cpu_latency_qos_* interfaces introduced in this series.  Drop your
    change making this available to CPU IDLE only.
=20
 3/ Go straight to a scheduling-based approach, which is likely to
    greatly increase the review effort required to upstream this
    feature.  (Peter might disagree though?)

Regards,
Francisco.

[1] https://lore.kernel.org/linux-pm/20180328063845.4884-1-currojerez@riseu=
p.net/

[2] I've written the code to do this already, but I wasn't able to test
    and debug it extensively until this week due to the instability of
    i915 on recent v5.5 kernels that prevented any benchmark run from
    surviving more than a few hours on my ICL system, hopefully the
    required i915 fixes will flow back to stable branches soon enough.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXkSLEwAKCRCDmTidfVK/
W0MsAP9x2ki7rWYnpUKfuSP5d9GDa5g1sIgiIv4hOFGlvVSXggEAowSpSOOqYZ4D
5wVNeS9hNZD00KHzVjgKoBfZ3cidegI=
=nV7b
-----END PGP SIGNATURE-----
--==-=-=--
