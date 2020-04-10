Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33BA11A491D
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 19:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgDJRhS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 13:37:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44015 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJRhR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 13:37:17 -0400
Received: by mail-oi1-f194.google.com with SMTP id j16so1950987oih.10;
        Fri, 10 Apr 2020 10:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xW8e7XbTL1MjtsBDuTG0LkmWBpzWpAePyK8vKyb+Asc=;
        b=j7yU23VuF725xF58SK5Roc/Cfsm3zEWJqbQzhsbRD5se3e6il2B2lQEeB+SRlg1tVK
         gBmi0I5uD+O/WsWUwXCNbtQh7QicOh36IThLAdiBnz05QDI8E+wXOuwLlcu5Tl/ee38v
         DaEJxm/i1NycW4TnsKJPmlHNjnmlm9epsERI7egU7nnrb8wPSfIU3OVReTgFe9KSFAil
         5n9VawFt9n1A5wuu0SRXyk+4EA+/gxJvhdxNMjupgzvlLF9hcehDxPmOwgmi2Z3PAbk9
         KX25K9pQIj7ytxmBfIb8FhG2kRQzWtrY3gHatIziq0mzqx1xbe77Nt2SB1xMeZcHVSRu
         lUAQ==
X-Gm-Message-State: AGi0Pubs3H9v50p3BWl0I7X93w5YRsYemEVPajmcRqJ4hkWKyroQqt9L
        Qrb2lEzp+ZJ7taRpm1CTAA==
X-Google-Smtp-Source: APiQypJmdA1J3nB4xGtREUEBTDio59zX9/RIygF9tZZ99KWP0wkysu/Kl5MeCvmgcKTQBow3llIrtg==
X-Received: by 2002:a54:4f90:: with SMTP id g16mr4030956oiy.150.1586540237288;
        Fri, 10 Apr 2020 10:37:17 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.cgn.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id y8sm1411323otq.76.2020.04.10.10.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:37:16 -0700 (PDT)
Received: (nullmailer pid 1486 invoked by uid 1000);
        Fri, 10 Apr 2020 17:07:15 -0000
Date:   Fri, 10 Apr 2020 12:07:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 04/22] dt-bindings: memory: tegra30: emc: Document new
 interconnect property
Message-ID: <20200410170715.GA1255@bogus>
References: <20200330010904.27643-1-digetx@gmail.com>
 <20200330010904.27643-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330010904.27643-5-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 30 Mar 2020 04:08:46 +0300, Dmitry Osipenko wrote:
> External memory controller is interconnected with memory controller and
> with external memory. Document new interconnect property which turns
> external memory controller into interconnect provider.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra30-emc.yaml     | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
