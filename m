Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAA7135F2E
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 18:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbgAIRWC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 12:22:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33660 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgAIRWB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 12:22:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so2792592plb.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2020 09:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dBdr2bp2TFFl7ixkJ4W5VJTz5FDx1fLRLzXxqlfP9iI=;
        b=npSHhg5A7HysiwSFyABUiyDkUmg4MLsPZoUv1MSZi9gKkTxm23jfd5zTUvt85lapYj
         HENesQpqw5u4MCVmxWw0chtIQ9NK2g9mS+VMKXUd/mkJV5t88qg4EWZiDQImvB5wXALe
         fiK8qANw36Mv3BH9C2JJHm2DymHIqvVZ+nUcJIkTEq/WtLTqTagVE4JdTOD8VtaNmp+P
         JDCf2DogfkW3U1yDf/Bb2sm/pjQTQMIy6Nm+jOb8EODYjxifhQTyfrK7VeGlfAfEV19f
         9vPPGNrUSnbP2kjINgcICq4asllAgVlSJJNN6G52aRIFxutCGyhTsk9mgbWsZgp0VTVf
         M/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dBdr2bp2TFFl7ixkJ4W5VJTz5FDx1fLRLzXxqlfP9iI=;
        b=FzlZEt2S6CVjhg6gur93HL7eGRhoy3pPrC1LXz4by/bpFvBEIUnvvAiKWzwJIbC1ej
         1DLpcNPZ6Jg0uXDhJGK9PQrbSzX5t4pGxcazF+g4Ey7zj0nD9OgnaNsupBVLq29Dz7af
         N5xwIqW7f0F/EP3IhlhX7KB5SESRFOOlCpgAGpOFj5PLtq9B1qci0zQMr4IoC3jl7cGi
         P74BYXnWhgo+dw03SdNySoks10AkAYuRRSwOWmr9aTMr7QCAokuz2skK4QgO8athst62
         n/A5n82gsegRpLB+btd5KvISFdoIt1n4Dj2ZTJJfhMCyD/ZUSn8yaz13aC+qFNN5k1oJ
         YMxw==
X-Gm-Message-State: APjAAAUmyFruJQ7maumUuRJ2UsIe8fh6YWTlfFVJ/xtk5kZDj9RMRiGe
        l2cF5mrJ7xb1mq2ZTHljh5nrpw==
X-Google-Smtp-Source: APXvYqxPmVDqKmgHApiW2w+JPHBVuxxXFebEJOSq68HFM3InB9WAF+9eHewkQRvNO7oYMCtnr8l56A==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr6465809pjz.135.1578590520746;
        Thu, 09 Jan 2020 09:22:00 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b1sm4003998pjw.4.2020.01.09.09.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 09:21:59 -0800 (PST)
Date:   Thu, 9 Jan 2020 09:21:57 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, leonard.crestez@nxp.com,
        lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: Re: [PATCH 2/2] PM / devfreq: Add devfreq_transitions debugfs file
Message-ID: <20200109172157.GM738324@yoga>
References: <20200107090519.3231-1-cw00.choi@samsung.com>
 <CGME20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea@epcas1p4.samsung.com>
 <20200107090519.3231-3-cw00.choi@samsung.com>
 <20200107214834.GB738324@yoga>
 <c1e6f324-b0c2-41ff-a015-7ba0b29ad42c@gmail.com>
 <9c3574e8-945b-56c4-3425-28e68cd3d2a9@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c3574e8-945b-56c4-3425-28e68cd3d2a9@samsung.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 09 Jan 00:07 PST 2020, Chanwoo Choi wrote:

