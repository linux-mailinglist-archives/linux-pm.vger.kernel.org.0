Return-Path: <linux-pm+bounces-22539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 057CDA3D9D7
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 13:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD8D189E4A8
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537B21F584D;
	Thu, 20 Feb 2025 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BA2sxox6"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F071F1523
	for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054090; cv=none; b=XCQwjp/U4ggGTWFEMlK9zvT+nhuk5NjQM9loKFlHntWVhjIRBmkVDtj/vv96BQjCpRDF+tI6qUfREpeBHTCe8IdnCReN8C/TRy07kbENOlAHrqc6SvDJB+w9FwGdZwdGKzVBTmC84fsNQYCcw+SwITFJu2Za9RukoW6G6Nh20xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054090; c=relaxed/simple;
	bh=G4WFzbUYu9lFfolRDvcn32TX+JrNB4gdpQ3zQ6MBFS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=De2PB41Z4aQBoHO6ughrv8+SCienTSeO69HebqW66cegXfQcKtgtQmLMJSA3xM61MfYqY5Esmz4zh5UOpZjGqAS8EcOSLVVbgm0OFJjUjBn8OO5gYhMyBs8rT39+lndPqedAQfMeelB94zXKAFufsGxjIOV8KuFGb8YQSBEITvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BA2sxox6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740054086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vm5MVJXgIurOEJPRVseRV9fMAcon6D5zZ8hk1lMW3L4=;
	b=BA2sxox6rGJCSdmG41HygORpWaXBCF+2KIei7+kaPctGpio7Lx3tPt/V740PctRMblkpD1
	FdUd+PgAE1gJyOeugvwjl8oH3t854PVF65H5RS/4qsViFH+XC248DnYd5z1sNgTu9HEBr0
	Prz0z2ch3z5YmoABIriOeMNasmRGbPk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-JnH-UJZBOBWx0yxi4i8lNw-1; Thu, 20 Feb 2025 07:21:25 -0500
X-MC-Unique: JnH-UJZBOBWx0yxi4i8lNw-1
X-Mimecast-MFC-AGG-ID: JnH-UJZBOBWx0yxi4i8lNw_1740054085
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c0a8583e60so149507185a.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 04:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054085; x=1740658885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vm5MVJXgIurOEJPRVseRV9fMAcon6D5zZ8hk1lMW3L4=;
        b=MVPhhI4hUnR1eTkk0IZLz5XYoS0RgEZtyBgdaSGuH59ijRMHvInZEJwiUEQD9hcrJr
         uPTrUZFYWzt5IofttAluaxlINOjcg1k6idNLXN733NTIhCk8cEkdA9kylHezOUGGNZ3Q
         1BrBCHB6sdHs4YXccjeqQ1v0h00vxtKeUz5BYmi6YA9qIqHlRkI4qS2tqKl8tStniBhl
         VQvJIqzcRXQJdrTQw+WwKoOzEFSbRH6pP8ROceZ6kVSYlzrAjL7fGwGpzMvh64iwmFAG
         L1lGvn0Du+8s0mEUHxlVcj/w1SFaN1ImoXgreQknqdAG4ClltsbsINI6+yfRnekBlG6y
         bgCQ==
X-Gm-Message-State: AOJu0Yw2ky6H68s3jUEUkb+q8QKXcWrOdJRsYukJ37/C9mJ9rgk8g+CT
	8V55RuRwjwbD1wIRAXp9mTtOJyNJvDGnPT82FJSk2GEirwwb9OCH+6hrJDofT9UolYsnfJrNteN
	dioZEWPAlF9zYk5ItNnA3COszLQUgzxzcbmak1eKDmh3P6EnmIykW/Ibo
X-Gm-Gg: ASbGncsFZBVzipe62X15SAoqsWIUGo4d+B8q9cJgEwC1BqMNadhy97h/LSHusmi0r6I
	hrA6bvTNDN2hLr2/6nUL8AG7jqF7bqtCaLWg/8OzzndBLblp24cZngqcFnz0jj3GJhwWUtGbZ31
	SQxXQeOUfM1O6vcQWHumEet0IQKFwjqr0I8oG6+Q2sJyMcH254unPZy1AinixErbNTdMKXyfN16
	IuLkF/a4H+dPFdrfkRrbdUC6+8g3nGPIVpAWAPpq1dSabCzWv9kH+TkFu73jTA8INLRT533ymBj
	lLPG
X-Received: by 2002:a05:620a:1a1b:b0:7c0:8306:1b63 with SMTP id af79cd13be357-7c0b5366543mr1106766485a.55.1740054084964;
        Thu, 20 Feb 2025 04:21:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJi6k2Wr4Fpd9iX+j88GJ8Ngi4ATiMfXbK8KqmuSfpODekq3owHmWB+d740Eh8Dc2wWajT+g==
X-Received: by 2002:a05:620a:1a1b:b0:7c0:8306:1b63 with SMTP id af79cd13be357-7c0b5366543mr1106763585a.55.1740054084619;
        Thu, 20 Feb 2025 04:21:24 -0800 (PST)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ae3fa256sm307219185a.0.2025.02.20.04.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 04:21:24 -0800 (PST)
Message-ID: <98c470f1-5c15-4075-958b-9f35e41005c1@redhat.com>
Date: Thu, 20 Feb 2025 07:21:23 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] intel_idle: introduce 'no_native' module parameter
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Len Brown <lenb@kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>,
 Prarit Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250128141139.2033088-1-darcari@redhat.com>
 <20250213160741.445351-1-darcari@redhat.com>
 <CAJZ5v0gUfp+ueLMr1arwgK0r3WAQmfbb7YB54oZP-ySkD0q6YQ@mail.gmail.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <CAJZ5v0gUfp+ueLMr1arwgK0r3WAQmfbb7YB54oZP-ySkD0q6YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

