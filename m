Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FB43053BA
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 07:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhA0G5r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 01:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhA0G4A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 01:56:00 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A89FC061756
        for <linux-pm@vger.kernel.org>; Tue, 26 Jan 2021 22:54:45 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id q20so575518pfu.8
        for <linux-pm@vger.kernel.org>; Tue, 26 Jan 2021 22:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pTwgFUD18J10kzxHrbvYTlK2Fz95pDqrTymbde1eXTk=;
        b=CtmoehdYMCxgJ5YmaTYJuEs5nO9uBsWNBvxyXHYBnpftWXZ3YRAlxq7SquRby76z1A
         l8I12es42UxKGwSqmCtf1ISe3ycHpxOEyiKjiGblAAdubB11uNFvDpbR+S4NGfOQMgHn
         FX6B9qkDUrmEf8yMsGEVN43kqyGIlNsOc/LVilJlOsbgOsa7D5Wkm6BmOtQrFCQ1l+DX
         AnUqA83ju1h2yi3vMV10royAHLMIbRDHWDFKmgdrdpKyxr+njMKV17iz0mYrYpG9Oi6e
         gNs50EOPlg1b6DY7cWkIAXvU9YqpfYUc+eQjY+D9VUOAP4k7aYiUqzOxH7JD0an1JCl3
         97sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pTwgFUD18J10kzxHrbvYTlK2Fz95pDqrTymbde1eXTk=;
        b=RzSz5tYj2eafdyxO4VxZKNHudzCrfpLNYSUSb3wJfYkYMineChKxEDaw9wJKKksqps
         WFAduh2c8ab55DIygeD5tpgAUK2wsowj2BeHJzB1yBpyu1q/4fuorICjTq0PWyOO6rne
         irRyE3+aeSqLXellEVrHZgbPgQdsxKOzjj+FzaInYB5ogUVHsh+k0hFeNFomzdw4LlV+
         8yJo0swhzPfROQrBVagup1G2yXia9QHazNEH1/QLt8sToGEkaFaqJ7g8HwtJvCgEs7Lt
         NL3SmFgdJ6MB9D2z0c/IHGGpmWwws6BiWHSiaGJs/foNwjLBoPgpIFHVd22+J+yWCmxH
         p9ww==
X-Gm-Message-State: AOAM530nB6QJ0DwTXUOeDk9NggY0ZH3dSOjGSaY3TLffdX6aY0Liy2re
        Cr/WN4/HOpVgsl1maX8fsqCE9A==
X-Google-Smtp-Source: ABdhPJyshWiqC8C9nN9XUvgxFRAppVMCfz7DwX+Y0wlAVXrVNbN/tlOICftJZu61My0PrLIv2Wj99w==
X-Received: by 2002:a63:33c4:: with SMTP id z187mr9716930pgz.312.1611730484495;
        Tue, 26 Jan 2021 22:54:44 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id q22sm1200065pgi.66.2021.01.26.22.54.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 22:54:43 -0800 (PST)
Date:   Wed, 27 Jan 2021 12:24:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/4] OPP API fixes and improvements
Message-ID: <20210127065441.p5v7einprkpiinab@vireshk-i7>
References: <20210120222649.28149-1-digetx@gmail.com>
 <20210122073439.yadzqwodsyscl2ac@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122073439.yadzqwodsyscl2ac@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-01-21, 13:04, Viresh Kumar wrote:
> Patch 2 can be applied only after the dependency patch for the stub
> definition gets merge in Linus's tree. I see that Mark has already
> queued that up in his for-5.11 branch, so it might be part of next
> -rc. I will apply 2nd patch then.

The consumer.h patch landed into Linus's tree this morning and hence I have
applied the last patch 2/4 from this series as well. Thanks.

-- 
viresh
