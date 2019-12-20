Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCED21284EF
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 23:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLTWgL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 17:36:11 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42207 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfLTWgL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 17:36:11 -0500
Received: by mail-io1-f68.google.com with SMTP id n11so4233747iom.9;
        Fri, 20 Dec 2019 14:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r/ujD9cpeTVxLA7xaDbDkgLLbv59I8EnWN3w9PFRh2g=;
        b=CfQI50th2kD8QYPeoNjILEDx6726AeCW7JS6qxw3LWTaNzvPxTx/4TP/fgR11OWClX
         pZhJumWHdewnNbjwmj0zb3ESfqlGwdJsvJdIVd3x6PleJeTO5U5K27+qE8h4AVHMHpC1
         HQMZqd+73SkIs0vA2wSxtzyDmpIMkjmBnY+lzVeOQAt+pj8r80dVkbiVM/P/tKmfQ1fW
         DFoOYqgMgKRUcbZ3d68PcRVAb5ubot/VB6WUsV7oqnfvUcnNUrAT4OgJ0h9/b++5Nctj
         woAl5VLU/FkbvauujBPYK/lRWsR3SScbQgpmmi7buRigGjFASXu7ines3uVadN0ycDYA
         1kyg==
X-Gm-Message-State: APjAAAVIkMpJupgwb85sAWJr/9yxjZDOEv16MOZ1q6ek3umO93i/UcM4
        OCZNDkXa2SgJvi8hUFzhug==
X-Google-Smtp-Source: APXvYqznRk6G0L20Qoe2oj7Zw9Ec8BirMdFnF1btWzmGivMJBa/bk89K1dHrEAE9tQQWsYloq5Ln2g==
X-Received: by 2002:a02:cd9c:: with SMTP id l28mr14138518jap.46.1576881370878;
        Fri, 20 Dec 2019 14:36:10 -0800 (PST)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id e1sm5446541ill.47.2019.12.20.14.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 14:36:10 -0800 (PST)
Date:   Fri, 20 Dec 2019 15:36:09 -0700
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     tiny.windzz@gmail.com, vireshk@kernel.org, sboyd@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH] dt-bindings: opp: Convert Allwinner H6 OPP to a schema
Message-ID: <20191220223609.GA8940@bogus>
References: <20191219084623.944458-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219084623.944458-1-maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 19 Dec 2019 09:46:23 +0100, Maxime Ripard wrote:
> The Allwinner H6 SoCs use binning in order to provide binning to
> cpufreq which is supported in Linux, with a matching Device Tree binding.
> 
> Now that we have the DT validation in place, let's convert the device tree
> bindings for that controller over to a YAML schemas.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  .../allwinner,sun50i-h6-operating-points.yaml | 129 ++++++++++++++
>  .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 ------------------
>  2 files changed, 129 insertions(+), 167 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
>  delete mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> 

Applied, thanks.

Rob
