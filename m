Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B82B8C0992
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 18:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfI0Q3b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 12:29:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37204 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfI0Q3b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2019 12:29:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id k32so2762998otc.4;
        Fri, 27 Sep 2019 09:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ijPthvXY5MkzJmndJb4QPmgAxNMcU2lPzqEJVv6FKic=;
        b=JndAQ8C/ST2/qjKS8JZGVGzHI9ae0F2lHMQ37OkbAywWC6Nh+o8RRBwzV0CtwtFhtx
         HcYvf1D2lGBnRvPPIiLPRyr70ItQr+B9gr1oluLlLYwANz1R/vXkHs5F5M1OpFYug/yt
         eAihmu4WzQaAbmg7WasdpWEjLwNrZxKN27+iqhveZ+z+FHmjZtipjT6xvYtBAvnY2Ah2
         werbEFsszDxVO8Z2jfitWT1ET0G502hMPXIu2KeeSxh+AWVW5NFPUqQYgzJxJBTv+4Nj
         xzUL5l/VarTrCncRiovCLDXu2MdfAz4hndhX2cdN+EflHjo+HsNhuF3hPdsx+FKC8VpH
         JWOw==
X-Gm-Message-State: APjAAAX7y4uYh4COQh3Seq6wgsBRJg6beotzYWHoMDFRqebxYiuMs84X
        nc5DnNQPcTGASG02UnLxTw==
X-Google-Smtp-Source: APXvYqyD1bsWUu1PkapLS2xhliXVV73CnxU+i/v9UfsVJdpaGaFnJoMTWN/WoU0EM9M/qN8nNCtBJg==
X-Received: by 2002:a9d:3dca:: with SMTP id l68mr4106313otc.49.1569601770160;
        Fri, 27 Sep 2019 09:29:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v132sm1832174oif.34.2019.09.27.09.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 09:29:29 -0700 (PDT)
Date:   Fri, 27 Sep 2019 11:29:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 07/15] dt-bindings: thermal: tsens: Convert over to a
 yaml schema
Message-ID: <20190927162929.GA27130@bogus>
References: <cover.1569015835.git.amit.kucheria@linaro.org>
 <805a2ae9c95f41dc733ccc80346941998e1b230c.1569015835.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <805a2ae9c95f41dc733ccc80346941998e1b230c.1569015835.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 20 Sep 2019 14:52:22 -0700, Amit Kucheria wrote:
> Older IP only supports the 'uplow' interrupt, but newer IP supports
> 'uplow' and 'critical' interrupts. Document interrupt support in the
> tsens driver by converting over to a YAML schema.
> 
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  .../bindings/thermal/qcom-tsens.txt           |  55 ------
>  .../bindings/thermal/qcom-tsens.yaml          | 168 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 169 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
