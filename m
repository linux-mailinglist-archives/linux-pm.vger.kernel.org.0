Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137EF250E96
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 04:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgHYCGB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 22:06:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40283 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgHYCGB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 22:06:01 -0400
Received: by mail-io1-f68.google.com with SMTP id q132so443893iod.7;
        Mon, 24 Aug 2020 19:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZGN03Bx1J0J0U0FIPaFphtLZ9Qz4EjlnoumNfdWnE9c=;
        b=UOCbcnAAG1Fu60Kk+zV068Ithtw2/X18nmIGYWqg3R23a8YhdQpgEzLPYXmNy4TDpl
         Td9TmHjlBSzAWsVAf383GdB25gGzKqEgBHyrTlWV2t7YV3DsjfI0WE/cwO1Thus1twM8
         n4ISAtaTWoZGz+3wFU3qRbfcvVT1UiQD6qaqoDuUCFiK2VH/ogf2CW7yPV+5QasTmxPl
         HsvpeANU4Bje+wgdNjbDK9JZwfVpG7Kywx/aMOP32fNKf9KdMGBcArqncZ2DSInl0xXz
         nPj+FXLmmjQgu8E6XZXatba10C3oholCq15VD6a8KPHt597o3zgc6gVDT1M9szXjieSU
         xe9g==
X-Gm-Message-State: AOAM531Xpb0j4HyhLVzmHJMnW26NTPeARyyuJ/6QTQFxSnRcIy/11LC4
        QbS/KF3+wl6cPPbs4T76Sw==
X-Google-Smtp-Source: ABdhPJzUtU0QZeu+947aXt+98/sl+b0+sMwwehvlhvzbucSiiO/JKakQGhWvD0wEf8EruOR1fygJ3g==
X-Received: by 2002:a02:6066:: with SMTP id d38mr8484706jaf.105.1598321160132;
        Mon, 24 Aug 2020 19:06:00 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id c88sm8445986ilg.5.2020.08.24.19.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:05:59 -0700 (PDT)
Received: (nullmailer pid 3782782 invoked by uid 1000);
        Tue, 25 Aug 2020 02:05:55 -0000
Date:   Mon, 24 Aug 2020 20:05:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonghwa Lee <jonghwa3.lee@samsung.com>,
        linux-tegra@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, David Heidelberg <david@ixit.cz>,
        Andy Gross <agross@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Bruce E . Robertson" <bruce.e.robertson@intel.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] dt-bindings: battery: Add temperature properties
Message-ID: <20200825020555.GA3782752@bogus>
References: <20200813213409.24222-1-digetx@gmail.com>
 <20200813213409.24222-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813213409.24222-2-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 14 Aug 2020 00:34:00 +0300, Dmitry Osipenko wrote:
> Document generic battery temperature properties.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/power/supply/battery.yaml        | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
