Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7012259DF8
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 20:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIAST2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 14:19:28 -0400
Received: from mx1.riseup.net ([198.252.153.129]:50938 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgIAST0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Sep 2020 14:19:26 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4BgwMK4vDkzDt06;
        Tue,  1 Sep 2020 11:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1598984365; bh=8bbfyLRVXRS+C1h8N/3tBO2t8FrkmWypaur/OE5pmDg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=o0JLY2K250hmFNz+jutkOAbbso+5PAKddL6tTDMGg8VvZ/9P/lcpmxCBbNOZ/wv+D
         RXy8sxiIJdG0HiAZ+ORzZyWWwCgWBlIrm1xaa3Ma/WhLVB8mUDe3QqR0X34ZjBQMHA
         WBHEpMVoojkp2kGR5n5DBtKlRuae3XW4NVXk+o0U=
X-Riseup-User-ID: 86341624FE01BF9067C593EFF0B85E38032EEA6791905943E283E4E30F06EC5D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 4BgwMK2lVpzJnv9;
        Tue,  1 Sep 2020 11:19:25 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Caleb Callaway <caleb.callaway@intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix intel_pstate_get_hwp_max() for turbo disabled cases.
In-Reply-To: <81b98c58eab0bf075d9ded2154a7a88020628c80.camel@linux.intel.com>
References: <20200901030250.495928-1-currojerez@riseup.net> <81b98c58eab0bf075d9ded2154a7a88020628c80.camel@linux.intel.com>
Date:   Tue, 01 Sep 2020 11:19:22 -0700
Message-ID: <87k0xdwead.fsf@riseup.net>
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

> On Mon, 2020-08-31 at 20:02 -0700, Francisco Jerez wrote:
>> This fixes the behavior of the scaling_max_freq and scaling_min_freq
>> sysfs files in systems which had turbo disabled by the BIOS.
>>=20
>> Caleb noticed that the HWP is programmed to operate in the wrong
>> P-state range on his system when the CPUFREQ policy min/max frequency
>> is set via sysfs.  This seems to be because in his system
>> intel_pstate_get_hwp_max() is returning the maximum turbo P-state
>> even
>> though turbo was disabled by the BIOS, which causes intel_pstate to
>> scale kHz frequencies incorrectly e.g. setting the maximum turbo
>> frequency whenever the maximum guaranteed frequency is requested via
>> sysfs.
>
> When  turbo is disabled via MSR_IA32_MISC_ENABLE_TURBO_DISABLE (From
> BIOS), then no matter what we write to HWP. max, the hardware will clip
> to HWP_GUARANTEED_PERF.
>
> But it looks like this is some issue on properly disabling turbo from
> BIOS, since you observe turbo frequencies (via aperf, mperf) not just
> sysfs display issue.
>

Caleb should be able to confirm that, but my understanding is that his
system was still clocking up to the max turbo frequency despite turbo
being disabled in the BIOS and the maximum guaranteed frequency having
been specified in scaling_max_freq.

However there is a bug even in systems where the clipping you describe
is working correctly, the conversion from kHz frequency to P-state uses
a bogus scaling factor without this patch applied.

>
>
>>=20
>> Tested-by: Caleb Callaway <caleb.callaway@intel.com>
>> Signed-off-by: Francisco Jerez <currojerez@riseup.net>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>

Thanks!

>> ---
>>  drivers/cpufreq/intel_pstate.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/cpufreq/intel_pstate.c
>> b/drivers/cpufreq/intel_pstate.c
>> index e0220a6fbc69..7eb7b62bd5c4 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -825,7 +825,7 @@ static void intel_pstate_get_hwp_max(unsigned int
>> cpu, int *phy_max,
>>=20=20
>>  	rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
>>  	WRITE_ONCE(all_cpu_data[cpu]->hwp_cap_cached, cap);
>> -	if (global.no_turbo)
>> +	if (global.no_turbo || global.turbo_disabled)
>>  		*current_max =3D HWP_GUARANTEED_PERF(cap);
>>  	else
>>  		*current_max =3D HWP_HIGHEST_PERF(cap);

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCX06QqgAKCRCDmTidfVK/
W1TKAQCg6FjTCBf5TM7UlxUVSScFuLWu1gVie00CRB6cIisP9wD+PL0Jr7MSdxp+
qNFZTUgfYtiIVnqWJo+1f+fi4u87P4o=
=BDjN
-----END PGP SIGNATURE-----
--==-=-=--
