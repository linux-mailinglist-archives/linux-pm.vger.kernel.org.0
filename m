Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0827845A3BF
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 14:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhKWNdE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 08:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbhKWNdA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 08:33:00 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3512C061756;
        Tue, 23 Nov 2021 05:29:52 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id x6so6163855iol.13;
        Tue, 23 Nov 2021 05:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1mzzQH4LR8E9en0oLHeEKt75OwAJ6GPgE1N3vKIF5Ws=;
        b=EIo2zpjMsvO81Q+EI8R8OfQZEXUoQwQClX2UVj0GR1MrfeNV9a2+iuM6IKMbfJesVu
         5W++R+mfnHKAUBjb2m6wPb6Sfqmep6qhLW5scVdDgAqj3KvBsvWJ9c5XPr6tFEgvtpQV
         e6nwS00xARewgIe5CpUn3IH9LWwEJ05wjGn8v7yaoRz9h8inoXZiIiq84LNAITBaJQpV
         7K3P5Jp7/mXCjZuHeuaujwziT+pycwl9fWiyw5X8zWIxxcE8QOQHQujCuZwBbnVWt64V
         7jXjBqcQATkgPpUKl/jNmU4MZRgd1ahChBNZ+dhDBnV44dn8DOUvmWaeGA68tZpWYOuP
         LgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mzzQH4LR8E9en0oLHeEKt75OwAJ6GPgE1N3vKIF5Ws=;
        b=r/tOiNxk5OdO67wrjgknl05LpEZs0nU3sF7A6MogsdEPq6eEgSn1dlvObQFLfkzZm/
         G+cgjc+cApi2nqmm16OUcepfYo1iQ4H9BwY4ikCQdoaneds+ON5yqJXc6u7F33H3OLNI
         huKj1NSlTrW2B6iPj5LGG04/khP5rg08ts2j7rHh7Uf1iGGUZOgA4yF5Rrc94L+lGTqW
         MyO2tYAGjVOhyfvOnihOCZH0EIFguCSQLySMfAqLhLEO4Kw3D7usmc4TZEaUZiMQ/puq
         lEknIJSZ++ygo17BKw4ooNYxG3RHdHUgcTXP+KDb+o0mI+JfVsJ9mwOUZh6+aTWunnKw
         uLqg==
X-Gm-Message-State: AOAM532bYFn0hJ+mmi7O7ddoMaF4QhIyUlmH08UBxXdi39ixOjkdtGwR
        PpcIKSWwtHRFIT5jJABHi6NF8eVLfWFBHpOZnO8=
X-Google-Smtp-Source: ABdhPJwMXgvkb/4JorRGYlbB9RBc9fTrr+yiBWVTdyS2Dguc9dZBlAvAFOrg/Q3ogahTOw2JtEq0LxkF6gaQvD7d6os=
X-Received: by 2002:a6b:ea0a:: with SMTP id m10mr5581825ioc.91.1637674192312;
 Tue, 23 Nov 2021 05:29:52 -0800 (PST)
MIME-Version: 1.0
References: <20211110122948.188683-1-alistair@alistair23.me>
 <20211110122948.188683-2-alistair@alistair23.me> <20211117223950.3a7eaf7a@aktux>
In-Reply-To: <20211117223950.3a7eaf7a@aktux>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 23 Nov 2021 23:29:26 +1000
Message-ID: <CAKmqyKP_gQ1qSADMPwmyf-V0TqGOYf2GitzpDXsmBUO6_iqK7Q@mail.gmail.com>
Subject: Re: [PATCH v15 1/8] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>, lgirdwood@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rui.zhang@intel.com, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-hwmon@vger.kernel.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 18, 2021 at 7:40 AM Andreas Kemnade <andreas@kemnade.info> wrote:
>
> On Wed, 10 Nov 2021 22:29:41 +1000
> Alistair Francis <alistair@alistair23.me> wrote:
>
> > Initial support for the Silergy SY7636A Power Management chip
> > and regulator.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  .../bindings/mfd/silergy,sy7636a.yaml         | 79 +++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> > new file mode 100644
> > index 000000000000..0566f9498e2f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> [...]
> > +  regulators:
> > +    type: object
> > +
> > +    properties:
> > +      compatible:
> > +        const: silergy,sy7636a-regulator
> > +
> > +      vcom:
> > +        type: object
> > +        $ref: /schemas/regulator/regulator.yaml#
> > +        properties:
> > +          regulator-name:
> > +            const: vcom
> > +
> hmm, this is what? If I understand it correctly, vcom means some
> voltage for compensation. On other comparable pmics (e.g. TPS65185
> which has also a sane public datasheet, MAX17135) I have seen some
> methods to measure a voltage while the display is doing something
> defined and then program this voltage non-volatile for compensation
> during manufacturing.
>
> If I understand the code correctly all the bunch of voltages are
> powered up if this one is enabled.
> So at least a description should be suitable.
>
> The other comparable PMICs have at least regulators named VCOM, DISPLAY
> (controls several regulators, started with delays configured via
> registers) and V3P3. MAX17135 source can be found in NXP kernels,
> TPS65185 in Kobo vendor kernels.
>
> So I would expect to see something similar here and a description or at
> least not such a misleading name as vcom if it is for some reason not
> feasible to separate the regulators.

This is a vcom in the sense of voltage for compensation. We just
currently don't support setting the vcom.

I had a look at the Kobo code and this is similar to
https://github.com/akemnade/linux/blob/kobo/epdc-pmic-5.15/drivers/regulator/sy7636-regulator.c#L614

So I think that vcom is still the appropriate name for this.

Alistair

>
> Regards,
> Andreas
