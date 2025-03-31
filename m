Return-Path: <linux-pm+bounces-24664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F217AA76DE3
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 22:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3A0188CB68
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 20:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30A02144D6;
	Mon, 31 Mar 2025 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mwRI0wn0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6975E1C5D7A;
	Mon, 31 Mar 2025 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451470; cv=none; b=CMukNL1smCvU7HrpAlyuPb+GFeJbvvMVkLdPK2AkDBm35puWrB89sPoG7v1xeer7Q2R1ZiQdnSLPUn+QbzLl2bLX7DSsDgEBNbPieARuFN9IvOTAJ4ehB6lvquW4d54jjB0d40bX7mYTIijwUISKF8pXamOE8Og99AlIYGkYaXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451470; c=relaxed/simple;
	bh=8mhciQk3HNzOogA+iAMRW1adL+y5/80yE1gAmrwRiys=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GYCPNrrC/jwkZx0L3WyNdVWo0IfVI4hgHqZ3ALqbs4eX/tj0nU1ZwjmGVxCVmDyRuOLbdXLbR+bqtKIxN5hue7Uza5QH8Qihe/OBNo7O9rUcGMzbqiPqf2HgW7TuYHbALpC2PTy3Rf0aoGiKa0x7j7gbbAjB4YYtDE7cLsg4Gx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=mwRI0wn0; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52VK3rrW3400773
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 31 Mar 2025 13:03:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52VK3rrW3400773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1743451434;
	bh=v8U0XHZi6lxT6tv6Qcq2KDfmB1yuIr305PlMO2qKFKc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=mwRI0wn0fINax6NVfzvYht9qPRyoDSv9oOrViwt3WMotoBTOjVSwStshBNClUQy7W
	 eM9pJ2kJ2Hr+3pARrY8BN9lKlPbmK4HEefOsy5MrmAeYJqnnvJ0xU/Pf8MlwDhlnGT
	 +JIeXZrZbINeO7yXdZlYVv93+dnrN0nKcOWN3wnFiO0/4l1tqiOUSl5UUJYG/8Ulcl
	 63E2yIUXdQm5rkGEgPU10B48rIXle8ZXOFGexXCsnrDNWrRlfHf/G0zy6Tj5gGgFn4
	 o1SQmMUMhdR3iglmXd/XcR2BttcrLBpVx7ghN4rT/mXWj0K5elzjn/dHRDaB8r+und
	 7T1usmLHHFk2Q==
Date: Mon, 31 Mar 2025 13:03:51 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, "Xin Li (Intel)" <xin@zytor.com>
CC: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, rafael@kernel.org, pavel@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, xi.pardee@intel.com,
        todd.e.brandt@intel.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/1=5D_x86/fred=3A_Fix_system?=
 =?US-ASCII?Q?_hang_during_S4_resume_with_FRED_enabled?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJZ5v0jfak9K_7b=adf5ew-xDiGHUEPSp5ZpAGt66Okj-ovsGQ@mail.gmail.com>
