Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147703B1399
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 08:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhFWGEB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 02:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhFWGEA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 02:04:00 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97BCC061574
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 23:01:42 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o21so593941pll.6
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 23:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0eD2NKzR92krNnSCAEqt3EN7AElb1rlw5uXmc6X1m0I=;
        b=m8KQZw6Ur1ZiTHKJ/vEdrdcpgTcd39VYmDcf9nHZVdCmN5oh5mXieYh2xJMKVyzF8B
         6RmHjE+UgMakMuNUE4/0BDh9kz3JMP0am2MFxfi3dDK2MOftOig/MyT31BM4Ji3WpmhM
         QY4Mfjmq1iubygVVb/KNSroMQPQDavBkVmLiw0/XMAjQnFRCVIKqbtFX6JacQo4Tss6m
         YWhubLF7358Jz2ZO6q5lcP/llnus3BrZgge/0UFQ2HW68GZfrphwMyl+16pl1Wv+yiu5
         6+TDJMhhKJO/7snEu8w3R9ISBR496y9OLfWO+682RmQipNOrUjD2RdILXbq39SR1pina
         grOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0eD2NKzR92krNnSCAEqt3EN7AElb1rlw5uXmc6X1m0I=;
        b=Pjj2LgPt7+rJxiNuRgOccX9xKBGRYw7fv0hIj64kyyO3HTIttySnIQbbRQHQLTnXhS
         u2MVb30PLZYCGvGzUFnqefMI6j/cikqEQgurtkvGKI30vNMhVO+IUyAPEN80PRIgzgO1
         cNBz7DPf5u9nax9g3JGaMUQhCRQdViUrlifWddKIawvTcm1wJxUOc5dyukc54yzDVW+S
         MAoMVsrWl9ifjJJX7ws40DAdRlNhjmQNQaK2kZk+mW3vbkPX68fxJW3Go+1uRSd/Pleo
         KblGqAMIhmY5NQVVwgE2xOa363SAwxFToNkj7YY/Bomu9KdeDVSiZNJSJuU/9GjdTl3q
         6tog==
X-Gm-Message-State: AOAM530GynXwYOpB+SJbtF5KdjJJAzY8zI71y8VtgssRGrspuHOOpNIq
        lVibMrsoDo6Fg4hnxMf+FFvMSg==
X-Google-Smtp-Source: ABdhPJzgZD7Ut0KQSWuTsx2q+526QSQy+cqtMp4zyuBW2ebISqTBxiJGMb+5BE0Iagm05/cmP38YvA==
X-Received: by 2002:a17:90a:17e7:: with SMTP id q94mr7708393pja.117.1624428102352;
        Tue, 22 Jun 2021 23:01:42 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id g18sm1063642pfi.199.2021.06.22.23.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 23:01:41 -0700 (PDT)
Date:   Wed, 23 Jun 2021 11:31:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/4] cpufreq: powerenv: Migrate to ->exit() callback
 instead of ->stop_cpu()
Message-ID: <20210623060140.2mtivaxuiemgg7ug@vireshk-i7>
References: <cover.1624421816.git.viresh.kumar@linaro.org>
 <e40e57a97735614941e9ca7fa2f221f8db9a12b2.1624421816.git.viresh.kumar@linaro.org>
 <87v96516d9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v96516d9.fsf@mpe.ellerman.id.au>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-06-21, 15:45, Michael Ellerman wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> >
> > Subject: Re: [PATCH V4 3/4] cpufreq: powerenv: Migrate to ->exit() callback instead of ->stop_cpu()
> 
> Typo in subject should be "powernv".

Thanks for noticing it :)

-- 
viresh
