Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FF32426FA
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 10:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHLIyX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 04:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgHLIyX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2020 04:54:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37FEC061787
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 01:54:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so1276890wrl.4
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDDmL3/ds8QQCHr7yYQlwt5HIoUGQcvll/5Jm4Nj/NU=;
        b=eZV8SOfT++JcZDWbZGOFPKgBc8EnckFjLKn0Viw6/71x8cx9KnAkUpyX/V2nx8COkQ
         zQlB/OB1wRP6pMrRE9yJN+Smhb4ZY7oNjWxYK+841LJxbAsQ+hbwU+EnDxuG7nllptBh
         kTFBJaY0ELC5hFKngUr4N7e64e5LHsz+8RTyapmjBNLyVhbCYlRTj8K3gPyBcNQqu/56
         A0sA6RI/7uLTydnKJViPe7ScJUB7FlL5/noJyDh/QYsEOBf72693tlJmhwdtjEDYxUjI
         FQm/Z/ep1iEMfNkmGmphrWOr8IeSQc8GBFMv5yh3ThO3kbJ9lv0IV6Pc5iwVfr61pd5A
         qavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDDmL3/ds8QQCHr7yYQlwt5HIoUGQcvll/5Jm4Nj/NU=;
        b=uUj7D7RGPXBcpGto4uQKquOduGXdkFJ5TMZvDPoY0k3O3qFLAMnkKOp1OPhoyChRIH
         rdnnItBwVtmv/EsQNTPlzSJb5I47veYV5D23aArnjbLNCHgbvcwpmOsi3yVSSlkrnEuP
         DN9e4op1epOpvNb3ulTVTtU02BYdel8dE7crC7NqtWVRzjaJV5MXh1+FrL+kqw847UL2
         DKxBSwRfyxayc0ujIQaw4gvSqbupm/8X31sNFSlsqKuS95y3sILVkSONfNKTnJDOwqQm
         cQgNkMbc31zuUPblcq9N3ZC3z0NYRBLUWKgcsyZDICnG1LQSQB/h46SzAuyF20ceWvGi
         QKgw==
X-Gm-Message-State: AOAM533bHbVdmiODsPsQhobDn4SwPHU0NbaYHuvQMSblC0sBKLlEJAEb
        QXQu3T4esGy28+QZQOIPeH0nPCUUjg/hB+rwtSnzMg==
X-Google-Smtp-Source: ABdhPJxgHkQRilAAOvDxUOE0ttC56I2wbbW0+aBiE/cDA/sPn42xpkcsDJURVoApPB+Kh0XCHSsmcVBjkOhxDPs0fKk=
X-Received: by 2002:adf:bc45:: with SMTP id a5mr32002929wrh.215.1597222460695;
 Wed, 12 Aug 2020 01:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200730080146.25185-1-stephan@gerhold.net>
In-Reply-To: <20200730080146.25185-1-stephan@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Aug 2020 10:53:44 +0200
Message-ID: <CAPDyKFqy5-qtfKy=8iyR+LZNUTVi8namLGk_juq4a9YZH8DVqg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] opp: required_opps: Power on genpd, scale down in
 reverse order
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Cassel <nks@flawful.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 30 Jul 2020 at 10:02, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> I'm trying to get CPR (Core Power Reduction, AVS) working for MSM8916 on mainline.
> Shortly said there are two power domains that must be scaled with the CPU OPP table:
>
>   - (VDD)MX
>   - CPR
>
> My idea for this was to add both as "required-opps" to the CPR OPP table
> and let the OPP core take care of all the scaling.
>
> There are two remaining problems that need to be addressed for that to work:
>
>   1. The power domains should be scaled down in reverse order
>      (MX, CPR when scaling up, CPR, MX when scaling down).
>   2. Something has to enable the virtual genpd devices to make the rpmpd driver
>      actually respect the performance states we vote for.
>
> Both issues were briefly discussed before (see links in the patches),
> but I think we did not agree on an exact solution yet. After some consideration,
> I thought it would be best to address these directly in the OPP core.
>
> However, note that this patch is RFC because it is just supposed to initiate
> discussion if alternative solutions would be better. :)

Ramping up since the holidays, so I might overlook something - but I
think your suggestion solution makes perfect sense to me.

>
> Stephan Gerhold (3):
>   opp: Reduce code duplication in _set_required_opps()
>   opp: Set required OPPs in reverse order when scaling down
>   opp: Power on (virtual) power domains managed by the OPP core
>
>  drivers/opp/core.c | 115 ++++++++++++++++++++++++++++++++++++---------
>  drivers/opp/opp.h  |   1 +
>  2 files changed, 93 insertions(+), 23 deletions(-)
>
> --
> 2.27.0

So, for the series:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
