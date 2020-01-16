Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C32F513D634
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 09:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgAPIxE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 03:53:04 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34544 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgAPIxE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 03:53:04 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so8727524qvf.1;
        Thu, 16 Jan 2020 00:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=801vaaIL76Zz7Eud3OqpJLc/Gt8+/1SS15pb9OLzY+A=;
        b=YDcIm089ZaVsZlmcaV0S2s0Xpl5IOCRdXT5rzLU4HYKIUIDEIoWzEHSiXXoBexd7QB
         xY+mixx4Y/9R7uBqqGwEKaW6lxDZGrMkVTqIhU6FevQPDy5Vbu2DP4CyXVb4UNAECC1E
         hDd7kM7nytCdOvDGuCJpDoE8NW4r7PaRd0ws2G1KZZpraAQckV0DgPQifuWeZ6/uhdfP
         2pF1Uw771J2o+6//8IctepMhogGj4zbo65kAm3d7pxRq/WIJNIJq3g/ad5totEJsZ6t5
         Tppo+SqQuQc3e8haZbB2DZUb2e6uKyaRp4uWiJqZDT2v0DEg3JZ/VUfGzRZOa38Dtz5s
         sYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=801vaaIL76Zz7Eud3OqpJLc/Gt8+/1SS15pb9OLzY+A=;
        b=qi5lcajG/+S0wRfFC1qDy9O3FoPlU1OyAl1ZWknxAewewvWKBwLD1csMkhnj0VV/QW
         GUcFwuWKqmyYIt70UkKx0OBRokqbK9nOatwHWvSDLq4pIL8JUAH4mqt3lOM18SyuVYfX
         0hR0NZD8+Zn+JBTbhmIk5+4XxTPuFDbECojLXjGDH8o3TIYiHRxCT/pW2NXFzw+rMS1Y
         S8QJqesy7yWplCHQLMsTWmtkUs7g4xriMKBXbZgNh6vbsGDKqdyzipddyGfyW0FSjr9I
         L0Z7oqx0QAj7tGO26WSe6NRwwhFIqzn1Bavz3YCEh0RdWfQiBQowyUKQxZm38R/TW5mK
         /X5w==
X-Gm-Message-State: APjAAAXSgIncqtta5TDM2MsQsGVUYAmlzGsWaeXMBCopv1Tkh4uzoHbR
        NSUVZ2qlGPAI34TeaVvhLSw88XRb7WGocIYeYVM=
X-Google-Smtp-Source: APXvYqyB1ED+E4BxrxPiN03JH5ZzF/hgDUCja6GKREeMJL/VnWAnIGR2fjYIWu7LWCYmmqcroz7FE/D0WOHqRzBea2M=
X-Received: by 2002:a05:6214:4f2:: with SMTP id cl18mr1586167qvb.89.1579164783499;
 Thu, 16 Jan 2020 00:53:03 -0800 (PST)
MIME-Version: 1.0
References: <8d5358a67746b2aff5f6995cabd11d0d7c9e579e.1575978484.git.baolin.wang7@gmail.com>
 <dd3303a956e7dd5c065ac2b92b1dea7ee5d1df17.1575978484.git.baolin.wang7@gmail.com>
 <CADBw62o3vW_hdFwcMdQFJqx2HpNhCEHOxADQO9LztzpqCVQBpg@mail.gmail.com>
 <547d91fa-66c5-e3bb-4028-2578f070695c@linaro.org> <CADBw62pcYZ_GR1OrS3VG-Y1T8CYOcL4pRzTwBt6of4ZmzhhNng@mail.gmail.com>
In-Reply-To: <CADBw62pcYZ_GR1OrS3VG-Y1T8CYOcL4pRzTwBt6of4ZmzhhNng@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 16 Jan 2020 16:52:52 +0800
Message-ID: <CADBw62r5qBVt8LB+E5XoToB7FJJDH+exwzVqJ6+Eti-6eKtB-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: sprd: Add Spreadtrum thermal driver support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        mark.rutland@arm.com, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>, freeman.liu@unisoc.com,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On Mon, Dec 23, 2019 at 3:48 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Hi Daniel,
>
> On Mon, Dec 23, 2019 at 3:42 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> >
> > Hi Baolin,
> >
> > On 23/12/2019 07:31, Baolin Wang wrote:
> > > Hi Rui and Daniel,
> > >
> > > On Tue, Dec 10, 2019 at 8:08 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > >>
> > >> From: Freeman Liu <freeman.liu@unisoc.com>
> > >>
> > >> This patch adds the support for Spreadtrum thermal sensor controller,
> > >> which can support maximum 8 sensors.
> > >>
> > >> Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> > >> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > >> ---
> > >> Changes from v1:
> > >>  - None.
> > >> ---
> > >
> > > Any comments for this patch? Thanks.
> >

Sorry for reminding you again, could you have a look about this patch
when you feel free? Thanks.
