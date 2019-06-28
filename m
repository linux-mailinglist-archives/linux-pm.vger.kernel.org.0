Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB0F59464
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 08:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfF1GtS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 02:49:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39403 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfF1GtR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 02:49:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so2689359pls.6
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2019 23:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vPhgOlnnCB9ywYOBqb6XWPEQoBI2y0wpZimTNVlxq94=;
        b=xlQEkY8FiSYP5T8Sr+fiSBjHesc/PjqUa14hg77RnJh0y29/YUP67po1FtaWYwrHM6
         A62F01aq9JawXlETdcaGGw0NdKmU19nBDaw3yEa68LMQMRv+B+4yAq1I90Nio+xQ6sEt
         o/0d8Rlt+SS0ROHur5wxPvffwvasNpbObHNsnG4dFNCoLygibKECrxmkqhvImDEUDQnp
         Wc/V4es3nOA9lNVxFB5HEQKA5Y5O0B+LEDIfk2XXHuJG7Pr1KcY7dli+FjHxkNgyHNpE
         nwLrkUmsr2SKdemi+zTyitOdMnjSCIYLog3E6PFg4vDnDoZTT0btNePuX+fMVzDFvBix
         P0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vPhgOlnnCB9ywYOBqb6XWPEQoBI2y0wpZimTNVlxq94=;
        b=lmBVhehhdlj2M6sV2Ezjhenb455rqQnzpg/Qac6SoIih/3pJK/sh4M9UAHSOD4aQrw
         mDm3alUIFUKIbUPS4MAoJM1C1iAZdKTogozjtnmOlkSPhW5yjJiF7uWNMc7/MuH0YE9e
         TWTdb5yHHRCARGnM5kQSi4/3+v8mFXfTpQmUlHYwMydOT2Tbnoq5SIHjMs/PeXBJ7Epu
         utM6gHmISEjNIZKLH4yTVGgANVAJkG9TkxPMeKnjOO11qNMBa2kYbfk9h8RAn80tYdeU
         LXIk++32aZPLH3L6ng+UaDAO7UDpsgZSwHETQL2sf7yR/k8R9F9jqkkSYaGQLUkpfxN6
         d1/Q==
X-Gm-Message-State: APjAAAWrWVzITZ4OXjNxxK/q1LlnfRI3ff3pzOCytHEQMYfxxYH6G9IA
        I2XqP/dP+UO31bIGLzJk3wfeNA==
X-Google-Smtp-Source: APXvYqyNvvDrhAXq/jq9bYxrggpCt4lHHPhkqneujqN2UIMLKeg9OegNN6US7peiZQLxZLxm2WqDnw==
X-Received: by 2002:a17:902:6a88:: with SMTP id n8mr9651454plk.70.1561704557101;
        Thu, 27 Jun 2019 23:49:17 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id j5sm1223710pfi.104.2019.06.27.23.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 23:49:16 -0700 (PDT)
Date:   Fri, 28 Jun 2019 12:19:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] Add required-opps support to devfreq passive gov
Message-ID: <20190628064914.4nu6ql7f7h7o4iul@vireshk-i7>
References: <20190622003449.33707-1-saravanak@google.com>
 <20190624094349.rtjb7nuv6g7zmsf2@vireshk-i7>
 <CAGETcx_ggG8oDnAVaSfuHfip1ozjQpFiGs15cz8nLQnzjTiSTg@mail.gmail.com>
 <20190625041054.2ceuvnuuebc6hsr5@vireshk-i7>
 <CAGETcx8MuXkQyD5qZBC948-hOu=kWd4hPk2Qiu-zWOcHBCc=FA@mail.gmail.com>
 <20190625052227.3v74l6xtrkydzx6w@vireshk-i7>
 <CAGETcx_v05PfscMi2qiYwHRMLryyA_494+h+kmJ3mD+GOjjeLA@mail.gmail.com>
 <20190626063240.kgdiy7xsz4mahrdr@vireshk-i7>
 <CAGETcx_KH6pqgqZFKddWmgiUX3n+XBU6BoFXkVvPdA4vMDHWsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_KH6pqgqZFKddWmgiUX3n+XBU6BoFXkVvPdA4vMDHWsw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-06-19, 11:10, Saravana Kannan wrote:
> On Tue, Jun 25, 2019 at 11:32 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> > So, when a CPU changes frequency, we must change the performance state
> > of PM domain and change frequency/bw of the cache synchronously.
> 
> I mean, it's going to be changed when we get the CPUfreq transition
> notifiers. From a correctness point of view, setting it inside the OPP
> framework is not any better than doing it when we get the notifiers.

That's what the problem is. All maintainers now a days ask people to
stay away from notifiers and we are making that base of another new
thing we are starting.

Over that, with many cpufreq drivers we have fast switching enabled
and notifiers disabled. How will they make these things work ? We
still want to scale L3 in those cases as well.

> I see this as "required for good performance". So I don't see it as
> redefining required-opps. If someone wants good performance/power
> balance they follow the "required-opps". Technically even the PM
> pstates are required for good power. Otherwise, the system could leave
> the voltage at max and stuff would still work.
> 
> Also, the slave device might need to get input from multiple master
> devices and aggregate the request before setting the slave device
> frequency. So I don't think OPP  framework would be the right place to
> deal with those things. For example, L3 might (will) have different
> mappings for big vs little cores. So that needs to be aggregated and
> set properly by the slave device driver. Also, GPU might have a
> mapping for L3 too. In which case the L3 slave driver needs to take
> input from even more masters before it decides its frequency. But most
> importantly, we still need the ability to change governors for L3.
> Again these are just examples with L3 and it can get more complicated
> based on the situation.
> 
> Most importantly, instead of always going by mapping, one might decide
> to scale the L3 based on some other governor (that looks at some HW
> counter). Or just set it to performance governor for a use case for
> which performance is more important. All of this comes for free with
> devfreq and if we always set it from OPP framework we don't give this
> required control to userspace.
> 
> I think going through devfreq is the right approach for this. And we
> can always rewrite the software if we find problems in the future. But
> as it stands today, this will help cases like exynos without the need
> for a lot of changes. Hope I've convinced you.

I understand the aggregation thing and fully support that the
aggregation can't happen in OPP core and must be done somewhere else.
But the input can go from OPP core while the frequency is changing,
isn't it ?

-- 
viresh
