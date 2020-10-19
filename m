Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1390129220B
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 06:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgJSE6c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 00:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgJSE6c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 00:58:32 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCCFC061755
        for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2020 21:58:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l18so5321301pgg.0
        for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2020 21:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6f/C91tZNh03qAAs3dj6+V8PcNIszWwYD5WiOJW/Er0=;
        b=hFWsgeKIpyXv63TLxokl4C22aWQfvnpdVKlP9XwktpzygC+EIBOzHOeeG3fVitdSFF
         LHJ6x/3/MqdVu9V+qpXe67o2VcWMH7XLwOncpvghPljed4FxRiMkLf2scwRSfmxL/rPA
         3Tc+x2WVE76Y1Pxr0E1uiU5UE2Ou5NzNDWbz1ApMfKbkWXlRcsy4F9HYiJQ8NQXGMHrf
         54GoMH95H2WrpiIzlI8LcJBzuifFJcXyanGESk5QEfJfybmhpzcK1buKfCjinbdQ0TfD
         2vQI/gDFjA3SOdMTOKvhM71ScHfVKXEHIU3WNJ4xwtpjBU9A64G1MFJ68rcz9uSJUgpH
         8S5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6f/C91tZNh03qAAs3dj6+V8PcNIszWwYD5WiOJW/Er0=;
        b=e5rHg/7xcPJ9JTKZxYDEujJtYdP3qtKm+SyEmKD9IEvuz+HjmbK/dzVlouOGjoE6y7
         5KAbazjaWNV8kOgtxlbUfcSkO+61jG+aJ2snCXMnH9ASUCP+bQqIhFkNPWgEFqb6sw40
         tbUmr4i0YyRK8rd3OfVIjSbkpeNREBXHzZgkTX14O51lUNKYJs0KenPVQflDSGotVqZm
         IosLFVmdoRhL/1FkXlci3IJgCHgEWKaSBGLwxfyjYXhmf1f1XNIYPaPhd+d45V7QTJwi
         UkzCIfxgA9rRVp2P4HhRTAxELwIoEb0jGHehTOs9ep4NQ8O5pEBU3K4rszafcc8CGCG/
         UjpA==
X-Gm-Message-State: AOAM533OtHbuzZ5w7ZBJVCm6j0WEQYWoUBHYj1O3b8ndQgFfva4EfkcC
        qEkVXUsX9m3B2jNDoDA4LNsnXQ==
X-Google-Smtp-Source: ABdhPJxWF9t4wYpgYzkSlSShupSIZhYevBl94ZD7xoiUcQVL/1GrfPReeWHV9QXxkcnbMeOGAXhmzA==
X-Received: by 2002:a65:5785:: with SMTP id b5mr12436826pgr.44.1603083510308;
        Sun, 18 Oct 2020 21:58:30 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id z16sm10342158pfr.116.2020.10.18.21.58.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Oct 2020 21:58:29 -0700 (PDT)
Date:   Mon, 19 Oct 2020 10:28:27 +0530
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
Message-ID: <20201019045827.kl6qnx6gidhzjkrs@vireshk-i7>
References: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
 <20201015180555.gacdzkofpibkdn2e@bogus>
 <20201016042434.org6ibdqsqbzcdww@vireshk-i7>
 <20201016060021.sotk72u4hioctg7o@bogus>
 <20201016111222.lvakbmjhlrocpogt@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016111222.lvakbmjhlrocpogt@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-10-20, 12:12, Sudeep Holla wrote:
> On Fri, Oct 16, 2020 at 07:00:21AM +0100, Sudeep Holla wrote:
> > On Fri, Oct 16, 2020 at 09:54:34AM +0530, Viresh Kumar wrote:
> > > On 15-10-20, 19:05, Sudeep Holla wrote:
> > > > OK, this breaks with SCMI which doesn't provide clocks but manage OPPs
> > > > directly. Before this change clk_get(dev..) was allowed to fail and
> > > > --EPROBE_DEFER was not an error.
> > >
> > > I think the change in itself is fine. We should be returning from
> > > there if we get EPROBE_DEFER. The question is rather why are you
> > > getting EPROBE_DEFER here ?
> > >
> >
> > Ah OK, I didn't spend too much time, saw -EPROBE_DEFER, just reverted
> > this patch and it worked. I need to check it in detail yet.
> >
> 
> You confused me earlier. As I said there will be no clock provider
> registered for SCMI CPU/Dev DVFS.
> 	opp_table->clk = clk_get(dev, NULL);
> will always return -EPROBE_DEFER as there is no clock provider for dev.
> But this change now propagates that error to caller of dev_pm_opp_add
> which means we can't add opp to a device if there are no clock providers.
> This breaks for DVFS which don't operate separately with clocks and
> regulators.

The CPUs DT node shouldn't have a clock property in such a case and I
would expect an error instead of EPROBE_DEFER then. Isn't it ?

-- 
viresh
