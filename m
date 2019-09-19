Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FACFB80B5
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 20:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389717AbfISSVE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 14:21:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34996 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388700AbfISSVE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 14:21:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id v8so4158547wrt.2;
        Thu, 19 Sep 2019 11:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Df51XRG41U9MXsXqMNu4Zu0vZRfW+tQcfvee+m+fQ2U=;
        b=S/oCjWrsxJaT455KkRDuKNIwy8JRT1SS08zgHkD4+pdN+tiiOPsO9V4yIceCsgWi31
         RyYX5bw0YsBmfXUTEwFmS/XelsubThankN2XKcuPQCf74G9xR3LD1QI7+AN6NdN27Z7v
         UFEzcQo3Z/b/jgN0VGWW2QE8yYp0rA9yi339PdnBjWG24H04GAxljTEg3AZr38nWJLcJ
         JQ3V100TI5HWDU705TxEhRvIUdJ+4xRDGRS9r5ho/7W5T4CQJsAjlAr11a0Kr4tGQZGD
         7ty2N8tg/bHGfxxzaJy7AunUqlvqhCjJtyrCwxsfiIAgkWtBnckRNVL2P81Snjl2f9mu
         531Q==
X-Gm-Message-State: APjAAAWf04M8dIO5iExoLp+datNUXDmQApmda15+uB3NrIP8pnu7iszY
        9R2S4P12qXOd3+BAgsmJViA=
X-Google-Smtp-Source: APXvYqxz396R6UXhqfzT1ChMZIsoSE5XAvvgM81aXd18Fyk201ZNYvViT04Q0nxl7S3A1oFmf2GJOA==
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr8185360wrx.58.1568917262045;
        Thu, 19 Sep 2019 11:21:02 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id o14sm11296791wrw.11.2019.09.19.11.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 11:21:01 -0700 (PDT)
Date:   Thu, 19 Sep 2019 20:20:58 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        kgene@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, willy.mh.wolff.ml@gmail.com,
        dan.carpenter@oracle.com
Subject: Re: [PATCH v3 2/2] dt-bindings: ddr: Add bindings for Samsung LPDDR3
 memories
Message-ID: <20190919182058.GA22656@pi3>
References: <20190919092641.4407-1-l.luba@partner.samsung.com>
 <CGME20190919092653eucas1p21a1caa00589649fbc972bc7b84fe0d89@eucas1p2.samsung.com>
 <20190919092641.4407-3-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190919092641.4407-3-l.luba@partner.samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 19, 2019 at 11:26:41AM +0200, Lukasz Luba wrote:
> Add compatible for Samsung k3qf2f20db LPDDR3 memory bindings.
> Suggested to based on at25.txt compatible section.
> Introduce minor fixes in the old documentation.
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  Documentation/devicetree/bindings/ddr/lpddr3.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Thanks, applied.

Best regards,
Krzysztof

