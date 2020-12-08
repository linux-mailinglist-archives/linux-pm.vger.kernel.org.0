Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC832D36EF
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 00:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgLHXc2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 18:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgLHXc1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 18:32:27 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E749CC0613CF;
        Tue,  8 Dec 2020 15:31:41 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t3so13664713pgi.11;
        Tue, 08 Dec 2020 15:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lpfVDguGDyrEWkSY8dCZf2JjX0LDrKbc5iVzSIp5LgU=;
        b=hR2Qtn2JADmgo0f/O6KupgUHz/LI6+QTySBQYwwXyZuTs3Qn6Xf6QLMc6bL5/RyqSM
         iGMmOwfhxubzvqoxBmojoF5uQNT1VS6cQlMlCvX9+a34pxwru8sdZKpRIxn8Myb/OKOS
         fAmnUsQpvDDElUbSZwfF6SIKEQBpp7sFMtrZ/7iy6ad+Z9ZYRCy5p3QpwLiMFLSw9+2u
         FHoqm9rdi0wer9v2h7NraUcmvxlSkzejotHqPa2hK7MNplJtgEXc6dJBdSnKwUTxcbrU
         2CtljOrZBUhYJQOEd94BfHYaxfmFUJSAOgRL4L/vHnodyMS9GLDhbNb7RpqXd1OMrdiP
         HOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=lpfVDguGDyrEWkSY8dCZf2JjX0LDrKbc5iVzSIp5LgU=;
        b=EWGvP7WLwYPP9d8BDgrK0M7WotzU497bPvqWFX4SD8Vz3WpFQ/SxF8NfVPNr8omUTu
         kcA4kM0Y1bzeFvuU/T3O1t52sjuscrqp1QQ7iNVjQFufj0UOIqhNjO62/ul8dTNUFntU
         Z/I9INRSSXFHN8BRH3x0hpsWlGs/O3TQclHo448RHZR3jlVuNcf0RNYpunKQtK30+iF4
         ttwe9YWpnvEF/3CfOviF0xBaC9qVSOywFsnHRD1w634rXQiWRKYDxZGZSsON9qyObYib
         uwq+4gBLG6bYyEYBArpbKaEwjG3+RVe3mHSSW2cukW5SoZT3/EbOdprtStRH5aMorhyN
         1MOg==
X-Gm-Message-State: AOAM531NU7inr7prbi5KoQ5Gjy03GVwijTgmqpvWR8AuvadIES61K/EU
        wKIYq95NM2kXkUSUcz9gpzQ7/JhPp30BNlAb+CY=
X-Google-Smtp-Source: ABdhPJx8Xv3qz1j3UzxnU/yeWpZww1hzaEuOkcOD1LeLf+uLjptM0OCHgc9cZuafl4GCZkM0SbC6fQ==
X-Received: by 2002:a63:5010:: with SMTP id e16mr383174pgb.422.1607470301500;
        Tue, 08 Dec 2020 15:31:41 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id d6sm245582pfo.199.2020.12.08.15.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 15:31:40 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Wei Huang <whuang2@amd.com>
Cc:     rjw@rjwysocki.net, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bp@alien8.de, x86@kernel.org
Subject: Re: [RFC PATCH 1/4] cpufreq: acpi-cpufreq: Re-factor overriding
 ACPI PSD
References: <20201125144847.3920-1-punitagrawal@gmail.com>
        <20201125144847.3920-2-punitagrawal@gmail.com>
        <52d9b72c-5935-c28c-21cf-b24c6928de81@amd.com>
Date:   Wed, 09 Dec 2020 08:31:38 +0900
In-Reply-To: <52d9b72c-5935-c28c-21cf-b24c6928de81@amd.com> (Wei Huang's
        message of "Mon, 7 Dec 2020 13:29:03 -0600")
Message-ID: <87y2i7oox1.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Wei,

Wei Huang <whuang2@amd.com> writes:

> On 11/25/20 8:48 AM, Punit Agrawal wrote:
>> Re-factor the code to override the firmware provided frequency domain
>> information (via PSD) to localise the checks in one function.
>> 
>> No functional change intended.
>> 
>> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
>> Cc: Wei Huang <wei.huang2@amd.com>
>> ---
>>  drivers/cpufreq/acpi-cpufreq.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>> index 1e4fbb002a31..b1e7df96d428 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -191,6 +191,20 @@ static int check_amd_hwpstate_cpu(unsigned int cpuid)
>>  	return cpu_has(cpu, X86_FEATURE_HW_PSTATE);
>>  }
>>  
>> +static int override_acpi_psd(unsigned int cpu_id)
>          ^^^^^
> int is fine, but it might be better to use bool. Otherwise I don't see
> any issues with this patch.

Makes sense - I will switch to a boolean in the next update.

Thanks for taking a look.

Punit

>
>> +{
>> +	struct cpuinfo_x86 *c = &boot_cpu_data;
>> +
>> +	if (c->x86_vendor == X86_VENDOR_AMD) {
>> +		if (!check_amd_hwpstate_cpu(cpu_id))
>> +			return false;
>> +
>> +		return c->x86 < 0x19;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>  static unsigned extract_io(struct cpufreq_policy *policy, u32 value)
>>  {
>>  	struct acpi_cpufreq_data *data = policy->driver_data;
>> @@ -691,8 +705,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>  		cpumask_copy(policy->cpus, topology_core_cpumask(cpu));
>>  	}
>>  
>> -	if (check_amd_hwpstate_cpu(cpu) && boot_cpu_data.x86 < 0x19 &&
>> -	    !acpi_pstate_strict) {
>> +	if (override_acpi_psd(cpu) && !acpi_pstate_strict) {
>>  		cpumask_clear(policy->cpus);
>>  		cpumask_set_cpu(cpu, policy->cpus);
>>  		cpumask_copy(data->freqdomain_cpus,
>> 
