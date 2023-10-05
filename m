Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE977BA556
	for <lists+linux-pm@lfdr.de>; Thu,  5 Oct 2023 18:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbjJEQP7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Oct 2023 12:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241485AbjJEQO2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Oct 2023 12:14:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD0A65BE
        for <linux-pm@vger.kernel.org>; Wed,  4 Oct 2023 23:22:16 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso5083245e9.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Oct 2023 23:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696486934; x=1697091734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HCYFX8DqNzwL6GYU1rfcPUGS3N4C41iYiCIn75uvSfk=;
        b=kGfxNzObiXR1w/Cwpgnle0zcPHoGCpDi4NX+CI7b44fx4wLbaSk9zxWhWBXVHAkPdv
         /OLw+DA/dGUp/pmcUf4HOyN8u9XkR2W+f4w0OeKaSVwAo9eOh91nuaGk8TGr0cnU9T3A
         rX028sPlHtvtYsr2pxS0jwhREQHvR8zKPw8UZdcwb13wbNOVrYc3JeSUo57a+cimnrk1
         u+pu4vLgO9Z+e50S3EBBp/NLi/rGQkvk/vUEyivsUIZ6+mQnGkV+kLpwrlWm5Y2bxfpN
         e2tGXrA79Ct3rokDryeq1SpQ7nee8PA2qPsoIsAanLpSwZPM8k4VmhhIusxutNEa4E02
         oWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696486934; x=1697091734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCYFX8DqNzwL6GYU1rfcPUGS3N4C41iYiCIn75uvSfk=;
        b=qoL1t/oA1CmYftXx4wKAtbxB/ie0aqm1r6egxKpxhDW1ocdFDyrqllJf4KSt80wh8v
         BPZdoRhst5siV4bNsJxbULhGN0PULEd2mDBwNC+IWIvmR5yoI7+1cUlkvhjTr86h05NU
         OqEofWycqWCNqRXQskQn3ga+tcf88A1s5iJwnfJ6nTQ/xtrQleOD43axS4dcJEGMPvuK
         /TISHqSizMqiCKWLmQ+n4RX5sbgVReC6Ak/ybWruRsEVs1FNq7uUbB67HO3b3UEXaqSF
         k3Sn8dCvfSXNHob1tPq8fHnltfKLi5zI74uf8//yYIbgM2DfZmYw214rR44h7yuWM+5w
         gTWg==
X-Gm-Message-State: AOJu0YwoFY2+F1pORYWKq+2U7NI1wfKM0kRj0KUlcv8vFU/7Z0SRbFaz
        53XTE4YHeHu6vCsm4YaF9kxM4w==
X-Google-Smtp-Source: AGHT+IGWRD93uyqouYy7cDYKEdj+YgCmxQ/c3dT08yZKwt4jO5D/UibpzgDbKf1/XmbUczotJUREvw==
X-Received: by 2002:a1c:6a0d:0:b0:3fc:1a6:7764 with SMTP id f13-20020a1c6a0d000000b003fc01a67764mr4004459wmc.16.1696486934337;
        Wed, 04 Oct 2023 23:22:14 -0700 (PDT)
Received: from blmsp ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id k22-20020a7bc416000000b00404719b05b5sm744928wmi.27.2023.10.04.23.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 23:22:13 -0700 (PDT)
Date:   Thu, 5 Oct 2023 08:22:12 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 0/8] soc: mediatek: MT8365 power support
Message-ID: <20231005062212.dpkscqq27exdnssm@blmsp>
References: <20230918093751.1188668-1-msp@baylibre.com>
 <CAPDyKFrUbWBQgMm6wYwFfybiRQKhBpwH7wwcXaT+KrQJLevq3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFrUbWBQgMm6wYwFfybiRQKhBpwH7wwcXaT+KrQJLevq3w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thu, Oct 05, 2023 at 12:09:06AM +0200, Ulf Hansson wrote:
