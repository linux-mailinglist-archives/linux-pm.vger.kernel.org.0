Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559363FD27D
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 06:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbhIAEmQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 00:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbhIAEmQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 00:42:16 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2983C061760
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 21:41:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e7so1527383pgk.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 21:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q8k8JI5FQuW1Mw9/upEhUeHBL2hwhBOt8kVZIdnHXcM=;
        b=ueFckocskygmdIn2npYotKsJ8yZNB4RDDxCogdztDyt0UjXi/gKpdgxTc0azraVN98
         x0N2N/nV/Mm1iQDinTlHP10SApFsAFNDOrDVccJ5TVAAKugUdL9+mH6AXwJKEavP6JaS
         FvKqNtFh8JwKNwfJ25n4FXeEQ+qJ+yzrS/fsGAWAaX2kBJrkgjQ+FY+B7yE9b+sOqva+
         ky5j8HqwIO2/lfp6OBFcMW+SV9l4yJ9zvtlVNSzTqDepMiyBuFEpmShLomOPoIuuagtn
         XrIfTVSJ+09PCCRKYqODyjBMGA2CRObHy1MVidxo6/c/CRqU1wUYS8EWY4duv4M9BWEL
         o2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q8k8JI5FQuW1Mw9/upEhUeHBL2hwhBOt8kVZIdnHXcM=;
        b=QY8RSVTZtkSQQ+H5TPfQvWQcn+hTcrBXDhdgJ4uDCJACSGS39RA8RP+6semRN+cL2z
         HVCQxAf+d7HceFyS96ZKZE8UeEPpqJlOH/PbPLw+6Ew3j/dZOqrEaqWmgVUgxDJwVDBm
         QQFP6B14LwpyOMpet0oSm609KRIrzRwwod4PvwcZ7vLd7uhDYiwYtWZC2Ht+Q7SXrgxE
         bbDVcaRdphMfbNyjXfxSKwJnkVoTu1kbPQ/sHMtn4NXbgfVkG+nKUqtjL9pJ5ggPAZIy
         zCdOiq9ZbwkLX8Wf21Gn9SL6gdd1UPklnhHwKYyKnnkrnMhLDHdW8zYwRTiu5t8S59H/
         DMBw==
X-Gm-Message-State: AOAM53141kHe9W2GiPBcBnFH8RNOxml5BFlReARGfg+zAwN4apTePZsj
        kY06BOhK4XWwMqTgfRL4TT0RLw==
X-Google-Smtp-Source: ABdhPJx5eWyZvUYCrsUn5TYkBM2Bd9wtBSNTavsfmJkMqa/KnwmVLuEH80r9qecitwRqDFzv8gNF8g==
X-Received: by 2002:aa7:8014:0:b029:3cd:b6f3:5dd6 with SMTP id j20-20020aa780140000b02903cdb6f35dd6mr31875202pfi.39.1630471279492;
        Tue, 31 Aug 2021 21:41:19 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id a21sm21633013pgl.51.2021.08.31.21.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 21:41:19 -0700 (PDT)
Date:   Wed, 1 Sep 2021 10:11:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 3/8] opp: Change type of
 dev_pm_opp_attach_genpd(names) argument
Message-ID: <20210901044117.abfwfebqw5lbn5zj@vireshk-i7>
References: <20210831135450.26070-1-digetx@gmail.com>
 <20210831135450.26070-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831135450.26070-4-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-08-21, 16:54, Dmitry Osipenko wrote:
> Elements of the 'names' array are not changed by the code, constify them
> for consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/core.c     | 6 +++---
>  include/linux/pm_opp.h | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 602e502d092e..d4e706a8b70d 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2359,12 +2359,12 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>   * "required-opps" are added in DT.
>   */
>  struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
> -		const char **names, struct device ***virt_devs)
> +		const char * const *names, struct device ***virt_devs)

I am sure there are issues around space around * here. Please run
checkpatch with --strict option for your series.

-- 
viresh
