Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D43250EB0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 04:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHYCIg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 22:08:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40534 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHYCIf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 22:08:35 -0400
Received: by mail-io1-f67.google.com with SMTP id q132so448651iod.7;
        Mon, 24 Aug 2020 19:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rftte33K9X8W4i2yhAHfYadgnzv4cujRdhAJKZI2Ty4=;
        b=iZOWsfzDRiu63QBoJqqfxsGynJKsQMEfCjBWyRoKktjMoFf1T2JMdu7o67L45qLd6S
         ERyl3sfqT3Du3VDBkZUO7BC+ax3lRTXug2tE3LcHtp1tiQf0MUHFtqCU2E/+Jltg5ojl
         HRxWXyEU1hW/jewTLlGSKvSoMmNbdU/sx1dT/tmjXj6ryCDTDEm7D0uXzsLicpzmM0if
         zhjxSkl61uryQvcUwjVQpGv6ffVg8oznFgM9+HFQH0fl2cVcqNlDiY97LWtgTBmm5sDv
         M0oReuXUhgPu3/95wjbArgrowT1QghyOvD2giNBdRM8igVBj2agcLTeYUXaeJ4zEgFf5
         TqUQ==
X-Gm-Message-State: AOAM530BplRT6Z8W7gRWzBVaRiBIt2THEYuNHLCdkbWgpF0a+a6416Pt
        o+JsD+CLP5+nnMsvYMdJxQ==
X-Google-Smtp-Source: ABdhPJz1vzKft6egaSzEgZqE3U+MF2iN7p7VQ4sVzHA8LE6oqB/qexZ7jcHxbimsqXP33WOz1cUejw==
X-Received: by 2002:a02:9f87:: with SMTP id a7mr8190898jam.35.1598321314588;
        Mon, 24 Aug 2020 19:08:34 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id f18sm8399898ilj.24.2020.08.24.19.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:08:34 -0700 (PDT)
Received: (nullmailer pid 3787077 invoked by uid 1000);
        Tue, 25 Aug 2020 02:08:32 -0000
Date:   Mon, 24 Aug 2020 20:08:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Vinay Simha BN <simhavcs@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        "Bruce E . Robertson" <bruce.e.robertson@intel.com>,
        devicetree@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: Re: [PATCH v3 02/10] dt-bindings: power: supply: Add device-tree
 binding for Summit SMB3xx
Message-ID: <20200825020832.GA3787024@bogus>
References: <20200813213409.24222-1-digetx@gmail.com>
 <20200813213409.24222-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813213409.24222-3-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 14 Aug 2020 00:34:01 +0300, Dmitry Osipenko wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Summit SMB3xx series is a Programmable Switching Li+ Battery Charger.
> This patch adds device-tree binding for Summit SMB345, SMB347 and SMB358
> chargers.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../power/supply/summit,smb347-charger.yaml   | 152 ++++++++++++++++++
>  .../dt-bindings/power/summit,smb347-charger.h |  19 +++
>  2 files changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
>  create mode 100644 include/dt-bindings/power/summit,smb347-charger.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
