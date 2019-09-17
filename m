Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4335B4A37
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 11:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfIQJS6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 05:18:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33576 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfIQJS6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2019 05:18:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id x134so3214936qkb.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2019 02:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qk1/kEMCc7hdtCl5vveWWjPTyqEJHdmDX9cEtBBSrMo=;
        b=oNed/+kkOpBqzgWZvc8m2HoCUsR870bim/7U6M6ciIxMGGmQnC551uF2G+T6HjZMHn
         +tnBXLKaFDx//RH0OvknlYwyJjua5GUILPW76AwekbFW4gPNNHQWqlAH4s5xrNqkwCoB
         Wey4KwVBY8lZ0wjk/+/+9RyqneCmbw0VT5aIgRFL0GxyzK0CT8F88x3UA3dPNxET1fu/
         OSZ7kE5axDPfK8IoDCxOgCJNiFdLhCO3p2wFfyEzUsfMeqmW1FsD2p9l9ZGWs/5739Nw
         OeoXkpjTP/5rN2yaGgIRa81J7wB6isbp9Y8NRB3FNE8afvWkC7TCs+fnOzWO8YMOXpU5
         cn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qk1/kEMCc7hdtCl5vveWWjPTyqEJHdmDX9cEtBBSrMo=;
        b=XvlvHWZBUhu4UVxxhloj62S2R2SpuKcf4vNAjsTxDm/fX+cCCSJ24p/7xw/IBbxRVa
         SdEad/LvQOnDgMzd3OuWsnIYt44x5rpK82y11lLMrPY71AErY90iowmDm/zyljmhvvHK
         WnM8LAiFKkZrBo6lwTg1i6rmRga/07e4R31MP7MkFPuQIIdYXglkarOlQLO8e0xFBHjb
         kTrgKtQEJesitZYYJaa5fEISMPJz/NV1rAT2i565r3sQvq+18faNj3u/cZtqm2BKZdPh
         GLWKClVIfp/dcKLofFprRYNXMoatKkOYR6Gy7bAPqiY7oe8H6eGxbbvYAW+01USd2j+i
         wH8g==
X-Gm-Message-State: APjAAAULfz739SdqGZHnL177mJa2t1lz5/nGNH/4+5XV+DGZIBv2NFB+
        TOiO+JyZptITAMHEcpMkuJv0cuPZf3UFFpoS71aaIw==
X-Google-Smtp-Source: APXvYqwsTYtRd0bAtTCshwktiNew7SgVScj0W0wJ6hvvFn22AcBW3g9dZ5tlXLrT4/NrL+dTsEI2JmRuYRQSgRLij8o=
X-Received: by 2002:a37:6d2:: with SMTP id 201mr2596626qkg.106.1568711936825;
 Tue, 17 Sep 2019 02:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568240476.git.amit.kucheria@linaro.org>
 <97b6f861e6e6a2ac7b50efb7211f3c8e7fe872b0.1568240476.git.amit.kucheria@linaro.org>
 <6920d231-73cf-d83d-2cc7-f29e5f73192c@linaro.org>
In-Reply-To: <6920d231-73cf-d83d-2cc7-f29e5f73192c@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 17 Sep 2019 14:48:45 +0530
Message-ID: <CAP245DVOX_x0e-CAzzG2cdpBeMdk=J7Tbgx4hpLXEavQwjRRAg@mail.gmail.com>
Subject: Re: [PATCH 1/5] thermal: Initialize thermal subsystem earlier
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 17, 2019 at 1:30 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 12/09/2019 00:32, Amit Kucheria wrote:
> > From: Lina Iyer <ilina@codeaurora.org>
> >
> > Now that the thermal framework is built-in, in order to facilitate
> > thermal mitigation as early as possible in the boot cycle, move the
> > thermal framework initialization to core_initcall.
> >
> > However, netlink initialization happens only as part of subsys_initcall.
> > At this time in the boot process, the userspace is not available yet. So
> > initialize the netlink events later in fs_initcall.
>
> Why not kill directly the netlink part, no one is using it in the kernel?

That's a good point. I wasn't sure if anybody was using it, but I can
remove it completely since no driver seems to be using the
thermal_generate_netlink_event() api.

Regards,
Amit

$ git grep thermal_generate_netlink_event
Documentation/thermal/sysfs-api.rst:just need to call
thermal_generate_netlink_event() with two arguments viz
drivers/thermal/thermal_core.c:int
thermal_generate_netlink_event(struct thermal_zone_device *tz,
drivers/thermal/thermal_core.c:EXPORT_SYMBOL_GPL(thermal_generate_netlink_event);
include/linux/thermal.h:extern int
thermal_generate_netlink_event(struct thermal_zone_device *tz,
include/linux/thermal.h:static inline int
thermal_generate_netlink_event(struct thermal_zone_device *tz,
