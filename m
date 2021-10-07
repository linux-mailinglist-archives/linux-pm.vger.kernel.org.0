Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C9642527A
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 14:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbhJGMHe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 08:07:34 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:47045 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241112AbhJGMHd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 08:07:33 -0400
Received: by mail-oi1-f170.google.com with SMTP id o204so505159oih.13;
        Thu, 07 Oct 2021 05:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=C5HykO0KJmE51rSMAeBl66uxHGW6FmegYmmUdn6Ti0U=;
        b=s89KW0XcUKTgJLDnLxcJtHS2v+JW9lUVNhzebc7zcWRWmTAZCNKf1fqXscmmwacP2l
         FYWyCo3lTRQjR0WfHjjrofTkdGDcMjLB6bmE1S4cgUWUKvScKOfbnBKWAP6NAzq7hutH
         i0iLHckNbEEiE/UOtVQOSkWEnlV0WhSVBTKechhHuvQuCaJUJ+ya9cg8n4IY7c/GhLeo
         ILKyKs/8f7qOoF0uWN/jSwQZQsWOCNf6q+dADnwMDOJkqF095gQYOVoYpxZ/puy/qksp
         FkuRTlIwsmlxT5PgOkYUiKVGguBHqDbuok8XqpQL983iXjo45zHNOCKGimofbKes2syd
         DwrA==
X-Gm-Message-State: AOAM531knDzrLERdQvEpcuhlFcjePZ2COc9m9MlzCnvhk6gDxzxJ9G0b
        zOgoukA19/FumSSbulZ+YYZYvVc9Aw==
X-Google-Smtp-Source: ABdhPJyq/f3hCEhSeGlOG15FIDuhWAqOdyWqIDBfSaysC13EPEgpx6+aPDTiRjtme99o3zej5tkZ0g==
X-Received: by 2002:aca:af49:: with SMTP id y70mr2699934oie.174.1633608339253;
        Thu, 07 Oct 2021 05:05:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q133sm4535586oia.55.2021.10.07.05.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:05:38 -0700 (PDT)
Received: (nullmailer pid 121527 invoked by uid 1000);
        Thu, 07 Oct 2021 12:05:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, devicetree@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
In-Reply-To: <20211006224008.394191-1-linus.walleij@linaro.org>
References: <20211006224008.394191-1-linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: power: supply: ab8500: Standard monitored-battery
Date:   Thu, 07 Oct 2021 07:05:36 -0500
Message-Id: <1633608336.217732.121526.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 07 Oct 2021 00:40:06 +0200, Linus Walleij wrote:
> Make monitored-battery the standard phandle to the battery we monitor
> for the AB8500 charger components. We make the old "battery" phandle
> deprecated, and the new one required so we detect and fix all users to
> use the standard phandle name.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/power/supply/stericsson,ab8500-btemp.yaml | 10 +++++++---
>  .../power/supply/stericsson,ab8500-chargalg.yaml       | 10 +++++++---
>  .../power/supply/stericsson,ab8500-charger.yaml        | 10 +++++++---
>  .../bindings/power/supply/stericsson,ab8500-fg.yaml    | 10 +++++++---
>  4 files changed, 28 insertions(+), 12 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1537450


ab8500_btemp: 'monitored-battery' is a required property
	arch/arm/boot/dts/ste-href520-tvk.dt.yaml
	arch/arm/boot/dts/ste-hrefprev60-stuib.dt.yaml
	arch/arm/boot/dts/ste-hrefprev60-tvk.dt.yaml
	arch/arm/boot/dts/ste-hrefv60plus-stuib.dt.yaml
	arch/arm/boot/dts/ste-hrefv60plus-tvk.dt.yaml
	arch/arm/boot/dts/ste-snowball.dt.yaml
	arch/arm/boot/dts/ste-ux500-samsung-codina.dt.yaml
	arch/arm/boot/dts/ste-ux500-samsung-gavini.dt.yaml
	arch/arm/boot/dts/ste-ux500-samsung-janice.dt.yaml

ab8500_chargalg: 'monitored-battery' is a required property
	arch/arm/boot/dts/ste-href520-tvk.dt.yaml
	arch/arm/boot/dts/ste-hrefprev60-stuib.dt.yaml
	arch/arm/boot/dts/ste-hrefprev60-tvk.dt.yaml
	arch/arm/boot/dts/ste-hrefv60plus-stuib.dt.yaml
	arch/arm/boot/dts/ste-hrefv60plus-tvk.dt.yaml
	arch/arm/boot/dts/ste-snowball.dt.yaml
	arch/arm/boot/dts/ste-ux500-samsung-codina.dt.yaml
	arch/arm/boot/dts/ste-ux500-samsung-gavini.dt.yaml
	arch/arm/boot/dts/ste-ux500-samsung-janice.dt.yaml

ab8500_charger: 'monitored-battery' is a required property
	arch/arm/boot/dts/ste-href520-tvk.dt.yaml
	arch/arm/boot/dts/ste-hrefprev60-stuib.dt.yaml
	arch/arm/boot/dts/ste-hrefprev60-tvk.dt.yaml
	arch/arm/boot/dts/ste-hrefv60plus-stuib.dt.yaml
	arch/arm/boot/dts/ste-hrefv60plus-tvk.dt.yaml
	arch/arm/boot/dts/ste-snowball.dt.yaml
	arch/arm/boot/dts/ste-ux500-samsung-codina.dt.yaml
	arch/arm/boot/dts/ste-ux500-samsung-gavini.dt.yaml
	arch/arm/boot/dts/ste-ux500-samsung-janice.dt.yaml

ab8500_fg: 'monitored-battery' is a required property
	arch/arm/boot/dts/ste-href520-tvk.dt.yaml
	arch/arm/boot/dts/ste-hrefprev60-stuib.dt.yaml
	arch/arm/boot/dts/ste-hrefprev60-tvk.dt.yaml
	arch/arm/boot/dts/ste-hrefv60plus-stuib.dt.yaml
	arch/arm/boot/dts/ste-hrefv60plus-tvk.dt.yaml
	arch/arm/boot/dts/ste-snowball.dt.yaml
	arch/arm/boot/dts/ste-ux500-samsung-codina.dt.yaml
	arch/arm/boot/dts/ste-ux500-samsung-gavini.dt.yaml
	arch/arm/boot/dts/ste-ux500-samsung-janice.dt.yaml

