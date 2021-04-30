Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D61136FD78
	for <lists+linux-pm@lfdr.de>; Fri, 30 Apr 2021 17:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhD3PQF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Apr 2021 11:16:05 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:33726 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhD3PQC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Apr 2021 11:16:02 -0400
Received: by mail-ot1-f53.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso42207007otl.0;
        Fri, 30 Apr 2021 08:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dls3JdP07FKx2SVUTP5QJwduat3Ev9SaPYcCsd8uxic=;
        b=LwTluvd55JZI+4td/0cHFbgXFZ1whkD8OFyN5o2taoWWFmh7hOcY1CoizNtDKehkn0
         eDOvTq45fPTz4CmaHOV2kLU3M/iGYWa3m3ttl8YWRIi6re9DSbn9uWf1gTgjSolL6gu+
         aQY/tRdbiacyR8TwYVkZOKrH3Zl9QA1DBcSMDsz9JcENjzcvH19zWjk2znAs1HVBaiEP
         iFfxTvyYe4d2UI1D6bR3rWeh1VJ/yoknKSfbaDHdFW8bBH2e6lHlmevxMRTW7yrJCAJ3
         q4S0BHJ9TFjOuL/PWT1oFOVZwM0MrZ9RniDL+cF32LqGe91fmUeizp+YYhxru5/5Pf0C
         j2SQ==
X-Gm-Message-State: AOAM531/36+/OwVH1wp8q/3XH+c3qb8bjInCrAIlSFZaQ7DAEVKhX9FH
        U8yMlig/IQxdiY26OM/IKg==
X-Google-Smtp-Source: ABdhPJxQ0pmZoqSv25pyS7S6IMQ39fbYqMp3fwW33tkoGpP1gOT7WXDp5XjP3NMP4/rNcFCuR/h0sg==
X-Received: by 2002:a9d:7401:: with SMTP id n1mr4051873otk.28.1619795714359;
        Fri, 30 Apr 2021 08:15:14 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r189sm850355oif.8.2021.04.30.08.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:15:13 -0700 (PDT)
Received: (nullmailer pid 3338441 invoked by uid 1000);
        Fri, 30 Apr 2021 15:15:12 -0000
Date:   Fri, 30 Apr 2021 10:15:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Finley Xiao <finley.xiao@rock-chips.com>, linux-pm@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com, Zhang Rui <rui.zhang@intel.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/2] dt-bindings: rockchip-thermal: Support the RK3568
 SoC compatible
Message-ID: <20210430151512.GA3338364@robh.at.kernel.org>
References: <20210421200445.32977-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421200445.32977-1-ezequiel@collabora.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 21 Apr 2021 17:04:44 -0300, Ezequiel Garcia wrote:
> Add a new compatible for the thermal sensor device on RK3568 SoCs.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
