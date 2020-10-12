Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7E528B593
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 15:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgJLNKO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 09:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388696AbgJLNKK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 09:10:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89624C0613D0
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 06:10:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n18so19132515wrs.5
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HDv79H0T0YMmpA6Cg6LXdiKcuj2DrLE+0Njp0Y0u8KM=;
        b=XGY9IxnK+Djfx5Zb8HC+CkSfHoX6LZfeU7EHgj0M7jE27eNiu/NTCS/8O2N4CTMsIr
         5HqQk78SAe0OaeEucGW1pj0pUs0eJK0sgVXRExrJJ1zO7w1xG78/XBvpsOoi0BhY+Z1w
         jF7hYRNPIHRUxxFrSyeAToz+/9RQ+zjKRDJgcjSHa4Uap2u0tdqxNVZf7hqSh24Xi9sT
         f+HixQE9Y0oDRYUii64YVp8p/vFZjnBTnvXhhjUpoK82Up70SzvU6+iF4rws5ul5hPfy
         YRi+o3/CaD4VTZS0wfrcVj/HR330hT2wnk/fWjBuNSrCrx78+tJHm2Pf+4dKLNOcsWEp
         9FQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HDv79H0T0YMmpA6Cg6LXdiKcuj2DrLE+0Njp0Y0u8KM=;
        b=s9joCbanxzwvQcCMRtWqEZfgWoCTNHXr+QbQC9skjSqjTEwhjqpw0i/v5nhqNKdVZf
         Sd2RzN5raMPFYDyNERSATASbHzZ4895BSQNPfGf2Y7EWT66SHnK9eLHPkFlYVpXlpTD3
         E/OhjFf3hxL5x5HyVfL32eNz2aryQc3SwmT8ouB8xgBiAiAvi/Zl7Daf5HM+CJTMmDDW
         NaPyyyH4PkOs8aRLOLwkawa3iTPcmqnBUKsUXPJtGzzigxkJ3DFxp3/OM20QNsXKurQN
         hkH9agZeiKesUH0ucJBo5oaKXQGZJW++hpO0iy6ZhrrbVBlqg1bkEx0BCS9i1xlZai/C
         Yl9g==
X-Gm-Message-State: AOAM533kyOk65x3MjUdrG+9BuWupjDCKuDff+1LzqfaT2h9ebU38/ucf
        FhyrMFNF+38OXOorSN8I08eGAg==
X-Google-Smtp-Source: ABdhPJysslHpkfKa/rNifK/bUIFGSLBzE605Lmx/ZaVPZeJstlvv21gBu3jK5rmlIjoNhyVsWXs6gg==
X-Received: by 2002:adf:97dd:: with SMTP id t29mr21818564wrb.322.1602508208105;
        Mon, 12 Oct 2020 06:10:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id u20sm15595626wmm.29.2020.10.12.06.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:10:07 -0700 (PDT)
Date:   Mon, 12 Oct 2020 14:10:04 +0100
From:   Quentin Perret <qperret@google.com>
To:     zhuguangqing83@gmail.com
Cc:     lukasz.luba@arm.com, quentin.perret@arm.com, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhuguangqing <zhuguangqing@xiaomi.com>
Subject: Re: [PATCH] PM / EM: consult something about cpumask in
 em_dev_register_perf_domain
Message-ID: <20201012131004.GB3366383@google.com>
References: <20201012124136.4147-1-zhuguangqing83@gmail.com>
 <20201012130501.GA3366383@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012130501.GA3366383@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday 12 Oct 2020 at 14:05:01 (+0100), Quentin Perret wrote:
> > 3, The third question is, how can we ensure cpu_dev as follows is not
> > NULL? If we can't ensure that, maybe we should add a check before using
> > it.
> > /kernel/power/energy_model.c
> > 174) static int em_create_pd(struct device *dev, int nr_states,
> > 175)                    struct em_data_callback *cb, cpumask_t *cpus)
> > 176) {
> > 199)    if (_is_cpu_device(dev))
> > 200)            for_each_cpu(cpu, cpus) {
> > 201)                    cpu_dev = get_cpu_device(cpu);
> > 202)                    cpu_dev->em_pd = pd;
> > 203)            }
> 
> And that should not be necessary as we check for the !dev case at the
> top of em_dev_register_perf_domain(). Or were you thinking about
> something else?

Oh I think I read that one wrong, but the conclusion should be the same,
at least on Arm64 -- all _possible_ CPUs should be registered early
enough for that not to be an issue.

Did you observe anything wrong there for your use-case?

Thanks,
Quentin
