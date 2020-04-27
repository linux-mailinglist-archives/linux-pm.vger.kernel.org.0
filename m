Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333641BAB95
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 19:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgD0RqD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 13:46:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgD0RqD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 13:46:03 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCAA621775;
        Mon, 27 Apr 2020 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588009562;
        bh=iF9YmvJqlTOPV6QEo1ch3u7PI0qsz6iUbUvNWthAYms=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x5dT7bls/3QJn+I9NbWzFlG6FHclIlFs0dMqD5tSRm8dQv0gBaJ4/72TXlkHbf0kb
         5JDD4w1fIgId0fi//oLcPdvIffq0NDHGy0/8f7NlxLYtrTIJIvLtveFzXAIaaFbQMa
         kbfuHB2JKD+TyBrwC58U+aB0tbjo5/LEOt5HXqfM=
Received: by mail-yb1-f172.google.com with SMTP id o139so9891403ybc.11;
        Mon, 27 Apr 2020 10:46:02 -0700 (PDT)
X-Gm-Message-State: AGi0PuauBr6AQeTzL2HsNKdxN76/MrNIVzrVim/JmvLEVxEn5U97W+QQ
        sjcxAxJ9PEokUyEsAS1VKL+cUmHgkF8t/yHSUQ==
X-Google-Smtp-Source: APiQypJCjp0sKkH8wsvV7TRTZ+Y5WfstmylSaK6ab9MlcQ1t5UeAxbE4A4p6/U7DdUD81SjmmMDCkQIJah8HRlmHtgQ=
X-Received: by 2002:a25:281:: with SMTP id 123mr37843786ybc.358.1588009561921;
 Mon, 27 Apr 2020 10:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200422201216.10593-1-ansuelsmth@gmail.com> <20200422201216.10593-2-ansuelsmth@gmail.com>
 <CAL_JsqLUbM7ed2q7so4Uibiz2URRg1juoGRExy9Ta3J-LWAFow@mail.gmail.com>
 <087301d61a86$68b6f950$3a24ebf0$@gmail.com> <20200427034951.xrk5ja3pg4anbg4s@vireshk-i7>
 <016c01d61c80$ba1358b0$2e3a0a10$@gmail.com>
In-Reply-To: <016c01d61c80$ba1358b0$2e3a0a10$@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 27 Apr 2020 12:45:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKu15CQu4pP6uyrUvYk3xZVWwUu=86CE5yDHPx7cSKdTw@mail.gmail.com>
Message-ID: <CAL_JsqKu15CQu4pP6uyrUvYk3xZVWwUu=86CE5yDHPx7cSKdTw@mail.gmail.com>
Subject: Re: R: [PATCH v2 2/2] dt-bindings: opp: Fix wrong binding in qcom-nvmem-cpufreq
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 27, 2020 at 5:43 AM <ansuelsmth@gmail.com> wrote:
>
> > On 25-04-20, 00:19, ansuelsmth@gmail.com wrote:
> > > > On Wed, Apr 22, 2020 at 3:12 PM Ansuel Smith
> > <ansuelsmth@gmail.com>
> > > > wrote:
> > > > >
> > > > > Update binding to new generic name "operating-points-v2-qcom-cpu"
> > > > >
> > > > > Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based
> > socs")
> > > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt |
> > 2
> > > > +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-
> > > > cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-
> > > > cpufreq.txt
> > > > > index 64f07417ecfb..537e1774f589 100644
> > > > > --- a/Documentation/devicetree/bindings/opp/qcom-nvmem-
> > cpufreq.txt
> > > > > +++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-
> > > > cpufreq.txt
> > > > > @@ -19,7 +19,7 @@ In 'cpu' nodes:
> > > > >
> > > > >  In 'operating-points-v2' table:
> > > > >  - compatible: Should be
> > > > > -       - 'operating-points-v2-kryo-cpu' for apq8096, msm8996,
> > msm8974,
> > > > > +       - 'operating-points-v2-qcom-cpu' for apq8096, msm8996,
> > > > msm8974,
> > > > >                                              apq8064, ipq8064,
> msm8960 and ipq8074.
> > > >
> > > > This is not how you fix the backwards compatibility issue pointed out
> > > > on the Fixes reference.
> > > >
> > > > Rob
> > >
> > > Sorry but can you give some directive? Should I use the old binding and
> > change
> > > the driver to use it instead of the new one (and drop it) ?
> >
> > It is not about the name of the binding, you can rename it to whatever
> > you want. The kernel needs to keep supporting all the previous
> > bindings, so we can keep on changing the kernel but keep the same
> > bootloader (with earlier bindings).
> >
> > --
> > viresh
>
> Ok but still I can't understand why this is not right.
> In 1/2 of this patchset I added the check for the old binding in the driver

I don't have patch 1 and this patch should stand on it's own.

> and
> here I updated the Documentation with the new one. This way the kernel
> should support all the previous bindings and I can use the new better name.

First, a compatible string is just an identifier. Maybe it wasn't the
best name, but who cares really. Just use it even if it's not just
kryo cpus. Otherwise, it's more complicated.

Are you changing every dts file? If not, then dts files now have an
undocumented compatible string which is not okay. You'd need to keep
the old compatible and mark it deprecated. If you are, then you are
breaking compatibility between new dts and older kernels unless adding
the new compatible string to the driver is backported to stable (which
should be okay).

Rob
