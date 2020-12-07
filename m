Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A4C2D1719
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 18:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgLGREg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 12:04:36 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35842 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGREg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 12:04:36 -0500
Received: by mail-oi1-f194.google.com with SMTP id x16so16168591oic.3;
        Mon, 07 Dec 2020 09:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=19119qT55jo1E4qrWnIhabF5L38EkieKkqJe7d3pVh4=;
        b=h6XDpKm0p1bCQ89j4bVamFTzcD2zQoq332clhIM+R8wHIA9GNodsalF/wgOUBzhjJS
         k2mLONLUCBCvgy7WaWrCWQ++gHmFqBmyGNKtsDpZx9V8axx76fLCKUc65r1QLC1QKB/q
         RO9eIXH0zXfAvMNDP7RSQnRjnEuntt1zjNUwS3xKKvloNsY5sPO+9KmIq2EqLbQ0sVZa
         9UkTdg8n5/A4AQfs5g3+QnmMj0cIvcKLJnKFdGGMWMTaKF6jxPg3G4m67AOnY3XUZ7NC
         wQU1ZENAI7UJoJnggKbiqtaImp/ISYsSsarVsq2cFBp18j0LW4aZBd26QPEbYjmx4skd
         aQ4A==
X-Gm-Message-State: AOAM532FfXhn7msFSK0JnEgTRHbxHnNN3UcD2kvOYq0s95/0QxQxCrnf
        b4aeTH2M+U8oRSJ8ugvKfQ==
X-Google-Smtp-Source: ABdhPJyBNmiiAD7WrCmET03nS+b6iaipwxbjuAnKKBQf6mUm+C30OUOrc++vnzrLL/+G5RhWs05D6Q==
X-Received: by 2002:aca:5711:: with SMTP id l17mr6127842oib.53.1607360635005;
        Mon, 07 Dec 2020 09:03:55 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m81sm3037226oib.37.2020.12.07.09.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 09:03:54 -0800 (PST)
Received: (nullmailer pid 439974 invoked by uid 1000);
        Mon, 07 Dec 2020 17:03:52 -0000
Date:   Mon, 7 Dec 2020 11:03:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        hsinyi@chromium.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        ethan.chang@mediatek.com, Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: thermal: Add binding document for
 mt6873 thermal controller
Message-ID: <20201207170352.GA439416@robh.at.kernel.org>
References: <20201207063127.28051-1-michael.kao@mediatek.com>
 <20201207063127.28051-4-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207063127.28051-4-michael.kao@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 07 Dec 2020 14:31:27 +0800, Michael Kao wrote:
> This patch adds binding document for mt6873 thermal controller.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  .../thermal/mediatek-thermal-lvts.yaml        | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.example.dts:21:18: fatal error: dt-bindings/clock/mt8192-clk.h: No such file or directory
   21 |         #include <dt-bindings/clock/mt8192-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1411898

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

