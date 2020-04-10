Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22A71A4912
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 19:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgDJRhC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 13:37:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33622 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJRhB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 13:37:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id 103so2537292otv.0;
        Fri, 10 Apr 2020 10:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cBvs5LwqUO7S5M6QR4lxvxc0bJWFJ0sqPahnnM7+10g=;
        b=XHte53IBXQ0nR1dXP5G4BYhZ6yp4AjKU1+zPZVVeTciDv9WSidNLhj+SVq9Hp5w9tf
         JqjIPL2FIWPDIOqsj6NukGPZd7kEMkpPyyyowS8LUio09M8Ut0qFqz7pvHeilrvyqGAe
         1ZqiwFkWEAJPa8MJuMzO0P3mcavNHwi2RvaWdjoUM55r/JlRkdrGOGZcVs6rLMvZHWKP
         bG3X6wIlt4fxLsX2eO8zHQ1rPNPgBqtnU/uSDl9U6EdVhlOnDeRXcLBk7B+xPG4kt4pn
         PkW2Cpeo/9OwKh24rHnYUpJcfQhvjrqMpF8ZIUQqM1/my4xqNv7XWjCGrhLwdyDq9daK
         D3Rw==
X-Gm-Message-State: AGi0PuYqVaKzfUFiDjoIIZcHZv0Jek/vab+QD2BmJW36jmizp7rt4F5R
        zysprLPrE10o/mov3DR+mA==
X-Google-Smtp-Source: APiQypL+sqymxMXjAk1Aso5m19W5p4BkuIoCN8DUgQmzzZdht2Km+Hfi4ZRxdegF8sh6WjgrkukfbQ==
X-Received: by 2002:a9d:5b4:: with SMTP id 49mr4807406otd.210.1586540221606;
        Fri, 10 Apr 2020 10:37:01 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id g18sm1566538oib.36.2020.04.10.10.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:37:01 -0700 (PDT)
Received: (nullmailer pid 31953 invoked by uid 1000);
        Fri, 10 Apr 2020 17:06:06 -0000
Date:   Fri, 10 Apr 2020 12:06:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 02/22] dt-bindings: memory: tegra20: emc: Document new
 interconnect property
Message-ID: <20200410170606.GA31915@bogus>
References: <20200330010904.27643-1-digetx@gmail.com>
 <20200330010904.27643-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330010904.27643-3-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 30 Mar 2020 04:08:44 +0300, Dmitry Osipenko wrote:
> External memory controller is interconnected with memory controller and
> with external memory. Document new interconnect property which turns
> external memory controller into interconnect provider.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
