Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5702E2701
	for <lists+linux-pm@lfdr.de>; Thu, 24 Dec 2020 14:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgLXM7T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Dec 2020 07:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbgLXM7T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Dec 2020 07:59:19 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADD3C0617A7
        for <linux-pm@vger.kernel.org>; Thu, 24 Dec 2020 04:58:38 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 3so1581954wmg.4
        for <linux-pm@vger.kernel.org>; Thu, 24 Dec 2020 04:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yLSSbEq6r4iVdZtmPmtafEBz2bgSZAhc70mUve9t2OY=;
        b=uv0H2fcPN8XeYyz54WYKPKVh3oZhVXm/mrrzREHWb03AIVVPRWOHRFuWFhpwbSDmWa
         +cfW43bRqgqsHcUqpHzkRRE2pKk7YNkNOkupy3vRuoWvMwUzo4HOF36Y0RHDY0uwWATg
         RrmgfrDDTMLHUXUHgPXC1fMJsynusDjMNUcMCeQ3/dbRE5MAhFgOvxwh2Rmoyg3Vy+uX
         XfAIbf5Dhqn8XpR+xhs7uBUFrKNwB7hi6B/kt3k6fy7Vt635EydzgeE5JwYnosCXtLjt
         OJ5VUlQaqk02E+aFMDj1G/tieUYZFIDRwbwvso+SG3+eEp/fDCj3JUkrELCAho0mO9UL
         MR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yLSSbEq6r4iVdZtmPmtafEBz2bgSZAhc70mUve9t2OY=;
        b=Vj/6ZRVwNgOFkFMJoqZwYnoRpwIL7coxQZQZFXnBj0/jUVLPELqPnz+Hf90ESiaNGw
         LCmk+9Df5jNdqQ4Q7UzbOcRj0RfpVZmwfImi0VyZl47gw/jKSpIQoS5TQvhvgqbzvfIh
         ah9QKaw9cELEeZzRfsqQz+SqLwxNmqAPuLm99lFzwd/ce0/sOde+U/7tlUrBwB8YOgTy
         LMkapjxRtSyw53OdvAkrzMPy+t/8SRNMGyH0y3buv3Zp1GCn5K3NUv91idCz5UPMNS2q
         +94guPe8H/x2GKUX2nLY05YsA0CaX+xBEAKJNeG1C05mRexplwK7TwdyrNTlidURuYpg
         kmuA==
X-Gm-Message-State: AOAM530a6/fdUb5cbRE0kvN3bRITktQ8im912bVcF8o9NBb1tRjKxAdg
        gH+h2VUGiDh68DNg8q+hVYH2fg==
X-Google-Smtp-Source: ABdhPJwNRTe2aN7t66YY66gFngJYZEz7gEfkEfsyDHMOQQllcKLjZYiJni/LjE0nNP7lpDDHT5aGaw==
X-Received: by 2002:a7b:c1d7:: with SMTP id a23mr4256319wmj.62.1608814717333;
        Thu, 24 Dec 2020 04:58:37 -0800 (PST)
Received: from dell ([91.110.221.181])
        by smtp.gmail.com with ESMTPSA id f9sm43371003wrw.81.2020.12.24.04.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 04:58:36 -0800 (PST)
Date:   Thu, 24 Dec 2020 12:58:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 3/7] mfd: max8997: Add of_compatible to extcon and
 charger mfd_cell
Message-ID: <20201224125834.GI681741@dell>
References: <20201223134221.804943-1-timon.baetz@protonmail.com>
 <20201223134221.804943-3-timon.baetz@protonmail.com>
 <20201223153207.GA300650@dell>
 <20201224122338.7183cf2e.timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201224122338.7183cf2e.timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 24 Dec 2020, Timon Baetz wrote:

> On Wed, 23 Dec 2020 15:32:07 +0000, Lee Jones wrote:
> > On Wed, 23 Dec 2020, Timon Baetz wrote:
> > 
> > > Add of_compatible ("maxim,max8997-muic") to the mfd_cell to have a
> > > of_node set in the extcon driver.
> > >
> > > Add of_compatible ("maxim,max8997-battery") to the mfd_cell to configure
> > > the charger driver.
> > >
> > > Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> > > ---
> > >  drivers/mfd/max8997.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)  
> > 
> > Why have you resent this?  It's already applied.
> > 
> 
> I made a change to an other patch in this series and wasn't sure if I
> had to resubmit everything. 

No need to send patches that have been applied.

You can safely drop it from the set.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
