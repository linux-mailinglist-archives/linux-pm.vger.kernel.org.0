Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94BC7B490E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 10:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfIQISN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 04:18:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38437 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbfIQISN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2019 04:18:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so1696774pfe.5
        for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2019 01:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ccksZ0DIr5YuOlmKQ56MKQuO6sfHn4/cYWLl1y6ZJss=;
        b=Os/OjkFdbkxbCMGYZNy/HnlfvRLdNhVDvO3OQ3Tjqp9ysoWyo0oM4s2SSDCAzouHsz
         gkjFk4cddTJ2rUMcXLsrmoS14Xcns241t9TBp2xl4Ltya+LciRWtEQ58XqrCB+viuEx7
         Xghm6/lG8f6ZFz2ZU4/8yigRh6Xo6AZmD5tcBL7R/PVjNIiv+hOwCPRttq4vURDrB2U9
         vVogGNoMgz30xlAJB7P7ThuBYG3OVdHfPB9AqNgQHkt62TSyfWxjkstqzWvMH0v+KetM
         TDXnzs7rLDW60zjQDKVvTA0qCV9uV+ENswqS425WgupE4mmBCfMyiGcnJRNzzZkvqwea
         1Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ccksZ0DIr5YuOlmKQ56MKQuO6sfHn4/cYWLl1y6ZJss=;
        b=Y4bHMuJgJ331W/feyRCWtMTrg3oBTeYawul2u9pFr0JAPeY/Uu1tgusIjxoJhWRNTe
         QDJs9Yar2jP5cbzWr/JeDyNj8lAK0QLxhNt1nQvo46ZuiQcpr3BNXb5wyJYN0eyRLFm9
         TEuGKH9ks7oKBpbfASHLCAhqDpT8M0zmqEXLBgV7JJa27FwPEkgtm7++Npwur9RerRal
         SZHJaoS5Dxe0UgzoswnWjPrFRKqMIWdL+Kx0IGP/J+0kriDkeZ2yRnogcRMczgrGvF+0
         /8PL0DHgl4foIxhbgr/gqH+c5u2J5XOysu+/ULgupveG5IDXbYFvTGHnHoR9lUrE9kwJ
         c7/g==
X-Gm-Message-State: APjAAAUFxUoPoZSH84m4wDtKKcfj/J7vUIfE4IKrH1cHn1ExXoJuxn0f
        MtwBtTNjRXN4EoK04FNGi/AUDw==
X-Google-Smtp-Source: APXvYqwpy0WS+QkLpZKa7+H9dnq/Maul15NnA8yNy5WichOtA6IyRwXpsp5wW9igskBRzYgp3hRJ5g==
X-Received: by 2002:a62:1955:: with SMTP id 82mr2836635pfz.256.1568708292663;
        Tue, 17 Sep 2019 01:18:12 -0700 (PDT)
Received: from localhost ([122.172.73.172])
        by smtp.gmail.com with ESMTPSA id v44sm4392124pgn.17.2019.09.17.01.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Sep 2019 01:18:12 -0700 (PDT)
Date:   Tue, 17 Sep 2019 09:18:05 +0100
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/5] cpufreq: Initialize cpufreq-dt driver earlier
Message-ID: <20190917081805.kmhu6zcdo6akbqe3@vireshk-mac-ubuntu>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
 <23d3ed7edc8b859da8e7640f77cf3028ad5804f3.1568240476.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23d3ed7edc8b859da8e7640f77cf3028ad5804f3.1568240476.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-09-19, 04:02, Amit Kucheria wrote:
> This allows HW drivers that depend on cpufreq-dt to initialise earlier.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