> On Mon, 18 Sept 2023 at 11:38, Markus Schneider-Pargmann
> <msp@baylibre.com> wrote:
> >
> > Hi,
> >
> > no real changes in this update. Rebase to v6.6-rc2 and according change
> > of directory.
> >
> > Thanks for any feedback!
> >
> > Best,
> > Markus
> >
> > Based on v6.6-rc2
> >
> > Changes in v8:
> > - Rebased to v6.6-rc2
> > - Moved changes from drivers/soc to drivers/pmdomain
> >
> > Changes in v7:
> > - Rebased to v6.5-rc1
> > - Fixed a couple of small style issues pointed out by Angelo
> >
> > Changes in v6:
> > - Change flags field to be u8 instead of u32
> > - Use macro concatenation to simplify BUS_PROT macros:
> >   BUS_PROT_WR(_hwip, ...) etc.
> > - Use the final bit values for scpsys_bus_prot_flags from the beginning
> >   of the series.
> > - Changed scpsys_domain_data->caps to be u16 to accommodate the new flag
> >   MTK_SCPD_STRICT_BUS_PROTECTION.
> >
> > Changes in v5:
> > - Create defines for all registers and bits in mt8365 power domain patch
> > - Redesign scpsys_bus_prot_data to use flags to store reg_update,
> >   clr_ack as well as the difference between SMI and INFRACFG. The code
> >   uses the appropriate regmap depending on the flags.
> > - The WAY_EN patch now uses two flags, one for inverted operations
> >   'BUS_PROT_INVERTED' and one to use infracfg-nao for the status flags
> >   'BUS_PROT_STA_COMPONENT_INFRA_NAO'.
> >
> > Changes in v4:
> > - Redesigned WAY_EN patch and split it up in smaller patches.
> > - Added two documentation patches.
> > - Added mediatek,infracfg-nao field to the binding.
> >
> > Changes in v3:
> > - Mainly redesigned WAY_EN patch to be easier to understand
> > - Rebased onto v6.0-rc1
> > - Several other stuff that is described in the individual patches
> >
> > Changes in v2:
> > - Updated error handling path for scpsys_power_on()
> > - Minor updates described in each patch
> >
> > Previous versions:
> > v1 - https://lore.kernel.org/linux-mediatek/20220530204214.913251-1-fparent@baylibre.com/
> > v2 - https://lore.kernel.org/linux-mediatek/20220725081853.1636444-1-msp@baylibre.com/
> > v3 - https://lore.kernel.org/linux-mediatek/20220822144303.3438467-1-msp@baylibre.com/
> > v4 - https://lore.kernel.org/linux-arm-kernel/20230105170735.1637416-1-msp@baylibre.com/
> > v5 - https://lore.kernel.org/linux-arm-kernel/20230619085344.2885311-1-msp@baylibre.com/
> > v6 - https://lore.kernel.org/linux-arm-kernel/20230627131040.3418538-1-msp@baylibre.com/
> > v7 - https://lore.kernel.org/linux-arm-kernel/20230713150414.891893-1-msp@baylibre.com
> >
> > Alexandre Bailon (2):
> >   soc: mediatek: Add support for WAY_EN operations
> >   soc: mediatek: Add support for MTK_SCPD_STRICT_BUS_PROTECTION cap
> >
> > Fabien Parent (2):
> >   dt-bindings: power: Add MT8365 power domains
> >   soc: mediatek: pm-domains: Add support for MT8365
> >
> > Markus Schneider-Pargmann (4):
> >   soc: mediatek: pm-domains: Move bools to a flags field
> >   soc: mediatek: pm-domains: Split bus_prot_mask
> >   soc: mediatek: pm-domains: Create bus protection operation functions
> >   soc: mediatek: pm-domains: Unify configuration for infracfg and smi
> >
> >  .../power/mediatek,power-controller.yaml      |   6 +
> >  drivers/pmdomain/mediatek/mt6795-pm-domains.h |  16 +-
> >  drivers/pmdomain/mediatek/mt8167-pm-domains.h |  20 +-
> >  drivers/pmdomain/mediatek/mt8173-pm-domains.h |  16 +-
> >  drivers/pmdomain/mediatek/mt8183-pm-domains.h | 125 ++++++----
> >  drivers/pmdomain/mediatek/mt8186-pm-domains.h | 236 ++++++++++--------
> >  drivers/pmdomain/mediatek/mt8188-pm-domains.h | 223 +++++++++++------
> >  drivers/pmdomain/mediatek/mt8192-pm-domains.h | 112 ++++++---
> >  drivers/pmdomain/mediatek/mt8195-pm-domains.h | 199 +++++++++------
> >  drivers/pmdomain/mediatek/mt8365-pm-domains.h | 197 +++++++++++++++
> >  drivers/pmdomain/mediatek/mtk-pm-domains.c    | 157 ++++++++----
> >  drivers/pmdomain/mediatek/mtk-pm-domains.h    |  51 ++--
> >  .../dt-bindings/power/mediatek,mt8365-power.h |  19 ++
> >  include/linux/soc/mediatek/infracfg.h         |  41 +++
> >  14 files changed, 972 insertions(+), 446 deletions(-)
> >  create mode 100644 drivers/pmdomain/mediatek/mt8365-pm-domains.h
> >  create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h
> >
> 
> Applied for next, thanks!
> 
> Note that while applying I amended the patch-prefix for patch 2->8 to
> "pmdomain: mediatek:", please try to conform to this when going
> forward, as it help me to better filter emails.

Thank you! Sorry, I will use that prefix in the future.

Best,
Markus

> 
> Kind regards
> Uffe
