Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8C3273C06
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgIVHb6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 03:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbgIVHb6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 03:31:58 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EB7C0613D0
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 00:31:58 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id e2so9695897vsr.7
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 00:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/RqbrzOlXZ/TBQu2smR9qpwNWSy/awy50sEEzyqxs4=;
        b=NzXqgHqaCNw/6HqSrE4LnebQtEdFqVo71WEXgRS3C5d3KCEjdEQbjjHhVVKfISpARC
         o+D5hkLpTwwG/e/OGilw2haftR+SghGlX/J8r79F68eMN4uE6RL3hro1qASYDbKR4QRA
         g/imvtIEP5oN6z0d8L5H+KxE9J4XVypTFsFctV8Uc4N+V6viBoh3t54F+OsgHHg83BpY
         941L26mUdVPekmBBTIJscROx4+mes+qw8v6E17lCjxBXiSB9xgkULXMYfd9OoJyLlTPb
         Y3/Hy3ASehxTkEQWm/0xjFMT8ot08JgxmOmpDiPfMZN2nAf2Blm5XGPpg1OIBxc+mk/5
         SsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/RqbrzOlXZ/TBQu2smR9qpwNWSy/awy50sEEzyqxs4=;
        b=X4jNlvquGvzu7RfS8rnYRSMbgaIyc7Yf7SHVs8FRqPuHNNNZo8PQuEa95HktVbPqk1
         QNrLnLTodTS0Y8nWLBZ2U6SaJC3IxwOWeZtXdqWH0q1ecUloNykYBJu4sTg8uaG+IfTm
         k5bdk/MDAt90qu46BXFey0UfbCVBGwurrYajP40eoWl9g02MUf2zUmNjnUsxdzLQ1MPd
         RKzSO2nAm44A7udNDnmb1NDGiWC1FiffjyJtDr+oC50dxb2DL6X0FoKFGnHCVfCygQSQ
         pA51sb9lMUdeJRSRRRyvXmLXNfJkTjmzKN8kMZseLoJ63pSqFtLEu/5kEnk6EuHQUrWu
         WvHA==
X-Gm-Message-State: AOAM533lOC9szs8mrsYu/5TlKXR8gda0Cl6RmHksw48LhEmInA/EDZXE
        QRoQ6JgvLYYSNh+Rj2Du9oINbS8clCjXiwaoMlNi/w==
X-Google-Smtp-Source: ABdhPJxeNIhY7wlyypnbF1IB9nBP4fszWTaZhnPAC20Ij1ZN2+2wp8/96cKt6PitFKNSShqnOdzY9WTVyvTwP4KTaPc=
X-Received: by 2002:a67:d011:: with SMTP id r17mr2601456vsi.48.1600759917536;
 Tue, 22 Sep 2020 00:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200821204921.32536-1-sibis@codeaurora.org> <CAJZ5v0gdMroJY0d9n2+_P2uhBNw1xp5yn=jhxdejDLq0WmkPTA@mail.gmail.com>
 <160071818317.4188128.15658877054019388462@swboyd.mtv.corp.google.com> <14eb0558c8ff820280bb7354cfe33326@codeaurora.org>
In-Reply-To: <14eb0558c8ff820280bb7354cfe33326@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Sep 2020 09:31:21 +0200
Message-ID: <CAPDyKFrOPPkkbuPUDS_+mnVS=rsoCBm0VCD1Qqz_3rChPcp+4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM / Domains: Add GENPD_FLAG_NO_SUSPEND/RESUME flags
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 22 Sep 2020 at 06:51, Sibi Sankar <sibis@codeaurora.org> wrote:
>
> On 2020-09-22 01:26, Stephen Boyd wrote:
> > Quoting Rafael J. Wysocki (2020-09-21 09:18:17)
> >> On Fri, Aug 21, 2020 at 10:49 PM Sibi Sankar <sibis@codeaurora.org>
> >> wrote:
> >> >
> >> > Add GENPD_FLAG_NO_SUSPEND/RESUME flags to instruct genpd to keep the
> >> > status of the PM domain unaltered during suspend/resume respectively.
> >> > The flags are aimed at power domains coupled to co-processors which
> >> > enter low-power modes independent to that of the application processor.
> >> >
> >> > Specifically the flags are to be used by the power domains exposed
> >> > by the AOSS QMP driver linked to modem, adsp, cdsp remoteprocs. These
> >> > power domains are used to notify the Always on Subsystem (AOSS) that
> >> > a particular co-processor is up. AOSS uses this information to wait
> >> > for the co-processors to suspend before starting its sleep sequence.
> >> > The application processor powers off these power domains only if the
> >> > co-processor has crashed or powered off and remains unaltered during
> >> > system suspend/resume.
> >> >
> >> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> >>
> >> Applied with the Ulf's R-by along with the [2/2] as 5.10 material,
> >> thanks!
> >>
> >
> > There was a bunch of discussion on this patch series and I thought the
> > consensus was to not apply these patches and instead implement a custom
> > qcom specific API that does this instead.
>
> https://lore.kernel.org/lkml/20200913034603.GV3715@yoga/
>
> The power domains which were targeted
> to use the flags will be replaced by
> custom qcom specific API. So let's not
> pick up the patch series.

I am fine with either option. However, please keep me posted, as I am
a bit curious how this will look like in the qcom specific drivers.

Kind regards
Uffe
