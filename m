Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2CD1CD13C
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 07:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgEKFVr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 01:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725840AbgEKFVq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 01:21:46 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B59C061A0E
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2020 22:21:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r14so4240135pfg.2
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2020 22:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z99sLoNJtvUPb5Oimy7/Ab89RPlq4LmhubC3XgJRemk=;
        b=QdDOkdm3armA+UkqeDUI8uWIroEDHSaYNvrr4VtGNWVIFrFo/etGIyX800wKwlfa5q
         oGjtaEa0g2f4LawzX3D+qPqLg1IT+hmn+jz4LE4ATT6ZAvc+h4ODPMqZubBSVObx0qh+
         rktIuB5m9Nub3X6gvdpdt/o4LOqI/u8bZRjIcqmN0xAdzuDMPbplG9KswC+J2ZvFf918
         qRna5DApJzMlYqIQhVouVzxQ4RRgIUWfhk4Znz6rxvMTxshnPe9vImq8WYGoTka2skes
         UbrF889Y3uzhYGyxsovIbXR1ux0uVe+odeHMapgON28crbNfVN3BVpKAtQGIGKS8fvgd
         ZEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z99sLoNJtvUPb5Oimy7/Ab89RPlq4LmhubC3XgJRemk=;
        b=W8W7+2YDJ+aEgRBdezPp7SOWSsGPqD3/oj3EOk6kjGykF1ItzUhL/aypbkdP+SPAru
         L/Z/01bDQLNS+RHdK6qaYqubcsaxl5sF41oPNK4ZQTiMaw8Y07nYHiOYpmGkBZ3weT4Y
         qXzz9cJjCgKZlkiAimVjyKXnTxXcFw3DGsBO1L8c9NnTMWoe4RClQmx59brT0FzhtR+/
         haYDwuv2AQs0QS2TU+9UXInS8LDfFO3s8Mo23Q2ZQYEa4We9DX3zEmSqHWKqRf8zBE4K
         OWEUyn0nnziAuwzs+3zXgKktrb+yT9sJkXJQYR/8AbJTlZsFghRtXztmNIDx9bAfKD1B
         fnCg==
X-Gm-Message-State: AOAM5329vx2KQ5ZONoU17weC4+X+LMvYRMtOhTa+sGkKpPFILQ2tqJ3d
        LMoL6PS4/HhygBFvjOetP4hF9Q==
X-Google-Smtp-Source: ABdhPJy5If8k0d87yf9zR6j4eLkbVal8JbArOgQGRcuw/Z5nthLe/i9OHHVLXY1wFyTehEaMPXJ/yw==
X-Received: by 2002:a63:4cc:: with SMTP id 195mr627586pge.294.1589174506092;
        Sun, 10 May 2020 22:21:46 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id w11sm7976422pfq.100.2020.05.10.22.21.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 May 2020 22:21:45 -0700 (PDT)
Date:   Mon, 11 May 2020 10:51:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, rafael@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200511052142.s2zjxuv44dqx3ta2@vireshk-i7>
References: <20200507181012.29791-1-qperret@google.com>
 <20200508081128.GM5298@hirez.programming.kicks-ass.net>
 <20200508103721.GA3860390@kroah.com>
 <20200508112609.GA5298@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508112609.GA5298@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-05-20, 13:26, Peter Zijlstra wrote:
> At the very least there's that interactive governor that's really
> popular with Android. But IIRC there's a whole scala of home-brew
> governors and tweaks out there.

I removed interactive governor from Android long time back :)

-- 
viresh
