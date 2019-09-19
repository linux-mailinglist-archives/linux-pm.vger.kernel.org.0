Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5BFDB80AF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 20:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbfISSTu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 14:19:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40305 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732834AbfISSTu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 14:19:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so5067975wmj.5;
        Thu, 19 Sep 2019 11:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MS71DLSrsr/G7o0fTmBzjlmIBqxvb7B9GSSu+P2PwIg=;
        b=YKmIA7mwzgkNBcim+ksTsPSsUvBXIRGp6xbLUfNQRPe6d+MLjl8E9Tua6Q+5Wiu9Ws
         noze5nhH/uLhYrtCmqCrrjwMsi+UiKrUPImUtotZ1JoG5p8VhLRXpAsoSwWpILNrowL3
         Y2cryJQo3LKjbp5M15oWlAvVLLW1QHRNAoIhZJJqpRyRcbPFQjQALlcw+ZKo90GHbjNL
         YvF9c9ImoSk0fbmaNl2qbIM4PT4y9ifvukdm5e1W64uXchkb35Zr6SYDjxGNlOXIKAfq
         DRP87LKVBPTDwZVFdv4IfMDfg+8d5bRoaLmiM5PGz4dX5E+fxefIYcj6/NufygKL+3Wh
         2t1A==
X-Gm-Message-State: APjAAAVginiW1ZbKlf2gcKy6Rj4JIeCsAEPhO2vtzSsPKs5xN3J9EnQG
        5IuJesT4sMTJ9T0+6bR+ZnerOyRY
X-Google-Smtp-Source: APXvYqzDQmkkIzntHgwlryzOqeRBmIg4C0xnns499J6+IhQ83PPvBY71St9Lwr2+SJuP95RGKnOA6Q==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr4156412wmb.93.1568917187038;
        Thu, 19 Sep 2019 11:19:47 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id r13sm13927274wrn.0.2019.09.19.11.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Sep 2019 11:19:46 -0700 (PDT)
Date:   Thu, 19 Sep 2019 20:19:43 +0200
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
Subject: Re: [PATCH v3 1/2] memory: samsung: exynos5422-dmc: Fix kfree() of
 devm-allocated memory and missing static
Message-ID: <20190919181943.GA10759@kozik-lap>
References: <20190919092641.4407-1-l.luba@partner.samsung.com>
 <CGME20190919092652eucas1p12dbf9ba9d60a0c89cb7de05ab61893be@eucas1p1.samsung.com>
 <20190919092641.4407-2-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190919092641.4407-2-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 19, 2019 at 11:26:40AM +0200, Lukasz Luba wrote:
> Fix issues captured by static checkers: used kfree() and missing 'static'
> in the private function.
> 
> Fixes Smatch warning:
>     drivers/memory/samsung/exynos5422-dmc.c:272
>         exynos5_init_freq_table() warn: passing devm_ allocated variable to kfree. 'dmc->opp'
> 
> Fixes Sparse warning:
>     drivers/memory/samsung/exynos5422-dmc.c:736:1:
>         warning: symbol 'exynos5_dmc_align_init_freq' was not declared.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 6 ++----

Thanks, applied.

Best regards,
Krzysztof

