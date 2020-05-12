Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6DA1CED44
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 08:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgELGu2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 02:50:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44658 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbgELGu2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 02:50:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id r7so10169983edo.11;
        Mon, 11 May 2020 23:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NGCmQRwn70jwSoE1rVBW7nYUdi0rleIM1+a6lKcmx6Y=;
        b=BEdokAKhE09o17Ib6jqnZ1D20IGifvKr+19ie8b0UruQCQc+xIjqzQkyM4kcCT13eN
         oI/jSf/zeHdoNJbci7Y300tG66KgzruR9ERSkOfY7d8G1an9HG6Fb2TFXZaq6Yz1lGSD
         ZuwATDcs9xy8bi5JsK53SV7j6R6d8xACLzkl2GKUQ/7MnzO1030y4fjgl4jMs+Z7w32B
         950h30X+VDrrpy+ErAhaA8Pg/n0mXLx9NychTPhxgwYZuEhSEqArw/eLxEP/HXAencrv
         Hnc/0SJJ9unHS379ORlI2jvIdfPcYpkM0KF5D2pDc22K0+HJMxK2+cql4JcO9niF26o5
         UAhw==
X-Gm-Message-State: AGi0PuakzhgipJfP4AQ/0P62+mL+1AFF6hSqR2n3nnnR2xMkSFDp45p4
        1ko83twTYsJMhPWv3/zgRns=
X-Google-Smtp-Source: APiQypJRBoTPk3w4SSl5+ddox+FzeAD0bP+sdgUJjGYIvF+5BKJVf2SdadvJzdj8oe1Rhj3tuk/VMw==
X-Received: by 2002:a50:eb0a:: with SMTP id y10mr16683538edp.312.1589266226225;
        Mon, 11 May 2020 23:50:26 -0700 (PDT)
Received: from kozik-lap ([194.230.155.237])
        by smtp.googlemail.com with ESMTPSA id m5sm1601440edq.71.2020.05.11.23.50.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 23:50:25 -0700 (PDT)
Date:   Tue, 12 May 2020 08:50:23 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bernard Zhao <bernard@vivo.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc:     Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] memory/samsung: reduce unnecessary mutex lock area
Message-ID: <20200512065023.GA10741@kozik-lap>
References: <20200508131338.32956-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200508131338.32956-1-bernard@vivo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 08, 2020 at 06:13:38AM -0700, Bernard Zhao wrote:
> Maybe dmc->df->lock is unnecessary to protect function
> exynos5_dmc_perf_events_check(dmc). If we have to protect,
> dmc->lock is more better and more effective.
> Also, it seems not needed to protect "if (ret) & dev_warn"
> branch.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

I checked the concurrent accesses and it looks correct.

Lukasz, any review from your side?

Best regards,
Krzysztof
