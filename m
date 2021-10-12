Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DD0429AB6
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 03:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhJLBGw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 21:06:52 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:35611 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhJLBGv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 21:06:51 -0400
Received: by mail-ot1-f41.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so6001602ott.2;
        Mon, 11 Oct 2021 18:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LQhuTohxiMBS7vgNzsE16/ddOgS0nDCEvrxLWN9UJbU=;
        b=o/TPWAfSA98O9bme+OxYfnz/qgLCg1HIXG0eTeEqYMaxkmExDc/BsgoWNrn4U/lzdO
         6t9B9BBxrhCXrNwtBV3BFhpu89aWMhRbggGuRFrHvVdqwJICvNQfX/HIyUsKMwrJecfb
         3MMrp82rizhMpypMZg3g2cMukEwoBEBEJm5dwypnZ/elASYwp95BUTOJ4d18b4sHhw6Q
         rmf8mVGHZfxXgiWKjftZ3P6hHJb+qZSMNsi7mIunRGVNkRkLA1jm2XTyZnqTS0ovsqUA
         gtFvLgB+PS/tgNG7eWjDzSnjxhz9+A76v2JH5LDfvplXJEyuOV0bnbb40um/FesRuoIA
         Ztuw==
X-Gm-Message-State: AOAM531IcuwuFKMIyDKhEIRFtMuY9OgW0q6OzQ+D9BEGZFrYL9Xo1fmr
        GuHyQnfRg0Tdm5LtNeJR8Q==
X-Google-Smtp-Source: ABdhPJzlgJahdsMtNXbZ+/xje5QalLPp9GMiSr8yI4Kgx1H7ZqWAJXJCmElJKP+v3mOFiuKde/nUjg==
X-Received: by 2002:a9d:5d15:: with SMTP id b21mr23336948oti.356.1634000690716;
        Mon, 11 Oct 2021 18:04:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c9sm2150812ots.30.2021.10.11.18.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 18:04:49 -0700 (PDT)
Received: (nullmailer pid 1510904 invoked by uid 1000);
        Tue, 12 Oct 2021 01:04:49 -0000
Date:   Mon, 11 Oct 2021 20:04:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lin Huang <hl@rock-chips.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: devfreq: rk3399_dmc: fix clocks in example
Message-ID: <YWTfMaBMrKeXTy/x@robh.at.kernel.org>
References: <20211001150024.18672-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001150024.18672-1-amadeus@jmu.edu.cn>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 01 Oct 2021 23:00:24 +0800, Chukun Pan wrote:
> The clocks in the example use 'SCLK_DDRCLK', which does not exist in
> the rk3399-cru.h, correct it to 'SCLK_DDRC'.
> 
> Ref: commit 7fbdfcd68783 ("clk: rockchip: add SCLK_DDRC id for rk3399 ddrc")
> Fixes: c1ceb8f7c167 ("Documentation: bindings: add dt documentation for rk3399 dmc")
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
