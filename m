Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F263DE117
	for <lists+linux-pm@lfdr.de>; Mon,  2 Aug 2021 22:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhHBUzc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Aug 2021 16:55:32 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:38739 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhHBUza (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Aug 2021 16:55:30 -0400
Received: by mail-io1-f47.google.com with SMTP id a13so21869708iol.5;
        Mon, 02 Aug 2021 13:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r7U2Fn9aSaP73iCpK58HL51gM1ciJiUa1RmwUXpa2Gg=;
        b=MM8RZ8l/Pz5sFLZsRIJGCc9eR1dCZjT0Y401Qr4UrRvZhVVFVOLGcph214bNYulfIz
         H5JF+28FZpO8tKb6iXFqM/BrhATWhP0v0O3DEyZf+irmtwr5kvfK0N2M1ozdE1+/jmIV
         SaN1kDUgACH/NvzWA+A9SCHeHlp4zVDOpuiFojhmKaLMLNWKNm8rtO9KODCUcW4ZTKLP
         A8yras1W7GWRFbPy6rtf+Mc/49UUcpw/NbliL/j7oiihwRBMWXhuwz3usYf4woVLiNBI
         r0Kg0olsvZ+k+pkr8sQpZjEGukGBvfe+qvq5uW8eG3zr9rVPrFEJ5rO1MSOtCrrErPlo
         8lJA==
X-Gm-Message-State: AOAM530RD8JYA99/r7d8+JsiYY2Iw4yu04HhC0YtqswvSb6Q1D/VhB5l
        E4hOvNxu2NnYswhze/w5JNXvVOlXPQ==
X-Google-Smtp-Source: ABdhPJwnZKWQL89fN7XA+xyAnjPiPLdOWB6RWa0kky0nnxSkRj6W9YD384b+VsomenGthtS2cEEmeg==
X-Received: by 2002:a5e:8519:: with SMTP id i25mr933749ioj.152.1627937719397;
        Mon, 02 Aug 2021 13:55:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z6sm6327730ilz.54.2021.08.02.13.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 13:55:18 -0700 (PDT)
Received: (nullmailer pid 1593721 invoked by uid 1000);
        Mon, 02 Aug 2021 20:55:17 -0000
Date:   Mon, 2 Aug 2021 14:55:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: max17042: Document
 max77849-battery
Message-ID: <YQhbtcPZ/WrDil4r@robh.at.kernel.org>
References: <20210727170345.115004-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727170345.115004-1-nikita@trvn.ru>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 27 Jul 2021 22:03:44 +0500, Nikita Travkin wrote:
> max77849 is a combined fuel-gauge, charger and MUIC device. Add it to
> the bindings documentation.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  .../devicetree/bindings/power/supply/maxim,max17042.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
