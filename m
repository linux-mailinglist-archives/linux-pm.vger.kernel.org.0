Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2F8920F1
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 12:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfHSKGq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 06:06:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33934 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfHSKGq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 06:06:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id b24so903654pfp.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6YMARnBm7B+MKOmk57BApjS/es/AZIVLPWfQBAL1uiI=;
        b=Ltly77eya2ZHkenw1lFaLukEhxN4gMQEVwOD4aajtliH0GlevR+LzfnfINIbGZldt+
         mHPxjruDnwwIvRd6gq3XnLiTHK2LImnTWnSIb+B+aFkBTnq8MHl0pNBcZ+Ce4FM09cp8
         ihEUSX6luQqwhsFviNrt8LTKObfhBe1Fqpm7Q0yewHvewovh+4DdcK4oiobEUB0hMsML
         outXNkNvFunIK0jD+hq47Kz/r9r5meCFBIVov84gs4XdwKhVA2VAaMJ1K+TI4nmQ5eeR
         cJY3Y7yo4U5sR4IZh3Ke1gn/JiYPrlO3KVT3L2UYghXy89dV2GnwoLwzYP3VtM1O9ltK
         1eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6YMARnBm7B+MKOmk57BApjS/es/AZIVLPWfQBAL1uiI=;
        b=SlTcGN6BlmUJhnbz6DwXam4jZkoI1coZBCdC3YA8HzMzCoohnQwLDDrGLmv8W+sROP
         nrhjJ0RMdxgbeQ838pLN7gPysatPvVJtmK2eLk5d9TicTvYYeaDolkOHzY00WE4xd2fk
         a8G3njAMzMB85OcipgsR4blxgl2Q7vJtuTmex24IyMGmBzF2bhz3XBuHVGtw92HhnD7M
         6rCH7dVNZK/DWopYLyma2VdGFJ6A4rGCYDuA8Vi/qlUPuJTMERHpBsmAXIBJVgcmY99B
         GotUIpmKjZY6lupp34VCb4LidbFscHuE5Yty2eagdro7Z+h0sQTbAWXwbLDKX709sbay
         qkTw==
X-Gm-Message-State: APjAAAW18yB2l4+JehZgUKwFdobHizywpef2VQmLfbGnO2ZuYypphgIw
        HN7JOJMH90EbkjfFgoLioGAXzQ==
X-Google-Smtp-Source: APXvYqzreJijvk3uX+BNwXXnkkyRrE/6662mwuSEGeb1CmdC9G2lWBgGtyuYEOtScyn90y57Rn3mlQ==
X-Received: by 2002:a62:26c4:: with SMTP id m187mr23960820pfm.49.1566209205119;
        Mon, 19 Aug 2019 03:06:45 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id 11sm21266551pgo.43.2019.08.19.03.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 03:06:44 -0700 (PDT)
Date:   Mon, 19 Aug 2019 15:36:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, krzk@kernel.org,
        robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 0/9] Exynos Adaptive Supply Voltage support
Message-ID: <20190819100642.tvnzt6d5rikugycr@vireshk-i7>
References: <CGME20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1@eucas1p1.samsung.com>
 <20190718143044.25066-1-s.nawrocki@samsung.com>
 <20190723020450.z2pqwetkn2tfhacq@vireshk-i7>
 <5ef302a4-5bbf-483d-dfdf-cf76f6f69cee@samsung.com>
 <20190725022343.p7lqalrh5svxvtu2@vireshk-i7>
 <562dd2e7-2b24-8492-d1c1-2dc4973f07be@samsung.com>
 <20190819090928.pke6cov52n4exlbp@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819090928.pke6cov52n4exlbp@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-08-19, 14:39, Viresh Kumar wrote:
> On 09-08-19, 17:58, Sylwester Nawrocki wrote:
> > Thank you for your suggestions.
> > 
> > For some Exynos SoC variants the algorithm of selecting CPU voltage supply
> > is a bit more complex than just selecting a column in the frequency/voltage 
> > matrix, i.e. selecting a set of voltage values for whole frequency range.
> > 
> > Frequency range could be divided into sub-ranges and to each such a sub-range 
> > part of different column could be assigned, depending on data fused in 
> > the CHIPID block registers.
> > 
> > We could create OPP node for each frequency and specify all needed voltages 
> > as a list of "opp-microvolt-<name>" properties but apart from the fact that 
> > it would have been quite many properties, e.g. 42 (3 tables * 14 columns), 
> > only for some SoC types the dev_pm_opp_set_prop_name() approach could be 
> > used. We would need to be able to set opp-microvolt-* property name 
> > separately for each frequency (OPP).
> > 
> > Probably most future proof would be a DT binding where we could still 
> > re-create those Exynos-specific ASV tables from DT. For example add named 
> > opp-microvolt-* properties or something similar to hold rows of each ASV 
> > table. But that conflicts with "operating-points-v2" binding, where 
> > multiple OPP voltage values are described by just named properties and 
> > multiple entries correspond to min/target/max.
> > 
> > opp_table0 {
> > 	compatible = "...", "operating-points-v2";
> > 	opp-shared;
> > 	opp-2100000000 {
> > 		opp-hz = /bits/ 64 <1800000000>;
> > 		opp-microvolt = <...>;
> > 		opp-microvolt-t1 = <1362500>, <1350000>, ....;
> > 		opp-microvolt-t2 = <1362500>, <1360000>, ....;
> > 		opp-microvolt-t3 = <1362500>, <1340000>, ....;
> > 	};
> > 	...
> > 	opp-200000000 {
> > 		opp-hz = /bits/ 64 <200000000>;
> > 		opp-microvolt = <...>;
> > 		opp-microvolt-t1 = <900000>, <900000>, ....;
> > 		opp-microvolt-t2 = <900000>, <900000>, ....;
> > 		opp-microvolt-t3 = <900000>, <900000>, ....;
> > 	};
> > };
> > 
> > I might be missing some information now on how those Exynos ASV tables 
> > are used on other SoCs that would need to be supported.
> > 
> > There will be even more data to include when adding support for the Body
> > Bias voltage, for each CPU supply voltage we could possibly have 
> > corresponding Body Bias voltage.
> 
> Will something like this help ?
> 
> https://lore.kernel.org/lkml/1442623929-4507-3-git-send-email-sboyd@codeaurora.org/
> 
> This never got merged but the idea was AVS only.

Here is a recent version under review.

https://lore.kernel.org/lkml/1565703113-31479-1-git-send-email-andrew-sh.cheng@mediatek.com

-- 
viresh
