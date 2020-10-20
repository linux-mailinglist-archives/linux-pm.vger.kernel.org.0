Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB857293475
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 07:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391779AbgJTFyg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 01:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391777AbgJTFyg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 01:54:36 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A746EC061755
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 22:54:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v22so215512ply.12
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 22:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nxPLYxHdSRuqO69/xXr8NI7f9DVIeX37mXrRDJrlqP4=;
        b=hTFFYg068bv/W8wuD+QXGdT0tMoV6sqmmj4MLZrSIA7P/6xmFIUQRjMjh5ixEuk9+s
         bnL+AhKmOrliT6pyNsBC6gnLAROnpdS5jTPDG1uWo7jKcREf9Ef+g4w6ypu8Q4e2vKSi
         WMXD01+vNIqSPzTbJ6r3aCTbzTeJ8xrzw6rckG4G/b87xYNnD9o8WTTf9Qse37xk0dpw
         8lj66QqurDpcCyjh3V2xc3uoZN894smzqIMx6JTjJ0avH/v7VrmhSBNX9W4Ptc9epfUs
         PUEncy4LDJq/ktDFWCXuQaG6BKsbM+i0lNT2ycElQvwdJcpPXIMIZYNrnNW4kI6bDO0H
         Svfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nxPLYxHdSRuqO69/xXr8NI7f9DVIeX37mXrRDJrlqP4=;
        b=lgmY4Bk1WO4cnjvzCRTETgQlODhdl4lhCul++Lr52EfSLRprsmSTFmadgFAAtlrlCC
         KOfts3mpaf/oORSvT7ZqNXsAVFboSNi4y+xon/EuEVvt1CV58rgZzqshHfm/vWu8fEJb
         oZDi7WZEA5syIhWIA0SkSEraMgFGqkwYSQRZtobkkThYgpzDGLkZ2v6+7SMk4TbrgVRw
         MhL8DqoKdnSU1IbIRyFkzJc+amyVzhmoDfR4qSfgLrMslwPvBqrhxCYebmMnRyB2h9gl
         pJmOe7I8Ca5hnUWVahaB+DM7ro1CPggqXmJCozAI39G00SgBiSHWLgUIkeslkByudc5/
         8aKw==
X-Gm-Message-State: AOAM532X0SToXoiqIwsKEmoM9QmhxpqrXJQSXh7FX2Dh3We2Cciw3ttw
        5rYd8Mi93UxpOyDCBaQ5hy0h2g==
X-Google-Smtp-Source: ABdhPJyo5+ib86HP6QctLhVLOcHST10R0jSm+p+v6mWQ6N+gPW2j3hELPp5nmsZQE2rwzQDKZp+OMQ==
X-Received: by 2002:a17:90a:420b:: with SMTP id o11mr1392148pjg.142.1603173275044;
        Mon, 19 Oct 2020 22:54:35 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id c12sm654902pgd.57.2020.10.19.22.54.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 22:54:34 -0700 (PDT)
Date:   Tue, 20 Oct 2020 11:24:32 +0530
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
Message-ID: <20201020055431.ln7d57x76f7z6j5k@vireshk-i7>
References: <20201016042434.org6ibdqsqbzcdww@vireshk-i7>
 <20201016060021.sotk72u4hioctg7o@bogus>
 <20201016111222.lvakbmjhlrocpogt@bogus>
 <20201019045827.kl6qnx6gidhzjkrs@vireshk-i7>
 <20201019091723.GA12087@bogus>
 <20201019092411.b3znjxebay3puq2j@vireshk-i7>
 <20201019101241.GB12908@bogus>
 <20201019103535.ksp5ackoihamam4g@vireshk-i7>
 <20201019141007.GA6358@bogus>
 <20201020050557.a3b2nk33eeyxnvl2@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020050557.a3b2nk33eeyxnvl2@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-10-20, 10:35, Viresh Kumar wrote:
> On 19-10-20, 15:10, Sudeep Holla wrote:
> > On Mon, Oct 19, 2020 at 04:05:35PM +0530, Viresh Kumar wrote:
> > > On 19-10-20, 11:12, Sudeep Holla wrote:
> > > > Yes it has clocks property but used by SCMI(for CPUFreq/DevFreq) and not
> > > > by any clock provider driver. E.g. the issue you will see if "clocks"
> > > > property is used instead of "qcom,freq-domain" on Qcom parts.
> > > 
> > > Okay, I understand. But what I still don't understand is why it fails
> > > for you. You have a clocks property in DT for the CPU, the OPP core
> > > tries to get it and will get deferred-probed, which will try probing
> > > at a later point of time and it shall work then. Isn't it ?
> > >
> > 
> > Nope unfortunately. We don't have clock provider, so clk_get will
> > never succeed and always return -EPROBE_DEFER.
> 
> Now this is really bad, you have a fake clocks property, how is the
> OPP core supposed to know it ? Damn.

What about instead of fixing the OPP core, which really is doing the
right thing, we fix your driver (as you can't fix the DT) and add a
dummy CPU clk to make it all work ?

-- 
viresh
