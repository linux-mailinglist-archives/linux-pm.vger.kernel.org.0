Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2905EA91F3
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 21:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbfIDSko (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 14:40:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46231 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732798AbfIDSko (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 14:40:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so21041859wrt.13;
        Wed, 04 Sep 2019 11:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wDpdMlMCF5UrovGjF4Va2FMMy9gFIfRsLeQXmXiaV3g=;
        b=D+mkB834o7u+D0K5/oNHvDZV8qN0Zb/HFP2C86d8N0wIao+bRF75NBPZ7cKvvoghVn
         y0iqo8dKIhruiSDxrGIz+/A906I7wGUK7LkTce54qrFc7n61jqnuIlgy5lhZo1d3b/el
         IsVm6gUImJPr8bczueedN8Inpwd8pJ3BRo99SUfywj/mthRVZd8C3B9Wt+lNnasfy8JV
         R0ZQ8KfZDJDw/kLEy7GhlSOsxWxb7Pgfu2ra45DzARcF4LjZCssmgb1Sh+h6L6UWY6fL
         m6FYyqiYA7+mh1FlgFaowliQPZJ9vj2oj19IEm4riNNq9/EFYFVNneqHijeVw8uyk2oA
         RQLg==
X-Gm-Message-State: APjAAAU8pwDVbJegRqsiDHxDj3APuxkxLHbZrX9igNGJ/mwdyQNYbl9Q
        G5Aft1/TifixRH8TYi/MUEM=
X-Google-Smtp-Source: APXvYqxvtG9kHPmcaKLv3d1DsMI6LazeZbKqnHU6FsxKP7huILUBq0jw4mH4+uhsH812Uk0oEnJa9g==
X-Received: by 2002:adf:c613:: with SMTP id n19mr29554578wrg.109.1567622441839;
        Wed, 04 Sep 2019 11:40:41 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id 207sm6841451wme.17.2019.09.04.11.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 11:40:41 -0700 (PDT)
Date:   Wed, 4 Sep 2019 20:40:37 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, b.zolnierkie@samsung.com, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v13 0/8] Exynos5 Dynamic Memory Controller driver
Message-ID: <20190904184037.GD12918@kozik-lap>
References: <CGME20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8@eucas1p2.samsung.com>
 <20190821104303.32079-1-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821104303.32079-1-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 21, 2019 at 12:42:55PM +0200, Lukasz Luba wrote:
> Hi all,
> 
> This is v13 which makes cosmetic changes. It is based on current mainline
> (v5.3-rc5) with with devfreq/for-next where there is a PPMU patch [1].
> 
> The patch set adds support of Dynamic Memory Controller for Exynos5422 SoC.
> The driver supports Dynamic Voltage and Frequency Scaling
> for the DMC and DRAM. It also provides needed timings for different
> speed operations of the DRAM memory.
> There is also new generic code in of_memory and headers which allows to parse
> LPDDR3 memories defined in device-tree.
> 
> Here are the last changes suggested by Krzysztof during his review.
> For the previous changes in older revisions please refer to [2], there is
> more detailed change log.
> 
> changes:
> v13:
> - skipped patch with chipID changes in DT, since it is not used anymore,
> - removed license comment in of_memory.c since SPDX has been merged,
> - aligned comment to the current fields in the structure,
> - changed printed warning when timings are not found,
> 
> Regards,
> Lukasz Luba
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/commit/?h=for-next&id=b617376df8f01c975dee66802f4da16291f92079
> [2] https://lkml.org/lkml/2019/7/22/251
> 

Thanks, applied entire set (except last defconfig patch) to two topic
branches, either for v5.4 or for v5.5 (it is quite late). I'll take the
last defconfig separately.

Automated tools found few issues to fix, please send incremental
patches.

In general, for new drivers always run automated checks - Smatch and
Sparse. Coccinelle is also recommended. Checkpatch pointed missing
compatible documentation - need to be fixed (see
https://elixir.bootlin.com/linux/v5.3-rc7/source/Documentation/devicetree/bindings/eeprom/at25.txt
as an example).

Best regards,
Krzysztof

