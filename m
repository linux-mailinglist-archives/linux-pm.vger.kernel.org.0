Return-Path: <linux-pm+bounces-16578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 928D09B31E5
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 14:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168411F2298C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 13:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2221DB54B;
	Mon, 28 Oct 2024 13:41:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296A31DB92A;
	Mon, 28 Oct 2024 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122870; cv=none; b=Pvuk9/xGHDxjKJZjxk6Md8lBLoOU0bLHc/m2pHctZTaC+Hbgba0v415lgubDOsgNLvS7QpiAlfNgc3N3dpPe55UIToaRoPogV7ejcQY1gadinJukM7/XcSGZ7LrNjZ/djlR59kcq+kipT0umdeZf1Q7DFAHk+pfuZYYJuMgn/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122870; c=relaxed/simple;
	bh=1kpE9N/yLjsniPNUsDc3/KUTxIkiLgOuR1PoRUVV0F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njmx/JeefXkHstKEoBIcAgrALrZIU77bOKwyjOeTB/vdhaVeq5DVKiexDqQXwyx8dgZG+l7xOk/GiB4wz8eC5uJVfLW6+U8v8Mx/ZVozZfhT1V12RGCdzFfVTpyh1hhe7eXFzSl5FmZUKy6FcYgL05KudVSG5y4Cz6O0ILbK/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56087497;
	Mon, 28 Oct 2024 06:41:37 -0700 (PDT)
Received: from [10.57.57.215] (unknown [10.57.57.215])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49CC93F66E;
	Mon, 28 Oct 2024 06:41:06 -0700 (PDT)
Message-ID: <96d1f356-b36b-4c14-bdd5-c38836bac418@arm.com>
Date: Mon, 28 Oct 2024 13:42:19 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 0/2] arm64: dts: renesas: Re-add voltages to OPP
 tables
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <cover.1728377971.git.geert+renesas@glider.be>
 <CAMuHMdXsmAqQL+2+D_y+u1z4nn8JO+xF-mq6wWJ0pAH58n5Wiw@mail.gmail.com>
 <b273599f-8653-4e98-ac64-09c91b0a1592@arm.com>
 <CAMuHMdUYnTRDHRdWYHBdJ3hNBKOXBtRMOsu1NiJFET7P-+zc4g@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAMuHMdUYnTRDHRdWYHBdJ3hNBKOXBtRMOsu1NiJFET7P-+zc4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/28/24 11:34, Geert Uytterhoeven wrote:
> Hi Lukasz,
> 
> On Fri, Oct 25, 2024 at 5:40 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>> On 10/22/24 14:36, Geert Uytterhoeven wrote:
>>> On Tue, Oct 8, 2024 at 11:14 AM Geert Uytterhoeven
>>> <geert+renesas@glider.be> wrote:
>>>> When CONFIG_ENERGY_MODEL=y, an error is printed on RZ/G2E and R-Car E3:
>>>>
>>>>       cpu cpu0: EM: invalid perf. state: -22
>>>>
>>>> This happens because the Operating Points Parameters tables do not list
>>>> voltages, as they are all identical.  Previously, it was assumed they
>>>> were optional, and unused, when none of the CPU nodes is tied to a
>>>> regulator using the "cpu-supply" property.  This assumption turned out
>>>> to be incorrect, causing the reported error message.
>>>>
>>>> This RFC patch series fixes this by adding the missing voltages.
>>>>
>>>> Note that the Energy Model calculates energy efficiency by dividing the
>>>> (estimated) CPU power consumption by CPU core clock frequency.  When all
>>>> voltages have the same value, the former is proportional to clock
>>>> frequency, and energy efficiency becomes a constant.  Hence all
>>>> operating points are considered to have the same efficiency, and the
>>>> Energy Model always picks the one with the highest clock rate (see also
>>>> [1]).
>>>>
>>>> Alternatively, the Energy Model could be changed to silently ignore OPP
>>>> tables with missing frequencies.  IMHO this is not an unusual case.
>>>>
>>>> Which approach should be taken?
>>>> Thanks for your comments!
>>>
>>> Any comments from the Energy Model and PM people?
>>
>> My apologies for delay.
>>
>> So you had issue with bogus Voltage values and removed them.
>>
>> There is another way to setup EM properly, via DT:
>> "opp-microwatt" [1].
>>
>> That micro watt value won't confuse other subsystems, like
>> your regulator fwk. It will only be used by the EM fwk.
>>
>> This would be an alternative to your voltage values.
>> Sounds better to you?
> 
> For opp-microwatt, I do need to know the actual power consumption
> of the core, right?

