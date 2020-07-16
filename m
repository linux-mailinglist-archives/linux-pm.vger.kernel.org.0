Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0200222B8A
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 21:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgGPTHW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 15:07:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38911 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgGPTHV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 15:07:21 -0400
Received: by mail-io1-f67.google.com with SMTP id l1so7182410ioh.5;
        Thu, 16 Jul 2020 12:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G6dTG9UH4b6ykHKCTmdcq2PPGZi935hwfuAzCkCoreE=;
        b=mEigJewzQP0wkYRsbshQ4rsG3H/5EV8PmGdaqlgtfyLBDPfoxjRgeZfgHcGRLibmWU
         rjpalXWgH8dOlB6B00O7K0x8ubt01c/+lwN+dexXFjAy4mJpzCTChYTv7mHUxaOkLyTl
         EmqGhOFTRgt4Fstwa60CWm3MltGODhx7QexODNg//ji9N6AEu1O78LYW3LGth196sX24
         i2TeuknrW9b/dp1lPD8YbukgvT8WUoPZ/EibHhLKqlX1abfLDAmxeMM3W39qnMTnr/8i
         CXD0fBp5KFsHcb5lvcRRDdXJJEPZZK5FXlaov7nMMdhf0zvXHAH1Sn/NCukuVA8x20By
         /YUg==
X-Gm-Message-State: AOAM531rMx7dNzjvKHu9FgUJEAqZGDTz+zcO1Hs4cDIhJ+XPInKREqr/
        sIISBimxdEVTcpVVh2n3jA==
X-Google-Smtp-Source: ABdhPJx9XPx9ju2mKOiII++3K2uqyxj3tmJirr4/6/QpB07uSd1tmgvamnP/6OpIjJ5+MD07MJLR6w==
X-Received: by 2002:a02:30ca:: with SMTP id q193mr6845522jaq.125.1594926440640;
        Thu, 16 Jul 2020 12:07:20 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w7sm812084iov.1.2020.07.16.12.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 12:07:19 -0700 (PDT)
Received: (nullmailer pid 2676844 invoked by uid 1000);
        Thu, 16 Jul 2020 19:07:18 -0000
Date:   Thu, 16 Jul 2020 13:07:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v4 4/7] dt-bindings: thermal: tsens: document ipq8064
 bindings
Message-ID: <20200716190718.GA2676798@bogus>
References: <20200716022817.30439-1-ansuelsmth@gmail.com>
 <20200716022817.30439-5-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716022817.30439-5-ansuelsmth@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 16 Jul 2020 04:28:13 +0200, Ansuel Smith wrote:
> Document the use of bindings used for ipq8064 SoCs tsens.
> ipq8064 use the same gcc regs and is set as a child of the qcom gcc.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 50 ++++++++++++++++---
>  1 file changed, 43 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
