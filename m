Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D82EFD7A
	for <lists+linux-pm@lfdr.de>; Sat,  9 Jan 2021 04:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbhAIDbG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 22:31:06 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:32895 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbhAIDbG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2021 22:31:06 -0500
Received: by mail-io1-f54.google.com with SMTP id w18so11943079iot.0;
        Fri, 08 Jan 2021 19:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=+H9IDqbsovueL7letf+rLIIMkhg3UJszYGBQf9zPSuw=;
        b=gDylqsXXdUlvY8FbklHOEf4kcSl/fsssO5r5G2Ln+MrVOALO4CxO4ogMSoE883jSvj
         MK59WKKVx6FD0VpPjCI49T6CgywY98OcbCv3s1/xcy+q+vxdGzKJFgneAqZ/c3QBrkhA
         L02SKfbFAo86bvvGdKWCj4IYAfwL8g/Ko4N4i/EpXMkyviBwZiwl1QcrXICC2+VqDwl0
         KMo1t15+8jPnTrFZtmzhp5FCFRIVTL19Bp3VoFzLleBcP4DIDvkfEtABhq+4ELbzL9jZ
         grlkNnIC5ddVvNq+tWKlFt/EZGZ2YwKwVAetBgKuLXTwWZZSlJT0LLZoKkkufFy44Z+X
         PK0A==
X-Gm-Message-State: AOAM532vz+5JIX8xSCzF+7f0cKONX4QtEQs5jPKjdf8NPdbBlPRqgaKl
        X/DAuz+PQWvu2tV1IVyXag==
X-Google-Smtp-Source: ABdhPJzHiKwMJh0PaWVNXYntY88PZcUJt9OHYgJ2VMnnb/yu1svmesnqnx+wFRaZo7igVW9Tfy+cvQ==
X-Received: by 2002:a5d:970c:: with SMTP id h12mr7705459iol.103.1610163025502;
        Fri, 08 Jan 2021 19:30:25 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z4sm6482374ioh.32.2021.01.08.19.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 19:30:24 -0800 (PST)
Received: (nullmailer pid 3762038 invoked by uid 1000);
        Sat, 09 Jan 2021 03:30:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org, Ryan Case <ryandcase@chromium.org>,
        Arvin Wang <arvin.wang@mediatek.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <1610092095-5113-2-git-send-email-henryc.chen@mediatek.com>
References: <1610092095-5113-1-git-send-email-henryc.chen@mediatek.com> <1610092095-5113-2-git-send-email-henryc.chen@mediatek.com>
Subject: Re: [PATCH V7 01/13] dt-bindings: soc: Add dvfsrc driver bindings
Date:   Fri, 08 Jan 2021 20:30:19 -0700
Message-Id: <1610163019.789930.3762037.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 08 Jan 2021 15:48:03 +0800, Henry Chen wrote:
> Document the binding for enabling dvfsrc on MediaTek SoC.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/dvfsrc.yaml   | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/mediatek/dvfsrc.example.dts:19:18: fatal error: dt-bindings/interconnect/mtk,mt8183-emi.h: No such file or directory
   19 |         #include <dt-bindings/interconnect/mtk,mt8183-emi.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:344: Documentation/devicetree/bindings/soc/mediatek/dvfsrc.example.dt.yaml] Error 1
make: *** [Makefile:1370: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1423679

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

