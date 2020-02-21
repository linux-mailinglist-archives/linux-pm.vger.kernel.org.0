Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE8AB1689CE
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 23:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgBUWK7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 17:10:59 -0500
Received: from mx1.riseup.net ([198.252.153.129]:45096 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgBUWK6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Feb 2020 17:10:58 -0500
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48PQdY5BjczFbgR;
        Fri, 21 Feb 2020 14:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1582323057; bh=xDOULZRpbeY7KpvwA2rDOTseM/Ct7CH+yfVqbVPQOHw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NKbG4bYO6gvtg2/bKnLk14xCYOMnhVr53RVGZaHsJRKqOMLZYPIJHRemEdQBpTEC0
         YOffv3QOfRBikqTDT1mzdN90/tOwANwm8zeAYggJCnV4yrebrZf61fLzv5ph30uc11
         EDyn92fFGa9PAAdGClcARYwpQgaQ6FREOZAenCBY=
X-Riseup-User-ID: 40F904F66C7E578679E7FE1A4FD79D280A24236C0758237B6635A1E2D09F48C0
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 48PQdY15XFz8v7L;
        Fri, 21 Feb 2020 14:10:57 -0800 (PST)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU latency QoS interface
In-Reply-To: <CAJZ5v0hH1XiphdakYFPmHLL+hFKw2U3YNU9HSRxsdRUV6ZtM5g@mail.gmail.com>
References: <1654227.8mz0SueHsU@kreacher> <87wo8rjsa4.fsf@riseup.net> <CAJZ5v0hAn0V-QhebFt=vqKK6gBLxjTq7SNOWOStt7huCXMSH7g@mail.gmail.com> <CAJZ5v0hrOma52rocMsitvYUK6WxHAa0702_8XJn1UJZVyhz=rQ@mail.gmail.com> <877e0qj4bm.fsf@riseup.net> <CAJZ5v0hH1XiphdakYFPmHLL+hFKw2U3YNU9HSRxsdRUV6ZtM5g@mail.gmail.com>
Date:   Fri, 21 Feb 2020 14:10:54 -0800
Message-ID: <87ftf3fv69.fsf@riseup.net>
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

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Thu, Feb 13, 2020 at 9:09 AM Francisco Jerez <currojerez@riseup.net> wrote:
>>
>> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>>
>> > On Thu, Feb 13, 2020 at 1:16 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> >>
>> >> On Thu, Feb 13, 2020 at 12:31 AM Francisco Jerez <currojerez@riseup.net> wrote:
>> >> >
>
> [cut]
>
>> >
>> > And BTW, posting patches as RFC is fine even if they have not been
>> > tested.  At least you let people know that you work on something this
>> > way, so if they work on changes in the same area, they may take that
>> > into consideration.
>> >
>>
>> Sure, that was going to be the first RFC.
>>
>> > Also if there are objections to your proposal, you may save quite a
>> > bit of time by sending it early.
>> >
>> > It is unfortunate that this series has clashed with the changes that
>> > you were about to propose, but in this particular case in my view it
>> > is better to clean up things and start over.
>> >
>>
>> Luckily it doesn't clash with the second RFC I was meaning to send,
>> maybe we should just skip the first?
>
> Yes, please.
>
>> Or maybe it's valuable as a curiosity anyway?
>
> No, let's just focus on the latest one.
>
> Thanks!

We don't seem to have reached much of an agreement on the general
direction of RFC2, so I can't really get started with it.  Here is RFC1
for the record:

https://github.com/curro/linux/commits/intel_pstate-lp-hwp-v10.8-alt

Specifically the following patch conflicts with this series:

https://github.com/curro/linux/commit/9a16f35531bbb76d38493da892ece088e31dc2e0

Series improves performance-per-watt of GfxBench gl_4 (AKA Car Chase) by
over 15% on my system with the branch above, actual FPS "only" improves
about 5.9% on ICL laptop due to it being very lightly TDP-bound with its
rather huge TDP.  The performance of almost every graphics benchmark
I've tried improves significantly with it (a number of SynMark
test-cases are improved by around 40% in perf-per-watt, Egypt
perf-per-watt improves by about 25%).

Hopefully we can come up with some alternative plan of action.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXlBVbgAKCRCDmTidfVK/
W/gtAP0dDbIUxAKRzrls42EXSlpM90oykm1O5NuaXw5FQsrp6wD7BqAQtSgtC7kt
xSSD+vYRPoTK1cLrAHb6gTD2l3BeQRQ=
=U3Wm
-----END PGP SIGNATURE-----
--==-=-=--
