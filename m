Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7244017A5AC
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2020 13:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgCEMuy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 07:50:54 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42146 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgCEMuy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2020 07:50:54 -0500
Received: by mail-vk1-f195.google.com with SMTP id c126so1555020vkg.9
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2020 04:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+maOR+AepgKRd4QlRgZ+R5o7Ks/CO7J6rgykLOQhg3o=;
        b=Fy5hwIsSVhanXjlLscLM66eenX+BCtRtAYQCsCxjZKETTFVL603yeJm9AFRLD+sAAS
         2wCyCE5SzA4P6OHNlMe8oMswbyXdzcCCcwhvas/r/37ooGvLGxcOmm2m7x59fDE1LGlo
         fUDuYL5anWHgBbi+EgIpIN9dzRwP7IDMZRBne7yKfT51oHStdbSTwPcNjC+cxCMqCnJd
         wFbVHtcPnf3cR45aDau0mW4usFyVX06o29igp6GHGzgyWrkBrrNRt5s3KTIexsRyLZy8
         f1GgC2pag/n7Sno/FT+PEJx3l/sXaGnM1cdS4fSX0XqZOqiQDbYcttOuEvpS2XCqeVVD
         MZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+maOR+AepgKRd4QlRgZ+R5o7Ks/CO7J6rgykLOQhg3o=;
        b=Rl3iQEwnM+WG7aeQc5iDZnVbY33BGYaS+5kikqR66KmnPnh5FLRgoFXoH6NTUOerNn
         uR+SHqTqNsN/DQ+uWWWCxkWkLJDqgQUbLpKPxbrUf1dsiMV8yhHDp0R793b9FUPq4k6a
         OCKkk+AFLbwwPMG0eNzMu7P/yGt+l+IIqi6T231NHE+i5BM+druvjETZvaHHbCD1MQaN
         J7Kpz3sDt/SK8aIde4TxvhaKrNuKdWkLykvQPkmLbRPD/gTAHe+qUsBOyfOxbATXqXCn
         SSI0t1ao7/ZzEm7s3qKSAbZkrzc2zsMnP70gdBNkniku7nN5tMVyat0q7qC3P7gvqwhd
         NGcQ==
X-Gm-Message-State: ANhLgQ0IPSIqY54+tPF+rkvUY35FLoZ3c9PynfwfqNaHrR3POjhgIKWh
        bPuxMyMliwB0+wA+00jUpBxZwBJE0WLwUB2Fqy8tKQ==
X-Google-Smtp-Source: ADFU+vsfx2UzBfGovuaSXLUze7lcuI9cYphDPyIxas1YBiaNucPu3Q6rG2VUsSQJWjDBQnBGc8WRyzuMSoSg7SJIEcM=
X-Received: by 2002:ac5:c94f:: with SMTP id s15mr3982555vkm.79.1583412651049;
 Thu, 05 Mar 2020 04:50:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582528977.git.amit.kucheria@linaro.org>
 <59d24f8ec98e29d119c5cbdb2abe6d4644cc51cf.1582528977.git.amit.kucheria@linaro.org>
 <20200224184003.GA3607@bogus>
In-Reply-To: <20200224184003.GA3607@bogus>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 5 Mar 2020 18:20:40 +0530
Message-ID: <CAHLCerP1_xESMbLuSBsVz1XkrA0j_okbX+SxbefVSo4ttvX_fg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/3] dt-bindings: thermal: Add yaml bindings for
 thermal zones
To:     Rob Herring <robh@kernel.org>
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

On Tue, Feb 25, 2020 at 12:10 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 24 Feb 2020 12:55:37 +0530, Amit Kucheria wrote:
> > As part of moving the thermal bindings to YAML, split it up into 3
> > bindings: thermal sensors, cooling devices and thermal zones.
> >
> > The thermal-zone binding is a software abstraction to capture the
> > properties of each zone - how often they should be checked, the
> > temperature thresholds (trips) at which mitigation actions need to be
> > taken and the level of mitigation needed at those thresholds.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  .../bindings/thermal/thermal-zones.yaml       | 302 ++++++++++++++++++
> >  1 file changed, 302 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node

This one isn't due to my patch, I believe.

> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.example.dt.yaml: thermal-sensor@c263000: interrupt-names: ['uplow'] is too short
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.example.dt.yaml: thermal-sensor@c263000: interrupts: [[0, 506, 4]] is too short
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.example.dt.yaml: thermal-sensor@c265000: interrupt-names: ['uplow'] is too short
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.example.dt.yaml: thermal-sensor@c265000: interrupts: [[0, 507, 4]] is too short

Fixed. Just for my information, did the check somehow figure out that
this (incomplete) example needed the qcom-tsens.yaml binding (based on
compatible string?) and then apply those rules to throw this error?

Regards,
Amit
