Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47CD1E41DF
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 04:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391411AbfJYCxx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 22:53:53 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:39867 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389230AbfJYCxx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 22:53:53 -0400
Received: by mail-pf1-f177.google.com with SMTP id v4so554992pff.6
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2019 19:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LIAxzZdUB/yYNUMYUR2KW+Y1d8eGDKKE+QAPPE4WwsY=;
        b=Vz7o7lQSTD6qHd8pLVTzTEbjC3I5zYa86pniTc6E8MwTONeHhHKlqf9rq+Iniayq4x
         QuxjKOVu3+KCRr/GpbvTRqba9Cm+o+aa8CQo89l8JfaCutV5qrAvKWQ/xt1sNqbHZqp9
         Mkcp1qd/TLYt+odIYQb1Lh7gKcSnRu+SriiDu3NSZYv1lbI944GPXRgD3z7mx+E5UOqa
         pej0kWb1PQSK8A7e+1AtvSm3jNGi6510Tb/zdjFj1c0FiugBs2nTj6vuWARJh+/jHYpZ
         BtGzS0J3f/hi/saT+EcgO59Yta52WpgIqIGAjDTwXJyIG0bPtxlikXRcpG9wkTZ+EMIM
         w92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LIAxzZdUB/yYNUMYUR2KW+Y1d8eGDKKE+QAPPE4WwsY=;
        b=huXjJjWiGee4toMzQd8EKIdALX6kqXhjqKmlCfdLn5CztuhPzqs4WNTjmuYj3m2h+I
         eImgNYSM4TFOK7AvrodzIyZ+8Cpf28+u3V5IBggdBofRqGGomaKUCI+59jqqb7B4KbA4
         vizOTy1QI6mStAoYN5zpLUIk0glwr/d5v+OV+xQFShZlaiuVAHY4Wz/9GPLHN1Uf7XLM
         JznkYMPdaL1d1dLbSJ+3jkTDaVE+IvbZE31VeVIZEnd16Kzc5ULR9T6hfOuQF5qZ1qTp
         5dozI21jg4rtah8mktComdfo8nRXAYbfBJ5UXIS4neE6lHG6N8pCkYphAt/gZcpEwYo4
         KNyg==
X-Gm-Message-State: APjAAAXi0U1KLt1PNTsE8UJm/9OeDg7EBM8+8orrKZQxy3AV74oCSBiT
        sXQsXHS4oAwgYrWCaEH32OKr+vufWyc=
X-Google-Smtp-Source: APXvYqw6+uxpZOQ1bKlEOo2fMWZXsuQqMpl1CAftf0fRvSZKWwcW1De5GpA5fGKl8LGe6rGoWu23rA==
X-Received: by 2002:a65:62d1:: with SMTP id m17mr1482308pgv.284.1571972030760;
        Thu, 24 Oct 2019 19:53:50 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id m65sm4232784pje.3.2019.10.24.19.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 19:53:49 -0700 (PDT)
Date:   Fri, 25 Oct 2019 08:23:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: processor: Add QoS requests for all CPUs
Message-ID: <20191025025343.tyihliza45os3e4r@vireshk-i7>
References: <2435090.1mJ0fSsrDY@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2435090.1mJ0fSsrDY@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-10-19, 02:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The _PPC change notifications from the platform firmware are per-CPU,
> so acpi_processor_ppc_init() needs to add a frequency QoS request
> for each CPU covered by a cpufreq policy to take all of them into
> account.
> 
> Even though ACPI thermal control of CPUs sets frequency limits
> per processor package, it also needs a frequency QoS request for each
> CPU in a cpufreq policy in case some of them are taken offline and
> the frequency limit needs to be set through the remaining online
> ones (this is slightly excessive, because all CPUs covered by one
> cpufreq policy will set the same frequency limit through their QoS
> requests, but it is not incorrect).
> 
> Modify the code in accordance with the above observations.

I am not sure if I understood everything you just said, but I don't
see how things can break with the current code we have.

Both acpi_thermal_cpufreq_init() and acpi_processor_ppc_init() are
called from acpi_processor_notifier() which is registered as a policy
notifier and is called when a policy is created or removed. Even if
some CPUs of a policy go offline, it won't matter as the request for
the policy stays and it will be dropped only when all the CPUs of a
policy go offline.

What am I missing ?

-- 
viresh
