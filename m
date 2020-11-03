Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840BA2A474C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 15:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgKCOIj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 09:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgKCOIN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 09:08:13 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B88C0613D1;
        Tue,  3 Nov 2020 06:08:12 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id v19so14241198lji.5;
        Tue, 03 Nov 2020 06:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=0w+rja1f0+G0RfOXnBBK3uQA6RuMQSPbDSi88HYNgNM=;
        b=R+YTXLaJT5LRB3SDG2U3aax6E3yLKCcwuhgc0epoTouJXakmiduZUDKre0YfVNipLB
         Mwo2Jud2dYkQ/ZvFyfwGQOa6VTksioP5O29eQUPcXYMfyTLG+qSt324jyOPAf6hojUgh
         d9aT6C3bEvljUsUbYxF23i/Ti2xq+/SX0kgdra6S6LqjDmXzTp6pWEWrI21oEP6ycB/N
         uhcmT2bbDWO37G7PDyxVu3/4Cm8DoiYal6vtkHGLqM+dfZudapXDtZGkcApEENYCRTTY
         a50ZzOaTiyjnGvI73R8A0Nar0VXQWXec+3G5X/gxeP9SsU7Zl7Fy4GAR5ADMg3Kjex8f
         m2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=0w+rja1f0+G0RfOXnBBK3uQA6RuMQSPbDSi88HYNgNM=;
        b=csC10LQkqtU5JDn0p9rNsqcOC6buIuvHZ6jDJXGshVYKAWXU16ziznTz7zGN+5UiZl
         fooB5EcBDRFy8ZVe/ze6xewIoWliSneGiTwooyJySqy44/QnX4X5YEjW+fvDcDgkTKij
         3egKOzR/rro6TbJvf/C3YxntQk/PVt6V+/AkGVDhBOnM5+clo01QC2tFc43O6eHrpuWX
         yqKTt8lAqgxfBrz5toF0BTaSBkV4CjYZkPZi+TbzsTCPqtmWklLFWrVbfsysfcmvHqKa
         iS4eV1S69DESAVruMHLzGGsTWsdkn3wVHVmfCY5QTN12fzv9xWFVUO7Wk9c4LmQWQu9O
         Oljw==
X-Gm-Message-State: AOAM530dQL8fZm7lLjA3bkPBDHHk8hfPMfWbxt4rzpgcUK0ZzKj2tRgv
        8GuKfKbm7JY+ODcnFbl7GjIycKd4wGy/RKDaGEKpOMBSer0=
X-Google-Smtp-Source: ABdhPJwl8ry5bPgxL7i4vb9WG0Em25+04gn0ilBPCIMhAiAHYx2hDHAioJBclKwKX5YWNigaffZFyk2LI5y4hopgEH8=
X-Received: by 2002:a2e:7815:: with SMTP id t21mr8217735ljc.217.1604412491411;
 Tue, 03 Nov 2020 06:08:11 -0800 (PST)
MIME-Version: 1.0
References: <20201030125149.8227-1-s.nawrocki@samsung.com> <CGME20201030125303eucas1p14a9de4111ffafc1870527abdea0994c9@eucas1p1.samsung.com>
 <20201030125149.8227-4-s.nawrocki@samsung.com> <522dd3d8-7c76-92c6-ab1e-7e04797b3e9f@samsung.com>
 <20bc744b-bbb1-8803-3844-97d59f708f43@samsung.com>
In-Reply-To: <20bc744b-bbb1-8803-3844-97d59f708f43@samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Tue, 3 Nov 2020 23:07:34 +0900
Message-ID: <CAGTfZH1wsdoFki1nUJ73DFvgOMDhTTXfx-Bmt=kUHxfpKDJ3rQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] PM / devfreq: exynos-bus: Add registration of
 interconnect child device
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,

On Tue, Nov 3, 2020 at 9:32 PM Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> Hi Chanwoo,
>
> On 03.11.2020 11:45, Chanwoo Choi wrote:
> > On 10/30/20 9:51 PM, Sylwester Nawrocki wrote:
> >> This patch adds registration of a child platform device for the exynos
> >> interconnect driver. It is assumed that the interconnect provider will
> >> only be needed when #interconnect-cells property is present in the bus
> >> DT node, hence the child device will be created only when such a property
> >> is present.
> >>
> >> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>
> >>  drivers/devfreq/exynos-bus.c | 17 +++++++++++++++++
>
> > We don't need to  add 'select INTERCONNECT_EXYNOS' in Kconfig?
>
> I think by doing so we could run into some dependency issues.
>
> > Do you want to remain it as optional according to user?
> Yes, I would prefer to keep it selectable through defconfig.
> Currently it's only needed by one 32-bit ARM board.

OK.

-- 
Best Regards,
Chanwoo Choi
