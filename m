Return-Path: <linux-pm+bounces-38658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A76C87474
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 22:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E58E34E3FE9
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 21:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE0530149F;
	Tue, 25 Nov 2025 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBmGw98v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mU7CCRHK"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50C8286417
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764107766; cv=none; b=cSeYzAlkzegdOt80DJnGxm5ixumdXPAXZaGTLkqTDwIhbUEJSShPJLmvpUvFVTiV7sIKWsQdwfk/mJWJyRmIedL6L3/O/d8M2MLZxxnoQQG9RU5hN4VBWD0m1Id84ayig2WiI3J4gskeLMLgjS9wFK7SVCf1uoTE3uQ4CqK/cyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764107766; c=relaxed/simple;
	bh=3e0+dzaDLsHKg0U0f54rCzv32i0Sku0SQFUhjdfSvwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+YWZaAuB9jy4Ha2t/zRuaOvICGVeOcOxYEtwvSRfrdIFUlnk5XaKtC5C14E04qNdbfJwMbtyqfGoGa/fykerlT0HFEnYWSRHfrzP7d5g5/jmde0hp+Tsrgdcs55eqHtd5ir4zfk5bH/Vdm8NY8PW6hH+uwoZ+h5LstfXLmsTbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBmGw98v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mU7CCRHK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764107761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSxcDzgKkecVBpQbNcgBBZPZjsuHh8zneuXN2m7PNc4=;
	b=CBmGw98ve2VLhRN3iKTpFKEK1UKmrFCfPLGONn0WV8NlMWeccRnOxWrcp8Cp9yAuMgsEb0
	StjXaDUwP6Ntxpjt3sZLd/HkLbrYIT6kN5oDSThGAVpeDZr3ANvdoToRdClupB9pK1qD2L
	CzDFZpTDJONNkkgoLW8NY2RecR+64SQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-10F8A6F-MoiBWx9KC_Wq-Q-1; Tue, 25 Nov 2025 16:55:59 -0500
X-MC-Unique: 10F8A6F-MoiBWx9KC_Wq-Q-1
X-Mimecast-MFC-AGG-ID: 10F8A6F-MoiBWx9KC_Wq-Q_1764107759
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2657cfcdaso720056185a.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 13:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764107759; x=1764712559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSxcDzgKkecVBpQbNcgBBZPZjsuHh8zneuXN2m7PNc4=;
        b=mU7CCRHK6gXOpKhLjiV3Hm3i85rgbh0IMjWsUImBNo6EM/0YDTVUBVxjcR5T21O4z1
         2qDfLZqyYNn9du4+To5bYaMfmEJaFFLy38X5U4bBbAyEp9p9znuTgfey1Bs7+G4iN1x7
         M+NoPvztSgPWR6m458LvtwDOsSnzbwnq85ydG0jVWTzAqhzuq0H7uAQ05BDt4lwgtROB
         3rlElmJMksz3btHQNMPLy3wVyDjPb0biz9WaBdnwGVEqTEJj9kDT+qVn+dY0wedSefkh
         VdZEIQ4V0N49z1O8Y9uy8Srxd+OUScXY3XmqjnNOmPDG61Yp5E8PEyBYAJBH48qNVKzu
         e0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764107759; x=1764712559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSxcDzgKkecVBpQbNcgBBZPZjsuHh8zneuXN2m7PNc4=;
        b=jBXooT0fwntcVhsfrMU+imDh8ijCwuxBKdQI6LgmXvP76w4pkWyuiPRYn+UI0bRvyi
         e5G2AQ6pb4Zx8C0TSQ6d8NgiSWEXuaA70t/jzy8Ha25ajnp1P6/za6IpFtLs8X073DSU
         icGtQtufTZ3JiudJpFDRkW0EtkDLUEkDC1ROUPVXyHVfvf8VP2Rhc8btdaaGTuuy9liF
         7dBif8cIcNX5cLJzms2M/nhbn+rK0RDDnzf+wPvqbKhjUC38PkrzQC9PvC9QruLqBsWd
         itLRVJQSnmTv4n2Z1c2hOS1klk8QtmEvvpTR5QCSDzlXf6L8CxivkhnmPKWw03qX6Zrm
         llKg==
X-Gm-Message-State: AOJu0YxRpovZibbm3KUdv3sfJVT+5vUlhTBvbF9IPUjpW8wc7cu6PIkx
	2CBBl5kbL2UUpFbgHpYM9vyszIpUNe6jtuJ2qKkRRWioW7eZSYWHRCUORIIiY4p57oLixlJF9fP
	u+lst7tv9g4oJt9zQzrPBEZHLWZGLzXd09gMJBGqHCcbLKdxzm7LTK97qQffxAcRPI/ck
