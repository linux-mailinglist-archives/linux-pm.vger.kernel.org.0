Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD405A8F07
	for <lists+linux-pm@lfdr.de>; Thu,  1 Sep 2022 09:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiIAHBa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Sep 2022 03:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbiIAHAv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2022 03:00:51 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DEAB5337
        for <linux-pm@vger.kernel.org>; Thu,  1 Sep 2022 00:00:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id z187so16632616pfb.12
        for <linux-pm@vger.kernel.org>; Thu, 01 Sep 2022 00:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=XcLxmoK8X1rF3FVFD0JBqtFjjFipU55iwKHDlizFoCg=;
        b=ELWrLnRa+jJMj9l69Mv3iL3lMyvZ5BmSP0cgO1D9xRZ6jvTsvYtpxQJsPNxPna9r+/
         sipKO9ZnYcpqQ3+wkD9z+lxmFIrTcPalX8cC5zcyVEgVQ9cnObBprDvuaGPJ1C9ZMBtk
         aDm193aRttofrbI8KWUVS3yxeDvKZhupR5FCC6cZ2dag6q3oCvaWebHj0yr63tUSqrSc
         J61vJMomwIMzImOJxvR7yz6znfAuez1YyabI1w8DEOWJ48agv285VjBz/yk785/rSDWk
         FysEoblcKPbkP5lA53XuRYncOCM6SAI16EWdeeEAP/1FeTwO0K3cUR/leywK/5xzFLbr
         /AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=XcLxmoK8X1rF3FVFD0JBqtFjjFipU55iwKHDlizFoCg=;
        b=NHsIlko/1F0nkby6umyEkvkrP8DBmoPdEgv4R+mRDt9hEVxyReg+oQ663iK9g8X/wt
         03l5PxkqXyIQkGvyMIZaGr5xcYga6ci/n38jGEaLnRptZWv5Q/uXtJKf14JQurSTw6DB
         k9m+yIe2EtZputBx08/RwKgJjY1hZ7nOz/Rd+Y1dgEgbKwKcyV7L7rhW6VCJ62Pe8PdA
         IbQ8l3TBcTool4gMv/WuN211qNyS6xtHtnhdEQsUlbfxJZUgvrvX3r1IJbHS5Cl/t+wy
         ZY8D+IvUz1ejwKvpvMt34wOobWroxG1RXK1Yvh2Ie3L3fHsQ5CIV+d/IWgBOMWUtk5gk
         XBUA==
X-Gm-Message-State: ACgBeo0KoGRfESw9MZWggI72t0g5RzG97uVGsP353vyybqmZRoaRRbXI
        vlEX9xoJnp2P+s7BZzvvuaQlbg==
X-Google-Smtp-Source: AA6agR6uOq/9FNUO/JkGYj+fPAoBwunDhHXuoa8RiEVETo4ejMSHHIQD4X5ylxMWepEgJ6YgSPPJUQ==
X-Received: by 2002:a63:1e11:0:b0:41c:d233:31f8 with SMTP id e17-20020a631e11000000b0041cd23331f8mr25233343pge.228.1662015631026;
        Thu, 01 Sep 2022 00:00:31 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id i3-20020a17090ac40300b001fd77933fb3sm2559403pjt.17.2022.09.01.00.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 00:00:30 -0700 (PDT)
Date:   Thu, 1 Sep 2022 12:30:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] cpufreq: amd-pstate: cleanup the unused and
 duplicated headers declaration
Message-ID: <20220901070028.gdm7uiszm35iom3e@vireshk-i7>
References: <20220901062339.2357552-1-Perry.Yuan@amd.com>
 <20220901063153.zutwnnfykaz47sah@vireshk-i7>
 <DM4PR12MB5278D01EA2D78367F182C7C69C7B9@DM4PR12MB5278.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5278D01EA2D78367F182C7C69C7B9@DM4PR12MB5278.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-09-22, 06:56, Yuan, Perry wrote:
> > On 01-09-22, 14:23, Perry Yuan wrote:
> > > Cleanup the headers declaration which are not used actually and
> > 
> > This is okay.
> 
> Thank you help to confirm this . 
> 
> > 
> > > some duplicated declaration which is declarated in some other headers
> > > already, it will help to simplify the header part.
> > 
> > This isn't.
> > 
> > Every file should directly include headers they use definitions from, instead of
> > relying on indirect inclusions.
> > 
> > --
> > Viresh
> 
> Do I need to update the commit with another V7 version ?

I am not sure which headers you removed are still required, working
for now since included indirectly. If there are any, then better to
get a new version out.

-- 
viresh
