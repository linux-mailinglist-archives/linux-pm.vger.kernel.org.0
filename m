Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB11C4B4C0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 11:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfFSJPr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 05:15:47 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41335 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfFSJPr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 05:15:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id 43so1434229otf.8;
        Wed, 19 Jun 2019 02:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+djdJ0egkgp6daDlovvAzvZS5tBfJ50BkTgrjF5MG50=;
        b=tSz+xBA9URqjEy0hb+UpfCO4+63MTnqCTEOauC6AOnZe/7Kcskf3sQ9kwhRSJB2llL
         dUjX43sBXsKQ3lUnoGSnJ8I4w2DlA3aIx/lUpdwHOmecd3BIhjHb31tqxx1/7JfnzMQ6
         IgTz5GLzempig2XK8hdeu2gc0kj11W6ZkzilA3ZUki+E+loPoQS8TNyK8Oeve/8NpH22
         oYnubDpnX/qcIK2jv6NFcIfIDTTI92beSVnB4xm8O7AYOqLy0OqUl3WRycQCOHHpjtCT
         tCH9P014oOJq9juhckrv5j+ITCyZJakB6T1yAZsbBVnemq2stqkSOg7KtWFE2H7hLE64
         awXQ==
X-Gm-Message-State: APjAAAWFcIAEeMtpggPN+hM723ngAVp3V5thgMkw4UdjIwgTRQgcjafX
        7mq+cbbi+f4e+ncWVzsmdDnhaAx4SHphVhGGlJchHLub
X-Google-Smtp-Source: APXvYqyVD2KuSejZtlg/XEAm9PCGlvwBLICR9kvCnZPa63+Breo2sFYqy95rmxMZm0PQLT0u/ljT+ZnNJvEBN+q9MFU=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr44684736oto.118.1560935746471;
 Wed, 19 Jun 2019 02:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560163748.git.viresh.kumar@linaro.org> <3504053.Rmt1Mul0J4@kreacher>
 <20190618112522.4odrysf7wmxgjlb2@vireshk-i7> <3176289.QFhGQadiPc@kreacher> <20190619063947.nj2awibmalrdccn2@vireshk-i7>
In-Reply-To: <20190619063947.nj2awibmalrdccn2@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jun 2019 11:15:35 +0200
Message-ID: <CAJZ5v0gXbDvSSfjpog=ycdTjSo8WVDyDXfD_zsW1SGP4gmS_eA@mail.gmail.com>
Subject: Re: [PATCH V3 4/5] cpufreq: Register notifiers with the PM QoS framework
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, Matthias Kaehlcke <mka@chromium.org>,
        Juri Lelli <juri.lelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 19, 2019 at 8:39 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 19-06-19, 00:23, Rafael J. Wysocki wrote:
> > In patch [3/5] you could point notifiers for both min and max freq to the same
> > notifier head.   Both of your notifiers end up calling cpufreq_update_policy()
> > anyway.
>
> I tried it and the changes in qos.c file look fine. But I don't like at all how
> cpufreq.c looks now. We only register for min-freq notifier now and that takes
> care of max as well. What could have been better is if we could have registered
> a freq-notifier instead of min/max, which isn't possible as well because of how
> qos framework works.
>
> Honestly, the cpufreq changes look hacky to me :(
>
> What do you say.

OK, leave it as is.  That's not a big deal.

It is slightly awkward, but oh well.
