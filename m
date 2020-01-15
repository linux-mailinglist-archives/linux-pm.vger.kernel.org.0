Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6177713CDFC
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 21:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgAOUSR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 15:18:17 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37814 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOUSR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 15:18:17 -0500
Received: by mail-oi1-f196.google.com with SMTP id z64so16729610oia.4
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2020 12:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=15O0u5i/rLLeI7Psjs2fWQ8eJ8azzo914oeadZHzrto=;
        b=CFCttlR1lBmxFOD3DqZYlTPbZNva3uyy8F8PgsDYHs1kt+Qeekp9LBjBhJFXrzJcry
         +ywLjjnq8Pb7zlrpqYcNazvPLo4wbd14P4J+gDGzTG9m8+ren7qWP1SZZedL6bAaTGIC
         k8+guV/tPFJEc22evk+o1sfk+hDqRLHmkvNsHSnPqrkEHzBKQSEgO5IosxirWt1ANJz3
         10kcLSVBqwRopDM10sh0YPS0mEMukb6ygkKCH4imRK3wVT01G0Zwz4qTYuVyAohxSf0d
         rKYK1xyirj9untDdRCzTacmrsIPkyPkCqkmzokHvCEj0BrMak/ZWPHPHQiSLa/jUs06F
         cUCQ==
X-Gm-Message-State: APjAAAXPE0FZqrjxYu7/RXXz2MdCa45n8qkV8qifzDaRDDW/AyejpVl/
        CuXAgt3JWC3Djym/TbACK9XW+J4=
X-Google-Smtp-Source: APXvYqynYQQ67pby6ASinLEV6+qop6nvxBt6TBpozai4DCJcxfn+gXxenL8XcGQumCH6ErclGdH8lg==
X-Received: by 2002:a05:6808:3b4:: with SMTP id n20mr1266060oie.123.1579119496696;
        Wed, 15 Jan 2020 12:18:16 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l82sm5999772oib.41.2020.01.15.12.18.16
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 12:18:16 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22061a
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 14:18:14 -0600
Date:   Wed, 15 Jan 2020 14:18:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH v6 2/4] dt-bindings: power: add Amlogic secure power
 domains bindings
Message-ID: <20200115201814.GA28654@bogus>
References: <1579087831-94965-1-git-send-email-jianxin.pan@amlogic.com>
 <1579087831-94965-3-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579087831-94965-3-git-send-email-jianxin.pan@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jan 2020 19:30:29 +0800, Jianxin Pan wrote:
> Add the bindings for the Amlogic Secure power domains, controlling the
> secure power domains.
> 
> The bindings targets the Amlogic A1 and C1 compatible SoCs, in which the
> power domain registers are in secure world.
> 
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  .../bindings/power/amlogic,meson-sec-pwrc.yaml     | 40 ++++++++++++++++++++++
>  include/dt-bindings/power/meson-a1-power.h         | 32 +++++++++++++++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>  create mode 100644 include/dt-bindings/power/meson-a1-power.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
