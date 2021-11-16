Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BAB4532EB
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 14:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbhKPNhS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 08:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhKPNhS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 08:37:18 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A267EC061570
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 05:34:21 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id be32so42408209oib.11
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 05:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FnOz78zNA7EYhgqHxy36FQEVr+6+dBCCINVzSgmxJnY=;
        b=YNtmhZKckJShb26oTMJhj6X6CVTYb3DAR5XEij9ZhhpkGVuchFFbqp5dKuLCgnXmsU
         g1sERXP3sMFvjDTpiSflHOMPfGV9ru7BrbroN2qrDNdCH4Emp3hTJKRwhyEsNs7QDddG
         KZH7KtZCtUTiqWd6Dw7yd4/9WAvLNBp39L5quAeKiE36eYqj4WvtroGUzYl7IOX5MW0+
         taLfM1sBaupUFveNXfYegdC/mmpjfThdecU6mF59OGHuN+QAtMOGs/hXaEdU1p4CyOf3
         y0A03X7PH4p+jZ08zTNsxdDeZBFpkiofaplA23fUi0dJjNLFjPcnV+bvgBUjWRdu0QjH
         /ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FnOz78zNA7EYhgqHxy36FQEVr+6+dBCCINVzSgmxJnY=;
        b=Eo388eRS+HBk6ooFhH2ET+xkFJcQZhc5cC7oIybac2ZZyilVPqyv+KQm8L2INrVK+U
         eBAsPoWJlRiKEVK4kWZ0ZtYY3OZD75j4pT9VxC+HnjG7Mp89dwzwaHrixaOvbPvnOjhm
         uxxA//zKCEoAyERyl7Fj8rJPTpMjNa3TtXvkcY2nwHJVyjt3RSOA4+sqsVPiCUn/HoKu
         dCLt4vQs8GLQTTmlG7RNMxfc81dRCtz6ugf62rwNdom7wLKE/WxHKOntphymcDnxIgVp
         h7VT1YjZbNSF7PyPVFLUS4sqh8EvD4K+89c67UlPJ/ZbISw/qSINt27RXXQeJJ79LHGv
         96ew==
X-Gm-Message-State: AOAM530aawQ4K5DFWX+S2f9DVE9HWzuw7uSyY/coFT5lv704+5KYp1P8
        XqDteBUAtT0VJa2UBvtXqyG5LyOACbTKn4Q2JIUnfr/y1Xt4wQ==
X-Google-Smtp-Source: ABdhPJzIUrutb2moOVQBUaUw5gf7b9GfWvryarqCY7bYHtPL3ipkcw1bD1nX5AB7k19uDvTsgPgpJtEnJ2Xp5sr+lRY=
X-Received: by 2002:aca:120f:: with SMTP id 15mr6303780ois.132.1637069660927;
 Tue, 16 Nov 2021 05:34:20 -0800 (PST)
MIME-Version: 1.0
References: <20211116003844.2133683-1-linus.walleij@linaro.org> <4cf76c42-2357-c000-86d7-13b2abf5dcbb@linux.alibaba.com>
In-Reply-To: <4cf76c42-2357-c000-86d7-13b2abf5dcbb@linux.alibaba.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Nov 2021 14:34:08 +0100
Message-ID: <CACRpkdbVdU0S+cOZfDczxW+pNVDgc54cB75itFi-V9tjHkq-zA@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply: core: Use library interpolation
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 16, 2021 at 3:28 AM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:

> Thanks for your patch, and overall looks good to me. But I still think
> we should not do interpolation if the temperature is larger than the
> maximum value of the table, we can just return the maximum value of the
> table instead. Something like below untested code, how do you think?

You are right, but if I understand correctly
fixp_linear_interpolate() already does what you want,
perhaps a bit unintuitively. See include/linux/fixp-arith.h:

static inline int fixp_linear_interpolate(int x0, int y0, int x1, int y1, int x)
{
        if (y0 == y1 || x == x0)
                return y0;
        if (x1 == x0 || x == x1)
                return y1;

        return y0 + ((y1 - y0) * (x - x0) / (x1 - x0));
}

Yours,
Linus Walleij
