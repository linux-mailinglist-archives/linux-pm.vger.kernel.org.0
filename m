Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED4F216475
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 05:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgGGDJr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 23:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgGGDJq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 23:09:46 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA42EC061794
        for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2020 20:09:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b92so17886971pjc.4
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2020 20:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GSx1bT4SdYNNGySVBuLACJLZyLGWhFOan+2snuP4yyc=;
        b=n60iyk8TSMc3vAYz3nvLMJhQu6kwvoHa9l7VQCWMN6Nr2pRxIs5N2zDLFihtdtVvWe
         rk1u8fwxBNu1xANifex1PcWsON37+ZRZ+jWkGjtFzOEJy09/vcNfb0OOdNTD3DyNgJ04
         zVfuorp4LjoM749EGSFwzNA3mjaYsHrJ8EeNteIqSix3iFHg/jXToiC7WqkSydNDeU60
         npm5KTczVL/89WVMUNMiMwu1FufwFiNfJLgyZGadab+bbyqzprjOgsXd0nI3z15LWfLT
         4EQJXEGbVaKzF6KN/3+PBGV8yJiUyHEPAH6VAw86BIcGZzq8LDgqJzPPyZp6qCauR5TQ
         ZASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GSx1bT4SdYNNGySVBuLACJLZyLGWhFOan+2snuP4yyc=;
        b=Q3Tn7RcuQSUBi7mfwtY9kTLV+XqtDnChQLsvGjZKB40PW4XNbMbLnJW1sgi+hb+dqT
         QOEbSUI4Lmr+c7aMLuCI++HqFRG8cVibBaRePUpbbcitPL7si+BPFmwO0JlXORkCpXCH
         sIKsO/BH5cv5bgTlNCLjoa0CdPENNEyLS6AnJRK+sp6F/loiysAUa5LHr/pgTKpOiPtI
         8QNu8yqPuooElBnRnKT/xwt3aMeQr40mRwnow0npvLQJ2ykO4xwDcGBmlUqtp9Yev3Ba
         CXJldr/qRpOaOjn9JB7reDBpMntoK20dgs3FF/RNIg/HVr/wjevV8ZXC+kmDWXhxuNhA
         02JQ==
X-Gm-Message-State: AOAM533X/mFWAPUQwGxU1K3TCRgcSuCF5b7FgleYSWGoDwD5XTtQTTTL
        B/uLTMvjiFT6t2Fc68/mmtOrmA==
X-Google-Smtp-Source: ABdhPJzJpOUGpyIrAzhJn0zt0rqaPV38yzhlx+vfI25d5Ck4wSSsY3JbDbzRHf293h7qe0iwmb9I5g==
X-Received: by 2002:a17:90a:7483:: with SMTP id p3mr2158077pjk.64.1594091386159;
        Mon, 06 Jul 2020 20:09:46 -0700 (PDT)
Received: from localhost ([122.172.40.201])
        by smtp.gmail.com with ESMTPSA id w1sm20880674pfq.53.2020.07.06.20.09.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2020 20:09:45 -0700 (PDT)
Date:   Tue, 7 Jul 2020 08:39:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: Re: [PATCH -next] cpufreq: add stub for get_cpu_idle_time() to fix
 scsi/lpfc driver build
Message-ID: <20200707030943.xkocccy6qy2c3hrx@vireshk-i7>
References: <3a20bf20-247d-1242-dcd0-aef1bbc6e308@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a20bf20-247d-1242-dcd0-aef1bbc6e308@infradead.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-07-20, 09:44, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> To fix a build error in drivers/scsi/lpfc/lpfc_sli.c when
> CONFIG_CPU_FREQ is not set/enabled, add a stub function for
> get_cpu_idle_time() in <linux/cpufreq.h>.
> 
> ../drivers/scsi/lpfc/lpfc_sli.c: In function ‘lpfc_init_idle_stat_hb’:
> ../drivers/scsi/lpfc/lpfc_sli.c:7330:26: error: implicit declaration of function ‘get_cpu_idle_time’; did you mean ‘set_cpu_active’? [-Werror=implicit-function-declaration]

And why is lpfc_sli.c using a cpufreq (supposedly internal, i.e. for
cpufreq related parts) routine ? I think if you really need this, then
it should be moved to a better common place and let everyone use it.

I also see that drivers/macintosh/rack-meter.c has its own
implementation for this.

>    idle_stat->prev_idle = get_cpu_idle_time(i, &wall, 1);
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Dick Kennedy <dick.kennedy@broadcom.com>
> Cc: linux-scsi@vger.kernel.org
> ---
>  include/linux/cpufreq.h |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- linux-next-20200706.orig/include/linux/cpufreq.h
> +++ linux-next-20200706/include/linux/cpufreq.h
> @@ -237,6 +237,10 @@ static inline unsigned int cpufreq_get_h
>  {
>  	return 0;
>  }
> +static inline u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy)
> +{
> +	return 0;
> +}
>  static inline void disable_cpufreq(void) { }
>  #endif
>  

-- 
viresh
