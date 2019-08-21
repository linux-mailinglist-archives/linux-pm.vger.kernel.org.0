Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC49985B1
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 22:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfHUUfV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 16:35:21 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36087 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbfHUUfV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 16:35:21 -0400
Received: by mail-oi1-f194.google.com with SMTP id n1so2658933oic.3;
        Wed, 21 Aug 2019 13:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h2MDZ1JBql5nn79XJfoA+yrBiCUG11jsLb+GXd+rHrM=;
        b=ZL0oax6d3PNkHuoF4FltAGleXI4dXwiewS6H1WKkHSmiVzNJ7e/M4Zo6Zc+nBe1MRr
         1qL0M0u/QN8/4mYQOLKkXM0fIkZkoUzBlvDvJ7RfjoaCcoXbca0Qh3E1BCYo3+i2brsX
         BsHaPxPoAXT9oULvjlkdBgNQ5vwhUW2wa9s9+PnvPyYjvSeQs0d0yAmQF7IXhB+7Yx+j
         Veomo89JaE75jlwChplaczWQdVf/bbPUdtX/ov/VKi8krxgEj52GnGWIVNxVXynKEwYV
         mNBZIOAcq35cnAAcKfVQdIxBnyNe6gTUQ92JP+9RSHAJjqtMbyS38GRMmE2OmBLTOORQ
         C8Gw==
X-Gm-Message-State: APjAAAUh7h6M5LM+uuE782Yap/qg1t9ZbGhIT9hUZwQp/YNmC8RmD3mC
        uF9RPH1HfRnkObQcQtkPEg==
X-Google-Smtp-Source: APXvYqwILWH5tWD+Ejh/Q5e8CQ+0m5rPo0bGWRzfqOdxJnwtqq4DpPe/5Sg2e6S6WGL2EmpEOUmWpg==
X-Received: by 2002:aca:d650:: with SMTP id n77mr1414451oig.129.1566419720019;
        Wed, 21 Aug 2019 13:35:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r8sm7788484oti.76.2019.08.21.13.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 13:35:19 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:35:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [RESEND PATCH v5 4/4] dt-bindings: devfreq: exynos-bus: remove
 unused property
Message-ID: <20190821203518.GA12770@bogus>
References: <20190808090234.12577-1-k.konieczny@partner.samsung.com>
 <CGME20190808090252eucas1p1be186b7a34fa75073fddca120c292f04@eucas1p1.samsung.com>
 <20190808090234.12577-5-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808090234.12577-5-k.konieczny@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 08, 2019 at 11:02:34AM +0200, Kamil Konieczny wrote:
> Remove unused DT property "exynos,voltage-tolerance".
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  Documentation/devicetree/bindings/devfreq/exynos-bus.txt | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
