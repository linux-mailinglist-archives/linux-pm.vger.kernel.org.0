Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD4826AB50
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 19:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgIOR6c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 13:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbgIOR6O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 13:58:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD82C061788
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 10:58:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q4so180419pjh.5
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j+g2akO1lz2ozUn1CRIfY/0d2i70WKcJaWsW6RG6CLQ=;
        b=hEsZVQNwXVb5K4Iph8p76V23YfAj+k4SN8f0kxzSkN7p+uCYR8z/2IVqN8L06s78aF
         Sb7NcBWHJB36BAYQWVD5TRuWB52QF1dvWygLsshdIPk5pOmIlQEkuQXjV+clkEAeLJm0
         o8/5GNFXs/MWQWMRSxjJXh2KYHFGnVWvi5xWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j+g2akO1lz2ozUn1CRIfY/0d2i70WKcJaWsW6RG6CLQ=;
        b=S5nwy12uUOchbwqUTiWMOlqZrhzZXE/3/N/fEcBsAFbmO3wL/pNPblq1yPjezcj5yC
         zC44Zt1O8SEksKZoj0aqUHuWBMncfsI5XvrGp9pcXcjqlSYzvs0PI1jm31hXpah3CqVI
         k0vRzD1d7h5VnL363I60y6U/XR4lhRHKY/+NAJ45ARgElbOSOyd1Q898vq2DBb3k0124
         BtQATfFQ3H3riE8NngOF802KRuSpF9ZXOyMazqi7v7lCeBMBHVfR96SGsa+dAO3TZ19E
         Kt4pm0HpvSDvs9QEOzi48Yqxi8JlMXcDVs1/OmgZKX7gLWAulTnNjQgAVnzkYQmghvlQ
         CANw==
X-Gm-Message-State: AOAM532tkCp2U24ITd8TnqulY+9bbzOTr1ax0DZ3WXPnHz2GTyxG4kk4
        w+0IRXOni1hakrrwgK8VzD3cug==
X-Google-Smtp-Source: ABdhPJzWSjusUL5iCMafqzidmc97rO1FaeMZvyldTmp4urHg5wJfBQZNJIuEoiZx9TlvbaxdNZZd1g==
X-Received: by 2002:a17:902:b94b:b029:d1:e5f9:9f8 with SMTP id h11-20020a170902b94bb02900d1e5f909f8mr2678519pls.53.1600192689753;
        Tue, 15 Sep 2020 10:58:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id k5sm14843618pfp.214.2020.09.15.10.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:58:09 -0700 (PDT)
Date:   Tue, 15 Sep 2020 10:58:08 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>
Subject: Re: is 'dynamic-power-coefficient' expected to be based on 'real'
 power measurements?
Message-ID: <20200915175808.GB2771744@google.com>
References: <248bb01e-1746-c84c-78c4-3cf7d2541a70@codeaurora.org>
 <20200915172444.GA2771744@google.com>
 <406d5d4e-d7d7-8a37-5501-119b734facb3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <406d5d4e-d7d7-8a37-5501-119b734facb3@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 07:50:10PM +0200, Daniel Lezcano wrote:
> On 15/09/2020 19:24, Matthias Kaehlcke wrote:
> > +Thermal folks
> > 
> > Hi Rajendra,
> > 
> > On Tue, Sep 15, 2020 at 11:14:00AM +0530, Rajendra Nayak wrote:
> >> Hi Rob,
> >>
> >> There has been some discussions on another thread [1] around the DPC (dynamic-power-coefficient) values
> >> for CPU's being relative vs absolute (based on real power) and should they be used to derive 'real' power
> >> at various OPPs in order to calculate things like 'sustainable-power' for thermal zones.
> >> I believe relative values work perfectly fine for scheduling decisions, but with others using this for
> >> calculating power values in mW, is there a need to document the property as something that *has* to be
> >> based on real power measurements?
> > 
> > Relative values may work for scheduling decisions, but not for thermal
> > management with the power allocator, at least not when CPU cooling devices
> > are combined with others that specify their power consumption in absolute
> > values. Such a configuration should be supported IMO.
> 
> The energy model is used in the cpufreq cooling device and if the
> sustainable power is consistent with the relative values then there is
> no reason it shouldn't work.

Agreed on thermal zones that exclusively use CPUs as cooling devices, but
what when you have mixed zones, with CPUs with their pseudo-unit and e.g. a
GPU that specifies its power in mW?
