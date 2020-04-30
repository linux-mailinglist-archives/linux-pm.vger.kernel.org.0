Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419241BF006
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 08:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgD3GJF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 02:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD3GJF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 02:09:05 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADCFC035494
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 23:09:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 7so3243240pjo.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 23:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gnoiaAuFUo4sUlvrv+0H1shPq44QtsmkGsofLniz4yU=;
        b=byAT5GYTKMmb9dN5DO0AqZOOlkZMewiHMDiX3iF5oAJvqYbarJDnT8HiAaHb+UZOFk
         bmEdH/HOUPRjPjpIJrvauvZsiyMivzMY6/bZJQHWR3JCAZpkxjE9fJ/lgPByDjtg4Wqp
         /MfNGLswKIMjLShQj0qTFpiMganNPnTRkjOs/NWunKHrbNWD0rys519H3+xIxPwWmh1V
         6C9E218KrhOJMq0fvfve5jDcZ84v1EkCmoqLcNPFjQaQAd0ZTiMEriuBnjr26/OBf1nY
         4qIHhZ/wc62lGL5pJevZFoSh0J5Jg2Q8KOWoEAXyLEsHnH6nS5t2c8VbjLOV1WtlTtf8
         vfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gnoiaAuFUo4sUlvrv+0H1shPq44QtsmkGsofLniz4yU=;
        b=P+kUBT3ykeQ4TQYuMif8KlOSIHR0Ja+hqhSncW3ie8na7liXiUJ1cSPP3Sc6GUxFgy
         4ZogtWJ97rUJRn33whbkz6uVkg8aGvyfNu1ZdnUbzdBKQagmoerjEvYChFxhELb4lbqL
         2PdXCkbWCbgrMLc8uMrJDHacOgyMWSxHJkAZO+36spPDA+kyHgXKLq5dRaC0gW3LSc3F
         PAWfIqgjCkdcULVW/9NWMIyxEXI64DCFbaITR4lXEdFF4qbT6CcuC52h9fmz5pojU59D
         YXa80zbq/m9sm4H9zmizNmywsQXvAlrV5zJJMkD0CjdzlxIzOIvWLe0EtjBuYKgvujHG
         CvJg==
X-Gm-Message-State: AGi0PubiIwp3e1gbW//WtyxcETOfCfdQ90oonArLpa+weT1ZmNhVQe0c
        +6Vv/texTfq2BeYy1sRNgZlb7A==
X-Google-Smtp-Source: APiQypL5K6KJakKoCQTgtpj++245Liqa/pnUNFWRMXQInyp9Q1+LAUoIIzocBD3tizpFbPtxFCAJhA==
X-Received: by 2002:a17:90a:68cb:: with SMTP id q11mr1200392pjj.15.1588226944531;
        Wed, 29 Apr 2020 23:09:04 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id t28sm2296509pgo.46.2020.04.29.23.09.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 23:09:03 -0700 (PDT)
Date:   Thu, 30 Apr 2020 11:39:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 6/7] OPP: Update the bandwidth on OPP frequency changes
Message-ID: <20200430060901.j7jjw6soo5h5xoul@vireshk-i7>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-7-georgi.djakov@linaro.org>
 <CAGETcx9iAJRW9Y9orHNF-fC53nNob_vZKYUNEpwf_AeAdWCOjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9iAJRW9Y9orHNF-fC53nNob_vZKYUNEpwf_AeAdWCOjw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-04-20, 14:18, Saravana Kannan wrote:
> My only comment is -- can we drop this patch please? I'd like to use
> devfreq governors for voting on bandwidth and this will effectively
> override whatever bandwidth decisions are made by the devfreq
> governor.

And why would that be better ? FWIW, that will have the same problem
which cpufreq governors had since ages, i.e. they were not proactive
and were always too late.

The bw should get updated right with frequency, why shouldn't it ?

-- 
viresh
