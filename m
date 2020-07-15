Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77FC22099F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 12:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbgGOKNm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 06:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731049AbgGOKNm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 06:13:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3D7C08C5C1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 03:13:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j4so1860033wrp.10
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Hn1Hbjff+9Afv2Xeip4oNSq9d24avIQDuzU6faxXekA=;
        b=qlR93dSPHSbqYU0Gl7DzP6gPZu10L3MypqxPjXRCd3zNlT8TlEC6m6Emrl5IBiFU1J
         DvS9LgkqWmXclVuVF7eg4Y3VJ/BFPwhIter84emkwYWrXg6eJKmAdTWpVOL02taH6M/s
         ws/vvSueQ8jw/viS+72dcaQPaxdYvi1GENdrZOfWMvPnL/0MCDx4q/mMSqFOp8QQHArp
         aZ2U5T4imohTHyYFz2Mc4/+JJEMmkH+o4DpX2yqPmu/O4oVsIWtL7T48dk1uGKNwpRgE
         CE5pZsKIyFkaJok/rludtGQVXlsS062uymdMtf9BELZ5hXh15NssRLqmPXbWGpr0sbBk
         L1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hn1Hbjff+9Afv2Xeip4oNSq9d24avIQDuzU6faxXekA=;
        b=MgTab4Q9SJSKIR4bGUHRNgLsHRxmOAouvfFkQauVQvIBYxcgWCbILIpRVtyHvfRLv+
         Z1Qgs1uCqUJ0zeKDfTQVWrMkRn5veAgPeOLfF2+f3uHcj3XLLsA8oE2w8MD9hq1sk8yk
         tHXx4PTQpaEOpoIIkaHL05mB0HRvM6yR0Mk4yBrz83K9iyLv8yuf6EzrPw8Mzp9Q11b7
         Bv+ZbNi90uP1Z+m3yRShdCAmz1Kb1ZoJcTJC+8zlzJE5vQuOHlWbI/Rd4tl0YrY7ClaR
         5S3/dOjCBwx8+hBAEYwcDJVfIgo2NLIwMuxKQSu16qHZ/tbzL8CxWxtucVgpICtVcPFF
         wzlg==
X-Gm-Message-State: AOAM531tG/mMfWk2H2K273nbsUfrRXITZCwGQtMYAh3j1kzjZFJWB4d1
        pHycUkHQhGxQRd+NEvbthtr6HQ==
X-Google-Smtp-Source: ABdhPJz1sof9nbSox7QA78MbtsQxOffGJyaBrE6z+a2qbZEL+1W2WAWsKdYybzfKFDfNwDKsEZNt6w==
X-Received: by 2002:a5d:60c7:: with SMTP id x7mr9987696wrt.138.1594808020835;
        Wed, 15 Jul 2020 03:13:40 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id 68sm2712443wmz.40.2020.07.15.03.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 03:13:40 -0700 (PDT)
Date:   Wed, 15 Jul 2020 11:13:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 06/13] cpufreq: powernv-cpufreq: Functions only used
 in call-backs should be static
Message-ID: <20200715101338.GA3165313@dell>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
 <20200715082634.3024816-7-lee.jones@linaro.org>
 <20200715094504.val6rb7wibysh7dn@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715094504.val6rb7wibysh7dn@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jul 2020, Viresh Kumar wrote:

> On 15-07-20, 09:26, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/cpufreq/powernv-cpufreq.c:669:6: warning: no previous prototype for ‘gpstate_timer_handler’ [-Wmissing-prototypes]
> >  drivers/cpufreq/powernv-cpufreq.c:902:6: warning: no previous prototype for ‘powernv_cpufreq_work_fn’ [-Wmissing-prototypes]
> > 
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/powernv-cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> > index 8646eb197cd96..068cc53abe320 100644
> > --- a/drivers/cpufreq/powernv-cpufreq.c
> > +++ b/drivers/cpufreq/powernv-cpufreq.c
> > @@ -666,7 +666,7 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
> >   * according quadratic equation. Queues a new timer if it is still not equal
> >   * to local pstate
> >   */
> > -void gpstate_timer_handler(struct timer_list *t)
> > +static void gpstate_timer_handler(struct timer_list *t)
> >  {
> >  	struct global_pstate_info *gpstates = from_timer(gpstates, t, timer);
> >  	struct cpufreq_policy *policy = gpstates->policy;
> > @@ -899,7 +899,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
> >  	.notifier_call = powernv_cpufreq_reboot_notifier,
> >  };
> >  
> > -void powernv_cpufreq_work_fn(struct work_struct *work)
> > +static void powernv_cpufreq_work_fn(struct work_struct *work)
> >  {
> >  	struct chip *chip = container_of(work, struct chip, throttle);
> >  	struct cpufreq_policy *policy;
> 
> Don't you want to drop this patch now ? As you already reviewed the
> other one on the list ?

Yes, please drop/ignore.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
