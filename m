Return-Path: <linux-pm+bounces-43934-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDO2JkaTrmmmGQIAu9opvQ
	(envelope-from <linux-pm+bounces-43934-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 10:30:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A91B2362F6
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 10:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD747301A50C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 09:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCE330F927;
	Mon,  9 Mar 2026 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="N9REWVPV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD41029B781;
	Mon,  9 Mar 2026 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048643; cv=none; b=TJLRZydx/25y+OrJQ1wFF+pwYchHJ4yQUTQeiP4J3DuF4ztdFFnzpUdZVvERqtEBLBBPXCKtn7ionfcQreKFOPuKDTS8sM32gUTPnkZ01HQvG7xETqaCoQy6s0n1y0TD0lxMTzvSQ2BFsYKJorLh845a6BxhGG2+2VydSohkW/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048643; c=relaxed/simple;
	bh=LfXiAGYAS1UFUbtHFhsqKW50BwyTvgo3D/H4jH3qHsg=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=Erk8C467+MBrRIJHuhbUmaDzOzjNa6LZvoCNt3nwaF5IBr0grV472ocrrjW7iWUJeccVgOwC9Bzd/GlvF9SUh1c2x91/3dV8GLkXFlVvVDd1V6RhO/uPD0wLfVLx6jf7CvmnSuisHHbnLrirwNoC7hjrT9KlCjoXMfmPze4Uokw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=N9REWVPV; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=5542c7fda1=ms@dev.tdt.de>)
	id 1vzWwc-00FOxB-92; Mon, 09 Mar 2026 10:30:34 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1vzWwb-00CUOE-NA; Mon, 09 Mar 2026 10:30:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1773048633;
	bh=8tcP9tvNZED+wwwnP5t4F7XTNySr9VR/Gz86McrrXNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N9REWVPVX8BPemzJIHiNoSOTJLMEypkt5358LiBx52oHMrzvm34BV9U6LJMWYLjiE
	 TC4jhFGTFZ0VKhwEk+SwSKLxz0vcQN7LxVE/yBojYi7kFqJ8XzfM+Ofqw7KyRLL83L
	 t4wB2IkleZbLtOPK6mXd+34i3IWhMhnlGg9ZPKpF+vRxZzimrWId4E+Zc1Wt2SYBE5
	 hetcFHPWk8miC4nIev7Ee+YrFwNg/fekmXY64S8etVpsBWS42cAaO8eNGfyaL4Vcq2
	 6qlI9/0e/zRDC6HRAXLvVx5BHnPBv/pYR9O+mBkoeXPgp4kj81fTodoXJv5hzY697u
	 K/5ik+OKb0usQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 48FF9240041;
	Mon,  9 Mar 2026 10:30:33 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 2DF65240036;
	Mon,  9 Mar 2026 10:30:33 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id B64ED22A28;
	Mon,  9 Mar 2026 10:30:24 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 09 Mar 2026 10:30:24 +0100
From: Martin Schiller <ms@dev.tdt.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH 2/2] x86/cpu/intel: Add EIST workaround for Lightning
 Mountain.
Organization: TDT AG
In-Reply-To: <ffb7e798-e8c7-4728-b699-6c885be61136@intel.com>
References: <20260306-cpufreq_lgm-v1-0-47f104aed7c2@dev.tdt.de>
 <20260306-cpufreq_lgm-v1-2-47f104aed7c2@dev.tdt.de>
 <ffb7e798-e8c7-4728-b699-6c885be61136@intel.com>