> Hi Bjorn and Dmitry,
> 
> I replied from Bjorn and Dmitry opinion.
> 
> On 1/8/20 11:20 PM, Dmitry Osipenko wrote:
> > 08.01.2020 00:48, Bjorn Andersson ??????????:
> >> On Tue 07 Jan 01:05 PST 2020, Chanwoo Choi wrote:
> >>
> >>> Add new devfreq_transitions debugfs file to track the frequency transitions
> >>> of all devfreq devices for the simple profiling as following:
> >>> - /sys/kernel/debug/devfreq/devfreq_transitions
> >>>
> >>> And the user can decide the storage size (CONFIG_NR_DEVFREQ_TRANSITIONS)
> >>> in Kconfig in order to save the transition history.
> >>>
> >>> [Detailed description of each field of 'devfreq_transitions' debugfs file]
> >>> - time_ms	: Change time of frequency transition. (unit: millisecond)
> >>> - dev_name	: Device name of h/w.
> >>> - dev		: Device name made by devfreq core.
> >>> - parent_dev	: If devfreq device uses the passive governor,
> >>> 		  show parent devfreq device name.
> >>> - load_%	: If devfreq device uses the simple_ondemand governor,
> >>> 		  load is used by governor whene deciding the new frequency.
> >>> 		  (unit: percentage)
> >>> - old_freq_hz	: Frequency before changing. (unit: hz)
> >>> - new_freq_hz	: Frequency after changed. (unit: hz)
> >>>
> >>> [For example on Exynos5422-based Odroid-XU3 board]
> >>> $ cat /sys/kernel/debug/devfreq/devfreq_transitions
> >>> time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz
> >>> ---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
> >>> 14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
> >>> 14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000
> >>> 14600      soc:bus_fsys                   devfreq4   devfreq1   0      200000000    100000000
> >>> 14600      soc:bus_fsys2                  devfreq5   devfreq1   0      150000000    75000000
> >>> 14602      soc:bus_mfc                    devfreq6   devfreq1   0      222000000    96000000
> >>> 14602      soc:bus_gen                    devfreq7   devfreq1   0      267000000    89000000
> >>> 14602      soc:bus_g2d                    devfreq9   devfreq1   0      300000000    84000000
> >>> 14602      soc:bus_g2d_acp                devfreq10  devfreq1   0      267000000    67000000
> >>> 14602      soc:bus_jpeg                   devfreq11  devfreq1   0      300000000    75000000
> >>> 14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0      167000000    84000000
> >>> 14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0      200000000    120000000
> >>> 14603      soc:bus_disp1                  devfreq14  devfreq1   0      300000000    120000000
> >>> 14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0      300000000    150000000
> >>> 14606      soc:bus_mscl                   devfreq16  devfreq1   0      333000000    84000000
> >>> 14608      soc:bus_wcore                  devfreq1              9      333000000    84000000
> >>> 14783      10c20000.memory-controller     devfreq0              35     825000000    633000000
> >>> 15873      soc:bus_wcore                  devfreq1              41     84000000     400000000
> >>> 15873      soc:bus_noc                    devfreq2   devfreq1   0      67000000     100000000
> >>> [snip]
> >>>
> >>
> >> Wouldn't it make more sense to expose this through the tracing
> >> framework - like many other subsystems does?
> > 
> > I think devfreq core already has some tracing support and indeed it
> > should be better to extend it rather than duplicate.
> > 
> 
> First of all, thanks for comments.
> 
> Before developing it, I have considered what is better to
> support debugging features for devfreq device. As you commented,
> trace event is more general way to catch the detailed behavior.
> 

It's more general, it has already dealt with the locking and life cycle
questions that was brought up by others and it allows getting traces
devfreq traces in the same timeline as other events (to give insight in
cross-framework behavior).

> But, I hope to provide the very easy simple profiling way
> for user if it is not harmful to the principle of linux kernel.
> 

You would achieve the same simplicity by integrating with the trace
framework instead of rolling your own subset of the functionality.

I know that it's the principle of the Linux kernel that everyone should
have their own ring buffer implementation, but you should try to use the
existing ones when it makes sense. And in my view this is a prime
example - with many additional benefits of doing so.

> In order to prevent the performance regression when DEBUG_FS is enabled,
> I will add the CONFIG_DEVFREQ_TRANSITIONS_DEBUG for 'devfreq_transitions'
> to make it selectable.
> 

The tracing framework has both static and dynamic mechanisms for
avoiding performance penalties when tracing is disabled and does provide
better performance than your proposal when active.

Relying on a Kconfig option means that with e.g. arm64 devices being
built from a single defconfig we will either all be missing this feature
or we will all always keep logging devfreq transitions to your buffer.

Regards,
Bjorn
