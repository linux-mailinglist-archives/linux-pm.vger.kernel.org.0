Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57121295006
	for <lists+linux-pm@lfdr.de>; Wed, 21 Oct 2020 17:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502504AbgJUPbc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 11:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502493AbgJUPbc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 11:31:32 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3A8C0613CE
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 08:31:32 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id s2so583178vks.13
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=anwDqQLPhLmhwHN7UeNR5u2jn0h/FQxOHHar/PmyA1Y=;
        b=i/Hl6YonMBqpSu/QT+v7Izpi0uKXq11VbuEUz2z5SdIiDL1GjhfPFM32bnFAaher3+
         kasmAmriAkz4kz9/3wGlLyaavVB0zh1X7qFreGOjAd5TyGewREK+2oa1o8+i0VrOn556
         KQd5MtAIF2WpymPlyZVBbvApdc1TXMZysgxxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=anwDqQLPhLmhwHN7UeNR5u2jn0h/FQxOHHar/PmyA1Y=;
        b=D8cI5JamGbUo0F/E73KRTtpsIWfODa/HYLCpcMtmbiJHC84bprIeGb6Xwvg8fkMhO7
         DJ4MfeVifK5jC/kQKT7ThAdrbGt59wm1Hot6uwBfgzd7ikmGub9gBk3UVCkO302lrEpe
         8Otar7cFzUxiyvXjG0E68bQ6jFejShnPyNRTyOH4f+0UERZyIMTDfcDgOHlvIQhuDXOH
         l5jf7bIuUFWXCIkKmyakww3gEnGjCx44Xh6BkNq6KJQ1wUxcUpAqWFgliVk8wBw0EIOp
         2wAWNqZ7iNYAHDejTNhqwIPPeUljRhdQynx+ny64ZE/nx3F+jvMoUeHuB1hSCIHJ1Lh4
         hwAg==
X-Gm-Message-State: AOAM533SQLBI950t3Vh8m2spGORCnq+vKD1/k9BA+oQRvp45sJZk/R9g
        oORoOijOLRWN0I0ORIZskAqbYVioO3bcyQ==
X-Google-Smtp-Source: ABdhPJyyX8qQnccVy9NBLDgFhIR5ydSIVuZrI7yQG7LdA2Go5gYCniXSd7oEmVxkV8fEGO1CAkpMaA==
X-Received: by 2002:a1f:23d0:: with SMTP id j199mr2360051vkj.11.1603294290846;
        Wed, 21 Oct 2020 08:31:30 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id 11sm330721vkz.42.2020.10.21.08.31.29
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 08:31:29 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id n189so595315vkb.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 08:31:29 -0700 (PDT)
X-Received: by 2002:a1f:a905:: with SMTP id s5mr2428353vke.9.1603294289336;
 Wed, 21 Oct 2020 08:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598594714.git.viresh.kumar@linaro.org> <7e28e6f93f463ffbe91b2a5c18b82e7123500f44.1598594714.git.viresh.kumar@linaro.org>
 <20201021073429.akspqkj2i5td7r7c@vireshk-i7>
In-Reply-To: <20201021073429.akspqkj2i5td7r7c@vireshk-i7>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 21 Oct 2020 08:31:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XFRMHxrqpGCubGZzOQ00DKScED-WHF+QqsC7N-pukfCw@mail.gmail.com>
Message-ID: <CAD=FV=XFRMHxrqpGCubGZzOQ00DKScED-WHF+QqsC7N-pukfCw@mail.gmail.com>
Subject: Re: [PATCH V2 8/8] qcom-geni-se: remove has_opp_table
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, Oct 21, 2020 at 12:34 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 28-08-20, 11:37, Viresh Kumar wrote:
> > has_opp_table isn't used anymore, remove it.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > ---
> > V2: No changes.
> > ---
> >  include/linux/qcom-geni-se.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
> > index 8f385fbe5a0e..02d1417c8ecf 100644
> > --- a/include/linux/qcom-geni-se.h
> > +++ b/include/linux/qcom-geni-se.h
> > @@ -48,7 +48,6 @@ struct geni_icc_path {
> >   * @clk_perf_tbl:    Table of clock frequency input to serial engine clock
> >   * @icc_paths:               Array of ICC paths for SE
> >   * @opp_table:               Pointer to the OPP table
> > - * @has_opp_table:   Specifies if the SE has an OPP table
> >   */
> >  struct geni_se {
> >       void __iomem *base;
> > @@ -59,7 +58,6 @@ struct geni_se {
> >       unsigned long *clk_perf_tbl;
> >       struct geni_icc_path icc_paths[3];
> >       struct opp_table *opp_table;
> > -     bool has_opp_table;
> >  };
> >
> >  /* Common SE registers */
>
> Rajendra,
>
> This patch depended on following patches which are part of Linus's master now:
>
> 7d568edff5cb spi: spi-geni-qcom: Unconditionally call dev_pm_opp_of_remove_table()
> c7ac46dac744 tty: serial: qcom_geni_serial: Unconditionally call dev_pm_opp_of_remove_table()
>
> Who is going to merge this one ? Should I ask Greg or you can take it ?

My guess would be that Bjorn would take it.

-Doug
