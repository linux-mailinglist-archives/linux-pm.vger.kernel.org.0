Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B46C7183B0F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 22:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCLVMs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 17:12:48 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46082 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgCLVMr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 17:12:47 -0400
Received: by mail-oi1-f194.google.com with SMTP id a22so7049124oid.13;
        Thu, 12 Mar 2020 14:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iHfZC1DChvttHXlnAFmMQXIUQJ7bISj0py1yPTC621o=;
        b=Tn/6NeMQ1p7hgFE5tx12v8I1TqaNdlvFASRGW45RvN2zO18ggO9XUh59HJcm+da3aW
         nUcajGo88aJ02H/7nz6JlLm28eXgA2hFkmStcUYneCa/k6zdMXpTqyzkvYj5y/g3JaOR
         OUk3zXVZllE+BlXIq4H/sGFPJUx7wwLVZLAkr2gygyqOPWa0qxkYUjBErJ6M4Vbqa52I
         aoACI9eSBs3iCTbIUQoVQbOzVSoTJK1DSWapm6MSYuC3rrEP7N51eJAhQcOVnF5QgxAo
         r12qVd3OM3iO1T4jpUSMKKg8M4jNfCIGos23BCvGQbbOaErSX/30af+xXy4fWelY6Gd0
         rQzQ==
X-Gm-Message-State: ANhLgQ0+b+8FMrbQ4MwfHTwsRDA2Wd5Y/DsTmcSc3B411iceLx0kbu2o
        WkMP2yddCNOdO5zaYZkMhw==
X-Google-Smtp-Source: ADFU+vuqGomNwPy8gx+w21w80uogekI1AzXVgz+tHdFM9c90dK3d+sY1MwkzmMtYOWXvju3IzdcFDw==
X-Received: by 2002:aca:5317:: with SMTP id h23mr3098489oib.33.1584047566566;
        Thu, 12 Mar 2020 14:12:46 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e15sm7086620oie.3.2020.03.12.14.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 14:12:46 -0700 (PDT)
Received: (nullmailer pid 21730 invoked by uid 1000);
        Thu, 12 Mar 2020 21:12:45 -0000
Date:   Thu, 12 Mar 2020 16:12:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: power: reset: Replace SYSCON
 reboot-mode legacy bindings with YAML-based one
Message-ID: <20200312211245.GA21628@bogus>
References: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130401.C07838030795@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306130401.C07838030795@mail.baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 6 Mar 2020 16:03:39 +0300, <Sergey.Semin@baikalelectronics.ru> wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Modern device tree bindings are supposed to be created as YAML-files
> in accordance with dt-schema. This commit replaces SYSCON reboot-mode
> legacy bare text bindings with YAML file. As before the bindings file
> states that the corresponding dts node is supposed to be compatible
> "syscon-reboot-mode" device and necessarily have an offset property
> to determine which register from the regmap is supposed to keep the
> mode on reboot.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
>  .../power/reset/syscon-reboot-mode.txt        | 35 ------------
>  .../power/reset/syscon-reboot-mode.yaml       | 55 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
