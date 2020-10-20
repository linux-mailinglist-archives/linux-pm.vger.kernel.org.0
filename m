Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B67329385A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 11:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403759AbgJTJlj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 05:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393073AbgJTJli (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 05:41:38 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA43BC0613CE
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 02:41:38 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w11so733169pll.8
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 02:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w6nF/0dbZEKqy03x0aQL4VJByv7A5fZiX1rs+a/9SYc=;
        b=GWotkPzntM5cJlUp/P5Y+QWrES8Pgtp/qedhgN2Z40yk84stamc2gtqLshNRYbj/uG
         MTXXN65l/L5LBek54IMPbPsePneuj2StrruKxPlqLiIHvncF0slaS8qGljT9n/T5Jbi1
         mXz50nHJAqkedemsjK5/NyVl+RalCdhB+eb11vzqDNYmM+giN0CIXa3CSfSNz3A4GkiS
         a1LQ3aMar8OsNkq2BnyK19jtqN+NQ5lujMUPaFueo6YnG76XLTQYTvMayUjCCxlk8NxA
         7TnHsyYgJ7+VoGOvAks9O0P+2oHGpordOenk7NmA5LyQxvmU1qT2aSJ+36+6Ef3Ydf/E
         r+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w6nF/0dbZEKqy03x0aQL4VJByv7A5fZiX1rs+a/9SYc=;
        b=YQuEZj9r/vViEogW+bTV0uij6HdWLrEd7WkofJPlCLPWBiOoRh37m1PPRaQkRdwgL7
         FFmeW3o0ipB31qZ7FaUTjwWOnxPmf9+KEOY2IyoJtpFh3bIeiUY73RT22HRp894SHywy
         19MTmRnAoN6AIE5t9uVWq6mp4t/zVyhnJJm0Y381mnOJttrTxgU17PI+aILHtOQAJS2m
         q9B/90t164Nc/nSWe5PF++0dV9hSS6xtZYSBUxy79V80dTjrtdYsLdvZhgx9DLnxgJWE
         3ELmZ6WglwdEQkDesR9HMJp2/DOykuGvTqDMJcIC5aiVJYaSCxj7Wv6ZlUNBVvhGjJWD
         1MDw==
X-Gm-Message-State: AOAM533j+EF37O+AeCgMlOjDK2sXU05KQpMvVxXqFrrMpf2SBsqFNMal
        SBIyXC0QYGkrb2GCtYYkYAXchw==
X-Google-Smtp-Source: ABdhPJyiQSPVfHjuj+yTE4LYi6dc2DR4r93iTWUzRzb9pM8NKM5Mv5XvpcLreDgg9VjTXqzVkhGjVw==
X-Received: by 2002:a17:90b:d91:: with SMTP id bg17mr2108773pjb.66.1603186898403;
        Tue, 20 Oct 2020 02:41:38 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id x18sm1540708pga.49.2020.10.20.02.41.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2020 02:41:37 -0700 (PDT)
Date:   Tue, 20 Oct 2020 15:11:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, nks@flawful.org,
        georgi.djakov@linaro.org, Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH V2 1/2] opp: Allow dev_pm_opp_get_opp_table() to return
 -EPROBE_DEFER
Message-ID: <20201020094134.natqnyp4zpfw3p5p@vireshk-i7>
References: <20201016111222.lvakbmjhlrocpogt@bogus>
 <20201019045827.kl6qnx6gidhzjkrs@vireshk-i7>
 <20201019091723.GA12087@bogus>
 <20201019092411.b3znjxebay3puq2j@vireshk-i7>
 <20201019101241.GB12908@bogus>
 <20201019103535.ksp5ackoihamam4g@vireshk-i7>
 <20201019141007.GA6358@bogus>
 <20201020050557.a3b2nk33eeyxnvl2@vireshk-i7>
 <20201020055431.ln7d57x76f7z6j5k@vireshk-i7>
 <20201020093745.GA10604@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020093745.GA10604@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-10-20, 10:37, Sudeep Holla wrote:
> On Tue, Oct 20, 2020 at 11:24:32AM +0530, Viresh Kumar wrote:
> > On 20-10-20, 10:35, Viresh Kumar wrote:
> > > On 19-10-20, 15:10, Sudeep Holla wrote:
> > > > On Mon, Oct 19, 2020 at 04:05:35PM +0530, Viresh Kumar wrote:
> > > > > On 19-10-20, 11:12, Sudeep Holla wrote:
> > > > > > Yes it has clocks property but used by SCMI(for CPUFreq/DevFreq) and not
> > > > > > by any clock provider driver. E.g. the issue you will see if "clocks"
> > > > > > property is used instead of "qcom,freq-domain" on Qcom parts.
> > > > > 
> > > > > Okay, I understand. But what I still don't understand is why it fails
> > > > > for you. You have a clocks property in DT for the CPU, the OPP core
> > > > > tries to get it and will get deferred-probed, which will try probing
> > > > > at a later point of time and it shall work then. Isn't it ?
> > > > >
> > > > 
> > > > Nope unfortunately. We don't have clock provider, so clk_get will
> > > > never succeed and always return -EPROBE_DEFER.
> > > 
> > > Now this is really bad, you have a fake clocks property, how is the
> > > OPP core supposed to know it ? Damn.
> > 
> > What about instead of fixing the OPP core, which really is doing the
> > right thing, we fix your driver (as you can't fix the DT) and add a
> > dummy CPU clk to make it all work ?
> >
> 
> I really would avoid that. I would rather change the binding as there is
> no single official users of that binding in the upstream tree.

But how will you solve backward compatibility thing then ?

-- 
viresh
