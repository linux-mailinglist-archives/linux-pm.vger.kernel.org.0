Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC9E3A5DB2
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 09:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhFNHal (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 03:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbhFNHal (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 03:30:41 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFC6C061574
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 00:28:38 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y15so9888320pfl.4
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 00:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DjnV04HG5NqPgKJtkvfELyyZ8DqhVJP7YK7izCblCjw=;
        b=njZK8PAG3lzzCVRtnUAKvaWXi3dDGLIrJwSGIwErp4PtifmDiqNG9XSHCYIxggfzM/
         m+zLRcRGGjlLPX4ntpj4jkp9eJi/qa20bv4PSVy+AAAeo/WAow3VB21XOFHNKsou0s9B
         z3j0UTuMTC8J2NJ5mp/unIVxH6Qj6cLca+n7D2aTnyRe+rwg584bmzd9hr55/33qsYNE
         knqtOjz7E9FcG25fssK7NTVCJ5L93luU9Np/0F6rhkjo3BGG1JpBZtUl/7iXbLIH3oul
         79pKY6+NkImEJGvoVchN8gDgIeMhBvpxINfzvvnoWvBDLLghg0a1k1JkW81ROCqeERtI
         rvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DjnV04HG5NqPgKJtkvfELyyZ8DqhVJP7YK7izCblCjw=;
        b=cdacN8rN5XbxcG1LcPi0a1c1P9mH36M/X2QcObWF8+aLvsuKAsENxjmf8MtlBrc5Wt
         XmxIzGB/4G03/+6buRzx0nqWcNqwYiOO65TQ5/anL8NgSNE0fqWHfBEdgVLipeW9oQhy
         hZn+b6d4LYJhL8JXq80nBYq4+gvpVb78pMzTK3MG24z1OXm6sA6ivqBKi0dWhaMW4mbI
         O73Auq9gghq8CMS/GgXE/Rp9H6MM5eK3zyJQlTERreUUwlWQTKvVdsoqITY3kfaxiAlj
         W1MOHExjhWzewglaf7b+Ht9vtQo8XsHurDFqMfEtLUAZaJ0/3X9TH5jhgUIHHop1p56f
         Zzhw==
X-Gm-Message-State: AOAM531tkEFhJF0SnUclFzlrlz1Jzfa1yZ8LJ5xdoV5kQx6x4lxFMWAS
        1qzTvEUChN1EikKQxT2psRdUVQ==
X-Google-Smtp-Source: ABdhPJwi4a3Xn7vvft7b/oFWckJdn/s1PAT0wBR3MO3rGFNWGthZpMteAxVEYKvZOaXEuR6OXolt2w==
X-Received: by 2002:a65:63d2:: with SMTP id n18mr15772445pgv.447.1623655718346;
        Mon, 14 Jun 2021 00:28:38 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id r16sm12211949pfq.140.2021.06.14.00.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 00:28:37 -0700 (PDT)
Date:   Mon, 14 Jun 2021 12:58:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210614072835.z2tjoaffcflry7pk@vireshk-i7>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-06-21, 12:05, Vincent Donnefort wrote:
>  int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
>  {
>  	int ret;
> @@ -362,7 +409,13 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
>  	if (ret)
>  		return ret;
>  
> -	return set_freq_table_sorted(policy);
> +	ret = set_freq_table_sorted(policy);
> +	if (ret)
> +		return ret;
> +
> +	set_freq_table_efficiencies(policy);
> +
> +	return ret;
>  }

Lets provide a single callback from the cpufreq core to do all
settings related to efficient frequencies and call it from
em_dev_register_perf_domain() ?

So we only do them for the cpufreq drivers that register themselves
with EM.

-- 
viresh
