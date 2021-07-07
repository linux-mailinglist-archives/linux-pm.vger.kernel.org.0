Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FCE3BE9FA
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 16:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhGGOpp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 7 Jul 2021 10:45:45 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:36830 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhGGOpo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 10:45:44 -0400
Received: by mail-vs1-f51.google.com with SMTP id g25so1722443vss.3;
        Wed, 07 Jul 2021 07:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Oy/lsyt2qqS6H9B3FtHDjHWr1dsk5aNcImtFuyQx14=;
        b=ZCt/MnHnRgS11d3V5g72GlVobmFUGh6vb/58xWGfeTlu4QdfRtfrN3l4Y9bRiDCt4S
         tao81sX2K+Q1mPZTW/kUOeZSuYzycP/i4WlPbGiRuMB18oqhLYUwgdMJMUDssgS5Wdgp
         RjMSoykcDFY/TZwN6+si8PDVo0/A5SGmwA6L/b7H0qwCtgxD/+sJuTYAHgHJwgGQzbS3
         UJRrJE6YA85zuozVg+lpoXguznDeIbgA0d602b1BzMjwDpz2QkEFjuQJT98Bx5gt/mh0
         gwxVSz+ETl3jyrh6me3nWncV23EoUsG5Ia9fuW2A+RxOxe+ytAYHtLN7sQZT8IZj3wQh
         yDWw==
X-Gm-Message-State: AOAM530cYhiwY12wEz5l+RYyuw5E5WYgmECA1ocEi8HAVBaOpUwXccBf
        RnH2aVD2BxbL8d8mcq8r0//OdJZDlX4Nh0qoRw4=
X-Google-Smtp-Source: ABdhPJwyKotE4o8dskqtM7CS2sxueDU+u1twV7lEuBws8t8BqCSaxvoP/ozWJTq2XheJWY8DhBe1hU/elb3hkav20Zg=
X-Received: by 2002:a67:3c2:: with SMTP id 185mr20906534vsd.42.1625668982845;
 Wed, 07 Jul 2021 07:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210707131306.4098443-1-niklas.soderlund+renesas@ragnatech.se> <20210707131306.4098443-2-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20210707131306.4098443-2-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Jul 2021 16:42:51 +0200
Message-ID: <CAMuHMdVyqj1PDHZzSY_jXsRG_0Jfthp+oW9gv1mkGmk=XEKYRg@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal: rcar_gen3_thermal: Create struct for OF
 match data
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 7, 2021 at 3:14 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> Prepare for storing more information in the OF match data by using a
> struct instead of a single integer value. There is no functional change.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
