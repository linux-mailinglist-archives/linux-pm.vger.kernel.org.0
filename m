Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EDE34AFD5
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 21:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCZUI1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 16:08:27 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:47097 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhCZUIZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Mar 2021 16:08:25 -0400
Received: by mail-io1-f53.google.com with SMTP id j26so6605669iog.13;
        Fri, 26 Mar 2021 13:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DASKl11Okq61XpyLvc+74DH7y8wg+D061aTOEn3xo/4=;
        b=R/ptozOT2+ZMDKXd67RrJWISdLufWwOHIX9F5PDrj9wxLch04r+TIWg+mcbW6gCMfD
         uxYvW2zjZ3IZZOM+5fauxbayLaCFRWmkbibftqf15JQq58Aaih+01WK9VWoY8jzH8VMa
         fFVBlDK2zTI20NwGLy2XPjC/W8IMj2nl2ipa+YHSQAo8zTz+Zp0WJ2c/nUPBv4Z4FEIb
         7wD/CqVloqLCp/FZtE7ZtCAG3bGxKeHgEwI0rivPj/JFM4skEelTPshuX25d6zL5HeCP
         G75Zt+0zald3PUO738ygMJMt0l3Jx1oNjnI3mM1DhNHBb7tNtuq97L0fipOC7ue+b+2I
         zGjw==
X-Gm-Message-State: AOAM530s8EaA7Dd3myh3dWTN4+3hI4rN1qTnDtLkaG3TyWzzHsTJuf+t
        o27qAYS7OTosYTK5koHuxg==
X-Google-Smtp-Source: ABdhPJzOMr0U8Z8VHTkdGna00jzbpA/m/ZJVl1xMmbaPPdHDWEfwemmVN983hu/qZLjWRyhejOe9Ug==
X-Received: by 2002:a5e:d908:: with SMTP id n8mr11743371iop.121.1616789304697;
        Fri, 26 Mar 2021 13:08:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b4sm4677200ilj.11.2021.03.26.13.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 13:08:24 -0700 (PDT)
Received: (nullmailer pid 3784988 invoked by uid 1000);
        Fri, 26 Mar 2021 20:08:20 -0000
Date:   Fri, 26 Mar 2021 14:08:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        Nicolas Boichat <drinkcat@google.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YT Lee <yt.lee@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>
Subject: Re: [PATCH v14 5/7] dt-bindings: soc: mediatek: add mt8192 svs
 dt-bindings
Message-ID: <20210326200820.GA3784958@robh.at.kernel.org>
References: <20210325025114.25842-1-roger.lu@mediatek.com>
 <20210325025114.25842-6-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325025114.25842-6-roger.lu@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 25 Mar 2021 10:51:12 +0800, Roger Lu wrote:
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mtk-svs.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
