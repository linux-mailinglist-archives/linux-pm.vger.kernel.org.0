Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573BD6DD30A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Apr 2023 08:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjDKGlI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Apr 2023 02:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjDKGlC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2023 02:41:02 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51033359F
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 23:40:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2465e4f1954so588746a91.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 23:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681195255; x=1683787255;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P9E3QUvAQUl3o+y94u92fiPsX7FeUqAvp4hYEOQvbNI=;
        b=bwSwwNrwlSHWxctuiILVq87IWdaCXi4nEQhZKXaFKHGDV/tZDxpAQPzI+p6nuAZ9oG
         n1bGcDq6OmaIFf4BQ0LvKfD3Sci1+HNPwXeZR0+OBAbB4KcqUumNf/FomVxTcM5mTv+X
         U+gGK4q/s7oHdLvaIguwGGZNi6Vu4uBzRO/7q8ZxfUuf4FlS/D26aoriZzdzM0kLOMLq
         hIpZgKcLXDwwgf9rqcRDE5C68WH45Nzr5xchIIECs8/4QL8284IRb9FR0zfEF+yGY473
         DhZNzPwfq6EM5wGOPi/L7GvR6Q36+NW1KHS4uhqNAkD6KpzaPr5t354cEGzZzKLmCtns
         JxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681195255; x=1683787255;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9E3QUvAQUl3o+y94u92fiPsX7FeUqAvp4hYEOQvbNI=;
        b=Z3rfT1kycYDWop5/CjBlrWdbdwwX7HDgLXR1xOmPlvvmDxpvzAD3Obzqrr/6yigXmg
         Rt2O39cipKD//KgnvuAdZF6YGd4QeE41h+SorOGP6vRAY9hBWn3Llnj8EjUcLYAYbI1Y
         QI8vBx/RIo2tcO1sD++676EglHg/KBxB9Eo5Bzf4NQ065u+j2QqRIKeDouKvZEfBjRFk
         RDl0xir8UQrQZfNY6dvRD/PFHo7LrCSKhnMTtpYoAU0Mw75+ut/yn40srbZYGBf3BEtS
         txeTXpz4R1OHD4q1IXbAlw9rxS7zuCuNOfs3UNa1iuigdljJwMGNbcgn7Bi4drxO1DSj
         9lkw==
X-Gm-Message-State: AAQBX9dFAAODKH6aZG6atP86oObTH1mYORXTs8iXe2inmb+MkBbEjm1D
        TjpJe+1JcG+Sw+/Ftia6fE0I1A==
X-Google-Smtp-Source: AKy350bAlb+cDbia8QKfCMxPUZQ30JZAbWebYQ1BSofjHaVQ6jNlpGiW52J3dB+BLo3Ik/HcvQl1ug==
X-Received: by 2002:a62:3802:0:b0:633:5c46:5a68 with SMTP id f2-20020a623802000000b006335c465a68mr9465898pfa.10.1681195254722;
        Mon, 10 Apr 2023 23:40:54 -0700 (PDT)
Received: from localhost ([122.172.85.8])
        by smtp.gmail.com with ESMTPSA id d21-20020aa78155000000b0062e0010c6c1sm8836856pfn.164.2023.04.10.23.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 23:40:53 -0700 (PDT)
Date:   Tue, 11 Apr 2023 12:10:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v2] cpufreq: sparc: Fix exception handling in two functions
Message-ID: <20230411064051.qyioheeoectj2lv3@vireshk-i7>
References: <b3cce5b3-2e68-180c-c293-74d4d9d4032c@web.de>
 <2d125f3e-4de6-cfb4-2d21-6e1ec04bc412@web.de>
 <20230403033529.x6n3ihhkypwizq3b@vireshk-i7>
 <39342542-9353-6a7b-0aa9-f9c294b158cb@web.de>
 <20230403230432.xeubpa3cc2gt4mw3@vireshk-i7>
 <68b1988b-987f-fa2b-111e-b1b42f9767ab@web.de>
 <20230409235511.7xxqdxsqtflrhifk@vireshk-i7>
 <f9f40c8a-a392-27e3-b19c-c8985a163159@web.de>
 <20230411033048.zwsijlyiksjcmgcc@vireshk-i7>
 <e53bfa4f-c4b0-ee80-a64c-be8e9af76230@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e53bfa4f-c4b0-ee80-a64c-be8e9af76230@web.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-04-23, 08:15, Markus Elfring wrote:
> >> The setting of the variables “cpufreq_us…_driver” influences the need
> >> to reset them to null pointers for the desired exception handling,
> >> doesn't it?
> >
> > This is what all should be done for these drivers I guess. There is no
> > points doing the dance of {de}allocating resources unnecessarily.
> 
> Are you going to integrate your source code adjustment according to
> reduced dynamic memory allocation?

You can prepare and send a patch for this if you want, else I will do
it.

-- 
viresh