Message-ID: <de11475f9544847664dcce44747c5b50@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate-ID: 151534::1773048634-F2710836-29C281B2/0/0
X-purgate: clean
X-Rspamd-Queue-Id: 1A91B2362F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tdt.de,none];
	R_DKIM_ALLOW(-0.20)[dev.tdt.de:s=z1-selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[dev.tdt.de:+];
	TAGGED_FROM(0.00)[bounces-43934-lists,linux-pm=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,dev.tdt.de:dkim,dev.tdt.de:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ms@dev.tdt.de,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-03-06 17:54, Dave Hansen wrote:
> So what's weird about these systems? Do they not have a "normal" BIOS
> based on the Intel reference one?

That's right, the Lightning Mountain SoC is an x86 (Atom) system, but
it doesn't have a classic BIOS.


> I don't know much about this specific feature, but this patch is doing
> some unusual things. I'll elaborate below:
>=20
>> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
>> index=20
>> 98ae4c37c93eccf775d5632acf122603a19918a8..e49df04e8d491158cc48f8d8bef8=
24c434256d09=20
>> 100644
>> --- a/arch/x86/kernel/cpu/intel.c
>> +++ b/arch/x86/kernel/cpu/intel.c
>> @@ -466,6 +466,29 @@ static void intel_workarounds(struct cpuinfo_x86=20
>> *c)
>>  #else
>>  static void intel_workarounds(struct cpuinfo_x86 *c)
>>  {
>> +	u64 misc_enable;
>> +
>> +	/*
>> +	 * Intel / MaxLinear Lightning Mountain workaround to enable=20
>> Enhanced
>> +	 * Intel SpeedStep Technology (EIST) for each cpu. Otherwise, the
>> +	 * frequency on some cpus is locked to the minimum value of 624 MHz.
>> +	 * This usually would be the job of the BIOS / bootloader, but=20
>> U-Boot
>> +	 * only enables it on the cpu on which it is running.
>> +	 */
>> +	if (c->x86_vfm =3D=3D INTEL_ATOM_AIRMONT_NP) {
>=20
> Model checks area kinda a last resort. A quick search in the SDM found:
>=20
> CPUID.01H:ECX[7]: If 1, supports Enhanced Intel SpeedStep=C2=AE technol=
ogy.
>=20
> But there's other chit chat in the "Runtime Mutable CPUID Fields"
> section that makes it seem that it's not a really feature enumeration
> bit, but a flag to tell if the BIOS enabled it:
>=20
> 	CPUID.01H:ECX[7] -- This feature flag reflects the setting in
> 			    IA32_MISC_ENABLE[16]
>=20
> But the plot thickens because the *existing* code does this:
>=20
> static int centrino_cpu_init(struct cpufreq_policy *policy)
> {
> ...
>         /* Only Intel makes Enhanced Speedstep-capable CPUs */
>         if (cpu->x86_vendor !=3D X86_VENDOR_INTEL ||
>             !cpu_has(cpu, X86_FEATURE_EST))
>                 return -ENODEV;
> ...
>         if (!(l & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
>=20
> Which, again, makes it seem like X86_FEATURE_EST (aka.=20
> CPUID.01H:ECX[7])
> tells you if the MSR bit is supported, not whether it is enabled.
>=20
> I'd tend to trust the existing kernel code over quibbling with the SDM
> wording in general. It's also possible the old code was just confused=20
> or
> something was buggy.
>=20
>> +		rdmsrq(MSR_IA32_MISC_ENABLE, misc_enable);
>> +		if (!(misc_enable & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
>> +			misc_enable |=3D MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP;
>> +			wrmsrq(MSR_IA32_MISC_ENABLE, misc_enable);
>> +
>> +			/* check to see if it was enabled successfully */
>> +			rdmsrq(MSR_IA32_MISC_ENABLE, misc_enable);
>> +			if (!(misc_enable & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
>> +				pr_info("CPU%d: Can't enable Enhanced SpeedStep\n",
>> +					c->cpu_index);
>> +			}
>> +		}
>> +	}
>>  }
>=20
>=20
> This is also not written in the normal kernel style which minimizes
> indentation. For instance, the function should have opened with:
>=20
> 	if (c->x86_vfm !=3D INTEL_ATOM_AIRMONT_NP)
> 		return;
>=20
> It also needs to be reconciled with centrino_cpu_init() (at least).
> Having *a* single place to go in and say "If this CPU supports 'EST',
> turn it on" would be a minimal refactoring that could be shared by your
> new workaround and the old centrino code.
>=20
> centrino_cpu_init() does look gated on X86_FEATURE_EST already, though
> because of the centrino_ids[]. So, you still need to figure out the
> interaction with X86_FEATURE_EST for when you call the workaround.

As you already noted, EIST is also enabled in the Intel Enhanced
SpeedStep (deprecated) "speedstep-centrino.c" driver. It is also
enabled in the VIA C7 Enhanced PowerSaver driver "e_powersaver.c".

The question now is whether and where this is best handled centrally.