References: <20250326062540.820556-1-xin@zytor.com> <CAJZ5v0jfak9K_7b=adf5ew-xDiGHUEPSp5ZpAGt66Okj-ovsGQ@mail.gmail.com>
Message-ID: <148C8753-8972-4970-8951-E2D1CB26D8B0@zytor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 31, 2025 8:30:49 AM PDT, "Rafael J=2E Wysocki" <rafael@kernel=2Eor=
g> wrote:
>On Wed, Mar 26, 2025 at 7:26=E2=80=AFAM Xin Li (Intel) <xin@zytor=2Ecom> =
wrote:
>>
>> During an S4 resume, the system first performs a cold power-on=2E  The
>> kernel image is initially loaded to a random linear address, and the
>> FRED MSRs are initialized=2E  Subsequently, the S4 image is loaded,
>> and the kernel image is relocated to its original address from before
>> the S4 suspend=2E  Due to changes in the kernel text and data mappings,
>> the FRED MSRs must be reinitialized=2E
>
>To be precise, the above description of the hibernation control flow
>doesn't exactly match the code=2E
>
>Yes, a new kernel is booted upon a wakeup from S4, but this is not "a
>cold power-on", strictly speaking=2E  This kernel is often referred to
>as the restore kernel and yes, it initializes the FRED MSRs as
>appropriate from its perspective=2E
>
>Yes, it loads a hibernation image, including the kernel that was
>running before hibernation, often referred to as the image kernel, but
>it does its best to load image pages directly into the page frames
>occupied by them before hibernation unless those page frames are
>currently in use=2E  In that case, the given image pages are loaded into
>currently free page frames, but they may or may not be part of the
>image kernel (they may as well belong to user space processes that
>were running before hibernation)=2E  Yes, all of these pages need to be
>moved to their original locations before the last step of restore,
>which is a jump into a "trampoline" page in the image kernel, but this
>is sort of irrelevant to the issue at hand=2E
>
>At this point, the image kernel has control, but the FRED MSRs still
>contain values written to them by the restore kernel and there is no
>guarantee that those values are the same as the ones written into them
>by the image kernel before hibernation=2E  Thus the image kernel must
>ensure that the values of the FRED MSRs will be the same as they were
>before hibernation, and because they only depend on the location of
>the kernel text and data, they may as well be recomputed from scratch=2E
>
>> Reported-by: Xi Pardee <xi=2Epardee@intel=2Ecom>
>> Reported-and-Tested-by: Todd Brandt <todd=2Ee=2Ebrandt@intel=2Ecom>
>> Suggested-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>> Signed-off-by: Xin Li (Intel) <xin@zytor=2Ecom>
>> Cc: stable@kernel=2Eorg # 6=2E9+
>> ---
>>  arch/x86/power/cpu=2Ec | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/x86/power/cpu=2Ec b/arch/x86/power/cpu=2Ec
>> index 63230ff8cf4f=2E=2Eef3c152c319c 100644
>> --- a/arch/x86/power/cpu=2Ec
>> +++ b/arch/x86/power/cpu=2Ec
>> @@ -27,6 +27,7 @@
>>  #include <asm/mmu_context=2Eh>
>>  #include <asm/cpu_device_id=2Eh>
>>  #include <asm/microcode=2Eh>
>> +#include <asm/fred=2Eh>
>>
>>  #ifdef CONFIG_X86_32
>>  __visible unsigned long saved_context_ebx;
>> @@ -231,6 +232,21 @@ static void notrace __restore_processor_state(stru=
ct saved_context *ctxt)
>>          */
>>  #ifdef CONFIG_X86_64
>>         wrmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
>> +
>> +       /*
>> +        * Restore FRED configs=2E
>> +        *
>> +        * FRED configs are completely derived from current kernel text=
 and
>> +        * data mappings, thus nothing needs to be saved and restored=
=2E
>> +        *
>> +        * As such, simply re-initialize FRED to restore FRED configs=
=2E
>
>Instead of the above, I would just say "Reinitialize FRED to ensure
>that the FRED registers contain the same values as before
>hibernation=2E"
>
>> +        *
>> +        * Note, FRED RSPs setup needs to access percpu data structures=
=2E
>
>And I'm not sure what you wanted to say here?  Does this refer to the
>ordering of the code below or to something else?
>
>> +        */
>> +       if (ctxt->cr4 & X86_CR4_FRED) {
>> +               cpu_init_fred_exceptions();
>> +               cpu_init_fred_rsps();
>> +       }
>>  #else
>>         loadsegment(fs, __KERNEL_PERCPU);
>>  #endif
>> --
>

Just to make it clear: the patch is correct, the shortcoming is in the des=
cription=2E=20

I would say that Xin's description, although perhaps excessively brief, is=
 correct from the *hardware* point of view, whereas Rafael adds the much ne=
eded *software* perspective=2E=20

As far as hardware is concerned, Linux S4 is just a power on (we don't use=
 any BIOS support for S4 even if it exists, which it rarely does anymore, a=
nd for very good reasons=2E) From a software point of view, it is more like=
 a kexec into the frozen kernel image, which then has to re-establish its r=
untime execution environment =E2=80=93 (including the FRED state, which is =
what this patch does=2E)

For the APs this is done through the normal AP bringup mechanism, it is on=
ly the BSP that needs special treatment=2E

