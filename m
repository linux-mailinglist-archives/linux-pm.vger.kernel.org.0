Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF27D183B25
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 22:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgCLVOk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 17:14:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34340 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgCLVOk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 17:14:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id j16so7876996otl.1;
        Thu, 12 Mar 2020 14:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hb+jggLgxrgsVbgn5UC+wajZRLswbi9I3/cHFEMhG5A=;
        b=I0hcORIboNsydVKFvFAMTfb5QsiIeJ7AD9yPDv/N/8rOEpXFiNdtdy7YGGIWvbbTiI
         5eHd85Uzo7iXn0mLlEZ+9CdN4FJieilTXU7jGW79nktR5j2u0uJcYr++J7SMMTqiVC/q
         pzDuZwuIeYIpmTH0KNtx19JsLc61wKJIcw+J9wRAmBhOrPQKvyv3QApMHJutYeuJ+6Lo
         eRjyCru7rEelSwfCt3CGvgsA0rV+iFkuyj3KhyDweT7kJJabOWkWqGkjYQl2/idAe/J7
         r2IIWOnXxrYhs1F90q4oLDOFovT7mI7KS3T4cmG/iJbzGq6zGLuNxQ/sNii8EKiKDkp9
         cdNw==
X-Gm-Message-State: ANhLgQ3E8J4dOKaWISXbRZujgN4cleF9CEkZDKoGUN+cyiuJEl8B/snm
        zadyFtit0znC7JYIbRe11g==
X-Google-Smtp-Source: ADFU+vuljXtmuwnM4UV2KeJttRiC0WN1lGhphK05ESUgIzEivH+NonbDuzc8edu6d6mjGc5QIpJOag==
X-Received: by 2002:a9d:c61:: with SMTP id 88mr7164473otr.144.1584047679639;
        Thu, 12 Mar 2020 14:14:39 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v12sm1633771otp.75.2020.03.12.14.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 14:14:39 -0700 (PDT)
Received: (nullmailer pid 27028 invoked by uid 1000);
        Thu, 12 Mar 2020 21:14:38 -0000
Date:   Thu, 12 Mar 2020 16:14:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: power: reset: Add regmap support to the
 SYSCON reboot-mode bindings
Message-ID: <20200312211438.GA21883@bogus>
References: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130402.1F4F0803079F@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306130402.1F4F0803079F@mail.baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 06, 2020 at 04:03:40PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Optional regmap property will be used to refer to a syscon-controller
> having a reboot tolerant register mapped.

NAK. It should simply be a child node of the 'syscon-controller'.

> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
>  .../bindings/power/reset/syscon-reboot-mode.yaml         | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> index e09bb07b1abb..f47bf52ad983 100644
> --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> @@ -13,9 +13,8 @@ description: |
>    This driver gets reboot mode magic value from reboot-mode driver
>    and stores it in a SYSCON mapped register. Then the bootloader
>    can read it and take different action according to the magic
> -  value stored. The SYSCON mapped register is retrieved from the
> -  parental dt-node plus the offset. So the SYSCON reboot-mode node
> -  should be represented as a sub-node of a "syscon", "simple-mfd" node.
> +  value stored. The SYSCON mapped register is retrieved either from
> +  the parental dt-node or from a regmap phandle plus the offset.
>  
>  properties:
>    compatible:
> @@ -29,6 +28,10 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: Offset in the register map for the mode register (in bytes).
>  
> +  regmap:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the register map node.
> +
>  patternProperties:
>    "^mode-.+":
>      $ref: /schemas/types.yaml#/definitions/uint32
> -- 
> 2.25.1
> 
