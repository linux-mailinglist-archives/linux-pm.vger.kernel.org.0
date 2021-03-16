Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F5733DB7D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 18:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhCPRxN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 13:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239269AbhCPRxA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Mar 2021 13:53:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EF196512F;
        Tue, 16 Mar 2021 17:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615917179;
        bh=W8rr8sTbWk/xigthIkTyoScmrkEHXz8tnd8LeK4Aq5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L7Qe6r7cy4oo3a7QC4RU5ShnI1IfUIXGMymWJJL18hoP+qr4a8ZlmErgMfOoQWY2q
         I+YaFe3FcrFsNCFjwfQA/NUkr5Vyl1hjheDf0cH1T2Fy9kleyC9GyZYS/nxm8JT8MX
         Dbbhr5IoBUtl+Tfft2wdeXYupzQRO6HVWl8qefQFnqIcrOqRmMhpoS2oHxwfPHATek
         0US5gr2za1lShVj87zBMfiYTUZv5ZGxPrspuMOfmjVGaTWndwj+YsoEHzjQOoosw41
         glO5ohMoFTmZgAM4+mYn79CnD7j0IJ0tfFSfUx9sXQKBEawxfJaVtDkHz9jGNYUIB8
         oewgcyTXbsouw==
Received: by mail-qt1-f181.google.com with SMTP id l13so12304799qtu.9;
        Tue, 16 Mar 2021 10:52:59 -0700 (PDT)
X-Gm-Message-State: AOAM533VVjS1w60iIaXJTU5UsKxHo5+jbuRBGIGT5g5+ieE1mLA6CUas
        QeIdhgq0SbQYY5h3ufpfo9MVArnB9qQksonKsQ==
X-Google-Smtp-Source: ABdhPJxG0ZFRjKxTysjTNHhJwM08UgCXG6fkHthhoVafsNybBo0emZ8KLn06OpgaliodW8DNOmRhuSOZzuNZ9pzhXaU=
X-Received: by 2002:ac8:4ccc:: with SMTP id l12mr58779qtv.137.1615917178617;
 Tue, 16 Mar 2021 10:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
 <20210312154357.1561730-17-sebastian.reichel@collabora.com>
 <CAL_JsqLn9Mo_hTuCEPapNz3cFHbC8NKHH0npYrnV+dC85pBAsQ@mail.gmail.com> <20210316162045.cvvb226rpzxbovdl@earth.universe>
In-Reply-To: <20210316162045.cvvb226rpzxbovdl@earth.universe>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 16 Mar 2021 11:52:47 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+rynEXFCJDL-Xrar1hSam65qP6ZAiOQUKRtDbu26BYSw@mail.gmail.com>
Message-ID: <CAL_Jsq+rynEXFCJDL-Xrar1hSam65qP6ZAiOQUKRtDbu26BYSw@mail.gmail.com>
Subject: Re: [PATCH 16/38] dt-bindings: power: supply: tps65217: Convert to DT
 schema format
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 16, 2021 at 10:20 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi Rob,
>
> On Mon, Mar 15, 2021 at 12:33:23PM -0600, Rob Herring wrote:
> > On Fri, Mar 12, 2021 at 8:44 AM Sebastian Reichel
> > <sebastian.reichel@collabora.com> wrote:
> > > +  interrupts:
> > > +    minItems: 2
> > > +    maxItems: 2
> >
> > We've lost info that was in the original binding. You could do
> > something like this:
> >
> > items:
> >   - description: USB charger
> >     const: 0
> >   - description: AC charger
> >     const: 1
> >
> > (Usually the interrupt values would be out of scope of the binding,
> > but I guess here it makes some sense.)
>
> I initially did this, but it did not work. I see the following for
> dt_binding_check (dtbs_check triggers the same):
>
> Documentation/devicetree/bindings/power/supply/tps65217-charger.example.dt.yaml: charger: interrupts:0: [0] is too short
>         From schema: Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
> Documentation/devicetree/bindings/power/supply/tps65217-charger.example.dt.yaml: charger: interrupts: [[0], [1]] is too long
>         From schema: Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
> Documentation/devicetree/bindings/power/supply/tps65217-charger.example.dt.yaml: charger: interrupts: Additional items are not allowed ([1] was unexpected)
>         From schema: Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
>
> Seemed to be a limitation in the validation tool, so I just dropped
> the extra information. If we do not want to loose information I can
> add it to the description, or should the validation tool be fixed?
> I suppose it's kind of unusual, that the binding can provide the
> interrupt line numbers.

It is, so let's just leave it as-is.

Rob
