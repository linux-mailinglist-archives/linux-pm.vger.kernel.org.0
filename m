Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C13232BFC
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 08:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgG3GlS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 02:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgG3GlS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 02:41:18 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002DBC061794
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 23:41:16 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e22so3648790pjt.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 23:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=krIgKID8uYB0pZD4CB8haR2YvOy/MetPylKw6idu3l4=;
        b=LtWOBflSooNTpehq6wySGxlXhtLuziSucWm8aMNu7Qx8q2bR8GF81/AiBhdD9hzzBb
         rXa0cqzGTIwPKML3flKaiwaz3cNLdgTQ5eoKvRIop6/KO9mX+0z4AvP0ese2AbDyXRJI
         T5YXe1NzybAoLYBhkaLHcF83QC40xAy2QnpzFdcgY3ki69ON3mHgp+qmHYgPUXHR5cZm
         3AzQQFq4dtkPw/wPAzYn2rCNxgW3eqsgt26sUuw7QBcTVT0TaWCf96cBOT6axy37aZew
         CJDWmLrQ8LaOv664AMsQgqNXnxY2sQcqAKykCvlFY7mEwVmJWkJQCOrF1DqMazKaOdE8
         1Luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=krIgKID8uYB0pZD4CB8haR2YvOy/MetPylKw6idu3l4=;
        b=lQ19W88hIyUDhZ5voSau+pzJKeiE4ETaFX8UukMN0n3aBTwuT9JLBsrTlQAe8M9YBC
         UQARf8pKya24NPxUdMHXsdA4HTTYA+53E1o2QkaEx15XiMa1bCRCemmP6d5jmXAfaybN
         UYTHRvS52RMzqovvNhtSnL/mY5c22wP2U0qf3EE15GClFE9UxEssaoWHnZjgqwUjlLkC
         09+/MrMOUQOPawrzo6DuYlkqIWrtMNA0tH3pLY6J5TqZkCrhHYeOvTC9TrXx+2qsKtmR
         zz/Q4A0NnpsSAHTmQ75p8hcOJoT1eMAD3QdxxRxzb5YmZA1wfl3IE3aCIF8LbKM6jJWs
         G+PQ==
X-Gm-Message-State: AOAM532AVcTXg9JjCKvd390p0sjsDijF7DxBVO2aixf5O6iTEcLSj/av
        vRAVxpXSxxSXC4oaJupVMHJ/ABI7BiU=
X-Google-Smtp-Source: ABdhPJzIeR2VvHfKshUiq72wZlmDXrmkeExywIbvTxbdaTNMXrcYSNWlNQK5rAj4ooTCk1/tFJM5HA==
X-Received: by 2002:a17:902:262:: with SMTP id 89mr28913394plc.31.1596091276190;
        Wed, 29 Jul 2020 23:41:16 -0700 (PDT)
Received: from localhost ([106.201.14.19])
        by smtp.gmail.com with ESMTPSA id y7sm4329829pjy.54.2020.07.29.23.41.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 23:41:15 -0700 (PDT)
Date:   Thu, 30 Jul 2020 12:11:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: cached_resolved_idx can not be negative
Message-ID: <20200730064112.lvbwas7zzqruvprk@vireshk-mac-ubuntu>
References: <d48d824ab3abacb2356878780979d7ed42191eaf.1596080365.git.viresh.kumar@linaro.org>
 <CAHLCerP4YPHc4sKD_RTq=Gxfj+ex4F=J2is1Y-UzGXcOuEOrOQ@mail.gmail.com>
 <20200730061041.gyprgwfkzfb64t3m@vireshk-mac-ubuntu>
 <CAHLCerMD_spZFHER-y9dOzr7qo9xKXZdqy3cFt+W9QUW4Ng3jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerMD_spZFHER-y9dOzr7qo9xKXZdqy3cFt+W9QUW4Ng3jw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-07-20, 12:02, Amit Kucheria wrote:
> Looking at this more closely, I found another call site for
> cpufreq_frequency_table_target() in cpufreq.c that needs the index to
> be unsigned int.
> 
> But then cpufreq_frequency_table_target() returns -EINVAL, so we

It returns -EINVAL only in the case where the relation is not valid,
which will never happen. Maybe that should be marked with WARN or BUG
and we should drop return value of -EINVAL.

Rafael ?

> should be able to handle int values.

And so no.

> I think you will need to fix the unconditional assignment of
>     policy->cached_resolved_idx = idx
> in cpufreq_driver_resolve_freq(). It doesn't check for -EINVAL, so the
> qcom driver is write in checking for a negative value.

Right, I don't want it to have that check for the reason stated above.

The point is I don't want code that verifies cached-idx at all, it is
useless.

-- 
viresh
