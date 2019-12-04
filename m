Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED821126DA
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 10:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfLDJRG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 04:17:06 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:46953 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfLDJRG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 04:17:06 -0500
Received: by mail-pj1-f66.google.com with SMTP id z21so2722726pjq.13
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 01:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lMKKy9t0iWSR4/z3gVbW2YwCWQytCz8n363Y9SgDkLg=;
        b=AoaXn3dDFHX0ZWRCrotiHldBlB/HrbAlLuyfSzBLpifiSH9AVjZ1dj8Z7BaKH9srKf
         +nfYSDrlBV6KEf5TTRTVE940MSjDQV5a16P6WEbM93mSde6KBiZeA6nRAxw5Y25B/vnZ
         T5iVOgAJFmwHkTXfejyEXhk0jryeVIjlkrgZDB+IANQ7Ppjjw+WCfSoIoPyOmBk5/SC3
         m/4WwJOBPjBTvU3lKW7RnA9rmf7fJOKSPmSgGfctK+2LjzCuZV2ewflB92JKr429LENu
         2QaqPrTAuB5bm8jp/Y8wRk+pRvFHvaKUThzf3wRGmFAoCUvm0aIETHDh35mLioE6VHZK
         diMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lMKKy9t0iWSR4/z3gVbW2YwCWQytCz8n363Y9SgDkLg=;
        b=G8p5RUAsfsi50QdtY+qdVa7JL68dvp9SwBooWd/Hz1zHYZuwjhlxBBQVMh6GyTC01z
         1j6kViB6S7iIUc5UiR2NcsfPAIXuLoORVGBR2D2ADuJjbHM5uPGFWry39pG4qYFjT6YS
         4gEIJS+x/4MRHKGO+OxfdI+wIRVZ21t0EFGN8xgmdhlrBVwlnS47/jaelED+LOEvQ86O
         4tUOH3Gtmbsgzxe98h60UzEDuRqFQMjIkuCmKukL0iuSlrhDsNIPHVAA0VkG0xmOpep/
         NdI91SYJBgNf4BhKX5SaUhDyuFzGOUgd49Qe4+GzsU5N7Qzgq4IGBapaPnc0G73vCdu5
         Unew==
X-Gm-Message-State: APjAAAV2Iwi6veYJDqwLnLFFb5BrI9aksOQVA2FcLUIq4FXTsiFpQRPy
        ujLtGzlxm0ClN9Yvg8738w35Fw==
X-Google-Smtp-Source: APXvYqyPYVArtaO2xDdvtLX/Iko7lEdMxiXPCNH/Ly1Vnt2lfYUTEc78zQ+nQkBgCTp9YuIdrXgr5g==
X-Received: by 2002:a17:902:8507:: with SMTP id bj7mr2349143plb.69.1575451025955;
        Wed, 04 Dec 2019 01:17:05 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id n26sm6717142pgd.46.2019.12.04.01.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 01:17:04 -0800 (PST)
Date:   Wed, 4 Dec 2019 14:47:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sumit Gupta <sumitg@nvidia.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, jonathanh@nvidia.com,
        talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ Patch 1/3] firmware: tegra: adding function to
 get BPMP data
Message-ID: <20191204091703.d32to5omdm3eynon@vireshk-i7>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <20191203174229.GA1721849@ulmo>
 <9404232d-84ce-a117-89dd-f2d8de80993e@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9404232d-84ce-a117-89dd-f2d8de80993e@kapsi.fi>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-12-19, 10:45, Mikko Perttunen wrote:
> Now, my original patchset (which this series is based on) did add
> nvidia,bpmp properties on the CPU DT nodes itself and query BPMP based on
> that. A change is still required for that since tegra_bpmp_get() currently
> takes a 'struct device *' which we don't have for a CPU DT node.

I may be missing the context, but the CPUs always have a struct device
* for them, which we get via a call to get_cpu_device(cpu), isn't ?

-- 
viresh
