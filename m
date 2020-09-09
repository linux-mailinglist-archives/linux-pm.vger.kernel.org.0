Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792A5262732
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 08:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgIIGc5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 02:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgIIGc5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Sep 2020 02:32:57 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D8D920C09;
        Wed,  9 Sep 2020 06:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599633173;
        bh=LwV9fPRrvc7RAMea8ZWViyDx6uKT2SR64XEDrs4MBQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HNdyTjuTMDhJZVUK9QQL5lfiB42iwl7PatxtwrupRAR8LzFPRqy15pJJkyhYgF8QX
         Ijh2ni7KmiP+ylmjIswKWWisDZJQZMZkS7UvAcwp403XVbmqNQAc/E0xxESZr/mnp8
         maIr9NqXjGnOKLAzLOttTQZUnVX2rI9uqpDBy2UA=
Received: by mail-ed1-f46.google.com with SMTP id c10so1446395edk.6;
        Tue, 08 Sep 2020 23:32:53 -0700 (PDT)
X-Gm-Message-State: AOAM533WCL31eeRZug+47NJDF5aHHZTkn2kDCBc8u4tWT7w5dWUEw3ko
        ZuCwFRFve4u10ZThWoZPrDDfs9eLsLbhCjvU+a0=
X-Google-Smtp-Source: ABdhPJzdY8tum8knjizUaKhH4FGeihBxAHyxgZO//Y2HnUsG2wEh8KsbKUJkgrTwygpjv/Rv9AaUhywxGanYVV4CErI=
X-Received: by 2002:a05:6402:180a:: with SMTP id g10mr2580583edy.18.1599633171907;
 Tue, 08 Sep 2020 23:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200730143122.28519-1-dmurphy@ti.com> <20200730143122.28519-2-dmurphy@ti.com>
 <CAJKOXPeTWko5zD-AJiAud+QvXgSj9_jjvEx3aBCNqRSYL0iJmQ@mail.gmail.com> <b9db96d3-c94e-79b2-006b-eb7ae90de1b3@ti.com>
In-Reply-To: <b9db96d3-c94e-79b2-006b-eb7ae90de1b3@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 9 Sep 2020 08:32:39 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd86EWCLb8di5FDmFn-W0MPJQNgJUa8QhURbps4_byf1Q@mail.gmail.com>
Message-ID: <CAJKOXPd86EWCLb8di5FDmFn-W0MPJQNgJUa8QhURbps4_byf1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: bq27xxx: Fix spacing style and white space issues
To:     Dan Murphy <dmurphy@ti.com>
Cc:     sre@kernel.org, pali@kernel.org, linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 8 Sep 2020 at 22:44, Dan Murphy <dmurphy@ti.com> wrote:
>
> Krzysztof
>
> On 9/8/20 3:32 PM, Krzysztof Kozlowski wrote:
> > On Thu, 30 Jul 2020 at 16:32, Dan Murphy <dmurphy@ti.com> wrote:
> >> Fix spacing style issues with the chip data array.  As well as fix
> >> missing new line after variable declaration.
> >>
> >> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> >> ---
> >>   drivers/power/supply/bq27xxx_battery.c | 63 ++++++++++++++------------
> >>   1 file changed, 33 insertions(+), 30 deletions(-)
> > Hi all,
> >
> > Different topic. Do you know what is happening with Andrew's email? I
> > receive bounces with 550, so permanent error (no recipient under this
> > address).
>
> Andrews email is invalid.  He no longer works for TI.

Thanks for update. Does he plan to send an email update? If not, I can
just remove him from MAINTAINERS.

Best Regards,
Krzysztof
