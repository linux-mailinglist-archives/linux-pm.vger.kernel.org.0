Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F63619213B
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 07:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgCYGhS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 02:37:18 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:39561 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgCYGhR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 02:37:17 -0400
Received: by mail-vk1-f196.google.com with SMTP id r129so378339vkr.6
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2020 23:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jSH6IwIzcHxO1dEAdKynoMSu3DuDL5sjpp02Uv2TK0=;
        b=jDm+gCbrABJRyKRkp6gI9YwPYuCeyHlXluAEXOh4yEMKoB+Tdx9T0+7noW1hpUNKzZ
         Kx/ZghXAAOW1qwMTlbHcf7Cig7EJ1MkmptqzUsnzhGfuytVbR6W5/tZy0c9w68S09hEb
         GoXhEGlfEndrcxqymIz5E4AK/TERQhQBmuoYIdgtF2ZaqtXRhVe8H86H7NSD7Jjg04nA
         STKax034sKWZzH1CevSpC8khjbcZcVVxIAJfS5r9pkeDk5lT61cLr+mNuU+KGm22qLTf
         YAMJokPA29sN9sDPIx7mSxT1/xoMMrPUqC9d3wBKZ8Siulb2zK8uHy0mqdOxj8FTcBaV
         P+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jSH6IwIzcHxO1dEAdKynoMSu3DuDL5sjpp02Uv2TK0=;
        b=SyCv6lO45JkJmJIJdFsGEgl2b54LDfd80ZZp3kpFh5sjCpHdYzbju8S+wiSQLfL3pa
         J2ucqdaKF0jWeQV5ifJIqP1HNnAte4WPrhVsfGVojC1fTABC91qx9YBi23uWlJXA+Xyq
         lzB3z7IG1FRb3UwibdHMfkQFuGS58xyfp7FwEaHMQ5h3p1q+M/oTQfD/BbBF+X6ULRJh
         XcaB04kvn1stiX28flvH+zC8fUYxFvrQrLNiwp8IQQ6cSlxQ8hWLgcWf4CU8ANDC0up+
         jPoEf3RVM18KDatjCGaBEvgrurzVV1jPcH831YHDplgztYOpCoY5FRL8fUvt1Bv9STrQ
         yT8w==
X-Gm-Message-State: ANhLgQ06DuIdpOUab7r24VSiPc4i6Qp+lk4rGU/zeOyO6eL4JVAsLAxZ
        yUGuyB6yIfsWhN7Qs+gXqYDvZt2A6H5ccaHBClbaIg==
X-Google-Smtp-Source: ADFU+vsYq8yJ59LPZqkr3eoifR7LDoo0CMncce0p+aNIhNSb+G7C4aTfiUP1oZ5YrcCWtKdvlXN7vBWm52sQhYicOGo=
X-Received: by 2002:a1f:ee05:: with SMTP id m5mr1056922vkh.9.1585118235539;
 Tue, 24 Mar 2020 23:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200309045411.21859-1-andy.tang@nxp.com> <18c58e1b-583c-2308-ee60-a8923c2027ee@linaro.org>
 <CAHLCerPBxe=Az=EexxYQkgvhRO40JT0qEhnAwqnGbeesiU-bnQ@mail.gmail.com>
In-Reply-To: <CAHLCerPBxe=Az=EexxYQkgvhRO40JT0qEhnAwqnGbeesiU-bnQ@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 25 Mar 2020 12:07:04 +0530
Message-ID: <CAHLCerN6ccJ7zbj9uYKGp-b05q1o7HsaUyW_oTZmEJX1EWXWQQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: make cooling-maps property optional
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Yuantian Tang <andy.tang@nxp.com>, Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 16, 2020 at 9:43 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Mon, Mar 16, 2020 at 8:22 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 09/03/2020 05:54, andy.tang@nxp.com wrote:
> > > From: Yuantian Tang <andy.tang@nxp.com>
> > >
> > > Cooling-maps doesn't have to be a required property because there may
> > > be no cooling device on system, or there are no enough cooling devices for
> > > each thermal zone in multiple thermal zone cases since cooling devices
> > > can't be shared.
> > > So make this property optional to remove such limitations.
> > >
> > > For thermal zones with no cooling-maps, there could be critic trips
> > > that can trigger CPU reset or shutdown. So they still can take actions.
> > >
> > > Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
>
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
>
> >
> > Amit, I'm about to pick this patch, it will collide with the yaml
> > conversion changes.
>
> Thanks for the headsup. I can fixup v3 when I respin.
>
> However, I've always interpreted this binding as follows:
> - cooling-maps should be mandatory for active and passive trip types
> otherwise there will be no cooling
> - cooling-maps make no sense for critical trip type since we're
> invoking system shutdown
> - cooling-maps are optional for hot trip types.
>
> Is this your understanding too?
>
> We should be able to enforce this in YAML.

Rui, Daniel,

What do you think about the above interpretation of the cooling-maps bindings?

Regards,
Amit
