Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE68C19A08C
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 23:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgCaVQJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 17:16:09 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40001 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaVQJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 17:16:09 -0400
Received: by mail-il1-f195.google.com with SMTP id j9so20985253ilr.7;
        Tue, 31 Mar 2020 14:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=75TI3oMqfxdvTiM30wyrqU7RxJWCU7Dag+WXdArhdRY=;
        b=lgZeIKE9c/1oJdRlj7KOmPciuKBnngQFlkw1A2CEGzOm+P0EfURdjMQt0HpWSzmt5M
         Zld0u9F1vZz94b0lX3m6CWGvWDtGeb3KsfeSw7DzuLhjGlbX2tOHq8qzS+BA/weRwsNO
         h0UmC1dFXD891AjaLRmXkgeMb86Le/Pzso4mlYwAHea5f8gZqAHw+9p0+FHxgyv/Tajm
         EuZERKScPvGCyevSpibVi0p6A4h2DT4mXsEzXrqTv5G4fXndjBeA8+ho6pz0yW8bKTLR
         n68mXw5RN2xG3RQpC7llHBtPjHFa3KyqJSo1i85YWsNCWQNyYuEvm2nFZIfpKBDsy55/
         CQKg==
X-Gm-Message-State: ANhLgQ2gk+w4t0aSWpF2hCcuLLlZ1vs8WP9w56HWOMw64lDw4vI0x9WP
        Iwl0EXrCjqBrMGehQU8d9A==
X-Google-Smtp-Source: ADFU+vtmMaqqJYnrnpnYolbC1/MXnHTVfsU7k1L1goBqozYm9WUdt58dS4gm3Diw7upoKxGAjJnsWQ==
X-Received: by 2002:a92:4849:: with SMTP id v70mr17830928ila.279.1585689367856;
        Tue, 31 Mar 2020 14:16:07 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z13sm13287ioh.16.2020.03.31.14.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:16:07 -0700 (PDT)
Received: (nullmailer pid 3855 invoked by uid 1000);
        Tue, 31 Mar 2020 21:16:06 -0000
Date:   Tue, 31 Mar 2020 15:16:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: thermal: Add yaml bindings for
 thermal cooling-devices
Message-ID: <20200331211605.GA3795@bogus>
References: <cover.1585117436.git.amit.kucheria@linaro.org>
 <1ee4240e29edefc36b5d410d4792971c2bb4c5d5.1585117436.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee4240e29edefc36b5d410d4792971c2bb4c5d5.1585117436.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 25 Mar 2020 12:04:53 +0530, Amit Kucheria wrote:
> As part of moving the thermal bindings to YAML, split it up into 3
> bindings: thermal sensors, cooling devices and thermal zones.
> 
> The property #cooling-cells is required in each device that acts as a
> cooling device - whether active or passive. So any device that can
> throttle its performance to passively reduce heat dissipation (e.g.
> cpus, gpus) and any device that can actively dissipate heat at different
> levels (e.g. fans) will contain this property.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  .../thermal/thermal-cooling-devices.yaml      | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
