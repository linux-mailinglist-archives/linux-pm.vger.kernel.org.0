Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0521D0F4E
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 12:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388638AbgEMKGT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 06:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388602AbgEMKGR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 06:06:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A59C061A0E
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 03:06:17 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so27776107wmc.5
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zU0nB1Ip8ux85FhZzaXr4w0z8K5MqsOQGnZo4jaAbog=;
        b=SszF5JPW3fDKq2WXZ39nc9lt5EoRcBFOKEf7uZel3MJNBA0J7xDYyepZ0GB8YN2VoX
         FyQ3Hp7xbElnfZvb8GtdVWbJQPOtnErTX233RRP744Q6VTMBlG5q+eucT4uCUWIVMPj4
         zFa9/+WUYlcsh/gG1hOn36HQj6yk2mZCB48BqGFRztVd07biYqlPpAnxXb8dZpJCiToO
         VfemMFAHmSwm4hoUFOxJZj2mDlBuZ9fUAqgFkFsiXIolgtHnzH0A8/jBI0hhedCfa1/f
         H7CvfWcHTM+6t7cekF9kiPFDTq0eoRIuN0VsDfnsJRdF0WSZkZhmcAMUgr/0ndRe5Jrp
         eRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zU0nB1Ip8ux85FhZzaXr4w0z8K5MqsOQGnZo4jaAbog=;
        b=LthL6mKFHqzL2qCNWBGkVxaL+ZHdrdaBKR1I9uIqkjuB0fF9yEAHXJQpOw/+uFCsSP
         h5cCkJOBux+FYwFxRhrVg9BjFfB63ufA4Jayio6//a+dlWeQN6yRQ9N7hRthlVSgFjky
         RTVJdrgB6Iq8hl6MsakMl66rJ1TH5/vdsPqdKM4bUyRCxj3BfshWJMeqPLUctOsDyVZr
         5nE4aR4v95pRp4VpepI99xpcvGtX+MuKS87Gd19BeoVOg8LILtdlofWFhdWeEfP2NsVd
         orOoDlw6h/hLKz7jCKkU3HjK8GXqlrJv9rX+T0jNp7Jd7Zp+bBYpItbbMh95afgwp03X
         b67A==
X-Gm-Message-State: AGi0PuayombAo8auJlUqkK2yjPvMY17hkVp6sAyKZKdn9QPDZp6erzMv
        ajRi7X5QCs1/yF2f2/UE2G11IA==
X-Google-Smtp-Source: APiQypK2RUITynpf031+51+fINLm92xUpyiGpfNAzJn9+fcZDpMYpGn6iHsaty4IHIxjBH6P5sq3fA==
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr12590358wmj.173.1589364375719;
        Wed, 13 May 2020 03:06:15 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id l13sm10335380wrm.55.2020.05.13.03.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 03:06:15 -0700 (PDT)
Date:   Wed, 13 May 2020 11:06:11 +0100
From:   Quentin Perret <qperret@google.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Todd Kjos <tkjos@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200513100611.GA168476@google.com>
References: <20200512092102.GA16151@google.com>
 <CAJZ5v0hm3Tv2yZKLzM9a+kJuB1V5_eFOEKT-uM318dzeKV3_Qw@mail.gmail.com>
 <20200512135813.GA101124@google.com>
 <CAJZ5v0hN708uvurZ-3oo90qUJFw3=Eg0OmtTaOKXQgNPXhCkFg@mail.gmail.com>
 <20200512151120.GB101124@google.com>
 <CAJZ5v0inoge=nWQtv-rU_ReQUMZA5w-PZXuSpHHj1UHn-S7aSA@mail.gmail.com>
 <20200512162630.GC101124@google.com>
 <CAJZ5v0ges4=e2HkHpVk4E1yF1VsBm9H5noqMz-MxX9DK_kt6Xg@mail.gmail.com>
 <20200513094117.GB225140@google.com>
 <20200513100213.GA868852@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513100213.GA868852@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 13 May 2020 at 12:02:13 (+0200), Greg KH wrote:
> It's not significant at all, just always build it in, no one will notice
> it, it's just a page or two.  Serial port drivers are way bigger :)

Alright, I give up :)

When partners will complain (and I think they will) I'll point them here
and say we tried ;)

Cheers,
Quentin
