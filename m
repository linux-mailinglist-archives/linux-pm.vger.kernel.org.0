Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85DF3187448
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 21:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbgCPUy1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 16:54:27 -0400
Received: from mx1.riseup.net ([198.252.153.129]:44182 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732486AbgCPUy1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Mar 2020 16:54:27 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48h7pB5vsHzFfCB;
        Mon, 16 Mar 2020 13:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1584392066; bh=0K7hTg742mmDbjHrmpW+Rw87i8fHIYp9ohLIcA2oYic=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=F7yY6w0xob02U5xjgOgwriomdpAnX8PUvQSGoTVmd3Fx+GU+uKNfH05hUoTXqD6J6
         0QCoL/qE4i5OYSblF92R3rL4oCe61ovufr5SeOYpFwNofHEIjUEoXwexlwc2pGearK
         L7D258ZXkRrpANBPytU+pLeC7w6dsvo8h1G13ZoM=
X-Riseup-User-ID: 568B88FCE0CE610BD520357C12E9668B8BB3C06EAAF5D57F9AB23955D82D4428
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 48h7pB25x3zJrcF;
        Mon, 16 Mar 2020 13:54:26 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-pm@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>,
        chris.p.wilson@intel.com
Subject: Re: [Intel-gfx] [PATCH 02/10] drm/i915: Adjust PM QoS response frequency based on GPU load.
In-Reply-To: <87sgic9008.fsf@riseup.net>
References: <20200310214203.26459-1-currojerez@riseup.net> <20200310214203.26459-3-currojerez@riseup.net> <158387916218.28297.4489489879582782488@build.alporthouse.com> <ac5fdd3c-bf47-60d3-edef-82d451266dcb@linux.intel.com> <878sk6acqs.fsf@riseup.net> <36854a07-2dd5-694c-4b9d-a3eddf8e33f9@linux.intel.com> <87sgic9008.fsf@riseup.net>
Date:   Mon, 16 Mar 2020 13:54:28 -0700
Message-ID: <875zf481h7.fsf@riseup.net>
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

Francisco Jerez <currojerez@riseup.net> writes:

> Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> writes:
>[...]
>> Some time ago we entertained the idea of GPU "load average", where that=
=20
>> was defined as a count of runnable requests (so batch buffers). How=20
>> that, more generic metric, would behave here if used as an input signal=
=20
>> really intrigues me. Sadly I don't have a patch ready to give to you and=
=20
>> ask to please test it.
>>
>> Or maybe the key is count of runnable contexts as opposed to requests,=20
>> which would more match the ELSP[1] idea.
>>
>[..]
> This patch takes the rather conservative approach of limiting the
> application of the response frequency PM QoS request to the more
> restrictive set of cases where we are most certain that CPU latency
> shouldn't be an issue, in order to avoid regressions.  But it might be
> that you find the additional energy efficiency benefit from the more
> aggressive approach to be worth the cost to a few execlists submission
> latency-sensitive applications.  I'm trying to get some numbers
> comparing the two approaches now, will post them here once I have
> results so we can make a more informed trade-off.
>

I got some results from the promised comparison between the dual-ELSP
utilization approach used in this series and the more obvious
alternative of keeping track of the time that any request (or context)
is in flight.  As expected there are quite a few performance
improvements (numbers relative to this approach), however most of them
are either synthetic benchmarks or off-screen variants of benchmarks
(the corresponding on-screen variant of each benchmark below doesn't
show a significant improvement):

 synmark/OglCSDof:                                                         =
             XXX =C2=B10.15% x18 ->   XXX =C2=B10.22% x12          d=3D1.15=
% =C2=B10.18%       p=3D0.00%
 synmark/OglDeferred:                                                      =
             XXX =C2=B10.31% x18 ->   XXX =C2=B10.15% x12          d=3D1.16=
% =C2=B10.26%       p=3D0.00%
 synmark/OglTexFilterAniso:                                                =
             XXX =C2=B10.18% x18 ->   XXX =C2=B10.21% x12          d=3D1.25=
% =C2=B10.19%       p=3D0.00%
 synmark/OglPSPhong:                                                       =
             XXX =C2=B10.43% x18 ->   XXX =C2=B10.29% x12          d=3D1.28=
% =C2=B10.38%       p=3D0.00%
 synmark/OglBatch0:                                                        =
             XXX =C2=B10.40% x18 ->   XXX =C2=B10.53% x12          d=3D1.29=
% =C2=B10.46%       p=3D0.00%
 synmark/OglVSDiffuse8:                                                    =
             XXX =C2=B10.49% x17 ->   XXX =C2=B10.25% x12          d=3D1.30=
% =C2=B10.41%       p=3D0.00%
 synmark/OglVSTangent:                                                     =
             XXX =C2=B10.53% x18 ->   XXX =C2=B10.31% x12          d=3D1.31=
% =C2=B10.46%       p=3D0.00%
 synmark/OglGeomPoint:                                                     =
             XXX =C2=B10.56% x18 ->   XXX =C2=B10.15% x12          d=3D1.48=
% =C2=B10.44%       p=3D0.00%
 gputest/plot3d:                                                           =
             XXX =C2=B10.16% x18 ->   XXX =C2=B10.11% x12          d=3D1.50=
% =C2=B10.14%       p=3D0.00%
 gputest/tess_x32:                                                         =
             XXX =C2=B10.15% x18 ->   XXX =C2=B10.06% x12          d=3D1.59=
% =C2=B10.13%       p=3D0.00%
 synmark/OglTexFilterTri:                                                  =
             XXX =C2=B10.15% x18 ->   XXX =C2=B10.19% x12          d=3D1.62=
% =C2=B10.17%       p=3D0.00%
 synmark/OglBatch3:                                                        =
             XXX =C2=B10.57% x18 ->   XXX =C2=B10.33% x12          d=3D1.70=
% =C2=B10.49%       p=3D0.00%
 synmark/OglBatch1:                                                        =
             XXX =C2=B10.41% x18 ->   XXX =C2=B10.34% x12          d=3D1.81=
% =C2=B10.38%       p=3D0.00%
 synmark/OglShMapVsm:                                                      =
             XXX =C2=B10.53% x18 ->   XXX =C2=B10.38% x12          d=3D1.81=
% =C2=B10.48%       p=3D0.00%
 synmark/OglTexMem128:                                                     =
             XXX =C2=B10.62% x18 ->   XXX =C2=B10.29% x12          d=3D1.87=
% =C2=B10.52%       p=3D0.00%
 phoronix/x11perf/test=3DScrolling 500 x 500 px:                           =
                XXX =C2=B10.35% x6 ->   XXX =C2=B10.56% x12          d=3D2.=
23% =C2=B10.52%       p=3D0.00%
 phoronix/x11perf/test=3D500px Copy From Window To Window:                 =
                XXX =C2=B10.00% x3 ->   XXX =C2=B10.74% x12          d=3D2.=
41% =C2=B10.70%       p=3D0.01%
 gfxbench/gl_trex_off:                                                     =
              XXX =C2=B10.04% x3 ->   XXX =C2=B10.34% x12          d=3D2.59=
% =C2=B10.32%       p=3D0.00%
 synmark/OglBatch2:                                                        =
             XXX =C2=B10.85% x18 ->   XXX =C2=B10.21% x12          d=3D2.87=
% =C2=B10.67%       p=3D0.00%
 glbenchmark/GLB27_EgyptHD_inherited_C24Z16_FixedTime_Offscreen:           =
              XXX =C2=B10.35% x3 ->   XXX =C2=B10.84% x12          d=3D3.03=
% =C2=B10.81%       p=3D0.01%
 glbenchmark/GLB27_TRex_C24Z16_Offscreen:                                  =
              XXX =C2=B10.23% x3 ->   XXX =C2=B10.32% x12          d=3D3.09=
% =C2=B10.32%       p=3D0.00%
 synmark/OglCSCloth:                                                       =
             XXX =C2=B10.60% x18 ->   XXX =C2=B10.29% x12          d=3D3.76=
% =C2=B10.50%       p=3D0.00%
 phoronix/x11perf/test=3DCopy 500x500 From Pixmap To Pixmap:               =
                XXX =C2=B10.44% x3 ->   XXX =C2=B10.70% x12          d=3D4.=
31% =C2=B10.69%       p=3D0.00%

There aren't as many regressions (numbers relative to upstream
linux-next kernel), they're mostly 2D test-cases, however they are
substantially worse in absolute value:

 phoronix/jxrendermark/rendering-test=3D12pt Text LCD/rendering-size=3D128x=
