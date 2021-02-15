Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208AE31B567
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 07:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhBOGax (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 01:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhBOGaw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2021 01:30:52 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BE3C061756
        for <linux-pm@vger.kernel.org>; Sun, 14 Feb 2021 22:30:11 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id nm1so3132862pjb.3
        for <linux-pm@vger.kernel.org>; Sun, 14 Feb 2021 22:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zrrEJXp5mV7UerRAeRKG8eH9oggn9kYScOtYlCg1RtE=;
        b=c8g5I91zu7IKDPWRVPgs/cED8NOhfy+V9BA2gFo06lfye2pSAvDAkGRhhTmEnlzw5B
         iTSU2NuOPWQYxgSUQ52oGuyUaGQelQpU3wt851sbECfNqYZMeqyDFT0FSqtnbyE1wxBx
         HtWsOszmdOnFkKq5Do2Db0vtr9W6Ep2QcKKeqS+h+rN6QLQPyRhRGg5KrzA74AE3ZHQK
         No9QT1nHtmV1lziAKaQ+wxdZNUGiB/0al++tnnbRo6gdkwtbMS9+mXrFWVOBziFxcTcU
         /kRGQo2pP7ia+AyXJyutfnWOgoRM+QufF/ERsq4tAEtxy5qS7xD2uAyH0vbQP3E5dtlu
         /f5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zrrEJXp5mV7UerRAeRKG8eH9oggn9kYScOtYlCg1RtE=;
        b=Ymv35d5PQPF1io9KanRs+g7yuDgXE7w/6ImKwE9LVUohsARgDXWjzLX6AhKsIL/yP4
         gVrNbcapxELbsDwDy6rq1/eDp9WkC2IaqpGbEnT64/VeSQ0wL3dqEfqvM/8taF2oi0Ip
         OEbig8rNeLUsw4Hu+bODZgms1/yx6UWwJtCJNp4TKhsDGH0969o7duY/c7VR78oAh7sn
         x1KLfRrc6Kj++uDkrrwIV6gNjpP8MnS7gADU/0Zxoopr3BiTfAF/Tg1qViSlf1K35Jur
         TFVORpB5nfg78rNH5qXHq8haiUgZEwIEbSGTKko/7Ebqqs0P5VjWRqa20dDAur8au2ru
         zXxw==
X-Gm-Message-State: AOAM531yWT6vaCFj4gYuRNxDXEr2bUWX93JpjiIbm6Cyu6YLM1+TldAt
        nl+hhRaTV2tW+WFWXl2InOs3Yg==
X-Google-Smtp-Source: ABdhPJzGTe48lxsGoiG5BQ2cUhs0YpVQdWcNZ1OnRBhDVBxUsDeJC5QSFVAut2zzMiSJhUPfzhz6Kg==
X-Received: by 2002:a17:90a:8e83:: with SMTP id f3mr15278354pjo.70.1613370611311;
        Sun, 14 Feb 2021 22:30:11 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id h8sm15462226pfv.154.2021.02.14.22.30.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2021 22:30:10 -0800 (PST)
Date:   Mon, 15 Feb 2021 12:00:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@163.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Yue Hu <zbestahu@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zhangwen@yulong.com
Subject: Re: [PATCH] cpufreq: schedutil: Don't use the limits_changed flag
 any more
Message-ID: <20210215063008.hsdkrs4bw7wt3wye@vireshk-i7>
References: <20210208030723.781-1-zbestahu@gmail.com>
 <CAJZ5v0hmgQp--uhRMZbqZnOvQPy9zLfQx_u=xAewmV=LgT6rPA@mail.gmail.com>
 <20210214114421.00000550.zbestahu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214114421.00000550.zbestahu@163.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-02-21, 11:44, Yue Hu wrote:
> On Fri, 12 Feb 2021 17:14:03 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > This may be running in parallel with sugov_update_next_freq() on a
> > different CPU, so the latter may clear need_freq_update right after it
> > has been set here unless I'm overlooking something.
> 
> Whether this logic is also happening for limits_changed in
> sugo_should_update_freq() or not?

It is but it shouldn't have any side effects as we calculate the next
frequency after cleaning the limits_changed flag. Your patch would
have been fine, but it is not anymore because of commit 23a881852f3e
("cpufreq: schedutil: Don't skip freq update if need_freq_update is
set").

It made a considerable change after which your patch adds a bug. With
23a881852f3e, need_freq_update is updated/cleared after the next
frequency is calculated, while earlier it was cleared before it. And
so even with the race condition taking place, there were no issues.

-- 
viresh
