Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 788DF180ECA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 04:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgCKDz0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 23:55:26 -0400
Received: from mx1.riseup.net ([198.252.153.129]:34478 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbgCKDz0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Mar 2020 23:55:26 -0400
Received: from capuchin.riseup.net (unknown [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48cdQj3s2yzFdkR;
        Tue, 10 Mar 2020 20:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1583898925; bh=Vd8ynTqGkO7zn+1w3D/vFfIX4SLKM0rZ+1nK/8EbJHQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HmbkcEK1DXAfNjcAGqGGJH5228y3F2k08oJxkSRl7let0BV10OaDM1odrAYjJSJGL
         rBk4bZcatltgUA+ENqecnurpwBgt3i0KGQjz34lbaqBaTgdhNumXkRVWFL933+R/qG
         2k0jE92T0wAERH9L7kg3S41uskar3wo8YH8E5epA=
X-Riseup-User-ID: C934A8A71355FA8D1E2446A4D002ED00385A4F3F25861A30A461B1BF5D8ED8A1
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 48cdQh6S7xz8tjR;
        Tue, 10 Mar 2020 20:55:24 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-pm\@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "intel-gfx\@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Cc:     "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "rjw\@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [RFC] GPU-bound energy efficiency improvements for the intel_pstate driver (v2).
In-Reply-To: <b8a09ef0c52dd02954b43b441dc3d1612837138c.camel@intel.com>
References: <20200310214203.26459-1-currojerez@riseup.net> <b8a09ef0c52dd02954b43b441dc3d1612837138c.camel@intel.com>
Date:   Tue, 10 Mar 2020 20:55:24 -0700
Message-ID: <87imjba6kz.fsf@riseup.net>
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

"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com> writes:

> On Tue, 2020-03-10 at 14:41 -0700, Francisco Jerez wrote:
>>=20
>
> [...]
>
>> Thanks in advance for any review feed-back and test reports.
>>=20
>> [PATCH 01/10] PM: QoS: Add CPU_RESPONSE_FREQUENCY global PM QoS
>> limit.
>> [PATCH 02/10] drm/i915: Adjust PM QoS response frequency based on GPU
>> load.
>> [PATCH 03/10] OPTIONAL: drm/i915: Expose PM QoS control parameters
>> via debugfs.
>> [PATCH 04/10] Revert "cpufreq: intel_pstate: Drop ->update_util from
>> pstate_funcs"
>> [PATCH 05/10] cpufreq: intel_pstate: Implement VLP controller
>> statistics and status calculation.
>> [PATCH 06/10] cpufreq: intel_pstate: Implement VLP controller target
>> P-state range estimation.
>> [PATCH 07/10] cpufreq: intel_pstate: Implement VLP controller for HWP
>> parts.
>> [PATCH 08/10] cpufreq: intel_pstate: Enable VLP controller based on
>> ACPI FADT profile and CPUID.
>> [PATCH 09/10] OPTIONAL: cpufreq: intel_pstate: Add tracing of VLP
>> controller status.
>> [PATCH 10/10] OPTIONAL: cpufreq: intel_pstate: Expose VLP controller
>> parameters via debugfs.
>>=20
> Do you have debug patch (You don't to submit as a patch), which will
> allow me to dynamically disable/enable all these changes? I want to
> compare and do some measurements.
>

Something like this (fully untested) patch?  It should prevent the VLP
controller from running if you do:

echo 16 > /sys/kernel/debug/pstate_snb/lp_debug

> Thanks,
> Srinivas=20
>
>>[...]


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=0001-DEBUG.patch
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ab893a211746..8749b4a14447 100644
=2D-- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2411,6 +2411,9 @@ static void intel_pstate_update_util(struct update_ut=
il_data *data, u64 time,
 static void intel_pstate_update_util_hwp_vlp(struct update_util_data *data,
 					     u64 time, unsigned int flags)
 {
+	if ((vlp_params.debug & 16))
+		return;
+
 	struct cpudata *cpu =3D container_of(data, struct cpudata, update_util);
=20
 	if (update_vlp_sample(cpu, time, flags)) {

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXmhhLAAKCRCDmTidfVK/
W1UqAP9n4Er2AUWSyYt9uHJEFfyHoFxRMy051/UzUeI0HMdVKwD/arovB95PUmru
7PfUKIofPB5+hacyyY/8WDYafVTqCZI=
=3QE1
-----END PGP SIGNATURE-----
--==-=-=--
