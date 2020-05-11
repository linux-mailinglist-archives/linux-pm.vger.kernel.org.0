Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E0E1CD13E
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 07:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgEKFZe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 01:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725817AbgEKFZe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 01:25:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B62C061A0C
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2020 22:25:34 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m7so3461444plt.5
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2020 22:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vjlOcvQUP3kyQkvnAgPxWdlpFkFmk5/vefsFk+hIj8Q=;
        b=CkKu1Y0gjJ7IZvWiV+eo2NsQyG1ejsrqcZb7US81GA2uQluGr+wZ6+UR56yYF04d9R
         z4tMXSvM5iC025DsoGDnJ1XFB6n4FqJRgm+AvYFG2/mKkDzBarD9760w/sLendAnsdYh
         coH6/aK4qgLTGKPVzWY9cs7mrm2YVmFhOReu/5/vsfI58V/qoK8aneq0sVXsMq6m71pK
         FLndGBpJ1e6BRb0KaLqP0bHVOLdrcn02LO/uGbcAKfBMIsn94xevoIEwLL+CU2Dr86H3
         3eMLi1yrFVncOPZ1qFwDU0sZmuzsvWkrdcLEeZBd8p8nL54nUGvAABLHTFQVkLVj2sED
         Ayfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vjlOcvQUP3kyQkvnAgPxWdlpFkFmk5/vefsFk+hIj8Q=;
        b=hnYZBRBka5gV+OalVUviZRuLiWQ1PxlNtgZw4Uwt4ItW/9p8p7Jbsos/yv5yWAzCex
         274PzQ14+L64ON05XR3siTYfegUwwdv7jnmHXTr3VRop9isR75JiVNPM3gi5gDcvfGaV
         suZ4N3bDkxbvPuNSjBPmkwxX9/6kX4KsNgaLi1DqdHAYpilMnpVK3/a4/0nD8LWlh7Zm
         5BjhgL0y3z+VjxCiQRT5dl5z1o2JGVtepPWjQDtNg6TmNLrxMBZC4buS4xCu7rFINE0V
         B6AyvqtYwuw3/77IcO87asUGK23lMjuB3oy02fM4Moc1SanK2SSqhUSXWEKpsWj5Uz3Q
         ZvYg==
X-Gm-Message-State: AGi0PuYNAsqYuch++CFg3U+cWdsifniCY3j7OMPUJEqlZ8oCNjYGgNcn
        aD+j4DF+R2xyifo8Tv/ZPzm+rw==
X-Google-Smtp-Source: APiQypIqVu+BsyJFFMfJUdu+oJfZrP3vvz3dlfD3zMY7+JuEm0a/Kcw92Z5uOS3phuqcPavaHmIAoA==
X-Received: by 2002:a17:902:c40b:: with SMTP id k11mr12726722plk.50.1589174733384;
        Sun, 10 May 2020 22:25:33 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id 28sm8922901pjh.43.2020.05.10.22.25.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 May 2020 22:25:32 -0700 (PDT)
Date:   Mon, 11 May 2020 10:55:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: Question about OPP regulator for Panfrost Devfreq
Message-ID: <20200511052530.iazkduojnba3abil@vireshk-i7>
References: <CAJiuCce9ZxeXnQzEW_3dbBDNZmmtWmKeft0hX+F9+SYu80NU=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCce9ZxeXnQzEW_3dbBDNZmmtWmKeft0hX+F9+SYu80NU=Q@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-05-20, 21:56, Clément Péron wrote:
> Dear OPP Maintainers,
> 
> I'm working on adding DVFS support using the generic OPP framework to Panfrost.
> I'm using the dev_pm_opp_set_regulators() to let OPP framework get and
> manage the regulator.
> https://github.com/clementperon/linux/commit/be310c37b82010e293b7f129ccdcb711a2abb2ce
> 
> However it seems that this function only get the regulator but never enable it.
> This result that the regulator is disabled later by the
> regulator_late_cleanup().
> 
> In a previous version I let the Panfrost driver to get and enable the
> regulator in addition to OPP but this create a conflict in debugFS
> because the regulator is "get" two times.
> 
> Quick discussion with Mark Brown point that we should try to avoid
> getting two times a regulator as it can create "confusion in your code
> with two different parts of the device controlling the same supply
> independently."
> 
> Is my understanding correct? If yes,
> Should we not add a call to regulator_enable() in the
> dev_pm_opp_set_regulators() ?
> 
> My WIP branch :
> https://github.com/clementperon/linux/commits/panfrost_devfreq

https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@samsung.com/

We tried that sometime back and faced issues with it.

-- 
viresh
