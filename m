Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC322235F6
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 09:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgGQHfs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 03:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgGQHfs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2020 03:35:48 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6D2C061755;
        Fri, 17 Jul 2020 00:35:47 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so6901176edz.12;
        Fri, 17 Jul 2020 00:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rYK2fP0PxrkgdndFMs+CB5yPwy58yRIUW72EzRYRpM=;
        b=fKHPgO/RexGvyEJpySfos24rsUVfL9YRkRssjkDn/6i8U0cQynR+belzOptx3qtNFB
         D5n5GlrYPWeVdIb5XmLE9QHcpOQA8SKVulf1gJev7MvDl8uEWsHyH0FnPKwmNKyPTnPx
         ClrOn5ns4p5F4G6Gh7RXe2jXGt4eAIRqhQ7NxkWMvK9pZRWvckdVsTyC4w6d44m+vOdw
         e/WGPHVLjPqxroRjHEB7Q+HpxltGOTYJ1ntNbW9oQ4a5Om/wtMhDQvAB+8T4Cp8WiG6Z
         UZzVwiN3cW0jH3dIYtWiQZQgypk064gLsU+VAgeu5E+3NdlX32Mj/U7JM8Y2wnUj/CiL
         ftDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rYK2fP0PxrkgdndFMs+CB5yPwy58yRIUW72EzRYRpM=;
        b=SQrm3LxnIS2XTF6evnPxeIfYNPCf7Q6vbba8aFt10QaxG4VgIOZD9jQwiGbH2eqMEF
         JHTuhD9ulm50uPkzeeVA7ByQN2IRSkfiQKu01+7j8iTUaKOQfE3SifP+0ZZNe5vYdlDm
         loBv5G/a4zgslikd6z5qo3hOlQSM+maub9dntlMU7LzNAdbYUry0fRHq2pHjpoM+S5yJ
         Gwuv1IoHv+Pnd7TBWU6OGHsqnbtxt7TohGNCYkUseEVNU4X6EawSetUGIV0o7NDusFU1
         EhyPbrRj6FFIALj+7xyRR3lixenDJ5hmLS3v8tCvShrvdlHy64HBDQla91GLWT7qyIy9
         vNTQ==
X-Gm-Message-State: AOAM5321doa+6ubpNcGT+DJ4DvB8fy14OPEN7cnBEo44TnBkvv/j38kI
        JRYdDjF1fPI+bLTzAU6QGrrjrygEdNOYhBt66Bw=
X-Google-Smtp-Source: ABdhPJzIc46u2fVJLDQvnexUFBUqZNTcUAMeHjWcSylf7rW5C7OuSBSemBsdJgcqytTBj1vTY/OEC8EkecyJRtfJtUU=
X-Received: by 2002:a50:a45d:: with SMTP id v29mr7988933edb.284.1594971346164;
 Fri, 17 Jul 2020 00:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594708863.git.frank@allwinnertech.com> <b8761e036b25f20873534e5f8d10b37b5d2ce72c.1594708864.git.frank@allwinnertech.com>
 <4771acd6-ecd3-b8e1-8605-75d78720b1d3@linaro.org>
In-Reply-To: <4771acd6-ecd3-b8e1-8605-75d78720b1d3@linaro.org>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 17 Jul 2020 15:35:35 +0800
Message-ID: <CAEExFWv9_1kec_b+t+nnvT3cziXzmVa8GzJT3pQAZiCf4KA0ig@mail.gmail.com>
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

On Fri, Jul 17, 2020 at 12:26 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 14/07/2020 09:13, Frank Lee wrote:
> > From: Yangtao Li <frank@allwinnertech.com>
> >
> > For sun50i_h6_ths_calibrate(), the data read from nvmem needs a round of
> > calculation. On the other hand, the newer SOC may store other data in
> > the space other than 12bit sensor data. Add mask operation to read data
> > to avoid conversion error.
> >
> > Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> > Reviewed-by: Yangtao Li <tiny.windzz@gmail.com>
>
> Can you clarify these SoB ?

Previously I used 'Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>',
maybe this should be removed directly?

>
> Frank Lee==Yangtao Li==frank@allwinnertech.com==tiny.windzz@gmail.com ?
>

Yeah.

Yangtao
