Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9BF2C7934
	for <lists+linux-pm@lfdr.de>; Sun, 29 Nov 2020 13:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbgK2M6z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Nov 2020 07:58:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:49360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgK2M6y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Nov 2020 07:58:54 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9264721973
        for <linux-pm@vger.kernel.org>; Sun, 29 Nov 2020 12:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606654693;
        bh=ELHNBHt4EqshhUGNuAZ5/xfd1MTVG6aw9M7tUezJtcw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lUSUlXk7ni4Qqk6/GO9uT9RLb9C5iar9YSvOCMP0dsEiOe4Y/pgDquhrtfDKXxuYK
         /QrbLJEnAhyNpDv3JXiIf5sq0w5jq8QqwKvjvP4zwRa8hpG21qVSLkGxCle5Ebhw6j
         Ldud0ctji2XFmdAof/2QF5pjW0PIkwMKE75WiLd0=
Received: by mail-vs1-f42.google.com with SMTP id r5so4894619vsp.7
        for <linux-pm@vger.kernel.org>; Sun, 29 Nov 2020 04:58:13 -0800 (PST)
X-Gm-Message-State: AOAM533KIsfxscmh+3qCnMKOpFjIzG/+bpBhrM7X/WQYW2UlfdaNHc3C
        wHzfTDp0jUhcCRM6vYkR+qiipo0D3RMW6ZN386JKLA==
X-Google-Smtp-Source: ABdhPJzhn1fsp9EHXvRGhpUoP1eGJoSFTv0W/yDjP/8SVVYy5I7YyO+aQKszItKWdNicTfimgy14oUOjpOK0S4oleTM=
X-Received: by 2002:a67:ce1a:: with SMTP id s26mr12147763vsl.0.1606654692685;
 Sun, 29 Nov 2020 04:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20200814134123.14566-1-ansuelsmth@gmail.com> <20200814134123.14566-3-ansuelsmth@gmail.com>
 <CAHLCerMArOceCFQ1XFbsZCAnUdKVX3TVnAb502w+kxmO97bdJg@mail.gmail.com> <20201125122228.GB23592@ansuel-xps20.localdomain>
In-Reply-To: <20201125122228.GB23592@ansuel-xps20.localdomain>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Sun, 29 Nov 2020 18:28:01 +0530
X-Gmail-Original-Message-ID: <CAHLCerNTNpEGiGT6Veroeh1b8pOCiYYFhpnj5YqZcFZxAXGB-A@mail.gmail.com>
Message-ID: <CAHLCerNTNpEGiGT6Veroeh1b8pOCiYYFhpnj5YqZcFZxAXGB-A@mail.gmail.com>
Subject: Re: [RFC PATCH v6 2/8] drivers: thermal: tsens: Add VER_0 tsens version
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 26, 2020 at 2:16 AM Ansuel Smith <ansuelsmth@gmail.com> wrote:

> > >  };
> > > @@ -441,6 +442,10 @@ enum regfield_ids {
> > >         CRIT_THRESH_14,
> > >         CRIT_THRESH_15,
> > >
> > > +       /* VER_0 MIN MAX THRESH */
> > > +       MIN_THRESH_0,
> > > +       MAX_THRESH_0,
> > > +
> >
> > Consider reusing LOW_THRESH_0 and UP_THRESH_0 for these?
> >
>
> As we already have defined LOW_THRESH and UP how can we reuse that
> regfield to define MIN and MAX?
>

We are using MIN and MAX THRESH on the apq8064 to mean LOW and UP
THRESOLD, isn't it? IIUC, It was just named differently earlier.

When the driver is loaded on the apq8064, only that one field will be
use since v0 has a single threshold for all sensors. When the driver
is loaded on new IPs, all fields will be used.
