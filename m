Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF182E2825
	for <lists+linux-pm@lfdr.de>; Thu, 24 Dec 2020 18:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgLXRCf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Dec 2020 12:02:35 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36905 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgLXRCf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Dec 2020 12:02:35 -0500
Received: by mail-ot1-f41.google.com with SMTP id o11so2255063ote.4;
        Thu, 24 Dec 2020 09:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=yQ+jkFqkeNW0g6dJlToG9rqzV65Dab1jDC5D6aio4ug=;
        b=cONns5qXYt5QAxqMy8Miy/CbKpaJMagUxNQeoLhfVDOJxyTR2p7qUUFUKntX5/dNml
         C05qjvM6k7stUMMM8G+sOETMEAfmAXN7bv7VqM6sQMfp6j3wT2yVd9YIAy6CYMaj11/a
         HS0DgyGR+22jPgOQuMTHzX328y49Tt8gQf6NGd0kne9GKdGHYNsUimO5aAqgNcrXdVVk
         jNDsknRy5uRZXft8clJcI3IVdtaYTp2bYplXanSmxZpYEo03+fXvFkZInw4DSQBVmbX7
         HPRaRtOw+Lnzawm94hcsj4Xe+A0va5hFOPmqDh1UYMT158toxqP+0D9tut0PZWA5Jj3+
         +2NA==
X-Gm-Message-State: AOAM532rZl0kOZFWNArs/gbowZr/FiNwnB2mwlcdWTxVWTfrQyc0AbVT
        /wRQGtGbG2r26mx4H5f1EQ==
X-Google-Smtp-Source: ABdhPJxjl8zgjJFFzzINq/VqWXTjo+1x0o/d2ybTE3Qvx2dNR11lKFEb1xRLDizL01CKwjn5zJzOpA==
X-Received: by 2002:a9d:f66:: with SMTP id 93mr22677948ott.289.1608829314107;
        Thu, 24 Dec 2020 09:01:54 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g12sm6917426oos.8.2020.12.24.09.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 09:01:53 -0800 (PST)
Received: (nullmailer pid 2966453 invoked by uid 1000);
        Thu, 24 Dec 2020 17:01:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>, linux-pm@vger.kernel.org,
        James Liao <jamesjj.liao@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Ryan Case <ryandcase@chromium.org>
In-Reply-To: <1608790134-27425-2-git-send-email-henryc.chen@mediatek.com>
References: <1608790134-27425-1-git-send-email-henryc.chen@mediatek.com> <1608790134-27425-2-git-send-email-henryc.chen@mediatek.com>
Subject: Re: [PATCH V6 01/13] dt-bindings: soc: Add dvfsrc driver bindings
Date:   Thu, 24 Dec 2020 10:01:45 -0700
Message-Id: <1608829305.386312.2966452.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 24 Dec 2020 14:08:42 +0800, Henry Chen wrote:
> Document the binding for enabling dvfsrc on MediaTek SoC.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/dvfsrc.yaml   | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/mediatek/dvfsrc.example.dts:19:18: fatal error: dt-bindings/soc/mtk,dvfsrc.h: No such file or directory
   19 |         #include <dt-bindings/soc/mtk,dvfsrc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/soc/mediatek/dvfsrc.example.dt.yaml] Error 1
make: *** [Makefile:1370: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1420382

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

