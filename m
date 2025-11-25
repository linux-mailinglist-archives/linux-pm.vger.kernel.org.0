Return-Path: <linux-pm+bounces-38657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25274C8745B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 22:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6003B70AF
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 21:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F3F30170B;
	Tue, 25 Nov 2025 21:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hU5sdm8H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A48myhiL"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79A82D0C72
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764107461; cv=none; b=hh+alTYC9IjTLcMnLp/j/KMnzt6i7V2fMypGJUTXGBGhuC49tC7msnCvNzkdWNeFhgJRO3tlQ6qqX3SvEOD552wNvo9CAfEWo5oFdYx0NV87MJB5ur98SaO/RokrDDPaDC4Jcgoj6Si3jf3z2m4DpQEKMcLnCgXOjJd1gsgwCJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764107461; c=relaxed/simple;
	bh=QnWW2FsKw25ER8CPySxn/1E8dEct60IACJESvaGvRcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUaQnSyrUhpZC3EQvb8krJDrTudsvkMov4cva+IGsQ3HDgQrCm5m46T5OifQ9vFAe+p+JgD7tqxwvolN8kDrXt6ibstbiPTWWjzE0+i2UM1MdDoRwXfXiQHPcDCSzwrSyDV2i3J+FQGBjRMbYToX4YnFqB0s3meAQNFsjeWQec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hU5sdm8H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A48myhiL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764107458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOGhsG2EtFgJFWze6YBO5hEWxYjkvjk6cTxT3PfvMzc=;
	b=hU5sdm8HKlF/RMIEpmZrlJfy4chh1XYKMFmxxrqk3K9AqjhoVgZKuB9tzHvAZBoPaBRDgo
	4mSuKVUoviY+4TXdKqpXAne3uJksEDpIPH7T8WaT5YSQdCNpmn/twXlKSkQNHPrtKlePYX
	jRUctqOqxcbor5YX2YqL709o120zfKY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-CR01P27zOoqZM3YU6p1VIg-1; Tue, 25 Nov 2025 16:50:57 -0500
X-MC-Unique: CR01P27zOoqZM3YU6p1VIg-1
X-Mimecast-MFC-AGG-ID: CR01P27zOoqZM3YU6p1VIg_1764107456
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5959d533486so4456088e87.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 13:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764107455; x=1764712255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOGhsG2EtFgJFWze6YBO5hEWxYjkvjk6cTxT3PfvMzc=;
        b=A48myhiL2jYSuxojUDCRkr1YMFPSv77IxpIOb2L5h068yLyN/UZ3lc3rZUuUjQ2xh7
         75bEogQ4YN3FIENzHn986vf8M0EU6fCklt1FbY/Gf5RdmORvu0FN22NkmPRh+yPP54XQ
         gYuYH+Yg/Ywaj1HYBrNj47yqUMProOIDwa92whIJoK6I8kiR8dztFpfzE2W9vMGgoHKw
         X1NsI3UdRA8hDZpxwbP3/7sedn7npOEUfB/YUuzcOKSC/UadTdOUgYmC1NHjJeup22zq
         PLS9u+CYgtTkaNCjA3wJIMGWzaA3BHorAQ50WoXD95wu+2q7jsDj83QSwFzBdeNdq6zN
         lk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764107455; x=1764712255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOGhsG2EtFgJFWze6YBO5hEWxYjkvjk6cTxT3PfvMzc=;
        b=VJ69Wc87QRH29/52QrhualdOb31SrgDdPmbN1E/Kt/d02bJkFhgrXb56TYliYwVbe8
         0R2YHds/fu4tJjQbF5OIcN7INoqXjrjXaxvppa24aIMqK635ppwiYa1HYye04uk9g8tQ
         wIJxNYTu/q4XJsi/K1xgsNJ5ftxO8CcoOi38EAM62mvjWUjwpt8WPHPr7Ex6bC1BS+JE
         RXGl5lsY1pirMIe/KRswR4TtkjeYKdO81k/bK1zi4dzaguWtZeI5gYCtWA+PU4fXyVt5
         Dz6JpBIWZ1OA5WhgJ2aA8MRjb/sqEaIZmGBA4nw3nCTrl9h/OrfMF9qsGpV4U2Qu4rpY
         CtIg==
X-Gm-Message-State: AOJu0YwYp2WtTibKGITYD8eUM92XeQm2tCxuTO2TIYotyVHm9DJj4xZR
	KXef2DCv2GG8A0f6ffoLAO/Sw4MJH3ToYsQL4A028leoy//7Z3xmCnqk14LoE+vRgFWm2VbM3yQ
	1/xa+Shov9qOxZa77GC9WyfSFcdHD0lKPDGoouu0uRdFF+vmz3GrKAWp8rN9c
