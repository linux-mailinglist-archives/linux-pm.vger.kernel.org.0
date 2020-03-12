Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8828A183A2F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 21:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCLUFu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 16:05:50 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38630 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgCLUFu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 16:05:50 -0400
Received: by mail-oi1-f193.google.com with SMTP id k21so6869381oij.5;
        Thu, 12 Mar 2020 13:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3bLRRYxvg8WPmScDUsmez1LtGKNh4mFSL/Bbm2FXoLA=;
        b=Z7FW3RydYJRFKMqlEOowzkzI190sEVYreFMGRGNbc5AXKUethBTxJwwvhJXb2cYAT4
         +GY8ZFpau5pn1F8OMcedypHweKHPvFvWvD2HF7igIG6Aj9tn8sUtG8ejFWqyqYdkhyqY
         eu9Mi8BAHGJtmaY+J3+kY5zu5gmYwspM8AzPngLzWaQCMtkCBqeY2/755y+S2bthzLYV
         JFmgV9jeKU2tTHU+hfr9spuQiUplYSmWZf6rvVlUbNrmMx9FnPDrv6ritNO10W8NDYH/
         PFNxFGAjmX1SGd75qbQxWOnlExxA/8To3ioa1GAM6I+gIbvtbeTtfcEob2kkgZlzGHA5
         zBEg==
X-Gm-Message-State: ANhLgQ1lXizsxXzFRDgI2nJD3tQj4WxUpmV/537Kz/o7QCL3HdfwQl0z
        /ZOMsaW9gMLVU+JetZDlIA==
X-Google-Smtp-Source: ADFU+vtzzZijf6zInIIlPCXBjx0bL4ZmzsWAe8jak76tyZW9bq0xAEQSMkZ9c7An/Wms8LmVvpct7Q==
X-Received: by 2002:a05:6808:3cb:: with SMTP id o11mr3876127oie.11.1584043549644;
        Thu, 12 Mar 2020 13:05:49 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h2sm806253otm.44.2020.03.12.13.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 13:05:48 -0700 (PDT)
Received: (nullmailer pid 18639 invoked by uid 1000);
        Thu, 12 Mar 2020 20:05:47 -0000
Date:   Thu, 12 Mar 2020 15:05:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: rcar-gen3-thermal: Add
 r8a77961 support
Message-ID: <20200312200547.GA18576@bogus>
References: <20200306105503.24267-1-geert+renesas@glider.be>
 <20200306105503.24267-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306105503.24267-2-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri,  6 Mar 2020 11:55:02 +0100, Geert Uytterhoeven wrote:
> Document R-Car M3-W+ (R8A77961) SoC bindings.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
