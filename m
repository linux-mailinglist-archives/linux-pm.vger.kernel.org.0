Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC5F31E8C6
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 11:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhBRKlT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 05:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhBRJ3f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 04:29:35 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA397C0613D6
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:28:54 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 75so767524pgf.13
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZ8nYLZzdIZG1Io1KW2qgUFRdyKDOYf33IwBsOGo870=;
        b=rHOwB/Mi0SoliUDjP42ExtQtcCyXB1+DFRzl4ZDVtofoQ/1NzhSo48SeT2q/mjr3Yi
         lourxFUuZDbH1Xnk7f1Me1N/uh55TSbbyvgg+kHYvjmOLKmPRrA4ha1hdgVHjyfecz/P
         sxnduoMwxB+GBRYSwsjmef56z/SraUcK6QYhFZh4/HMVbxsi1BxYba+97gGL50z7gZlu
         6seF9wkgAZowVAq0kuSXB/6SbAEVri1YSJqpKMD7NERoD4TltWFNRIvmVU7YHPE04mbU
         7sHKw1pa8bCpOLTN61PdCyYy9QDRbaVHf2aQgcan88ZKwU0qKYcfNW65Gfs58gQS8c48
         o7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZ8nYLZzdIZG1Io1KW2qgUFRdyKDOYf33IwBsOGo870=;
        b=S4ZNU5XlmDixo/BvmhOfjKgvW/CXKnFaEghZ24KJDmtAK8LsANxeT66p+xYSWjgA64
         Mx0tuuNqSzNV0D+7pZ5fgjiT9RWftaXpuqrn2xlAlK+uBcQvH/rp1/70j7lPPjbpHTGL
         +R+qcnZplY4BYTzs/jr7LNKAD/BHc2CUoYwxv1IwXpzxEHTsSkMCoU8uS1OBBO4k6J3s
         PQnJ38QowGL7mBISDCMiE7V1L5z6Rf+GOqC9c0mHAbnZ3hK0i+CGFRuaGzivHJLiU2gW
         jvq88qtmrQnI+qRC/q/0Xp3xW57uUKscJAt+NsEda6OQDLJRD4mamMpV8IfFciCiMP6m
         P0iA==
X-Gm-Message-State: AOAM530WJNuncG6OEexx2mCkNJuBSvLYYOSmeByg1TDoFNN78wDKVShV
        HNzxrBjkzPYRJmoxOpRpZak=
X-Google-Smtp-Source: ABdhPJzjq6R/hWJ2YC3ULrPLUzIifhP8CH883v1nP7exX8t8AfFzQlCenQgM12a5j2gh3dKU1CcTxw==
X-Received: by 2002:a65:43ca:: with SMTP id n10mr3255570pgp.430.1613640534588;
        Thu, 18 Feb 2021 01:28:54 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id s10sm5616538pgl.90.2021.02.18.01.28.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Feb 2021 01:28:54 -0800 (PST)
Date:   Thu, 18 Feb 2021 17:28:45 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] cpufreq: schedutil: Correct comment to update_lock of
 struct sugov_policy
Message-ID: <20210218172845.000071c1.zbestahu@gmail.com>
In-Reply-To: <20210218092658.y4dxcxayz25ogrpi@vireshk-i7>
References: <20210218092316.1624-1-zbestahu@gmail.com>
        <20210218092658.y4dxcxayz25ogrpi@vireshk-i7>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 18 Feb 2021 14:56:58 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 18-02-21, 17:23, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Currently, update_lock is also used in sugov_update_single_freq().
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c
> > b/kernel/sched/cpufreq_schedutil.c index add8081..cc0308c 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -26,7 +26,7 @@ struct sugov_policy {
> >  	struct sugov_tunables	*tunables;
> >  	struct list_head	tunables_hook;
> >  
> > -	raw_spinlock_t		update_lock;	/* For
> > shared policies */
> > +	raw_spinlock_t		update_lock;	/* For
> > single + shared policies */  
> 
> I will just remove the comments, its pretty much useless anyway.
> 

ok, i will do it.

Thx.
