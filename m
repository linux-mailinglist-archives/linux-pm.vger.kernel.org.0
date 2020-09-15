Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2214A26AC74
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 20:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgIOSrV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 14:47:21 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42321 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbgIOR2j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 13:28:39 -0400
Received: by mail-qk1-f195.google.com with SMTP id v123so5048804qkd.9;
        Tue, 15 Sep 2020 10:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nMAyu9gaeD5KneTR08etfhTbKcQO0tFdgu4T0zizHD4=;
        b=iTRZC0qWLAaaW+nyYis6BJdsr7irp2bDn6LS9wErrycBDP+bbclP2X3ynOFUEzXaXP
         o/tVCFMpf0o7irFzkAVR2F/oZntnwnl98K3ACUuDKX74alh8S3Do3s0ietV466QuJzce
         N6JV4y+hyltoIYTearCQiGorbNg05eYOhglDMIHjlYGI8oQhtk44ojJkdDt8AqdNJpJi
         G1vH8wMbAlht5xN8gneVXJcTI/P7MmpreLwlpSFzLiwAi4nzoLve+ualHfNhMdd7k96N
         eTFNqCN6OxvQLnOv1Pu/76LePiDm0T+9FeW7cLm25kNTbcd6k/YNYBBHmx9NBhOexayb
         e+uQ==
X-Gm-Message-State: AOAM533v/qhX3G73gcVaNtH0U8Wo7WkiN9N90tF1zQ+OoCvBwiOeUlPx
        yh2SuGNa7XUH4C5mt3DWOf3igsOX2RTa+H0=
X-Google-Smtp-Source: ABdhPJyzV6XVR3M4AxQfi/ZcxsetRVymmGU/c0n8YWApO7VeuCS+WfyJbS4pWQ2xgt6zHI79oVsb0Q==
X-Received: by 2002:a02:9986:: with SMTP id a6mr19164058jal.28.1600188853861;
        Tue, 15 Sep 2020 09:54:13 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z4sm7618475iol.52.2020.09.15.09.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 09:54:13 -0700 (PDT)
Received: (nullmailer pid 2113565 invoked by uid 1000);
        Tue, 15 Sep 2020 16:54:11 -0000
Date:   Tue, 15 Sep 2020 10:54:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: power: Correct interrupt flags in examples
Message-ID: <20200915165411.GA2113514@bogus>
References: <20200908145922.4502-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908145922.4502-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 08 Sep 2020 16:59:22 +0200, Krzysztof Kozlowski wrote:
> GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> These are simple defines so they could be used in DTS but they will not
> have the same meaning:
> 1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
> 2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING
> 
> Correct the interrupt flags, assuming the author of the code wanted some
> logical behavior behind the name "ACTIVE_xxx", this is:
>   ACTIVE_LOW => IRQ_TYPE_LEVEL_LOW
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/power/supply/act8945a-charger.txt       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
