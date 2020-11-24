Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11892C1D2C
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 05:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgKXE5C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 23:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgKXE5B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 23:57:01 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A83C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 20:57:00 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f17so7839687pge.6
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 20:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ncpwistDFnipYLn+/2FKxZUn+WKeJ5fneb6uwY/MPIQ=;
        b=GK1RxQqLnVhVj8jOqOYCtmv4YBATiByta/qF4Czg7CYzV4aaAlcHWuibeXBFnCfnB3
         q8y2DtxRlrZblPn2jL7oB7eABBb++nnhdu92oMJ41H3wFZr4K5hlbPXF8rTryakLDU0E
         R4ZZdLXGJ/WXMH/3JjEtTTXzJnIw7+3YJA4SJt2CmzEgqwLz3u1X3Lp2J1oLh6wT6ONT
         dQ0SVWXoxmq3qHedEZqSEIxmyJMo7aZTOspjvLxSNj/uB2kSUz2WD55Krs0qa14SOPeI
         bYynzPImk2G6i2AWdgx+KiTsaHjn4634ZOCDhHd5jKQSaInBSOpdCOGl0Cplea3W8s3r
         zZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ncpwistDFnipYLn+/2FKxZUn+WKeJ5fneb6uwY/MPIQ=;
        b=DSb3+sxe0QLcgOnTyn+hyjiUw524LpSQcM31/3hl9apZZEhHdqWEmAGl5G3vUZWZ07
         0YLtnELyY/iIM/3vxIljYf482GW20eAmxX6dddDIJEFpxA192XX8PbS3BvfpguU1kqzT
         pGcq5fpFg9vTXhmygvtWmEZ40IFJxMP0SdCmU8poYSobOLpL1Ds2amNEP3TfuNLeyRxZ
         F8+tk1Pqi/RBv1Jqp8DVKoMwpnHQrBcVXkW2wy4/UgDk8fS5AUNKJNvPrhwIEeY2kEAQ
         Jk7D09wBSMSY9IyXmVI/NRvdpVmP99s1etGFe/ZRdMOXy3e7dQMidr1WjOtJETNnteBp
         +gHw==
X-Gm-Message-State: AOAM530qTU4ZtymCUQETVS9A61CTQID0WmrBrisy1bTKzE/xlCwJJxeb
        crMeEBc6du8r/VtJH1WOqgrtrgtYGIUU2Q==
X-Google-Smtp-Source: ABdhPJxCpsrFYmyMKV+7dRbT97Vja8EQkjD7PAm2TZk1FVxAs7v60jrow0dq2xqS6MwSng19pVxIqg==
X-Received: by 2002:a17:90a:1bc5:: with SMTP id r5mr2827375pjr.157.1606193819575;
        Mon, 23 Nov 2020 20:56:59 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id d68sm12501014pfd.32.2020.11.23.20.56.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 20:56:58 -0800 (PST)
Date:   Tue, 24 Nov 2020 10:26:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Quentin Perret <qperret@google.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 2/2] thermal: cpufreq_cooling: Reuse sched_cpu_util()
 for SMP platforms
Message-ID: <20201124045653.jpkcl75mxjihovhj@vireshk-i7>
References: <cover.1605770951.git.viresh.kumar@linaro.org>
 <1fa9994395764ba19cfe6240d8b3c1ce390e8f82.1605770951.git.viresh.kumar@linaro.org>
 <aefcc0e2-6c13-625a-4367-fe665330c0db@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aefcc0e2-6c13-625a-4367-fe665330c0db@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-11-20, 15:32, Lukasz Luba wrote:
> LGTM. It has potential. We will see how far we can improve IPA with this
> model.
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks Lukasz for your review :)

-- 
viresh