X-Gm-Gg: ASbGncsyoAWcKQm+IMciFiMS3M3MgmUQU78JZYwaqe+rU3wREDdf+OFwvRcOK/nRmlh
	lWGT3ZBXQLiK0KUZwLWiwEHSXgfR6jl1BASwRObVaLc+5e1LT7/Po6NOyztTChuRxttbp6aCjVz
	N6WAT4UeKnrl6wKt6MyEjvz+kht6BPeISl5nEKYzWSdRzqOGFI9X9TeSgy73KU+NSWKvEbIm26W
	GpVv5zmd9HogvfFid/fqcMugmpfzEEL0NezHUS1ugxhfsmBc3CxxZbt2ehBp6Ev4BNZP+DgeEbC
	eKOWvrjfUFiYnR5LSRffXXIdPWvmqBcPqPa8oH3LC/sYVbpFmbNZW2Wgny6seDLFqi4AnOCHiBh
	lySTtGEpeRw==
X-Received: by 2002:a05:6512:1383:b0:591:c346:1106 with SMTP id 2adb3069b0e04-596a3eb5c4dmr6989773e87.9.1764107455480;
        Tue, 25 Nov 2025 13:50:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZzTRqB2iuOyrmZ0bKAv1eaa1mVGCxMUAXDkXbed34OjxNdP3HCbqbGgTk3aohfQlf8AcDRw==
X-Received: by 2002:a05:6512:1383:b0:591:c346:1106 with SMTP id 2adb3069b0e04-596a3eb5c4dmr6989768e87.9.1764107455028;
        Tue, 25 Nov 2025 13:50:55 -0800 (PST)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596a70a9b0bsm3591918e87.44.2025.11.25.13.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 13:50:54 -0800 (PST)
Message-ID: <41373082-e421-496f-955d-bc9abbf44be4@redhat.com>
Date: Tue, 25 Nov 2025 16:50:52 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tools/power turbostat: avoid an infinite loop of
 restarts
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251118155813.533424-1-darcari@redhat.com>
 <20251118155813.533424-3-darcari@redhat.com>
 <CAJvTdK=tw76+79sCAa3TbVQwDdv9EGCWVrFvFbHihtH3jNcDWw@mail.gmail.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <CAJvTdK=tw76+79sCAa3TbVQwDdv9EGCWVrFvFbHihtH3jNcDWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


I see.  Perhaps this isn't fixable then.  I'll take another look.

-DA

On 11/25/25 2:12 PM, Len Brown wrote:
> this patch introduces a limit of 10-restarts per turbostat lifetime,
> down from infinity.
> 
> some turbostat invocations span multiple uses of cpu online/offline --
> so this limit will not fly.
> 
> On Tue, Nov 18, 2025 at 10:58 AM David Arcari <darcari@redhat.com> wrote:
>>
>> There are some error cases where turbostat will attempt to reinitialize
>> by calling the re_initialize() function.  The code attempts to avoid
>> an infinite loop by checking the value of 'restarted' in one case, but
>> not others. It should be checked in all cases of restart.  Additonally,
>> the 'restarted' is reset to zero at the start of the loop which also
>> needs to be removed.
>>
>> Signed-off-by: David Arcari <darcari@redhat.com>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   tools/power/x86/turbostat/turbostat.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
>> index 584b0f7f9067..5567b9ecd516 100644
>> --- a/tools/power/x86/turbostat/turbostat.c
>> +++ b/tools/power/x86/turbostat/turbostat.c
>> @@ -6722,7 +6722,11 @@ void turbostat_loop()
>>          set_my_sched_priority(-20);
>>
>>   restart:
>> -       restarted++;
>> +       if (restarted++ > 10) {
>> +               if (!retval)
>> +                       retval = -1;
>> +               exit(retval);
>> +       }
>>
>>          snapshot_proc_sysfs_files();
>>          retval = for_all_cpus(get_counters, EVEN_COUNTERS);
>> @@ -6730,13 +6734,9 @@ void turbostat_loop()
>>          if (retval < -1) {
>>                  exit(retval);
>>          } else if (retval == -1) {
>> -               if (restarted > 10) {
>> -                       exit(retval);
>> -               }
>>                  re_initialize();
>>                  goto restart;
>>          }
>> -       restarted = 0;
>>          done_iters = 0;
>>          gettimeofday(&tv_even, (struct timezone *)NULL);
>>
>> --
>> 2.51.0
>>
>>
> 
> 


