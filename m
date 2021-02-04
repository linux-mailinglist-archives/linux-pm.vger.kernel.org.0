Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B14730EE18
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 09:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhBDINJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 03:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbhBDINH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 03:13:07 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A1BC061573
        for <linux-pm@vger.kernel.org>; Thu,  4 Feb 2021 00:12:27 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id p15so1766540ilq.8
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2021 00:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qx0Orp2D7dKzIfXughhW29/GNQy6bVJN7VUDID0upIw=;
        b=mK1+xAQ57OW3J+YyKJ2vxHMqrrYC4PwdNXP08DPqwEsqhYxk8DVvE+M/ld+hmk3ndi
         yN1ZVKl7fF9k1gOMNnhBGMy7FWqX0OB+DjiOdWsRVOOpsunHmP7y2K65xWlqBnI3O6Ab
         tWOKYc0/gsl4MPQ/hCUThugfrR2w9gPYH23BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qx0Orp2D7dKzIfXughhW29/GNQy6bVJN7VUDID0upIw=;
        b=TToHEluHHyc8mt81yOdUISgV7dZv2RP5Hor9O4lhTVXG1WMj+kVTExDvBDtbce9l2z
         ytMsAuk611a2eOWYY/GHO8tYPk2zMlJi95OgI9tRmkLRFMfnnpYio+xJY33Cs3Ivix7e
         bihdhli7gs89jaV1Qi9+uPsdWzZU2n8BGZK96t7oQOAMgdJzrYI/fkStnuc6YcgiMpS8
         5p7szjXkcQPOuRl5CAIzMmWuqmiGO+9hL+HKmLVjrKL5yfdE7gq/suBkzhfYZASfeW/d
         vdSBttvszoE8raYW7mHfC93xjhGS9uiJU2BlI4LZFt45Z50Ax/ShTCfW41+O/xlIBf7B
         ZZMg==
X-Gm-Message-State: AOAM533pDqEn2oOLInpCYWW4OGqviA8oJr4svNCavtrh9ZmChz0cgwHw
        YQG4hfBLkEXdqMAtfbw2X9b+qFwyctjADlbxhyCKhw==
X-Google-Smtp-Source: ABdhPJw14nNO+4UCNhjLacUdfSxIIGkS9lR5qAS0Fs8h3ihFqjc65Fu3/rKMEoaPy8iosx/qJ8vE4rb0BxqPKExmHFc=
X-Received: by 2002:a92:cf08:: with SMTP id c8mr5929433ilo.106.1612426347082;
 Thu, 04 Feb 2021 00:12:27 -0800 (PST)
MIME-Version: 1.0
References: <20210203092400.1791884-1-hsinyi@chromium.org> <20210204054133.sb6vymf56u43bpwe@vireshk-i7>
In-Reply-To: <20210204054133.sb6vymf56u43bpwe@vireshk-i7>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 4 Feb 2021 16:12:01 +0800
Message-ID: <CAJMQK-jaYTG_jRB1mfs8c1=NWM2bEAWhUUhjVTfGJ5fCR6dCkQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add required-opps support to devfreq passive gov
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        lkml <linux-kernel@vger.kernel.org>,
        "MyungJoo Ham )" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 4, 2021 at 1:41 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-02-21, 17:23, Hsin-Yi Wang wrote:
> > The devfreq passive governor scales the frequency of a "child" device based
> > on the current frequency of a "parent" device (not parent/child in the
> > sense of device hierarchy). As of today, the passive governor requires one
> > of the following to work correctly:
> > 1. The parent and child device have the same number of frequencies
> > 2. The child device driver passes a mapping function to translate from
> >    parent frequency to child frequency.
> >
> > When (1) is not true, (2) is the only option right now. But often times,
> > all that is required is a simple mapping from parent's frequency to child's
> > frequency.
> >
> > Since OPPs already support pointing to other "required-opps", add support
> > for using that to map from parent device frequency to child device
> > frequency. That way, every child device driver doesn't have to implement a
> > separate mapping function anytime (1) isn't true.
>
> So you guys aren't interested in dev_pm_opp_set_opp() but just the
> translation of the required-OPPs ?
>
I think this series focuses on required-opps.

> I am fine with most of the stuff and I would like to take it via OPP
> tree, hope that would be fine ?
>
Sounds good to me, thanks.

> --
> viresh
