Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D5E306E09
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 08:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhA1HCH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 02:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhA1HCF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 02:02:05 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7BAC061574
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 23:01:25 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id g15so3730143pjd.2
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 23:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nlba24MbVDarjbDWpz/7r7AuP6jGDXLXfVDSaaZnioc=;
        b=CQrSlYQAFkR9mTkea/Og6d9itO4X0ucrPrdmZnnS+W7X9SSXuLeRnkUW42pl3MuDlu
         HMGldKk3rabPpFJ4Y/7RGCcMHADDabJc3vgRy4az+r1YlIeabU/h26bGp9s65SkwMclJ
         cdpa8X6Qhg22Ma4mbSSC9HwJaSS0alKqZoOa0x6HNkaKPGHUXDgS0ff0cPOWuFO70ZPU
         izGmB5iu1z/0ks366VGNhSTOrnzqc3fL1AuOljYrvh0fJKVRVgXJwhz/l4N5N/33II5P
         pKdZLVzdEfrN650ZYNQ3/EI0y1N27p8GVG/mivXwNpUrx1WSOayX+jTnPPgYf8FMlwgR
         M6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nlba24MbVDarjbDWpz/7r7AuP6jGDXLXfVDSaaZnioc=;
        b=IsLbtvolHBxU0Jn83gvBJgmzlTPgGNGbZ8iOjyQuhZSZn/V0qBWDYYby9OZ8mVfn/s
         VjsspTtkaKsptfwvtVVnMftEWKZWFx82UclouRz2NIHwZbuzLZDUVD3ofBXlep+5QcTy
         eYxGb/nXiUd/JgqYUIu9Kd8Edf58QIub2MBTnHsrbf0m2imZuPC3w4hPBCyORZQ0zcBm
         9Fy07noFv6sxfybNRsscQXzd0XNw1LTKol7v8oj9uAMV0FTgbUJLwBysbc6JAaz6qbhD
         rNIYsXu/UaFlcxjT9z0l6+4i+jZRJ0ktALKZ53FhqFArdOSuU9wAhBOziNyOBk/bkpwM
         UWvw==
X-Gm-Message-State: AOAM530yUmklobpvaFgi48pOK+wfKpfzKJuEFP0AgbMXHvk/abGBliAT
        5Bf5/EadmG8GLpPuyetXA+APeA==
X-Google-Smtp-Source: ABdhPJwJrZUiQO7pCFolzTYtxYtzNwESyIYHO8ut0T/Glo0lFk5TiR1nbYNQ/a7MnPw6ElBz53tRAQ==
X-Received: by 2002:a17:902:854b:b029:db:c725:edcd with SMTP id d11-20020a170902854bb02900dbc725edcdmr15248493plo.64.1611817285276;
        Wed, 27 Jan 2021 23:01:25 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 77sm4530580pfx.130.2021.01.27.23.01.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 23:01:24 -0800 (PST)
Date:   Thu, 28 Jan 2021 12:31:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 11/13] devfreq: tegra30: Migrate to
 dev_pm_opp_set_opp()
Message-ID: <20210128070122.d3syt7mhey2dcf4s@vireshk-i7>
References: <3345fd49f7987d022f4f61edb6c44f230f7354c4.1611227342.git.viresh.kumar@linaro.org>
 <f0341655361aa0107266ed9c838aa8bcfe50a3ed.1611738418.git.viresh.kumar@linaro.org>
 <20210127100234.vl2wwe7rjrrz4btz@vireshk-i7>
 <b5f1065b-14ad-adae-af1c-e9962e6626ad@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f1065b-14ad-adae-af1c-e9962e6626ad@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-01-21, 18:58, Dmitry Osipenko wrote:
> Sadly this doesn't work because we missed that clk is assigned to
> opp_table when OPP table is allocated and not when it's added to device.

Ahh, I missed that.

I have bumped up the other patchset to V2, that should work fine with
this patch for tegra30 (this shouldn't require any update).

Everything is pushed in opp/linux-next, fetch and try it. Thanks.

-- 
viresh
