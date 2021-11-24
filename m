Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6554645B64B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 09:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241237AbhKXIOs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 03:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbhKXIOs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 03:14:48 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60332C061574;
        Wed, 24 Nov 2021 00:11:39 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id m9so2194729iop.0;
        Wed, 24 Nov 2021 00:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2X5/LFLLoXcHwnJiEqimMyAM3gnORo1QfzmyY4+BjE4=;
        b=npeCSbzYQg6nrUVVZQQ8tgSeTCGq09gYMzHWIG0nLkIXzBo5vgZx6H3/iEUg/F86HW
         TXWRlrdMfyukSte1IudpCHD3Qs+RqObFVGnEo0PSRcJCdOVDMnfNEn5CrQQ2j9ldGs4m
         2ycv4mNR6Um+nxdxUFga3qN7G/84kL/MHYOxzf6i4Yhws4gqzOHqlcHg9ZI0jqSLV2kR
         n57OBWBuVQvVMDbIfM10hp5DLBApDFXngA4DKKZzPQVCnpTXRdfbI+VuZbgw73V5nRdU
         8Q5S9kQJrihbPG0W1hddydAFBWPjhv2vAOX+YMO0/FYkifW4Rf1yxUAcqowzIHFeoQO8
         HMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2X5/LFLLoXcHwnJiEqimMyAM3gnORo1QfzmyY4+BjE4=;
        b=isHaDxOKb9A9RXFXyBHgGXo48HYkzdVyHhb3RDTGM7o5xHk9I5nKesLS3a/RBCaIkZ
         LND015zHAc2GUlNSCYXRQE8ADWOysgWpoHubKs9M5RfenZsRgQFH1anilze1R+JZ2v0E
         Y08NZHxlDvq8N1WIecFU+dsUk+O3c2UOnCgBrVnreq7jx/VjM7V/kiSorLP7/4T4mTH+
         QhBJZslUq/KDIqGI1+qmsvubG856DQvwgfgojEtSLtqjMer461TQkmjoeS3/EyM8mdrU
         1sYki9zPA3iwaKkifVzxc3MWXGoo2wlfNirfeOGquWTV4I8oGnma5HsxMCGSAyF3baTe
         BH0Q==
X-Gm-Message-State: AOAM531izeO/YzssB12zEwKphyIOD/lmIPLm0vdeqECybLDHliUxTp/d
        XmJKzjG+hyHBU1cabJ0r3VHLOqlA8kjYHYO5YOU=
X-Google-Smtp-Source: ABdhPJzW+77DXfhD6ZDT96Rg0Qdwq2dVRlgLowhSu0150wCdHrY0rjX6LZy9nWoS6+vd6IY7LS+U9jMgylZH7nxoqfs=
X-Received: by 2002:a05:6638:32a2:: with SMTP id f34mr12973174jav.63.1637741498831;
 Wed, 24 Nov 2021 00:11:38 -0800 (PST)
MIME-Version: 1.0
References: <20211110122948.188683-1-alistair@alistair23.me>
 <20211110122948.188683-4-alistair@alistair23.me> <20211116000634.767dcdc0@aktux>
 <CAKmqyKPFOqWD7t6tC1Act97CVcY+yazrhwMLLr3j_wOyH50GTA@mail.gmail.com> <00d68181-ad3b-17d2-0150-00029d399f0f@roeck-us.net>
In-Reply-To: <00d68181-ad3b-17d2-0150-00029d399f0f@roeck-us.net>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 24 Nov 2021 18:11:00 +1000
Message-ID: <CAKmqyKNNGA4pOxayG5UZowC7cQj7cFyVJBbWLvFqEizEO7izyg@mail.gmail.com>
Subject: Re: [PATCH v15 3/8] mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Alistair Francis <alistair@alistair23.me>,
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
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 24, 2021 at 1:39 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 11/23/21 4:14 AM, Alistair Francis wrote:
> > On Tue, Nov 16, 2021 at 9:10 AM Andreas Kemnade <andreas@kemnade.info> =
wrote:
> >>
> >> Hi,
> >>
> >> this all creates a lot of question marks...
> >> One of my main question is whether sy7636a =3D sy7636 (at least the
> >> driver in the kobo vendor kernels does not have the "A" at the end,
> >> whic does not necessarily mean a difference).
> >>
> >> https://www.silergy.com/products/panel_pmic
> >> lists only a SY7636ARMC, so chances are good that the letters were jus=
t
> >> stripped away by the driver developers. Printing on chip package is
> >> cryptic so it is not that helpful. It is just "BWNBDA"
> >
> > I don't have a definite answer for you. But I think it's sy7636a
> >
> > The page you linked to above lists SY7636ARMC as well as SY7627RMC,
> > SY7570RMC. That makes me think that the RMC is a generic suffix and
> > this actual IC is the SY7636A.
> >
>
> Almost all chips have an ordering suffix, indicating things like
> temperature range or packaging. The datasheet says:
>
> Ordering Information
> SY7636 =E2=96=A1(=E2=96=A1=E2=96=A1)=E2=96=A1
>              | Temperature Code (C)
>           | Package Code (RM)
>         | Optional Spec Code (A)
>
> The datasheet otherwise refers to the chip as SY7636A.

To me this seems like SY7636A is the correct name then.

Alistair

>
> Guenter
