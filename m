Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 069161645F8
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 14:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgBSNuN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 08:50:13 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45791 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgBSNuN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 08:50:13 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so131403otp.12;
        Wed, 19 Feb 2020 05:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PDadwaa2tCalOGhbrNe+eCFiucqxINzGz8b3IuyJVBo=;
        b=EGsSEAtLKFuTpzxcIzJ29HQJY0zofaY7DnrDaCzc7Nd/0nu8bq6suOGmsO0EthPJAV
         PGhvnjGpA5/ZIK3qeyAdbL7h5JPk3xQd7crvCg2N5MAQQVqw0AewtgjCrGFwU7upd5H2
         mvFYsWCFIzwujge6bHVq31oy4SuOLrhah4CM6DJZOAAxmD9RVl1Cg3EBxnxuwVsNjptV
         Tu8Pjx2ySkdxfYbn0AyVM96HhSWOxezRxW0ovZREXjGagS+TSuVVzxTPoTIwI9L+4ebM
         Ewa+cwlsSien2ZeIP+zSBfNR/uezp5JYVdEb3/6atEBKZc8KCgRinPS2RvANxQLJIAcM
         AQyQ==
X-Gm-Message-State: APjAAAXpPUIsrR9PeRNpu6EluZpLJKPPIuKeGjYk8YKdc5UOJhyskEdL
        A2ouHV31hQxMido4IsqBCg==
X-Google-Smtp-Source: APXvYqx9tjudoBcfo2l2gjTj/tz/jOPKzWnJusxxw8qa+pcBGOCG323+8cZRapiKtJcy/ffY1jGT2Q==
X-Received: by 2002:a05:6830:1c8:: with SMTP id r8mr6946584ota.63.1582120212489;
        Wed, 19 Feb 2020 05:50:12 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a1sm654837oti.2.2020.02.19.05.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 05:50:11 -0800 (PST)
Received: (nullmailer pid 9937 invoked by uid 1000);
        Wed, 19 Feb 2020 13:50:10 -0000
Date:   Wed, 19 Feb 2020 07:50:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, baolin.wang7@gmail.com,
        freeman.liu@unisoc.com, zhang.lyra@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: sprd: Add the Spreadtrum
 thermal documentation
Message-ID: <20200219135010.GA9880@bogus>
References: <444e45ce0a9b390b2502dfcefd1ddb36948fa8e1.1582013101.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444e45ce0a9b390b2502dfcefd1ddb36948fa8e1.1582013101.git.baolin.wang7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 18 Feb 2020 16:10:27 +0800, Baolin Wang wrote:
> From: Baolin Wang <baolin.wang@unisoc.com>
> 
> Add the Spreadtrum thermal documentation.
> 
> Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
> Changes from v2:
>  - Add missing #address-cells and #size-cells properties.
>  - Change the child node name with patternProperties.
>  - Simplify the nvmem-cells-names property.
> 
> Changes from v1:
>  - Change to yaml format.
> ---
>  .../devicetree/bindings/thermal/sprd-thermal.yaml  |  108 ++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
