Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1868451FA15
	for <lists+linux-pm@lfdr.de>; Mon,  9 May 2022 12:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiEIKmJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 May 2022 06:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiEIKmG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2022 06:42:06 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E7B2BE9C5
        for <linux-pm@vger.kernel.org>; Mon,  9 May 2022 03:37:44 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id w187so24102349ybe.2
        for <linux-pm@vger.kernel.org>; Mon, 09 May 2022 03:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80xOYZxsh90bQCAAYjLSEAMgMzcM/mrDKj7P0WRJ0SA=;
        b=iqf+MV4Tv6bRrcUMAaQvoC0FRR40mhaBGnA8aH+uVsLtcxGK+NhEJRQlvxsIqwMh1o
         djI19GlOzQmryuep2F2p+p2cv46cfHrBnAysfiCsCNcZB9CJDonA9Dd9wQh9XJLbDzFh
         FDg41QKF8MeA9vtOVbH8F020aHtd8mdChvJElxQ8o/HBHNcV71ZH7Qio5LpuygH8h4Ua
         3tjbA7ugnHDNiF77gWk926YuWrDH8oBpr+hhpXEjyS7l5cvBlVNknkuu7f+jL9DE5ZRW
         yyXU5kCcDsiTMCw5ZdZZ47BKUknnxaJpEq2jHBpb1aXDHHi8nF+TfIvSivdRx42INp5k
         RqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80xOYZxsh90bQCAAYjLSEAMgMzcM/mrDKj7P0WRJ0SA=;
        b=jnHBdBCqwaShAj9oCs4ydQ7BPWHTkUy+4Y87i5dxAs5uRqz4uUUwuSLjLt49KNwbuG
         HBs/ChmtfpUkC1uVVrds1+Jh7yEEXQWjix7pKhu+tz3CbeI5zjK42m5rVI8c0Hkhpoq/
         55GpZazjAVNZEuf0+O4jf271lr6ejOHULWKAFkd/VboE42TjSZJD0WCmxVpd11/tU4c2
         zqEZzdfgcivHeThfh6aa1XcgM1qMTfZh/fejq0sbEB5XgIolqtA2G37qsSDXpvnvXPU8
         CHhR0R5u4RI/Hq0noPDHKVrp1yGF0dGHbbqw4U+m3TakDAMp5If5szorPDuEoYoWqdHr
         RIbw==
X-Gm-Message-State: AOAM5312/1q5ZIRwSH6vaZmi0tFdnMrBomontVwwbDWG5CS/D8bgF2d7
        KBzw/tiL3yh3luZJFgkUr2oO3ND5rM9vuG2eNoNC9/Llqdw=
X-Google-Smtp-Source: ABdhPJzHx4CXXs+/mYe4RvqTPpfZg0KvBhG7DMhGRgwFxeux08EnD/i9lJE8+JXHOZ9qUCCmA6YLJURvmpivHMCQNe8=
X-Received: by 2002:a25:bcc3:0:b0:648:7360:8e75 with SMTP id
 l3-20020a25bcc3000000b0064873608e75mr12446586ybm.533.1652092405790; Mon, 09
 May 2022 03:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220415203638.361074-1-linus.walleij@linaro.org>
 <a1ad97a5-4048-1f8e-272b-6d1e99bd20cf@fi.rohmeurope.com> <CACRpkdYCWYgUAUJVVKy0jU4yF=d95e0Ead=coeMaA=uD3WV35Q@mail.gmail.com>
 <0442f454-9fba-8901-ca97-90538df439cb@fi.rohmeurope.com>
In-Reply-To: <0442f454-9fba-8901-ca97-90538df439cb@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 May 2022 12:33:14 +0200
Message-ID: <CACRpkdZfadK1vrCwOzUYOt5BjZP3SVhzd5-tyfA1s_QoekLkvw@mail.gmail.com>
Subject: Re: [PATCH 1/2] power: supply: ab8500: Respect charge_restart_voltage_uv
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
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

On Fri, May 6, 2022 at 7:38 AM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:

> I am perfectly happy with the patch
> then. Also, really happy for receiving the explanation. Thanks!:]

I record that as an Acked-by, OK?

Yours,
Linus Walleij
