Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A5BB6B3F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 20:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbfIRS5m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 14:57:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42168 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbfIRS5m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 14:57:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so494381wrw.9;
        Wed, 18 Sep 2019 11:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GJ3R8XhnecOsiy6g/x7C0Epa5BrgApmxuvPwK+dFs18=;
        b=aKSnuTCrCjyTSPixc7HKskoy8t4QkDnUKmZHXm/ogfhRkac3YPQbwLAD9pr1QdaK7F
         YIFs7q2EBZnx2jIN6qb3lNI2K1Rprien83OUYHBOBRfpM1EF4Bimu+Md41ZJ6wzdaKbl
         XUa4I5TkoNeHSGOUlx/T4TQsH0qFXlCB4wYoPUlCA1T/PhJHihaAq2oOTYdqLYqEh0VJ
         J/XxBkUAcbeIzu5tcWiLQbSUzK+F1nHeeeVtjqS0pFcHdTQmCD1SHCD1CM/pcuad70Oh
         0LlFbR5r1+CBD+WXrzkAynXcK6T9ywR+couCrQV1EPEa79Puyu1MS8iIVOFMit6nj/LF
         DBIA==
X-Gm-Message-State: APjAAAXGy38ahFb6BV99dg1VFZu1/LNppubpde2mayCQACJgotIOF8gv
        6JjJiOpma5VP4EZB+UiPhtI=
X-Google-Smtp-Source: APXvYqxCZ8ybmcDduSjrnyaRtnNA3U3N4PBgLW8JuqHbZ7QUON1Zenp0iU3fty+pz/Nwx6fAtGOOVA==
X-Received: by 2002:a05:6000:1002:: with SMTP id a2mr4017924wrx.272.1568833058449;
        Wed, 18 Sep 2019 11:57:38 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id g73sm4743264wme.10.2019.09.18.11.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 11:57:35 -0700 (PDT)
Date:   Wed, 18 Sep 2019 20:57:32 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Lukasz Luba <l.luba@partner.samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] memory: exynos5422: fix spelling mistake "counld"
 -> "could"
Message-ID: <20190918185732.GC8463@kozik-lap>
References: <20190916091249.31950-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190916091249.31950-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 16, 2019 at 10:12:49AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 2 +-

Thanks, applied.

Best regards,
Krzysztof

