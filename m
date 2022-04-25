Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8A250D8A9
	for <lists+linux-pm@lfdr.de>; Mon, 25 Apr 2022 07:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiDYFOC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Apr 2022 01:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbiDYFNz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2022 01:13:55 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3327112
        for <linux-pm@vger.kernel.org>; Sun, 24 Apr 2022 22:10:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id t13so125769pfg.2
        for <linux-pm@vger.kernel.org>; Sun, 24 Apr 2022 22:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=84kR6Ne3XN+sltkcwh/T1Tej1sQ2efwbcDr/K859dsI=;
        b=dN9wtsmeLae7F6wFK9gX7zDkbC7pO8fi49NOzAvN+FziFaQvJhVvGOXMvUzJ49ooDA
         IdHJ2hyB/xWo75MODlma39ciKNYlcH1DewSz/WIgv48sTW4Wjnm5ES4qowXDin+mSH8/
         guf0HP0LtYcsMkGJO5h8hWR5CtVhQQd93CZhutXYyOu+RFLzbuLgXS9fGM+Q33q3KocU
         EiGrkNh9QMKmERnZW9xog+piIG8uYQHpOTuQ6BvS+mUPbKFolqqGOga+USvw1wx4CQxq
         7IlNgYP4lNDmtkHO3PxzjdhdQb3i6r3qh8ng223W3HM3ullv5Cnc03p0QbyzgZmeKOm+
         SqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=84kR6Ne3XN+sltkcwh/T1Tej1sQ2efwbcDr/K859dsI=;
        b=VkMD1+a6UdD+iHt94NTmWU5OWSFD23+JpVMHTa22nciasjQaBMOSpogDC+s/sw95Fn
         iApL3PUKRBhtYnA5nUPjr9c3HF5iKCTLN8u0KlYyf7mEUFlPrIPMv5dH2nzBNxdeTT9u
         K/gyrveKqRkk3bGaJ746E/VtFZIwLFQqkNGaaQ0LKW/MhXuQsJicqQvB7kSiNeU9vPTl
         t6jv6x3TivBr8Z9az7DvEnvA281MUT6k4aNjWoGzYthS1ZGsQapZiMudczEddW+Upzwv
         NRP3iHO+4SPoVs4UPzG6UDLXUwYKYXcKDcpJxpyyCtnbmcb4iQS9HBxJ33fAcZq/Nggs
         lS9g==
X-Gm-Message-State: AOAM531jTC9F14U2Kqih5QuJqR1xmdmxLQftY6ntM/b4t6oUkiZ0X40+
        GBtbRAnPDur1R5U+iBpOGxd/gA==
X-Google-Smtp-Source: ABdhPJzGGW+GIrQOBy6BDvyB6yPlv6juol7Eg18fNiB0YyJ6APP5kw4YfaBWqD0Z9BK/KWxa2RwHqA==
X-Received: by 2002:a63:7d4a:0:b0:398:dad:6963 with SMTP id m10-20020a637d4a000000b003980dad6963mr13585899pgn.329.1650863452300;
        Sun, 24 Apr 2022 22:10:52 -0700 (PDT)
Received: from localhost ([122.171.250.232])
        by smtp.gmail.com with ESMTPSA id f127-20020a62db85000000b0050d3dd1138csm2207570pfg.126.2022.04.24.22.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 22:10:51 -0700 (PDT)
Date:   Mon, 25 Apr 2022 10:40:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V4 02/14] cpufreq: mediatek: Use device print to show logs
Message-ID: <20220425051050.6azd3izcuoa3ybj4@vireshk-i7>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
 <20220422075239.16437-3-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422075239.16437-3-rex-bc.chen@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-04-22, 15:52, Rex-BC Chen wrote:
> - Replace pr_* with dev_* to show logs.
> - Remove usage of __func__.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 54 ++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 26 deletions(-)

Applied. Thanks.

-- 
viresh
