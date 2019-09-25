Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF92BE3AF
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 19:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfIYRpr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 13:45:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35775 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfIYRpr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 13:45:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id a24so265027pgj.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 10:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZAuGgXVozBxAOyU104EisOA4FjYX9B/ph1VDDQrfSC8=;
        b=Xn43tYA4vLlz8TCF32HKJSEtg2SCWQgDnM4HWr5KCnJiZ95YwMY/MLHvKYTRH1E1aT
         PdWtlOrtLmQsFpX6/Nz8oSHu843qAcoL2fmA8n9/w8CcwI/aKHa6pKTlbt2oTljKtHoT
         5Bpjf0YklXGfTJ+fj8CFCKXk3oYuaYYqf0yGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZAuGgXVozBxAOyU104EisOA4FjYX9B/ph1VDDQrfSC8=;
        b=VOEHEySDOoVdJNHWrX1vZbmMWdt7A2/JZyAKDvrcPiEZt5qdW9VzIbXLrxCArqafuY
         /IoHw4yWXILUs8WNgPILkbucLY5wqtAu27UkYTu7Wgl5PHU8eT0OBcPBJ1wY+FKTfv2X
         zrwwAvcg2WchEGIwIUTzRi/wXzQ6kIfl1Us5Sm3YpcwVIdWWVUZklnSQncQWT2aVReA3
         vug+LARKC6pgVHNO3JSLm0Sb/SOnFJJ/vJbwkitLosK4l5xV4h4wIh1g8V+y7Wt5n6lL
         wKgabgfo6gVoqsJaAhWSMaE5vy/VcUs+g27FlJI0lLvhe0WX9eegnZmGBJZs/SevIW3m
         zw4A==
X-Gm-Message-State: APjAAAUBNMKzk8NQvJD2NvwOzlcd9qA5mTSGH5fv/wccQwfvI4CWUUz6
        3uPF1v2TZsg9YlLtKFeDrl11tw==
X-Google-Smtp-Source: APXvYqxiD1rpTlqHrtU9YEtYSpp4KVbVAbHt0Mb8WqRxgoUa9sqTYMuk4PHPkRwJMeseB+Imz6hTDA==
X-Received: by 2002:a17:90a:2744:: with SMTP id o62mr7612146pje.139.1569433545789;
        Wed, 25 Sep 2019 10:45:45 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id b3sm3467917pjp.13.2019.09.25.10.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 10:45:45 -0700 (PDT)
Date:   Wed, 25 Sep 2019 10:45:43 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] devfreq: Add tracepoint for frequency changes
Message-ID: <20190925174543.GN133864@google.com>
References: <CGME20190919174436epcas4p17bf0528950813d3326237fcc56fd9b21@epcas4p1.samsung.com>
 <20190919174423.105030-1-mka@chromium.org>
 <62b2228b-e198-2558-2afc-e5687935742b@samsung.com>
 <20190924193721.GK133864@google.com>
 <418ddd67-ca8a-3d0e-066c-38d05a7082a8@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <418ddd67-ca8a-3d0e-066c-38d05a7082a8@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 25, 2019 at 10:56:15AM +0900, Chanwoo Choi wrote:
> On 19. 9. 25. 오전 4:37, Matthias Kaehlcke wrote:
> > On Fri, Sep 20, 2019 at 10:15:57AM +0900, Chanwoo Choi wrote:
> >> Hi,
> > 
> > sorry for the delayed response, you message got buried in my
> > mailbox.
> > 
> >> On 19. 9. 20. 오전 2:44, Matthias Kaehlcke wrote:
> >>> Add a tracepoint for frequency changes of devfreq devices and
> >>> use it.
> >>>
> >>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >>> ---
> >>> (sending v2 without much delay wrt v1, since the change in devfreq
> >>>  probably isn't controversial, and I'll be offline a few days)
> >>>
> >>> Changes in v2:
> >>> - included trace_devfreq_frequency_enabled() in the condition
> >>>   to avoid unnecessary evaluation when the trace point is
> >>>   disabled
> >>> ---
> >>>  drivers/devfreq/devfreq.c      |  3 +++
> >>>  include/trace/events/devfreq.h | 18 ++++++++++++++++++
> >>>  2 files changed, 21 insertions(+)
> >>>
> >>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> >>> index ab22bf8a12d6..e9f04dcafb01 100644
> >>> --- a/drivers/devfreq/devfreq.c
> >>> +++ b/drivers/devfreq/devfreq.c
> >>> @@ -317,6 +317,9 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
> >>>  
> >>>  	devfreq->previous_freq = new_freq;
> >>>  
> >>> +	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
> >>> +		trace_devfreq_frequency(devfreq, new_freq);
> >>
> >> You can change as following without 'new_freq' variable
> >> because devfreq->previous_freq is the new frequency.	
> >> 	trace_devfreq_frequency(devfreq);
> > 
> > In general that sounds good.
> > 
> > devfreq essentially uses df->previous_freq as df->cur_freq, I think
> > most code using it would be clearer if we renamed it accordingly.
> > I'll send a separate patch for this.
> 
> Actually, according to reference time of the 'df->previous_freq',
> 'previous_freq' is proper or 'cur_freq is proper.
> But, In the comment of 'struct devfreq',
> it means the configured time as following: 
> 	* @previous_freq:      previously configured frequency value.

sure, I wouldn't expect the comment of a variable/field called 'previous_freq'
say that it's the current frequency.

> I think that it it not big problem to keep the name.

It's indeed not a big problem, because the code works either way, something
like 'cur_freq' would just be less confusing.

These are the functions that use 'previous_freq' and how they use it:

devfreq_set_target
devfreq_monitor_suspend
cur_freq_show
target_freq_show
trans_stat_show
devfreq_passive_notifier_call
devfreq_userspace_func
  cur freq

devfreq_update_status
  prev freq

More than 85% use the variable as current frequency, which seems like a
good argument to give it the proper name, instead of having folks wonder
why the previous frequency is used.
