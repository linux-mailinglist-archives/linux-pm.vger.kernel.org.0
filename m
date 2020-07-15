Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DE92202B6
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 05:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgGODHi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 23:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgGODHh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 23:07:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8743FC061755
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 20:07:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b9so1316538plx.6
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 20:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G2eRhXKmTEwTRQanSal/vSTAH9sP+NPQp5iAdhOZfgg=;
        b=zr5JWRbTGLJp8u1/MRQxIwWW/APlv9WqwsvnqgQGG8mSRtvxbJYHVHv43e4/bUsskg
         m9YsiPUcPQSqG9NYzOsapwL/AL0euAzYN+yFHAygI6Rbv2i0iy2VW3erNMQMx6b+o+bK
         CqQ5PR5wRHps18XmeeLDlHBdpaFq4Dbp/NA/AK/UaTjmxhqlqq7ncpED5RPZnusmlFdI
         ZvXa96YRX4SN4a6TVM9u+nBQtNNFuSk2CDQP32u/iJd+rBShWhobxpQlmQ2ErLkN3r24
         F7sZD2wX99im9YbzgEC1lDsjOXAzZS6uDX+t3YnDY9MDgpytN3Tyd90smDlsEZ4i9qRV
         w3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G2eRhXKmTEwTRQanSal/vSTAH9sP+NPQp5iAdhOZfgg=;
        b=D+H1aUie/t6Pf3O/+U6XiAMkMj4OeKV/m9HNsnQK0xFrY0gAlN+uJrI61Xzh79SKgK
         zLXIMZcKJN6FYvB3qXtIVNQlN2YAK58fw4HXZ58BVVtPdBQT6gnq6z22nYOGLLDKm/hY
         KZO2XcyCz95cpMiQ3ezy7CyrpyIPlcY2EiZbdE6puDKPoUxCzAc5woB0QGOFNrCSdwDY
         nVoKQD4osinXK9p6xoNPDz9aqQB1cXudIJ7MoPaMYBM91QVArdv58pdUGTOFlMyxOO6y
         FN/VNho5muOG99ky6DNUiSzZIUX1rqbVR0551+8STtr7jM318qhtWwncMOgIPilpDdRY
         PrXg==
X-Gm-Message-State: AOAM5320iXkr3KpOsSMBm/qc/4YPpizkdUkYJ6m+ulSv0ezwWKKnLAfr
        jo+LDlk6zeYaAAnCrtTWtJDuLw==
X-Google-Smtp-Source: ABdhPJy6G78yRMtYXULRufyLyim3gEDYCwAAZwkqYmBwjzlqARktEGcx+FHp/26xKL2ZJaDT5cfH6w==
X-Received: by 2002:a17:90a:db02:: with SMTP id g2mr7405784pjv.43.1594782456515;
        Tue, 14 Jul 2020 20:07:36 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id b15sm465430pga.54.2020.07.14.20.07.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 20:07:35 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:37:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 06/13] cpufreq: powernv-cpufreq: Functions only used in
 call-backs should be static
Message-ID: <20200715030734.3kdqmyr7rjlmrd3h@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-7-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200714145049.2496163-7-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-07-20, 15:50, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/cpufreq/powernv-cpufreq.c:669:6: warning: no previous prototype for ‘gpstate_timer_handler’ [-Wmissing-prototypes]
>  drivers/cpufreq/powernv-cpufreq.c:902:6: warning: no previous prototype for ‘powernv_cpufreq_work_fn’ [-Wmissing-prototypes]
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 8646eb197cd96..068cc53abe320 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -666,7 +666,7 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
>   * according quadratic equation. Queues a new timer if it is still not equal
>   * to local pstate
>   */
> -void gpstate_timer_handler(struct timer_list *t)
> +static void gpstate_timer_handler(struct timer_list *t)
>  {
>  	struct global_pstate_info *gpstates = from_timer(gpstates, t, timer);
>  	struct cpufreq_policy *policy = gpstates->policy;
> @@ -899,7 +899,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>  	.notifier_call = powernv_cpufreq_reboot_notifier,
>  };
>  
> -void powernv_cpufreq_work_fn(struct work_struct *work)
> +static void powernv_cpufreq_work_fn(struct work_struct *work)
>  {
>  	struct chip *chip = container_of(work, struct chip, throttle);
>  	struct cpufreq_policy *policy;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
