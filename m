Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36EB761963
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 05:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfGHDFJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 23:05:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46894 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbfGHDFJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 23:05:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id i8so6869636pgm.13
        for <linux-pm@vger.kernel.org>; Sun, 07 Jul 2019 20:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ca2tpIFl6yHQwbB5affH5Fg9gK6OeRUiXwj57Mj1vE0=;
        b=VFq6tW5MKjQ1WiDZqY33YPW9/o5u43NaWJ6IKTbrnveSGtQoFvLT29BvqM79Pe23sV
         RYki/wKkg1E7Y3Ph9PQGjlpn8X5BfZpG168nbD+ElpXW7bnPEBRH67FHu5YctashwgmD
         pWq6N2lLf47ZA6dZ7VKVMtXJKgQvOdCeLzpgPf/l4A2HEgNQlCG64vxVd7ifagcD8Og2
         uLulCQdg7Fb8Ojhe9Hn6o0CFQILq4Hv1+kTXHzzYmI+1hcZBDl71IqiSZFcP5NHG/J0U
         kUyfaVrcL6h06TQACts7KRaaeV/FaN27IaqcKp/1IYC/43aHy37xq2rrabmK0k2V6dId
         Tz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ca2tpIFl6yHQwbB5affH5Fg9gK6OeRUiXwj57Mj1vE0=;
        b=ovX0pbY8wICchKzalr+FaEqaFWs8bBU1KbIkMd5b7DdmS0MV6bat1gFw9qa4wM1fAc
         3Ax4kHDtehAiy5zQMt3TMZYR5mGrmHAKzCvf4kxq0acUFGAPhozI6qkLQnfaolbwf8gi
         10aw4nxFN4KJUfcRdt/jrS/jjZrPwXWwxrVNC1tvXroAnmPHNGIopjYUzsa+yfA0HtJ5
         qgye9zzkbSnRdq4GnSNQLk1Kw29lK2mSBcxJQz/NJZW7MByzJxVOCOMOgoBhGDxWmgnx
         6KJ77mXv4cLJzelUHejja5uoCW7sfkhuqDIyo61/ayzeT+u7/7ogyt5mjTRhuOHiwZG7
         7ObA==
X-Gm-Message-State: APjAAAWLF6jZTGG232gLnkhIMhZzU17T9ig2jCbyAsZnbe4DYSj6/PGH
        TwYWfoCiFyCH4fdq5wHlYADeDw==
X-Google-Smtp-Source: APXvYqzc1s7VmGIq2VxBLyML+3yvNdAWNOg6+sQcjG/qoVV+In5GR+guYWIUkKBapldiGjAkhDqZ0Q==
X-Received: by 2002:a65:538d:: with SMTP id x13mr20493819pgq.190.1562555108255;
        Sun, 07 Jul 2019 20:05:08 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id c98sm17123060pje.1.2019.07.07.20.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 20:05:07 -0700 (PDT)
Date:   Mon, 8 Jul 2019 08:35:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, mka@chromium.org,
        ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: cpufreq notifiers break suspend -- Re: suspend broken in
 next-20190704 on Thinkpad X60
Message-ID: <20190708030505.kvrg6sh6bd4xzzwa@vireshk-i7>
References: <20190704192020.GA3771@amd>
 <CAJZ5v0gn7FWpqW+WmCzj1=K-pjY=SjRNuEsMR3bRTSO8FzFG=Q@mail.gmail.com>
 <20190705185001.GA4068@amd>
 <CAJZ5v0irbn-Xd47KExw=h7On7KShCm6rThCo0q4-zn=o_x6_HQ@mail.gmail.com>
 <20190706203032.GA26828@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706203032.GA26828@amd>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-07-19, 22:30, Pavel Machek wrote:
> Hi!
> 
> > Anyway, if 5.2-rc7 is OK, something in this branch causes the problem
> > to happen for you.
> > 
> > I would try
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=f012a132824fc870b90980540f727c76fc72e244
> > 
> > to narrow down the scope somewhat.

I couldn't find the original mail, what exactly is the problem with
suspend in your case ?

> Bisect says:
> 
> 572542c81dec533b7dd3778ea9f5949a00595f68 is the first bad commit
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> 
>     cpufreq: Register notifiers with the PM QoS framework
> 
>     This registers the notifiers for min/max frequency constraints
>     with the
> 
>  Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>  Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>  Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Unfortunately, it does not revert cleanly:

I tried following on my ARM board (both single policy and multiple
policy configurations):

rtcwake --seconds 5 -v -m mem

And everything worked as expected. Please make sure the top commit of
my series in pm/linux-next is, some issues were fixed on Friday:

0a811974f3f7 cpufreq: Add QoS requests for userspace constraints

-- 
viresh
