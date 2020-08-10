Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280D0240519
	for <lists+linux-pm@lfdr.de>; Mon, 10 Aug 2020 13:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgHJLPb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Aug 2020 07:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgHJLPb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2020 07:15:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F58BC061756;
        Mon, 10 Aug 2020 04:15:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so7746904wrh.10;
        Mon, 10 Aug 2020 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=jM/x2ogPXMvwtQt/xozdmqVBQPu8Fwaz54JOytXUpzU=;
        b=FQVZgih9symQj4VmUqzuy5/O3o69bDPE03jXa5anR2KLy1aYIj6gP+vioW6Qs/8jx2
         +oPVqOSobGoHWu2uFAvqg6Ikpe/IXpNgHjT5I/kZyOl/s6i0rauCf9WM3QRuUcceqFga
         LKKgjupgWz8hcEo0OHNMkr8piLHKjfRvOy6holSnDoRtTDos6orfmrzIGUx1yIzX4h2T
         /fKnDwHLkhFwyskcjMZlERHguAR+TcYrigfZVmpP4K4kbtnOf5KPXUUMgh4Vb1Zsceau
         FcNmkHZy3l6Nh39qcVjHooZkZI9AkISbzLRkeO4imbg/3Ko3ZSANAZ/Dp5zJc10ue76p
         PQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=jM/x2ogPXMvwtQt/xozdmqVBQPu8Fwaz54JOytXUpzU=;
        b=DD+6/L3WehnJgxT8hCF4ZCqt4cwFTb1Em8vN0laaeVZwEYCT7TtpLYK0G7rcFF2lHk
         WfFMA6XBcTQyB1hj/Y/1/n9E/r0I3kaE6HBfM4UmVqcRd5S8zaLJEP9MggygTv2KMSGt
         D1c3meJqOBY+gSIH74XyjG7SKaMOkVm/K8fxuBDH719DJRXGSpQUzpiclaVtA7oU/I6/
         LXnd6YiRV5fWbXBIZCYovpscgog0dzDk4+XkxUbc9VgYvVzjMyzLFt/a38NE0a5otUkm
         trkjmVSHCQG5t155Wu/mTu4ulrTRqK2dzIU48L1avzPwTtXdJnrSPXm+499uj6WFbjcU
         EY5Q==
X-Gm-Message-State: AOAM531pTiiOj2K97YIcCARxO9BD1Z7Gi5jEJ6uTynIX5+eIWkSPPivC
        LDiy09zWKZxPz/0yRL2/I/475llm
X-Google-Smtp-Source: ABdhPJwcPHCeAo0uTg5hEi7rDqLfIVZ9pqeTFyQLI1zqaFaT/2ollaueAscNjF2L8b2q2fbgrUdzLg==
X-Received: by 2002:a5d:6381:: with SMTP id p1mr23595566wru.112.1597058126918;
        Mon, 10 Aug 2020 04:15:26 -0700 (PDT)
Received: from AnsuelXPS (host-79-13-255-165.retail.telecomitalia.it. [79.13.255.165])
        by smtp.gmail.com with ESMTPSA id b203sm21323133wmc.22.2020.08.10.04.15.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Aug 2020 04:15:26 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Sudeep Holla'" <sudeep.holla@arm.com>
Cc:     "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Rob Herring'" <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200807234914.7341-1-ansuelsmth@gmail.com> <20200807234914.7341-3-ansuelsmth@gmail.com> <20200810080146.GA31434@bogus>
In-Reply-To: <20200810080146.GA31434@bogus>
Subject: R: [RFC PATCH v2 2/2] dt-bindings: cpufreq: Document Krait CPU Cache scaling
Date:   Mon, 10 Aug 2020 13:15:24 +0200
Message-ID: <061301d66f07$8beae690$a3c0b3b0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQJQ3CWQUPMUi8qrdt9OPWHZDAmorwGMMbnpAk5rSZOoHXwVIA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> -----Messaggio originale-----
> Da: Sudeep Holla <sudeep.holla@arm.com>
> Inviato: luned=EC 10 agosto 2020 10:02
> A: Ansuel Smith <ansuelsmth@gmail.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>; Rafael J. Wysocki
> <rjw@rjwysocki.net>; Rob Herring <robh+dt@kernel.org>; linux-
> pm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Oggetto: Re: [RFC PATCH v2 2/2] dt-bindings: cpufreq: Document Krait =
CPU
> Cache scaling
>=20
> On Sat, Aug 08, 2020 at 01:49:12AM +0200, Ansuel Smith wrote:
> > Document dedicated Krait CPU Cache Scaling driver.
> >
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/cpufreq/krait-cache-scale.yaml   | 92
> +++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-
> cache-scale.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/cpufreq/krait-cache-
> scale.yaml b/Documentation/devicetree/bindings/cpufreq/krait-cache-
> scale.yaml
> > new file mode 100644
> > index 000000000000..f10b1f386a99
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/krait-cache-
> scale.yaml
> > @@ -0,0 +1,92 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/cpufreq/krait-cache-scale.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Krait Cpu Cache Frequency Scaling dedicated driver
> > +
> > +maintainers:
> > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > +
> > +description: |
> > +  This Scale the Krait CPU Cache Frequency and optionally voltage
> > +  when the Cpu Frequency is changed (using the cpufreq notifier).
> > +
> > +  Cache is scaled with the max frequency across all core and the =
cache
> > +  frequency will scale based on the configured threshold in the =
dts.
> > +
> > +  The cache is hardcoded to 3 frequency bin, idle, nominal and =
high.
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,krait-cache
> > +
>=20
> How does this fit in the standard cache hierarchy nodes ? Extend the
> example to cover that.
>=20

I think i didn't understand this question. You mean that I should put
in the example how the standard l2 cache nodes are defined?

> > +  clocks:
> > +    description: Phandle to the L2 CPU clock
> > +
> > +  clock-names:
> > +    const: "l2"
> > +
> > +  voltage-tolerance:
> > +    description: Same voltage tollerance of the Krait CPU
> > +
> > +  l2-rates:
> > +    description: |
> > +      Frequency the L2 cache will be scaled at.
> > +      Value is in Hz.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    items:
> > +      - description: idle
> > +      - description: nominal
> > +      - description: high
> > +
>=20
> Why can't you re-use the standard OPP v2 bindings ?
>=20

Isn't overkill to use the OPP v2 bindings to represent the the microvolt
related
to the le freq? Is the OPP v1 sufficient? Also I can't find a way to =
reflect
this specific
case where the l2 rates are changed based on the cpu freq value? Any =
idea
about that?

> --
> Regards,
> Sudeep

