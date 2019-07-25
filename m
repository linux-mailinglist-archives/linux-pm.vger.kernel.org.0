Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5460574339
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 04:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389041AbfGYCXt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 22:23:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39141 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389040AbfGYCXs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 22:23:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so17892856pfn.6
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 19:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f2gYhr2xF9eqfzuK1I6ByZW/6E+IIFIf49moUqSig44=;
        b=UWpYFZCqApaDNfrjdA5KtekES5UJ5GTU1kmcTFDFb2FLfRCDcNFDgvronSImr9dgD9
         0mFTlZI7X35xO1vEdd3Gki5LIf98gKG5QhKxb/Y4+VDIDhfB1gwWeVXBqiLEyWL2EkgW
         NT11Oz6vHpCvPOjC1YKTKmUoFKun/2NxPqpp1JkpL65nRxlStWUN4lRLXspUzJnsSUs7
         f0W+td0YgaR8ANRf2sKNe+yfU85x4p815cUUDhoDA7GMXy2XLaBS0z1jQB9wcs/VHaCv
         7pV5B+RTx3CuZ/R9xi/w3tBHDvXglw6aX/anI5anp/fOKcEQncy2ECQwLBNYPNc9rUd9
         Z5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f2gYhr2xF9eqfzuK1I6ByZW/6E+IIFIf49moUqSig44=;
        b=mqCyvhrNTCSu0Xwgxc5sQ52g0tnAiuYriXe7hZUOKBIgNgWGuEjlx02v3unVXwlkul
         BAHKHD3/gWSCr5yDP97rsFVLWnsdDEIHf2ukBD2Vc/L+D/eAqnaVncMtOlHumOqUznOI
         urCGOLXTI1RSVywti6ukhTVTyUuyuDfzze0olfalItBqt+wBUh2zH0DHBgdjiRJM1NhT
         zsjDO9arI5+Vm9Wj5gL6d97HByQn0tSGrMwsSpbuE6CCHLpmkwJU0yhw+XEG/rJqY7y0
         tZ6CsatLov0726cWxF3t90GYvr8gCU8EJWCE//r5kP50WiLKYTldPCpcbm+c75oumJd3
         el8A==
X-Gm-Message-State: APjAAAXUUJ6RTIiWOiaihMOagGj+KxnL8CE36f8pITERAf1LSOpGr+fs
        mjvrjBYbljk7V35qOpG+F0pMAQ==
X-Google-Smtp-Source: APXvYqzXNlrdXx1C+X0/1qZx+FxwGsBmRDCWeiwCURuT22GPdQ5YuJbOB5TOiPQUDU7gUhGBG6bBRQ==
X-Received: by 2002:a62:750c:: with SMTP id q12mr14690753pfc.59.1564021427936;
        Wed, 24 Jul 2019 19:23:47 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id k25sm37963077pgt.53.2019.07.24.19.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 19:23:46 -0700 (PDT)
Date:   Thu, 25 Jul 2019 07:53:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>, krzk@kernel.org,
        robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 0/9] Exynos Adaptive Supply Voltage support
Message-ID: <20190725022343.p7lqalrh5svxvtu2@vireshk-i7>
References: <CGME20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1@eucas1p1.samsung.com>
 <20190718143044.25066-1-s.nawrocki@samsung.com>
 <20190723020450.z2pqwetkn2tfhacq@vireshk-i7>
 <5ef302a4-5bbf-483d-dfdf-cf76f6f69cee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ef302a4-5bbf-483d-dfdf-cf76f6f69cee@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-07-19, 15:10, Marek Szyprowski wrote:
> Hi Viresh,
> 
> On 2019-07-23 04:04, Viresh Kumar wrote:
> > On 18-07-19, 16:30, Sylwester Nawrocki wrote:
> >> This is second iteration of patch series adding ASV (Adaptive Supply
> >> Voltage) support for Exynos SoCs. The first one can be found at:
> >> https://lore.kernel.org/lkml/20190404171735.12815-1-s.nawrocki@samsung.com
> >>
> >> The main changes comparing to the first (RFC) version are:
> >>   - moving ASV data tables from DT to the driver,
> >>   - converting the chipid and the ASV drivers to use regmap,
> >>   - converting the ASV driver to proper platform driver.
> >>
> >> I tried the opp-supported-hw bitmask approach as in the Qualcomm CPUFreq
> >> DT bindings but it resulted in too many OPPs and DT nodes, around 200
> >> per CPU cluster. So the ASV OPP tables are now in the ASV driver, as in
> >> downstream kernels.
> > Hmm. Can you explain why do you have so many OPPs? How many
> > frequencies do you actually support per cluster and what all varies
> > per frequency based on hw ? How many hw version do u have ?
> 
> For big cores there are 20 frequencies (2100MHz .. 200MHz). Each SoC 
> might belong to one of the 3 production 'sets' and each set contains 14 
> so called 'asv groups', which assign the certain voltage values for each 
> of those 20 frequencies (the lower asv group means lower voltage needed 
> for given frequency).

There is another property which might be useful in this case:
"opp-microvolt-<name>" and then you can use API
dev_pm_opp_set_prop_name() to choose which voltage value to apply to
all OPPs.

opp-supported-hw property is more useful for the cases where only a
subset of frequencies will be supported for different versions of the
SoC. And what you need is a different voltage value for all
frequencies based on some h/w version.

-- 
viresh
