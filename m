Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDD823DCD7
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbgHFQ47 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 12:56:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36648 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgHFQkm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 12:40:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id p3so27121834pgh.3;
        Thu, 06 Aug 2020 09:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NGFLJxMeBxJCNtUDHjRW6ZiLVs82vJu7FA4KSa9s8BU=;
        b=ZCPVEgjElsHlVvJFI36AFgZD2tNn/l0eRBgVjjNS3JYOwTnpUesShQ64aaQwziztbg
         hNS2kNv/jZWdMMypyaXYOLOf1gK0lwohQnM2IuUTgnPM+pzkqhAOPYd9s3zfA6Vb2t6Z
         nH1hT0Xeq1UVIW+HqUyIyuGrVzfJnSX5FHLlNVCrT8SGcU/Wf9YtG0qgmw3A5gRqCb+S
         5gH9zRtoFheT4myIHFBFrX8u//LKvDXTwmOuz3ZScaTlbR1bawzPlURrf11M740PNG2H
         EPTS99wPwEYaVIksq+qij8ptMZl5IAsheWyWQmWIeYqjtMm7m5kb/O/LOylbv3pPgKSF
         fnTA==
X-Gm-Message-State: AOAM530qhH3iew1NiCRmMKQP9mDUaZTgVmVHCEtMKicywPqteTiJN2dg
        COlVdatINMoMRr8rabbbY7jECEY=
X-Google-Smtp-Source: ABdhPJylkZQ+5iAfHEgte0gd4yrfCNYNVomE5IG2p4UtcVZBqQMjGgI/WCTWEagKSExRTf0dapNetA==
X-Received: by 2002:a6b:3bd4:: with SMTP id i203mr10428163ioa.205.1596723384461;
        Thu, 06 Aug 2020 07:16:24 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id a16sm1583882ilh.12.2020.08.06.07.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 07:16:23 -0700 (PDT)
Received: (nullmailer pid 782817 invoked by uid 1000);
        Thu, 06 Aug 2020 14:16:22 -0000
Date:   Thu, 6 Aug 2020 08:16:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] dt-bindings: cpufreq: Document Krait CPU Cache
 scaling
Message-ID: <20200806141622.GA782018@bogus>
References: <20200805131200.3234-1-ansuelsmth@gmail.com>
 <20200805131200.3234-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805131200.3234-3-ansuelsmth@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 05 Aug 2020 15:11:59 +0200, Ansuel Smith wrote:
> Document dedicated Krait CPU Cache Scaling driver.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/cpufreq/krait-cache-scale.yaml   | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.example.dt.yaml: qcom-krait-cache: l2-cpufreq: [[384000, 600000, 1200000]] is too short
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.example.dt.yaml: qcom-krait-cache: l2-rates: [[384000000, 1000000000, 1200000000]] is too short
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.example.dt.yaml: qcom-krait-cache: l2-volt: [[1100000, 1100000, 1150000]] is too short


See https://patchwork.ozlabs.org/patch/1341295

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

