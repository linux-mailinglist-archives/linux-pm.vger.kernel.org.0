Return-Path: <linux-pm+bounces-31709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF547B1777B
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 22:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FFB5883D5
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 20:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A3021D584;
	Thu, 31 Jul 2025 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=viasat.com header.i=@viasat.com header.b="JEj7nAXD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0e-0085b301.gpphosted.com (mx0e-0085b301.gpphosted.com [67.231.147.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D3120B22;
	Thu, 31 Jul 2025 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.147.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995511; cv=none; b=c75R8hB+fN2XbMxl4S1ZzvVvZAsQ6PKyNUO+TAiFsgsOGXmbFCc/IHteSTIEh4pUWqKVVubm2xq4Sqk409/FqTfr7/uReVFEwZa6Jlo+mm3M3TGbSzoq0h1SkdXctmXJSBpde5E36mGQ6UYgK5Xy+FmTQG+SF4QQFbUVpjgS6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995511; c=relaxed/simple;
	bh=zlH0RfC76DhvbnUaV2GPtwg3u0KKc/8zibG7tbyBxZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bdc+KOiilUTDu87Wkf77WAKyvAba0bvNAPBfh6Cdb2DHH2KDfe+h2qbw2q26FJtErLgxhvz/Ym8DLworozs3+ZWUWQj/1QXLiLAZzK0mMK2z6830x4m5p/JtmGCC5AXtqVSHoLKtCAXdkZoeD6A84gVgEA9FEjARth1l4w5SPGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=viasat.com; spf=pass smtp.mailfrom=viasat.com; dkim=pass (2048-bit key) header.d=viasat.com header.i=@viasat.com header.b=JEj7nAXD; arc=none smtp.client-ip=67.231.147.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=viasat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=viasat.com
Received: from pps.filterd (m0351329.ppops.net [127.0.0.1])
	by mx0e-0085b301.gpphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VJgaKB006710;
	Thu, 31 Jul 2025 20:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=viasat.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2y4disjWUjWYFrysJhW0zowUF5MQL9jLgrMDCcueTZg=;
 b=JEj7nAXD1WoQEDwpGXSakQplDvohZfFYYtlkfQqfN+EwsliHaOriTEC7vZmeLQByPOTI
 3H5EPMMSS6fDDGkpCmmSDriufBHmxuKBbuczQG598phEq2JCEponPDZuMEYrAGgJ6+ZR
 yfxZLDKwjTIn4W246ZdyOA1hHEyOe5KaAVYKC10K10ov1YrzYaHJ9A7xx1gARFNGpPQc
 zx7afkPRT4s70d7bdpfg8AFle+sJbxUKAQZJROaeP7rWDcZnmH2294uTmKTlBJ/+CNRv
 WbRYSflB+kooXsTlQcUGjyAz7VHi0H51gR1JNhR1JCNzkalrWzQcb967gnq5EkGcP0jB BA== 
Received: from wdc1exchp03.hq.corp.viasat.com ([8.37.104.42])
	by mx0e-0085b301.gpphosted.com (PPS) with ESMTPS id 488esu0c19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 31 Jul 2025 20:44:04 +0000
