Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C4874411
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 05:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbfGYDl0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 23:41:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36201 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389752AbfGYDlZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 23:41:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id r6so50176267oti.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 20:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r50KNczYHsGrLVGWh6ZQQJCk+euz0u5D2BdOZkkJPZ4=;
        b=vGP9PNjGPjrvV6Fp17JQsypCrE9DTKh2pkXmKyjXy2EaMuUVYCtUKcbSDIaL/jYjrg
         H/LtngKQGANQ3RXBjJLSD3hszRFxmYmvEFNEtpA3NmXiNi4jODZx1M+Y5cU/mmStKJCV
         tKk9elHbHNXo1TjqthSQpB3LUGgKjwpPdvLPSnfIy4fYfV+qLK5u01nGbDYWyhBI1Um8
         adSFzkt0eSGlF+xQ54DII4RTfWqJ9TPW5uiXrzj16zGffl5++7xkOsWkomHu9qg1Bd7v
         IPgGruwLxFy0GhyHUlrahUq8ofVWiKsywetB+kCYiBkyEsdlfg0iXjhdPR3SeEy+SDt9
         vV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r50KNczYHsGrLVGWh6ZQQJCk+euz0u5D2BdOZkkJPZ4=;
        b=C5I5G/m6k+uaBzyFCofPUHXaecIICJtee5AGmyRkFlHqUyyC2dKqvcumSX4D9d1U/W
         +IqDku0Lj6IgWPek1duUHTseBF1tQwy3Qg8RJ3jjNQo/zwhtn0AeJXauN6rjWrBRxFK7
         w1+uEVq+PxeZEXtLQ4hFSCHrteQZhrgkg28QqsbV6JMahTBqCpEjGUJLZrS2txXC7sSC
         Kr01n5Si6ygn8Vcly2Sklt+aWl242jP3BYBMCLQ9EWePCA3NlBJZOaB+vSaHk8yGNmFM
         yCo5+n1q6Ndom5TCxrCCfDggh/eIffBINYGhQQFnA4Glofv+Khii4b4sTYAv7lmCbFPO
         TFFA==
X-Gm-Message-State: APjAAAX8U04dNbXkzWS74GmHInn20+I+2NtJQLQ4YYuj0VifFHnWRAHj
        UfGUyLqnpvlIQ7uDpRi/ew2SQZ2yvSyB0g/xUcS9MQ==
X-Google-Smtp-Source: APXvYqxygEL51qcrcdZob6n1E2VXGdJ4wPnev6GIEcEYTj6Lf1kgwRqEvEl2ham2F8ZP4KwLZgHvcNm3EjqcDDYtvq4=
X-Received: by 2002:a9d:6256:: with SMTP id i22mr42328108otk.139.1564026084726;
 Wed, 24 Jul 2019 20:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190724014222.110767-1-saravanak@google.com> <20190725023050.7ggjbwsthoxpkexv@vireshk-i7>
In-Reply-To: <20190725023050.7ggjbwsthoxpkexv@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 24 Jul 2019 20:40:47 -0700
Message-ID: <CAGETcx_ZHXkjZMBhO8YTW2fMyVqmsj8f9F8d6oJTn=NmRL1q=A@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Add required-opps support to devfreq passive gov
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 24, 2019 at 7:30 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 23-07-19, 18:42, Saravana Kannan wrote:
> > The devfreq passive governor scales the frequency of a "child" device based
> > on the current frequency of a "parent" device (not parent/child in the
> > sense of device hierarchy). As of today, the passive governor requires one
> > of the following to work correctly:
> > 1. The parent and child device have the same number of frequencies
> > 2. The child device driver passes a mapping function to translate from
> >    parent frequency to child frequency.
>
> > v3 -> v4:
> > - Fixed documentation comments
> > - Fixed order of functions in .h file
> > - Renamed the new xlate API
> > - Caused _set_required_opps() to fail if all required opps tables aren't
> >   linked.
>
> We are already in the middle of a discussion for your previous version
> and I haven't said yet that I am happy with what you suggested just 2
> days back. Why send another version so soon ?

I wanted you to see how I addressed your comments. It didn't look like
you were going to make more comments on the code.

> The next merge window is
> also very far in time from now.
>
> Please wait for a few days before sending newer versions, I will
> continue discussion on the previous version only for now.

Ok

-Saravana
