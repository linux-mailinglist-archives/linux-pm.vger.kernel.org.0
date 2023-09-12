Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDCB79D48C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbjILPOa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Sep 2023 11:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbjILPOa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Sep 2023 11:14:30 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5145C12E;
        Tue, 12 Sep 2023 08:14:26 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51f64817809so678445a12.1;
        Tue, 12 Sep 2023 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694531666; x=1695136466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmhnU1mUBTvGooJ8RY5P2rzvLlRqBBo52eULg86WrB4=;
        b=LucxwN6EDigLSwLeCQjYJRaf9zRo6v/qRDFE3rvQmSaFldJ30ljv0fNqU6zebOSGP/
         8L5b1PQoDvGbID/BHBut5JwZOutlGBqwDJsNZrMEImDW6yz1r7UJGqColJ2gDL0bacCX
         LdRbawDEJkK9vc/rA0tM8oPvWqozACmePev2YfNJBAd/geyNMSnn5PFyrB5mJdARFXQd
         HktG5BNJ0+Ax4NcEQDKblH5qYDTWubzM00P9YcYaHQwaid0hBa8DeY2CK5QLghfuBr2m
         etmgOyH8tvpkhFhfFWkx7u8y7dHa8iSSWFfIhzJUqPdcRaTJQB5dsZ2cAJTL3QM1aSvH
         AfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694531666; x=1695136466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmhnU1mUBTvGooJ8RY5P2rzvLlRqBBo52eULg86WrB4=;
        b=HjJUQwrB/PONLnqvm2FKEnor1XSOct/q6DvSdmcE2hgau68qZpIjOcEHmyrZzygvY1
         2cTT87rHQc+yi3KeFC6xW4x4GFOhmxDkXsSgCWOibwWS89/M2xsRbsHw7oxiGujCOvsb
         slPqpY24cI/l1UVwIVj9u+56Z66mGdS34IVyv7RtTyMcRksPH5CWfM5yJZBUee4X9s6t
         WtvKfS5VHS1ETCnPtKiicgZJYl3I6B6bwypMRns1UOWGNw1Bu6+WMiIviYT5xucKOnF5
         VCe/k2zPG6Soh2S6ApXXHBL+5K8HfMUL/lXcYlphcLHXdKv8A6D9XcFU6IBPltaBHEO8
         gK+g==
X-Gm-Message-State: AOJu0Yzi5g1fLaUtd5By3/VrQMNk48G4ECVFr7L9bgoFMSUu4u8VuGMg
        GnlhuP6QINa/jkkEqqeOi89hvgWmZ4yvKz6YnQw=
X-Google-Smtp-Source: AGHT+IEDx0Xvd6FTrq5LXjrHvQW9X9/hVgAwJQ2qx5fukPQYXdAbKJmbOIMNh2wpMGXCeJrZHwzePfCPFLzb1jBlTFQ=
X-Received: by 2002:a17:90a:1210:b0:263:f36e:d610 with SMTP id
 f16-20020a17090a121000b00263f36ed610mr11612777pja.0.1694531665742; Tue, 12
 Sep 2023 08:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230831130242.2290502-1-festevam@gmail.com> <CAJZ5v0jKmxxFMO5TkHujEtdSjeEqKqEOwRyXAXbaeRQUTythdg@mail.gmail.com>
 <18b23d536827559f113ebae99c859cfc@denx.de> <CAJZ5v0iROqUP+HGM9djazVCYnRP_QOikgPAH1kympaC2qy_hcg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iROqUP+HGM9djazVCYnRP_QOikgPAH1kympaC2qy_hcg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 12 Sep 2023 12:14:14 -0300
Message-ID: <CAOMZO5AHGr9A2RFQ89SzLnzkwOFez3vO2BH3Lh4yZOL-aSn9cA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: thermal-zones: Document critical-action
To:     "Rafael J. Wysocki" <rafael@kernel.org>, amitk@kernel.org,
        daniel.lezcano@linaro.org
Cc:     Fabio Estevam <festevam@denx.de>, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Amit and Daniel,

On Fri, Sep 8, 2023 at 3:02=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Fri, Sep 8, 2023 at 7:37=E2=80=AFPM Fabio Estevam <festevam@denx.de> w=
rote:
> >
> > Hi Rafael,
> >
> > On 07/09/2023 13:23, Rafael J. Wysocki wrote:
> >
> > > So one more question here: Why is this a property of a thermal zone
> > > and not the property of the whole system?
> > >
> > > Presumably, on a system where the platform integrator prefers to
> > > reboot on critical temperature, it would be necessary to add this
> > > property to every thermal zone.
> > >
> > > Also, what if this property has different values for different therma=
l
> > > zones?
> >
> > I got your point and I can make the 'critical-action' property to be
> > valid
> > for the whole thermal system.
> >
> > Originally, I have been doing like this:
> >
> >         thermal-zones {
> >                 cpu-thermal {
> >                         critical-action =3D "reboot";
> >                         polling-delay-passive =3D <250>;
> >                         polling-delay =3D <2000>;
> >                         thermal-sensors =3D <&tmu>;
> >
> >                         trips {
> >                                 cpu_alert0: trip0 {
> >                                         temperature =3D <85000>;
> >                                         hysteresis =3D <2000>;
> >                                         type =3D "passive";
> >                                 };
> >
> > I can change it to be:
> >
> >
> >         thermal-zones {
> >                 critical-action =3D "reboot";
> >
> >                 cpu-thermal {
> >                         polling-delay-passive =3D <250>;
> >                         polling-delay =3D <2000>;
> >                         thermal-sensors =3D <&tmu>;
> >
> >                         trips {
> >                                 cpu_alert0: trip0 {
> >                                         temperature =3D <85000>;
> >                                         hysteresis =3D <2000>;
> >                                         type =3D "passive";
> >                                 };
> >
>
> I think that this would match the use case better.
>
> I still would love to hear about it from the people who take care of
> the DT-based thermal control (mostly Daniel and Amit, who BTW is
> listed as the maintainer of the file being updated by this patch),
> though.

Please let us know what you think.

I can send v8 which places the 'critical-action' property to be valid
for the whole thermal system, as suggested by Rafael.

Thanks
