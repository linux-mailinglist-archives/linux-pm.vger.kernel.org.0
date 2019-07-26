Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA47775C9B
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 03:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfGZBmV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 21:42:21 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39076 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfGZBmV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 21:42:21 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so47708627otq.6
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 18:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xZv/cnujU0oqDcp877dW2V6UxgQGvLsyyGAH+W7I5Q=;
        b=qKSd1EDbUaxk7Iml18aMNgKB1KOluUzbqTK8JoXGWgOObVnyonZySJSebDxiRunuzG
         ONV9GJmMyrbKV1mWeZVfLP8vBOai9WA5JH2ETG9fSWiZjygeP6B3wYHrbD9kaGqCJigF
         hHeBo47AFH/uGAExbpBWJfFRCd5rEVaa2/zoEpiWHzfs45skGgYWqW15xuFuU8qSDNN9
         MaWTiHUQznOw7F7Ert6XCD9UZrFjEMo/tG7a5Yc37JAgzSedkrtRNQB1z32tqhcibVh1
         c01SnJBiAu0lndpZProKdtv4Jh04By4fyCt74wCAJ8OiIghLfU0f61I7gDdy/XXG6a4Q
         2zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xZv/cnujU0oqDcp877dW2V6UxgQGvLsyyGAH+W7I5Q=;
        b=AYHT0gERVCsMJ7DqjFiHiEXtY6ZonnQDT1GselTrHe5HI44djmZ0PX+0rIl90Amm29
         2yDPb9MqeEtKPgS0lGgUic4SPWmCeFRSAahgNLaTQ/fGe6yajB2lmbDUJVopvABTrq8g
         IIhMqjP6yvY1B1CJokGRFZAtCU+WcYMAjMDxLd63KMowqpAocG8Ni45BtnMBq8B8J/cV
         79cn+8/6/OQrJdXlUF4pA27sxK0510sNtKMNiplr5CE48fXcFHN7L/rNocRmvwrQ8MPa
         XZ+4Ks1JJuiH+0sqk88rJ86RZIFCxd8h6Cmx0rc0ZM2zuqdQlkzT3N1TfaDACOoUP5PA
         44sg==
X-Gm-Message-State: APjAAAWPidOzAR0b2tbQr5DFDj9OVxmbkMK454+7643kxAK/b4mtYEZR
        uDbnHezTZ99Nr3tmX1CvsCdmA++tGdUFYJFyqMOI1Q==
X-Google-Smtp-Source: APXvYqzBT6V8BKTmErDkTC6/DiTsYm+9qsuAcDebvhWuQludZowll3Hh8C7QVnHF58QiogxuxCzCliIKfabB9C+OTbw=
X-Received: by 2002:a9d:6256:: with SMTP id i22mr46575918otk.139.1564105340461;
 Thu, 25 Jul 2019 18:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-3-saravanak@google.com>
 <20190723095316.t5ltprixxd5veuj7@vireshk-i7> <CAGETcx-r6fZH0xYea-YXyXDwe33pimtfNerLzzBn4UHT2qQVvA@mail.gmail.com>
 <20190725025849.y2xyxmqmgorrny6k@vireshk-i7> <CAGETcx8r3C_=Y0vSwqekCZPUeYkNQ6EOUDK4bUJksDHG6zPUjA@mail.gmail.com>
 <20190725053823.yqaxnk2a7geebmqw@vireshk-i7>
In-Reply-To: <20190725053823.yqaxnk2a7geebmqw@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 25 Jul 2019 18:41:44 -0700
Message-ID: <CAGETcx9thoqwAuGOc3t9oiw9fzB_-Gcsb4qBAESb0rfwk9T75Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] OPP: Add function to look up required OPP's for a
 given OPP
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

On Wed, Jul 24, 2019 at 10:38 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 24-07-19, 20:46, Saravana Kannan wrote:
> > On Wed, Jul 24, 2019 at 7:58 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > On 23-07-19, 17:23, Saravana Kannan wrote:
>
> > > > I almost said "not sure. Let me just compare pointers".
> > > > I think (not sure) it has to do with the same OPP table being used to
> > > > create multiple OPP table copies if the "shared OPP table" flag isn't
> > > > set?
> > > > Can you confirm if this makes sense? If so, I can add a comment patch
> > > > that adds comments to the existing code and then copies it into this
> > > > function in this patch.
> > >
> > > Right, that was the reason but we also need to fix ...
> >
> > I know I gave that explanation but I'm still a bit confused by the
> > existing logic. If the same DT OPP table is used to create multiple in
> > memory OPP tables, how do you device which in memory OPP table is the
> > right one to point to?
>
> This is a bit broken actually, we don't see any problems right now but
> may eventually have to fix it someday.
>
> We pick the first in-memory OPP table that was created using the DT
> OPP table. This is done because the DT doesn't provide any explicit
> linking to the required-opp device right now.
>
> Right now the required-opps is only used for power domains and so it
> is working fine. It may work fine for your case as well. But once we
> have a case we want to use required-opps in a single OPP table for
> both power-domains and master/slave thing you are proposing, we may
> see more problems.
>
> > > > > > +                     break;
> > > > > > +     }
> > > > > > +
> > > > > > +     if (unlikely(i == src_table->required_opp_count)) {
> > > > > > +             pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
> > > > > > +                    __func__, src_table, dst_table);
> > > > > > +             return NULL;
> > > > > > +     }
> > > > > > +
> > > > > > +     mutex_lock(&src_table->lock);
> > > > > > +
> > > > > > +     list_for_each_entry(opp, &src_table->opp_list, node) {
> > > > > > +             if (opp == src_opp) {
> > >
> > > ... this as well. We must be comparing node pointers here as well.
> >
> > Not really, if an in memory OPP entry is not part of an in memory OPP
> > table list, I don't think it should be considered part of the OPP
> > table just because the node pointer is the same. I think that's
> > explicitly wrong and the above code is correct as is.
>
> I understand what you are saying, but because we match the very first
> OPP table that was there in the list we need to match the DT node here
> as well.
>
> Or somehow we make sure to have the correct in-memory OPP table being
> pointed by the required-opp-table array. Then we don't need the node
> pointer anywhere here.

Ah, right. I'll fix this.

-Saravana
