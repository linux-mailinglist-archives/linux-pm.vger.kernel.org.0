Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D928B2A9C5D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 19:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgKFSgK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 13:36:10 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40524 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgKFSgK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:36:10 -0500
Received: by mail-ed1-f68.google.com with SMTP id p93so2256075edd.7;
        Fri, 06 Nov 2020 10:36:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=isQEn/WGIzcD1/rQJHgyKiYzp/eybvhQKlIidDjmFmA=;
        b=qVB4jxXqzvScrJOpFs+t3G9yfHEZxHRxsQ5KbLd5kFBdTWzHZPz2SBQoELl9Yp1ciC
         NJ6470X0cf6GM0wtZ88liQrJruo143QmLB0yxTutJ3WalD0fXEKAVVbCKD5Ksaxl2oSM
         wKPrP2xUCR+VLdUQBfpNoB0U7xz+9IobJTHNPvEplRiQI9IWxAozfnXja/P4IiEFjGw2
         3BStX/utiT/tDc7CdWiEV3ulwFlnEdy4D07YEjX41lVQygLcmKt0bWxAIzFDwXrphjkh
         Un6PtDm7lQh2Fsp/abh4qy4nl6bbKrvdsjOYBqJk0PRxxEKaxObKInkjrb7lE9YhKcc9
         /gTw==
X-Gm-Message-State: AOAM532ROkYevIMij8ZMGrs4mTxi1ChAoZ3QMEUmsGbQlfIc4AiWFkby
        QNX4TL4lJGWr08hxSEKll4A=
X-Google-Smtp-Source: ABdhPJzm34++RkZ9i/6bHVN6gXnBfb/w4saUjJTF7dzV+wNMUHTg7CQscPnPW320PmoLmbR6sA3gpg==
X-Received: by 2002:aa7:dbca:: with SMTP id v10mr3419657edt.219.1604687767458;
        Fri, 06 Nov 2020 10:36:07 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id p1sm1463523ejd.33.2020.11.06.10.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:36:06 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:36:04 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 16/47] dt-bindings: host1x: Document new interconnect
 properties
Message-ID: <20201106183604.GO65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-17-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-17-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:52PM +0300, Dmitry Osipenko wrote:
> Most of Host1x devices have at least one memory client. These clients
> are directly connected to the memory controller. The new interconnect
> properties represent the memory client's connection to the memory
> controller.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../display/tegra/nvidia,tegra20-host1x.txt   | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)

Does not look like patch for memory controller drivers but I guess
better to keep it with others. Let me know if it should go via different
tree.

Thanks, applied.

Best regards,
Krzysztof

