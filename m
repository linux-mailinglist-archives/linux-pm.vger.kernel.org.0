Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B3E247954
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 23:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgHQVzq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 17:55:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42242 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgHQVzp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 17:55:45 -0400
Received: by mail-io1-f68.google.com with SMTP id g13so4911351ioo.9;
        Mon, 17 Aug 2020 14:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nkpIYhalEcM+P3nv1fCih/h2x5+KBhnkb2wFnc/lhB8=;
        b=T9fmygbA8DbrXiW3OVPQPR5WvFM9bmLxRrbEgFeAJuBHzfZIFb/RKE6vyflCAiAkJb
         9rJm+t182SPvjwTxqD3x0bjRHydXtsp5/D5VcrY5pwwGpRqvSRYIaMXkpsRSznXeAz+p
         Sbv+YU4AfISOwCx6w1gW1+uwjFOvz0kSRDhE65x7RGKv+gPTAX/ebq9jwSiAakttYrXr
         bQ2R6pl1iyD+T82weCsLXf4HSNG0gGFrPEqHzNsc3mCARrrhvAJ24JS61nSt21dn8xuy
         HptCGbPAnxQuifQf6ebh8BGz4nQiAzs4Cmdni2V9TB5zl9KxDRbodVay3PhXPHZ1Bb9s
         8RfA==
X-Gm-Message-State: AOAM533X5cIhFkvvZ25brZmWzq3baYR664yCPtkBVhegs00rDJU7BMo6
        +88OZrynIzcCD/Lx95F66g==
X-Google-Smtp-Source: ABdhPJwDNrUfp8Fv8dzBBjKs4kQQjiJPwC5XtW2qYTwNIhyPOu65dg7TzCwVaw1CyyD4fNG+ENza/g==
X-Received: by 2002:a6b:8b86:: with SMTP id n128mr13794859iod.202.1597701343859;
        Mon, 17 Aug 2020 14:55:43 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id 13sm9921642ilz.58.2020.08.17.14.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:55:42 -0700 (PDT)
Received: (nullmailer pid 1641174 invoked by uid 1000);
        Mon, 17 Aug 2020 21:55:40 -0000
Date:   Mon, 17 Aug 2020 15:55:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     devicetree@vger.kernel.org, sibis@codeaurora.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mka@chromium.org, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: interconnect: Document the support
 of optional path tag
Message-ID: <20200817215540.GA1641121@bogus>
References: <20200806163126.22667-1-georgi.djakov@linaro.org>
 <20200806163126.22667-3-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806163126.22667-3-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 06 Aug 2020 19:31:21 +0300, Georgi Djakov wrote:
> Let's document that we now support specifying path tag information in the
> arg cells of the 'interconnects' DT property. This information would be
> populated when the xlate_extended() callback is used.
> 
> Specifying the tag in DT will allow the interconnect framework to do the
> aggregation based on the tag automatically. The users can still use the
> icc_set_tag() API if/when needed.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/interconnect.txt    | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
