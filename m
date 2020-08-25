Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA53251394
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 09:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgHYHvC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 03:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729556AbgHYHvB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 03:51:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0369C061755
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 00:51:00 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kx11so362618pjb.5
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 00:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mCcFd+Ib+D6NrRVBcY3zB0ASaxSirffeaKtrRg05oPg=;
        b=cUVxWd5YAFtVgmxWog/tnuEbxeMvYWs96FCO8CWBQmTDbXPISCaykrwOFmDu95K18q
         4jtUPFXHnAMTpBcqoX320no4HwcQcdddT/Ats8ziLGPfaNiTUwTpD/xs3Mp7YCNBcg7E
         k7rOhB33YG18rRnvnU1nBkLLb+M3Pyf9Ft8Fn0vGnKtAtfTx8liLtZnZ/OCR0MlTN2Om
         8hohoQi+EzKFk6wCeYIK7QMoDPWDmmDl4tpp5SWTxxsNgTZAwvJnEA5ay/MkUDa8T8xA
         R1mExTRjWlQqt1GOuR4xb/Pdlw7titRqOEkOyCWLZ+a4uU+XDWIt0DGfVBM9vhUaJrA4
         /Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mCcFd+Ib+D6NrRVBcY3zB0ASaxSirffeaKtrRg05oPg=;
        b=kkuV56KISTGiU8SRryXHwsbnMqKpjtaee5mcyVja5jQeVSsD9makE4UFgU2JdGYZpk
         5Ng0yN17GQLCyhJx28TC9GEL0cfcx8zAgQCFCYfAnqZRR9mWhTx4dCmYjG3OCT1S8Zgp
         qxI55ZajAmOvPesBLUedv08y3E/0GpODOe5CkhTtvBUF3WNzeUcbARV8ZRc1e80DRrSw
         ZYJSx9X/pRQTX+tw/zeOKHwc2bHt0RcbeROf+A8g3uSdssIe2SaK2RKasYbzPBWuQXyG
         RzI2wZ3pyyz0nraCyFmzl0SsdQvF0SsUCETPc4zfeXPSIz30Aadhf11Zn7U/UfI9QiYx
         vmsg==
X-Gm-Message-State: AOAM5332GFSdfCPURSiVy25z6KCoFniFNpK9exSUexKVmGkKJAfKy+v7
        W9mEOpIZ5tsg2Sxz96nmcNf30Q==
X-Google-Smtp-Source: ABdhPJwNEYPlzbhGOubSsxb+BsVE+Afz7ijxDKwxJjN6y2MlrRDMZI/5cg5muv/8e4oEFOQiQy7j9A==
X-Received: by 2002:a17:90a:4214:: with SMTP id o20mr588108pjg.232.1598341860202;
        Tue, 25 Aug 2020 00:51:00 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id n72sm9788264pfd.93.2020.08.25.00.50.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 00:50:59 -0700 (PDT)
Date:   Tue, 25 Aug 2020 13:20:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] arch_topology, arm, arm64: define
 arch_scale_freq_invariant()
Message-ID: <20200825075057.rpeg6d6uziqzogsa@vireshk-i7>
References: <20200824210252.27486-1-ionela.voinescu@arm.com>
 <20200824210252.27486-6-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824210252.27486-6-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-08-20, 22:02, Ionela Voinescu wrote:
> From: Valentin Schneider <valentin.schneider@arm.com>
> 
> arch_scale_freq_invariant() is used by schedutil to determine whether
> the scheduler's load-tracking signals are frequency invariant. Its
> definition is overridable, though by default it is hardcoded to 'true'
> if arch_scale_freq_capacity() is defined ('false' otherwise).
> 
> This behaviour is not overridden on arm, arm64 and other users of the
> generic arch topology driver, which is somewhat precarious:
> arch_scale_freq_capacity() will always be defined, yet not all cpufreq
> drivers are guaranteed to drive the frequency invariance scale factor
> setting. In other words, the load-tracking signals may very well *not*
> be frequency invariant.
> 
> Now that cpufreq can be queried on whether the current driver is driving
> the Frequency Invariance (FI) scale setting, the current situation can
> be improved. This combines the query of whether cpufreq supports the
> setting of the frequency scale factor, with whether all online CPUs are
> counter-based FI enabled.
> 
> While cpufreq FI enablement applies at system level, for all CPUs,
> counter-based FI support could also be used for only a subset of CPUs to
> set the invariance scale factor. Therefore, if cpufreq-based FI support
> is present, we consider the system to be invariant. If missing, we
> require all online CPUs to be counter-based FI enabled in order for the
> full system to be considered invariant.
> 
> If the system ends up not being invariant, a new condition is needed in
> the counter initialization code that disables all scale factor setting
> based on counters.
> 
> Precedence of counters over cpufreq use is not important here. The
> invariant status is only given to the system if all CPUs have at least
> one method of setting the frequency scale factor.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/include/asm/topology.h   | 1 +
>  arch/arm64/include/asm/topology.h | 1 +
>  arch/arm64/kernel/topology.c      | 7 +++++++
>  drivers/base/arch_topology.c      | 6 ++++++
>  include/linux/arch_topology.h     | 2 ++
>  5 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index e0593cf095d0..9219e67befbe 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -9,6 +9,7 @@
>  
>  /* Replace task scheduler's default frequency-invariant accounting */
>  #define arch_scale_freq_capacity topology_get_freq_scale
> +#define arch_scale_freq_invariant topology_scale_freq_invariant

Maybe this macro should have been named arch_is_freq_invariant as all other ones
are actually getting us a scaled number and this one is just a flag. But yeah,
that is out of this series's scope, but maybe you should name
topology_scale_freq_invariant() to topology_is_freq_invariant() or something
else on those lines ? Anyway:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
