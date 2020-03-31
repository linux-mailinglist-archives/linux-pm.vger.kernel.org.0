Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E037219A09D
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 23:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgCaVUX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 17:20:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44466 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaVUX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 17:20:23 -0400
Received: by mail-io1-f65.google.com with SMTP id r25so11534525ioc.11;
        Tue, 31 Mar 2020 14:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=14hw2ub7l4s2nuyd6/cfCjnjlrxzOMzhWT/qtQavKts=;
        b=Wc+kryshQ7HhaNSbg9AEWyE9acE4SSs4M2DNZLqcv1WpfdedopA0JnlaZijIYT1zuh
         Ec4ye3H3vUvb5O6Rx6ZvvLXGnrYdxf/ScFlc5q/tFxGYcMC6iYn2PPPRdfkIBdqUbtBI
         CuJ8bJhJnMC2Ndz7kDg9W9GeZ807KDFxj2Fr+5q4AS9cIwklNzTxYuGq5SXCrAMlRoqR
         rjLNHnQb0e/IQKZkziEL0dZr967shDcbPTRrrNWv43MU314ze5JdtQn7WBleDpkxSigP
         w9sAlUBrqFcYveOOASNsVNlo83Mxsu6QWpqpEgmCS/20c4ExF3ynzW5RiA/EGfoKiGfX
         MNFw==
X-Gm-Message-State: ANhLgQ3EfwTM3jhrS7xXOVsrFiLtDd+T4pszdxgEXtiP/7bnzQOKgLE4
        DbV23NiV0WlA+alArh2tEg==
X-Google-Smtp-Source: ADFU+vuL8I+4T+6IOLxjA3xLLdm41OSCz6hZ32QCpFZ/Ngg6WtgUEeoArtoYpUVK0WLupHM7uy8SEg==
X-Received: by 2002:a5e:da0c:: with SMTP id x12mr17052613ioj.69.1585689621841;
        Tue, 31 Mar 2020 14:20:21 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a17sm18656ilm.22.2020.03.31.14.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:20:20 -0700 (PDT)
Received: (nullmailer pid 15296 invoked by uid 1000);
        Tue, 31 Mar 2020 21:20:18 -0000
Date:   Tue, 31 Mar 2020 15:20:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: thermal: Add yaml bindings for
 thermal zones
Message-ID: <20200331212018.GA11347@bogus>
References: <cover.1585117436.git.amit.kucheria@linaro.org>
 <9c447186008ef2e3f4c3e712458dc0ddcd8a8b03.1585117436.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c447186008ef2e3f4c3e712458dc0ddcd8a8b03.1585117436.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 25 Mar 2020 12:04:54 +0530, Amit Kucheria wrote:
> As part of moving the thermal bindings to YAML, split it up into 3
> bindings: thermal sensors, cooling devices and thermal zones.
> 
> The thermal-zone binding is a software abstraction to capture the
> properties of each zone - how often they should be checked, the
> temperature thresholds (trips) at which mitigation actions need to be
> taken and the level of mitigation needed at those thresholds.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
> Changes since v2:
> - Addressed review comment from Rob
> - Added required properties for thermal-zones node
> - Added select: true to thermal-cooling-devices.yaml
> - Fixed up example to pass dt_binding_check
> 
>  .../bindings/thermal/thermal-zones.yaml       | 324 ++++++++++++++++++
>  1 file changed, 324 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> 

The change discussed doesn't affect the schema other than adding a 
'maxItems: 1', so:

Reviewed-by: Rob Herring <robh@kernel.org>
