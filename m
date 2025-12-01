Return-Path: <linux-pm+bounces-38971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C26C97C8D
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 15:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A6B3A175E
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0125731770E;
	Mon,  1 Dec 2025 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7gUrqSI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcCT9rYb"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5232EC54D
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598387; cv=none; b=Dz7mGVTIZzFnXV7P+QjbmSCkyTNDUus7580E0Y5SyH8mQSQ0lv1EqTsRlmUbo4YTauxMk4mi+MU5nym9ZMZCQgUuLJs/LCfZ1rKnY1AYiXti1P+36LWMY2Eu6NrRvsKbzxE70oYhKGXOkBTEsUfy+nL/e9yc5II2bWEsjVKpWFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598387; c=relaxed/simple;
	bh=Rc8tQOb4KW598mjC8YsSgSNwBXwy5J7HyE2s6WHzBK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwFaroi8o0qMo32AvyK4vzzXKcjKxGMCV04s5WN3er5tPP15VqruErPCqpmENWxLrEFqd+N/AX3e565bXgZQ4l/bONjfZeXYuDKthbLjEPlmeWU97uncYvoYBl+joVl2T967KSvMS4Y6wAy6ofqp+tEJSrgjz48phiFtuxNEe6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7gUrqSI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcCT9rYb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764598385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61JYzq1X4An4pJbqjhEXU3J3+I6bDh/T5IuX0+k4kE8=;
	b=N7gUrqSIZ/J77bsebfKkVt8El0VYE369WmzUe7EBdA17x73qmKkyvxu2QfgQ7ZtSfICgWM
	c6Igb5JRHAxBd/dNM7KMsWT7R1tvBiFRM4vYTQprA7MdkeVrUL4ypIMsayw2oTEy+QMrwL
	IwmeuSzwoJEKeSgYZhDA4WJtBCvC17w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-hm6pZwcpNY-MFbQx6lpFAw-1; Mon, 01 Dec 2025 09:13:03 -0500
X-MC-Unique: hm6pZwcpNY-MFbQx6lpFAw-1
X-Mimecast-MFC-AGG-ID: hm6pZwcpNY-MFbQx6lpFAw_1764598383
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b2e19c8558so754756485a.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 06:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764598383; x=1765203183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61JYzq1X4An4pJbqjhEXU3J3+I6bDh/T5IuX0+k4kE8=;
        b=gcCT9rYbVrkf9XrwAUgJ2RemyaQOsOeolJC3kRZnPq0YuIQIJh6iO/7FqPBG0X7cRo
         HzOIqwTxPlZtF6I5XuEIMDWLRUhwSjv8UToYseBxZiHhrBgK2JGt7WBMqOg2EUEeMKfc
         zskaMjuDJK2+ugCLTJIDzKSV+JErW/Xe0OMIeucDtQ6knvekQWYDIBhIXYehpInCNacT
         ZB6FoJOSRomI4RxlGbi176IZnkfrppZE1FNooZ/83gPm9/pZ0V38FPE8bYBrV92PWXQJ
         Y14pfHNc8VCLnglfxyWL+6ajxcDWY9xuXpnewnyfMCrSbNXt/IC7sjR9UhBd1+OD6+Nr
         kRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764598383; x=1765203183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61JYzq1X4An4pJbqjhEXU3J3+I6bDh/T5IuX0+k4kE8=;
        b=d/eazjBDnQWCapuEwsST4e5VLFfdp61zKWR9Ss35Q6Wi3QNvJtC55JDalLLe6KW4Fi
         ZanGSYBqDjmsXeQH5bHcO2fheiTq8Pa/w8QJ9VZpZfNYpxIBVExnFioHDhnshM1EaxYw
         McAjrZOFqr6sDHxVhALmqoe/P2K5uTK9umVTrNPef05fLlZhImbOgjB6m2a2y+PF9QvR
         bazv2zqa+jRUqNQSh3WEj8XVxRj+VKHmRjBFZByCQ3ZxV9rgF/oZaH2WyDXD2tK1ScAA
         0mcUVe4IJhrSjYt2k7nq0O+4Zfh0UJewr2IpvFuVF+ZrXXgt8ZQg0Xvvcay+6S80Cl7e
         7i3A==
X-Gm-Message-State: AOJu0YxXDdpXSTycl7KKOQhtFpGVf8jhh2Of+s0yeUf+21UHT/1X8qZd
	GC+Ld25XyRtwm4yGxvLhP6lNSRmwwO8kmt3Cn+7GheuV+IK88Hc16z8XygHuPsNAKQsL/mgRZlY
	NsSe4YOTGJDapsgLyuftZsn+mTAYiLZWuccuXJFihr5oc34nicT1is1P85ddA
X-Gm-Gg: ASbGncuWA5zoibnvPrMBFOmHbl+C16HygI/y3LGDC+YpP8jGGZmb0zHYk3a6fxIMDJb
	wL8PT5Dm/QbfLh4TpT8a+++mvbNLsHuZIzsAC/fYcuzH2DLgdx4l5Ib1bmaEGcgIy1CG990hKTx
	n4YaUOKYn4aoXC/zDINDgnBpSxeZxfd2wVidEhOeKusjch07FiHHMum+yM0cvySvyO1Xi18BLzA
	8Z/Kr5fcmjH9TGtk/1zoPBvqTJp9qeFqwWzv5xO36FInW7cFcf7pq8IJ6XADY1gkW/muv2I9aT3
	qm006qwMK2GQ0xW4wH7vVooDT0Wjq+uWVBIJ/GoBThPDsdOUGakvGYVQPZf3TqzOAWuXxP/xw4L
	/zXaJRIZ9xA==
