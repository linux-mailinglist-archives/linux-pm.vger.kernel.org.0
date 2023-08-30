Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF33A78DA9F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjH3Sgo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 30 Aug 2023 14:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245558AbjH3PeG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 11:34:06 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A54E113;
        Wed, 30 Aug 2023 08:34:04 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-56e280cc606so1054141eaf.1;
        Wed, 30 Aug 2023 08:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693409644; x=1694014444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTuqJnQkCwWlyqM/q4fV6JfdUwD1R7rVnKITvD3BSDQ=;
        b=JZJNX/WWp4TSUVutCBWPrhEt5LR6tclVWIAE5FnwZGmrknUKwylo4Lmp1aTkNxh06B
         iuIRUI5g7YxNT5pzLBEMCDQ58umQvj97u17b12Y/p2OWDtCKnTz94hQYhlyieJPOi3Wk
         hO7qV2VCp9fAncq1LXOZBwDBSRQF9AiRDbFshAYojwCt2tsmel4x/r73R1QRa43KMsHG
         1KAjEEKrJbiRxWO1kzDiatm99BpOMGw39d1r2HH+Ec5ABq9DU+ASzqNSIj26cu3zWUFu
         wEfNhvAKx5hZp0HOwbbIaF/rzx53qHtfLUgDhpGpU5YoALCEPswwygF2WO/L15DBb0mb
         90pw==
X-Gm-Message-State: AOJu0Yw5JzSLFOmpbalc1iSg0c5bSJEhuCNTXnCu7a1xxGvKGMSbbL+A
        5qtDwA8jYVzDm6s5GAeSht82IpxVdpgwhzlDK1U=
X-Google-Smtp-Source: AGHT+IGcyQGIr1m9M7sSUZg5KbvnbecJ9tZMaEmiIJOlIexXEfQG+/9lV83EeuZuiumI9twMmPHrVkSAh9nK5b8FqHk=
X-Received: by 2002:a4a:c50d:0:b0:573:3a3b:594b with SMTP id
 i13-20020a4ac50d000000b005733a3b594bmr2596090ooq.1.1693409643867; Wed, 30 Aug
 2023 08:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230829194200.1901988-1-festevam@gmail.com> <CAJZ5v0hZR3WD+wMA6c-Gt86hM5oCRZDcSsYF4SrYTvT2HtQ=fQ@mail.gmail.com>
 <c5d72559-4a97-c865-e51e-855d2bc1edee@linaro.org> <CAJZ5v0gexPEV2M5kfgCEUti=EE+_oR+wUjRboo0Rh=fPfNeDew@mail.gmail.com>
 <edd2bc8ea364959e89ed4c3d2cc11a1e@denx.de>
In-Reply-To: <edd2bc8ea364959e89ed4c3d2cc11a1e@denx.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Aug 2023 17:33:52 +0200
Message-ID: <CAJZ5v0i1H58YPEu7sQdcS2SWXGqv2Q7GNUwje3HiRnb1YNNFAQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: thermal-zones: Document critical-action
To:     Fabio Estevam <festevam@denx.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabio Estevam <festevam@gmail.com>, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Fabio,

On Wed, Aug 30, 2023 at 5:14 PM Fabio Estevam <festevam@denx.de> wrote:
>
> Hi Rafael,
>
> On 30/08/2023 10:54, Rafael J. Wysocki wrote:
>
> > Well, as a matter of fact, it isn't, so I'm not sure where this is
> > going.
> >
> > Bool definitely allows the property to be not present, which means
> > that the default behavior is intended and this is all about overriding
> > a known default behavior.
>
> This devicetree property can be used on non-Linux environments, such as
> bootloaders.
>
> Bootloaders may have different default behavior than Linux, so
> explicitly listing
> "shutdown" or "reboot" make it clearer, independent of the OS.

This property is defined in the Linux kernel source tree and it will
only turn out whether or not any other projects adopt it, so I'm not
really convinced by this argument.

What I'm saying is that from the Linux kernel's POV, the definition is
more complex than it needs to be.

Moreover, to me it merely represents the preference of a system
integrator and so in practice, it can be ignored.
