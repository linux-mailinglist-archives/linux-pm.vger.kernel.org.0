Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04433AFD6C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 08:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFVGzS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 02:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFVGzS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 02:55:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16647C06175F
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 23:53:03 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y4so8666985pfi.9
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 23:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A+0Tg8/ehjkNNlYZ11nZ7l0NXx3B5Abt3YljTUc7YIU=;
        b=uWmEAgaeRHW4CpBeXjy8FKqCGke5BEp9kO0ZEsSZ8nwqjUF983zd0m1yPQnjszkTSW
         kh7LcDUJr70ThCHIXmfm6ftXOk3sMiPBK0SUwXtuRxzevg/1cWO+4dC5A7uHF3UtsgFs
         VLf0x+msmNGcD7Ffqfn5k+x7I3eiz9/kwwWYnV+eRdI9fQosHGWONKtqE3k2kt56RfFX
         UQnC/woA/zwGy6Oss6cm8cvkhx9RkMqisj6/2KtK1NQIxwVInznALAeDgbVpuQTTi4sf
         +IXV+er/DCTxt0gsRO+3VfAPD5iYW6y+9ZWQ0St8goS7np2SmkRoVg3IfpeHs1Aiicul
         GfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A+0Tg8/ehjkNNlYZ11nZ7l0NXx3B5Abt3YljTUc7YIU=;
        b=dph2lFHyxRU8YPj5705qo1kv9qlqqQu9G7qJ5BOq7dlQfAuLLTJK03gSjPxtgLK/kb
         r0bSg6NXg+Ek+oJi4Y/MG/MDQpDOKCpyGhiiVJk9gM43QbYxL1MiRWbvJ2BcAbG6Xg6p
         T9IOYp/oAW1TOE0ER1snnVhyGoGUa8hzbWp7i88J2dKHu+UseEQqL7JiMh6JdAe71wPG
         7+k1BR3E9vBfw8k56EBOKd4N7WkangZb04qUY7NFNimQTgbFgoqyy+3XH5ccGeYUweR9
         Q/oG6cluU0KgBx6nPhWPd/H3QMKTX1YiRiyGgVngfbf+ztOivaEe1MfZxjMMwcejE1kx
         44zg==
X-Gm-Message-State: AOAM5324e6FaTGS6Y1Sc8duITkb4RWxcj84Db1DFVMkRZnmHfnr9ZaXV
        96O/V1nGqESJt7KHDdUGcgV/zHADmdtjlA==
X-Google-Smtp-Source: ABdhPJwTv7IAJoT5FFohk3D27niTo2XcR1hBZCqcYQMKOKAEs1KAKdzTzVz31HlrSO0yKq4m3T1Bpg==
X-Received: by 2002:a63:4a18:: with SMTP id x24mr2311757pga.303.1624344782512;
        Mon, 21 Jun 2021 23:53:02 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id d20sm14848939pfn.219.2021.06.21.23.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 23:53:02 -0700 (PDT)
Date:   Tue, 22 Jun 2021 12:22:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency
 invariance
Message-ID: <20210622065259.nw3e7ajwgzgnlm5e@vireshk-i7>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <09a39f5c-b47b-a931-bf23-dc43229fb2dd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09a39f5c-b47b-a931-bf23-dc43229fb2dd@quicinc.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-06-21, 16:48, Qian Cai wrote:
> Viresh, this series works fine on my quick tests so far.

Thanks for testing.

> BTW, I
> noticed some strange things even with the series applied mentioned
> below when reading acpi_cppc vs cpufreq sysfs. Do you happen to know
> are those just hardware/firmware issues because Linux just
> faithfully exported the register values?

The values are exported by drivers/acpi/cppc_acpi.c I believe and they
look to be based on simple register reads.

> == Arm64 server Foo ==
> CPU max MHz:                     3000.0000
> CPU min MHz:                     1000.0000
> 
> /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf
> 300
> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq
> 1000
> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf
> 200
> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf
> 100
> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq <--- should be 3000?
> 2800
> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf <--- should be 300?
> 280

nominal-perf is max perf, and highest-perf is boost-perf. Same goes
with nominal-freq (i.e. policy->max).

So 280 and 2800 look to be the correct values, 300 and 3000 come with
boost enabled. Look at the first entry, highest_perf.

> /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf
> 100
> 
> == Arm64 server Bar ==
> CPU max MHz:                     3000.0000
> CPU min MHz:                     375.0000
> 
> /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf <--- should be 3000? There is no cpufreq boost.
> 3300

This isn't exported by cpufreq driver but acpi, and it just exports
hardware values of highest_perf (with boost i.e.). cpufreq may or
may not use this to support boost.

> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq <--- don't understand why 0.
> 0

Because corresponding hardware registers aren't implemented for your
platform, this is the function that reads these registers:

int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
{
        ...

	/* Read optional lowest and nominal frequencies if present */
	if (CPC_SUPPORTED(low_freq_reg))
		cpc_read(cpunum, low_freq_reg, &low_f);

	if (CPC_SUPPORTED(nom_freq_reg))
		cpc_read(cpunum, nom_freq_reg, &nom_f);

	perf_caps->lowest_freq = low_f;
	perf_caps->nominal_freq = nom_f;
}

> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf
> 375
> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf
> 375
> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq <--- ditto
> 0
> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf
> 3000
> /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf
> 100

-- 
viresh
