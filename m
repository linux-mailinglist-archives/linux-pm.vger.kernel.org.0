Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 359B0E7E55
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 03:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfJ2CB2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 22:01:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33447 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbfJ2CB2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 22:01:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id u13so8470280ote.0;
        Mon, 28 Oct 2019 19:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9BL3Z1A/tEWwa5UAepvAQv367j/DZhoKZ8WMU7Awauw=;
        b=FMo/udJcoTk0koZYwYsmVgGNItWh8z0WloKRvpMwU5KFk4L4iPkw3Qc0HNe9lpJaSu
         BMjvVmJftHpWpRJfB5j5LG5sqqaVZmsFTQBIiHULUvnHQYPMFMM4KxsqXV2lWrxePXYz
         fX2kmpJNUqiBjr/+k0FfEyQhR5tiejdter/ZORVWZDjanxVwqFENknL1mynh4YoZ7K/c
         l49KSl/WqrrIKWbmaItuykfg0gD0P6iL26Kn6q8JCFA6Jip3bPA74v64LufYJ46BrRCa
         09c2MuzaUcGqs0jiMhJ5rlx0MvvYTYSW4Ck1s0ix4GCRSTaaAflZosIsiZpGc1euLgXb
         TMPw==
X-Gm-Message-State: APjAAAUZLtYBtTmd9WQB9qwSR9VYGUxhKu2va6g+Rzx5eGIInGbyB09n
        0+Da3203XYbcI0gFZVBeHQ==
X-Google-Smtp-Source: APXvYqxTMdckI8FQ4OvetDPaspVzeYA6kfan5ggpGK9XdwPtUCWnW0VVdmXnlKq6EvrM8Js1EYCC2Q==
X-Received: by 2002:a9d:538d:: with SMTP id w13mr15641639otg.184.1572314486742;
        Mon, 28 Oct 2019 19:01:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h17sm2203144otr.53.2019.10.28.19.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 19:01:26 -0700 (PDT)
Date:   Mon, 28 Oct 2019 21:01:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: power: add Amlogic secure power
 domains bindings
Message-ID: <20191029020125.GA11182@bogus>
References: <1571391167-79679-1-git-send-email-jianxin.pan@amlogic.com>
 <1571391167-79679-2-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571391167-79679-2-git-send-email-jianxin.pan@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 18, 2019 at 05:32:44PM +0800, Jianxin Pan wrote:
> Add the bindings for the Amlogic Secure power domains, controlling the
> secure power domains.
> 
> The bindings targets the Amlogic A1 and C1 compatible SoCs, in which the
> power domain registers are in secure world.
> 
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  .../bindings/power/amlogic,meson-sec-pwrc.yaml     | 42 ++++++++++++++++++++++
>  include/dt-bindings/power/meson-a1-power.h         | 32 +++++++++++++++++
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>  create mode 100644 include/dt-bindings/power/meson-a1-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> new file mode 100644
> index 00000000..88d8261
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +# Copyright (c) 2019 Amlogic, Inc
> +# Author: Jianxin Pan <jianxin.pan@amlogic.com>
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/amlogic,meson-sec-pwrc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson Secure Power Domains
> +
> +maintainers:
> +  - Jianxin Pan <jianxin.pan@amlogic.com>
> +
> +description: |+
> +  Meson Secure Power Domains used in A1/C1 SoCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson-a1-pwrc
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +  secure-monitor:
> +    description: phandle to the secure-monitor node
> +    $ref: /schemas/types.yaml#/definitions/phandle

Like the watchdog, make this a child or the secure firmware node. Or 
just add '#power-domain-cells' to it. You don't really need a child node 
here if there's not other resources in DT for this.

Rob
