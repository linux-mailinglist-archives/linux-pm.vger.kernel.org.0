Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F44A240630
	for <lists+linux-pm@lfdr.de>; Mon, 10 Aug 2020 14:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgHJMvL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Aug 2020 08:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgHJMvK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2020 08:51:10 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B0BC061756;
        Mon, 10 Aug 2020 05:51:09 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id cq28so6100315edb.10;
        Mon, 10 Aug 2020 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=LrkS8bPL538kQ7bNdv7BnP1bghXsTc7kkI6BCl+cUtw=;
        b=fh8Py677GNM8lDBajIebrsFFBOPP0YQsZp8PIrAMxtughKQDkP7nqfmiWPRrciKKjj
         Zw0Wwxbc1kMlEOmHfKrTriCAqj2+gST55rnJq97sopjtJXilWd5KCggoSmJPmY6m8biB
         91x/FWL6PCL6J1Wpjs6ZRc3f7EpToVGNa2vIOVKYh1+hlAKBBqVOjmyPYDDXi+THH9O+
         bT8iX9M1U97ny0ZEyfqVhm9xeBht1AvbI2NhKS17O951Qjz+/58EJyv1QOt67AG8TMzQ
         4z4FMz6DJ4AyNjkJkQ/RqQiq4rdGeT5pcEZrPhIueojHwZWViAdcB+rIOFqQQbO5414Z
         SQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=LrkS8bPL538kQ7bNdv7BnP1bghXsTc7kkI6BCl+cUtw=;
        b=PcUTfioTxondRprjERHjDVWfKBwj4lPH0GooPNQ0nEmSM8vEV6wL/wzVP4o88Uk2IQ
         ZLjFf0NvC+UvzPql9wI9xHzca+1nsq5P9pYa94X0D/fDs8t/syjlqgCIXyXSAF5cW95X
         o/P+FC8gsjBspkxx8W2lCklhBimTj7aPoSZ0oXNd8GYPSbTnQDRfK+Pu8bRW4JLzTpIL
         Pe0pJrYTOPTDD2LxaHAQ9abAYVXLxEviUh6QAFUfN4idRZgosfLihXUp+LooFD+vWQIA
         wi2eoV5Kig7r9PXQkvv+tkzp4iT+TQiWkmU8gBlRL7iZ8xDaC7Xr8QObulC8OgzpZ5wi
         PFIg==
X-Gm-Message-State: AOAM532SKbPIsTXSmadhT8k6Wz+3sGoXIp5VWRhr/OpHJdEq9trs3TUj
        nPpQ7W/OeaI5CUo93X7UPJgndjOi
X-Google-Smtp-Source: ABdhPJw4m6xe0M6IfgxazF7sadfNQMuScg+4nFYyInLy7KM2wlF1Pfm6VXShZ+RDUoJZg/woWz3BDA==
X-Received: by 2002:a50:ee0a:: with SMTP id g10mr19981370eds.289.1597063867494;
        Mon, 10 Aug 2020 05:51:07 -0700 (PDT)
Received: from AnsuelXPS (host-79-13-255-165.retail.telecomitalia.it. [79.13.255.165])
        by smtp.gmail.com with ESMTPSA id gl20sm13283010ejb.86.2020.08.10.05.51.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Aug 2020 05:51:06 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Sudeep Holla'" <sudeep.holla@arm.com>
