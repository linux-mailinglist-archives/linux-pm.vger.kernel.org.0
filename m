Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038DA212287
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 13:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgGBLqU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 07:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgGBLqU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 07:46:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677C2C08C5DC
        for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2020 04:46:20 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l6so9252195pjq.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2020 04:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y66BdGLXe7ElT19YUw05TZ+XtmB7S3su8JlgwqLpqn4=;
        b=eJ7T25fEPgZk9QNXnChTO+a5BkV6i/A6p7o+VidSoCqAklisjQtAD4HFTkojx2NsHs
         zH/yhGxuzpbyJGcybXmCB6c07VoM05DdC9mHPSGi4pNm9vl0ncRktw3uRz9TxcToUtsJ
         rleBxoLp40KRUt0qmAT6+uKVkjX2V5cJx4Maxle/92nZhajSJaBWaFgjw0qnjFd1f1tY
         QC0uTfknbnIcruC6M1Z+GSVa7fYFkl7y+sbBC6KGIbDCQASt8yE93zURNFOmo6xgzqK+
         loRrMu95ccMw4zU3CYgsrVXy01UIiOrOkr+xt1ObNcvg7kJL2/vaNAoiuap5VOUPb2dA
         n8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y66BdGLXe7ElT19YUw05TZ+XtmB7S3su8JlgwqLpqn4=;
        b=pcXMfvL1SFt2s9r6WKwfohvZ5e6mvsT1e/5h2aQhyBbuBmdyABiWkuwRKR2V3YtN7c
         a+05LUf7UeRF+B9oMG7EnvP9HPDALtvjfdnsQ7LttzBNVFPJ0pWDmjutlJTYE2ABJ5iR
         79XkV7JNEVELpitiJOatpFzsCvEB4P94mhRNsLD+cRhGr0IU2nSTtzxEaHj8ybvFUDGt
         sPVBnBNxbTxVlLOV1abpH4I0AbJ+F4DHPXtoeKQbqxchi8XZfj87pjRLKTeFeF8kab3+
         TxkzVvMjgBfjeqeQb8Or8ylv7yC4souPKZTIWkR6/pe0Rol24gP/5Zay49pqeZMVUuEJ
         vsYA==
X-Gm-Message-State: AOAM530axUfcwsV3guhpLg+zEdonel4xxdOHDghe422VBypBnhlxpv3n
        Sh9ZXkpMIkPLX0HKScZktTRz+Q==
X-Google-Smtp-Source: ABdhPJxGOFQpu5yGoJXE8yveWRzYwJ4ls6rFlsnyYT4JuklF+wC0ozy8mFOMNpmJav9d5Mbmcq/Hlg==
X-Received: by 2002:a17:90a:8c01:: with SMTP id a1mr4912838pjo.97.1593690378893;
        Thu, 02 Jul 2020 04:46:18 -0700 (PDT)
Received: from localhost ([122.172.40.201])
        by smtp.gmail.com with ESMTPSA id c207sm8856436pfb.159.2020.07.02.04.46.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 04:46:18 -0700 (PDT)
Date:   Thu, 2 Jul 2020 17:16:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, sudeep.holla@arm.com,
        will@kernel.org, linux@armlinux.org.uk, valentin.schneider@arm.com,
        mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH 4/8] cpufreq,vexpress-spc: fix Frequency Invariance (FI)
 for bL switching
Message-ID: <20200702114616.kgzxj4ffzgdn2g24@vireshk-i7>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-5-ionela.voinescu@arm.com>
 <20200701095414.2wjcnyhndgcedk2q@vireshk-i7>
 <20200701140735.GB32736@arm.com>
 <20200702030551.p4cevaahgfvpum4o@vireshk-i7>
 <20200702114123.GA28120@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702114123.GA28120@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-07-20, 12:41, Ionela Voinescu wrote:
> It was enabled until now, but it was partially broken. If you look over
> the driver you'll see arch_set_freq_scale() being called for both
> is_bL_switching_enabled() and for when it's not [1].

I missed that completely, it was indeed added here:

commit 518accf20629 ("cpufreq: arm_big_little: invoke frequency-invariance setter function")

and so this patch or a version of it is required here.

> If we just don't want frequency invariance for
> is_bL_switching_enabled(), I can just guard the setting of the flag
> suggested by Rafael at 1/8 by !CONFIG_BL_SWITCHER.
> 
> I'll proceed to do that and remove the fix at 4/8.

I think it would be better to do that and avoid any complicate code
unnecessarily here.

-- 
viresh
