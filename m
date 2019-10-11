Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7C64D4359
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfJKOsP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 10:48:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37773 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfJKOsP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Oct 2019 10:48:15 -0400
Received: by mail-ot1-f66.google.com with SMTP id k32so8181656otc.4;
        Fri, 11 Oct 2019 07:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9kELu6s8Xez72s7yjDEZd7hwsCCJDY4gV2VlEWP54QM=;
        b=A1Omp0uwnI0AOwdEtOWKSx2b/m3irUctzOB+KNmI+BpLLDwsjBsXAAoO10lEF3RoeI
         K1fWe0+CR7cCbhU+W9B38osApHFaPxAn2QM0PgbYmCB9Nz+Yxm4Scot09XlhC07B1esF
         yxa6HcvvjJQNNhAjpYok7vnhHs0f4MqlEe/HS9MlC/bb/gj8qos40j80z5Wrd2zg2brz
         ZlNbynBuZWvCHQ2ngWqTp3XLeLwSPLFin3MyLbuN8uaBKJ5iqbW1N9c2z9gFb+Dwd9Gh
         1toC+3VGRw3PDpCV1QfPKDWyV0UZfLvdfFAO8rSR1A1oP5OSJZqu/hG9OuvnZ1HlAHvm
         Xgig==
X-Gm-Message-State: APjAAAVtup4jNyNKXEPgpTB8/EwfD3+xmianbBDKblgs0I/zAJ6S3dAs
        YhOWzZ53pd12YJG6xmnwQw==
X-Google-Smtp-Source: APXvYqxWiF9mlWpmhF4F7i28hJLZ1dDoTA6YcBMy+P+DctntpvAmW5FA4W9ZKMX5tPkbxHvi4IwDcw==
X-Received: by 2002:a9d:6084:: with SMTP id m4mr11834429otj.18.1570805293419;
        Fri, 11 Oct 2019 07:48:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o184sm2694641oia.28.2019.10.11.07.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:48:12 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:48:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jamie Lentin <jm@lentin.co.uk>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: power: reset: gpio-poweroff: Add
 'force-mode' property
Message-ID: <20191011144812.GA7239@bogus>
References: <20190930141244.12311-1-oleksandr.suvorov@toradex.com>
 <20190930141244.12311-3-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930141244.12311-3-oleksandr.suvorov@toradex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 30, 2019 at 02:12:53PM +0000, Oleksandr Suvorov wrote:
> Add 'force-mode' property to allow the driver to load even if
> someone has registered the pm_power_off hook earlier.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> 
> ---
> 
> Changes in v2: None
> 
>  .../devicetree/bindings/power/reset/gpio-poweroff.txt          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> index 3e56c1b34a4c..2056e299a472 100644
> --- a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> +++ b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> @@ -31,6 +31,9 @@ Optional properties:
>  - inactive-delay-ms: Delay (default 100) to wait after driving gpio inactive
>  - timeout-ms: Time to wait before asserting a WARN_ON(1). If nothing is
>                specified, 3000 ms is used.
> +- force-mode: Force replacing pm_power_off kernel hook.
> +  If this optional property is not specified, the driver will fail to
> +  load if someone has registered the pm_power_off hook earlier.

What if the init order changes?

This is too tied to a specific OS implementation to go in DT.

Rob
