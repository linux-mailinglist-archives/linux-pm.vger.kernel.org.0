Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD33D220647
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 09:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgGOHeP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 03:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgGOHeP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 03:34:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32F3C08C5C1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 00:34:14 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j4so1275631wrp.10
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 00:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=avwYWZQgEurqcXkU7LpKmqAZpVrL+3myo10HNlbAiZA=;
        b=wgjaf8T1iOlWhopvmy+kXu8jWdXSOxYGhU2LJgDU+1bJ7mSLxnZLcs5PjppVPgRhcC
         Eje79C3Xs68AChjt6q4Y5J9Z16PLZ4PamfnKnB0SeuJF3hEoZqg6PKLnofhGcajGBf+s
         YSNx6kh8ovtCar3Gm+FZ0JIncFmpLKuOy3MN/R2dDLvQ4nwqtftOddT60HrAzwfGipvW
         ODbCqSMz3NqiW2TAIembjtpsPH/c9qw/hcy3NEsRybF0pYNFzUs97kp9e9Qr1Eyk5iOk
         Gv+evS6dDnt16H2yWHuat/lYByKUtuxxUHYl/fCKHppZkvFDrquGWR2ACNuFs8an1IIf
         XvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=avwYWZQgEurqcXkU7LpKmqAZpVrL+3myo10HNlbAiZA=;
        b=D7PCQNQ11pz4s4I7aZ2siLet0UD8LhMa8FqqjyOLe1yW7uUDwDTie8xX9vuQVS3fNf
         0RkTGuwl+OEoL9Cqd6GwPRi4N/APsOmoJ4BRVSgsZEpWPPMiN6JwBqnrNkgKVVzuiyxC
         y4S30/m+JHsF3tIIPLmfJBok8h6Bvev0//fPUdYmj2KAkxVvltXMhp9xTc8q7eUjhaV6
         8MG+zKsKY9Xjt+pz1WP33W1I65NNLvNG4dhMpN1b1l3wwFROsjEn7LmsXhntMPwgmVNf
         0tTcE4//YRE4Fu1D/1mObD+gzESwVKh4epJ/eHrmaNCs1FEI8djspjbWJpDgrO4BZMtO
         Pkqw==
X-Gm-Message-State: AOAM531Rr9Tv3wvSEfjYaLYxR6eePHMfMuMBKQx0U9vBmlvhZwGlKRGY
        ZkaJ/1Dzod/RLF4DQqYUlmKV1w==
X-Google-Smtp-Source: ABdhPJyS0HtFat3SprvbB0DRVKo+gi+RW4I85zv/+N8Y6ZxU4LhmFYr/l4W/3k8I7mEZq/5kyRo8Fw==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr9785584wrw.199.1594798453497;
        Wed, 15 Jul 2020 00:34:13 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id u23sm2299147wru.94.2020.07.15.00.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 00:34:12 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:34:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 00/13] Rid W=1 warnings in CPUFreq
Message-ID: <20200715073411.GZ1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200715033627.k6ardlhm3z3w65xw@vireshk-i7>
 <20200715063214.GO1398296@dell>
 <20200715063800.4vfxie2wrmaqdnra@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715063800.4vfxie2wrmaqdnra@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jul 2020, Viresh Kumar wrote:

> On 15-07-20, 07:32, Lee Jones wrote:
> > On Wed, 15 Jul 2020, Viresh Kumar wrote:
> > 
> > > On 14-07-20, 15:50, Lee Jones wrote:
> > > > This set is part of a larger effort attempting to clean-up W=1
> > > > kernel builds, which are currently overwhelmingly riddled with
> > > > niggly little warnings.
> > > > 
> > > > After these patches are applied, the build system no longer
> > > > complains about any W=0 nor W=1 level warnings in drivers/cpufreq.
> > > 
> > > And you need to rebase this stuff of pm/linux-next, as there are some
> > > changes in cpufreq.c there.
> > 
> > It's based on the latest -next.  Is pm/linux-next in -next?
> 
> Yes it is. Actually my bad, I based it on my next which didn't had
> pm/linux-next :)

No problem.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
