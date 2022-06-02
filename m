Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D1053B3F0
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jun 2022 08:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiFBGyi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jun 2022 02:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiFBGyg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2022 02:54:36 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40966BC86
        for <linux-pm@vger.kernel.org>; Wed,  1 Jun 2022 23:54:35 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id f13so3769064vsp.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2022 23:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hlIwxPeW006bY340NSBO3uX67HdfP5KYaInja9t5Jdw=;
        b=zSYaSzSXSOohCB29IiDwFnX6SeGkhoWOYd5Kk0jN+zUsx3AJIsX/BLVWOxQvIR5EGS
         pgptu0Jmn6hyjosrlBwz8EVK1Xg+y+3Wcd/PJIHfflRoyVfuMnb+2XNfvIedLoKti8WV
         YxbKCT8pqX2ArUq+xe57dU0wtdKi8MFlyZJd6/ZswOEpHxSYJ7ea/+C4mYvJNpt/JXTA
         LOMPvqkV+I7plEiRsqbAvDJLjdBWTkpJM0229rpLj3G1DBG3mAuRre229PgwPrHo1lmz
         u7ML0iQbo3h+Oo3sqLx0auJbyHs+Q8ZXZGWKpcahgscYgq9ma6OCEBbXO9Qac/OfpTpT
         gq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hlIwxPeW006bY340NSBO3uX67HdfP5KYaInja9t5Jdw=;
        b=ZuU5+RC1uii2UrMABYiMzSy3Clwbkhnw4Yo4q31/Bh6pBoLPXsG8OSQ1linvstF0XL
         Pf/hArlzky6uE4CDZE2zTxqvcuJqDEfrUX4ZoIQXfvc+KZS7Cxgy2JV4aW9+1HHMwqae
         9P++lSHdmZWGUT45V+dzxvtokAsb/zaY5eZDoel7uMbNRslC3EOWtF1g5OgjdKntCIqK
         aSgyUh9xvK0RPpxQs3dDH8Qdt+CiyfZ4XBJ6yEBNqQ11gKc74pIgg1Jcc8posWeyGIHb
         zD0s3r0gYqg5p7UHcrtHYvv0Y5e8ua73urQPQwTiWWo1j8Gt2qim8WJv1f/ujzKpeC9/
         hcgw==
X-Gm-Message-State: AOAM533/5lI+nUEqWmsJOc9mzclnASUSAFppk/BD0tVyoFGuiMgEEQxr
        eXRGl/SYxK6kCVlaTZh8NEGqzG86eOnuINBHoRvSsA==
X-Google-Smtp-Source: ABdhPJzZDP+92yKh+HvVhjL2bgkmdnKMCOmgxYpMm3UYhBbvzzJhD3zGolsRDEE8/VTEu/+83qeqDGThDdoVtGXAYt4=
X-Received: by 2002:a05:6102:3126:b0:349:f1a7:fe32 with SMTP id
 f6-20020a056102312600b00349f1a7fe32mr1536566vsh.55.1654152874335; Wed, 01 Jun
 2022 23:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <1553841972-19737-1-git-send-email-andrew-sh.cheng@mediatek.com> <1553841972-19737-3-git-send-email-andrew-sh.cheng@mediatek.com>
In-Reply-To: <1553841972-19737-3-git-send-email-andrew-sh.cheng@mediatek.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 2 Jun 2022 12:24:23 +0530
Message-ID: <CAKohpom625zOdWvvgsbnAe1EfzWABvdxHzjn2KVb0x2tftJnqg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] opp: add API which get max freq by voltage
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, fan.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 29 Mar 2019 at 12:16, Andrew-sh.Cheng
<andrew-sh.cheng@mediatek.com> wrote:
>
> This API will get voltage as input parameter.
> Search all opp items for the item which with max frequency,
> and the voltae is smaller than provided voltage.
>
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/opp/core.c     | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  8 ++++++++
>  2 files changed, 63 insertions(+)

This patch added dev_pm_opp_find_freq_ceil_by_volt() but I don't find anything
in the kernel which uses it? The patchset for CCI never got merged ?

I will remove the API now.

--
Viresh
