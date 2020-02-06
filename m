Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29216154E3D
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2020 22:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgBFVoN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Feb 2020 16:44:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42504 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgBFVoN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Feb 2020 16:44:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id e8so90304plt.9;
        Thu, 06 Feb 2020 13:44:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nCZ9ayqGFGGOYCf7mf3ecb4tbvZDda1tYkdu0cB2PR4=;
        b=U4giyh4y0NAhxuyDtd+A9nir0lC/F2p9rdV3VpM1LFY6Jp+EiXSrd3W0STUI63nIEL
         tl6sQF2CmpkihNdl+51XXjLlk3PAzpT4P1HP+O5EpWrgLj5MqnRjzssIPRVRKtoFS3V1
         24OGKscdWR6lXArp9QwA3acuqsWEJrIFwTkjna4pHiE3IisuGvSISSGw0xffgi8BrKSl
         E0aBIo1YdA4fH4tChU0wXfJ1EEqPKBKVPEsPYsqdXZDwLRNref0HOC85nNkOwgpfgRJD
         fC5/w009hEs9hd6d+cTsDsIsSmK9GvXJY5KUv4delQub3V6QiVRxoqB8zYYC8ytAesW5
         fTjQ==
X-Gm-Message-State: APjAAAVxltD438GEjilld/m6b/3fj8GW3+jX7h7C4KOBwibPUP5FaaTu
        IDN64M/be7KDCtYIJhvZAQ==
X-Google-Smtp-Source: APXvYqzPnEQi9AlKJV7dkCP3bX1PSsZSNp5hyLTeKDDKyOAazqddsO1VbrfRdnm25lzXK+TMcPs0QQ==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3mr6259832plo.282.1581025451046;
        Thu, 06 Feb 2020 13:44:11 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id a18sm340710pfl.138.2020.02.06.13.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 13:44:10 -0800 (PST)
Received: (nullmailer pid 30200 invoked by uid 1000);
        Thu, 06 Feb 2020 21:44:08 -0000
Date:   Thu, 6 Feb 2020 14:44:08 -0700
From:   Rob Herring <robh@kernel.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        sudeep.holla@arm.com, Lorenzo.Pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org, rjw@rjwysocki.net,
        Maulik Shah <mkshah@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/6] dt-bindings: soc: qcom: Add RSC power domain
 specifier
Message-ID: <20200206214408.GA30136@bogus>
References: <1580905572-22712-1-git-send-email-mkshah@codeaurora.org>
 <1580905572-22712-4-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580905572-22712-4-git-send-email-mkshah@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed,  5 Feb 2020 17:56:09 +0530, Maulik Shah wrote:
> In addition to transmitting resource state requests to the remote
> processor, the RSC is responsible for powering off/lowering the
> requirements from CPUs subsystem for the associated hardware like
> buses, clocks, and regulators when all CPUs and cluster is powered down.
> 
> The power domain is configured to a low power state and when all the
> CPUs are powered down, the RSC can lower resource state requirements
> and power down the rails that power the CPUs.
> 
> Add PM domain specifier property for RSC controller.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
