Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3103D433C
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jul 2021 01:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhGWWYm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jul 2021 18:24:42 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:45916 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhGWWYl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jul 2021 18:24:41 -0400
Received: by mail-il1-f173.google.com with SMTP id z3so2942789ile.12;
        Fri, 23 Jul 2021 16:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MrXbRU0qaC0LeEuhcjlnMm4aRsbajEOUCb9TAnE+JIM=;
        b=NtteqRB/uyMfpPnZ0u54egNRe8plSElymsIe1SHnRIA9J/Q7TFLfJJbGxXVkmROCca
         elbKq+OgjEdqfVdi3XdQhI/SpernoMcF/RptE5fHu9aTrw/RiAyuGFfzBYcglB37LhD5
         I5MJ67BiwZbM6EEDEW0yC0yn1RuAcBW6onm027mY/DalkyCEHQ3ZMGuL8mNmVa9TD6Qy
         V8SNR4xJdj8KUnDObMgzo3o/RIirNHOPWkWHCoaLr8x8K3KX+B0hUkUpImoQgWll69Uo
         EFE93RaL2QfHIpSG9z+xTtCLaixrvISKE4rBPtpMuRWCAcVBHk+R1pE78Rl9gD9JigrT
         fojw==
X-Gm-Message-State: AOAM531QM/5ibQxkwWcTkyW9zMnPXDT01ifYMGCFodFhdmP6zuvpaL68
        +eNkFmPAjtqeLSUOVuY8sQ==
X-Google-Smtp-Source: ABdhPJyDqa2ABIha9680bJGuR90oTpYszCeb8Rsatgwor2yqPmrOwZ2ikQrM53eoL1/GZdLVeKs0Aw==
X-Received: by 2002:a92:7b13:: with SMTP id w19mr974197ilc.291.1627081514071;
        Fri, 23 Jul 2021 16:05:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o13sm16925461ilq.58.2021.07.23.16.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 16:05:13 -0700 (PDT)
Received: (nullmailer pid 2772770 invoked by uid 1000);
        Fri, 23 Jul 2021 23:05:10 -0000
Date:   Fri, 23 Jul 2021 17:05:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     David Heidelberg <david@ixit.cz>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-pm@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v5 02/12] dt-bindings: phy: tegra20-usb-phy: Document
 properties needed for OTG mode
Message-ID: <20210723230510.GA2772736@robh.at.kernel.org>
References: <20210717182134.30262-1-digetx@gmail.com>
 <20210717182134.30262-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210717182134.30262-3-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 17 Jul 2021 21:21:24 +0300, Dmitry Osipenko wrote:
> In order to support OTG mode we need these new properties:
> 
> 	- interrupt
> 	- nvidia,pmc
> 
> Add the new properties to the binding.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/phy/nvidia,tegra20-usb-phy.yaml     | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
