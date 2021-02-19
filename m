Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F75731F43B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Feb 2021 04:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBSDiy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 22:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhBSDix (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 22:38:53 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0905EC061574;
        Thu, 18 Feb 2021 19:38:13 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 75so2694490pgf.13;
        Thu, 18 Feb 2021 19:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vW7QGTkoOi2XDxjLsMalRoDFkj6U8fLmlA2rW//tPic=;
        b=iNZLEKSK2EAXZ9oiD8ZvJX6H3vFs2uRjvJRz4yr3+BvIcQokun6mPSO/V8L9ioxUO2
         jA7u7RgRt/fCYxj04TNY7nLW+3kkzBp6M9wB6E25mBBumoAv9bIFmnoWnjZhDmYZQPwB
         x1ogLvfmdwHmwDP3591E9prOv/zXKV7wotgkMclYmIDXjzHVK3ntv1eoW9uLYHOY5IDz
         8ZRV5GLPC0Fy3jC9/S0sVC+R/GjBN0yXT8XcGbYsd4C2Qh7ckl1yUGrJk5eLE0uCod9o
         UBS/xM4O6zLL0ebKjAOcE5IUZXHiPw+sXzi86C44c7YiGuXRjd0dmgZ1x65g71fMO9Bc
         A3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vW7QGTkoOi2XDxjLsMalRoDFkj6U8fLmlA2rW//tPic=;
        b=GXW/f/4nNm9Nfpuwi3jzg9cB/v9rZ6NAaoVCCuS88QCPrrCmBhRevhz5uLCYFI0Bus
         uYuG5826XQJx9ru+Ok+uUttVsb2zzgXYc7FciuNW2FL28W9lnNJZ/IDJthb7+8rhQkdI
         aI+p0dmvFT/CgqdUC9kWA3MJ8RCMOi4DV5kutgoJXM9rb06IOR5dWMTkpQ9eap89bkqT
         yxAzvvLIticqCgQFl/OPsi6HpQdYI3dwd7bsiBYi3C00FHHjV+umnaxMlVOykWg62CbF
         mV7o3m5qF2uFwpIc1GtIr55H7NvQElFrbeqychF9e58a0onRr85KPBx+RNDmeoN2oqYH
         QdbQ==
X-Gm-Message-State: AOAM531N7ZOQtpn275HGtRpmQWIAAupz+WrhnZkLc2rRRGTUI7d60xc4
        He+oMhbiFOTYShYOmLol9UM=
X-Google-Smtp-Source: ABdhPJyShZ5ikxNDWbl4CJBezHrxoWlOLVPxABwg6LdDteEMS2sr/OT8tqrf1PzB/2Sb1TVop1nGFw==
X-Received: by 2002:aa7:9e90:0:b029:1dd:3cd6:9dde with SMTP id p16-20020aa79e900000b02901dd3cd69ddemr7268618pfq.57.1613705892622;
        Thu, 18 Feb 2021 19:38:12 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id e17sm6609267pjh.39.2021.02.18.19.38.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Feb 2021 19:38:12 -0800 (PST)
Date:   Fri, 19 Feb 2021 11:38:04 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] cpufreq: schedutil: Don't consider freq reduction to
 busy CPU if need_freq_update is set
Message-ID: <20210219113804.00004a7e.zbestahu@gmail.com>
In-Reply-To: <20210218102029.syj6vkltlbtoxsig@vireshk-i7>
References: <20210218082514.1437-1-zbestahu@gmail.com>
        <20210218102029.syj6vkltlbtoxsig@vireshk-i7>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 18 Feb 2021 15:50:29 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 18-02-21, 16:25, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > For busy CPU case, we do not need to avoid freq reduction if limits
> > change since commit 600f5badb78c ("cpufreq: schedutil: Don't skip
> > freq update when limits change").
> > 
> > Later, commit 23a881852f3e ("cpufreq: schedutil: Don't skip freq
> > update if need_freq_update is set") discarded the need_freq_update
> > check for special case of busy CPU because we won't abort a
> > frequency update anymore if need_freq_update is set.
> > 
> > That is nonlogical since we will not reduce the freq for busy CPU
> > if the computed next_f is really reduced when limits change.  
> 
> Schedutil governor will probably ask for a higher frequency than
> allowed, but cpufreq core will clamp the request between policy
> min/max before updating the frequency here.
> 
> We added the check in 600f5badb78c here earlier as there were chances
> that we will abort the operation without reaching to cpufreq core,
> which won't happen now.
> 

There's a possibility: we will use the previous freq to update if next_f
is reduced for busy CPU if need_freq_update is set in
sugov_update_next_freq(). This possibility would happen now? And this
update is what we want if it happens? This is related to another
possible patch ready to send.

Thank you.