Correct. You can try to derived that in a way you did and put below.
Although, Dhrystone is a synthetic micro-benchmark with small
impact to data caches, so it will not use much power.

> 
> Full system power consumption while running the in-kernel
> Dhrystones benchmark:
> 
> 800 MHz: avg 4972,55 mW, stdef 20,474 mW
> 1000 MHz: avg 5025,93 mW, stdef 18,644 mW
> 1200 MHz: avg 5059,63 mW, stdef 15,425 mW

Right. From those power values can be try to derive the
'CPU only power' values - assuming only one core was
running the test.

AFAIU you don't have proper DVFS due to missing voltage scaling.

Therefore...
Out of that I got these CPU power values:
800MHz -> 174mW
1000MHz -> 212mW
1200MHz -> 261mW

> 
> The system also has test points across a 0.005 Ohm sense resistor in
> the DVFS power supply line, but no on-board measurement sensor (like
> the MAX9611 on Salvator-X(S)), so I haven't measured anything
> there yet.
> 
>> Do you know from /sys/kernel/debug/energy_model/
>> the current power values?
> 
> With this series applied:
> 
> root@ebisu:~# grep -r . /sys/kernel/debug/energy_model/
> /sys/kernel/debug/energy_model/cpu0/ps:1200000/inefficient:0
> /sys/kernel/debug/energy_model/cpu0/ps:1200000/performance:1024
> /sys/kernel/debug/energy_model/cpu0/ps:1200000/cost:3443
> /sys/kernel/debug/energy_model/cpu0/ps:1200000/power:352643
> /sys/kernel/debug/energy_model/cpu0/ps:1200000/frequency:1200000
> /sys/kernel/debug/energy_model/cpu0/ps:1000000/inefficient:1
> /sys/kernel/debug/energy_model/cpu0/ps:1000000/performance:853
> /sys/kernel/debug/energy_model/cpu0/ps:1000000/cost:3445
> /sys/kernel/debug/energy_model/cpu0/ps:1000000/power:293869
> /sys/kernel/debug/energy_model/cpu0/ps:1000000/frequency:1000000
> /sys/kernel/debug/energy_model/cpu0/ps:800000/inefficient:1
> /sys/kernel/debug/energy_model/cpu0/ps:800000/performance:682
> /sys/kernel/debug/energy_model/cpu0/ps:800000/cost:3447
> /sys/kernel/debug/energy_model/cpu0/ps:800000/power:235095
> /sys/kernel/debug/energy_model/cpu0/ps:800000/frequency:800000
> /sys/kernel/debug/energy_model/cpu0/flags:0x3
> /sys/kernel/debug/energy_model/cpu0/cpus:0-1

Those power values listed above look a bit higher, but they
could be more related to a benchmark which utilized caches
and more parts of the CPU. I don't know if you had chance to
see some of my presentations on Linux conferences, where
I show how much power can vary in different scenarios at
the same frequency...
TLDR; it can be even 1.8x comparing to Dhrystone.

So would say it's OK for you to put either your Dhrystone
power results, or these one from EM dump (probably from
some more heavy benchmark then set into DT coefficient
to derive them in OPP fwk).

Your platform AFAIK is not Heterogeneous, so it won't be used
in EAS w/ that EM. It will be only used for thermal governor
IPA or PowerCap DTPM, which require EM to work.

Regards,
Lukasz

