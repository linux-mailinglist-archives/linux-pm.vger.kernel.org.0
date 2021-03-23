Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F413469BB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 21:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhCWUUx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 16:20:53 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:43974 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhCWUUY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 16:20:24 -0400
Received: by mail-io1-f51.google.com with SMTP id z136so19105504iof.10;
        Tue, 23 Mar 2021 13:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Tp80gy+0OkNwU5Jvc6Bj62i4jpwSRXTDIXhxrL5nq0=;
        b=CMIcuRhT+iBuiRoxNvUOT8c+R/Kw4QVq8hF2yMMr7zNlFNqIyR0Fxh+5Ms4jpBXb0I
         Vo/rWxSq4O9Qft/sg+8SX8tFiYV9J51hBctyMVOxnKa7ys5oD/FbEyqtccKmwYQRzVWX
         k7jOVxDdPuA9LYzEwmjfZ8jG1wsJCaFmZMXpeKWYVkzMEA2LbYb0+L2BgBai619OBemX
         y6LxWC/gGKfZYApsyHRdB+ClMgnjmffdn9JUAl55E4DvjxCAbrEF41mO2kDvsA7j7KDy
         qYnRH1+uS7wc+3gjpSbBuD4yiEl1eoIxOUPrJrSMPrTLjRifnFNwGg2YyPTNcgzUfHGL
         vzoQ==
X-Gm-Message-State: AOAM531y95xRtkeb4SWdJHyBsF021adhHfEd5rRgz/tuRWY9zg9R860m
        brBMm+vKvOMBnTHYwOaPIQ==
X-Google-Smtp-Source: ABdhPJwiamQiJEfKQT0y+jbtus3lBMMGGCM3cCXWnYFJsj5T/y8a7/HZNP8JHP80rewyR1hKdB3KaQ==
X-Received: by 2002:a5e:d901:: with SMTP id n1mr5947919iop.84.1616530823835;
        Tue, 23 Mar 2021 13:20:23 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f13sm9614313ila.51.2021.03.23.13.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 13:20:23 -0700 (PDT)
Received: (nullmailer pid 1250413 invoked by uid 1000);
        Tue, 23 Mar 2021 20:20:20 -0000
Date:   Tue, 23 Mar 2021 14:20:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        srv_heupstream@mediatek.com
Subject: Re: [v3, 3/3] dt-bindings: thermal: Add binding document for mt6873
 thermal controller
Message-ID: <20210323202020.GA1250358@robh.at.kernel.org>
References: <20210312034018.17437-1-michael.kao@mediatek.com>
 <20210312034018.17437-4-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312034018.17437-4-michael.kao@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 12 Mar 2021 11:40:18 +0800, Michael Kao wrote:
> This patch adds binding document for mt6873 thermal controller.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
> This patch depends on [1].
> 
> [1]https://patchwork.kernel.org/project/linux-mediatek/cover/1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com/
> ---
>  .../thermal/mediatek-thermal-lvts.yaml        | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
