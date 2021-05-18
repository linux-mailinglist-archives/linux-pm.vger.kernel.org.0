Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDAA387B01
	for <lists+linux-pm@lfdr.de>; Tue, 18 May 2021 16:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349973AbhEROVc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 May 2021 10:21:32 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:42786 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349959AbhEROVc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 May 2021 10:21:32 -0400
Received: by mail-oi1-f177.google.com with SMTP id c196so1723440oib.9;
        Tue, 18 May 2021 07:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hJ7DVI8fhmwBOH2IUo1UrfyvEw8/sy8ERU4boAZCTso=;
        b=f6ET+gXPlUmc7TWYz3BQZejcxaBZH6E7Ccq+vDOpesMI1cRKggqMEQiNBaLq1/ZAkR
         6AB4omNe66s4Q41UHHupgi9T8LpEb2xrRXZWLqBGIUBhY1RLNkqtF7mcEbTpWfRCJL4Q
         N7NkEPvYLNf3VFwh3NFKK70VDrBdX38boSwhC+v8j2rfMPLDTtHN3bqMgWs9JuC3vs1D
         3ivlmt9JHsR4M9WOx63xaYw8ke6LPB0xqkoGTbBccps7VcNg1w+HZ7iPoGPkp/KCTJgM
         hnFdOeJvuFkfEwpKIZsq1hnMq9C1QXLeqp5oi5AsNAPP/u/tlufiQaMn+lFxviFKvjiK
         hVKQ==
X-Gm-Message-State: AOAM531Icy98neUzKO7s+yud+aZ45fek3AIPi1JFM3PruAqTC/NmVUIw
        Z9PINO3dN2L1TGrNqH3vAw==
X-Google-Smtp-Source: ABdhPJynRC8420FIewuhiizTHJ0JIkGZoXyJiMlRQ3p6rQVxlUE6GcHDy22QVqjHj/ZT9D4CJfj+WQ==
X-Received: by 2002:aca:4dc3:: with SMTP id a186mr3676923oib.22.1621347613471;
        Tue, 18 May 2021 07:20:13 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e11sm3779210ook.20.2021.05.18.07.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:20:11 -0700 (PDT)
Received: (nullmailer pid 617644 invoked by uid 1000);
        Tue, 18 May 2021 14:20:09 -0000
Date:   Tue, 18 May 2021 09:20:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Matt Merhar <mattmerhar@protonmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Paul Fertser <fercerpav@gmail.com>, devicetree@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: soc: tegra-pmc: Document core power
 domain
Message-ID: <20210518142009.GA617606@robh.at.kernel.org>
References: <20210516231755.24193-1-digetx@gmail.com>
 <20210516231755.24193-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516231755.24193-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 17 May 2021 02:17:53 +0300, Dmitry Osipenko wrote:
> All NVIDIA Tegra SoCs have a core power domain where majority of hardware
> blocks reside. Document the new core power domain properties.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../arm/tegra/nvidia,tegra20-pmc.yaml         | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
