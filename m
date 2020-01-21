Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 104251444C8
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 20:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAUTFZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 14:05:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40069 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbgAUTFY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 14:05:24 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so1957479pfh.7
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2020 11:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pa59fYCDlAe6Tpwao7wMVi6YpE63nP24dCm06l2iicc=;
        b=ImkOggh07bXyDGZ5/RZe49clFsRhDpDFfmsQ2CJ63cUE/5jBCzcy5pNKeRTQ8ES55B
         mM3tBSmTjGO/z562nUCoeaJZaBO3v1e/uEoLtxVhRzIaWkx1FqFQcKBqVZXeTr1lrl5K
         mPR+YrzSRr0zPuKGgzTgzxboWVJ+td5/fYjJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pa59fYCDlAe6Tpwao7wMVi6YpE63nP24dCm06l2iicc=;
        b=H0wwsjwqC8vquMx65iMmkrEpLLJ9je2JRz3BXPPnxp139jnsb9EvTRPUAO270yWuBZ
         pItjKdFNI9S3UJeJ3zR8kjLLJcFT6t2HjSWn9jKD9TiVmaEJOOmQ37TkPaDIHAmYMZX3
         u97gFV+9Yr7F87sB0Vda/RtPk9TqR0/dEriYOFW4M7iSliLi+Z7bhLs28dLlkuProNFv
         Dim+7d8q1KDb11TCTsKif1RioDsedgfUmA+8VVMDVohcAwaTkitbXCXeJDOqPTwGo5QO
         102MdmJNypECcBh8C8Ttw4odiwpk73ByhgHLlXW5eBGH35NCvLkhGzC76SBknT5hG1Lb
         2TUw==
X-Gm-Message-State: APjAAAWiwvm5gOdeWmCbcz+1GMcO+uu4XOMR4YnpouJw5ETftEDZxEj4
        8OQxhqEolXJXeAQxXjLd5/Uuew==
X-Google-Smtp-Source: APXvYqxm51yEBdJrV3LGqLaPvhqBlzgHVrjIRyZodBwEGeiX8FCB2IV12uXzvx5oAHAAFK+2KrrOPQ==
X-Received: by 2002:a63:4850:: with SMTP id x16mr7279208pgk.334.1579633524281;
        Tue, 21 Jan 2020 11:05:24 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 80sm44717385pfw.123.2020.01.21.11.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 11:05:23 -0800 (PST)
Date:   Tue, 21 Jan 2020 11:05:21 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, ulf.hansson@linaro.org
Subject: Re: [PATCH v2 0/6] Add RSC power domain support
Message-ID: <20200121190521.GT89495@google.com>
References: <20190823081703.17325-1-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190823081703.17325-1-mkshah@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Maulik,

What is the status of this series? It seems it hasn't been updated since
you sent it in August last year. Do you plan to send a v3 in the near future
to address the outstanding comments?

Thanks

Matthias

On Fri, Aug 23, 2019 at 01:46:57PM +0530, Maulik Shah wrote:
> Changes in v2:
> - Add Stephen's Reviewed-By to the first three patches
> - Addressed Stephen's comments on fourth patch
> - Include changes to connect rpmh domain to cpuidle and genpds
> 
> Resource State Coordinator (RSC) is responsible for powering off/lowering
> the requirements from CPU subsystem for the associated hardware like buses,
> clocks, and regulators when all CPUs and cluster is powered down.
> 
> RSC power domain uses last-man activities provided by genpd framework based on
> Ulf Hansoon's patch series[1], when the cluster of CPUs enter deepest idle
> states. As a part of domain poweroff, RSC can lower resource state requirements
> by flushing the cached sleep and wake state votes for resources.
> 
> Dependencies:
> 
> [1] https://lkml.org/lkml/2019/5/13/839
> 
> Maulik Shah (6):
>   drivers: qcom: rpmh: fix macro to accept NULL argument
>   drivers: qcom: rpmh: remove rpmh_flush export
>   dt-bindings: soc: qcom: Add RSC power domain specifier
>   drivers: qcom: rpmh-rsc: Add RSC power domain support
>   arm64: dts: Convert to the hierarchical CPU topology layout for sdm845
>   arm64: dts: Add rsc power domain for sdm845
> 
>  .../devicetree/bindings/soc/qcom/rpmh-rsc.txt |   8 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 105 +++++++++++++-----
>  drivers/soc/qcom/rpmh-internal.h              |   3 +
>  drivers/soc/qcom/rpmh-rsc.c                   |  84 ++++++++++++++
>  drivers/soc/qcom/rpmh.c                       |  22 ++--
>  include/soc/qcom/rpmh.h                       |   5 -
>  6 files changed, 185 insertions(+), 42 deletions(-)
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.
> 
