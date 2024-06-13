Return-Path: <linux-pm+bounces-9066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9133690673C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 10:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8582819AC
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147F713F45B;
	Thu, 13 Jun 2024 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0rS1jAI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CDD13E40E
	for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268057; cv=none; b=l4yqRfzZMIHHKNMf1vFeOLqE6imx1agKqhKQ/VpezV5MViYIqk96MIXRi7WDdPEO9EZySgGQBmFWbDHaO7tn2o7G6vowO8gblVCF74exH1QYp709GZh06MzlJ7sQdKR/608noydrItlRgclUuSxTzZQFE9Muiq8tcuJBvo1kzwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268057; c=relaxed/simple;
	bh=lz+J7ECynvwrICT+knSUHp3JLF9AhqPp3gvZh+sZfzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUKURjOb0mKNyGFQDvth9wgNWflZth4Nn7C5xbrFxz3w/HMQm4BvSK9mnYqPKde0Z1NZv3ABQHzzfFc9rd1WigV7AVbODGUnBO9IkjwArLWUIQ7YhE3zYJLeWiu8Tn0X+xEH30cgiMuMjosOe5O4BBkItSI6EDZ73AiFAHIWAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y0rS1jAI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f700e4cb92so7248475ad.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 01:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718268054; x=1718872854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YDwa0aAv5gxFNuZZc/0uN+kIGJAkjMhJhrL06tEhYk8=;
        b=Y0rS1jAIJm3V9OqXQnQfhNP3EHyEvjlqeFU+dU6393K43N7wHL1cAfI5VhgYdYSwHE
         v1xVYYgwKsHPf/mgbpGaLc0FbE265bN05FWf25gVqvxBIZlnn4Vfg5NWeEF0xA9F4V+c
         UUqErN1FewiZRtEJtNSLdkwciUbJCkdO73kx1GZW+fKf+0DG3owrmfh/Fdo94j5fGKCA
         K90Xv0d52I25CrIo8q5WBTbmYs4YxxbhOF6NCWn8l1dTl+vNjYEfi2l41GZ7LkhYvPDm
         F7684F/FgaWc9N1eJoKD+318jWwhOhepF42mlvCEnmSfMK8808ttYnDSmXt56kSS3dcT
         UTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718268054; x=1718872854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDwa0aAv5gxFNuZZc/0uN+kIGJAkjMhJhrL06tEhYk8=;
        b=GCUZ8kXJEKj2kdVVI1g0wgbm+fASi2YCZuI5CTCucKgWs3BtFX8+BZJeCniYgfV7Cx
         w3bX5KTP8HmEL8cQR/H6yz1CJ55ajTUWJVZUPReot6lQANMGszTTFru6y1fQFTyIqIdG
         362/wPVeahveiVXXLSN0MnzAKgGMnOn5FPeC5VKnSejg9pvB+IfHA6URnu0KuW+SEqQk
         z/fM4RLJe6YCA5ZU/icP5QtO2JrlvzlwT6oZ9do/EpNaeJOOrvrhajIlnA1lUZz5bK0a
         /CcUrF5fG9X4FJS+YIsxzLJOvPxLG6f1xXAYyhidFdKGEnkas2TBnAMYtj+G4dqIK2xN
         mUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPRO6o25fNmLQ7vjQLoLMcxKCeJhv+5s6BAxsE6pbXb4P0hiAcIalv52p9SOou8B9u9ACDJ8HzSMTDn2ieFLrrcUV6Ar5L4wU=
X-Gm-Message-State: AOJu0YxcLMmal2hmBOoLlwNJtQb+RVIa4VgWYXtG3FP7GA+MumRNvgH4
	iWCsONaLgqKzG1Hw1mN1rjWKgbsKpDU4cOcYOTdpr7ZaB1UMT7GV7wHYXQKyZ1k=
X-Google-Smtp-Source: AGHT+IExRaITsIyPWFBZWYk+cCJaiWCZcYlnzQyFSWjVSUx4WBIhmdHHpVxHQkRAc7kEd0QvJmAA8g==
X-Received: by 2002:a17:902:ce90:b0:1f6:a96f:225c with SMTP id d9443c01a7336-1f83b60eea6mr49703325ad.28.1718268054236;
        Thu, 13 Jun 2024 01:40:54 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee81casm8226255ad.163.2024.06.13.01.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 01:40:53 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:10:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: "liwei (JK)" <liwei728@huawei.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	rafael@kernel.org, al.stone@linaro.org, ashwin.chaugule@linaro.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	liwei391@huawei.com, liaoyu15@huawei.com
Subject: Re: [PATCH] cpufreq/cppc: changing highest_perf to nominal_perf in
 cppc_cpufreq_cpu_init()
Message-ID: <20240613084051.6e7o32nmwim4wj5d@vireshk-i7>
References: <20240428092852.1588188-1-liwei728@huawei.com>
 <20240429104945.esdukn6ayudgyumc@vireshk-i7>
 <ZjoBrF4bAK5ukm7H@arm.com>
 <be312b75-eede-44f5-b7f3-b50f50c6fb56@huawei.com>
 <ZmB1qKucR5fXk100@arm.com>
 <20240606072031.lxr7tykl7sdgjwva@vireshk-i7>
 <ZmgbRh+m9MmEaopK@arm.com>
 <20240611094526.vcirawlsdefbkuhf@vireshk-i7>
 <Zmgm9Rf0piqFqnrI@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmgm9Rf0piqFqnrI@arm.com>

On 11-06-24, 11:29, Ionela Voinescu wrote:
> Yes, I mean we should only update policy->cur to a requested frequency
> from a governor, after we start it (cpufreq_start_governor()).

Hmm, I went through the code one more time and there is more to it I guess.

During the earlier days (when the cpufreq core was taking shape), I think the
basic idea behind keeping the policy->cur field was (which is true today as
well):

- Know current frequency of a CPU, quickly and so we cached it.

- Avoid a frequency change, and not waste time, if we know that we aren't going
  to change the frequency eventually.

- Ideally we can just remove the field, if the get() operation has zero
  overhead. But it doesn't and so we have this field.


What the core does now is this:

- Once the frequency is changed, set policy->cur to the frequency that the
  software believes the hardware is running at. This can be different from the
  requested frequency for example.

- If we end up getting the real frequency from the hardware somehow, update
  policy->cur to match and so to avoid wasting of time later.

- And I think this is the right thing to do even today.

> But currently policy->cur gets updated to the .get() returned value in
> multiple places, via cpufreq_verify_current_freq() (for example from 
> show_cpuinfo_cur_freq() or cpufreq_get().

Which makes sense based on above..

> .get() is meant to return the current frequency of the hardware and that
> can opportunistically be different from the last request made.

Right, and so if we have called get() for some other reason, like the user
requesting it, we opportunistically fix policy->cur as well.

> (+ we probably should force the first request from a governor to go
> through to the driver to make sure the policy->cur obtained before,
> via .get(), did not just happen to coincide with the governor request,
> therefore making the request no longer go through to the driver: see
> __cpufreq_driver_target)

Not sure why would we want to do that.

> > needs to be up to date all the times, it is an important part of the
> > entire working of the cpufreq core..
> 
> When you say that "policy->cur must be kept up to date at all times",
> I suppose you mean that it should be kept up to date with any frequency
> change requests not with any changes happening in hardware?

Yes and no. It should be up to date with the best knowledge that the software
has, without any extra overheads.

-- 
viresh

