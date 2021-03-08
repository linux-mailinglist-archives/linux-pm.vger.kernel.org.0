Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20DA331649
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 19:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCHSjI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 13:39:08 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:43923 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhCHSiv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 13:38:51 -0500
Received: by mail-io1-f47.google.com with SMTP id f20so11019736ioo.10;
        Mon, 08 Mar 2021 10:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vzkfcBGh7P+3bfy1FsKTmuA9EtwsLrw7/lKLRVRQBX0=;
        b=AMHLQdMLjGxaR6AdwxWNFSyaV/9DggXfNkfAlVt+X59WnxuqThZYwwvLli08FI2raA
         +kIsKHWQQTyO7K+kfi+wZ3ZK79xv2MtU2DyBieIlYY3uLTETUxfd67+P+llyTXLYnKAk
         eTNKhYESFh51VOjL+A0qx5tyNSTMh/UYpU9PfU7Anie9PSSmF2tOFOaawvdnML0ejZIB
         ThQT6+vDTeqwEwxoyiNAM39k4WDPCASHCjBnjR4JE5vsBAT4O07guVHIKW9FKO/bqByI
         3ZEguE2vZKriHh0SOcL8rq4R49FNRjQwEAomaOZieF49V3jNyCzGny+yEkjIh4YtScLp
         HEiQ==
X-Gm-Message-State: AOAM532KefiC3LQv3u07qaygBCk1CSGPG4Tw1Vx9xg3CjuHk7AzKo2Sf
        Wzmh8eBiZXhFLkFxJ6ersOTAzC7ReA==
X-Google-Smtp-Source: ABdhPJwmF14ikEMZXnQAtX0RfcialPVky2Q8Ob0oT7+HCxv+jgTqMb2EH4jQceofAvOrGqFFocgcEA==
X-Received: by 2002:a05:6638:1648:: with SMTP id a8mr24511056jat.25.1615228730570;
        Mon, 08 Mar 2021 10:38:50 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f9sm6241138ilu.36.2021.03.08.10.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:38:49 -0800 (PST)
Received: (nullmailer pid 2760823 invoked by uid 1000);
        Mon, 08 Mar 2021 18:38:47 -0000
Date:   Mon, 8 Mar 2021 11:38:47 -0700
From:   Rob Herring <robh@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Arvin Wang <arvin.wang@mediatek.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-pm@vger.kernel.org, Ryan Case <ryandcase@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        linux-kernel@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V9 01/12] dt-bindings: soc: Add dvfsrc driver bindings
Message-ID: <20210308183847.GA2760789@robh.at.kernel.org>
References: <1614656863-8530-1-git-send-email-henryc.chen@mediatek.com>
 <1614656863-8530-2-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614656863-8530-2-git-send-email-henryc.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 02 Mar 2021 11:47:32 +0800, Henry Chen wrote:
> Document the binding for enabling dvfsrc on MediaTek SoC.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/dvfsrc.yaml   | 67 ++++++++++++++++++++++
>  include/dt-bindings/interconnect/mtk,mt8183-emi.h  | 21 +++++++
>  2 files changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml
>  create mode 100644 include/dt-bindings/interconnect/mtk,mt8183-emi.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
