Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C0E1E80AF
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgE2OnD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 10:43:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39267 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgE2OnC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 10:43:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id a7so2387659oic.6;
        Fri, 29 May 2020 07:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPY/wNV8YP0SBveUEbPZoXtMjIbvbN5AtrIKyFHWbWU=;
        b=heKZ6ETFA6s1FB3VUeAZt7dymIwNYSHW2tCpjaAi+egju7f4sPgaV+o3LiU3o+wyKS
         muyMaIW+fehz7+GcOvmrccOLiLPzlahUQYUcpxCTwIbF6K/UyZAiYi318L1wnNjesft2
         7a7FZxFIdVePJnY7mN4WxCETS4mLtXLmeEGPHSbROdjcqwnHfYZNiVck5Z20+HXMy7e8
         maFBwyR3C7m8j9/1E+0ly7vWjsi4mcQdkJvwsAHfBQyuRh20dfth7tFbtpZSQdLoBwbj
         yj84XAYTGCmJRJQdE4xTuMxTlhRMm0uPw0833NnM2071XX2Md5fcECpVrTKq6CwHechL
         /nkg==
X-Gm-Message-State: AOAM5329Wg603ddmsEVDDUBySwAlcRxVxIXcI2FnbKkPxyOTgASqLZuO
        ZwndWV7SRoYjuWjF3lY1qTleb4WCC7dV0TSpPI8=
X-Google-Smtp-Source: ABdhPJzmWtSxLVFgpDh/6SvlDYjaJ+B2sAtwHZzkioXeuMMP3MpiTfJThmmhXeOnVG7R7L1RUx2h5RvyoQlpO5vXuwA=
X-Received: by 2002:aca:eb56:: with SMTP id j83mr6323511oih.110.1590763375867;
 Fri, 29 May 2020 07:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200529023722epcas1p4062a6826d015c249adddd45bf28c0a29@epcas1p4.samsung.com>
 <eba2afce-78d0-50ba-8907-da2f61f0df9e@samsung.com>
In-Reply-To: <eba2afce-78d0-50ba-8907-da2f61f0df9e@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 May 2020 16:42:43 +0200
Message-ID: <CAJZ5v0jNPH0cCc-mCKMJnNDyC6K29Yw8UOZA2TFMqL8k+eCprg@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for v5.8
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 29, 2020 at 4:37 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v5.8-rc1. I add detailed description of
> this pull request on the following tag. Please pull devfreq with following updates.
> - tag name : devfreq-next-for-5.8
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:
>
>   Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.8
>
> for you to fetch changes up to 8fc0e48e0faefef5064f3cb803d3d12314e16ec4:
>
>   PM / devfreq: Use lockdep asserts instead of manual checks for locked mutex (2020-05-28 18:02:40 +0900)

Pulled, thanks!
