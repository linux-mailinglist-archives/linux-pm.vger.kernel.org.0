Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4EA691B04
	for <lists+linux-pm@lfdr.de>; Fri, 10 Feb 2023 10:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjBJJNf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Feb 2023 04:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjBJJNc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2023 04:13:32 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834165BA5F
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 01:13:24 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ml19so14205984ejb.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 01:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fZFf2yI4NiZ1ohXSbStbdFw0GfjyGPBHrzhVz49z0Y=;
        b=b2tb5/OmuOTxoKVQ1J47Qg4rdMcs72fXWi2DfegMVNDSgLn/zmioHttGI9DFW+/qzO
         96+2ePEG/zrjdP3GQl7vtsyP9kRPGLutO27ermYdpR0e4tHx7pko4FrB0tILW41i8pj+
         lJC2lLEgiqa39+x8zVHZEfRw6ZyQwxKpS73UR37olSz5OGLmHnSbLV3yAGCIkezCx+bZ
         3YKLECmvyv1A336QZ3mUaN3cQ2YSd2yz6iSe2D+ptr82EpDptxzhcW8pJ+sLw5hn2CGJ
         yl7czinS3HoNadZ0i7ykVJoirTqSh+11oUPnlCzAIxf1R22L/6/bBQ//MSXFOy7yRTX/
         5fvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fZFf2yI4NiZ1ohXSbStbdFw0GfjyGPBHrzhVz49z0Y=;
        b=nfrblzAJQoUIuHBYdZBAYRBELcibbJ+vossUyxDV8Zi5DNfEPaf4zgicejBXfluoE5
         HhcrEnTek6GwJWltJXBie4K+zbF/ElXWDrAM8rLVvAUf+Bc7+Z+3BRCqHanv8tNmMhai
         qR6ybbT5wdiZi5vzc8I0Fo+p9+VE7z+Wcp8QrcJp//QjeqB2ZNzFJmizy5isH3w+Iyz8
         IPYGOMiPRBg9tBcoPq+J/fja+FAGPJNJ3MuuoDfMiMPzz8kXk09ubS2lIWpzohXhtUEb
         ZLt9IkgPi9dT++oE6FPzEwwgothseQ5rbxNxx/FLgwL8oX7Qy7MQ77q0MiUUkx3s04uc
         kJgA==
X-Gm-Message-State: AO0yUKU9thEW5bAJW7Kf/N1CyhHJan5xAHZVva32545Gz33nMVRAuiaH
        FMAMHJgxb8Gj3vnJMY4oZTmTkc+Ymr80r2dg0FjfXQ==
X-Google-Smtp-Source: AK7set8z0VVs9Ynm8YK8/sg/s2hoilc5vUf32Iszp/v3ATNK4ku2TS/dWRb+ymTJE6AxLofb6FZhMsS0juAOG5sQLBU=
X-Received: by 2002:a17:906:ca04:b0:7c0:f45e:22ff with SMTP id
 jt4-20020a170906ca0400b007c0f45e22ffmr3467086ejb.104.1676020403067; Fri, 10
 Feb 2023 01:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20230209105628.50294-1-bchihi@baylibre.com> <b41930f9-89d9-1b12-b024-05fb12700769@linaro.org>
In-Reply-To: <b41930f9-89d9-1b12-b024-05fb12700769@linaro.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Fri, 10 Feb 2023 10:12:47 +0100
Message-ID: <CAGuA+oo+1tSDhVkrc-2feH9e8wMpBgAa-N1VEOuGN8_c=uo1zw@mail.gmail.com>
Subject: Re: [PATCH v14 0/6] Add LVTS Thermal Architecture
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On Fri, Feb 10, 2023 at 7:44 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 09/02/2023 11:56, bchihi@baylibre.com wrote:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > The LVTS (Low Voltage Thermal Sensor) driver is capable of monitoring
> > multiple hot points. For that, it contains 7 thermal control blocks
> > dedicated to specific devices on the die. Each control block can handle
> > up to 4 sensors.
> >
> > The thermal controller supports several interrupts. One for the cold
> > trip point, the hot trip point, the return to the normal trip point,
> > and a specific programmable trip point to monitor the temperature
> > dynamically.
> >
> > The temperature measurement can be done in two ways, the immediate mode
> > where the temperature read is instantaneous and the filtered mode where
> > the controller uses, by configuration, an average of a set of values
> > removing the minimum and the maximum.
> >
> > Finally, it is composed of 2 finite-state machines responsible for
> > the state of the temperature (cold, hot, hot 2 normal, hot hot),
> > the triggering of the interrupts, and the monitoring of the temperature=
.
> >
> > As requested, the thermal driver has been reworked to reduce
> > the complexity of the code. At this time, the 4 little CPUs and
> > the 4 big CPUs are supported by the thermal driver.They are described
> > in a data structure and more devices can be added later.
> > The calibration routine has been simplified also.
> >
> > The series provide the following changes:
> >   - Move the Mediatek drivers inside a dedicated folder as their number
> >     is increasing
> >   - Add the DT bindings for the controller
> >   - Add the efuse node for the mt8195
> >   - The LVTS driver
> >   - The thermal zones description in the DT
>
> Applied patch 1,2 and 4 for v6.3

Thank you very much!

>
> Patches 5 and 6 should go through the Mediatek tree.
>
> Thanks!
>
>    -- Daniel
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

Best regards,
Balsam
