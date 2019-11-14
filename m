Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0ADFC1C2
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 09:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfKNInb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 03:43:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46526 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNInb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 03:43:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id 193so3676329pfc.13
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 00:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dtXf1cklkEILsdJe1BKmSn+H2sUj3L7wyP1UZ92tPKI=;
        b=Mok+lx5+2tneGl5Q8292wQfcG9ogwNvHx+Af4Ura3ONzfPqpaD6F17vKXMnxIc10pU
         RVKMLLwuCR/6CFa3UmeJrWMtPspfYbxvTQJz/hAFRtNQVh5dAMx8Ez4/HBuDFzENGkI1
         H4j+J+m3Bm5r9flMQlValkUQyEgmoGc2HyHv3c+mrb/+wp5eAt/a4z3YjPhiq/KGeYsp
         dNTpZb3jeMYiSdlie+3XeGPS/WA/CpjgqZQG1p3FpOf5VT+Fdre2/1acs/fjrif2fPux
         3hos112hB2n3qnkSKih/VkNHkhWtkC45liABkgQpZggOinzG18NdqlN7zH4JV0Nznrhh
         nVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dtXf1cklkEILsdJe1BKmSn+H2sUj3L7wyP1UZ92tPKI=;
        b=nvWQzwopKkfTKcQkR7TQWebP5Od41io4Jg7wdh+xFlMsQNuOqVQ9b9Tl/+3yA3qFMw
         FFbO5LRLO5xEGESYyxBd1BmEU62RAK9oNxS4PPvZC14yEhhtZCxPN0lqWbQOr0etVudu
         yMTqK/pKrYqkjQpm9uKLOrOSvEPYbCAy4D0bkiA46ABdl1Ry7GO1RO0I3bsQ4NPlEpTV
         kutA4R3Aujex5F+F3Lf3bHLhrCIaVPz0z/Xv2c4sUMgHg8ju8r5bCTmB9osd2U/t2APO
         w++nlGEOUSjjNrFylzCBiXnGfuzxbKjiKvzYF4E75IAv0QAkFo3RL0Sf6RIsXbAMOfRO
         Ubtg==
X-Gm-Message-State: APjAAAVUTcB7KDxFhS2/Aazcmx7lfBgggXM1DbFgT2zhN88eZoy7KMnf
        bvSh2PBo5/f3/3I0P8Br1/X1DA==
X-Google-Smtp-Source: APXvYqyYhTC0ce+qbjrbGFQFfaNT3sAvLA5TGFmVIHESn/S8uxnmD9nXoKF3hLsxV8VXjaDGQHLtxQ==
X-Received: by 2002:a63:1402:: with SMTP id u2mr8732447pgl.391.1573721010376;
        Thu, 14 Nov 2019 00:43:30 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id z7sm7012468pfr.165.2019.11.14.00.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 00:43:29 -0800 (PST)
Date:   Thu, 14 Nov 2019 14:13:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Register cpufreq drivers only after CPU devices
 are registered
Message-ID: <20191114084327.ra5hnpizeffxzis2@vireshk-i7>
References: <c60806d5480b7311ced8db07ff239aa5af7a050d.1573702497.git.viresh.kumar@linaro.org>
 <CAJZ5v0jPkP4Nu2zbWuCGCtiBMQcnfaAOdm-GW1KX81GsyV_Cdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jPkP4Nu2zbWuCGCtiBMQcnfaAOdm-GW1KX81GsyV_Cdg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-11-19, 09:40, Rafael J. Wysocki wrote:
> On Thu, Nov 14, 2019 at 4:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > The cpufreq core heavily depends on the availability of the struct
> > device for CPUs and if they aren't available at the time cpufreq driver
> > is registered, we will never succeed in making cpufreq work.
> >
> > This happens due to following sequence of events:
> >
> > - cpufreq_register_driver()
> >   - subsys_interface_register()
> >   - return 0; //successful registration of driver
> >
> > ... at a later point of time
> >
> > - register_cpu();
> >   - device_register();
> >     - bus_probe_device();
> >       - sif->add_dev();
> >         - cpufreq_add_dev();
> >           - get_cpu_device(); //FAILS
> >   - per_cpu(cpu_sys_devices, num) = &cpu->dev; //used by get_cpu_device()
> >   - return 0; //CPU registered successfully
> >
> > Because the per-cpu variable cpu_sys_devices is set only after the CPU
> > device is regsitered, cpufreq will never be able to get it when
> > cpufreq_add_dev() is called.
> >
> > This patch avoids this failure by making sure device structure of at
> > least CPU0 is available when the cpufreq driver is registered, else
> > return -EPROBE_DEFER.
> >
> > Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > @Amit: I have added your sob without asking as you were involved in
> > getting us to this patch, you did a lot of testing yesterday to find the
> > root cause.
> 
> Co-developed-by is for that, so I used it in the commit.
> 
> > @Rafael: This fixes the issues reported by Bjorn on Amit's series and so
> > should land before Amit's series, if at all this is acceptable to you.
> 
> Well, yes it is.
> 
> Applied for 5.5 with a reworded subject, thanks!

Thanks.

-- 
viresh
