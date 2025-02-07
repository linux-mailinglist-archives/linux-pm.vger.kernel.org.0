Return-Path: <linux-pm+bounces-21555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DD3A2C9E8
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 18:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 638B77A5429
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 17:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52409192B6D;
	Fri,  7 Feb 2025 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fw0mloFd"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9924A18FDAE
	for <linux-pm@vger.kernel.org>; Fri,  7 Feb 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948421; cv=none; b=WwTqWmn1/VrzAhxAN3XwPjolWFBlr+fLg2j++1/j/9yQmi2Oo1xONXXUwqdSZ3ShPJ8ALT25RVUnogVS4VVHziyW6KErIEumgljxXcW13E+2yxrgacbLN69WDnlw8A3/9Xs1me/ouMsGwYwZNfzwKaQwaCq7I5fufjU0ssFz9ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948421; c=relaxed/simple;
	bh=BLOWmoRmbHy/gnuzM8xwn2yz4ukNppwSyIISh/gH96A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOxPR6oecKL9sFNRYI8DbzqXLPxU6A4YaJ4T5TtfIsdOYsuJO7Tf3+prXL02VAC60PgN6bakurblhLerNXLlkg7J+pwduA86jflD5CpSstOcw1U2ZNsdnW3o+RLZEjaxB3kgVTFClepN5wEcq5IF0A+oHW3MHjjjV4PgdASCxjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fw0mloFd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738948418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4xExkY7a9dfcmWWKsnQJ8PF5WnPHcZhnPPJN0QoVJGQ=;
	b=Fw0mloFdAg1eyeMHiOClG5Qd0eeU3eVxPt6QcHMeLxX6HvSbnJhIUsIgQiaAkgAWm8m2y0
	iUnpVjopApB/ztfGac+HkVVBvOOljEew0C9cFzHccdzHhjNhCRpX28Y4hoqCCBc1qg+aPG
	yvxI2ivvm044HN1V2s5eACHZoZ+Tbp0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-CGdqye--ObaD8U8ymAMTOw-1; Fri, 07 Feb 2025 12:13:35 -0500
X-MC-Unique: CGdqye--ObaD8U8ymAMTOw-1
X-Mimecast-MFC-AGG-ID: CGdqye--ObaD8U8ymAMTOw
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e4434d78e5so38229936d6.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Feb 2025 09:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738948415; x=1739553215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xExkY7a9dfcmWWKsnQJ8PF5WnPHcZhnPPJN0QoVJGQ=;
        b=gVqglQWJvrn1b2NnntkG6FbX+wgEpqueaA/cLHORQfYqvpV9DNhE/XU8Qx4KlkUDZ1
         dQFOexYHwWFsgzIIf4TU0Xid8ueBKmGH6F4JyOnI8NcrJ2kF52WAlBKJMf2FkJOSg5Dl
         OplGu8jTHPfa8bYNIGLwYM+kBxSM4bGrlQ6Q9HPpGuOmYKFo4wzdDni5pngI4qzCS+/y
         L9B+BiWiyoQB1mNqq5QioY1nao6GD86tHGQNtNCu5XlFUVc2zpcaceU3S2BylPrVqumL
         49Nz3Z2SiQVGJrOIbLvvoD1hNtfm/t/5m+kRDxJ+n6YNq5AeaV4twTEMchYLku6BiSFR
         AdPw==
X-Forwarded-Encrypted: i=1; AJvYcCVjqZBNpTZjg3T22+n4JdP0GVNn5394vY2LHNbxmaPQ3SZ2OY6iIJI/Th2ZPNt5i4eDcNniXgEoNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YygvD8HTvmqDtAFzWfUrqXhdievHbFbDEzkSZG8aG1d3djG1J8T
	ySoRUory6VokWdJI+tGL+B5V2u7sTQIvWQ0WkIXMwvCuNb1XD2vYzixxSxbL1Y2/d0SOdQpLb//
	Gc8bsFM5XRPBxmpy/GdCz1UQBpAKC0NCgrgZ4etweOfs9q+BYgN++Ckx38bXKDkw+
X-Gm-Gg: ASbGncveEO8VxGc/GEAQLEjZ0yQgnRvSZVpIL0GWa8MyVDH5w9uABqiFp+TiYLX7elI
	UiOR5hTgLzoijpe8GS/0glKGJ3CR1c4eHF2OIfjvetoy8doqFQY7P2Urz4YvosR0L6YDyE6sYcx
	39Mtg2m1paGK3B/FV3LyUtQk926A7UVSEd4mVMrnHBStOqpPsrjp688i5lQ2nBfZZ9s7T2T3cXA
	c+dPnNGCzKzL/0FlzL+KArKIaPF+kc13naF0gompQLXfriyXWfmH1KQkTncT6aJOc/SBI91hIr5
	Ba8S
X-Received: by 2002:a05:6214:2526:b0:6e4:34ed:c571 with SMTP id 6a1803df08f44-6e445674b58mr67413606d6.27.1738948414587;
        Fri, 07 Feb 2025 09:13:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmRysRMMAuZgbKXJBfFfQlbWetjxagGtq3aooaiwcNUXxsKgWhnuH6aSZCDZB6CMm/i/IdTA==
X-Received: by 2002:a05:6214:2526:b0:6e4:34ed:c571 with SMTP id 6a1803df08f44-6e445674b58mr67413256d6.27.1738948414309;
        Fri, 07 Feb 2025 09:13:34 -0800 (PST)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44150c6e9sm14437056d6.6.2025.02.07.09.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 09:13:33 -0800 (PST)
Message-ID: <9241eff1-0c2d-4c82-a77d-cb8b67cab6f9@redhat.com>
Date: Fri, 7 Feb 2025 12:13:32 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] intel_idle: introduce 'no_native' module parameter
To: dedekind1@gmail.com, linux-pm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>,
 Prarit Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250128141139.2033088-1-darcari@redhat.com>
 <20250206164009.816232-1-darcari@redhat.com>
 <6c258775cdf2f8f3c370c0cb81daf22dacf6aeed.camel@gmail.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <6c258775cdf2f8f3c370c0cb81daf22dacf6aeed.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Artem,

On 2/7/25 10:55 AM, Artem Bityutskiy wrote:
> Hi David,
> 
> On Thu, 2025-02-06 at 11:40 -0500, David Arcari wrote:
>> +The ``no_acpi``, ``use_acpi`` and ``no_native`` module parameters are
>> +recognized by ``intel_idle`` if the kernel has been configured with ACPI
>> +support).
> 
> And if kernel was not configured with ACPI support, are these not recognized? Or
> they are just no-op basically?

They are a no-op - the flags are all set to false so ACPI C-state tables 
are ignored.

> 
> Looks like there is a stray ")" at the end.
> 

Yes I will fix that.

>> +
>> +``no_acpi`` - Do not use ACPI at all.  Only native mode is available, no
>> +ACPI mode.
>> +
>> +``use_acpi`` - No-op in ACPI mode; however, the driver will consult ACPI
>> +tables for C-states on/off status in native mode.
> 
> I think "however" part is a bit confusing. Would you consider re-phrasing
> without "however" ?

Sure - so is this better:

``use_acpi`` - No-op in ACPI mode, the driver will consult ACPI tabees 
for C-states on/off status in native mode.

Thanks,
-DA
> 
>> +
>> +``no_native`` - Work only in ACPI mode, no native mode available (ignore
>> +all custom tables).
> 
> Other than these small nitpicks,
> 
> Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> (I tested it on an Intel Broadwell platform).
> 
> Thanks!
> 


