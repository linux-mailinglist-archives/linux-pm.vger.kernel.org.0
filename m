Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BDA3CA24F
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jul 2021 18:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhGOQcl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Jul 2021 12:32:41 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:34329 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhGOQcl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Jul 2021 12:32:41 -0400
Received: by mail-io1-f46.google.com with SMTP id g22so7173681iom.1;
        Thu, 15 Jul 2021 09:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v1sGyty0gd4iWu3C0ErzREGdbTnaUB1Y47ERaQdKRHQ=;
        b=tP5MtCbqOJttlDLkmR3IV9VZkL8ifux50hPr1sTIFADvEfk4awzxu3oq4dZd4LdCmj
         taycb15lPUYsXpRkJbnyNAAkngVbSFIt6wR4XctNYmsknD4PkUP09DyQGu+D8mj21Upv
         bKdYv45ahxR18MREOrvN2DgJcI0C1EXKCNqJAcVBNofjLRZKGno28XN+DN7ldvJBFu4S
         XrPq8rQirHFv35Lo8Nz8bvXKq+IkJiDy5w1peh0DGDyz4zzfDENBWOvG0S/nr5OB9md2
         /XzU8/Ro59NO7jQGHXxplXGg7REQPgcol6In14+1i+AttMQijH9o0BwgqzH3BPGRcota
         0txw==
X-Gm-Message-State: AOAM532twfMxjpBpZbnUBDceLdGPjoLD4Pk7jEeoHn6M4WoH3z9Qz8Jq
        1o68T37R78NrPhRGRW64Ow==
X-Google-Smtp-Source: ABdhPJw5QX6CywVdSfB1MVePX9dufRHI9Tmxd4hvIU019ILBXIrMdD0QbzQb2b6Pv64zSONFgSiIgQ==
X-Received: by 2002:a02:3b26:: with SMTP id c38mr4877816jaa.12.1626366587396;
        Thu, 15 Jul 2021 09:29:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z12sm3427093iom.6.2021.07.15.09.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:29:46 -0700 (PDT)
Received: (nullmailer pid 1196299 invoked by uid 1000);
        Thu, 15 Jul 2021 16:29:42 -0000
Date:   Thu, 15 Jul 2021 10:29:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     YT Lee <yt.lee@mediatek.com>
Cc:     louis.yu@mediatek.com, charles.yang@mediatek.com,
        eballetbo@gmail.com, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, xiaoqing.liu@mediatek.com, nm@ti.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        angus.lin@mediatek.com, robh+dt@kernel.org, roger.lu@mediatek.com,
        linux-pm@vger.kernel.org, sboyd@kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        khilman@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, drinkcat@google.com,
        linux-arm-kernel@lists.infradead.org, linux@roeck-us.net,
        fan.chen@mediatek.com, srv_heupstream@mediatek.com
Subject: Re: [PATCH 1/2] dt-bindings: soc: mediatek: add mt8195 svs
 dt-bindings
Message-ID: <20210715162942.GA1196241@robh.at.kernel.org>
References: <20210713020552.18667-1-yt.lee@mediatek.com>
 <20210713020552.18667-2-yt.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713020552.18667-2-yt.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 13 Jul 2021 10:05:51 +0800, YT Lee wrote:
> Add new binding documentation of the mt8195 svs.
> 
> Signed-off-by: YT Lee <yt.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
