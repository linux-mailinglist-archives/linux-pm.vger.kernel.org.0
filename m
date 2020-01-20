Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAC4142EBD
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 16:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgATP2K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 10:28:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54321 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgATP2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 10:28:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so14866501wmj.4
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2020 07:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w+9WBX8T8487sYdaCRBOXdftKEOOIGARUU12ptPCXoI=;
        b=WM3/QuTjf8YHugRgHr0CAc4EPmW7lL5TBdACtz7cIwWejTZRMsjvhvpYDk1vBCv8x/
         mwSEMBD6BloK3XpD4M9pIYUXdWrL2+620dZ1+sv7VzGqnDERmsL63ChlF8tg20oIUyHN
         52ASdnLuNO3Sz8qauPMfDhgnCWpxUMumc6RftxuofGduJ6V4Ri+m9/ezp6kMCpjP0Cag
         AtFqAedbPek8I2J21QlxubzVd67+p4k75DZEBCr6gQdRH2dUKnHDTWK3kJyHePYYwXMd
         8gKlHjdsZ26gCY4wieLh8B5FzXN/qNQg1wHFrQ0GWe3qX7B5O2cOpVF0DpGUbwhfDz+P
         oqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w+9WBX8T8487sYdaCRBOXdftKEOOIGARUU12ptPCXoI=;
        b=SPAC2qpH9XDR0nORmTL9az+f4Z2DJqViwAE02gObd75/Z4tbnH+nEMGgLtcycq0H5l
         iZW3aDnXiBAXtxfsOlLbpf34mmKQsFqcTANxs8/JPnwq2/nYSyTGNyCW2KqR9THTtn3s
         9JqWpyQmKZ0QgIQNg6oo4nVVKRnKu4tGdWfJdHXgPblQ9yNkrgK4DdJM4Y5Hts/dcOFG
         na1CbKiomay+jgiXdj1qgoiYbXq43s1ePrqIrpMsJl0ffAmk7M+O+TfLipG4ORk2kgo4
         FUZwwsizwDYjEToPUXTqTAWY8F3kwJJVyVSLMIpihWub4w6lTiSdd7VCwDYQvNGnXkbf
         PPVw==
X-Gm-Message-State: APjAAAUybua9ZsXDYoBTY8t3l3rWSuxU6ipOGiKGaOcZd9jaJuT2eqLP
        HRD9pNaBVs4w0eGBBxlROZ6MJQ==
X-Google-Smtp-Source: APXvYqxyY0xjDcRn7kSUge9Pe/ZJykQdMkCOLrQxdDGvp71dWPGzFxihXcV4Py+Y8+/t7qRz+k6uxg==
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr19453471wmg.34.1579534088409;
        Mon, 20 Jan 2020 07:28:08 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id d14sm51225920wru.9.2020.01.20.07.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 07:28:07 -0800 (PST)
Date:   Mon, 20 Jan 2020 15:28:04 +0000
From:   Quentin Perret <qperret@google.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Morten.Rasmussen@arm.com, Chris.Redpath@arm.com,
        ionela.voinescu@arm.com, javi.merino@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, patrick.bellasi@matbug.net
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
Message-ID: <20200120152804.GB164543@google.com>
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
 <17b77e0c-9455-0479-d37b-c57717c784c7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17b77e0c-9455-0479-d37b-c57717c784c7@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday 20 Jan 2020 at 15:53:35 (+0100), Dietmar Eggemann wrote:
> Would be really nice if this wouldn't be required. We should really aim
> for 1 framework == 1 set of interfaces.
> 
> What happens if someone calls em_get_pd() on a CPU EM?
> 
> E.g:
> 
>  static struct perf_domain *pd_init(int cpu)
>  {
> -       struct em_perf_domain *obj = em_cpu_get(cpu);
> +       struct device *dev = get_cpu_device(cpu);
> +       struct em_perf_domain *obj = em_pd_get(dev);
>         struct perf_domain *pd;
> 
> Two versions of one functionality will confuse API user from the
> beginning ...

Agreed, this looks a bit confusing. It should be trivial to make
em_dev_get() (or whatever we end up calling it) work for CPUs too,
though. And we could always have a em_cpu_get(int cpu) API that is a
basically a wrapper around em_dev_get() for convenience.

Thanks,
Quentin
