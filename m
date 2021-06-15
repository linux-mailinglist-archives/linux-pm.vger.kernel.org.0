Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22363A7638
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 07:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFOFEU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 01:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhFOFET (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 01:04:19 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5034EC061574
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 22:02:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id k15so12348587pfp.6
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 22:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UN4uXpNFwIqGmFhgPQ7JnOT7nbIBWoUjjkVNyzE4huo=;
        b=BTACoCtX0Dq7ppvJcamvr50OQU3TFXmLMbVAUleMJke9KdsAwknuXOcZLszxTbD0w5
         oqPfDN3yJKsfQPNEzqLY/Tq9N/nfmLb+ylEIIhV2WNlnA/pLuiMdVF0u4F3FMP+EQy2i
         DL1s+EPBYY7THJSu11RJwCGBNw6mqfh3UzHYrp78CMxchvhU+zIMUsUA7vUsr5Utt4m5
         ozQoeDFaI8cyuFA60bgOYcLFB5cDq4nJS0pEyZ5vj7CXi3H5g2HkUnEFGa46tzMUPNn/
         lAWqYxnCo1TbYues2SI7sFO1+7kJP+NenvRfHP8zgyTBPpYu754MEA7+Eal0x5lrh7gA
         5lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UN4uXpNFwIqGmFhgPQ7JnOT7nbIBWoUjjkVNyzE4huo=;
        b=AUNdu2zkyItJuopdt0M/IOqiBtc4OevbAUqF6TUgO9QRG4bBrjdXCSYgt4SSCogOi7
         FVHOikxbIwF0+ZvdJsBgrIMBSfuut1a8k3VzX927G4UkaA+RP47wTY4jpoN8GKQe6nRo
         DhbnKAcbpBiauxCUiIdm7Xs5kkt4vA1v2ZNr+H9GjyKidKc7zkilObXKM4sFoX6Jiprf
         be5CXf+AX0M2ZHF6ezpOyonpp+yjxxeY6vpLS3cmosvZX3U6OKvyBLiM53J4M1v0rGJn
         3gQdA9l80J7Sh9k1835GW2v7sHOtllIVriY9EYbGDZ7W44lg2H8ZhfSv56Wy0AnY1Fi5
         ChlQ==
X-Gm-Message-State: AOAM532horSUbCTyFlgQ1ychEXL9XHir+3zdcb/j29OZ/t7FqZuGdt0H
        Pfy5dmrxk5oX38GcE7c5wKTHFA==
X-Google-Smtp-Source: ABdhPJxIgINQjV2e45Mv91v2h7qhQz5PenpBprvA7B/YkYjQ/qDLX/89j/LzDU2Eqq2f6Khu5Po2nw==
X-Received: by 2002:a63:1004:: with SMTP id f4mr20372577pgl.115.1623733334819;
        Mon, 14 Jun 2021 22:02:14 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id fs10sm1005470pjb.31.2021.06.14.22.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 22:02:13 -0700 (PDT)
Date:   Tue, 15 Jun 2021 10:32:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210615050211.5gpx4faha6heytad@vireshk-i7>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
 <20210614072835.z2tjoaffcflry7pk@vireshk-i7>
 <20210614133522.GA34061@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614133522.GA34061@e120877-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-06-21, 14:35, Vincent Donnefort wrote:
> On Mon, Jun 14, 2021 at 12:58:35PM +0530, Viresh Kumar wrote:
> > On 04-06-21, 12:05, Vincent Donnefort wrote:
> > >  int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
> > >  {
> > >  	int ret;
> > > @@ -362,7 +409,13 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > -	return set_freq_table_sorted(policy);
> > > +	ret = set_freq_table_sorted(policy);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	set_freq_table_efficiencies(policy);
> > > +
> > > +	return ret;
> > >  }
> > 
> > Lets provide a single callback from the cpufreq core to do all
> > settings related to efficient frequencies and call it from
> > em_dev_register_perf_domain() ?
> 
> Sadly we cannot do it in em_dev_register_perf_domain(). This function is called
> from the cpufreq driver init, when the table isn't available yet.

I looked at all the users of em_dev_register_perf_domain() and each
one of them have the freq table ready at that point of time.

> > 
> > So we only do them for the cpufreq drivers that register themselves
> > with EM.
> 
> Currently, only the EM would set those inefficient OPPs. But it also gives the
> possibility for individual drivers to set them, even if they do not use the EM.

This is exactly why I want those parts of the kernel to call a
specific API to get this done. This shouldn't be done automatically by
the cpufreq core.

-- 
viresh
