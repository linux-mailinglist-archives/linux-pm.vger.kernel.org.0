Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C84DE205
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 04:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfJUCSa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 22:18:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40674 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfJUCS3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Oct 2019 22:18:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id 15so1426242pgt.7
        for <linux-pm@vger.kernel.org>; Sun, 20 Oct 2019 19:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3KkbOgRtc0ye//XzrZ1HtbsRod4/UoW1OyI1xkwp61M=;
        b=y0X48+XU/v4pR8S1TD8PWQRDAGl7UT22V/2UB3oN+3Q07vW746B1HCclfgKCJ0ad1w
         JqYinTw0BU0f31ftYf3esKH/cDtr2DMnV0QE/sJp1vDqEmrsTtmBF9nfr05CdkjbHmGU
         YtbJUnxqUs6/nARTE52mBOo9SveKL7HCUEBlj7X9soSkXcZzrLABZymF+rc9hJY9gQzW
         8t5OeFyzN5hbcYecVOgAV/PLeEjim6vEAcZPm0n8ItB2xdrqnja7WWTut2fhjB4YVS/Q
         kCIkE5wVxHYIEz8OvNaadD8SP9kN/HklHC1t7vpCG3Kh59WA8pcQJo9CfWFu8LyL/H/L
         nkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3KkbOgRtc0ye//XzrZ1HtbsRod4/UoW1OyI1xkwp61M=;
        b=EaMkPYAQBu9FEOFZazpEylZ4cOj5LlO1znujW+J3HwTJ+OR7BmFwQDXXs3KI9x0/+t
         MMrFjNTltdrIKJ2KbiHmxoOiZtksyOm1/3VpruwWeFOVEoL3l4uIrECis4EjbPI9LafL
         Gtp3foTZlIlrG1d0v4wyFsHduxiGo9YWueGtABej9AGXLqZeTW6Gx5kPDWLmscXjF4YW
         IBvXKdUM+zvy8DJYu/yUMhWUfHmA2+u8fKyOdXu9I32viFc5ZbU7qxig4PFPQiroNVjF
         har4YAgPuVljQux7aXKcsdbK0ngKogYdJ8Pm4Yy9uqKJgVq/anjiW45HATZH5Xh0Tdtw
         21VQ==
X-Gm-Message-State: APjAAAW/t4I0RKwSbjKcT9XLLTzLBKzHY4nyh7jBuzjnkLQR+DMBW4at
        1c/jn197efXow2T9jdm1m2aMBw==
X-Google-Smtp-Source: APXvYqyfkmRm6cgUmhZUWaLCQElSCXG088L8r4pd+d221iaj1mUUWNy87aCmTxoL+oq4lWO/7puhOQ==
X-Received: by 2002:a63:41c7:: with SMTP id o190mr22715253pga.6.1571624308824;
        Sun, 20 Oct 2019 19:18:28 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id 18sm15419183pfp.100.2019.10.20.19.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 19:18:28 -0700 (PDT)
Date:   Mon, 21 Oct 2019 07:48:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Reinitialize the list_kref before adding the static
 OPPs again
Message-ID: <20191021021826.afb3yrh2r63mzghw@vireshk-i7>
References: <2700308706c0d46ca06eeb973079a1f18bf553dd.1571390916.git.viresh.kumar@linaro.org>
 <b1d263bb-f797-0f0d-5beb-0747c564ca90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1d263bb-f797-0f0d-5beb-0747c564ca90@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-10-19, 18:35, Dmitry Osipenko wrote:
> 18.10.2019 12:28, Viresh Kumar пишет:
> > The list_kref reaches a count of 0 when all the static OPPs are removed,
> > for example when dev_pm_opp_of_cpumask_remove_table() is called, though
> > the actual OPP table may not get freed as it may still be referenced by
> > other parts of the kernel, like from a call to
> > dev_pm_opp_set_supported_hw(). And if we call
> > dev_pm_opp_of_cpumask_add_table() again at this point, we must
> > reinitialize the list_kref otherwise the kernel will hit a WARN() in
> > kref infrastructure for incrementing a kref with value 0.
> > 
> > Fixes: 11e1a1648298 ("opp: Don't decrement uninitialized list_kref")
> > Reported-by: Dmitry Osipenko <digetx@gmail.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/opp/of.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index 6dc41faf74b5..1cbb58240b80 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -663,6 +663,13 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
> >  		return 0;
> >  	}
> >  
> > +	/*
> > +	 * Re-initialize list_kref every time we add static OPPs to the OPP
> > +	 * table as the reference count may be 0 after the last tie static OPPs
> > +	 * were removed.
> > +	 */
> > +	kref_init(&opp_table->list_kref);
> > +
> >  	/* We have opp-table node now, iterate over it and add OPPs */
> >  	for_each_available_child_of_node(opp_table->np, np) {
> >  		opp = _opp_add_static_v2(opp_table, dev, np);
> > 
> 
> I don't see the warning anymore, cpufreq-dt module reloading works fine
> now. Thank you very much!
> 
> Tested-by: Dmitry Osipenko <digetx@gmail.com>

Thanks for testing.

-- 
viresh
