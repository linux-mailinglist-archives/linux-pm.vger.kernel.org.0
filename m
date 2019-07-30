Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2BC7B60E
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 01:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfG3XGU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 19:06:20 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38580 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfG3XGT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 19:06:19 -0400
Received: by mail-ot1-f66.google.com with SMTP id d17so68176936oth.5
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 16:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GWk710+kd17q1OMPpu/V4kqYNuYX+KuVsErBpC5nLIk=;
        b=WrAabiJo3Dd0TtRAdJPNb1JBiYkFvBRm3vSWFQpJ+gwuoytfTPfI3f8PTELhhVKlyD
         Rhp07QkokIAzB6efv9wY6sdxtKIkuJTwvqZULuS9AfQ1pK3jcRPLwP5gxssPI/Ugw1H3
         tBK4pFecWaDN42C5f8c1CnMEoWW0vrwdcxuHjvtXSAvbkbAKwVQhmLFLECySRswMmtCs
         iJftiD9zxs5YSMoAkdp/M78U764JOqBiJhvvhAplQjacULBgh1O+teQhg2blsWFp540R
         8ZQSCjurivZoKK0qnm1XrlEo+kzJzeohTGG8uFoxO5TFALHfsShQTJ6Ae71NzRVe9gon
         H+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWk710+kd17q1OMPpu/V4kqYNuYX+KuVsErBpC5nLIk=;
        b=IxpGnvJEcSVXX1feLyiy7pRAei0fqb+08xFhJjPeIDSuYDlvGv1/c4RZuxtfv2cp7f
         eq6iSmjpPA6VHLhg0z1MJKcxf6GlyDYfijWWz95GVqvC/F8BTZrHN8i9mp3evPiD42bN
         PMFqTGlf3TF7VAtSV0a9nGeeGoGlE4FJz4/J3b45vzuF5jzL0J8w8WxzVothrTPRQvEV
         y2ZN2gFexkOnDBiIPCmxZrmBlyJxQLnFhz7gumO7S6qt3lsWaseoCkBMS0LDTz2oWc+N
         JdxB3LD+E+juvWx3L/yypl9JdVajLeEQ49a5ROq8j8P4Y1OQd+d6SdbBjmF21KJUS7UG
         KQkQ==
X-Gm-Message-State: APjAAAX5LjLg5wO2nNmJXQ4dc7uBt2Ynujdt4gFOLePRjAAdOHvz/wvn
        LE2P04NeQUoFfEFBt4pIzi7AWAbStYNS9+GqafoaXg==
X-Google-Smtp-Source: APXvYqwRZBGclW0RsoKetYGEdOPnQk2VEPJBoWqPKFhs6YkunF2OBOxQev4HLUxITQUhOPKxNUn5nu5CyC5NSPsHFsA=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr33175342otr.231.1564527978919;
 Tue, 30 Jul 2019 16:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-4-saravanak@google.com>
 <CAJMQK-jQA6aeSMmrRKDeJz+mGDsu09=ywPv+kfuo26GhQJD4Ug@mail.gmail.com>
In-Reply-To: <CAJMQK-jQA6aeSMmrRKDeJz+mGDsu09=ywPv+kfuo26GhQJD4Ug@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 30 Jul 2019 16:05:43 -0700
Message-ID: <CAGETcx_qKTDd+pid-jdapi4XqVnN1k4EBP9Vt238rUzhDTHzig@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 30, 2019 at 4:03 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Wed, Jul 17, 2019 at 10:23 PM Saravana Kannan <saravanak@google.com> wrote:
>
> > -free_required_tables:
> > -       _opp_table_free_required_tables(opp_table);
> > -put_np:
> > -       of_node_put(np);
> > +       for (i = 0; i < src->required_opp_count; i++) {
> > +               if (src->required_opp_tables[i])
> > +                       continue;
> > +
> > +               req_np = of_parse_required_opp(src_opp->np, i);
> > +               if (!req_np)
> > +                       continue;
> > +
> > +               req_table = _find_table_of_opp_np(req_np);
> Not yet tested in v4, but in v3:
> In _find_table_of_opp_np(), there's a lockdep check:
> lockdep_assert_held(&opp_table_lock);
> which would lead to lockdep warnings.
>
> Call trace:
> _find_table_of_opp_np
> _of_lazy_link_required_tables
> dev_pm_opp_xlate_opp

Thanks for testing. I'll keep this in mind based on where the rest of
the discussion goes.

-Saravana
