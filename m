Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3549914D598
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2020 05:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgA3EVa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 23:21:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32891 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgA3EVa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 23:21:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id n7so824365pfn.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Jan 2020 20:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jhh4QgLWyaoYG8HAwtQ4AQhj4HFkJJcmjwzfU/Y1O+4=;
        b=MkqC/jdD5ZsDZmSULeKNrUD+fwzcx0l5j4gt27QA0CPLXUPT63tYapSetcx4Jflovb
         OIEyfkl+TQ/cv91KYNDm0Vp+cuzOmMeCabedE8Yhvcpt0OaUATGZFe9jJ3wZHuLqlIWa
         4NUyBKxvo/R5afw9Y+pV/GgtR0Rmr23dYPosWwoAEwVnfsZzOpn3B76eeubqM71TtoxY
         uq7lBrnDK9i2CC1bGOhs+ezMLM6uCpvfjclgfvkIw0sV3BgPALSKvPftW6tdOkf2fxcX
         haB75aSlAwY6BDja4yc2etMTSlpFimhgPsadJH+1NvpnkuTw6SpuieB6cB+CmV3VQer5
         EORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jhh4QgLWyaoYG8HAwtQ4AQhj4HFkJJcmjwzfU/Y1O+4=;
        b=ZwvzEWw57gtGkrVsWh894erCWjfEzGlUU61n6ZaFWj7Dt0ewHtdNIANS5kdnRtPyyq
         4sOt1dfitMJCkLsbj72NPjqTP6av3vZVZXKyjN4cZ76znMrejIq07qsAywOgXZ/WBmMC
         UGZWcgotEv/e8U5s2Zi4NG58rYqOmf1XVhy9WG2xvk/cBQP2V6hgcb7DEHUkPBiKd5rH
         4+Ztm8Ws0CHraw7CZNcrv8tuDpswGa4XEyVJ10NJigtu8XMzcrMlOPIi0M6xtSJKAlR3
         f1DCP5CHb2kVcIDvpt9eCtvRKmQCncHLQmOL/+KaVcz8ElZvlayUx/Ltw9G5oz9U+FpV
         tgCQ==
X-Gm-Message-State: APjAAAXxdnSpHl2PYDsTWZX2k2Hw934fA9c73wI+K12ouXJPIPSxegrl
        CL9yk4pnXUGthCWhbkc0/1qgdg==
X-Google-Smtp-Source: APXvYqxth7XbsK5bbuSd8tnRy7pwS+h2pI5149XunMRDZJGJi44uZDJ5EJDkQ1uB6UTdZSDqQwahrw==
X-Received: by 2002:a65:5281:: with SMTP id y1mr2579435pgp.327.1580358089558;
        Wed, 29 Jan 2020 20:21:29 -0800 (PST)
Received: from localhost ([122.172.141.204])
        by smtp.gmail.com with ESMTPSA id k63sm4296235pjb.10.2020.01.29.20.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 20:21:28 -0800 (PST)
Date:   Thu, 30 Jan 2020 09:51:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
Message-ID: <20200130042126.ahkik6ffb5vnzdim@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-4-saravanak@google.com>
 <20191125112812.26jk5hsdwqfnofc2@vireshk-i7>
 <20200127061118.5bxei6nghowlmf53@vireshk-i7>
 <b0be1275-c5cb-8171-58fa-64d65f60eaf8@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0be1275-c5cb-8171-58fa-64d65f60eaf8@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-01-20, 19:04, Sibi Sankar wrote:
> I don't have a gen-pd use case to test against but with the is_genpd
> check removed it works as expected when I used it against this
> series: https://patchwork.kernel.org/cover/11353185/
> 
> In the lazy_link_required_opps fn shouldn't we skip the dynamic
> opps in the the opp list?

Tables with dynamic OPPs should not be there in pending_opp_tables
list and so that function shall never get called for them.

> With ^^ addressed:
> Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
> Tested-by: Sibi Sankar <sibis@codeaurora.org>

Thanks Sibi.

@Saravana: Can you please give your feedback as well? I don't want to
push something that may end up breaking something else :)

-- 
viresh
