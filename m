Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72971250626
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 19:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHXR2Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 13:28:25 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44047 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgHXR2R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 13:28:17 -0400
Received: by mail-il1-f193.google.com with SMTP id j9so7957408ilc.11;
        Mon, 24 Aug 2020 10:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x7C6eQok8Pl7UAFU0rsUV0+mcmV/0wTU7nSxBfhdONU=;
        b=f64I7DgNzbLxLaQnXMunJZw4KYJ6lGCWrmUgDXGiwGXxh8er6TKzChrs++41rVg6ii
         qD88bvDZWqXlrUZDRG2GjSbonyyB4j0D/BWzk361Vi7qY9wt3lFN5hRKJoddtnv9IOVO
         kNvyU6zoXyyiV0tbwD9rXIkEDnEEVwW85gemPFyQr1Q1eX6JMNf5/656nYCHPMtIjcDN
         1Vq9yGfZIiaWWZxGljFOI9vfJB8uqxdlZxPti3tU+2cW39ET4qDDOYpKaV/wc8smnEqK
         eQEZtmvke6eTtAG6LIKox5zBBy5/iYknb0ORup9hvhCTmAaehLcc203pt2dIRh1SPPfu
         ZgAw==
X-Gm-Message-State: AOAM532nwip8f3v4qiorOW+YLDsko6vCNzCxMpiBDN2raVM6trBLyiKB
        gDf2Av9ORnkk63yr7+Jb3A==
X-Google-Smtp-Source: ABdhPJzkYfjUhbsSi6w7J4evk76kL04eVABwUGbo+mtIu1y8X5HK24uHDZUNBkjNVX1Iq4Z3YR///g==
X-Received: by 2002:a92:c7d4:: with SMTP id g20mr5927212ilk.40.1598290096298;
        Mon, 24 Aug 2020 10:28:16 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id y8sm6835601iom.26.2020.08.24.10.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:28:15 -0700 (PDT)
Received: (nullmailer pid 2933345 invoked by uid 1000);
        Mon, 24 Aug 2020 17:28:13 -0000
Date:   Mon, 24 Aug 2020 11:28:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH v3 2/2] dt-bindings: cpufreq: Document Krait CPU
 Cache scaling
Message-ID: <20200824172813.GA2932192@bogus>
References: <20200821140026.19643-1-ansuelsmth@gmail.com>
 <20200821140026.19643-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821140026.19643-3-ansuelsmth@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 21 Aug 2020 16:00:21 +0200, Ansuel Smith wrote:
> Document dedicated Krait CPU Cache Scaling driver.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/cpufreq/krait-cache-scale.yaml   | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.example.dt.yaml: qcom-krait-cache: clocks:0:1: missing phandle tag in 4
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.example.dt.yaml: qcom-krait-cache: clocks:0: [4294967295, 4] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml


See https://patchwork.ozlabs.org/patch/1349260

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

