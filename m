Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6254B7E03E
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 18:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfHAQee (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 12:34:34 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44380 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729364AbfHAQee (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 12:34:34 -0400
Received: by mail-vs1-f66.google.com with SMTP id v129so49297249vsb.11
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2019 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvRoX0NEsQk9uexjhPZ3WYNGs4rNhG1WU3C5nGaJfJM=;
        b=OA94mFnKu9MN40x5ZP19/Na2xaPAb2ScvmDnDhcfY2prbEDzeCDna+MwcFseo3nnf5
         1AUcDpimJVSG1wT8fJosG0BZnnSuvapIZ53206Su4kgn5QQmaxAvbnNbW1l2qDcUSf7S
         g1CCg6WhlKunjGWiR+ByOfg5e/renIOsnueh69l9UYU9kzwbl+y/0wFgo7RZe9BpcWQf
         y4NlE7WvT9g6JByabW9SWTk6ge4/LEx9IlMEx8x8h0CEwzdytxY4S23QstL7jNj7dZbT
         yHei/SyFU3x0wlV9kg/i7T6d1yO8NHrdI7yzGaWIgDYZfPY1l7ma8qkaYpdrU7paRQLU
         dqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvRoX0NEsQk9uexjhPZ3WYNGs4rNhG1WU3C5nGaJfJM=;
        b=Nd7yLhOSB66mBEheuMzQHguma5JaYYsR9Heh9JstuwZuMzzQOV1O6xjBorFKp9WTeA
         4ZGw7HOlBX2GECUXJejbpYC/Ztvtg6+rzKqBaMEwxcKhcuVGvukmuDiLyBQdEo4juKoA
         Il7LnPEu933JdCcupRFzfu0IDtNBnULQvqL24M+elhY30P7oKtgev9oVXwieWElqmShK
         GH3OR8d4WD2q0R9g+xQkse5GtWWKbOhIsv5VwEoFsCRLcOnJnwrYorV/ZTWPjC1SmVAf
         49Yc6UDLCe4o3x/5vkUjoidntU7yTBKfdQnqna3GJw/ZF17LSEN0P/NwY2CnRwKpNtOF
         HOKg==
X-Gm-Message-State: APjAAAWgy9vrFjaaxPY7LU657RUgVLFNti3XhuRpQkJE8k6fsqhQGrC1
        YzD4QOsGu5tYL5hBTp9+O+bQuV7yo/5Bmwwr7vvxjA==
X-Google-Smtp-Source: APXvYqydtcOkpu3k1CXQGjTrhaIKC2YliA7J9eX1NcSUJxl4798q/t6LuS+fW/3LemXGtS34w27lPgBhk1ooXMDOtVg=
X-Received: by 2002:a67:a44b:: with SMTP id p11mr78053893vsh.237.1564677272877;
 Thu, 01 Aug 2019 09:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190731050549.GA20809@kroah.com> <20190731212933.23673-1-kaleshsingh@google.com>
 <20190801061941.GB4338@kroah.com>
In-Reply-To: <20190801061941.GB4338@kroah.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 1 Aug 2019 09:34:22 -0700
Message-ID: <CAC_TJvdUReRL-Xqq-sSOZ6w1FpEA=Uzys22Mami1USrErnkw+Q@mail.gmail.com>
Subject: Re: [PATCH v2] PM/sleep: Expose suspend stats in sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rjw@rjwysocki.net, Tri Vo <trong@google.com>, trong@android.com,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 31, 2019 at 11:19 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 31, 2019 at 02:29:33PM -0700, Kalesh Singh wrote:
> > Userspace can get suspend stats from the suspend stats debugfs node.
> > Since debugfs doesn't have stable ABI, expose suspend stats in
> > sysfs under /sys/power/suspend_stats.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> > Changes in v2:
> >   - Added separate show functions for last_failed_* stats, as per Greg
> >   - Updated ABI Documentation
>
> This is nice, I didn't even know some of these were in the debugfs
> entries, so this should be more helpful to people.
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for the review Greg :)
