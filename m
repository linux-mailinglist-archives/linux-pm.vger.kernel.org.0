Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED46517A8FF
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2020 16:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCEPiI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 10:38:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgCEPiI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Mar 2020 10:38:08 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 219032073D;
        Thu,  5 Mar 2020 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583422687;
        bh=pFOZLiv0mIVHTNZOWfiOPa3A/ridTd7fa+fuzsFhe40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K44rhoDh34OpJhwV62dvPm3zfh+dqxbN7xwYVMhfZ6ZtnzxuPOWZhfpLyZuQqa7WQ
         NichaLzvxHrJDLkeBwtLMNXQRtD3/TVjiW+oqlRAriWQjYEti6aP1BLgLq7zNI2mxx
         7X85qsau8d6izShQ8AZil0GgKS4OYGGK784FwZKk=
Received: by mail-qt1-f176.google.com with SMTP id v22so4418939qtp.10;
        Thu, 05 Mar 2020 07:38:07 -0800 (PST)
X-Gm-Message-State: ANhLgQ2FibSRIUifkvXSwNNXPqj3BiEkiU0K5UsMqj3iNdJIoZQzflF+
        XnAF6ndI/ERNChGJMKgDxTS5X3oR3gg7Ko7M8w==
X-Google-Smtp-Source: ADFU+vsQsV656cyzVfl1AIRiy+kSqBsXm03AeKkd3MEkLkSKnRjRFBKeqrqHktEL6J028OlhKaosK6M+LVN7lOLFI+w=
X-Received: by 2002:ac8:7c9b:: with SMTP id y27mr7976141qtv.300.1583422686231;
 Thu, 05 Mar 2020 07:38:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582528977.git.amit.kucheria@linaro.org>
 <59d24f8ec98e29d119c5cbdb2abe6d4644cc51cf.1582528977.git.amit.kucheria@linaro.org>
 <20200224184003.GA3607@bogus> <CAHLCerP1_xESMbLuSBsVz1XkrA0j_okbX+SxbefVSo4ttvX_fg@mail.gmail.com>
In-Reply-To: <CAHLCerP1_xESMbLuSBsVz1XkrA0j_okbX+SxbefVSo4ttvX_fg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 5 Mar 2020 09:37:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK_8MbxwKb9D4U0Cfv1m61zHWku4hJwiLaeOO6wkS8WCQ@mail.gmail.com>
Message-ID: <CAL_JsqK_8MbxwKb9D4U0Cfv1m61zHWku4hJwiLaeOO6wkS8WCQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/3] dt-bindings: thermal: Add yaml bindings for
 thermal zones
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 5, 2020 at 6:50 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Tue, Feb 25, 2020 at 12:10 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, 24 Feb 2020 12:55:37 +0530, Amit Kucheria wrote:
> > > As part of moving the thermal bindings to YAML, split it up into 3
> > > bindings: thermal sensors, cooling devices and thermal zones.
> > >
> > > The thermal-zone binding is a software abstraction to capture the
> > > properties of each zone - how often they should be checked, the
> > > temperature thresholds (trips) at which mitigation actions need to be
> > > taken and the level of mitigation needed at those thresholds.
> > >
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  .../bindings/thermal/thermal-zones.yaml       | 302 ++++++++++++++++++
> > >  1 file changed, 302 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
>
> This one isn't due to my patch, I believe.

Right, that's the one known warning...

> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.example.dt.yaml: thermal-sensor@c263000: interrupt-names: ['uplow'] is too short
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.example.dt.yaml: thermal-sensor@c263000: interrupts: [[0, 506, 4]] is too short
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.example.dt.yaml: thermal-sensor@c265000: interrupt-names: ['uplow'] is too short
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.example.dt.yaml: thermal-sensor@c265000: interrupts: [[0, 507, 4]] is too short
>
> Fixed. Just for my information, did the check somehow figure out that
> this (incomplete) example needed the qcom-tsens.yaml binding (based on
> compatible string?) and then apply those rules to throw this error?

Yes. And setting DT_SCHEMA_FILES did change that to only check with
the specified schema file. However, that's now changed in linux-next
such that examples are always checked by all schemas and
DT_SCHEMA_FILES just limits which bindings to build and check.

Rob