Cc:     "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Rob Herring'" <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200807234914.7341-1-ansuelsmth@gmail.com> <20200807234914.7341-3-ansuelsmth@gmail.com> <20200810080146.GA31434@bogus> <061301d66f07$8beae690$a3c0b3b0$@gmail.com> <20200810124509.GC31434@bogus>
In-Reply-To: <20200810124509.GC31434@bogus>
Subject: R: R: [RFC PATCH v2 2/2] dt-bindings: cpufreq: Document Krait CPU Cache scaling
Date:   Mon, 10 Aug 2020 14:51:02 +0200
Message-ID: <000101d66f14$e9bc2920$bd347b60$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJQ3CWQUPMUi8qrdt9OPWHZDAmorwGMMbnpAk5rSZMCKND62AGS0mSDp/++qdA=
Content-Language: it
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> -----Messaggio originale-----
> Da: Sudeep Holla <sudeep.holla@arm.com>
> Inviato: luned=EC 10 agosto 2020 14:45
> A: ansuelsmth@gmail.com
> Cc: 'Viresh Kumar' <viresh.kumar@linaro.org>; 'Rafael J. Wysocki'
> <rjw@rjwysocki.net>; 'Rob Herring' <robh+dt@kernel.org>; linux-
> pm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Oggetto: Re: R: [RFC PATCH v2 2/2] dt-bindings: cpufreq: Document =
Krait
> CPU Cache scaling
>=20
> On Mon, Aug 10, 2020 at 01:15:24PM +0200, ansuelsmth@gmail.com
> wrote:
> >
> >
> > > -----Messaggio originale-----
> > > Da: Sudeep Holla <sudeep.holla@arm.com>
> > > Inviato: luned=EC 10 agosto 2020 10:02
> > > A: Ansuel Smith <ansuelsmth@gmail.com>
> > > Cc: Viresh Kumar <viresh.kumar@linaro.org>; Rafael J. Wysocki
> > > <rjw@rjwysocki.net>; Rob Herring <robh+dt@kernel.org>; linux-
> > > pm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Oggetto: Re: [RFC PATCH v2 2/2] dt-bindings: cpufreq: Document =
Krait
> CPU
> > > Cache scaling
> > >
> > > On Sat, Aug 08, 2020 at 01:49:12AM +0200, Ansuel Smith wrote:
> > > > Document dedicated Krait CPU Cache Scaling driver.
> > > >
> > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > ---
> > > >  .../bindings/cpufreq/krait-cache-scale.yaml   | 92
> > > +++++++++++++++++++
> > > >  1 file changed, 92 insertions(+)
> > > >  create mode 100644
> Documentation/devicetree/bindings/cpufreq/krait-
> > > cache-scale.yaml
> > > >
> > > > diff --git =
a/Documentation/devicetree/bindings/cpufreq/krait-cache-
> > > scale.yaml =
b/Documentation/devicetree/bindings/cpufreq/krait-cache-
> > > scale.yaml
> > > > new file mode 100644
> > > > index 000000000000..f10b1f386a99
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/cpufreq/krait-cache-
> > > scale.yaml
> > > > @@ -0,0 +1,92 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: =
http://devicetree.org/schemas/cpufreq/krait-cache-scale.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Krait Cpu Cache Frequency Scaling dedicated driver
> > > > +
> > > > +maintainers:
> > > > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > > > +
> > > > +description: |
> > > > +  This Scale the Krait CPU Cache Frequency and optionally =
voltage
> > > > +  when the Cpu Frequency is changed (using the cpufreq =
notifier).
> > > > +
> > > > +  Cache is scaled with the max frequency across all core and =
the
cache
> > > > +  frequency will scale based on the configured threshold in the
dts.
> > > > +
> > > > +  The cache is hardcoded to 3 frequency bin, idle, nominal and
high.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: qcom,krait-cache
> > > > +
> > >
> > > How does this fit in the standard cache hierarchy nodes ? Extend =
the
> > > example to cover that.
> > >
> >
> > I think i didn't understand this question. You mean that I should =
put
> > in the example how the standard l2 cache nodes are defined?
> >
>=20
> I was referring to something like below which I found now in
> arch/arm/boot/dts/qcom-msm8974.dtsi:
> 	L2: l2-cache {
> 		compatible =3D "cache";
> 		cache-level =3D <2>;
> 		qcom,saw =3D <&saw_l2>;
> 	};
>=20
> > > > +  clocks:
> > > > +    description: Phandle to the L2 CPU clock
> > > > +
> > > > +  clock-names:
> > > > +    const: "l2"
> > > > +
> > > > +  voltage-tolerance:
> > > > +    description: Same voltage tollerance of the Krait CPU
> > > > +
> > > > +  l2-rates:
> > > > +    description: |
> > > > +      Frequency the L2 cache will be scaled at.
> > > > +      Value is in Hz.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > +    items:
> > > > +      - description: idle
> > > > +      - description: nominal
> > > > +      - description: high
> > > > +
> > >
> > > Why can't you re-use the standard OPP v2 bindings ?
> > >
> >
> > Isn't overkill to use the OPP v2 bindings to represent the the =
microvolt
> > related to the le freq? Is the OPP v1 sufficient?
>=20
> Should be fine if it is allowed. v2 came out in the flow of my thought
> and was not intentional.
>=20
> > Also I can't find a way to reflect this specific case where the l2 =
rates
> > are changed based on the cpu freq value? Any idea about that?
> >
>=20
> OK, I am always opposed to giving such independent controls in the =
kernel
> as one can play around say max cpu freq and lowest cache or vice-versa
> and create instabilities. IMO this should be completely hidden from =
OS.
> But I know these are old platforms, so I will shut my mouth ;)
>=20

If we really want to deny this practice, I can add a check in the probe
function to fail if the l2 freq threshold is less than the cpu freq.=20

> --
> Regards,
> Sudeep

