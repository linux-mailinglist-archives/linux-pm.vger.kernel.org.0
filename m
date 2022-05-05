Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096D251B963
	for <lists+linux-pm@lfdr.de>; Thu,  5 May 2022 09:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242624AbiEEHr5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 May 2022 03:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345818AbiEEHrt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2022 03:47:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82CE48E7A
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 00:44:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so3263900pji.3
        for <linux-pm@vger.kernel.org>; Thu, 05 May 2022 00:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QyQdkF85sxaGXngVWCf+CtwxLJCswpvbc9Yb9r9b3ps=;
        b=D2FD8aKIDuPOc/gFcRzpeEFffc8FHi92DSXpFvDnOA5KT5ENc/h3GzfKD7L3oMMYVT
         W9tGZqtnjYGHKzdcxLtMMkVSnFYMZz6lCNYNNONigSREnfWlDSo2UmH+wusKATbrfm6n
         owJjiKuRF9EB6+/EKcz/cyGfDtxyc2ojbUUQhmquEVwBkZGcrsBZqHiMoHCkVgcZok5h
         xtHjqd379S5OMFXdVcrMuQSKT7NSRTVsmhI/5+QF9DsKekFeUUJp5rQQhZ20Zhl89CVg
         sMqfKqjoOavUqIJoYdWqrTstCvGNXHF947B2SvGNaXA42ceUmHZG0g+SI3Om3V5dWaos
         9H2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QyQdkF85sxaGXngVWCf+CtwxLJCswpvbc9Yb9r9b3ps=;
        b=sUHJ/mGcgmORCd/HEkrD90f+QmO0/QVRZViR853LJYlYiQaUXk+ECXYuFQ+wYYHIP+
         Ea+3FjlpFlgw9/3dv7drHrGzUOTbLJot2m++z0EdeIsBA5KJNtP8oeocbxbbp4gH1YbE
         4s/ZJD9nZvSlWl/T49ZC+FQFqZGWwYjPGpc7HAHwyZyh1CTNYxDn5Jou+VSQMdhTcPg/
         HCe0+vCSTblGNdkL9SZvD12k+0Ss4//QGYi9Qx/+i+xbd2VEsHxl20g+05Q4rP9KeOg6
         xEKlbFOYJWWBcLVbZuWw4Ds+iCuDz1B0qKkWWFrTnjdVtZgmcpO7XsnKzotlnIK4PPFI
         wluw==
X-Gm-Message-State: AOAM5302OT7qdTQ6tKiwcwqx5QU5y/zu48nIm4oNbqEeE/JP4HGBTl8U
        Eyu7JxCIZNlApqHaAcReSm6eIg==
X-Google-Smtp-Source: ABdhPJy8Ta6MH5GIF9d0xleqp2yj0Z1ejJgxU3wQrlYHh9gsGENoZbW5iILj3qg7tgiuvnW7JMhLvA==
X-Received: by 2002:a17:902:dacd:b0:15e:a53e:3239 with SMTP id q13-20020a170902dacd00b0015ea53e3239mr19129271plx.7.1651736650309;
        Thu, 05 May 2022 00:44:10 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id c19-20020a63d153000000b003c14af5061asm626743pgj.50.2022.05.05.00.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 00:44:09 -0700 (PDT)
Date:   Thu, 5 May 2022 13:14:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Avoid unnecessary frequency updates due to
 mismatch
Message-ID: <20220505074408.ayzmd5kdbw2fagbq@vireshk-i7>
References: <39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org>
 <CAKfTPtDbsd+RLwY+0ZfnNWkQD+jOHmoX2K+ZfsOMnEH81ouVjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDbsd+RLwY+0ZfnNWkQD+jOHmoX2K+ZfsOMnEH81ouVjw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-05-22, 09:28, Vincent Guittot wrote:
> On Wed, 4 May 2022 at 10:21, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > For some platforms, the frequency returned by hardware may be slightly
> > different from what is provided in the frequency table. For example,
> 
> Do you have more details ?

This is where the problem was discussed.

https://lore.kernel.org/lkml/20220422075239.16437-8-rex-bc.chen@mediatek.com/

> Do you mean that between 2 consecutives reads you can get either
> 500Mhz or 499Mhz ?

No, the hardware always returns something like 499,999,726 Hz, but the
OPP table contains the value 500 MHz. The field policy->cur is set
based on opp table eventually (target_index) and so contains 500MHz,
almost always. But when cpufreq_get() is called, it finds the current
freq is 499 MHz, instead of 500 MHz. And so the issue.

> Or is it a fixed mismatch between the table and the freq returned by HW ?

Yes.

-- 
viresh
