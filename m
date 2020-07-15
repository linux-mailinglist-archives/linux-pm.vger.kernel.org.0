Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900AF220501
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 08:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGOGcT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 02:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgGOGcS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 02:32:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C349C061794
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:32:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so4146539wmj.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pkHUcVa4GYgE65LjnGsodAOm4gwGb9et7Xg2bzrwdzE=;
        b=jGogWDgbgbl2Aen5UYcLTTHJfC/9rpVJZsfavJSZ7TkB5UwdLUMDooQoT6g+wKKZw9
         pZHxPvxYwfTgAFzLCmz+mWXsHQuf4K+jmnjlmHf08qnBBgAEJifed9e/K9+61lg/9W6F
         qUDNBAit2SLTA4D++TMePb0pZdD5qlETRBG6ZREFNiC6cj5qKW3ix/j6eMxcthF7Em8m
         ZmILsRfMBsfk7btqm+m4BKYdWFj0kKbuGYJyGJeoRVd8hv+etMhaR2O9xRbxHdQVpMOG
         Sh1xCQiazfBihP6e29yQc2uONwoPl7CTIMkQE0fKSQFjE/mdkvASHRFmZ+VsRuk4Lxhe
         okZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pkHUcVa4GYgE65LjnGsodAOm4gwGb9et7Xg2bzrwdzE=;
        b=plBWHrCZf3PCR6nWmyEkj3EzeY95RYmu0gyQWbS/wnBBHp1hFYPU/09hYPCvhixyBB
         0m85clTlQeu/hOupYpzC0Y2Wk9i+lzFCHs4b83PFfPdPTV28Bcv5tfbL1j2q/KopYq0Q
         IMFdf1oRIzNXFZ7j/HbGa4KGN/szevzKaoXYQIkT9hpD91pZmqYoTNdEDyKgO3KQ//YH
         dmMNigSqt6g3uYu/403s7hAUvJujKLeFlpyxW4j0d1rHa821gRNxaJbBlesHraEVwfMc
         lTEJIqiqZCIOUt/eMLeI39H3gF3uF92ZCyET8shqdaliV8qcKKIFbvlyoyMTDTJWlNcH
         6/Rw==
X-Gm-Message-State: AOAM533dNicfr68yc3/AIom28Su3Pdyf2CCXeYRItWnHlKwI9UigyLFC
        LMU1HGGwpBJ/cpqa5o7zcqS1CGHl1tc=
X-Google-Smtp-Source: ABdhPJxMK1q+aFYu8Ne/pvxzKFhE4bmkNgHpgH+yuuJVXawMMk1x0V0KEwkym2ub6wbPjV351i6yeg==
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr7440522wmc.51.1594794737161;
        Tue, 14 Jul 2020 23:32:17 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id t2sm1827418wma.43.2020.07.14.23.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 23:32:16 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:32:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 00/13] Rid W=1 warnings in CPUFreq
Message-ID: <20200715063214.GO1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200715033627.k6ardlhm3z3w65xw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715033627.k6ardlhm3z3w65xw@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jul 2020, Viresh Kumar wrote:

> On 14-07-20, 15:50, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > After these patches are applied, the build system no longer
> > complains about any W=0 nor W=1 level warnings in drivers/cpufreq.
> 
> And you need to rebase this stuff of pm/linux-next, as there are some
> changes in cpufreq.c there.

It's based on the latest -next.  Is pm/linux-next in -next?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
