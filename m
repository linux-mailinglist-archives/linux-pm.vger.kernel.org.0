Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8284402ED6
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhIGTP3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 15:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345991AbhIGTP2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 15:15:28 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60863C061575
        for <linux-pm@vger.kernel.org>; Tue,  7 Sep 2021 12:14:22 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id q3so107013iot.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Sep 2021 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wptDSYLyDM12oE9PwIaapQVmJMO09viAmQFPtSVPYek=;
        b=g6tHrIqYCpyi3uj+Y8V0ZzItGWMeRuxbj7UZPUdqo9Ry/Sn6Ke28/Dg30vmx4JzCqo
         P666Khn7t7fmoEngyabMLFpP8CPK0f0OV9XBYX8VYiMK7gPoOcmKMoEVfQg4SzTjJ3l8
         Br8oh0YDph1cvQZS95VDMXVGHdGTntHbICFKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wptDSYLyDM12oE9PwIaapQVmJMO09viAmQFPtSVPYek=;
        b=Pb/gBsllSgtmK/GOuqHjATzECcjNX4VRKOyXNrrNxadDQT24EDppDa1jbgR3zDoRsv
         Z1KYkArep5IejDi5U6rp2UXIEzcNk8OIODwHUmrGirG8EhhZidoBjdRVDSjgEMrYBe4w
         4GirujxSewUOPtlk6zWeGzDtlWfWbwz5sLRM+2wlIf1IMJ5ESCIhlFi7AbTT1RVWmUmm
         V+wjvcpIqeVqfQPRz0roNpx1FQFhKWE2EzEGZp9RSoa46QIyFUeMBui0wZN4DiIupDNl
         nz4ZAfG61z7j9WUx/Pp807H6y+jJOqQ1lAGst3gK3Ey7LNg/jIfiD+vLJ7MT3Dl066/W
         5cGQ==
X-Gm-Message-State: AOAM530oRXBqJMUm7fs0WlPDPsKPGHkN+aKF4DvPiTYIQVtBjoVi7cGZ
        8U0694Wo2dRl9vnQi01d5XGhs3K9jGbWuA==
X-Google-Smtp-Source: ABdhPJz7AOB+kLeryxhjXyRF/+6S/SixxCt2J29Vjb3mGRDuwmnfxsIwiL5gZdnkbV42pnpjLAGqfw==
X-Received: by 2002:a02:1608:: with SMTP id a8mr16820869jaa.36.1631042061601;
        Tue, 07 Sep 2021 12:14:21 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id c5sm6725518ilk.48.2021.09.07.12.14.21
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 12:14:21 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id b4so136496ilr.11
        for <linux-pm@vger.kernel.org>; Tue, 07 Sep 2021 12:14:21 -0700 (PDT)
X-Received: by 2002:a92:6b0a:: with SMTP id g10mr3631557ilc.27.1631042060676;
 Tue, 07 Sep 2021 12:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org>
 <1627581885-32165-4-git-send-email-sibis@codeaurora.org> <YS5LDb4KDFx/dRnM@google.com>
 <YS5hDq+xblntYbh0@ripper> <fde7bac239f796b039b9be58b391fb77@codeaurora.org>
In-Reply-To: <fde7bac239f796b039b9be58b391fb77@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Sep 2021 12:14:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XHzwvudc4jABHVUC0OkKat-xdvo5yY2xRJ0VP5gds91w@mail.gmail.com>
Message-ID: <CAD=FV=XHzwvudc4jABHVUC0OkKat-xdvo5yY2xRJ0VP5gds91w@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc7280: Fixup the cpufreq node
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Sun, Sep 5, 2021 at 8:20 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> On 2021-08-31 22:34, Bjorn Andersson wrote:
> > On Tue 31 Aug 08:30 PDT 2021, Matthias Kaehlcke wrote:
> >
> >> On Thu, Jul 29, 2021 at 11:34:44PM +0530, Sibi Sankar wrote:
> >> > Fixup the register regions used by the cpufreq node on SC7280 SoC to
> >> > support per core L3 DCVS.
> >> >
> >> > Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
> >> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> >>
> >> This patch landed in the Bjorn's tree, however the corresponding
> >> driver
> >> change ("cpufreq: qcom: Re-arrange register offsets to support per
> >> core
> >> L3 DCVS" /
> >> https://patchwork.kernel.org/project/linux-arm-msm/patch/1627581885-32165-3-git-send-email-sibis@codeaurora.org/)
> >> did not land in any maintainer tree yet AFAIK. IIUC the DT change
> >> alone
> >> breaks cpufreq since the changed register regions require the changed
> >> offset in the cpufreq driver.
> >>
> >
> > Thanks for the note Matthias, it must have slipped by as I scraped the
> > inbox for things that looked ready.
> >
> > I'm actually not in favor of splitting these memory blocks in DT to
> > facilitate the Linux implementation of splitting that in multiple
> > drivers...
> >
> > But I've not been following up on that discussion.
> >
> > Regards,
> > Bjorn
> >
> >> Sibi, please confirm or clarify that my concern is unwarranted.
>
> Let's drop the patch asap as it breaks
> SC7280 cpufreq on lnext without the driver
> changes.

It's already landed so we need a revert:

https://lore.kernel.org/r/20210907121220.1.I08460f490473b70de0d768db45f030a4d5c17828@changeid/

-Doug
