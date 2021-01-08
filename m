Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C59A2EEB82
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 03:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbhAHCyO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 21:54:14 -0500
Received: from mail-il1-f178.google.com ([209.85.166.178]:42722 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbhAHCyO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 21:54:14 -0500
Received: by mail-il1-f178.google.com with SMTP id t3so4793442ilh.9;
        Thu, 07 Jan 2021 18:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=69Ai8HKbknhZURPxIt5QF+kZu4eC3CxPN2pRYOgxhpE=;
        b=ZM3eg6xyszTRVYu8fsn1OdWGUDxIDk0Cuyrz11C72V1LwEUDUG7aZjnze2ajEXa1Xb
         DQvvnC95ewNdCHrPEDKrU+ti6LUDxeOiYkJ2xaZ6BV7ISepuW47XpPyftYjT9QXJY18v
         v4b7GkCMGSgdtBRaPZBZdWlamrgKdyTxZUYBCzkeRi4i0U5SWAUU1ho4UaNrr9RXaOh/
         EuJkKKB/x2GHrHVmY4oZLmpSJ4wZwm6hVR/2B17ZNuF/czFszc9HxijcQ1vZDl9saTHN
         X+6QJ+ej3WjJPmr/iUu6h+x60LWZSbbyP6GLdg6st3iviZn15h/IydaJ/Xne/OYgrCgR
         QE9Q==
X-Gm-Message-State: AOAM532Y2U+Bdf0+PV1VuIxuxtWMG/zrCXRTQAgffctont+Cs2FnSTeq
        zKcGCnFzY0N3HV8KJwpcPA==
X-Google-Smtp-Source: ABdhPJz0n8Ax1fYCmyGE1t0YnZvd+uYz6siGhRJeWz7gpuf0/CLxB7RETkZBZu7XV0Njtaia8G2Wzg==
X-Received: by 2002:a92:d8c1:: with SMTP id l1mr1893601ilo.178.1610074407262;
        Thu, 07 Jan 2021 18:53:27 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a4sm3110909ild.5.2021.01.07.18.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 18:53:26 -0800 (PST)
Received: (nullmailer pid 1784130 invoked by uid 1000);
        Fri, 08 Jan 2021 02:53:24 -0000
Date:   Thu, 7 Jan 2021 19:53:24 -0700
From:   Rob Herring <robh@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Ryan Case <ryandcase@chromium.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        devicetree@vger.kernel.org, Arvin Wang <arvin.wang@mediatek.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Nicolas Boichat <drinkcat@google.com>
Subject: Re: [PATCH V6 06/13] dt-bindings: interconnect: add MT8183
 interconnect dt-bindings
Message-ID: <20210108025324.GA1784095@robh.at.kernel.org>
References: <1608790134-27425-1-git-send-email-henryc.chen@mediatek.com>
 <1608790134-27425-7-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608790134-27425-7-git-send-email-henryc.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 24 Dec 2020 14:08:47 +0800, Henry Chen wrote:
> Add interconnect provider dt-bindings for MT8183.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  include/dt-bindings/interconnect/mtk,mt8183-emi.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/mtk,mt8183-emi.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
