Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154983EF726
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 03:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhHRBHs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 21:07:48 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:36791 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbhHRBHm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 21:07:42 -0400
Received: by mail-oo1-f54.google.com with SMTP id z3-20020a4a98430000b029025f4693434bso217386ooi.3;
        Tue, 17 Aug 2021 18:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h5q8VzIWAFVz/l5dP+7x5gcn5xuv5tl7Qar3LU6BUB8=;
        b=IaTRp4Wit7OV+7r5q4a5la9uJanA1zFEgtzM6h0oxuNvtfqGjR+4LPrcHLcmWtrAaU
         EGAunyckZON8+/dKQRV1Yb40j0Y08TDsx6ngpMK/kIYHlBlNhmxZfm6rCgbV/3P8E49S
         AGT9luL1QIdIgTyDXWUKYg2nu3S1t+G5CxS4cv+ft4WVGjgS0HBX8+oMBLuq1ZLMwoJQ
         65ex2gegtqQp/nJad+j5ie4QK6wE8h6U36dNZ5PzL5o4JQmH0CeWF48ejyWejqeTzbIH
         4+oCSIWbDohcqexR+YHuexuv7OqMYv9jk3cI88gjkl58DOQZfi0GFKVUuop9vHcKIqyK
         Zv/A==
X-Gm-Message-State: AOAM530pER8alpbFjoXuZ0WMkUliqdsNhB9C5wOR7BjMZM1Mo5i/o60k
        pjry70JblbQB5YeS0RVoLNH+Ogz2yA==
X-Google-Smtp-Source: ABdhPJzIPH42GWVxKeO7jdVek/5WPtkXW3uDVYvdwtDdzpUjulmiYbSAP1qL3dVSUN/o2H5a4ZbnjA==
X-Received: by 2002:a4a:dfac:: with SMTP id k12mr4668702ook.41.1629248828736;
        Tue, 17 Aug 2021 18:07:08 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n130sm654964oif.32.2021.08.17.18.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 18:07:08 -0700 (PDT)
Received: (nullmailer pid 1164082 invoked by uid 1000);
        Wed, 18 Aug 2021 01:07:07 -0000
Date:   Tue, 17 Aug 2021 20:07:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        matthias.bgg@gmail.com, ben.tseng@mediatek.com,
        michael.kao@mediatek.com, ethan.chang@mediatek.com,
        fparent@baylibre.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add binding document for
 mt8195 thermal controller
Message-ID: <YRxdO9upQxib5Tcb@robh.at.kernel.org>
References: <20210816164307.557315-1-abailon@baylibre.com>
 <20210816164307.557315-2-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816164307.557315-2-abailon@baylibre.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 16, 2021 at 06:43:05PM +0200, Alexandre Bailon wrote:
> This patch adds binding document for mt8195 thermal controller.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  .../devicetree/bindings/thermal/mediatek-thermal-lvts.yaml  | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> index 69ffe7b14c212..2e1ae00d4fd18 100644
> --- a/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> @@ -12,7 +12,11 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: mediatek,mt6873-lvts
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt6873-lvts
> +              - mediatek,mt8195-lvts

You don't need 'oneOf' when only one clause. Just changing the const to 
enum is enough. 

Rob
