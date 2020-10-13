Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E3328D122
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 17:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbgJMPUt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 11:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731106AbgJMPUs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 11:20:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBDEC0613D2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 08:20:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b127so47897wmb.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 08:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9em53n7IKEDSCEYZtHmPvDvhhD75e1+tqMf+AhUYcN4=;
        b=ZDCLkG1BSn4yzX28Cam+G3NZDw5dwK3VT+N15YmgrZRxnTZz5mmxDJB3t6EfNUCMl/
         yNGO9IODIqe/eLuAnfoWNqKtwCZl8rNrECPyV2pTlupb/h85FtJXxbw3xfM94sx3KhG1
         qEPQMjSJtYQdBoDUTK2FzVJcB0wCk8AwMuBHCcsjj7eK8k9D4JSgVc4dhwMze67FeZQR
         h7JQC6aDdElSxxKMQ9L3mfMHw+o91FAERtM3VHKddlOz7ZMtb/KwWHtboYrpUbzVwVUj
         LN6h8JXHnArz0bMnef6KX1XdLKOmnh7o+rEJN3W2QJTQgEEi/UKPZvtlT6YCuR7MFdJb
         FP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9em53n7IKEDSCEYZtHmPvDvhhD75e1+tqMf+AhUYcN4=;
        b=ogrD+CquiHnJfkgEMF2DcHtPOKrkw+gY2+Bzmg18C2vwYa4tYirWJmVMM1wDR07rXU
         zr5ltSaBBP8zRqbRLRE2Pl/xTnlHyhbDZmdnrFLLbi4uRCdmWh5r2Ic2N9cLiomjee7x
         j9bz4JlYH5yp9IbyJOAa3EzbY6GuQsi0PXLhWSpopyRHRiSyKwZOj1fajDM+eG7B8A5t
         b2uSrM4XzXbrRiRZdmK0Zh6nDfv2XGv9+C9OirSaY3YfvOj/m585B2oy1eNqYS5lEo0q
         3piXM6s/0I52SaBRRbAJj6GcSMOEelCJyUNwkmt9axFVf7scwUwuWaOBrBSakKGi4hQD
         zD6Q==
X-Gm-Message-State: AOAM532sKp2xxwzlDqcRaq98i3AClARjOZ6uDQaZUchlcgcgskituaYZ
        U1wpQBjSIzXwXJzlK1pmsOHgvw==
X-Google-Smtp-Source: ABdhPJyFnJ/cKfn28zIhHhYwEBDs6pJv0b6Na5kylov1gHy9GGl7+H6NbRMIp3c0Rb4SEoNUMB8oAw==
X-Received: by 2002:a1c:495:: with SMTP id 143mr337585wme.63.1602602446108;
        Tue, 13 Oct 2020 08:20:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id i10sm11441211wrq.27.2020.10.13.08.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 08:20:45 -0700 (PDT)
Date:   Tue, 13 Oct 2020 16:20:42 +0100
From:   Quentin Perret <qperret@google.com>
To:     "zhuguangqing83" <zhuguangqing83@gmail.com>
Cc:     <lukasz.luba@arm.com>, <rjw@rjwysocki.net>, <pavel@ucw.cz>,
        <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'zhuguangqing'" <zhuguangqing@xiaomi.com>
Subject: Re: [PATCH] PM / EM: consult something about cpumask in
 em_dev_register_perf_domain
Message-ID: <20201013152042.GA183119@google.com>
References: <098a01d6a112$9cd7f410$d687dc30$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <098a01d6a112$9cd7f410$d687dc30$@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 13 Oct 2020 at 11:40:31 (+0800), zhuguangqing83 wrote:
> I did not observe anything wrong for my use-case. But I think it's possible
> in
> theory that cpu_dev maybe NULL. I observe that in the function
> scmi_cpufreq_init(), before calling em_dev_register_perf_domain(),
> 'policy->cpus' can be ensure that all the cpu_dev in CPU mask are not NULL.
> But maybe we can not ensure all the clients do the check.  This could happen
> if the arch did not set up cpu_dev since this CPU is not in cpu_present mask
> and the driver did not send a correct CPU mask during registration.

Admittedly this has only been tested on Arm64 where I think we can
safely assume that all possible CPUs have been registered at once -- see
topology_init().

And for allowing to register CPUs late in a perf domain, I'm not opposed
to it in principle but that has deep implications as the existing EM
users (e.g. EAS) currently hard rely on it being static after
registration. If you have a real need for it and a patch that adds the
feature and fixes all the users I'll be happy to look at it :)

Thanks,
Quentin
