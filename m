Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C364C14397F
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 10:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgAUJcE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 04:32:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37761 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgAUJcE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 04:32:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so2188360wmf.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2020 01:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=imtrsyE4PqkfOuBH2bEU5/ycShpe5DgMQpGEtomyMa0=;
        b=rtcJ+LQlDZ/dhGfo9Iu5OJd4+HKMy2yzD9iSGdalzOoIEncUjzsz5/aNNTd5RjsSc8
         zO8R7IWeVumQmIJtNgo4RVZt7gUhd5yZRRBQqVDryoKs8BU04+PpGfSZJNvnjsH/62yj
         utNq7GGLPGyTxTb1yb3mltp6nzJAjgAWU6qQKOTamwB12SgQZpUurDCVdShHDY4zSwRt
         27hnYDJCXhMMgdvO1mW+7T9xCr4uphzvbjrusTEF0ylfATpdKENfYomQu6F+lwzn6RUS
         UpDbh4WVRvpRmqp5fb/B2A+GM9Tidwg6k1/Hgf4wLH/tybPmLM/Hd8ve+be8A6ZldBH9
         pQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=imtrsyE4PqkfOuBH2bEU5/ycShpe5DgMQpGEtomyMa0=;
        b=sO549fFZ4GgxJELOfKsbZ5q64ZxqTc1jmn6hJlrhnVId5zmmDRLF4thhjsJwvsKGW0
         1yQOw23hxyqA7RXjsufGamcb9HgKLzvm7bSJdH0+Hm0p+b+7lqy7AXlWIOOkXajqjZ19
         PiQNGL3qWCd/+WXsSQ82QufNacjg1igRffEgznhSYG2T01Ifooc2djc1TUway0kWz7mn
         PlcYv9lSljIQpq8wjsKGQpm2OuxCLh5NXatIJDf7Fo3RTPjUjM/tpIzVh2ep4yjR6d8l
         BWGutXVavgvLAapj2VXfL+IQssPdRbTMZD2T177xc5DJ1vDJeS/ozCuJXm586UbYrB3Y
         qKJA==
X-Gm-Message-State: APjAAAW2hk8xUUiNKXewe/60fx6ERlq+mvVU3WPHM5QATc7OkRVA6Oep
        4o7Twm7Z6dwbrRuQToO0RlnU4Q==
X-Google-Smtp-Source: APXvYqxXLTNXCnqXFHWAqOhNn4BqFUdupPBlV6/fm+9Ho9HF0rYCv/gYw3ZqBCY91j9ikIx2kYRjiw==
X-Received: by 2002:a1c:a584:: with SMTP id o126mr3199652wme.163.1579599122625;
        Tue, 21 Jan 2020 01:32:02 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id g7sm51210925wrq.21.2020.01.21.01.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 01:32:01 -0800 (PST)
Date:   Tue, 21 Jan 2020 09:31:58 +0000
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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
        airlied@linux.ie, daniel@ffwll.ch, kernel-team@android.com
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
Message-ID: <20200121093158.GA154455@google.com>
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
 <20200117105437.GA211774@google.com>
 <40587d98-0e8d-cbac-dbf5-d26501d47a8c@arm.com>
 <20200120150918.GA164543@google.com>
 <8332c4ac-2a7d-1e2d-76e9-7c979a666257@arm.com>
 <b02da0ed-9e0b-36db-9813-daa334cbf2ba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b02da0ed-9e0b-36db-9813-daa334cbf2ba@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday 20 Jan 2020 at 18:38:41 (+0000), Lukasz Luba wrote:
> I think we could avoid this additional argument 'cpumask'. I have
> checked the cpufreq_cpu_get function, which should do be good for this:
> 
> ---------->8-------------------------
> static int _get_sharing_cpus(struct device *cpu_dev, struct cpumask *span)
> {
>         struct cpufreq_policy *policy;
> 
>         policy = cpufreq_cpu_get(cpu_dev->id);
>         if (policy) {
>                 cpumask_copy(span, policy->cpus);

That should be with 'policy->related_cpus', but yes if the policy
cpumasks have been populated this approach is OK I think.

>                 cpufreq_cpu_put(policy);
>                 return 0;
>         } else {
>                 return -EINVAL;
>         }
> }
> --------------------------8<-------------------------------

Thanks,
Quentin
