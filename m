Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79A7293940
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 12:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393242AbgJTKgW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 06:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392110AbgJTKgV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 06:36:21 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6D8C061755
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 03:36:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id lw2so756271pjb.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 03:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xMyFD9aGKc1uxqgQqPeeOsvhMt6C8yiL5bwMNHZ2olo=;
        b=GSMeM7NOjHfz41kQrfcTjo3+JWRn+PyrY3mFZMC2M7Mzs89wRF4FVzkzCX3S6+NOjB
         zk57fp2xG9nMX7vfnuakibqPWCHF1dqli5JQZVtB7epDQDX30IRoXNZNw3hRhLvcnMG7
         pes7iP9/6KdH0Aapb3g1e+xoPbZaOv/6/fxiCR7M4yzDnA5/Rhel6MyoO5DGRKiGrrJV
         Re7WID/H5J23z/hqNWh87jJhavo/A8n1jxkgzhsk1Fi/uRIRUG7aLhk45P0gGFXKlA7m
         I4wxUl0djcYJMx/BiPlyYNVL7TnodAnUuhUoUKuQGpOIs/lcPuNVZu9cVeL2aShEwg0a
         vJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xMyFD9aGKc1uxqgQqPeeOsvhMt6C8yiL5bwMNHZ2olo=;
        b=Ao7hSnTSzdoCEzCG5eTPPPbDACE6qjUYbC1I/ADmLC6TPxQB71J37KK0yvkNVVkaZk
         J6CiMzbbAI+1CmIBj6/Nvtq0CGCOJ6X32PAxbbHPEsGP/zDyY1QyQXVhoDvVOhUuW/My
         QfF5OFiAkBLNgs81vILoYlXxEsRHBqj/gS5JJD3rjcwlvHSh4KatOQPlMfuDkPNC8nMj
         2A/OEl4U06VUJojCBaAEaaFx6QHGRPwPGGuBIuwwFlJZgLWWuRcBREPYwg8nxzefwv2s
         yXcCWbGyNlGHUIO3va9OtWobfJVcTNvJJSNwdhf2+vvo3Sg8etUPK20gDFaiQMh0api8
         PH2w==
X-Gm-Message-State: AOAM532pWlC6HJg0x+aiY5Rvf5Rm1uHIhTkyxnC7/gNCahg6OSbOigp6
        ISFA48O7eMcUkGn/A2XhWbS/rw==
X-Google-Smtp-Source: ABdhPJxk4To5ufiwxPrTIXU0TYP0McrQLZP7E8JHmy9qgb+tIux4p/Hw0G7cVl1LQfteqOAETflXLw==
X-Received: by 2002:a17:902:c252:b029:d3:d480:9e10 with SMTP id 18-20020a170902c252b02900d3d4809e10mr2364704plg.47.1603190180695;
        Tue, 20 Oct 2020 03:36:20 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 70sm1792610pfu.203.2020.10.20.03.36.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2020 03:36:19 -0700 (PDT)
Date:   Tue, 20 Oct 2020 16:06:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, sbhanu@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>, nm@ti.com
Subject: Re: WARNING: at drivers/opp/core.c:678
 dev_pm_opp_set_rate+0x4cc/0x5d4 - on arm x15
Message-ID: <20201020103617.qramu2ejlp44qxcz@vireshk-i7>
References: <CA+G9fYvK5UkERLuBSRH5t2=j5==dbtw45GTMta9MafyJDqFsFA@mail.gmail.com>
 <20200827094651.3grvs6ungv3dh7y3@vireshk-i7>
 <20200827211832.3ebeda8a@canb.auug.org.au>
 <20200828045128.y7ybkd7dnvn4h6dt@vireshk-i7>
 <CA+G9fYsn1S-SieuP85-Z4qKO+aNyqJarrBR0xx0X-YbtF9eo0g@mail.gmail.com>
 <20200831044132.jb7aflr2sfbart2z@vireshk-i7>
 <CA+G9fYsLd77Wuz6Fdwr0w4eFvs=rX5ooewrztFtSe7MeyRJeGQ@mail.gmail.com>
 <20200831060203.7guhirtxb72odow2@vireshk-i7>
 <CA+G9fYv5WKQkDvjZsc+xth54X_MK3qUmuUTXhUDVUHpS3UhNpQ@mail.gmail.com>
 <20201016054551.jwxk2xdvvnk7o5yy@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016054551.jwxk2xdvvnk7o5yy@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-10-20, 11:15, Viresh Kumar wrote:
> +Dave,
> 
> On 15-10-20, 15:26, Naresh Kamboju wrote:
> > The arm x15 boot failed on Linus 's mainline version 5.9.0.
> 
> Don't mention the version as this doesn't give the right information.
> You tested it over 5.9 + 5.10-rc1 material.
> 
> > I have listed the latest commits on drivers/opp/ .
> > 
> > metadata:
> >   git branch: master
> >   git repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
> >   git commit: 3e4fb4346c781068610d03c12b16c0cfb0fd24a3
> >   git describe: v5.9-4105-g3e4fb4346c78
> >   make_kernelversion: 5.9.0
> >   kernel-config:
> > https://builds.tuxbuild.com/2BB2g61t29VaadVLXEl4cQ/kernel.config
> > 
> > 
> > ------------[ cut here ]------------
> > [   13.530971] sdhci-omap 4809c000.mmc: Got CD GPIO
> > [   13.535647] WARNING: CPU: 0 PID: 137 at drivers/opp/core.c:678
> > dev_pm_opp_set_rate+0x4cc/0x5d4
> 
> Looks like the stuff from drivers/opp/ti-opp-supply.c supply didn't
> work as expected.
> 
> One of the major changes came with these patches:
> 
> dc279ac6e5b4 cpufreq: dt: Refactor initialization to handle probe deferral properly
> dd461cd9183f opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER
> 
> And that's where I think it may have gone wrong.
> 
> Dave: Will you (or someone else from TI) can have a look at it as well
> ?

http://lore.kernel.org/lkml/be911bcddc1dbf4a152513cb3d83f8eed7d2574c.1603189831.git.viresh.kumar@linaro.org

I think this will fix it now.

-- 
viresh
