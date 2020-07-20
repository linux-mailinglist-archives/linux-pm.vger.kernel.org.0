Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8E4225B9E
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jul 2020 11:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgGTJ1m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jul 2020 05:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgGTJ1m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 05:27:42 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BABFC061794;
        Mon, 20 Jul 2020 02:27:42 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ga4so17292191ejb.11;
        Mon, 20 Jul 2020 02:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i2oJzehZb8OInu2docosJSP0SU12+CFSPAkmMBNpOsA=;
        b=sjpOSPXSl4bzZSUip1JJKRH6wjLEc6y6wTdpLgdOUYoOVTw9J/QeSW/DChRIrpNJam
         VLkvCDhOHBUTpvpX+whQNiXXO3U/5pb/FzFY+yG48cXjw+aWI+UgoVbDnI/vtnAuyelD
         jPHtRKIAzPj/qYvKggd8FI93EQKQFvKSMa0UTIxo7A38JEPEDsfjQA4MV8pVzw1++aSL
         zmViUplQkVmBSLyZyd1/ck7Ouz/wqr5peAp18XDAavNSb3GqTBDCiz5qljmYwi76l5eX
         G8aPD/w//2aXt74/0neYP/6YGvg09NoFGZt0bGt5s8UibQaovAyQOjS6J56ORwrVkwOK
         4bKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2oJzehZb8OInu2docosJSP0SU12+CFSPAkmMBNpOsA=;
        b=bPMT9sh9AKGhxk6OxOynGPF87SHEK9GyxJc5AWxEdgXwvTdYKRaO2IEyirY5AMqwy/
         alzAMB/N0euvQhOV705rGhECPYZQ8qUtZZ7ZQpRaRffSlLTwhVngYEfl5Zc4yeMSfmBw
         LAoW6w2uDHFfXTEaE4NdbTmDmvSayMpfmwxvJwseaH32T6VeILFqkduKYhMuODkXxIeP
         Z7NRWY98sO9v5+DjyYv/2HL3SktJ6l3rMgm0XOZ82Bag3Cml7VS5IYTOXnW93Ic6p6r/
         SPqfy4/Bih8Ttz9xrzhZl2sEMPTTiFmqzf7NstN1VPJqe3O48HDK1DrPciBkYqCoH5le
         BCyw==
X-Gm-Message-State: AOAM5321Yi8o03xFlCguVmtwlg1Yo/askkiLpD+zRCJbECiLpuG5x1g9
        w0a6MEjWmxbW23VTqX9tapbfFsqaSYZUQ8ue3VU=
X-Google-Smtp-Source: ABdhPJyQHHakoLdELgPvkwJTPziVgkhT8/+bkeNWSKGuEAZEoPVZam3reeNo7zKlDysNI061zW+zgDRMoXPZab8/IOI=
X-Received: by 2002:a17:906:6847:: with SMTP id a7mr19449731ejs.306.1595237260974;
 Mon, 20 Jul 2020 02:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594708863.git.frank@allwinnertech.com> <b8761e036b25f20873534e5f8d10b37b5d2ce72c.1594708864.git.frank@allwinnertech.com>
 <4771acd6-ecd3-b8e1-8605-75d78720b1d3@linaro.org> <CAEExFWv9_1kec_b+t+nnvT3cziXzmVa8GzJT3pQAZiCf4KA0ig@mail.gmail.com>
 <836e1b23-1c75-57fe-6e45-f7141272071c@linaro.org>
In-Reply-To: <836e1b23-1c75-57fe-6e45-f7141272071c@linaro.org>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 20 Jul 2020 17:27:29 +0800
Message-ID: <CAEExFWsJBizFArd+9Mh6D=o6rvD7GLPZ-1pNFzTvBiE+uKwVhQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/16] thermal: sun8i: add TEMP_CALIB_MASK for
 calibration data in sun50i_h6_ths_calibrate
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Frank Lee <frank@allwinnertech.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6buE54OB55Sf?= <huangshuosheng@allwinnertech.com>,
        liyong@allwinnertech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

HI,
On Fri, Jul 17, 2020 at 3:56 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 17/07/2020 09:35, Frank Lee wrote:
> > On Fri, Jul 17, 2020 at 12:26 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 14/07/2020 09:13, Frank Lee wrote:
> >>> From: Yangtao Li <frank@allwinnertech.com>
> >>>
> >>> For sun50i_h6_ths_calibrate(), the data read from nvmem needs a round of
> >>> calculation. On the other hand, the newer SOC may store other data in
> >>> the space other than 12bit sensor data. Add mask operation to read data
> >>> to avoid conversion error.
> >>>
> >>> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> >>> Reviewed-by: Yangtao Li <tiny.windzz@gmail.com>
> >>
> >> Can you clarify these SoB ?
> >
> > Previously I used 'Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>',
> > maybe this should be removed directly?
> >
> >>
> >> Frank Lee==Yangtao Li==frank@allwinnertech.com==tiny.windzz@gmail.com ?
> >>
> >
> > Yeah.
>
> You are not supposed to add reviewed-by yourself. Please remove it.

Should I resend the entire series or just the thermal patch?
What about those that have been applied.

Thx,
Yangtao
