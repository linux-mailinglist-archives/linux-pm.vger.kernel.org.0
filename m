Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A686E61A81
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 08:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfGHGBl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 02:01:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41032 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfGHGBl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 02:01:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so7030482pff.8
        for <linux-pm@vger.kernel.org>; Sun, 07 Jul 2019 23:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=peXRtMB4l6/FU5tZ5pa+2prKmpjjO6KyHe/s1NBwntA=;
        b=qYpXTTdC+57Hi5zh0A4h3c0ri+hVuuOJYcg0Ag+6G3hwW370kXqV6DpyH1I4wcRSVU
         ff05mKcnVZv75ZdywlAJJGuRaSYf+i2D2qhMFZrl86LKvVQ1kUCljAPXI+S3JR+FJUkT
         gBQpUc2bYkVDTvxUs0R3c/33xUIGEdqsapp6DkI6gBX1z/XX2jC1qZcTWevZ2SWOSs8o
         oDgV1wTfUwhk6v4rHcpdVDlGy7YT0bgG43vOyavNj9/m9s1f18B+8wYKMbdvr1x3sRg4
         cgecUwFe/B0k3IyD8lOInpIn7iiqDnw/qhQpZSYXqG1hMvKFvtIecDN79OaTvEWc/WqP
         myrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=peXRtMB4l6/FU5tZ5pa+2prKmpjjO6KyHe/s1NBwntA=;
        b=hpQFLl3uwCq8R9f9SejiF/tzYobiqTokh9D/a7f3aGok0KeAQVT5xYFLg3pdorsp6a
         Snu0QdG7jrDrcCc5KjmulfniEYo5/Vvgb1kp+NETwzpfx5+NpF4kiFKlb0Oo4jxhLoGf
         wkPZj+DwslS4Zi2s8N9mVTXs+yBP22kVkMDFTC76PqJARu/PmLNUqsEMUoCTMYB2aGLc
         fdlsce3IvNNXxepPrQJAao3MZh6XfOLqMHx4+yzh2qy3N9WKWeLcar6dW1Jgaq4vzNJE
         WtaDeYyAVxs/CWYOAJ0ceKwLrk2eJvBuYdx0NkJ1QWNMHgsLDyaQdrMvfkr4o88yDy8Y
         PQkA==
X-Gm-Message-State: APjAAAXGwzQCI+BZhCe1dNNgbvaa+k1MzwbH3BJPqoxm/ls739kMOTR8
        XfRAevu1T+BmA3BZzp1OYn2HzA==
X-Google-Smtp-Source: APXvYqxvVIaEeh282d+Px+8Oq6IL6RS+zn2W2vd8R+iyk699sGYBj9Cr6pFpfRenH5l+igaTy8z2ow==
X-Received: by 2002:a17:90a:5207:: with SMTP id v7mr22102909pjh.127.1562565700727;
        Sun, 07 Jul 2019 23:01:40 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id 125sm19424002pfg.23.2019.07.07.23.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 23:01:40 -0700 (PDT)
Date:   Mon, 8 Jul 2019 11:31:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] opp: Attach genpds to devices from within OPP core
Message-ID: <20190708060138.7mmdbusfnimzg7er@vireshk-i7>
References: <1bc9053f5c41a10832b58a2a81decbad7f1aded9.1557742920.git.viresh.kumar@linaro.org>
 <aee8dc78-e292-a671-3dc5-ca962c0eec6b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aee8dc78-e292-a671-3dc5-ca962c0eec6b@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-07-19, 11:55, Rajendra Nayak wrote:
> 
> On 5/13/2019 3:54 PM, Viresh Kumar wrote:
> > The OPP core requires the virtual device pointers to set performance
> > state on behalf of the device, for the multiple power domain case. The
> > genpd API (dev_pm_domain_attach_by_name()) has evolved now to support
> > even the single power domain case and that lets us add common code for
> > handling both the cases more efficiently.
> > 
> > The virtual device structure returned by dev_pm_domain_attach_by_name()
> > isn't normally used by the cpufreq drivers as they don't manage power
> > on/off of the domains and so is only useful for the OPP core.
> 
> This might be true for CPUs but not necessarily so for IO devices which might
> want to set up device links so the devices runtime pm calls can trigger the
> on/off of the power domain. Is there a way to handle that case now?

https://lore.kernel.org/lkml/027985ce35873cd218298302a1408da06d48458b.1562565567.git.viresh.kumar@linaro.org

-- 
viresh
