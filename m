Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E885798C23
	for <lists+linux-pm@lfdr.de>; Fri,  8 Sep 2023 20:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbjIHSEm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 8 Sep 2023 14:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241982AbjIHSEl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Sep 2023 14:04:41 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21361FD9;
        Fri,  8 Sep 2023 11:04:12 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1d549d01c74so465000fac.1;
        Fri, 08 Sep 2023 11:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694196127; x=1694800927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4xMGxgAQ0KLjdYqgKsPVykZohU0zG+yrE1paP2f2FE=;
        b=atYFyz0ylyQEcdK6MT+9wpY/bTiivt/59BklcrJvQVtFlNocltSX4hLusVfB7HbibX
         OIqSeg5eWkSTdGU3qbt0MqNUgoGT/mphvLcKaqHc4hlTS3MWgGLMNQJPFzZ5CitPSXqb
         caQKINLYOq8aaPYFGQk+CvDtD335ZgdM3DaokC1GQqdBEjZyO5gUtGV1fL0+nAbEmBrI
         8GkhNw/ZoYuZ1FyrVnvB7AdtjVNIYbzgXk49OPSkuraCpB8OpQ3IBETTXyg+SPSzBvI4
         gZW394zFgYRs9Pc5stUilZQULliyPJTJaYmyiOGlyO0ys7HhrlhbUhqxpFUekrLDgLEf
         jP/g==
X-Gm-Message-State: AOJu0YxXzaasMwHpobNZpgF8mN9lDiJ3bwpemDhnQRHzx+UsPPLJNrhJ
        PEri2qWDH0KEyVVdt57KU9LXvA0FfeeoaBxwdCs=
X-Google-Smtp-Source: AGHT+IFsYRNxvJlIPNOCgp621VYMzACoA/iAr4iJEakCcL3A6TKOlo/9EC1Gkp7D3+5M3+w55Yr2iboYdSgSC5h8R+0=
X-Received: by 2002:a05:6870:70a6:b0:1b3:8cfd:fecf with SMTP id
 v38-20020a05687070a600b001b38cfdfecfmr3906386oae.0.1694196127405; Fri, 08 Sep
 2023 11:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230831130242.2290502-1-festevam@gmail.com> <CAJZ5v0jKmxxFMO5TkHujEtdSjeEqKqEOwRyXAXbaeRQUTythdg@mail.gmail.com>
 <18b23d536827559f113ebae99c859cfc@denx.de>
In-Reply-To: <18b23d536827559f113ebae99c859cfc@denx.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Sep 2023 20:01:55 +0200
Message-ID: <CAJZ5v0iROqUP+HGM9djazVCYnRP_QOikgPAH1kympaC2qy_hcg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: thermal-zones: Document critical-action
To:     Fabio Estevam <festevam@denx.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 8, 2023 at 7:37 PM Fabio Estevam <festevam@denx.de> wrote:
>
> Hi Rafael,
>
> On 07/09/2023 13:23, Rafael J. Wysocki wrote:
>
> > So one more question here: Why is this a property of a thermal zone
> > and not the property of the whole system?
> >
> > Presumably, on a system where the platform integrator prefers to
> > reboot on critical temperature, it would be necessary to add this
> > property to every thermal zone.
> >
> > Also, what if this property has different values for different thermal
> > zones?
>
> I got your point and I can make the 'critical-action' property to be
> valid
> for the whole thermal system.
>
> Originally, I have been doing like this:
>
>         thermal-zones {
>                 cpu-thermal {
>                         critical-action = "reboot";
>                         polling-delay-passive = <250>;
>                         polling-delay = <2000>;
>                         thermal-sensors = <&tmu>;
>
>                         trips {
>                                 cpu_alert0: trip0 {
>                                         temperature = <85000>;
>                                         hysteresis = <2000>;
>                                         type = "passive";
>                                 };
>
> I can change it to be:
>
>
>         thermal-zones {
>                 critical-action = "reboot";
>
>                 cpu-thermal {
>                         polling-delay-passive = <250>;
>                         polling-delay = <2000>;
>                         thermal-sensors = <&tmu>;
>
>                         trips {
>                                 cpu_alert0: trip0 {
>                                         temperature = <85000>;
>                                         hysteresis = <2000>;
>                                         type = "passive";
>                                 };
>

I think that this would match the use case better.

I still would love to hear about it from the people who take care of
the DT-based thermal control (mostly Daniel and Amit, who BTW is
listed as the maintainer of the file being updated by this patch),
though.
