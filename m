Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A093E3EF4E6
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 23:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhHQVY5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 17:24:57 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:38680 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhHQVY5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 17:24:57 -0400
Received: by mail-ot1-f45.google.com with SMTP id 108-20020a9d01750000b029050e5cc11ae3so148279otu.5;
        Tue, 17 Aug 2021 14:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7W9npOknUtUU037y5TUXkyCwGRj5nJWHyHC1caEq6G0=;
        b=KaPUtZkb+dBxxKHSQIF/5l2JzsO79gpKqdkEHiiN5vC+85hchaOfmAV6ZtP5dJlKaj
         K4FenRRArgYw/UpLm/8fJkUTgJpk5lntVQvXlRUd8mBFu4dGwv6MgT58YSdM+SzhPXLg
         XS3oYwHLsaRCwE2yH7LAWzyAf3nDSlphvC7p5kXsV9yWHiSSthw42w/H188oOtCn2X9g
         slRVMHkGxYbMaeg0Ct1w+/EM5EcOd5p3DCpCxYLd237YXa1lSxCibEKiQ0iczAYpGO9h
         Zuy96VtkGcPsqoN8w59fyZi5syZiEdz5KqHOMcA4jZ3sC607L48ZCG6f4bIjq9SCWc7D
         nZsA==
X-Gm-Message-State: AOAM5338r/SnTi0LhWU0KinwuvOSR5QqDrj0FasRb6rHZjmvieeCn518
        d/uGvJcDOAYA53/b/hOw9A==
X-Google-Smtp-Source: ABdhPJz5WjCQw00OSV19UzmnYoJNag5H4oeeak/snW4AcVvwi66ujDfDHn7AEgc1RlfMhusAaMvC0g==
X-Received: by 2002:a9d:8ed:: with SMTP id 100mr4115192otf.232.1629235463552;
        Tue, 17 Aug 2021 14:24:23 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u127sm779604oib.16.2021.08.17.14.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:24:22 -0700 (PDT)
Received: (nullmailer pid 866082 invoked by uid 1000);
        Tue, 17 Aug 2021 21:24:21 -0000
Date:   Tue, 17 Aug 2021 16:24:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dawei Chien <dawei.chien@mediatek.com>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Case <ryandcase@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Arvin Wang <arvin.wang@mediatek.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, James Liao <jamesjj.liao@mediatek.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Boichat <drinkcat@google.com>,
        linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [V11,PATCH 11/19] dt-bindings: interconnect: add MT8195
 interconnect dt-bindings
Message-ID: <YRwpBQu+rXPiUe3i@robh.at.kernel.org>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
 <20210812085846.2628-12-dawei.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812085846.2628-12-dawei.chien@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 12 Aug 2021 16:58:38 +0800, Dawei Chien wrote:
> Add interconnect provider dt-bindings for MT8195
> 
> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> ---
>  include/dt-bindings/interconnect/mtk,mt8195-emi.h | 42 +++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/mtk,mt8195-emi.h
> 

Acked-by: Rob Herring <robh@kernel.org>
