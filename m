Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D252D6E53
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 04:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392029AbgLKDHS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 22:07:18 -0500
Received: from mail-oo1-f66.google.com ([209.85.161.66]:34784 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388364AbgLKDHM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 22:07:12 -0500
Received: by mail-oo1-f66.google.com with SMTP id t63so1811922ooa.1;
        Thu, 10 Dec 2020 19:06:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tTEMRb7V1p2F9KCydXVvXfb48BNtn6HMFTOoKMCdUp8=;
        b=n3QQ+ClhRJfv3/C7HG3JBKeMJnkxX7gGm+wpABiYEaZF1A8S8JeenK8Srz1MkSGAMb
         CNsEkWBr0CB03p8Q4JCKknsi1rvsySsuaL/Nz0UlE5m9LeAxao1zyOK80MWE3spacJlq
         AglaoBE16zWXxfRoXlETDe1uobKKHW2u+kFz60oDFGsnvoCkuwKCCktCwvwp+04f2ao6
         GvgBmBeN9Vm02vJTiEfOjeHoNS6y4NViRRLKYjXqfYtMs2gr8i4nHKZOFywLaklXKe6V
         4qNgBYRxp7WE251WdS3YK5z0vQcCOrzNdAt8O9wk8ms94h8uGDSig1CvxRP+73WcvVPe
         pYLg==
X-Gm-Message-State: AOAM531H5HSpmou8ms3c9CdiuF6NWbzbTO72XRsLRiVbwBvXEgjiq8PY
        PFg9UCXdQs7BLJfVC06+TskpZ6fQQg==
X-Google-Smtp-Source: ABdhPJzwCZ/LdhdXGPVFCFUrIUwiHobPQlW+a/7pgy6NOGroMHgb/L5um7BEfax0rbsXdfVptKgMgg==
X-Received: by 2002:a4a:c60c:: with SMTP id l12mr8321136ooq.45.1607655991897;
        Thu, 10 Dec 2020 19:06:31 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p8sm1500250oig.22.2020.12.10.19.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:06:31 -0800 (PST)
Received: (nullmailer pid 3545571 invoked by uid 1000);
        Fri, 11 Dec 2020 03:06:30 -0000
Date:   Thu, 10 Dec 2020 21:06:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Klein <michael@fossekall.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] Documentation: DT: binding documentation for
 regulator-poweroff
Message-ID: <20201211030630.GA3545539@robh.at.kernel.org>
References: <20201209210221.385188-1-michael@fossekall.de>
 <20201209210221.385188-3-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209210221.385188-3-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 09 Dec 2020 22:02:20 +0100, Michael Klein wrote:
> Add devicetree binding documentation for regulator-poweroff driver.
> 
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
>  .../power/reset/regulator-poweroff.yaml       | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