Received: from WDC1EXCHP05.hq.corp.viasat.com (10.228.7.145) by
 WDC1EXCHP03.hq.corp.viasat.com (10.228.7.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Jul 2025 14:44:03 -0600
Received: from WDC1EXCHP05.hq.corp.viasat.com ([fe80::e59e:1518:91aa:55e9]) by
 WDC1EXCHP05.hq.corp.viasat.com ([fe80::e59e:1518:91aa:55e9%14]) with mapi id
 15.01.2507.039; Thu, 31 Jul 2025 14:44:02 -0600
From: "Jones, Morgan" <Morgan.Jones@viasat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Heusel
	<christian@heusel.eu>
CC: Mario Limonciello <mario.limonciello@amd.com>,
        Sasha Levin
	<sashal@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Arcari
	<darcari@redhat.com>,
        Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>,
        "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
        "perry.yuan@amd.com" <perry.yuan@amd.com>,
        "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>,
        "li.meng@amd.com" <li.meng@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Linux kernel regressions list
	<regressions@lists.linux.dev>
Subject: RE: [EXTERNAL] Re: linux-6.6.y regression on amd-pstate
Thread-Topic: [EXTERNAL] Re: linux-6.6.y regression on amd-pstate
Thread-Index: AQHbAfgjMcfsLm0RPUe9mEZa119bzrJOUuoAgAAExwCCAFqV0A==
Date: Thu, 31 Jul 2025 20:44:02 +0000
Message-ID: <534cb3af86bd4371800ebfb3035382c2@viasat.com>
References: <66f08ce529d246bd8315c87fe0f880e6@viasat.com>
 <645f2e77-336b-4a9c-b33e-06043010028b@amd.com>
 <2e36ee28-d3b8-4cdb-9d64-3d26ef0a9180@amd.com>
 <d6477bd059df414d85cd825ac8a5350d@viasat.com>
 <d6808d8e-acaf-46ac-812a-0a3e1df75b09@amd.com>
 <7f50abf9-e11a-4630-9970-f894c9caee52@amd.com>
 <f9085ef60f4b42c89b72c650a14db29c@viasat.com>
 <be2d96b0-63a6-42ea-a13b-1b9cf7f04694@amd.com>
 <2024090834-hull-unbalance-ca6b@gregkh>
 <2ffb55e3-6752-466a-b06b-98c324a8d3cc@heusel.eu>
 <2024090825-clarity-cofounder-5c79@gregkh>
In-Reply-To: <2024090825-clarity-cofounder-5c79@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: rNIW7h3nN3UqglVKc0s-xxVSD8karOTt
X-Proofpoint-GUID: rNIW7h3nN3UqglVKc0s-xxVSD8karOTt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDE1MCBTYWx0ZWRfX4nN+1EmU7bN/ dYErwNdOvfXw7lZvRoN7AHOlEQUGKNWWPDmS0p7XFmnGvSVp5FlFCdStZG1zOi/yTDvrkrHBgID 8xwVsReQgIUZkWOjAKtSSgZhl/I57dNQtNwfT6UU151q3zhmOP/+/yJdGJKMcSY29lvu9EMfK6a
 WdG4cRMs/8j0r+4W/8PhOrW1soGZX5BCuQSTqXv0I5gvZGwH1nmcd2IqggDmR9JfChDDM9bjHe1 9YJagsNud5tqJocYZrxEtCS+giU57CMigOM0rDCx0M7F81f0fywO/74IcuThJia/+HSc64TybwE 9/SoNzSKORUTlU/aIK8+XiNOhA0WJcOcaQezc51OONhFjFlMjsXF+P6c2VmkaTkxK/1eiFkcZRg UhTzXLFH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507310150

Hey all,

I think some form of this is back between 6.12 and 6.15 on our fractious AM=
D EPYC 7702. The symptom appears to be that the core will not boost past 2 =
GHz (the nominal frequency), so we lose out on 1.36 GHz of boost frequency.=
 Downgrade from 6.15.7 to LTS (6.12.39) seems to fix it.

Keeping an eye out for other threads reporting similar symptoms on recent k=
ernels:

[    0.000000] Linux version 6.15.7-xanmod1 (nixbld@localhost) (gcc (GCC) 1=
4.2.1 20250322, GNU ld (GNU Binutils) 2.44) #1-NixOS SMP PREEMPT_DYNAMIC Tu=
e Jan  1 00:00:00 UTC 1980

# cat /proc/cmdline
[snip] amd_pstate=3Dactive amd_prefcore=3Denable amd_pstate.shared_mem=3D1

# cat /proc/cpuinfo
[snip]
processor       : 127
vendor_id       : AuthenticAMD
cpu family      : 23
model           : 49
model name      : AMD EPYC 7702 64-Core Processor
stepping        : 0
microcode       : 0x830107d
cpu MHz         : 400.000
cache size      : 512 KB
physical id     : 0
siblings        : 128
core id         : 63
cpu cores       : 64
apicid          : 127
initial apicid  : 127
fpu             : yes
fpu_exception   : yes
cpuid level     : 16
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe=
1gb rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid extd_a=
picid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 mo=
vbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_leg=
acy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext per=
fctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate s=
sbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdse=
ed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc c=
qm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbn=
oinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushb=
yasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spe=
c_ctrl umip rdpid overflow_recov succor smca sev sev_es
bugs            : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass r=
etbleed smt_rsb srso ibpb_no_ret
bogomips        : 3992.75
TLB size        : 3072 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 43 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

# cpupower frequency-info
analyzing CPU 76:
  driver: amd-pstate-epp
  CPUs which run at the same hardware frequency: 76
  CPUs which need to have their frequency coordinated by software: 76
  energy performance preference: performance
  hardware limits: 408 MHz - 3.36 GHz
  available cpufreq governors: performance powersave
  current policy: frequency should be within 1.51 GHz and 3.36 GHz.
                  The governor "performance" may decide which speed to use
                  within this range.
  current CPU frequency: 1.98 GHz (asserted by call to kernel)
  boost state support:
    Supported: yes
    Active: yes
  amd-pstate limits:
    Highest Performance: 255. Maximum Frequency: 3.36 GHz.
    Nominal Performance: 152. Nominal Frequency: 2.00 GHz.
    Lowest Non-linear Performance: 115. Lowest Non-linear Frequency: 1.51 G=
Hz.
    Lowest Performance: 31. Lowest Frequency: 400 MHz.
    Preferred Core Support: 0. Preferred Core Ranking: 255.

Regards,
Morgan

-----Original Message-----
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>=20
Sent: Sunday, September 8, 2024 7:30 AM
To: Christian Heusel <christian@heusel.eu>
Cc: Mario Limonciello <mario.limonciello@amd.com>; Jones, Morgan <Morgan.Jo=
nes@viasat.com>; Sasha Levin <sashal@kernel.org>; linux-pm@vger.kernel.org;=
 linux-kernel@vger.kernel.org; David Arcari <darcari@redhat.com>; Dhananjay=
 Ugwekar <Dhananjay.Ugwekar@amd.com>; rafael@kernel.org; viresh.kumar@linar=
o.org; gautham.shenoy@amd.com; perry.yuan@amd.com; skhan@linuxfoundation.or=
g; li.meng@amd.com; ray.huang@amd.com; stable@vger.kernel.org; Linux kernel=
 regressions list <regressions@lists.linux.dev>
Subject: [EXTERNAL] Re: linux-6.6.y regression on amd-pstate

On Sun, Sep 08, 2024 at 04:12:28PM +0200, Christian Heusel wrote:
> Hey Greg,
>=20
> On 24/09/08 04:05PM, Greg Kroah-Hartman wrote:
> > On Thu, Sep 05, 2024 at 04:14:26PM -0500, Mario Limonciello wrote:
> > > + stable
> > > + regressions
> > > New subject
> > >=20
> > > Great news.
> > >=20
> > > Greg, Sasha,
> > >=20
> > > Can you please pull in these 3 commits specifically to 6.6.y to=20
> > > fix a regression that was reported by Morgan in 6.6.y:
> > >=20
> > > commit 12753d71e8c5 ("ACPI: CPPC: Add helper to get the highest=20
> > > performance
> > > value")
> >=20
> > This is fine, but:
> >=20
> > > commit ed429c686b79 ("cpufreq: amd-pstate: Enable amd-pstate=20
> > > preferred core
> > > support")
> >=20
> > This is not a valid git id in Linus's tree :(
>=20
> f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core=20
> support")
>=20
> >=20
> > > commit 3d291fe47fe1 ("cpufreq: amd-pstate: fix the highest=20
> > > frequency issue which limits performance")
> >=20
> > And neither is this :(
>=20
> bf202e654bfa ("cpufreq: amd-pstate: fix the highest frequency issue=20
> which limits performance")
>=20
> > So perhaps you got them wrong?
>=20
> I have added the ID's of the matching commits from Linus' tree above!=20
> :)
>=20

Thanks, that works, all now queued up.

greg k-h

