Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46C92F2230
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 22:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbhAKVup (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 16:50:45 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:37508 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbhAKVuo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 16:50:44 -0500
Received: by mail-ot1-f43.google.com with SMTP id o11so350980ote.4;
        Mon, 11 Jan 2021 13:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qZB7YFnYmK5pmVyjaf+FA297zYveGF4/mkcj6q7QOss=;
        b=KzzdNZ6Atd3vBpENJVNI0RJlHFY4HrjV+UMAXXdX00Rah+o4Fl1mJCK/L9LhydwEGD
         UBkdr1YSw5din4zzw9jg3kI+rDjFEZMR1eV/eKMCa9J+bT7fdxH3G1IyqP4ZZH91OjG0
         BHQOsgyKaJpl4/BV9D8HDdFc6C6tflQUSNhEzlXKsm0kvIdG/0IdXWk4cQAPmkUbQt8L
         eAtQ1FV5acmEQGkjaebMlD01hygS9bIlXx0pTbPipZ2k1aJ4irsHg25X0Drp2Rjyr9xJ
         zlvb8VaqbZH77Au1hgxblZnIYAn8POm9FuNekOSEZV58gqGoP6zDGTk8vj32l8mCR2ZF
         JXXg==
X-Gm-Message-State: AOAM53088rib++/Yfr0VEHejVfTiIWtEYfyhsXKZo1UIk/udhHTNwNhs
        Kv4w46R3+5BYL3ew65PalQ==
X-Google-Smtp-Source: ABdhPJx4sESqsRtj0tIKhFssBKghbCoKpOR5OcYFGX1jMiDvJvhAgfB0xNG4OTZoj71kNHt+15hP5w==
X-Received: by 2002:a05:6830:1343:: with SMTP id r3mr753075otq.344.1610401803679;
        Mon, 11 Jan 2021 13:50:03 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f18sm214594otf.55.2021.01.11.13.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:50:02 -0800 (PST)
Received: (nullmailer pid 3120427 invoked by uid 1000);
        Mon, 11 Jan 2021 21:50:01 -0000
Date:   Mon, 11 Jan 2021 15:50:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 2/8] regulator: dt-bindings: Document max8997-pmic
 nodes
Message-ID: <20210111215001.GA3111856@robh.at.kernel.org>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
 <20201230205139.1812366-2-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230205139.1812366-2-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 30, 2020 at 08:52:07PM +0000, Timon Baetz wrote:
> Add maxim,max8997-battery and maxim,max8997-muic optional nodes.
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> v6: No change.
> v5: No change.
> v4: Make extcon and charger-supply optional.
> v3: Reorder patch, no change.
> v2: Add patch.
> 
>  .../bindings/regulator/max8997-regulator.txt         | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

This exceeds my threshold of changes for please convert this to schema 
first. However, I agree with what Mark has said already, so maybe some 
of this isn't needed.

> 
> diff --git a/Documentation/devicetree/bindings/regulator/max8997-regulator.txt b/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
> index 6fe825b8ac1b..faaf2bbf0272 100644
> --- a/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
> @@ -53,6 +53,18 @@ Additional properties required if either of the optional properties are used:
>  - max8997,pmic-buck125-dvs-gpios: GPIO specifiers for three host gpio's used
>    for dvs. The format of the gpio specifier depends in the gpio controller.
>  
> +Optional nodes:
> +- charger: Node for configuring the charger driver.
> +  Required properties:
> +  - compatible: "maxim,max8997-battery"
> +  Optional properties:
> +  - extcon: extcon specifier for charging events

Don't use 'extcon' for new bindings. Define a connector node. USB I 
suppose?

> +  - charger-supply: regulator node for charging current
> +
> +- muic: Node used only by extcon consumers.
> +  Required properties:
> +  - compatible: "maxim,max8997-muic"
> +
>  Regulators: The regulators of max8997 that have to be instantiated should be
>  included in a sub-node named 'regulators'. Regulator nodes included in this
>  sub-node should be of the format as listed below.
> -- 
> 2.25.1
> 
> 
