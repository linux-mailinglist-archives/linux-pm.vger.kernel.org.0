Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9A6248BC5
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 18:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHRQg6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 12:36:58 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45928 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgHRQg4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2020 12:36:56 -0400
Received: by mail-il1-f195.google.com with SMTP id k4so18155592ilr.12;
        Tue, 18 Aug 2020 09:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gl6XS4qfTxmDXNCXwNlbRvktsoiefhKSAFrgJZHSqYw=;
        b=Q43fn4+uE/fNehYCY0UN5oK70Yal3P43gTjFCqgZBeRV2FfPWPArdbeXYQySGPS/dz
         osMEGzobSEqSsZbudLOXkK5NPH3Zs+sdH1DYBKaK99BvfLX6BqcVZ4C+KqJBldfc2DvA
         9CGK2rGIgYYxjjUy8JXtow46ce9mE/FQcG0zfNiGdoXOxTABiJ4V9pZY8etLgn3f7ZZz
         5mXw3+zAXKHVT3O3nLj24yXnu6Y1z3QiTFa3syy18OwKrzSC+BoY81AtJk8cKJGkaTLN
         g2H+XXtnVU8Fz/VUYI/2OFNtIG+sqKlEhkPJrkEJPj4IVRZNnjHKqQxVFIJyS/5ZUlZ5
         XVCw==
X-Gm-Message-State: AOAM533sB3nfHua0L61zbzqM1qtSXd2smy/pkNjimwszihv3pqHysdc/
        JW9aKF2ruy7XnhEmySq08w==
X-Google-Smtp-Source: ABdhPJzJ2p5fY3FMzkqhU6ooYSUD+BBzc6VBbwlA10dpndvE9pEmDfl71ZZPTxN6zqYd1aoufnDppA==
X-Received: by 2002:a92:9996:: with SMTP id t22mr18129341ilk.216.1597768614776;
        Tue, 18 Aug 2020 09:36:54 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id c76sm12155039ill.63.2020.08.18.09.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 09:36:54 -0700 (PDT)
Received: (nullmailer pid 3587582 invoked by uid 1000);
        Tue, 18 Aug 2020 16:36:53 -0000
Date:   Tue, 18 Aug 2020 10:36:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     linux-pm@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, sre@kernel.org,
        devicetree@vger.kernel.org, dmurphy@ti.com
Subject: Re: [PATCH v1 1/2] dt-bindings: power: Add the bq256xx dt bindings
Message-ID: <20200818163653.GA3586878@bogus>
References: <20200817191723.22416-1-r-rivera-matos@ti.com>
 <20200817191723.22416-2-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817191723.22416-2-r-rivera-matos@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 17 Aug 2020 14:17:22 -0500, Ricardo Rivera-Matos wrote:
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
>  .../bindings/power/supply/bq256xx.yaml        | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/bq256xx.example.dt.yaml: battery: 'termination-current-microamp' does not match any of the regexes: '^ocv-capacity-table-[0-9]+$', 'pinctrl-[0-9]+'


See https://patchwork.ozlabs.org/patch/1346479

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

