Return-Path: <linux-pm+bounces-16470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED619B089E
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 17:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0C51C22BB2
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976D61885B7;
	Fri, 25 Oct 2024 15:40:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A2415A858;
	Fri, 25 Oct 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870852; cv=none; b=FvTAUuCyVYeOxT2fgbokrXonL83G9C7LG4ID/FjF7R5kcNaMEH4M7AocAy6qwb9sFd4kDeTv/Nujz3NoEf0hZDlbeBSm4L8Tgc9zkcNae8FfjVaHl7sDgvgLuCoBXtpp05hAPRG3ttSdkds5OdGMN0sHrSo/Zwprf5t7NBEplps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870852; c=relaxed/simple;
	bh=qEVNQFJWLhm7KbaIPFSwZIfcXxwCW6QTwMEqNJ7ho34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/IuIsacuLPrCn9jsZhewIAm5NdYr/ov1sDJ+bzX+Szopc7Gex797jqNV3LDuMpQvhccTVMXoyRiFdOZqqorPEBOeHPS9PBCGfp0dT82bdg79bM5OShjo8rEmsfmIvLrQ6heHtJoRwJuZiwzZ/t34cUWwuilwmBBlKZ34KdEPcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26CBF339;
	Fri, 25 Oct 2024 08:41:18 -0700 (PDT)
Received: from [10.57.55.217] (unknown [10.57.55.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3B7D3F73B;
	Fri, 25 Oct 2024 08:40:46 -0700 (PDT)
Message-ID: <b273599f-8653-4e98-ac64-09c91b0a1592@arm.com>
Date: Fri, 25 Oct 2024 16:41:57 +0100
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
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAMuHMdXsmAqQL+2+D_y+u1z4nn8JO+xF-mq6wWJ0pAH58n5Wiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Geert,

On 10/22/24 14:36, Geert Uytterhoeven wrote:
> On Tue, Oct 8, 2024 at 11:14 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> When CONFIG_ENERGY_MODEL=y, an error is printed on RZ/G2E and R-Car E3:
>>
>>      cpu cpu0: EM: invalid perf. state: -22
>>
>> This happens because the Operating Points Parameters tables do not list
>> voltages, as they are all identical.  Previously, it was assumed they
>> were optional, and unused, when none of the CPU nodes is tied to a
>> regulator using the "cpu-supply" property.  This assumption turned out
>> to be incorrect, causing the reported error message.
>>
>> This RFC patch series fixes this by adding the missing voltages.
>>
>> Note that the Energy Model calculates energy efficiency by dividing the
>> (estimated) CPU power consumption by CPU core clock frequency.  When all
>> voltages have the same value, the former is proportional to clock
>> frequency, and energy efficiency becomes a constant.  Hence all
>> operating points are considered to have the same efficiency, and the
>> Energy Model always picks the one with the highest clock rate (see also
>> [1]).
>>
>> Alternatively, the Energy Model could be changed to silently ignore OPP
>> tables with missing frequencies.  IMHO this is not an unusual case.
>>
>> Which approach should be taken?
>> Thanks for your comments!
> 
> Any comments from the Energy Model and PM people?

My apologies for delay.

So you had issue with bogus Voltage values and removed them.

There is another way to setup EM properly, via DT:
"opp-microwatt" [1].

That micro watt value won't confuse other subsystems, like
your regulator fwk. It will only be used by the EM fwk.

This would be an alternative to your voltage values.
Sounds better to you?

Do you know from /sys/kernel/debug/energy_model/
the current power values?

Regards,
Lukasz

[1] 
https://www.kernel.org/doc/html/v6.11/power/energy-model.html#registration-of-em-using-dt

