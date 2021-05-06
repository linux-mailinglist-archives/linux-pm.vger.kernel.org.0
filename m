Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1824375CF5
	for <lists+linux-pm@lfdr.de>; Thu,  6 May 2021 23:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhEFVqB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 May 2021 17:46:01 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:46034 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhEFVqB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 May 2021 17:46:01 -0400
Received: by mail-ot1-f46.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so6197886otf.12;
        Thu, 06 May 2021 14:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XyAhogY5RKWxU8HPoNpJMjz+kQU5BtxI2lVbOAWbTl0=;
        b=iGPFwiCHasoVgUvFgK7m36MsCr4aVprgNQj+5F7X5eQAfC0zZOc0ONTdcmxFrlY9qd
         42sbXUlNTHOdH2DqbgDReYs6WvzR2hUIn4XnlNGNox7Efb0NwPAZ7AvBMbPH/O4gnRS3
         IZjA7sFBzqEj9BuS9+las+EgcZxo+TVYt8BhIH1iBMx7U6KATUGDvqTAsxOCKvUW5c0b
         eMsxvRgPpwTUlkSCN/XilrP651cRj5FDISv2jXnSVUnRltpzgL8p4YSMJFi2TUY4ZK7f
         mH+EpVGqJPGWVFCIH9RWJlyFVI9IEXx/yQDmXOBlYz5AwNQc9haztE7ucB6I+eBwFHQY
         Z9tA==
X-Gm-Message-State: AOAM53376OfSAXif5RgcNTwEj7CBUoNAZEz0aw3aNF75Y3wfLwgXrZ5r
        a+XgLaOekGE/etUFRsn7TQ==
X-Google-Smtp-Source: ABdhPJxHDr6Hds/Md7b57bDuLoP4gBNh8QTwF4qOLe9F2hOfCEB2PQePbXkcuiLLRFbMO4FW4wcJLA==
X-Received: by 2002:a05:6830:208e:: with SMTP id y14mr5322270otq.15.1620337502071;
        Thu, 06 May 2021 14:45:02 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q130sm629601oif.40.2021.05.06.14.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 14:44:54 -0700 (PDT)
Received: (nullmailer pid 853927 invoked by uid 1000);
        Thu, 06 May 2021 21:44:52 -0000
Date:   Thu, 6 May 2021 16:44:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/4] dt-bindings: rockchip-thermal: Support the RK3568
 SoC compatible
Message-ID: <20210506214452.GA853809@robh.at.kernel.org>
References: <20210506175514.168365-1-ezequiel@collabora.com>
 <20210506175514.168365-4-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506175514.168365-4-ezequiel@collabora.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 06 May 2021 14:55:13 -0300, Ezequiel Garcia wrote:
> Add a new compatible for the thermal sensor device on RK3568 SoCs.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
