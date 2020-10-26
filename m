Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3DF298FD5
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 15:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781958AbgJZOt1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 10:49:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42575 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781957AbgJZOtZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 10:49:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id h62so8189716oth.9;
        Mon, 26 Oct 2020 07:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Nh7HRtiviidsm4a3WxEgJxaq5Xaotz77zJ4no9xGWg=;
        b=P/1xZi0ZwBBu2AmDw/44Yu80PB/+21zVAWuuApb2qzsMF+8QPAkHS4Dkc8pUUqhjQ/
         FdwKXGDspIgIX8jQcdU5N7pzMRYPGwvyrElBXWddhr6FcqpZHe/OgUHjF9WGRRVstuSJ
         G0/HbVTzSeqM1De0gDgFcSILqtadIRv1FHFXAbo40B05H2fAjcLiHa3o65WkVDfzh3AO
         c4hPIjRLtEPO076WXym9uFGYVVUnYQ6Si1lmqNpx5ECd0uX8p78uEJ0W9Ar/BttgqoXV
         9QfmJxjzE8miNC7B0tipfyoejmQ824uflXDT188CcRMG7bFuBHGV6Hq8ikphzVHvibYP
         llpw==
X-Gm-Message-State: AOAM533r8tuMccpZSgC19ypTu3iCucvsafVUoeSB+b6VAPdV0F0c7EJa
        A4nUiZ4dAY8Eb6NR66QiKw==
X-Google-Smtp-Source: ABdhPJwtO2IX81WQshcX9WVDYLyK4r3Zc8udhCmT9aQgFi0oZ7kQ03vjZ4UBiS98Nn2LOy+rPAQacQ==
X-Received: by 2002:a9d:1a5:: with SMTP id e34mr15087183ote.197.1603723765055;
        Mon, 26 Oct 2020 07:49:25 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h32sm3651553oth.2.2020.10.26.07.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:49:24 -0700 (PDT)
Received: (nullmailer pid 138475 invoked by uid 1000);
        Mon, 26 Oct 2020 14:49:23 -0000
Date:   Mon, 26 Oct 2020 09:49:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        amitk@kernel.org, rui.zhang@intel.com
Subject: Re: [PATCH 2/3] dt-bindings: thermal: mediatek: add documentation
 for MT8516 SoC
Message-ID: <20201026144923.GA138429@bogus>
References: <20201021164231.3029956-1-fparent@baylibre.com>
 <20201021164231.3029956-2-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021164231.3029956-2-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 21 Oct 2020 18:42:30 +0200, Fabien Parent wrote:
> Add binding documentation for the MediaTek MT8516 SoC.
> The SoC thermal IP is similar to MT2701.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
