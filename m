Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3745E1F427D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 19:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbgFIRgk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 13:36:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37756 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbgFIRgj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 13:36:39 -0400
Received: by mail-io1-f65.google.com with SMTP id r2so23753371ioo.4;
        Tue, 09 Jun 2020 10:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7dNnoZ1rdnzksidSAoSZhnIgLkiZGWEcPmE8xec0a/I=;
        b=RNQoZ+05QeNbX1nMCf5ioAf37nvivHz6QAPZ13BV9WOxXOH456+AiD6Ny1a2MuHlcE
         +mh5FDbbEh3HsC+dTuLQB3crBDaIGRdQsX6ZN9WUhUeE7ZMEwWS+SykkcAdI3nqCQ4tj
         LuB/yGpozRGI6CmbW3ElUaw3euR48mhWCsmLGgYBu/HCIrQpewmssFNZUhrmJwMy+meQ
         Q+bc7p0llUhejYpA0K1tg0ScO/dgQKKBxHiYfvvg/Vd/EP/rmpHsO9Yty8bwxE10D8q9
         ZksT8PVyHMZLcPEp3hKhpKf40b89WYJbZrXCosZB9leI7uxbSkjiqCD0R4ROTrocoHk9
         XfMw==
X-Gm-Message-State: AOAM53046Ub2DrsjTnSofjqEFnHgNJajwK8V/xhqL9x/0vZsaV0s0fbG
        /CmFWO5kGBdKih9bGjYL3g==
X-Google-Smtp-Source: ABdhPJx/yiiBlNgsHUuSZP9/9xQBsqT57J3LHhF0CAayD6QmiM8GHdAZbeyCcaqsGh0uWxqQeNNQvg==
X-Received: by 2002:a02:a78e:: with SMTP id e14mr28221151jaj.9.1591724198380;
        Tue, 09 Jun 2020 10:36:38 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y5sm8056179iov.3.2020.06.09.10.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 10:36:37 -0700 (PDT)
Received: (nullmailer pid 1126603 invoked by uid 1000);
        Tue, 09 Jun 2020 17:36:36 -0000
Date:   Tue, 9 Jun 2020 11:36:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     linux-pm@vger.kernel.org, Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Fan Chen <fan.chen@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>,
        YT Lee <yt.lee@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Angus Lin <Angus.Lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v9 1/4] dt-bindings: power: avs: add mtk svs dt-bindings
Message-ID: <20200609173636.GA1125574@bogus>
References: <20200609104534.29314-1-roger.lu@mediatek.com>
 <20200609104534.29314-2-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609104534.29314-2-roger.lu@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 09 Jun 2020 18:45:31 +0800, Roger Lu wrote:
> Document the binding for enabling mtk svs on MediaTek SoC.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  .../bindings/power/avs/mtk_svs.yaml           | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/avs/mtk_svs.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/power/avs/mtk_svs.example.dts:22:18: fatal error: dt-bindings/power/mt8183-power.h: No such file or directory
         #include <dt-bindings/power/mt8183-power.h>
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
scripts/Makefile.lib:312: recipe for target 'Documentation/devicetree/bindings/power/avs/mtk_svs.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/power/avs/mtk_svs.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1305800

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

