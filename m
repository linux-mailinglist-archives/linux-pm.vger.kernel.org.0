Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C1F56D704
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jul 2022 09:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiGKHra (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jul 2022 03:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiGKHr3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jul 2022 03:47:29 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9D7A1B8
        for <linux-pm@vger.kernel.org>; Mon, 11 Jul 2022 00:47:27 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f11so3196297pgj.7
        for <linux-pm@vger.kernel.org>; Mon, 11 Jul 2022 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gVWdkX/m1Qk9iruntOsK3yu1LrQltAXUFPSy21C5XNA=;
        b=VERXYZ+T9H58wkavpjHTanqt00qi09rylxLZqPmDCjG9ATm6O66Ah6LdvdOPj4RIpU
         F12Y48ETmxqLzTmtbHJ8ktQ5cjUEGYFSp9Fh4Eq8tJTlAaA4RepwoOeccHkv8FahuJcD
         2yNGmXbEXKw/k3awYd8j04XSnHttd6Vw75cRSIUT659bmlxPnd7fOhig1FXbFrzeR13q
         /7Iv1Z/I/QSQG0MzN7Hofj3haTQ50R8IOvuXAg86VHH3y4mBVWCJdFVLDK+0PdsKUAQA
         snxlexk7c/buV7QDhFRBSwU4XktxxoPzPWAADR2bIfbqltFmkuWaDpVx5e5+w2/GF101
         3KpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gVWdkX/m1Qk9iruntOsK3yu1LrQltAXUFPSy21C5XNA=;
        b=IBD1bbot7+D8ho5Y1djexfEj8ahlgfIe7uaJCMQRS0h3urjHaL5uAZqAhFVwiiBgc7
         ZxQmKTT9F7CdgT/cICM0MBGkJbYXxrNTvZRQSXUdT2XvTtnxRh4wWVvVP0q9xlyHsppg
         brm1XKY4436YgQ54Fy9L3nrRcQoNI5DuAP8pwY/NYLa535GsllaHJGFCJVrbXYhlW6P8
         m8euWa36D2fj7x8LZbkADXUqmUaTUNiYez25nDETa8sUXCysZBwz6HSjU88vJqZ1ENkJ
         6+fI5mF9fdRSmE2LxlsCnQtT6evtHJOCozII1BM3PEyaPhvIwdvvpJGb/NUIAL5mTIyQ
         8w5w==
X-Gm-Message-State: AJIora8BjIzuh0gU/DpHdGckIiQCugEijwxLDLvd52AwB2B4CzIFUTlZ
        tlWQmapTatunz6/dE7iXNq+fCw==
X-Google-Smtp-Source: AGRyM1vH9arVcJAj5xz0lDtflVHw1uEgRKfdipmUFQRQlurlJJUI0mfxMQcQ6l6SqEFgsottlDcBuQ==
X-Received: by 2002:a62:79d7:0:b0:52a:b557:2796 with SMTP id u206-20020a6279d7000000b0052ab5572796mr14342440pfc.34.1657525647022;
        Mon, 11 Jul 2022 00:47:27 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id fh17-20020a17090b035100b001ec932d7592sm4095335pjb.9.2022.07.11.00.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 00:47:26 -0700 (PDT)
Date:   Mon, 11 Jul 2022 13:17:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Message-ID: <20220711074724.tbwefl42fpf2aq5a@vireshk-i7>
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
 <CAB8ipk8w1=cMJV2_ZjWuX6T9RH9VXCMdUaZhLEkCziarhpy-5w@mail.gmail.com>
 <9ade9d43-3ed1-1239-f26e-73145856275a@arm.com>
 <CAB8ipk_Y5vaUMnRQVJsbHUue_J00qqy0E1ifu3W_hFSspL1r1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8ipk_Y5vaUMnRQVJsbHUue_J00qqy0E1ifu3W_hFSspL1r1w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-07-22, 15:43, Xuewen Yan wrote:
> This deadlock occurs when we run the monkey test on an Android phone,
> at the same time, randomly put online or offline a cpu core.
> Indeed the thread-A which get the cgroup_threadgroup_rwsem and waiting
> for the cpu_hotplug_lock is the thread whose name is "OomAdjuster" in
> android.

It would be better to reproduce this on mainline kernel, no android,
and tell us the steps. We don't want to chase an Android only issue,
just in case.

Thanks.

-- 
viresh
