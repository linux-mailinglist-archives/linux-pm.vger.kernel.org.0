Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31E63EE6FD
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 09:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhHQHKD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 03:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbhHQHKC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 03:10:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFF6C061764
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 00:09:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so3556676pjn.4
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 00:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wVGD6rAfvd7Te/trDH3IZqa8JveZ9i/ommHcUBqt7qA=;
        b=O5HxVZzk+6B05EUxu75pASs+K/CmmEh22yECelUsUDZ9LoPK1Zp0Wz3r5C2y0ClE1n
         rrwDRellmd62k6REYiiq3hIqCUU6GH/0yFKNzNExNsKlPDSguv2lEgAIfYVtffIIItQq
         SgfeEWKJLe++CHOwC8emD8xiazPr+j2L5HLXQxcK9R6FX0f3sOTo0jzuZ7yy2DGQn7fd
         4qqFVCaXNSynk4WvgESRBrPrrcs1D2hcOcT+SBAY9eVbZOqYnWMzQdnDyNMzjsWNKcEx
         D7uhNX5EB75WSFCqR3NpnovbkJlvdtspUTA0i98jw/BS3tbvsU2g+/GnyE2VkbayrYZ8
         yJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wVGD6rAfvd7Te/trDH3IZqa8JveZ9i/ommHcUBqt7qA=;
        b=O2B/vYM+A3sTrXQDWPmk/40tM7YvYtyKXqF0prc+87vnx+JIBKBpFyuI1sBn+hIXMk
         mA2UmnxJAYo8m1pSfTjb0Keju0ONI55+9lOtRaK2HrN0MiMW3QqHrrb2mhUE1JOMA/FD
         +OkLNOVmhplJbeVTbjRs1jS6ZyMUUNLuhFm8fUKjLHByRqYYd+0y4AI9NG+Ol5gWw7yU
         D74ZCuvzM1vqZ7TtudG2tr0e0rRKwzfsTKonac8dACI6b6HlBQ54imyrCWZV5o/391Jh
         l2vdsZ2nWQPf/sY69GIc/WRfORPTdRDqXzCFpfuuXMUXop5s0rlE6KEem9/thc7hJ4mt
         1+Fg==
X-Gm-Message-State: AOAM5338gpodeqWTBEfXWZhRCW6YeTJ2Nk4b7FuOr0lRyoIQ+DdM32o4
        SbMHHJZIASEBkYE41o2N4jdSBQ==
X-Google-Smtp-Source: ABdhPJwVIFIGmXLZPQufTGzupMLNp7PAuVczsUu9xrTa5YaEi7qp8y3KYhPxOCMTSn387LdUewnAFw==
X-Received: by 2002:a17:90a:3004:: with SMTP id g4mr2271805pjb.104.1629184169834;
        Tue, 17 Aug 2021 00:09:29 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id k9sm1336506pfu.109.2021.08.17.00.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 00:09:29 -0700 (PDT)
Date:   Tue, 17 Aug 2021 12:39:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Quentin Perret <qperret@google.com>, r@google.com,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v4 0/9] Inefficient OPPs
Message-ID: <20210817070927.z4ub6nvrztmly6lq@vireshk-i7>
References: <CAJZ5v0jLzj48-Bu1-i4=r3aratJwRzVYuaPvycUb--4jKSRkHw@mail.gmail.com>
 <20210810061323.kc5kvy6m6566z3gz@vireshk-i7>
 <78bc08fe-71c2-398c-9a10-caa54b8bd866@arm.com>
 <YRKINFhDmYqvgxsN@google.com>
 <cf9d78fe-cff0-1992-2c15-7053e4431296@arm.com>
 <b888407c-d444-8184-cbb7-ce8e925b254b@arm.com>
 <YRKfluMP8G41/P61@google.com>
 <20210811050327.3yxrk4kqxjjwaztx@vireshk-i7>
 <165735fc-1d03-42cb-b5eb-8a9c1d3c4387@arm.com>
 <CAJZ5v0jc4KNeM2CotsPrD_Mnen57x3wCneGYzy5yNOdJ27wWOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jc4KNeM2CotsPrD_Mnen57x3wCneGYzy5yNOdJ27wWOg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-08-21, 16:35, Rafael J. Wysocki wrote:
> It was introduced by
> 
> 7c45cf31b3ab cpufreq: Introduce ->ready() callback for cpufreq drivers
> 
> and appears to be still suitable for the purpose stated in the changelog.
> 
> Anyway, the vexpress-spc driver is the only one doing anything
> significant in this callback AFAICS.

And I have already sent a patch to drop that user, after which we can
remove the callback altogether.

https://lore.kernel.org/linux-pm/0efe0c7b1c07591f07a905021f455b033441784f.1628659212.git.viresh.kumar@linaro.org/

Moreover, this idea of reusing ->ready() callback is already replaced
with this:

https://lore.kernel.org/linux-arm-msm/cover.1628742634.git.viresh.kumar@linaro.org/

-- 
viresh
