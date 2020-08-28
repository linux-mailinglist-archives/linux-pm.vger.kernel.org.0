Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9C8256293
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 23:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgH1Vlc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 17:41:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42754 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgH1Vlb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 17:41:31 -0400
Received: by mail-io1-f66.google.com with SMTP id g13so497278ioo.9;
        Fri, 28 Aug 2020 14:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d/272Ge9F+h939RcGifK+OjeQK+BeVfrxyuLoTuNL9w=;
        b=BJDDM9iJFaFAgrhASeUxSxQD6Vy6zmqTxA05HGRbgSPm78AxjhsDzYE0QHmgZNF9GY
         VQW6zhoCmpynluVZj5cUaFQXNWc1Gg2pX5c5n1xyzfTKq2P+H2aiaQTLvxbeAH8OdEKP
         ALbjt2LI2QrctkeuH7dfoaT7h7mQYhDwGQVNUmimQ27scJ5i3HNqNpz4+VvZTZua+gkl
         /Wi6CZVQugLg+NJha3V4Dy2wwnJBJwHfEn7Y5zztKbQQKDB50lp5iuVfqTQS1c/H90Jd
         sO6zWgnlNPnYjQZywJb8Wjx3ppgBZJbtB/pPg0eDEx72PvDPOkpi3/791zWpmUR5XJRn
         lVCg==
X-Gm-Message-State: AOAM533S+WSnZr446GDyYLsaTqmUdCeinnrXMw/ukmi/Hcbzj1m/7PWm
        TwRjExXTeQ/LYU9wuQAwxja0kLkOG0Eg
X-Google-Smtp-Source: ABdhPJyHlTGuXiCcZmcVqwDVyL9Vhx+k1VLxvQ69KwJSEwIlfx8NYYd5PsezubKDxVh/gRFnzeSRbg==
X-Received: by 2002:a02:820b:: with SMTP id o11mr2979024jag.136.1598650890419;
        Fri, 28 Aug 2020 14:41:30 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id c12sm276839ilq.79.2020.08.28.14.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 14:41:29 -0700 (PDT)
Received: (nullmailer pid 3449714 invoked by uid 1000);
        Fri, 28 Aug 2020 21:41:27 -0000
Date:   Fri, 28 Aug 2020 15:41:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        sre@kernel.org, dmurphy@ti.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: power: Add the bq256xx dt bindings
Message-ID: <20200828214127.GA3449324@bogus>
References: <20200828195219.15560-1-r-rivera-matos@ti.com>
 <20200828195219.15560-2-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828195219.15560-2-r-rivera-matos@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 28 Aug 2020 14:52:18 -0500, Ricardo Rivera-Matos wrote:
> Add the bindings for the bq256xx series of battery charging ICs.
> 
> Datasheets:
> - https://www.ti.com/lit/ds/symlink/bq25600.pdf
> - https://www.ti.com/lit/ds/symlink/bq25601.pdf
> - https://www.ti.com/lit/ds/symlink/bq25600d.pdf
> - https://www.ti.com/lit/ds/symlink/bq25601d.pdf
> - https://www.ti.com/lit/ds/symlink/bq25611d.pdf
> - https://www.ti.com/lit/ds/symlink/bq25618.pdf
> - https://www.ti.com/lit/ds/symlink/bq25619.pdf
> 
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> ---
>  .../bindings/power/supply/bq256xx.yaml        | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/bq256xx.example.dt.yaml: battery: 'termination-current-microamp' does not match any of the regexes: '^ocv-capacity-table-[0-9]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/battery.yaml


See https://patchwork.ozlabs.org/patch/1353535

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

