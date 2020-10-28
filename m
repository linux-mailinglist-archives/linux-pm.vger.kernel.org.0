Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8023229DA08
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 00:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbgJ1XKm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 19:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgJ1XJH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 19:09:07 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7595CC0613CF
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 16:09:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b19so391355pld.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 16:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q3HZdrGNxCI/rwL2bJs+sG1c4DmY7gX64VUv8zPGJp0=;
        b=w3iZHgADd5v9U6zAOB8D+M8MEqnphniRW2Jy/fJCVN1kcqPClAO4LvMLqXOn07ZoLx
         ghyYw4tbLkd4ZLpFJ5yYzeB2FBTJQOSqLMu+eu0MDJFJ1PQQMIkmn0b06suSVU6pNGV6
         uV39iGdCd3/RgcBjaecMILewDPwDqHInv8BvhYSJukEtH5w8pUdZPPy3QYGUUlq8TXYX
         hViJ47ZuJPB3vTAc/INXSEvHVjOHsgy8am405mFyVp6YQXoavgdc2s31XtRWYPbONypI
         78PXWgfQYCOgG1JQeffggPKb8W+MjeWpY6LcpiSzsV3ffNOzQEzvrZzoRDJygvKe4ngM
         kzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q3HZdrGNxCI/rwL2bJs+sG1c4DmY7gX64VUv8zPGJp0=;
        b=b4ai0yfU3xQEvYr69z7Pz/GDIyMGRrvzw0BTWEhTh8JgD8IUdXaXj4410cXSUh79GH
         jNbnRR3AnuFkgiXahjZ9HdavfrdqV/vZZwh69/aFM/FTOSAk1MejYdnfpCgaRpr6cXRB
         rXH8DmIpvBr624NEeE4Yq6AdxaQ4GxrrgF6qlBrpbFsBTsO7Yvh//wv3DF7+r6I/cA/q
         UJg0ryLTPOduS/DnGTOSb9BbYL20HGZyWvxeDjSnNwBcHdGlMFFvBV+Al3c+9L3U67ND
         SCGsDkcBpKyK3xt+DqcxMmW/U9L38AU29AKwXkso9w4EcYLrxPAR5S0EnLjijSP8fM0M
         UL9Q==
X-Gm-Message-State: AOAM531+lbHyC83bROXypKrwtikQxDmWikWMSK2BFxyM7pZ1Uy+F4p33
        RctalN4jGEvlGdGLrK3WyPZ1l+w5k8B1iQ==
X-Google-Smtp-Source: ABdhPJx3bloTJFrm0fb9VkDA3VdvEPdnyGyj3MWhkAqG7wE90ovxnS/KcE9dbBFeor/v06ApPv/DnQ==
X-Received: by 2002:a05:6a00:2cf:b029:160:c0c:a95c with SMTP id b15-20020a056a0002cfb02901600c0ca95cmr5587882pft.76.1603857803605;
        Tue, 27 Oct 2020 21:03:23 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id kk14sm3187829pjb.47.2020.10.27.21.03.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 21:03:22 -0700 (PDT)
Date:   Wed, 28 Oct 2020 09:33:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 46/52] opp: Put interconnect paths outside of
 opp_table_lock
Message-ID: <20201028040320.4nobxzudy3fuwmms@vireshk-i7>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-47-digetx@gmail.com>
 <20201027051013.5gr4s3wuuwxsd7ax@vireshk-i7>
 <44169d24-4afc-5388-788f-d1e8263fc627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44169d24-4afc-5388-788f-d1e8263fc627@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-10-20, 23:26, Dmitry Osipenko wrote:
> 27.10.2020 08:10, Viresh Kumar пишет:
> > On 26-10-20, 01:17, Dmitry Osipenko wrote:
> >> This patch fixes lockup which happens when OPP table is released if
> >> interconnect provider uses OPP in the icc_provider->set() callback
> >> and bandwidth of the ICC path is set to 0 by the ICC core when path
> >> is released. The icc_put() doesn't need the opp_table_lock protection,
> >> hence let's move it outside of the lock in order to resolve the problem.
> >>
> >> In particular this fixes tegra-devfreq driver lockup on trying to unload
> >> the driver module. The devfreq driver uses OPP-bandwidth API and its ICC
> >> provider also uses OPP for DVFS, hence they both take same opp_table_lock
> >> when OPP table of the devfreq is released.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> ...
> > 
> > Never make such _fixes_ part of such a big patchset. Always send them
> > separately.
> 
> Perhaps it's not obvious from the commit description that this patch
> doesn't fix any known problems of the current mainline kernel and it's
> needed only for the new patches.

No, I understood that we started getting the warning now only after
some other patches of yours. Nevertheless, it should be considered as
a fix only as that generated lockdep because of locking placement. And
so sending such stuff separately is better as that allows people to
apply it fast.

> > Having said that, I already have a patch with me which shall fix it for you as
> > well:
> 
> I see that yours fix is already applied, thanks!

I hope it worked for you. Thanks.

-- 
viresh
