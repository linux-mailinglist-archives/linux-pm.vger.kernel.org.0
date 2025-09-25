Return-Path: <linux-pm+bounces-35385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8460BA0667
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 17:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94EE4A3B4A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 15:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274732ECEA8;
	Thu, 25 Sep 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XN7IDCL2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4231B1D6187;
	Thu, 25 Sep 2025 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814402; cv=none; b=PT66vZXrZ/iUgGVBRhx/PWq4b8XilVM7VwpFtIu/G1pC9Lb0N5RRyHuywiW2JuXsKAzUbwfsXnD6F+5HMAOWGHiUZDvsm3p7XIcIrZ8/psuAtEagE+lMi4ZZeB5qbf3ni8PHRRF7d8mEUUpxS7gPt2riWCQ+en0ayuBYO580d/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814402; c=relaxed/simple;
	bh=u5FAkVs1d2yn2V+vcAWfPQaluNSH3+uZoP8oWWENrP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IbUmVP2GDio8+0xjxKVKFAG7mljCmwtZUXV2V3wC3RgxTJYFb9+Hy97+n4MJXIC++7HwVO9Oh9O3LZyNlrRFF+m+XzUtp47fhJ/kOd5mJVO/tCFZQ7uFXDr/hmoqWqdHcbgJ07gGfvuP36ICcbdmjdSOMDAKqKWY81KjlUlHPpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=XN7IDCL2; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9484:60d0:6c9:beea:16a] ([IPv6:2601:646:8081:9484:60d0:6c9:beea:16a])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 58PFWQ7T2493900
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 25 Sep 2025 08:32:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 58PFWQ7T2493900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1758814349;
	bh=AlBarqxfhsKUEiXxrH663bEYPMkBt9GFIKZMwmsouDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XN7IDCL2hY74mA4XAqYEpQlWM22WhzIkHQDMT09Fa7KGN2qfZXMZH8A5+62nxAlYK
	 hRT5jjh5KjF/gSUrUk81P2hu67RN0xhpMV05N3g8+TqWEHSVBCo5Lkyc/2RXaaCj5W
	 WHTZhiQd8oCnOiRaueELO3jym5VFYB3Kda676ngVklxmqfoi+6ItqxjzP9br9U82U5
	 LZ/EipCl9W8Em9a1jMStFuIREedWydmfnLgBLYsdklw4Gbtd3YwsVA/8RjGQUgifRu
	 ufhw0YVOOxe1RXNMeE5ulR4YF+0nO2qqCdlXDiy5WK5175xuFfwrerCAa2tnhEZWkW
	 PsBStTLa0kl5w==
Message-ID: <113902a5-a635-4d21-8192-8c6d482e88bf@zytor.com>
Date: Thu, 25 Sep 2025 08:32:21 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [RFC 0/5] parker: PARtitioned KERnel
To: Fam Zheng <fam.zheng@bytedance.com>
Cc: fam@euphon.net, Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        linyongting@bytedance.com, songmuchun@bytedance.com,
        satish.kumar@bytedance.com, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, yuanzhu@bytedance.com,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org, liangma@bytedance.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, guojinhui.liam@bytedance.com,
        linux-pm@vger.kernel.org, Thom Hughes <thom.hughes@bytedance.com>
References: <20250923153146.365015-1-fam.zheng@bytedance.com>
 <40419dea-666e-4a8d-97a7-fa571d7122f4@intel.com>
 <AEC34AE1-AEB5-4678-AC9D-39155E97D86C@zytor.com>
 <CABgc4wTjc9nxmB16LkxiOL5gYO9K8kr46OqM=asyUkX7cT50Sg@mail.gmail.com>
 <CABgc4wThvZrxBLb0JRiROCws12qLNUxwcb4cJa_W63qh41apjg@mail.gmail.com>
 <585D086B-733C-4274-B274-794F360E8E33@zytor.com>
 <CAG+v+KZL8teU5ReRNEJ2sdKgP02+K26DLMt2=KapZPfqcSWM3A@mail.gmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAG+v+KZL8teU5ReRNEJ2sdKgP02+K26DLMt2=KapZPfqcSWM3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-09-25 00:26, Fam Zheng wrote:
>> From: "H. Peter Anvin"<hpa@zytor.com>
>> The difference is that this is highly invasive to the OS, which affects developers and users not wanting this feature.
> 
> Yeah that makes sense, thanks for clarifying. By having a hypervisor
> at least in early boot of secondary kernels, we don't need to patch
> device enumeration etc. In the kernel code.
> 
> Once the kernel is up, it can be then promoted to run directly on bare
> metal, so zero performance overhead.

Realistically you would remain in the hypervisor, but nothing or almost
nothing will trap into the hypervisor, so again, zero or negligible
performance overhead.  You also *can* put some isolation or protection
features in the low-level hypervisor.

The important thing here is that the maintenance burden *and* the policy
choices fall on the users of the feature, and as the upstream maintainers
cannot and thus will not test this use case, it is likely to break on a
regular basis.

This is basically "paravirt_ops all over again." There are very good reasons
we are trying to get rid of them.

	-hpa