X-Gm-Gg: ASbGncslgrPKPrS4kVj3c+tM6XRo1ahzwTVx7NDkV4meDAz6jvBnGvcCdJalp6uZiro
	U3P0xtBofXYvNllVZ2bFeCV5lILHfdHzFXuIjOeur07vvsdCJJLCg9yg2sBQLyo0cMGGQO+5STv
	7Unjq+Z9mQjsDPGd1irQ06YTSFkfgiZPaq4+92Rybgxhkh5dIsFiRsOzE90EmS9PmvhTW+OQn5R
	mpixCdY0HyofZ8ldtVhHffSzeD7kkEIrKCmSV4DUXlpONuHvZGYU3tYehC7F4r378Vucj0dQ3aR
	0sPvXoGF0KWlRPt1gsG1XjmkyFr5lzeo0c/jui4uw4vvMZIU2+v67fG0uu9bOLwStZv9oYddvva
	6HPkOcQ365A==
X-Received: by 2002:a05:620a:4110:b0:8b2:ec5c:20bf with SMTP id af79cd13be357-8b4ebd5221emr603709285a.29.1764107758798;
        Tue, 25 Nov 2025 13:55:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNUiVdPADZLhEqiePWHHzDj+dyXpF+3u+pyWxwS7qaHE30wD9qtNmaFS/cc5pZdY4OGMrocQ==
X-Received: by 2002:a05:620a:4110:b0:8b2:ec5c:20bf with SMTP id af79cd13be357-8b4ebd5221emr603707185a.29.1764107758381;
        Tue, 25 Nov 2025 13:55:58 -0800 (PST)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295c17c7sm1265864785a.32.2025.11.25.13.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 13:55:57 -0800 (PST)
Message-ID: <b2ff2579-0d19-4648-9411-c02133c28c1d@redhat.com>
Date: Tue, 25 Nov 2025 16:55:57 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tools/power turbostat: allow turbostat to work when
 aperf is not available
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251118155813.533424-1-darcari@redhat.com>
 <20251118155813.533424-4-darcari@redhat.com>
 <CAJvTdKmt+3i+TjbYSa--=uS22q1ZgEQuferNhCxKVK_G5Lx2jQ@mail.gmail.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <CAJvTdKmt+3i+TjbYSa--=uS22q1ZgEQuferNhCxKVK_G5Lx2jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/25/25 2:14 PM, Len Brown wrote:
> It would be helpful if you could describe exactly what environment you
> are running in.

It' a VMWARE instance.

CPUID(0): AuthenticAMD 0xd CPUID levels
CPUID(1): family:model:stepping 0x17:0:0 (23:0:0) microcode 0x0
CPUID(0x80000000): max_extended_levels: 0x8000001f
CPUID(1): SSE3 - - - - TSC MSR - - -
CPUID(6): No-APERF, No-TURBO, No-DTS, No-PTM, No-HWP, No-HWPnotify, 
No-HWPwindow, No-HWPepp, No-HWPpkg, No-EPB
CPUID(7): No-SGX No-Hybrid


> 
> are there any MSRs?

I'm not certain, is there something in particular you are looking for?

> Is APERF available via perf, but not via MSR?
> etc.

I don't believe that APERF was available via perf. I'll go back and 
verify when I have a chance.

-DA

> 
> On Tue, Nov 18, 2025 at 10:58 AM David Arcari <darcari@redhat.com> wrote:
>>
>> Currently when aperf is not available the function has_amperf() still
>> returns true.  The end result is that the program gets an error in
>> delta_thread() which causes turbostat to restart.  We can avoid this
>> by not setting msr_counter_arch_infos[MSR_ARCH_INFO_APERF_INDEX].present
>> when aperf is not available allowing turbostat to execute normally.
>>
>> Signed-off-by: David Arcari <darcari@redhat.com>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   tools/power/x86/turbostat/turbostat.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
>> index 5567b9ecd516..b3f1e4ae5813 100644
>> --- a/tools/power/x86/turbostat/turbostat.c
>> +++ b/tools/power/x86/turbostat/turbostat.c
>> @@ -8592,6 +8592,10 @@ void msr_perf_init_(void)
>>                                  continue;
>>
>>                          if (cai->needed) {
>> +                               /* check to see if APERF is available */
>> +                               if (cidx == MSR_ARCH_INFO_APERF_INDEX && !has_aperf)
>> +                                       continue;
>> +
>>                                  /* Use perf API for this counter */
>>                                  if (add_msr_perf_counter(cpu, cci, cai) != -1) {
>>                                          cci->source[cai->rci_index] = COUNTER_SOURCE_PERF;
>> --
>> 2.51.0
>>
>>
> 
> 



