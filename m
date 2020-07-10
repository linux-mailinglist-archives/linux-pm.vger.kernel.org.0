Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E93021B924
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 17:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgGJPMm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 11:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgGJPMg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 11:12:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0A3C08C5CE;
        Fri, 10 Jul 2020 08:12:36 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so6272111wmh.2;
        Fri, 10 Jul 2020 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xEchJDumlr5zSz/EMCvc3mIu0atKAoLY2c6rM2/WmwA=;
        b=CD0901AbfEpZzWSg2DqIk6HF9pzekPCM3fMqDKwLVlTGXa8tpdfENHUgfLTW/8VOar
         6dHmIPwFe6ipQKhW8yCG6ZCNAF+UnO9UGmpzc/SL8n3kkDapEP1pP9eZzMkEbgpwzaDI
         iXjnLCF86qHvuqsWaDZODNhucxvPN+wC8L6Obr3cx74b+vR5ZUeNHJep3dlJn0+ioZZs
         uTCvYTKYmZUJWDm/sbfmpJ0LQRdK6ucsPgPorbG2bK1stvKpbQy/DFha0Yk/rs8iHW4V
         QkF9iDdaXDMoeWVfQNGBH07ypqKofE2j4xEg0IOjktV2AKqSdAmHXKsQhQL56MDouMlz
         UKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xEchJDumlr5zSz/EMCvc3mIu0atKAoLY2c6rM2/WmwA=;
        b=I03o1AiWe1j8rgwOXriYtNoQqygS46EPNchlDPu8A1I6PBJLkJ9l/AxMsXNE817D2Z
         xv8xBCzPrpOzaIAGLl5EoofEDcCg1tFYP288ghvMcxc0kh2LIbXZNE+z8ocVgM5hcqIb
         7DJV8hR2khyNFRtC7vgm4UDVA1rUpO8zSHUV8oHFDuClc6YM1RDDd//+iGLJrjIapkeV
         jPF2408EcbEZf5pdLohFe58ltI/v6KQ7D9qaRVzKDMGVXLvbhROC0Z3PiQo1QfTVGQHg
         uImC1ve8n2H/Olwc5WHb2GDWOLBWhn4rwyBmo1azDkM5vOM9Kjmox1y9sFswwnj4JJd3
         89Dg==
X-Gm-Message-State: AOAM533epHwARACaAyLWt84POZAMm1C59C880uoHhZeqAnLwsVQRH6we
        44SeF0fY38uVf5wjg/oxxw2CWka/
X-Google-Smtp-Source: ABdhPJzzvpOnyFWAZ9LjUtwsQhOc0TLo40Xs9qE+VazD4kcKa3lIteNJVkDHzkZR5ZymXroYPSJ/ow==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr5504254wmb.53.1594393954943;
        Fri, 10 Jul 2020 08:12:34 -0700 (PDT)
Received: from macmini.local (181.4.199.77.rev.sfr.net. [77.199.4.181])
        by smtp.gmail.com with ESMTPSA id v24sm13229925wrd.92.2020.07.10.08.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 08:12:34 -0700 (PDT)
Date:   Fri, 10 Jul 2020 17:12:33 +0200
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, k.konieczny@samsung.com,
        krzk@kernel.org, kgene@kernel.org, s.nawrocki@samsung.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 0/2] PM / devfreq: Add delayed timer for polling
Message-ID: <20200710151233.ci5c4rgwb64eswy7@macmini.local>
References: <CGME20200703061508epcas1p171aa3c0ab832b77e5837d8bd1e563742@epcas1p1.samsung.com>
 <20200703062622.11773-1-cw00.choi@samsung.com>
 <20200703123346.6fy6i33ks6nox46a@macmini.local>
 <a3339c58-6350-9298-6053-9dc021170048@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3339c58-6350-9298-6053-9dc021170048@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 2020-07-08-15-25-03, Lukasz Luba wrote:
> Hi Willy,
> 
> On 7/3/20 1:33 PM, Willy Wolff wrote:
> > Hi Chanwoo,
> > 
> > I think it doesn't help on the benchmark I suggested that is doing only memory
> > accesses. With both timer, I have the same timing.
> > 
> > To test the benchmark with these new patches about timer:
> > 
> > git clone https://github.com/wwilly/benchmark.git \
> >    && cd benchmark \
> >    && source env.sh \
> >    && ./bench_build.sh \
> >    && bash source/scripts/test_dvfs_mem_patched.sh
> > 
> > The benchmark is set by default to run for 1s, but you can increase this by
> > tweaking the script as:
> > 
> > taskset 8 ./bench_install/bin/microbe_cache 33554431 0 9722222 <TIME in sec> ${little_freq}
> > 
> > 
> > Also, as I reported the issue, would it be possible to add a
> > Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com> ?
> > Many thanks in advance.
> 
> Thank you for your good work and the benchmark. I hope you will continue
> to use it and report some issues. I am going to send a follow up patches
> for the DMC and I will add your 'Reported-by'. In the tests I can see
> the improvements, but it's worth to consult with you if I understand
> the new results correctly.
> 

Thanks for that. I will follow on the other patch thread discussion.

> I think there is still some area for improvements in the devfreq and you
> could find the interesting bits to contribute.

In fact, this benchmark is motivated about part of my PhD research that has just
been accepted at LCTES2020: "Performance Optimization on big.LITTLE Architectures:
A Memory-latency Aware Approach" at https://dl.acm.org/doi/10.1145/3372799.3394370

Basically, it's about snooping latency with "bad" CPU DVFS choice on big.LITTLE
systems or more generally SMP/AMP architecture. I'm cleaning up my code and will
propose patches as an RFC later. It introduces a new CPU DVFS governor to limit
snooping latency.

Cheers,
Willy

> 
> Regards,
> Lukasz
> 
> > 
> > 
> > Best Regards,
> > Willy
> > 