128:              XXX =C2=B10.30% x26 ->  XXX =C2=B15.71% x26        d=3D-2=
3.15% =C2=B13.11%       p=3D0.00%
 phoronix/jxrendermark/rendering-test=3DLinear Gradient Blend/rendering-siz=
e=3D128x128:      XXX =C2=B10.30% x26 ->  XXX =C2=B14.32% x26        d=3D-2=
1.34% =C2=B12.41%       p=3D0.00%
 phoronix/x11perf/test=3D500px Compositing From Pixmap To Window:          =
               XXX =C2=B115.46% x26 -> XXX =C2=B112.76% x26       d=3D-19.0=
5% =C2=B113.15%       p=3D0.00%
 phoronix/jxrendermark/rendering-test=3DTransformed Blit Bilinear/rendering=
-size=3D128x128:  XXX =C2=B10.20% x26 ->  XXX =C2=B13.82% x27         d=3D-=
5.07% =C2=B12.57%       p=3D0.00%
 phoronix/gtkperf/gtk-test=3DGtkDrawingArea - Pixbufs:                     =
                XXX =C2=B12.81% x26 ->  XXX =C2=B12.10% x26         d=3D-3.=
59% =C2=B12.45%       p=3D0.00%
 warsow/benchsow:                                                          =
              XXX =C2=B10.61% x26 ->  XXX =C2=B11.41% x27         d=3D-2.45=
% =C2=B11.07%       p=3D0.00%
 synmark/OglTerrainFlyInst:                                                =
              XXX =C2=B10.44% x25 ->  XXX =C2=B10.74% x25         d=3D-1.24=
% =C2=B10.60%       p=3D0.00%

There are some things we might be able to do to get some of the
additional improvement we can see above without hurting
latency-sensitive workloads, but it's going to take more effort, the
present approach of using the dual-ELSP utilization seems like a good
compromise to me for starters.

>[...]

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXm/nhAAKCRCDmTidfVK/
W+mgAP9pnhAvLhgEBIpq9WrGKudZ96NiUo26cGioSAMMXkweSQD+KhCmK6fQg9Sf
o7RPzJtoZEU1pp1MCyzIV2WHXFajaVc=
=DMcu
-----END PGP SIGNATURE-----
--==-=-=--
