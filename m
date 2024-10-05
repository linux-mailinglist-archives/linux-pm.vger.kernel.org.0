Return-Path: <linux-pm+bounces-15213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECA5991845
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 18:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0A51F21D88
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B306157476;
	Sat,  5 Oct 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuNVLbxN"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF455156C74
	for <linux-pm@vger.kernel.org>; Sat,  5 Oct 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728145633; cv=none; b=ETe1kR7N1RDdvs8VSGt2CqL4veuX2Oc6U+1dRXnP4LxLjnlFcXZJ2qRLeoFe9Bicg1VhE3ao//+pLJhQYP/Y2B09JjKHcJT42QZfDbhXo5dGrN+DR8vISnhq9kpXucsZ4H+47KPtGhqYOD9yfsbH6KmrJ547naRIghN+V0Nh2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728145633; c=relaxed/simple;
	bh=9ZvisnSJRFJ2ogCvSEG1YlRdGpHNkC/TDJASCuC9Sgc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KFOXoZYRBVG8/uvs++49AMpP/A1DTlW/U1k3YUJqnPMqS/fC+TtH5iUSuq1ciVtrWSm2RriLMYEKugNc0gjGAcgfDMGZlg0rhtSTTPvDFQ+So45ucFfNmxS7nklKcwgTzoA8tIMx28lXuz9cdKXzdZcM3tP8ZZ1KFGUmDNhUqIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuNVLbxN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728145630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zq9NLdq207yX9JNveWp2gfaOV1UfC2nKX+dyW5rdSYk=;
	b=QuNVLbxN08immEPyJWAXKVMFUpZKKfRVu+AmsZVH4x/RL1iHR9h339mWBk2hrzcEYAVQ1M
	VwD9zrVH+RsXZmgV2jvblSkBvGZIrkIZYdirU263t8i2NhRDuFMhN1vDig1fnqnmMYk13M
	W2fUK+X65LOmA0HMBhznUJr5VGNBIPc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-nmgqSAUUMG-JosbW2hwBHg-1; Sat, 05 Oct 2024 12:27:09 -0400
X-MC-Unique: nmgqSAUUMG-JosbW2hwBHg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c877a8db97so2607227a12.0
        for <linux-pm@vger.kernel.org>; Sat, 05 Oct 2024 09:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728145628; x=1728750428;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zq9NLdq207yX9JNveWp2gfaOV1UfC2nKX+dyW5rdSYk=;
        b=cUFRARFel6FP802uXXJ1/kdii7y9JVvZIyH9sTwxFJ4BQZj6vsj2ipKBs3lEjbSlFD
         WOSveNXfb8hexUv5VkP8DP/nhwUXPqyvpzFUd994DgtuNngaBfc6B/rcUbg2JazqsIU0
         WygLb/c/zuMWwkDAwyHi9497HVsQI+FioFGeGHbXppK0BqpLZ8INbgK4i8mO+Yet1CFp
         yregmtDWVmpxrAYdV0aSwYDa4F3dp5IEoaKmp6fSRj+OAMyG2OCsJpTbCBwo1sem9gFG
         Zk9M22sB9RWRtlxWJGrBo6Gs5/AHZH7OlK7MlVj2qsm08li+1bLxX0ej0lH1pKIImnHL
         W/EQ==
X-Gm-Message-State: AOJu0YzrSDGjwtP9jHH4JFHo4q4fhZJre9B9s01+t+rtSj9zbSmUj2sa
	7+hT28mkb26xBBQ3rLg9sCgLo+vBc+K6M5oDLUtEquU9OzI9DhohC1EWhxfjULSFtOs+PX5ncsY
	mJ9gTsKOF5EA6hNS2N12j7eWcRSgc9LDlkaN4xKfhiFI41Nk7LN907Q6W
X-Received: by 2002:a05:6402:440a:b0:5c8:8db1:1d55 with SMTP id 4fb4d7f45d1cf-5c8d2e3a6b2mr5583026a12.10.1728145628194;
        Sat, 05 Oct 2024 09:27:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6MHGfvxfFnEvu59h2PTnO3h6b30JWK5W4rpCsx0+ltgIv+w8CVFY0YoMmP9mSTxzCoBkVcg==
X-Received: by 2002:a05:6402:440a:b0:5c8:8db1:1d55 with SMTP id 4fb4d7f45d1cf-5c8d2e3a6b2mr5583008a12.10.1728145627790;
        Sat, 05 Oct 2024 09:27:07 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05aa730sm1146228a12.36.2024.10.05.09.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 09:27:06 -0700 (PDT)
Message-ID: <f8042679-a469-4aaa-8671-a6dcaa894e8c@redhat.com>
Date: Sat, 5 Oct 2024 18:27:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls
 outside suspend (fixes ROG Ally suspend)
From: Hans de Goede <hdegoede@redhat.com>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>, luke@ljones.dev,
 me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>
References: <20240922172258.48435-1-lkml@antheas.dev>
 <134adbb7-06c5-4b6a-a8b9-abb973784f73@redhat.com>
 <CAGwozwG49xkWoFVybsVzpa=eG1U2YVCMdr8qc-HwRWSqEKCv0g@mail.gmail.com>
 <c19490b6-dc4b-47b3-b422-d244a6b87e5e@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <c19490b6-dc4b-47b3-b422-d244a6b87e5e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

p.s.

On 5-Oct-24 6:24 PM, Hans de Goede wrote:
> Hi Antheas,
> 
> On 5-Oct-24 5:10 PM, Antheas Kapenekakis wrote:
>> Hi Hans,
>>

<snip>

>>> IMHO it would be good to submit a v2 of just patches 1 - 3 run through
>>> checkpatch. Also the commit message of patch 3 should point to the existing
>>> quirk code in asus-wmi.c and mention that then is no longer necessary after
>>> patch 3, then we can discuss what is the best place for these quirks.
>>
>> I did run it through before sending the patch. However, some of the
>> warnings were a bit cryptic to me... I will run it again.
>>
>> I will add a note for asus-wmi on future patch series.
>>
>> First 3 patches of the series are designed to NOOP before patch 4. Did
>> you mean patch 3 (which adds the delay) instead of 4?
> 
> Ah I misread the series and failed to notice that patch 4 actually hooks
> things up, I was under the impression that patch 4 hooks things up.
> 
> But I did mean that patch 3 might lead to discussion not patch 4.

Oh and upon re-reading the series I see that pathc 5 is just dropping
the quirks from asus-wmi.c, which is fine.

I somehow thought that the later patches where adding a way for userspace
to already enter the LPS0 display off state earlier. No idea how that
idea got in my head ...

Regards,

Hans



