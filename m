Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A743AA9C6
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 06:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhFQECj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 00:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhFQECh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 00:02:37 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3545C06175F
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 21:00:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so3065847pjn.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 21:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pC2Nbi4igIwZvfic20raTQXRqc481qbOBEUTVrlffcM=;
        b=W/Iz1s1iFfzN5NvkND/sJwgBiBkIIUdYhZYEzcC69P6VQr3inUKzT+ewHPDavXOzNO
         gZ31rQmoZCHRo6c2NQ7VfiginGJ7AUWhmtRgUnqa0x9cBbcszsTueHaYbpCjB6lLpVIZ
         D2KqiGtwlGPX4/es4yI89OKiOePddqF2eV9F9Wh+mbArFJKYELXwj69oSh02zy/CwfuG
         yxnXCk7kpy28qm41eFsC+lXhmF2JgHtndb4UsQV24wb05SNfxCLRjK2Meu3oOPJ5Ex04
         JpMS078ZqB1H6bwcCtAPHVb9EuFp1QmZ+a8XHyEd2q4VpGyTAlNqTVjvb2DFDgcquz1y
         0DjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pC2Nbi4igIwZvfic20raTQXRqc481qbOBEUTVrlffcM=;
        b=nkRnRT0pE9/mCaemySdVb3lU4zXgfOvRRqddErwTBPVwQFh5isH2puwLjOSgrZl7KN
         kiFccHOD6FGUCwwBwQoxVB+4T1iGcxCy75Fxhn5eSgFnQqtoWCSfITM7QCubGv85z4oT
         jjhyepow6PSjPyGvqX+1iWLYu0k7CuiLYfgkIAsrihzqpirkfB33KYHOEdpeUz47zlpZ
         Sjri87df0HpwMO0PEFqhkIhaiZueCuwk1o14deDR9MqLX7ZD4Aq/6Zbl4z4Pepwc+Pt2
         oEkyiIq81A92zlq2F5m7WJSyNieshrjKfrn7vuqMu+pe4pBNstnG5PwmBO2Hd6dFqgIQ
         YcDQ==
X-Gm-Message-State: AOAM533Y19c9LKarfGnT+7D5f9H0BRATSe+a7AL8oWxb0nx5iChdp3Cy
        y3dLzDfjJRsls0DXHfV7oNshnw==
X-Google-Smtp-Source: ABdhPJyDv7ubI5q+IKKJfE9KSESdn7Qn3OCPz3FLjbADh/Q4cQNBLHiksqUAZ4ofi1gqIRGVprwt/Q==
X-Received: by 2002:a17:902:bd09:b029:ec:7e58:a54a with SMTP id p9-20020a170902bd09b02900ec7e58a54amr2751421pls.62.1623902429381;
        Wed, 16 Jun 2021 21:00:29 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id 20sm3495193pfi.170.2021.06.16.21.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 21:00:28 -0700 (PDT)
Date:   Thu, 17 Jun 2021 09:30:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        "Viresh Kumar )" <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "andrew-sh . cheng" <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH] opp: of: Allow lazy-linking of required-opps to non genpd
Message-ID: <20210617040027.vtqlhxqq7cwzeygg@vireshk-i7>
References: <20210616053335.4181780-1-hsinyi@chromium.org>
 <CGME20210616075555epcas1p136129544501878b4bedaf8e46f9a43dc@epcas1p1.samsung.com>
 <20210616075548.ghp3lmjf4y6pyxoy@vireshk-i7>
 <b9310754-2105-2a93-ecbf-513d9a80a91a@samsung.com>
 <20210616090945.sn337tftdcp7y7y6@vireshk-i7>
 <742b2623-e8ff-db1f-9168-bdbde98110dd@samsung.com>
 <20210617033351.44pxdpjicm62byuh@vireshk-i7>
 <c40f535b-3075-62eb-3b82-837ad13d67d4@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c40f535b-3075-62eb-3b82-837ad13d67d4@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-06-21, 13:09, Chanwoo Choi wrote:
> On 6/17/21 12:33 PM, Viresh Kumar wrote:
> > On 17-06-21, 10:13, Chanwoo Choi wrote:
> >> The devfreq driver(exynos-bus.c) has used the dev_pm_opp_set_rate()
> >> and used the passive governor without the required-opp property.
> > 
> > Which is fine.
> > 
> >> I have a plan to use the required-opp property
> >> between devfreq drivers (exynos-bus.c) with dev_pm_opp_set_rate().
> >>
> >> I'll support them on later if this approach doesn't break the any
> >> rule of required-opp property.
> > 
> > You will be required to make some changes in core for that I am
> > afraid. It won't work automatically.
> 
> Do you think that better to use clk_enable/regulator_enable directly
> instead of dev_pm_opp_set_rate() for using required-opp property?

No. All I am saying is that the OPP core won't work for your use case
today and may need some updates.

-- 
viresh
