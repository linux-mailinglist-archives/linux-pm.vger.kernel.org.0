Return-Path: <linux-pm+bounces-41929-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAycHSlRgWmLFgMAu9opvQ
	(envelope-from <linux-pm+bounces-41929-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 02:36:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D066DD36C0
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 02:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96A11300DF56
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 01:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A244273809;
	Tue,  3 Feb 2026 01:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLv93Bw6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBED17C21C
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770082580; cv=none; b=eRe8GIJ48ubv+2zGutyRxjW9ewU+5ipuwfI0ETdPU1kh2Usij20p4lmRZbQdInoDXyZLEBzdIH5u/a0l2YA6PW1vgoM41tPVQrfc2P8Th6SsB7cICVq4iM2eNhzoQyaoopcZedlU+A4K5K2f4GXuTr8hPRB4Z9NJFEBJet8ILRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770082580; c=relaxed/simple;
	bh=2X+mytXBtNSV0apIC0KsjvAvt2VlH2ZbcBkfrYklwOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqUlADEWIdsnCQbvSFnwb5PgC6Y24d8WqtMRsXBdKrUPpUXmYgKc8vfVEyBTtCfcZT4RaA8xJVyvEezTKnrGWSAQ7uHmnj6YoEaNB+0n4vd915w/f8U6pZuFu4XD7XlK6OERgehBBOtOLNznmYC9Oq4YrOkPMqV3epbb+pGRBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLv93Bw6; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-649ba412cd4so2088640d50.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 17:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770082578; x=1770687378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IDGINNniODK4Zc3R8bth6pqq7qdppNjLL1gm7R6GyLM=;
        b=RLv93Bw6xpk89FZZDN9UOJBCxmu+ZX80fcvlX6bt8TqwUJTiClbdTH5AQD8E5w77/G
         EmANL4xl7htJb2EnggaR7Oey2IPQHsNxiJhn/qp1wRaN4TL9cFC2IaOwf80olBg7wgED
         Fl89qLbZ+dHAAjGRgL4KqL+UdRcPIWczq0jHo9rwVw4NVl6hy5Uon8bpCNIWOpXvn29N
         WYjhEg/iODYyxI4+zhoKTRsfw/GW7YfvfiamnYtVLIghpvMDOOyy6t+MJXT4cxjcPwkD
         KdiNUwbAjbe3Ea7Ku9JdabafkB+05C/KwUceMICFVY9+a40saVM2iBZ4/xO44EPHXENN
         nrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770082578; x=1770687378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDGINNniODK4Zc3R8bth6pqq7qdppNjLL1gm7R6GyLM=;
        b=oIFUpcU9oLtKgjF3Yphh+pqFVthCSPDJddfN6VO9IpQmUDCgAOobL/Ye+s1Z8Vz2R1
         IlaPbrzUZBO7djkQkt1E0+PlnHM3F0Wa6vlnJEf0IjRlo6PYzPKWCxvbbXUGQNG1F6qZ
         FKruhPfMW5zlgP5dlZ0RfZlX8VaCSz4AwDM4dwBUzRCvn3kTIXnsNxKk6ZYpLNAlEzw3
         U+4UmAcgAuaNu2h/4x0KSmqnRqoibx5ZyDAwFpbgsr77fYyyme11x/ChvBB7293FTwnq
         zUQJGEYHwsKoqbAdQJjSL3aTxeqJIM/DnEX6fwbNtUqytN2CiZCrQ+QWHM2xlEiOSQ3k
         5ITQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBnEEmUjiTTxWSkz2Z5C/SD5E/DKZQ564xofd4TAEpYOBYVmlmqbK9W6QNz5uH5G/tg9IrOydKWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYtbitc3fRNwdxfjnqxUes0nAoWbSwjoPmhyEaum0Wq/Bi8VIK
	mjkBFyE3Usn4pHaFUklinDHwv7nywQ+asXhfSj0klPzUmofZvSbZP5tw
X-Gm-Gg: AZuq6aKUh+UamZqu8Oll15rhnL6MHYzy4hytWvndShaSp/OuebGaIz9gsVwHN1MfWqj
	MsAyc0RQYZgpxFcZXs5epvKXjI4vV5W+clBf7IwnD9sWU2pcFqpuz764XGFZ6RoICPzqaQGag56
	/NahIixyrutLhXbU5NaAmA7frUVIXTpMY4T5SelbFBGAluXzyxNuiTMrlOiDl25JXexE+f6VTTf
	WOinorMboiy7R7U4tRSvo44CE82aqOGHr8OncgLWaToXbEPMuCT2n9MTN9X2wFaPqFeUOStz9r7
	AEqznDYHkKvCtU5wwITF1QHUwfri4UXLDRYN7AjrAcMSwpZJh9IpWzncLeZt0mE7IL/IADb/4gZ
	U+ArLclNCGj0tUA9HNkWKQDpjWGiWFg2k8H8qSi6An/IeE2vMRxAEHvDAu+b00EntAPNO5qiiSN
	kY5XZ1je1Z3n5k8AJft6T85n3xcVV8boQ0505qlw==
X-Received: by 2002:a05:690e:408e:b0:649:523d:e701 with SMTP id 956f58d0204a3-649a852de09mr10271339d50.92.1770082578400;
        Mon, 02 Feb 2026 17:36:18 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-649d447df2bsm423325d50.4.2026.02.02.17.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 17:36:17 -0800 (PST)
Message-ID: <74f3e6cf-7c13-43e6-a8f6-2b46184b8ad6@gmail.com>
Date: Mon, 2 Feb 2026 19:36:14 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: Sumit Gupta <sumitg@nvidia.com>, "zhenglifeng (A)"
 <zhenglifeng1@huawei.com>, pierre.gondois@arm.com
Cc: rafael@kernel.org, viresh.kumar@linaro.org, ionela.voinescu@arm.com,
 lenb@kernel.org, robert.moore@intel.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
 bbasu@nvidia.com
References: <20260129104817.3752340-1-sumitg@nvidia.com>
 <20260129104817.3752340-5-sumitg@nvidia.com>
 <4432fa04-e67c-422a-aae4-2938be431985@huawei.com>
 <c96312c7-b13f-4f5c-9512-cc0382c1c77b@nvidia.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <c96312c7-b13f-4f5c-9512-cc0382c1c77b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41929-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yumpusamongus@gmail.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D066DD36C0
X-Rspamd-Action: no action

On 1/31/26 7:58 AM, Sumit Gupta wrote:
> 
> On 31/01/26 09:36, zhenglifeng (A) wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Sumit,
>>
>> I am thinking that maybe it is better to call these two sysfs interface
>> 'min_freq' and 'max_freq' as users read and write khz instead of raw
>> value.
> 
> Thanks for the suggestion.
> Kept min_perf/max_perf to match the CPPC register names
> (MIN_PERF/MAX_PERF), making it clear to users familiar with
> CPPC what's being controlled.
> The kHz unit is documented in the ABI.
> 
> Thank you,
> Sumit Gupta

On my x86 machine with kernel 6.18.5, the kernel is exposing raw values:

> grep . /sys/devices/system/cpu/cpu0/acpi_cppc/*
/sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:342904018856568
del:437439724183386
/sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:63
/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:88
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:36
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:3900
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:62
/sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:62
/sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615

It would be surprising for a nearby sysfs interface with very similar
names to use kHz instead.

Thanks,

Russell Haley

