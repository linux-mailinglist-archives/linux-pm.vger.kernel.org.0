Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAF446A6D0
	for <lists+linux-pm@lfdr.de>; Mon,  6 Dec 2021 21:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349486AbhLFU0z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Dec 2021 15:26:55 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:45988 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245450AbhLFU0z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Dec 2021 15:26:55 -0500
Received: by mail-ot1-f53.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso15120055otf.12;
        Mon, 06 Dec 2021 12:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pVcKmFiflg2BA7jLxRWdptrXQB/vvV27FoNP85xzsZ8=;
        b=7/y4MasJPrm8T8PqjgEQEWno6j/LiH9+VzXMuL7v1bL38u6CW+s55lFnywx+N6zH6w
         nXSii28VXmREOp+LyVLJMwhtwsAKD5qyW92BpnOMs5shVJvb7f7yMgkbLawk/JRXkBM7
         EWgh3uSkS4eZu0UAoKsUuTbKLKywmRVXtxqU66hxfngJqht2aTck+rP2+5LnCwj2jy1O
         zVMpxIDfNZZE7JRj3w4tcKennR4APGYKsde0ih46I9qT3RZrdI8JHc8zuLvkrVeI6z38
         cDaMQSuYS1y46axDnifg0by7hFlq1y5d0ZSqQHEJCRsJN2DPd+mEfB4FNGxmrvooaOpr
         kJXQ==
X-Gm-Message-State: AOAM5327Dv93SPA4XzV/r0ntTW0F6hCD+rMVF2gfloJXowA4AhEipSHx
        IF0GfCVWkq6BfufvEt8BMA==
X-Google-Smtp-Source: ABdhPJwIIbmpiTcdNapzihgXpSzMc2yN4AtYlNACYl3Gmv8q5o5dxLJxOtKc7YiTVLWVMjDETLz3QA==
X-Received: by 2002:a9d:1e1:: with SMTP id e88mr31047469ote.75.1638822206020;
        Mon, 06 Dec 2021 12:23:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p6sm2330016oof.0.2021.12.06.12.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:23:25 -0800 (PST)
Received: (nullmailer pid 2522780 invoked by uid 1000);
        Mon, 06 Dec 2021 20:23:24 -0000
Date:   Mon, 6 Dec 2021 14:23:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: bq25980: Fixup the example
Message-ID: <Ya5xPEo+NqKRHBKX@robh.at.kernel.org>
References: <20211206152905.226239-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206152905.226239-1-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 06 Dec 2021 16:29:05 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Use the ti,watchdog-timeout-ms property instead of the unsupported
> ti,watchdog-timer property to make the example validate correctly.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  Documentation/devicetree/bindings/power/supply/bq25980.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
