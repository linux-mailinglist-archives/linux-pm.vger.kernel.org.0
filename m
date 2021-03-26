Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F8734AFD1
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 21:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhCZUH4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 16:07:56 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:44647 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhCZUHv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Mar 2021 16:07:51 -0400
Received: by mail-io1-f44.google.com with SMTP id v26so6622984iox.11;
        Fri, 26 Mar 2021 13:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BbtWtxUcA4nQqDl/UPn+aqKLA2p77nKCFqTscN4h5/k=;
        b=YKaoWdWbX3CtY8JNkmnbZdQ977MGAVlYEiS4shYyupRbeDpsiEDn5I7oDZr9ui4wlP
         9JlAYbVtN1Xd+5shMGnLM+vZDgdozqWwOKMKGjOYxoc0oiQJHtDll5yu4ixintnP9DLs
         dzfSHVkxLS5Uo3N/+rbKAxzmXa9hWBBv1paVkzfxelmSFYp0Kcurupow++dhBQs71AfO
         s7Ioqf4rA8x9qSxD/lenS56fcAq7meuRMSxB+vA+FRRDkmMxA2Z7niYV7x24z1uKr+LW
         AsgiWdfu1EH41F+uOG43ie/3aS/cNtG4wQRopvz7RcnkQdTJsutIRUEuQXiXkk+ggR6f
         JaIw==
X-Gm-Message-State: AOAM530fw7mO1O8MFImxn8Jt9dEtSMFOpV2uAiCAKbg+keuKtvhyuTQI
        TtFD7iQuN54/uvIIuYhuP8ThNFi/OA==
X-Google-Smtp-Source: ABdhPJxkLZewL+HvKGCAaXxRvt+eMKXvcHbXgnT813SdpEA+owGYpMxsBB+s+dACBDurjiqsiv9iOw==
X-Received: by 2002:a02:a809:: with SMTP id f9mr13513022jaj.63.1616789270808;
        Fri, 26 Mar 2021 13:07:50 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k10sm4816688iop.42.2021.03.26.13.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 13:07:49 -0700 (PDT)
Received: (nullmailer pid 3784158 invoked by uid 1000);
        Fri, 26 Mar 2021 20:07:47 -0000
Date:   Fri, 26 Mar 2021 14:07:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Nishanth Menon <nm@ti.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Kevin Hilman <khilman@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        YT Lee <yt.lee@mediatek.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Nicolas Boichat <drinkcat@google.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v14 1/7] dt-bindings: soc: mediatek: add mtk svs
 dt-bindings
Message-ID: <20210326200747.GA3784111@robh.at.kernel.org>
References: <20210325025114.25842-1-roger.lu@mediatek.com>
 <20210325025114.25842-2-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325025114.25842-2-roger.lu@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 25 Mar 2021 10:51:08 +0800, Roger Lu wrote:
> Document the binding for enabling mtk svs on MediaTek SoC.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  .../bindings/soc/mediatek/mtk-svs.yaml        | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
