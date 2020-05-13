Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A516B1D0BBF
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 11:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbgEMJT1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 05:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbgEMJT1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 05:19:27 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB684C061A0C
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 02:19:25 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d184so7752914pfd.4
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 02:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ehs8D/i0+/N1zCQQnkt7QFlvG4VVy6oBEc7nouR0tmY=;
        b=U7RrZNoQeIk7iFUjq3G0vEI1LOlrSv4U/imLHjt9FIm1Ov6YlmeBLVf/ze4+y33Pkf
         K4193qvdmsheOrMXl5kXArsi+8OGL8Ip+GizFfb1Cs0/2Z63oVofrjImitKRp8HKrc9X
         BGbTFwf8llkzPpp61bpFYweZ1R8jrMeHtVp5Cy7Yoa8tngcx7gqo6Xj3vAUFnXETrbp+
         bStYxdzJ074UUZUd4vXP3+jia0ZhlsrrB+rPAWg/rT8r6NIrACEFOp7KRsnlC+ESle/X
         8bvG/HCv/kw2uc3jL/XBrUyWFrB+lNPgllkFVf+R+dqNyOadUXioXmWsMLSZCkIOM7vE
         Xz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ehs8D/i0+/N1zCQQnkt7QFlvG4VVy6oBEc7nouR0tmY=;
        b=hrUnnfmwPfKn0sXtukDme30rBOY32qAXjzv5Z5DFKOqZ1FIt7YrBNVaSxqS/wrrHX9
         /myUhRQ7N1/HPnWTSLme/De9VdO+7QouVZCqfkjfjIaimdEKfAZlrnuXJXgPHWiJQYb5
         JEYQ4JfHfgst68U42zGE+7tM+t1J1uFDEqHQHWIhPEH7n4chJRdV/t0mVEcY+dG8sU29
         G6P9Ngf13J6LxEXgW8/7wozW6+h1nFZquqq6ZzmaV1EJWuNzKblS+x3yZNQltVxS1DYY
         buviKPLAUADSk5IB6ZslTvXI6q+MlKsE0uDmGyMbbhCSNRWLy3pEgvnUpcsUI7jjywjg
         +qdA==
X-Gm-Message-State: AGi0PuYTyECTEFQhGzglf2AGHM7kN0GIZVlXktsdDwr2pDNbgT69bq0u
        IzDfvbik5e0ig3WF/skE45ghiQ==
X-Google-Smtp-Source: APiQypLgLAkqL1ozHiZiSu90p2A8clIUN0n+8N8AINYcwAggh+BQNt1I1LIS0u6/ksTVFtwXvIlarg==
X-Received: by 2002:a62:15c5:: with SMTP id 188mr23636617pfv.66.1589361565252;
        Wed, 13 May 2020 02:19:25 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id x13sm14738270pfq.154.2020.05.13.02.19.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 02:19:24 -0700 (PDT)
Date:   Wed, 13 May 2020 14:49:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Steven Price <steven.price@arm.com>
Subject: Re: Question about OPP regulator for Panfrost Devfreq
Message-ID: <20200513091922.qnpjx4kw2m3jv2ry@vireshk-i7>
References: <CAJiuCce9ZxeXnQzEW_3dbBDNZmmtWmKeft0hX+F9+SYu80NU=Q@mail.gmail.com>
 <20200511052530.iazkduojnba3abil@vireshk-i7>
 <CAJiuCcfRmDbBxEms=HAFQhaiBTznEd1of3TOcnAAc2yuTq0XtA@mail.gmail.com>
 <20200513054601.nvwsjhk6i4bjmgt7@vireshk-i7>
 <CAJiuCccd+ycnmirL7chtMom0uqbQ8cX9VQf_ZAvhzTto9VSDbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCccd+ycnmirL7chtMom0uqbQ8cX9VQf_ZAvhzTto9VSDbA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-05-20, 10:18, Clément Péron wrote:
> Sorry,  my message was not clear, I was trying to see if there is a
> way to fix exynos issue other than removing the regulator_enable().
> I'm wondering if calling regulator_enable() on an reg which is
> 'regulator-boot-on' declared will trigger this issue.

Ahh, that's actually the real problem. Enabling the regulator which is
already enabled by the boot loader has some side effects explained in
the below thread and so the patch was quickly reverted after being
applied.

https://lkml.org/lkml/2019/10/8/459

> > What about doing runtime_pm_get/put() from the driver which should
> > enable/disable all power related stuff for the device ?

Actually runtime_pm_get() may not affect the regulator, but just the
pm domain.

> I'm really not an expert on this but for what I understand I think
> that removing the regulator_enable in the OPP framework to fix some
> side-effects is not the proper fix.

It was removed quickly after we added it. And everyone knew that it
isn't the best fix possible :(

> I wonder if we can get where the voltage is changed and why? Maybe
> there is a proper fix like setting the required OPP voltage before
> enabling the regulator or declaring the regulator as
> 'regulator-boot-on'.

I am not sure how to fix that problem, but ...

@Mark: Regarding enabling/disabling regulators from the OPP core, what
about skipping that only for the regulators that are enabled at boot,
i.e. to avoid the issue we faced earlier, (by exporting a helper from
regulator core for that first) and then applying this patch again: 

https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@samsung.com/

-- 
viresh
