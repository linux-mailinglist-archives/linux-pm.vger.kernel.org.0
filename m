Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0F03B6FBE
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 10:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhF2Izn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Jun 2021 04:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbhF2Izn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jun 2021 04:55:43 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559F9C061760
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 01:53:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u19so4819523plc.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y/8aWcR8pQLRr1AneyecLvILPcZP/SywuwqtFiKRs6o=;
        b=UERVdQrpA6QxI7RQYA+eUhOfbgXgeUFYb4pvURcjwQKvNlRQqHAOYqkWee5zs+Xjb0
         Ah3t28sJQF+zhkVQHRqUV46YTiZXGBh15MtEwUIevK9C7jHP7Fn7YYpts7mxMjBYXvfV
         47iOj3Tl6L2SOmEYsEKhu1xRsUleykMhGR2fkj71nvNEvo29dZejYi93pRIysLFg/Jyj
         JIwu/CkRn40298AVPZw0CFNk+2U+cYskRpjwI/yVZ8wTDOqXyUmLMtHYRw69DrGY1b7o
         BrSUColfv2WDuJLrTcLbkUPwpk6iOu0/QE8q5I/rcsxj598vsuZMvfGGMrfhnqAJGbzj
         noXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y/8aWcR8pQLRr1AneyecLvILPcZP/SywuwqtFiKRs6o=;
        b=Q+kfqp/az3OODbEcw5bnogFvJo7LzJz83Kqih7JA4AHUQKPXqjcW0iYgg2ypyYiTbN
         ynlNHO4sZCgwMi1xixsItUr8pMG1tSKKvIPfMnHX5BphHdqDeGDlZUNHnTb+6g8NAWOB
         7/MWQP089IkWR3NfPrAqMyGfsfp6I9o+S08ouEk16LK2iDqge2FAdrrGqDPY2ggEFaYE
         PRcbMlgLUxhpjN7wNcsng8G00FcGftW8G0WS9/bgxYn+Mrm3EoOOLbLWk1HfAgLEE94P
         x5gf2NNu0A9OEN0azBT42bXv6L4lSgStZpkgjHsj1qUyet6eNFT9FLXmkWw1WcN635jE
         awmw==
X-Gm-Message-State: AOAM530FtLVD28znE0gBFfOv2ukCu2z4w+xLtps0iTP130XRpqWGLjNv
        a3yYQLN+jj6cSnvbycpxRP9adQ==
X-Google-Smtp-Source: ABdhPJwo1gpUzWaxumdXxHpJ6qsqw7SXNoTKDhbjUPtSfTPJXEB307kK2Bp7DWMmed5a8furb5U99g==
X-Received: by 2002:a17:90a:5907:: with SMTP id k7mr33269795pji.196.1624956794956;
        Tue, 29 Jun 2021 01:53:14 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id i188sm6191585pfe.30.2021.06.29.01.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 01:53:14 -0700 (PDT)
Date:   Tue, 29 Jun 2021 14:23:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-pm@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/4] cpufreq: CPPC: Add support for frequency
 invariance
Message-ID: <20210629085312.j6f4e4b6vuezsqvm@vireshk-i7>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <f963d09e57115969dae32827ade5558b0467d3a0.1624266901.git.viresh.kumar@linaro.org>
 <20210624094812.GA6095@arm.com>
 <20210624130418.poiy4ph66mbv3y67@vireshk-i7>
 <20210625085454.GA15540@arm.com>
 <20210625165418.shi3gkebumqllxma@vireshk-i7>
 <20210628104929.GA29595@arm.com>
 <20210629043244.xkjat5dqqjaixkii@vireshk-i7>
 <20210629084737.GB2425@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629084737.GB2425@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-06-21, 09:47, Ionela Voinescu wrote:
> Okay, makes sense. I have not seen this code actually do anything wrong
> so far, and the issues I see on ThunderX2 point more to misbehaving
> counters for this purpose. This being said, I would have probably
> preferred for this feature to be disabled by default, until we've tested
> more, but that won't give the chance to anyone else to test.
> 
> Thanks!
> 
> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Thanks for understanding Ionela.

-- 
viresh
