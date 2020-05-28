Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5691E62EC
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 15:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390615AbgE1NxT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 09:53:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42564 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390605AbgE1NxP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 09:53:15 -0400
Received: by mail-io1-f68.google.com with SMTP id d5so20518906ios.9;
        Thu, 28 May 2020 06:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ieGt96JN2xk1TOCoMTNWk75fkEMxKG58KHD7sTOPT/8=;
        b=Az4x/+zJt5jNmLXgD/ItBVMeY+4seAUmClARv+Xhf2fLclf7eLRlg8aMDbH/hjsG/a
         m+5iYfA7m2LYNkPyxGXFBLAxDNkkyAKHathH5Yahgg2SL0thhkjmymv+E5jOQZzFlG35
         9uPyMePTSJKk/VEWv77GBcUuIb92ISdzdhHfqGrYzBQlOr6p+VCZB0AXY/oBFy4sBKN4
         h79+3gWTaGojoNZHjmBH2jZRLkk2L+O5ChZPgFyuMAbupVHIjZ8WvV6El37cnHz8XQnE
         hgijH8KHPynIKCZTo3aOQ9eZ8IW7lP19kULsjDLyPhJqYkCH0qrC75YKojHQoU4Gn07z
         Rs5w==
X-Gm-Message-State: AOAM530brOa0AtMXa2S8BKj0V2fnzRZ71ILv6zuZB7zRy/sV1DvNxOK+
        T88HmCWeRKB/ngsmVHY7/Q==
X-Google-Smtp-Source: ABdhPJzclyEODFLn0tQ20KW9iwr5ozig07HeYHOTUhqj9NGRtRSCqqxxF+0SsfY7jJguIxnWcUP8dA==
X-Received: by 2002:a02:5249:: with SMTP id d70mr2695772jab.121.1590673994229;
        Thu, 28 May 2020 06:53:14 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d10sm3253459ils.69.2020.05.28.06.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 06:53:13 -0700 (PDT)
Received: (nullmailer pid 4157616 invoked by uid 1000);
        Thu, 28 May 2020 13:53:12 -0000
Date:   Thu, 28 May 2020 07:53:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     dmurphy@ti.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, sspatil@android.com,
        devicetree@vger.kernel.org, afd@ti.com, sre@kernel.org,
        pali@kernel.org
Subject: Re: [PATCH v10 3/4] dt-bindings: power: Add the bindings for the
 bq2515x family of chargers.
Message-ID: <20200528135312.GA4156923@bogus>
References: <20200527231743.18066-1-r-rivera-matos@ti.com>
 <20200527231743.18066-4-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527231743.18066-4-r-rivera-matos@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 27 May 2020 18:17:42 -0500, Ricardo Rivera-Matos wrote:
> The BQ2515X family of devices are highly integrated battery management
> ICs that integrate the most common functions for wearable devices
> namely a charger, an output voltage rail, ADC for battery and system
> monitoring, and a push-button controller.
> 
> Datasheets:
> http://www.ti.com/lit/ds/symlink/bq25150.pdf
> http://www.ti.com/lit/ds/symlink/bq25155.pdf
> 
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> ---
>  .../bindings/power/supply/bq2515x.yaml        | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/bq2515x.example.dt.yaml: charger@6b: 'low-power-gpios' does not match any of the regexes: 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1299261

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

