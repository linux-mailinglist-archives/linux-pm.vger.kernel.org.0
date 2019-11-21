Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37B06104A4B
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 06:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKUFcO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 00:32:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38479 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfKUFcN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 00:32:13 -0500
Received: by mail-pf1-f194.google.com with SMTP id c13so1071132pfp.5
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 21:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yE3H52ST3bCRAdHmUDzhL/7UmgqQkrfup+4Ir818ZIQ=;
        b=M7BBqQwbeIa8JPve1L1VxPnrWig2i9WY0ZyJQqNtb4XAMmkDMSCMWoXgsK/BUgwDUG
         +d9RoKdI2qyNSdaD+nSIAoT7F4oQIUqrWJd/nlez1kwBmCmhxwHQwABfxrJ5IP+wo2Np
         tAso4ANpMBRdhCbXYBWd9wpXO9r11KzHWL9BoyF9oNUi9p7j3jazmA2qZctVscY3YyDJ
         GWW/g07xgm2+CEP4ffmAH+DyewVtNhP/yJaOVzOJK5pztvZNrR1n9PqUzwRYF8FWjpFf
         +nQ0SA77fRXYfHhgPIg2TTZCDsMmEdFh0XpHNs3hB8UFqQTbHJ0EM/l3gY7KwLMyAD30
         cNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yE3H52ST3bCRAdHmUDzhL/7UmgqQkrfup+4Ir818ZIQ=;
        b=cFHrGo6Wdbyouh8rvXdxJnZ9JveQ55Crki3wvw4pTfqjtp/RXuRh+UvbSJBGdQTXzc
         u4qA6+jtUvQP8qZukq5ih8ZUrwDiGP0PAmVbJx4xdrBplrnjgPsiPQh+LGW+gFvye2Wg
         n1gJ7JHOZrL6Gl0wXFmatg0IHox/3P6F+r/dy9u1XIDWXsOl8Ga8so6PAXB0NubpjbNd
         BVWKKeLg4aBS9medR2tFmxgyJ0kCduFFkmNXKRpEMHVCeLFOcJ1LwQSfHlfq6YTBR5SU
         8yEIRE+3ijj4O0stvtwCEgX1CThCRHkJZvkvYbERttZjiqaJ0VTiG5xYHfJ7AUdbh8qQ
         ZNTA==
X-Gm-Message-State: APjAAAUt9L5lTc1Ao1h3SQePfmV0+xopLPMmsxBqtFsOj3+yRynI04R8
        kgZjBujy5fgyDUbs2glqAGK8Yw==
X-Google-Smtp-Source: APXvYqwNM9dZdansKs8pKoOeaen5b9vqImpjSGgtw89kbCl3/6894oiyg46ElaulgywEwwJJ0Y0fIQ==
X-Received: by 2002:aa7:8421:: with SMTP id q1mr8754271pfn.174.1574314333119;
        Wed, 20 Nov 2019 21:32:13 -0800 (PST)
Received: from localhost ([223.226.74.76])
        by smtp.gmail.com with ESMTPSA id p16sm1083971pjp.31.2019.11.20.21.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 21:32:12 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:02:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/11] thermal: samsung: Appease the kernel-doc deity
Message-ID: <20191121053207.gyulu3vb3caaituv@vireshk-i7>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
 <1ded1697c6e5eff11b034b3302b9c79e88fa9c42.1574242756.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ded1697c6e5eff11b034b3302b9c79e88fa9c42.1574242756.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-11-19, 21:15, Amit Kucheria wrote:
> Fix up the following warning when compiled with make W=1:
> 
> linux.git/drivers/thermal/samsung/exynos_tmu.c:141: warning: bad
> line:         driver
> linux.git/drivers/thermal/samsung/exynos_tmu.c:203: warning: Function
> parameter or member 'tzd' not described in 'exynos_tmu_data'
> linux.git/drivers/thermal/samsung/exynos_tmu.c:203: warning: Function
> parameter or member 'tmu_set_trip_temp' not described in
> 'exynos_tmu_data'
> linux.git/drivers/thermal/samsung/exynos_tmu.c:203: warning: Function
> parameter or member 'tmu_set_trip_hyst' not described in
> 'exynos_tmu_data'
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
