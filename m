Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E204760D614
	for <lists+linux-pm@lfdr.de>; Tue, 25 Oct 2022 23:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiJYVWT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Oct 2022 17:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJYVWS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 17:22:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3833E659D
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 14:22:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i21so17289797edj.10
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 14:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1r2CnugOAJ27/zLCmeUMgFKfotH1XVefdtSVY454cTM=;
        b=hUrB+DazaZ6ULnk8xEy7lQRuOiIIjqk0HPOzaNdPCvoOkFihm0sLetRZsPELwuvP3u
         wvcIZgOWVCvzcabfuo2fLaJpt5tS3EHGOuo1RC9uoPUDEA2X2rpLwWh74121DyCVWFPC
         rST5YrR+cvWcRuhu2FRKe7vUs1xdj5kxXd0qVzMpgpCEoLsMkmyBzfSd3eZfxVjLNjTj
         +mEKOC3kTfih9q/gTDkVVzbf1dcrecL+HnJMTzQDLsnDJC1QXPv0M5SxfnIm/NreBMnT
         WXZihKNaalutJ2gC6cEPwkqUKUZYsWsY+HztOYH+uXYMyydACvpJlrRlZVqWRCUfsMU/
         Kfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1r2CnugOAJ27/zLCmeUMgFKfotH1XVefdtSVY454cTM=;
        b=CEfiajYrG8hIgkoHENAZjg/9V4VRpl0nXt6N9lvTUhc3OpZjaK77dE6LD+s6AgztSN
         hGNCDspWmNQaqGJipqEoJkXAmBgKnCa3DsT3Wi9d75Herp4OYU0oS6RnziOBbuYPhS7e
         LJhoCwzw1G2YcZtkXNV+1LLEXc58qsG4VXbjIiGdmBYkf36lw3qaWqcQzZN21qd8aWOS
         Hr8vahg+tgBumHPYtETg+5b7cv9icwFS9NQm7OiwPta6iAN5pypmD+VrQpkhdse37jWs
         KOYVAvHF45RcEYjY5rcoM6za90ee83Rc8SzC3BVOOOwYYGSjipTfjb0ldL8DZ8zBLSt8
         RNZQ==
X-Gm-Message-State: ACrzQf3S0DHonjCTxl6jL/NgXRT/dJGoiLFpCwvNjyUZEtxQzsdfj+9p
        JeYtt6z7tYlMHzswfTIGPQJ4VCIgKMlTbPrR+0Duv3hun8J5D53S
X-Google-Smtp-Source: AMsMyM6RIaJq3T8JAUmpJACanx/Du0C13ERMhVXmpnc3WBbXKEa9xGpZeiuW9QLWtvMiT3jPQzd6RbEDMCWsGZWS3gA=
X-Received: by 2002:aa7:d385:0:b0:461:8cd3:b38b with SMTP id
 x5-20020aa7d385000000b004618cd3b38bmr16745976edq.172.1666732935801; Tue, 25
 Oct 2022 14:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdbB5hgkrPZVb-+9tuKErvwjTKNaBQ1LvH1==fR7bndjSQ@mail.gmail.com>
In-Reply-To: <CACRpkdbB5hgkrPZVb-+9tuKErvwjTKNaBQ1LvH1==fR7bndjSQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Oct 2022 23:22:04 +0200
Message-ID: <CACRpkda1X-18M0KCMGh+xgnr+Re30JiNUJaNjvT76qM_1Wze+A@mail.gmail.com>
Subject: Re: Regression after recent changes to drivers/thermal/thermal_of.c
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 25, 2022 at 11:13 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> The reason why I have this is that the thermal zone is not managed
> by the OF thermal core, but by the battery charging algorithm which
> just retrieves the thermal zone and use it to read the temperature, see
> commit 2b0e7ac0841b3906aeecf432567b02af683a596c
> "power: supply: ab8500: Integrate thermal zone".

You will probably ask why the charging code does this and why we
don't put a trip point in there to protect the battery.

It is because the battery is detected from the device tree and the
thermal points determine things like when to start charging carefully,
based on the specific battery. There is also an over-temperature
of course, but the action is very different from what a CPU does
with these temperatures.

You find these statically per-compatible in e.g.:
drivers/power/supply/samsung-sdi-battery.c, e.g.:

(...)
.temp_min = -30,
.temp_alert_min = 0,
.temp_alert_max = 40,
.temp_max = 47,
(...)

The battery charging will stop entirely at temp_min or temp_max
and reduce below alert_min or above alert_max. It will not
shut down the system though, just the charging.

Yours,
Linus Walleij