X-Received: by 2002:a05:620a:708a:b0:89f:db05:1643 with SMTP id af79cd13be357-8b33d48e2f2mr5244009885a.89.1764598383237;
        Mon, 01 Dec 2025 06:13:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ1J6QLX6Tv54HUvnqgzshcUPHK7E1VpPS4qLWxfkDn4ZOdMBygaWC5SDcdU9pi/1XIBeWfQ==
X-Received: by 2002:a05:620a:708a:b0:89f:db05:1643 with SMTP id af79cd13be357-8b33d48e2f2mr5244003785a.89.1764598382738;
        Mon, 01 Dec 2025 06:13:02 -0800 (PST)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b529993c92sm868303485a.1.2025.12.01.06.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 06:13:02 -0800 (PST)
Message-ID: <eae451c6-9bf8-4910-b9c1-4a558c308929@redhat.com>
Date: Mon, 1 Dec 2025 09:13:01 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tools/power turbostat: avoid segfault referencing
 fd_instr_count_percpu
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251118155813.533424-1-darcari@redhat.com>
 <20251118155813.533424-2-darcari@redhat.com>
 <CAJvTdK=wpC85at_oshwAhdKtU32QLnHx8MyB7QVtRVRZ=303CQ@mail.gmail.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <CAJvTdK=wpC85at_oshwAhdKtU32QLnHx8MyB7QVtRVRZ=303CQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


So get_instr_count_fd() calls open_perf_counter() which in turn calls 
perf_event_open() which returns the value from syscall().  From the 
documentation this seems to return -1 in the case of a failure.

Looking at get_instr_count_fd() I see:

int get_instr_count_fd(int cpu)
{
	if (fd_instr_count_percpu[cpu])
		return fd_instr_count_percpu[cpu];

	fd_instr_count_percpu[cpu] = open_perf_counter(cpu, PERF_TYPE_HARDWARE, 
PERF_COUNT_HW_INSTRUCTIONS, -1, 0);

	return fd_instr_count_percpu[cpu];
}


So open_perf_counter() is only called when fd_instr_count_percpu[cpu] is 
0.  In that case the return value is stored in 
fd_instr_count_percpu[cpu].  So in the case of an error this value would 
be -1; otherwise, it should be a valid file descriptor.  In fact, I 
don't think the function should ever return 0.

As far as I can tell fd_instr_count_percpu[] is initialized to zero so 
that  get_instr_count_fd() can discern whether or not 
open_perf_counter() needs to be called.

Am I missing something?

I do see that free_fd_instr_count_percpu() has a bug as I think the code 
should be:

		if (fd_instr_count_percpu[i] > 0)

instead of:

		if (fd_instr_count_percpu[i] != 0)


Thanks,
-DA

On 11/25/25 2:11 PM, Len Brown wrote:
> not your fault, but looking at this code, it seems that
> get_instr_count_fd(base_cpu)
> assumes that 0 is an invalid FD.  Fine, but based on that you'd think
> we'd use zero for invalid
> and non-zero for valid as return for the function call...
> 
> On Tue, Nov 18, 2025 at 10:58 AM David Arcari <darcari@redhat.com> wrote:
>>
>> The problem is that fd_instr_count_percpu is allocated based on
>> the value of has_aperf. If has_aperf=0 then fd_instr_count_percpu
>> remains NULL. However, get_instr_count_fd() is called from
>> turbostat_init() based on the value of has_aperf_access.
>>
>> On some VM systems has_aperf can be 0, while has_aperf_access can be
>> 1.  In order to resolve the issue simply check for to see if
>> fd_instr_count_percpu is NULL and return -1 if it is.  Accordingly,
>> the has_aperf_access check can be removed from turbostat_init.
>>
>> Signed-off-by: David Arcari <darcari@redhat.com>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   tools/power/x86/turbostat/turbostat.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
>> index f2512d78bcbd..584b0f7f9067 100644
>> --- a/tools/power/x86/turbostat/turbostat.c
>> +++ b/tools/power/x86/turbostat/turbostat.c
>> @@ -2463,6 +2463,9 @@ static long open_perf_counter(int cpu, unsigned int type, unsigned int config, i
>>
>>   int get_instr_count_fd(int cpu)
>>   {
>> +       if (!fd_instr_count_percpu)
>> +               return -1;
>> +
>>          if (fd_instr_count_percpu[cpu])
>>                  return fd_instr_count_percpu[cpu];
>>
>> @@ -10027,7 +10030,7 @@ void turbostat_init()
>>          for_all_cpus(get_cpu_type, ODD_COUNTERS);
>>          for_all_cpus(get_cpu_type, EVEN_COUNTERS);
>>
>> -       if (BIC_IS_ENABLED(BIC_IPC) && has_aperf_access && get_instr_count_fd(base_cpu) != -1)
>> +       if (BIC_IS_ENABLED(BIC_IPC) && get_instr_count_fd(base_cpu) != -1)
>>                  BIC_PRESENT(BIC_IPC);
>>
>>          /*
>> --
>> 2.51.0
>>
>>
> 
> 