On 2/19/25 4:27 PM, Rafael J. Wysocki wrote:
> On Thu, Feb 13, 2025 at 5:07 PM David Arcari <darcari@redhat.com> wrote:
>>
>> Since commit 18734958e9bf ("intel_idle: Use ACPI _CST for processor models
>> without C-state tables") the intel_idle driver has had the ability to use
>> the ACPI _CST to populate C-states when the processor model is not
>> recognized. However, even when the processor model is recognized (native
>> mode) there are cases where it is useful to make the driver ignore the per
>> cpu idle states in lieu of ACPI C-states (such as specific application
>> performance). Add the 'no_native' module parameter to provide this
>> functionality.
>>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: David Arcari <darcari@redhat.com>
>> Cc: Artem Bityutskiy <dedekind1@gmail.com>
>> Cc: Prarit Bhargava <prarit@redhat.com>
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: David Arcari <darcari@redhat.com>
>> ---
>> v4: fix !CONFIG_ACPI_PROCESSOR_CSTATE compilation issue
>> v3: more documentation cleanup
>> v2: renamed parameter, cleaned up documentation
>>
>> Documentation/admin-guide/pm/intel_idle.rst | 18 +++++++++++++-----
>>   drivers/idle/intel_idle.c                   | 16 ++++++++++++++++
>>   2 files changed, 29 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/admin-guide/pm/intel_idle.rst
>> index 39bd6ecce7de..5940528146eb 100644
>> --- a/Documentation/admin-guide/pm/intel_idle.rst
>> +++ b/Documentation/admin-guide/pm/intel_idle.rst
>> @@ -192,11 +192,19 @@ even if they have been enumerated (see :ref:`cpu-pm-qos` in
>>   Documentation/admin-guide/pm/cpuidle.rst).
>>   Setting ``max_cstate`` to 0 causes the ``intel_idle`` initialization to fail.
>>
>> -The ``no_acpi`` and ``use_acpi`` module parameters (recognized by ``intel_idle``
>> -if the kernel has been configured with ACPI support) can be set to make the
>> -driver ignore the system's ACPI tables entirely or use them for all of the
>> -recognized processor models, respectively (they both are unset by default and
>> -``use_acpi`` has no effect if ``no_acpi`` is set).
>> +The ``no_acpi``, ``use_acpi`` and ``no_native`` module parameters are
>> +recognized by ``intel_idle`` if the kernel has been configured with ACPI
>> +support.  In the case that ACPI is not configured these flags have no impact
>> +on functionality.
>> +
>> +``no_acpi`` - Do not use ACPI at all.  Only native mode is available, no
>> +ACPI mode.
>> +
>> +``use_acpi`` - No-op in ACPI mode, the driver will consult ACPI tables for
>> +C-states on/off status in native mode.
>> +
>> +``no_native`` - Work only in ACPI mode, no native mode available (ignore
>> +all custom tables).
>>
>>   The value of the ``states_off`` module parameter (0 by default) represents a
>>   list of idle states to be disabled by default in the form of a bitmask.
>> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>> index 118fe1d37c22..b0be5ef43ffc 100644
>> --- a/drivers/idle/intel_idle.c
>> +++ b/drivers/idle/intel_idle.c
>> @@ -1695,6 +1695,10 @@ static bool force_use_acpi __read_mostly; /* No effect if no_acpi is set. */
>>   module_param_named(use_acpi, force_use_acpi, bool, 0444);
>>   MODULE_PARM_DESC(use_acpi, "Use ACPI _CST for building the idle states list");
>>
>> +static bool no_native __read_mostly; /* No effect if no_acpi is set. */
>> +module_param_named(no_native, no_native, bool, 0444);
>> +MODULE_PARM_DESC(no_native, "Ignore cpu specific (native) idle states in lieu of ACPI idle states");
>> +
>>   static struct acpi_processor_power acpi_state_table __initdata;
>>
>>   /**
>> @@ -1834,6 +1838,11 @@ static bool __init intel_idle_off_by_default(unsigned int flags, u32 mwait_hint)
>>          }
>>          return true;
>>   }
>> +
>> +static inline bool ignore_native(void)
>> +{
>> +       return no_native & !no_acpi;
>> +}
>>   #else /* !CONFIG_ACPI_PROCESSOR_CSTATE */
>>   #define force_use_acpi (false)
>>
>> @@ -1843,6 +1852,7 @@ static inline bool intel_idle_off_by_default(unsigned int flags, u32 mwait_hint)
>>   {
>>          return false;
>>   }
>> +static inline bool ignore_native(void) { return false; }
>>   #endif /* !CONFIG_ACPI_PROCESSOR_CSTATE */
>>
>>   /**
>> @@ -2328,6 +2338,12 @@ static int __init intel_idle_init(void)
>>          pr_debug("MWAIT substates: 0x%x\n", mwait_substates);
>>
>>          icpu = (const struct idle_cpu *)id->driver_data;
>> +       if (ignore_native()) {
>> +               if (icpu) {
>> +                       pr_debug("ignoring native cpu idle states\n");
>> +                       icpu = NULL;
>> +               }
>> +       }
> 
> Why not
> 
> +       if (icpu && ignore_native()) {
> +              pr_debug("disregarding built-in CPU idle states table\n");
> +              icpu = NULL;
> +       }

That's cleaner.  I'll submit a v5 shortly.

Should the pr_debug be a pr_info?  I've waffled on this, but think that 
pr_info is probably a good idea.  Or do you prefer pr_debug?

Thanks,
-DA

> 
>>          if (icpu) {
>>                  if (icpu->state_table)
>>                          cpuidle_state_table = icpu->state_table;
>> --
> 


