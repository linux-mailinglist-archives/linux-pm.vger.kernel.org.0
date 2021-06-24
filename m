Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE2C3B30A3
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 16:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhFXOCy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 10:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231157AbhFXOCx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Jun 2021 10:02:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1837461413;
        Thu, 24 Jun 2021 14:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624543234;
        bh=nnWxQzbRUx8Qk7mmLnWigLYEA/UQu5S806YSqsNSR6Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Flgkarhy7Qk4jQS5swLgztydWO40jnFsofA/R+IZs4wPC7FhQqT+EbNfpVqoyL1pd
         R/rCwHvnUnEHDsAtodc7LzPgy5ikCadSfIoRnlZOcRzdlqtMfNI8JLqJjgLX6A3EyR
         trIEWpZi8DTffFXkeCvA2cz4tCYeTuWfhwcS6ThsDEVLc5n8PD76AcVB6wslyU53tF
         qrELditF57/G2rS10cnk88OjwSlN2pQAWuws0NHspfdcFah/IznLeoH0Olu7FQvVY7
         50LGaM/HcNBhNso4MgkHl0ecrJrp7bcbD/O3lNRtU6xqt8qIVSEE8S8QwEWvYzXdNC
         JXg35VYld8sOQ==
Received: by mail-ed1-f47.google.com with SMTP id h17so8663128edw.11;
        Thu, 24 Jun 2021 07:00:34 -0700 (PDT)
X-Gm-Message-State: AOAM530nnhKdsdaLIFczgKZwC7cxVkWMRA98TbkpcLzb0Numn338i6jG
        Kwvlfn7cp1xpiHC5S0SPV/eO9gHYoTuk4CXGsw==
X-Google-Smtp-Source: ABdhPJzzInWyD5X461ly7VfBRdz00t6HneScJdDHoXnnXJiaIo3nfJuXh1S7ImzvVuTpXeuUp4Zz0xB9MsnTE/pIyVI=
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr7559674edt.194.1624543232599;
 Thu, 24 Jun 2021 07:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210623230722.3545986-1-robh@kernel.org> <20210623230722.3545986-3-robh@kernel.org>
 <20210624043240.n6m3cdftz75lhm3t@vireshk-i7>
In-Reply-To: <20210624043240.n6m3cdftz75lhm3t@vireshk-i7>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 24 Jun 2021 08:00:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJZf-i_utyar46aa0AD4fJBi1PeUHqm8cyk28GMSEtbDw@mail.gmail.com>
Message-ID: <CAL_JsqJZf-i_utyar46aa0AD4fJBi1PeUHqm8cyk28GMSEtbDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: opp: Convert to DT schema
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 23, 2021 at 10:32 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Thanks for taking it up :)
>
> On 23-06-21, 17:07, Rob Herring wrote:
> > diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> > +$id: http://devicetree.org/schemas/opp/opp-v2-base.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Generic OPP (Operating Performance Points) Common Binding
> > +
> > +maintainers:
> > +  - Viresh Kumar <viresh.kumar@linaro.org>
> > +
> > +description: |
> > +  Devices work at voltage-current-frequency combinations and some implementations
> > +  have the liberty of choosing these. These combinations are called Operating
> > +  Performance Points aka OPPs. This document defines bindings for these OPPs
> > +  applicable across wide range of devices. For illustration purpose, this document
> > +  uses CPU as a device.
> > +
> > +  This describes the OPPs belonging to a device.
> > +
> > +select: false
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: '^opp-table(-[a-z0-9]+)?$'
> > +
> > +  opp-shared:
> > +    description:
> > +      Indicates that device nodes using this OPP Table Node's phandle switch
> > +      their DVFS state together, i.e. they share clock/voltage/current lines.
> > +      Missing property means devices have independent clock/voltage/current
> > +      lines, but they share OPP tables.
> > +    type: boolean
> > +
> > +patternProperties:
> > +  '^opp-?[0-9]+$':
> > +    type: object
> > +    description:
> > +      One or more OPP nodes describing voltage-current-frequency combinations.
> > +      Their name isn't significant but their phandle can be used to reference an
> > +      OPP. These are mandatory except for the case where the OPP table is
> > +      present only to indicate dependency between devices using the opp-shared
> > +      property.
> > +
> > +    properties:
> > +      opp-hz:
> > +        description:
> > +          Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
> > +          required property for all device nodes, unless another "required"
> > +          property to uniquely identify the OPP nodes exists. Devices like power
> > +          domains must have another (implementation dependent) property.
> > +
> > +      opp-peak-kBps:
> > +        description:
> > +          Peak bandwidth in kilobytes per second, expressed as an array of
> > +          32-bit big-endian integers. Each element of the array represents the
> > +          peak bandwidth value of each interconnect path. The number of elements
> > +          should match the number of interconnect paths.
> > +        minItems: 1
> > +        maxItems: 32  # Should be enough
>
> Can we move this down, closer to opp-avg-kBps ?

Sure.

> > +
> > +      opp-microvolt:
> > +        description: |
> > +          Voltage for the OPP
> > +
> > +          A single regulator's voltage is specified with an array of size one or three.
> > +          Single entry is for target voltage and three entries are for <target min max>
> > +          voltages.
> > +
> > +          Entries for multiple regulators shall be provided in the same field separated
> > +          by angular brackets <>. The OPP binding doesn't provide any provisions to
> > +          relate the values to their power supplies or the order in which the supplies
> > +          need to be configured and that is left for the implementation specific
> > +          binding.
> > +
> > +          Entries for all regulators shall be of the same size, i.e. either all use a
> > +          single value or triplets.
> > +        minItems: 1
> > +        maxItems: 8
>
> For consistency with rest of the doc, maybe add
>
> # Should be enough regulators
>
> > +        items:
> > +          minItems: 1
> > +          maxItems: 3
> > +
> > +      opp-microamp:
> > +        description: |
> > +          The maximum current drawn by the device in microamperes considering
> > +          system specific parameters (such as transients, process, aging,
> > +          maximum operating temperature range etc.) as necessary. This may be
> > +          used to set the most efficient regulator operating mode.
> > +
> > +          Should only be set if opp-microvolt(-name)? is set for the OPP.
>
> What is the significance of '?' here ?

regex. '?' means optional.

> > +          Entries for multiple regulators shall be provided in the same field
> > +          separated by angular brackets <>. If current values aren't required
> > +          for a regulator, then it shall be filled with 0. If current values
> > +          aren't required for any of the regulators, then this field is not
> > +          required. The OPP binding doesn't provide any provisions to relate the
> > +          values to their power supplies or the order in which the supplies need
> > +          to be configured and that is left for the implementation specific
> > +          binding.
> > +        minItems: 1
> > +        maxItems: 8   # Should be enough regulators
> > +        items:
> > +          minItems: 1
> > +          maxItems: 3

Actually, I need to drop these 3 lines as opp-microamp doesn't have a
range like opp-microvolt.

>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> --
> viresh
