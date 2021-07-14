Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5933C841A
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jul 2021 13:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbhGNLxE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jul 2021 07:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhGNLxD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jul 2021 07:53:03 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60ACC06175F
        for <linux-pm@vger.kernel.org>; Wed, 14 Jul 2021 04:50:11 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b12so1805053pfv.6
        for <linux-pm@vger.kernel.org>; Wed, 14 Jul 2021 04:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=12eUwpVE7CCQZhGXg14kXDSLP4TmS3iMl6QBgv+GuyM=;
        b=aR8wGXsU9AUVloF0vq84zNnI1tiULt8B/IkHWnmf0p5pHo4rKruxk2ny33782nnSIi
         LPwpj3OIvziPLYKu+WL8900Gmnw0HyFcWbYbscV916y1hzsrwENc+fJ86ar83u3xCxd4
         JKr/6gQqzfnR+PIS5zUJlI5xF6UbTTG1LLba/g8tMbqXDsCpDntnDYHIopcSm53sZl18
         BaCKTck+j/FBHZ0VoIPlaF6xPffYr3nkBwrDgyVYmiOa80UlY9z5lXzQrffMN3d+rByh
         Ol9vVy8udujUhDs7x+D7ZaYD15dVAUyoxx5thpx7A5vndmKP/DHwiDV6e15rKn8BdoTR
         gjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=12eUwpVE7CCQZhGXg14kXDSLP4TmS3iMl6QBgv+GuyM=;
        b=lqbvewAY6SX4ESOfl+uri6xo6y9/7tjUL98sAMl/EZ5Y+etin35hcahrcEMEepA/hd
         sKMorWT6cDnd6i4FlHpHoL7igvrJIlE36DB8U/yuzX1xsKKcN/4UT9wH12ODdPzQK53i
         VWBRfiQBwm4b2/sJuAlZK1Z8OIzuZ/6AwEyl2czuhG07pNvbHrHB3NV/8LNXDj8RT65S
         q02QsEmLi/d8SexoaO868+8BZvqqEOTtKkf3e+b2A2UTtP0AkLXNSWK4NUzWk63IxoR3
         GyCWPDFZt+7dE7ix45VjXrKj3EzpCriTLlYbCVX2ilGQNBzLa+sRnUTiKMOsNJ+eZgM+
         QaGg==
X-Gm-Message-State: AOAM530O4DYNN3+nwquP/BAst3sShE7mYKU7GsMrUMbEMmoXMt9qIimJ
        QTNELHMW4VTeWss9ALGd3Ldjxw==
X-Google-Smtp-Source: ABdhPJw8nHTd49BGH+pFXxggh0xJxXK2Zr+pmXZvKNrQ0nzbopfvHY/TIF53CEGmNxw0EfkUdkYe7A==
X-Received: by 2002:aa7:9a08:0:b029:331:ea96:691d with SMTP id w8-20020aa79a080000b0290331ea96691dmr1301133pfj.75.1626263411418;
        Wed, 14 Jul 2021 04:50:11 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id e30sm2879336pga.63.2021.07.14.04.50.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Jul 2021 04:50:11 -0700 (PDT)
Date:   Wed, 14 Jul 2021 19:49:57 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] power: reset: qcom-pon: Add support for
 'qcom,pon-reboot-not-used'
Message-ID: <20210714114957.GF11342@dragon>
References: <20210705025032.12804-1-shawn.guo@linaro.org>
 <20210705025032.12804-4-shawn.guo@linaro.org>
 <YOx3+qy2JhmLP87r@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOx3+qy2JhmLP87r@yoga>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 12, 2021 at 12:12:26PM -0500, Bjorn Andersson wrote:
> On Sun 04 Jul 21:50 CDT 2021, Shawn Guo wrote:
> 
> > Check property 'qcom,pon-reboot-not-used' and skip reboot-mode setup
> > if the property is present.  This is useful for devices that use IMEM
> > instead of PON register to pass reboot mode, but still want to populate
> > pwrkey and resin devices.
> > 
> 
> If IMEM is used instead, I think it should be sufficient for the DT
> author to omit mode-* properties to achieve this.

Indeed!  This is much better solution.  Thanks for the suggestion!

So please disregard patch #2 and #3, and I will resend #1 as a separate
patch.

Shawn

> If the PON hardware
> doesn't support mode-*, then that should be reflected in the DT binding
> and compatible.
