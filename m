Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F007F246602
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 14:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgHQMHb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 17 Aug 2020 08:07:31 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:43383 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgHQMH3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 08:07:29 -0400
Received: by mail-ej1-f66.google.com with SMTP id m22so17390729eje.10;
        Mon, 17 Aug 2020 05:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XIuQOuUaLCyIWHshWktb4nYi9hWRbsGYibRpCmgF41g=;
        b=mBE5zgHpSE1ZLEVdCf8iLSCVvcrWSTMpZYPtt2LkF1pvX6hqiOxSbURSN/zdsc/mDm
         ZYFJIm4Fb5pVKwJigTfYy832/4O1EdQQ8EFy66WO9ASCuWeccRT8TOfSiV/Id5clQymn
         y2y5Laxr+TBNyrWS8hwCD+X++j+NoEpovWHn3wd66E+0jhPnUCB0IMRQ8bFP919bUoew
         Z7cOJ1fRgyraOOadDgXXPFyjcBgg8WfsnseGqzf566iYXZvUysSZdCqC/QbgkO54b+L/
         HFWbjFs1d5yMBl79v9WMM8I7EMXSM6ZWkmrjgbEer5IIPBsnBlEIb55bWdBZtWgliy5t
         gmbQ==
X-Gm-Message-State: AOAM533ycfO9H7M7+yf46a0Q/lfDTyEI3hdFZCnkfuCacyC1OrBc/KNp
        L7swj+xnreCVg+UjllCeeBE=
X-Google-Smtp-Source: ABdhPJz7HdyH9hH9sLE1i/WqKVViT+08Fne7n9TmxR2ujamxyK3OlQ1uIBv+agqYmfW/N1N5m3WT1w==
X-Received: by 2002:a17:906:7f0b:: with SMTP id d11mr15808343ejr.116.1597666047383;
        Mon, 17 Aug 2020 05:07:27 -0700 (PDT)
Received: from kozik-lap ([194.230.155.242])
        by smtp.googlemail.com with ESMTPSA id eb11sm7997597edb.76.2020.08.17.05.07.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Aug 2020 05:07:26 -0700 (PDT)
Date:   Mon, 17 Aug 2020 14:07:24 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: propagate error from
 exynos5_counters_get()
Message-ID: <20200817120724.GC2346@kozik-lap>
References: <CGME20200804061225eucas1p283c1e0dc404bc420a2184480fdfd2b0d@eucas1p2.samsung.com>
 <20200804061210.5415-1-m.szyprowski@samsung.com>
 <24675559-b807-5b80-1318-805c1530ffb3@arm.com>
 <78c95f58-8142-7607-6d74-5cfa6a7ffb77@samsung.com>
 <f3f416ac-0d63-b4e5-676f-8801b4166c11@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <f3f416ac-0d63-b4e5-676f-8801b4166c11@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 04, 2020 at 01:38:11PM +0100, Lukasz Luba wrote:
> 
> 
> On 8/4/20 1:19 PM, Marek Szyprowski wrote:
> > Hi Lukasz,
> > 
> > On 04.08.2020 11:11, Lukasz Luba wrote:
> > > Hi Marek,
> > > 
> > > On 8/4/20 7:12 AM, Marek Szyprowski wrote:
> > > > exynos5_counters_get() might fail with -EPROBE_DEFER if the driver for
> > > > devfreq event counter is not yet probed. Propagate that error value to
> > > > the caller to ensure that the exynos5422-dmc driver will be probed again
> > > > when devfreq event contuner is available.
> > > > 
> > > > This fixes boot hang if both exynos5422-dmc and exynos-ppmu drivers are
> > > > compiled as modules.
> > > > 
> > > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > ---
> > > >    drivers/memory/samsung/exynos5422-dmc.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/memory/samsung/exynos5422-dmc.c
> > > > b/drivers/memory/samsung/exynos5422-dmc.c
> > > > index b9c7956e5031..639811a3eecb 100644
> > > > --- a/drivers/memory/samsung/exynos5422-dmc.c
> > > > +++ b/drivers/memory/samsung/exynos5422-dmc.c
> > > > @@ -914,7 +914,7 @@ static int exynos5_dmc_get_status(struct device
> > > > *dev,
> > > >        } else {
> > > >            ret = exynos5_counters_get(dmc, &load, &total);
> > > >            if (ret < 0)
> > > > -            return -EINVAL;
> > > > +            return ret;
> > > >              /* To protect from overflow, divide by 1024 */
> > > >            stat->busy_time = load >> 10;
> > > > 
> > > 
> > > Thank you for the patch, LGTM.
> > > Some questions are still there, though. The function
> > > exynos5_performance_counters_init() should capture that the counters
> > > couldn't be enabled or set. So the functions:
> > > exynos5_counters_enable_edev() and exynos5_counters_set_event()
> > > must pass gently because devfreq device is registered.
> > > Then devfreq checks device status, and reaches the state when
> > > counters 'get' function returns that they are not ready...
> > > 
> > > If that is a kind of 2-stage initialization, maybe we should add
> > > another 'check' in the exynos5_performance_counters_init() and call
> > > the devfreq_event_get_event() to make sure that we are ready to go,
> > > otherwise return ret from that function (which is probably EPROBE_DEFER)
> > > and not register the devfreq device.
> > 
> > I've finally investigated this further and it turned out that the issue
> > is elsewhere. The $subject patch can be discarded, as it doesn't fix
> > anything. The -EPROBE_DEFER is properly returned by
> > exynos5_performance_counters_init(), which redirects exynos5_dmc_probe()
> > to remove_clocks label. This causes disabling mout_bpll/fout_bpll clocks
> > what in turn *sometimes* causes boot hang. This random behavior mislead
> > me that the $subject patch fixes the issue, but then longer tests
> > revealed that it didn't change anything.
> 
> Really good investigation, great work Marek!
> 
> > 
> > It looks that the proper fix would be to keep fout_bpll enabled all the
> > time.
> 
> Yes, I agree. I am looking for your next patch to test it then.

Hi all,

Is the patch still useful then? Shall I apply it?

Best regards,
Krzysztof

