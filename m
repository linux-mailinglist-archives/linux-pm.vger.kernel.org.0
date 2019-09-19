Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C84B7FFA
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 19:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390860AbfISRZg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 13:25:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33378 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390843AbfISRZg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 13:25:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so2773907pfl.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 10:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DJzyXNF8iTS1yqKZOMbwgyqWnQ4cfI4lYx+lKZ4L8Xo=;
        b=cfE6edkP26+ud/ERpMrZEAYsavn3IO/jjGtCQLonmnCu1KmIMdeQHvqNPOnxoZD/iw
         HoGC4xNoOfP7iXv75IoFPqkhMpUwgr2tMK3meZqd8hK4p2Vw58aKIE3gZBORjWwUgPD+
         G+Fmzvu8BDoLs9UBzVzCNPgZW027iSQZ0FnZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DJzyXNF8iTS1yqKZOMbwgyqWnQ4cfI4lYx+lKZ4L8Xo=;
        b=KQEqBnPKNsstm9VyTt4d2111eivOiFxFINccuomEdpUl+EaDNne9Dq4jfiBoNz2KVR
         vBobiLpIHSIl01NPpbpFKKH54/L7Lmy3Lbh5zWbViJ0OpovUE7RxW121euLiR632bC5Z
         M08+ZBMUninzAcAiNIXfDnH//6j+p31oAQ0yzDFac0n6cRuMZ/MU/UEopNfn3B13/PBe
         F5kxRgLzlgA+jIvmfJP/IqenS4zkEKY/NcCEW9cjAHRHugMjNLBjJ5gQvHw1rOxc5xI1
         jAz9RqS0R3Pf4TL8cAOJGlhBuhGGxM2ijXG8d0LrtGXqMPq16JdvESd+Gjd7perr8ldw
         xsjQ==
X-Gm-Message-State: APjAAAXdPbQSbCHd1CUDcpU7L06fu8iCaW/1Dl2sm2sUK5WSN5IDqET/
        RKBnYeSK2MKh0PuyQf/SCkjxOA==
X-Google-Smtp-Source: APXvYqxmUPU6Nfqmu0y8uViniAr+3rSxtfyaajROXjNndjr3j5x89y/frD8XSM6YQBKdRLxAbW6SVg==
X-Received: by 2002:a65:6547:: with SMTP id a7mr10013007pgw.65.1568913935969;
        Thu, 19 Sep 2019 10:25:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p20sm8656051pgj.47.2019.09.19.10.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 10:25:35 -0700 (PDT)
Date:   Thu, 19 Sep 2019 10:25:33 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] devfreq: Add tracepoint for frequency changes
Message-ID: <20190919172533.GS133864@google.com>
References: <20190918191537.48837-1-mka@chromium.org>
 <20190919123559.2931e0ef@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190919123559.2931e0ef@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Thu, Sep 19, 2019 at 12:35:59PM -0400, Steven Rostedt wrote:
> On Wed, 18 Sep 2019 12:15:37 -0700
> Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > Add a tracepoint for frequency changes of devfreq devices and
> > use it.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/devfreq/devfreq.c      |  3 +++
> >  include/trace/events/devfreq.h | 18 ++++++++++++++++++
> >  2 files changed, 21 insertions(+)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index ab22bf8a12d6..32de1f6ac776 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -317,6 +317,9 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
> >  
> >  	devfreq->previous_freq = new_freq;
> >  
> > +	if (new_freq != cur_freq)
> 
> I would make this:
> 
> 	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
> 
> Because this would place the second check into the "nop" portion of the
> code, keeping the test from being performed if the devfreq_frequency
> trace point is not enabled. Slight micro optimization, but still enough
> to add it.

Sounds good to me, thanks for the review!
