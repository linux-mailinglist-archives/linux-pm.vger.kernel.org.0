Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64042166847
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 21:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgBTU2U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 15:28:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbgBTU2T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Feb 2020 15:28:19 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A684824670;
        Thu, 20 Feb 2020 20:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582230498;
        bh=e7Roq7Daj5Bqc+VwP6/Sbq5H7ZycqvJy9VIdcG29uAU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gCipvhE+WLOUNhhRUhdv9GnOviF1bpzSd4O4+SyTc7qCQJ8MOKPQWuOyI0UssKMYl
         16z7KFtQbq0rYvQB02+iSTnpJVaoGtGRCnXD1Wr5CgNhSyQVafuQkezbVt6XE4mppi
         Eavwf9gf4xktUuOxqN7oBdjmhH2/RaZ0MafFUZLY=
Received: by mail-qv1-f41.google.com with SMTP id s7so1484qvn.8;
        Thu, 20 Feb 2020 12:28:18 -0800 (PST)
X-Gm-Message-State: APjAAAVmc3EcgHT4H9uq2s3FZeci+iC6MRfs+QP2667VeK5HSo7LIftg
        NUbFkXx8jwhuP1SpBPvcQUn5yIeLfWm/e7Ag9A==
X-Google-Smtp-Source: APXvYqzKZv8uzFgFFGlqw1uQdbtON0g1jljHhpVNKgnhHAnH7T+6Bku3pHRk4YpmaohQNiGnHzdhLZliMv9F7naBmsg=
X-Received: by 2002:a05:6214:11ac:: with SMTP id u12mr27563384qvv.85.1582230497726;
 Thu, 20 Feb 2020 12:28:17 -0800 (PST)
MIME-Version: 1.0
References: <20200214063443.23589-1-j-keerthy@ti.com> <20200214063443.23589-2-j-keerthy@ti.com>
 <20200218202048.GA32279@bogus> <6895cf5e-9195-c914-f4ce-a83f36027dbf@ti.com>
In-Reply-To: <6895cf5e-9195-c914-f4ce-a83f36027dbf@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 Feb 2020 14:28:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLamx4hdXLJ5SCP1FPHRP11JP6V-1=NyRY2QM1bvtMtpg@mail.gmail.com>
Message-ID: <CAL_JsqLamx4hdXLJ5SCP1FPHRP11JP6V-1=NyRY2QM1bvtMtpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: thermal: k3: Add VTM bindings documentation
To:     Keerthy <j-keerthy@ti.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 19, 2020 at 1:40 AM Keerthy <j-keerthy@ti.com> wrote:
>
>
>
> On 19/02/20 1:50 am, Rob Herring wrote:
> > On Fri, 14 Feb 2020 12:04:40 +0530, Keerthy wrote:
> >> Add VTM bindings documentation. In the Voltage Thermal
> >> Management Module(VTM), K3 AM654 supplies a voltage
> >> reference and a temperature sensor feature that are gathered in the band
> >> gap voltage and temperature sensor (VBGAPTS) module. The band
> >> gap provides current and voltage reference for its internal
> >> circuits and other analog IP blocks. The analog-to-digital
> >> converter (ADC) produces an output value that is proportional
> >> to the silicon temperature.
> >>
> >> Signed-off-by: Keerthy <j-keerthy@ti.com>
> >> ---
> >>
> >> Changes in v2:
> >>
> >>    * Fixed make dt_binding_check errors.
> >>
> >>   .../bindings/thermal/ti,am654-thermal.yaml    | 57 +++++++++++++++++++
> >>   1 file changed, 57 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> >>
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> > Error: Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dts:21.41-42 syntax error
> > FATAL ERROR: Unable to parse input tree
> > scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dt.yaml' failed
> > make[1]: *** [Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dt.yaml] Error 1
> > Makefile:1263: recipe for target 'dt_binding_check' failed
> > make: *** [dt_binding_check] Error 2
> >
> > See https://patchwork.ozlabs.org/patch/1237882
> > Please check and re-submit.
>
> Rob,
>
> I am using:
>
> Tree: https//github.com/devicetree-org/dt-schema.git
> branch: master
>
> I have make dt_binding_check working for
> Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dt.yaml
>
> Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dts
> is created without any errors :
>
> https://pastebin.ubuntu.com/p/6MkMbKPpbY/
>
> I did not see any errors as the other files erred out.

'make -k' is your friend.

What branch are you on. Only linux-next breaks generally.

> Today i tried with DT_SCHEMA_FILES option and then finally reproduced
> the errors. It is a bit confusing for the first time users.
>
> Now i have it compiled without any errors.
>
> Posting v3 in a bit.
>
> - Keerthy
>
>
> >
