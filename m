Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4616950D89E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Apr 2022 07:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbiDYFJO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Apr 2022 01:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiDYFJM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2022 01:09:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8DE8BF72
        for <linux-pm@vger.kernel.org>; Sun, 24 Apr 2022 22:06:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n8so24524331plh.1
        for <linux-pm@vger.kernel.org>; Sun, 24 Apr 2022 22:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gNvaAoMPbdbdyvNqhaTtDMGsJUQFjlXi46W57sai814=;
        b=NKY5xGBqWdv1qptYi67G9s1QIJ57Ku3frhJzM74pZxsLSWQd3yGijZwqvpsfapeTSv
         ciClB3KxoTrc1xQ+TglZAorvsC5xzJmyKKSXlKKHCDdqdirRKannkSUmPr9zZywT+Bz4
         ToUJxiflwolHfGYbJiGmq6FDTq2Xxcb7eDK1qR0daTZVhI2aCIztxoAJHyoEtr158TQO
         +WU1o2FQ3VPVx1ngQsmc0FgbIEYGWk4Hfv9u109YdchiW4PGtaPXUDEXSLjo3cbT+cp6
         uJrsyjjetqBcXf1KxiqOadLPtU6M+ubji3ZOGb9QMjnJs45xc06rZKn5bhHuT1sW7y4s
         kL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gNvaAoMPbdbdyvNqhaTtDMGsJUQFjlXi46W57sai814=;
        b=n/xO2WYwd8Lt4jBi4L+BJ1AMwVQhXarTRXrCGuCoxbmW6vB7aBS4EgnTAVgWjJ/jLa
         yfiRSaybhYlIjQGYN+H2hGpZo87joxlTVAqXqz2EfXzs1EA+yX52eK+i1sYgfFUl5BrO
         aACkmbpk7f+UuW8ULEBq+IirtdkGQbkpOP8EjGQlWgrO8y2FI2Dht+7R1LLEgtWiEpQK
         ebSFmMmheYoiBjjDdwOjmIPvPh/qqTnI5O4hw6tEB8FPm9aSR1P+6JmdTmn0aJspm7/t
         97TYbtCYtw5bui4HJHDjjP1OswjtzQDTVJNqulhLrAGR6WVb2kTfl/s4cp7/ch3JUw9D
         gUCA==
X-Gm-Message-State: AOAM531LeBs+7TM8gnLg8aAL65E//bTFyLJAbU4SHy9Ng0vrM8ToO7lc
        bCoh4dN3J+8CKbEGVv5ESe+nAQ==
X-Google-Smtp-Source: ABdhPJyk6HWS+uLuAV1Fn7IQFtK1dt2aoEgyN3lkCaQS7r5QtxgXFkshOgNrfrKAaTBDliwuWIE75g==
X-Received: by 2002:a17:902:8698:b0:158:99d4:6256 with SMTP id g24-20020a170902869800b0015899d46256mr16749805plo.104.1650863167283;
        Sun, 24 Apr 2022 22:06:07 -0700 (PDT)
Received: from localhost ([122.171.250.232])
        by smtp.gmail.com with ESMTPSA id l2-20020a056a0016c200b004f7e3181a41sm10159399pfc.98.2022.04.24.22.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 22:06:06 -0700 (PDT)
Date:   Mon, 25 Apr 2022 10:36:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Xiaobing Luo <luoxiaobing0926@gmail.com>, tiny.windzz@gmail.com,
        rafael@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        mripard@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq:fix memory leak in sun50i_cpufreq_nvmem_probe
Message-ID: <20220425050604.fv4f3s74jmvx6rlp@vireshk-i7>
References: <20220423151204.2102314-1-luoxiaobing0926@gmail.com>
 <4ee2421f-79a8-7f4d-f7ef-33f0ccf49337@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ee2421f-79a8-7f4d-f7ef-33f0ccf49337@sholland.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-04-22, 21:46, Samuel Holland wrote:
> On 4/23/22 10:12 AM, Xiaobing Luo wrote:
> > --------------------------------------------
> > unreferenced object 0xffff000010742a00 (size 128):
> >   comm "swapper/0", pid 1, jiffies 4294902015 (age 1187.652s)
> >   hex dump (first 32 bytes):
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<00000000b4dfebaa>] __kmalloc+0x338/0x474
> >     [<00000000d6e716db>] sun50i_cpufreq_nvmem_probe+0xc4/0x36c
> >     [<000000007d6082a0>] platform_probe+0x98/0x11c
> >     [<00000000c990f549>] really_probe+0x234/0x5a0
> >     [<000000002d9fecc6>] __driver_probe_device+0x194/0x224
> >     [<00000000cf0b94fa>] driver_probe_device+0x64/0x13c
> >     [<00000000f238e4cf>] __device_attach_driver+0xf8/0x180
> >     [<000000006720e418>] bus_for_each_drv+0xf8/0x160
> >     [<00000000df4f14f6>] __device_attach+0x174/0x29c
> >     [<00000000782002fb>] device_initial_probe+0x20/0x30
> >     [<00000000c2681b06>] bus_probe_device+0xfc/0x110
> >     [<00000000964cf3bd>] device_add+0x5f0/0xcd0
> >     [<000000004b9264e3>] platform_device_add+0x198/0x390
> >     [<00000000fa82a9d0>] platform_device_register_full+0x178/0x210
> >     [<000000009a5daf13>] sun50i_cpufreq_init+0xf8/0x168
> >     [<000000000377cc7c>] do_one_initcall+0xe4/0x570
> > --------------------------------------------
> > 
> > if sun50i_cpufreq_get_efuse failed, then opp_tables leak.
> > Fixes: f328584f7bff ("cpufreq: Add sun50i nvmem based CPU scaling driver")
> > 
> > Signed-off-by: Xiaobing Luo <luoxiaobing0926@gmail.com>
> 
> Two minor style issues: there should be a space after "cpufreq:" in the commit
> subject. And the blank line should come before the "Fixes:" tag, not after.
> Otherwise:
> 
> Reviewed-by: Samuel Holland <samuel@sholland.org>

Applied, thanks.

-- 
viresh
