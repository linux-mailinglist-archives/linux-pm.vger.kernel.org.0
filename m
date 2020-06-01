Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A76C1EA72F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 17:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgFAPjt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 11:39:49 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43894 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgFAPjt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 11:39:49 -0400
Received: by mail-il1-f193.google.com with SMTP id g3so4134080ilq.10;
        Mon, 01 Jun 2020 08:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uQctr68w1T+JTZAiD2c189KGkqvpCSkASHtFDFD6kPg=;
        b=Z3R2bezFqI2zblT0hvR2iN/SAn4vvdRr1sM4sLdHWgotFmJHG0MvRxBtuL/BgaK/Bq
         0HWZ6w6AGgw0GhSGMsVJZxK3LLK6dkiFBJDq5gwHgPpGIM80WClHpUnMFnkhuDwD/Mf4
         qEqC5uxdlc4QaZFXSNWqIEQA3s/2Ze7DkTsiLthql7mjDUrZoctl35M5NUaF/HGw3JvZ
         H/wFpbacuihzTCHHT+l1r5Uv8D96meSIurM95UCUPnbKWlsG/zxWizFwHI6PW7yE5IYk
         wgCFqGuymqgsGU513VejvdZlvSyBsyhLgcaZB6v6/ZhAP2bE1Fd3ii925601WgZ7ejae
         CsNA==
X-Gm-Message-State: AOAM533LycHvg7phX2iVBnVWZZSfrmcbQOAf7WApCOZJHsYlXYvg4JdS
        EpVAM31aBjvW9iPqvSpwBw==
X-Google-Smtp-Source: ABdhPJyL0RNRyJqXpG0jaebbTt8fpUOr4WWt/IQwice5HIAdlQ60OU/5kgVflkd780N0uyqkaOu91w==
X-Received: by 2002:a92:2a06:: with SMTP id r6mr20868440ile.121.1591025988250;
        Mon, 01 Jun 2020 08:39:48 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id n12sm7452990iog.25.2020.06.01.08.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 08:39:47 -0700 (PDT)
Received: (nullmailer pid 957363 invoked by uid 1000);
        Mon, 01 Jun 2020 15:39:46 -0000
Date:   Mon, 1 Jun 2020 09:39:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-kernel@vger.kernel.org,
        hongtao.jia@freescale.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2] dt-bindings: thermal: Convert qoriq to json-schema
Message-ID: <20200601153946.GA957310@bogus>
References: <1590982520-5437-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590982520-5437-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 01 Jun 2020 11:35:20 +0800, Anson Huang wrote:
> Convert the qoriq thermal binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- add 'maxItems' for 'fsl,tmu-range' property;
> 	- add 'minItems'/'maxItems' and items descriptions for 'fsl,tmu-calibration' property;
> 	- remove description for common property '#thermal-sensor-cells';
> 	- refine 'fsl,tmu-calibration' format in example.
> ---
>  .../devicetree/bindings/thermal/qoriq-thermal.txt  |  71 -------------
>  .../devicetree/bindings/thermal/qoriq-thermal.yaml | 112 +++++++++++++++++++++
>  2 files changed, 112 insertions(+), 71 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> 

Applied, thanks!
