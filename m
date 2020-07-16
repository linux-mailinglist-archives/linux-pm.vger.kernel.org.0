Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E773222280B
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 18:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgGPQLU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 12:11:20 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43846 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbgGPQLU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 12:11:20 -0400
Received: by mail-il1-f196.google.com with SMTP id i18so5508929ilk.10;
        Thu, 16 Jul 2020 09:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cbUUjgcnlKBB1y/HiNXUfJhKluzYQVIQ9rFJ6Jchx6Y=;
        b=W8W/78cRMTbfyKz9nCEqBxnFvzZIYtWZ13uKkIKWBvWhWPFeQgKDwV6t0atv/shkBr
         RN8dCMqHzS5HHeV4YFwrmlYYW1I9xO2sOV4j9UQ1isMBPdikceg4gGFfks9TVoq7NHQ3
         P40MfJXWWj+rvUqIgB+kIJO4htoYxkjzheC4PSX0rxhfWGd3R99ITtzi/PwEVY/DNHAn
         fuahjdiG0Po/rnmmGS2g5HdXhKrg3iX3rnijlSD4qEhGKBf2HLlMfDmgcRMyrL0FWF+F
         ++fl0GUCvhhsjOfMqFgDO/YjEWAeT67OTz3eQu07tGjlL9ZdVLWdE1547/Yt1JbnH/jT
         hiBg==
X-Gm-Message-State: AOAM533XqmJJDD/uhqpVNqZuFx8u22oEeTheXXXH3PZSwH7aKQqgl+aE
        D13Hn58JbheS+xwrJ3Pu8Q==
X-Google-Smtp-Source: ABdhPJykgNPAQ0ukdx+9RHPQeuBGQg3i83rE/+gk01ha61WNVg1+tryT5iPiCWo/Zuq9lN7wfapCDg==
X-Received: by 2002:a92:d148:: with SMTP id t8mr4803913ilg.12.1594915879180;
        Thu, 16 Jul 2020 09:11:19 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y12sm2963784iot.49.2020.07.16.09.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 09:11:18 -0700 (PDT)
Received: (nullmailer pid 2444477 invoked by uid 1000);
        Thu, 16 Jul 2020 16:11:17 -0000
Date:   Thu, 16 Jul 2020 10:11:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        viresh.kumar@linaro.org, catalin.marinas@arm.com, talho@nvidia.com,
        bbasu@nvidia.com, will@kernel.org, linux-tegra@vger.kernel.org,
        mirq-linux@rere.qmqm.pl, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ PATCH v6 1/3] dt-bindings: arm: Add NVIDIA
 Tegra194 CPU Complex binding
Message-ID: <20200716161117.GA2444431@bogus>
References: <1594819885-31016-1-git-send-email-sumitg@nvidia.com>
 <1594819885-31016-2-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594819885-31016-2-git-send-email-sumitg@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jul 2020 19:01:23 +0530, Sumit Gupta wrote:
> Add device-tree binding documentation to represent Tegra194
> CPU Complex with compatible string under 'cpus' node. This
> can be used by drivers like cpufreq which don't have their
> node or CPU Complex node to bind to. Also, documenting
> 'nvidia,bpmp' property which points to BPMP device.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../bindings/arm/nvidia,tegra194-ccplex.yaml       | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
