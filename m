Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE06D5B4D7A
	for <lists+linux-pm@lfdr.de>; Sun, 11 Sep 2022 12:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiIKKfZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Sep 2022 06:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiIKKfS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Sep 2022 06:35:18 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4AD1403C
        for <linux-pm@vger.kernel.org>; Sun, 11 Sep 2022 03:35:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b35so8910001edf.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Sep 2022 03:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=q3834ATZM4uW4E7+m37Jcaz9Vq5t/5NQIEJwA7O+k6o=;
        b=XvBH1YOQqIJRGxyVtPX6Xm+v6zpD+aOfSya3dqGzrRCBg4ZLiFocTjzGRPwT6b/2dM
         z8ZP92vNuxCenE9IK28/vTB9tNXB6tO1MpPfpsnYUznLWyH+hZDQdKMbbMSQw74bTstY
         v6XHskf4vginFjZJS18qQBtTBaME392J8ppkFxAuG3BsiSXvw/Gtyk6N0mppsEVq2uwH
         mJk5KqbLUih8OU5iODf4sssjKPCkkCEmK6xFsdbvo7hyMqh2XiHe/VX9xOHT+MI3Z6te
         Ty9LhMXUpFGY585zGqtcmpVRaEU9tgmwRaSTOaqdDTTjmm1F6elnwsQPGkRLLMJ4ODni
         T0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=q3834ATZM4uW4E7+m37Jcaz9Vq5t/5NQIEJwA7O+k6o=;
        b=NbzXOl3LcpiZALs4kPIafgM0kBZA2Atj+rgbBWnkgu6/UjRCDvoc9zpngQdZGbIqyW
         ixMU7S6YpcXY5ViKEjjhlqTX9w62x84hL2rptW1DgBlcio6KKMlq/J7x25X8isC/II8q
         lN9hcauv1YJdbQipQSEjmjNnsyt3h9HOzDTBYV/VXd/s5JKOqNsn3m46XuZnJ177mVqD
         RdELIrDdOcrbsQhNsEgm8Ye2sJL96HDcN0McEI33NKc4Pt9JfqVm/FC5YiP7vIlnxcau
         +6BCZExOIVm5oRAJsSDnMNclGgDhJsL07dIE52pgT4cmVjFR6Yxhtyvp0E8BpTEGcCcs
         MHzA==
X-Gm-Message-State: ACgBeo1au9lCHNCoDqQ6zj1RzxX9Wajm2tMH04y6IJdj14OlQ8fzCHZX
        J1Yc9x5JEn/xGk3ltbN2p3G4yWMD5dB/YvtR7FGazjkZCxI=
X-Google-Smtp-Source: AA6agR5kiwVnqu9KYElwqnZI8CfqSaCYPBvf6ZVBZejwDC8VjlQxPYwBEH9+3D7y1dM5coQjSs4N1o13nhW8mCtUmPo=
X-Received: by 2002:a05:6402:148e:b0:44e:aa8c:abc5 with SMTP id
 e14-20020a056402148e00b0044eaa8cabc5mr18271631edv.145.1662892516205; Sun, 11
 Sep 2022 03:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAGtpHi=f1+HCL+4kbfYGCC+qrLZasrpdT4peMF6t8-h-5h8KWA@mail.gmail.com>
 <87b82371d2a209dda3d63f57a3cc259783577616.camel@intel.com>
In-Reply-To: <87b82371d2a209dda3d63f57a3cc259783577616.camel@intel.com>
From:   Xhivat Hoxhiq <xhivo97@gmail.com>
Date:   Sun, 11 Sep 2022 12:35:00 +0200
Message-ID: <CAGtpHi=bj9W3J-OcUW8UNDoXXVY3rMazktEwoEcagZ6BZXDzTQ@mail.gmail.com>
Subject: Re: Is Tigerlake Missing From intel_idle?
To:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rui,

Thanks for the reply!

> intel_idle driver works with the cstate provided via _CST ACPI control
> method on any platform by default.

I see. Does this mean that C-States are entirely up to the vendor?

> I recalled that I did some measurement for TGL, but didn't find any
> power/performance improvement using the measured latency numbers.

In terms of laptops, how device dependent is this? Would a customized table
provide more consistent results over many different machines?

> May I know why you need a customized table?

To squeeze as much battery life as I can! I'll be honest, I am very new to this
so I assumed the missing table for TGL was an issue. I wasn't aware _CST ACPI
control is a thing. Would you say it's a wasted effort to have a customized
table for TGL? Every other platform seems to have them.

Any other pros/cons to having a customized cstate table?

Cheers,
Xhivo
