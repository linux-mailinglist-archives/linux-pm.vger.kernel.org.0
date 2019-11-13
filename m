Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4710F9F4D
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 01:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKMAan (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 19:30:43 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42410 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfKMAan (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 19:30:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id q17so119930pgt.9
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2019 16:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q255pVhVuoq1jRHKaF0XnAkw/D7Ep/OqDcaVole5ol8=;
        b=I8mJBV2Hym2i6OFGHQfoLXYcyshvXngBApr/e3oxxtonq/+EDelm1NjltFabtX9Aky
         oV7MTkYtLb04x8iEqjZaUZrVQSd8nCCTZnw3bWuJW0TSrQKwL4au9ogsHi8n9QyY9z/x
         HKxlwXmQQU1/GdaVPGBjL28b/pP4/p7vSTgUeOgMlUITVQNH76UAI0UO9aLX6Rdc7v/e
         kpGknF+K6dsPg4S+uqTrpdklNYyDJ+IlI/8FjMYfPUpf+h+/Aq/VeMpTO5Zn5A7andnO
         SamWbadzDdMTQoxNexpVDplXa1nQtlwSZ1zKQs4PlS147I+3yGVro89/5jJ09KvJyX/V
         vMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q255pVhVuoq1jRHKaF0XnAkw/D7Ep/OqDcaVole5ol8=;
        b=CMCQJmT9QiJrtqWZKZNm8oyN+gYRfwPXGbkjRjC03LDhRy/cSkuje765JdBSUFqdvQ
         Ts5oajFVJBX2zItO3qs4r7HB9kV7BleRaEOHf0I5NzxgIoyD5oKP/BEaVGu1YQoU1sQd
         Gbqkj41C+qAttLhltrkYSzD/BdSMTROPfAESeNSfO71lDhd5xzLtls1ThPYG3PD2tfjV
         o8ENsP0RvehdFVi6P5d6biVL/5E3iPL62epVPw6RD63WnciL0y6zAMDdVPVKCF8uOsTd
         9shMzZqgCFd2VnXlLL1h+SRqDPQtq1RH66HzT4EsbCLm4vvCJIV1bIYEP9Alyj1nabfz
         e+sQ==
X-Gm-Message-State: APjAAAXYZny/3DvpLWSOqaJN3640hnbepkTkvLyw20VE5bZ8lX7MiTGA
        q29rUcZUi6jJ05eokEbl+M6s7w==
X-Google-Smtp-Source: APXvYqyKYoTasYQVQBJZt/sE02pUXLLkEGeQ9E8IHDrU7vF4AyOKWvmcjwXNRcuyn5fZrXEUF+vPAg==
X-Received: by 2002:a63:c54e:: with SMTP id g14mr317356pgd.435.1573605040663;
        Tue, 12 Nov 2019 16:30:40 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k190sm175851pga.12.2019.11.12.16.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 16:30:39 -0800 (PST)
Date:   Tue, 12 Nov 2019 16:30:36 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 6/6] cpufreq: qcom-hw: Move driver initialisation
 earlier
Message-ID: <20191113003036.GA3143381@builder>
References: <cover.1571387352.git.amit.kucheria@linaro.org>
 <3d367762ba72fa1cbd6391dc55d94b3284f6c00c.1571387352.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d367762ba72fa1cbd6391dc55d94b3284f6c00c.1571387352.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 18 Oct 01:52 PDT 2019, Amit Kucheria wrote:

> Allow qcom-hw driver to initialise right after the cpufreq and thermal
> subsystems are initialised in core_initcall so we get earlier access to
> thermal mitigation.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Taniya Das <tdas@codeaurora.org>

Hi Amit,

Booting linux-next on my db845c (and SDM850 laptop) I can see that the
device probes in /sys/bus/platform/drivers/qcom-cpufreq-hw, but
/sys/devices/system/cpu/cpufreq is empty.

Reverting this change gives me cpufreq back. Can you please have a look
at this?

Regards,
Bjorn

> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index a9ae2f84a4efc..fc92a8842e252 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -334,7 +334,7 @@ static int __init qcom_cpufreq_hw_init(void)
>  {
>  	return platform_driver_register(&qcom_cpufreq_hw_driver);
>  }
> -device_initcall(qcom_cpufreq_hw_init);
> +postcore_initcall(qcom_cpufreq_hw_init);
>  
>  static void __exit qcom_cpufreq_hw_exit(void)
>  {
> -- 
> 2.17.1
> 
