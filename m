Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54E38F0927
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 23:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfKEWPr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 17:15:47 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43165 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbfKEWPr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 17:15:47 -0500
Received: by mail-oi1-f196.google.com with SMTP id l20so7010088oie.10;
        Tue, 05 Nov 2019 14:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJKfiPYLHEtW06JtOk10bMOl8mXc19glkHivp3gq6Js=;
        b=kSL6BxDwhuj7/Q8QiTwaW5IL0kN19BCN4TkIWgFTMSBhlaviubhttWgFhwcnqOlnXc
         LUz+lQpiZbnih6mdHgpRcd3aLEBd/wtYSSEArXKTVeq0fyFjlCgevprEAuhV5Ep2Pu0k
         QdxXwtYez/Rpvt7uzL+m16tPRkNxX2FEhj7Js3+4hRVtcFwqZdi8i3RtU0gl68PTPTqS
         exDQB0mbzDLqhRYtUhGMRBvuo/W9HGOcpnWp1kY08EVp5kTP5Nh65IdJ3pHlnS6I2CBl
         zFaITh+ee9tUg6xxfk0ePlXqLcsRN0uAoI2w3n3e+lNdgXealMe6r9sYG4L6oLDiFvod
         IL6w==
X-Gm-Message-State: APjAAAVelqiHBhV55NZLgc0HqE1Bbdy/Gij5Tjeg6UFfGNa2t40VwjW7
        opZ8tdo8MDYMPzEBQijNlW/WCXECHBV3EH/2/sE=
X-Google-Smtp-Source: APXvYqyRy7urT24plfjb8+0f9Emww7LbC+V2/WMx9a2x8v4H25zZwZYO/NqR5PVTxWKLGK++J9DGXvSdBH15vI81ipc=
X-Received: by 2002:aca:c753:: with SMTP id x80mr1050849oif.115.1572992146106;
 Tue, 05 Nov 2019 14:15:46 -0800 (PST)
MIME-Version: 1.0
References: <60416800.X4hXmAfbqi@kreacher> <1746940.X44tFrgt99@kreacher> <001701d59412$5804f620$080ee260$@net>
In-Reply-To: <001701d59412$5804f620$080ee260$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Nov 2019 23:15:35 +0100
Message-ID: <CAJZ5v0h_cBa_q_XjWk-9RuOnf2yS+u3eH7A-tT=tH+Gmjh8H1w@mail.gmail.com>
Subject: Re: [PATCH 4/4] cpuidle: teo: Fix "early hits" handling for disabled
 idle states
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 5, 2019 at 8:51 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2019.10.10 14:38 Rafael J. Wysocki wrote:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The TEO governor uses idle duration "bins" defined in accordance with
> > the CPU idle states table provided by the driver, so that each "bin"
> > covers the idle duration range between the target residency of the
> > idle state corresponding to it and the target residency of the closest
> > deeper idle state.  The governor collects statistics for each bin
> > regardless of whether or not the idle state corresponding to it is
> > currently enabled.
> >
> > In particular, the "early hits" metric measures the likelihood of a
> > situation in which the idle duration measured after wakeup falls into
> > to given bin, but the time till the next timer (sleep length) falls
> > into a bin corresponding to one of the deeper idle states.  It is
> > used when the "hits" and "misses" metrics indicate that the state
> > "matching" the sleep length should not be selected, so that the state
> > with the maximum "early hits" value is selected instead of it.
> >
> > If the idle state corresponding to the given bin is disabled, it
> > cannot be selected and if it turns out to be the one that should be
> > selected, a shallower idle state needs to be used instead of it.
> > Nevertheless, the metrics collected for the bin corresponding to it
> > are still valid and need to be taken into account as though that
> > state had not been disabled.
> >
> > As far as the "early hits" metric is concerned, teo_select() tries to
> > take disabled states into account, but the state index corresponding
> > to the maximum "early hits" value computed by it may be incorrect.
> > Namely, it always uses the index of the previous maximum "early hits"
> > state then, but there may be enabled idle states closer to the
> > disabled one in question.  In particular, if the current candidate
> > state (whose index is the idx value) is closer to the disabled one
> > and the "early hits" value of the disabled state is greater than the
> > current maximum, the index of the current candidate state (idx)
> > should replace the "maximum early hits state" index.
> >
> > Modify the code to handle that case correctly.
> >
> > Fixes: b26bf6ab716f ("cpuidle: New timer events oriented governor for tickless systems")
> > Reported-by: Doug Smythies <dsmythies@telus.net>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> I tested this pretty patch set thoroughly, but can not claim exhaustively.
> I did my best to mess it up via trying weird scenarios.
> Unrelated issues discovered during testing are being handled on
> other e-mail threads.
>
> Tested-by: Doug Smythies <dsmythies@telus.net>

Thanks for the testing and reviews, much appreciated!
