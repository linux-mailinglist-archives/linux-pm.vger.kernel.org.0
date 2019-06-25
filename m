Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE8B522D1
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 07:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfFYF3k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 01:29:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35425 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfFYF3j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 01:29:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id j19so16013473otq.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 22:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uC3lDlnZNnMr39J4BLCeS59JUfHFpDiBQC2yaNOX3EU=;
        b=cHyYtigR030CGwbia9XjivfYSSK5TfUzhNj9QaSTAZWOfZAx+VemnXq8uLkD9ZwHz3
         ehx19LZDM8LuciBMmOwwyD5r8S9rMIFrqIM20fO84hIiz3gPcRBECXVgzxvbEd3uoIYr
         8ylR74TM/W5BWbtjPc6ETen765e6jGapIQJ+D5iIWHBZf/MRPmtUQfCQZcFIe3RX/DCm
         rH4sdQsFDy5OqE08PJBFoO2d4UCGECSFamjoIQQ4ODzkjHsxH9/LeaKWO9i24sh6dv3h
         Gwwy0fC4Xckq3Q2GA+x4/rEA6p6At/BMx3N6ZkK0X2wYoHFyQNKXEJ+qnSTUVWR2sYtX
         NhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uC3lDlnZNnMr39J4BLCeS59JUfHFpDiBQC2yaNOX3EU=;
        b=h/Yrc53Zf144GDx2CdSwya6rCmJc0Vqj+KPxxMeuq9q9Z1ECx5cCuWtJUPC1eJ9Jnw
         pLM/rEIvl1pVvDZh/TIITtZ13obX8q5ACxvgbzssky2isgqX6oFaxzEN9SEQLl+bb2Y7
         gle7+VoFd2gCCHsTCCuUVnLOm2M4FEaItYl9f5d6FExGap0pK3ZAO7r0O9bswzVXQUL/
         CL6Zw11YPvMXb5ftbQq0LJCC+oVEbG7poabR2EM/OZDqTOGDaS/tgBBu5E9dJLGmNAA/
         HLk+/EvM/ZD7C3GlkaF8ZVwiorREn54zndUIyRPGmHM2EEc3sAqu7lSLG8QNP17Mg280
         RqIg==
X-Gm-Message-State: APjAAAUnj3Gd638UCB16+YtgYMVMRymyunThUv/+zcnI68OIpTxYng3O
        9eK0DBy/RCSOljV0UvL0DRjKB3+0j9FyHLwC21qu4A==
X-Google-Smtp-Source: APXvYqz419m7SEW5QL17XvTqouYkZ2rpD4Pkajzcte4sYOZIO8UFXa6HsFMvMUpRKqRbXcAwKCJuiMCqRpXYgJeJfdg=
X-Received: by 2002:a9d:1909:: with SMTP id j9mr1536282ota.139.1561440578763;
 Mon, 24 Jun 2019 22:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com> <20190624094349.rtjb7nuv6g7zmsf2@vireshk-i7>
 <CAGETcx_ggG8oDnAVaSfuHfip1ozjQpFiGs15cz8nLQnzjTiSTg@mail.gmail.com>
 <20190625041054.2ceuvnuuebc6hsr5@vireshk-i7> <CAGETcx8MuXkQyD5qZBC948-hOu=kWd4hPk2Qiu-zWOcHBCc=FA@mail.gmail.com>
 <20190625052227.3v74l6xtrkydzx6w@vireshk-i7>
In-Reply-To: <20190625052227.3v74l6xtrkydzx6w@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 24 Jun 2019 22:29:02 -0700
Message-ID: <CAGETcx_v05PfscMi2qiYwHRMLryyA_494+h+kmJ3mD+GOjjeLA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Add required-opps support to devfreq passive gov
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 24, 2019 at 10:22 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 24-06-19, 22:00, Saravana Kannan wrote:
> > All of the cases above are some real world scenarios I've come across.
> > CPU and L2/L3 on ARM systems are a good example of (2) but the passive
> > governor doesn't work with CPUs yet. But I plan to work on that later
> > as that's not related to this patch series.
>
> So in case of CPUs, the cache will be the parent device and CPU be the
> children ? And CPUs nodes will contain the required-opps property ?

No, the CPUs will be the "parent" and the cache will be the "child".
CPU is a special case when it comes to the actual software (not DT) as
we'll need the devfreq governor to look at all the CPUfreq policies to
decide the cache frequency (max of all their requirements).

I think "master" and "slave" would have been a better term as the
master device determines its frequency using whatever means and the
"slave" device just "follows" the master device.

-Saravana
