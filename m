Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD00F398066
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 06:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhFBEiZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 00:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhFBEiY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 00:38:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5AFC061574;
        Tue,  1 Jun 2021 21:36:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v12so445540plo.10;
        Tue, 01 Jun 2021 21:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KTf2Z6MKvY8sheO1d8MEddPyrsTpIrIEJxqzm3TzrA4=;
        b=uR6J2dSEP1OKp5UxswuSHcxR0MWh824sc/eaO0h38A8FJXcY2LNW1Sxh31Xx4gqtnG
         syptW6UKkNBqbFfiBYUcqvw0A+G7SPI/h0I+HWeRjeNrTVpLj8ExgHZL4RSqDRlH5+oa
         dXh3aUhwbnMzMVM28P9wGI47mKjW8YS2q8XVA+dsXcdB3Qj6tRzvlo2GlpPSqhh6vZXL
         dM161TM5rabaCclhHpw16+nZctAKOyDk7RPyiZgX+2xBU+YiGbTHom8v5FwfbarDvSZt
         nzhJl1ClazXJ/A2INO5XRqYdtwcJOSR3niAk/rlb/M8Ya92qF4rMzqAyu67LeKUpzM+F
         Cpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KTf2Z6MKvY8sheO1d8MEddPyrsTpIrIEJxqzm3TzrA4=;
        b=ZhPotWn8z88KtU/dL+AqGT0GSB5N1Fp9DfUg3a+NcZXZDDKoehX33RxdMFc00V9hD1
         ehMQZQlOnFx0BysQ4NPwDBcLRFQuiblMaKoCs+gyDAmNioJcR9ZxAMPWeb4OIpX5/1Vn
         LhheycVNo9b7EnS2CR37+ppbVGi3JckVJ7Jx9XjwCIUJcQFZOwy/eknnYJ3RDBBui3hq
         xKypDolCQhxJD2OSuZQmaMKjPn+GLvnAkcMH26R2oidMCFEBGwZZmAZZXUckpAaGv1Yc
         nKDKmtEYVn9iX8AVmAeZikckxZ1cW7CqMZhEFwQ1YHFk+fvYSWzeWBmKHr18hS+qTIRr
         nRjg==
X-Gm-Message-State: AOAM530Xx6DqBQwmeGETo6JPrIx5maor3xdEMzQge2leI+bvQ2Ok5els
        i/HE07DQB1I6LOrqFT/hpZI=
X-Google-Smtp-Source: ABdhPJxrMPYyqzW1DClbrvN9pPlagr9x09huXer5s+LsC8rOinkkaZV4vikyVUL8843z6isIah4zUQ==
X-Received: by 2002:a17:90a:9511:: with SMTP id t17mr28971813pjo.108.1622608602298;
        Tue, 01 Jun 2021 21:36:42 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a596:b3cb:1a6:1ee4])
        by smtp.gmail.com with ESMTPSA id f3sm14007054pfd.21.2021.06.01.21.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 21:36:38 -0700 (PDT)
Date:   Tue, 1 Jun 2021 21:36:36 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     satya priya <skakit@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH V3 2/5] dt-bindings: input: pm8941-pwrkey: add pmk8350
 compatible strings
Message-ID: <YLcK1P2/3v01XCHb@google.com>
References: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
 <1620630064-16354-3-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620630064-16354-3-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 10, 2021 at 12:31:01PM +0530, satya priya wrote:
> From: David Collins <collinsd@codeaurora.org>
> 
> Add power key and resin compatible strings for the PMK8350 PMIC.
> These are needed to distinguish key PON_HLOS register differences
> between PMK8350 and previous PMIC PON modules.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: satya priya <skakit@codeaurora.org>
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thank you.

-- 
Dmitry
