Return-Path: <linux-pm+bounces-43652-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBqYMjEhqWkL2gAAu9opvQ
	(envelope-from <linux-pm+bounces-43652-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:22:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2832120B7E9
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 680F63045205
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 06:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CF4282F11;
	Thu,  5 Mar 2026 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KuX4MII9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FBF27280A
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772691673; cv=none; b=B5P6aUl70AFbunAOsIZvaeV11ttWqGQ2TOwyJsx2MQc71UjVHvJIHzTDWaxw+Hvo7Gfqc8Qj2WEI7jkahwHz4+FFBCYspcBcXZw+7i1itI2zJ8FauM7dNgKtNTq7d7Id42SJy707OlEEdksJWBvC7hrpdTHMp4JCxbt+6viip88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772691673; c=relaxed/simple;
	bh=Qh6vfNCTTclJyCzhn791amMMn+1O3cZI9KiBI5kkeLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaqgbP3lpPQbnJt/mTeLTToI1p/JMEXNOjWJiFcKYQcv8YKCC6Gi+WGYsdcv9JyWfyboWoMZqoYmryzHA/fmA7qWSxKeyfYzHzJ+eq6IWPD/XgKoFYJAX/x4udFE6xGgFwzYAxPLg9XgkY9MygapjYMIgOlRAZX+sg03F7JxbY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KuX4MII9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-827270d50d4so8076679b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 22:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772691672; x=1773296472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y8hZ/u63/1B5iEl5ucyLfex+mt3rmiBZrOOtdGWM0QE=;
        b=KuX4MII9s0hOOVx5x1y8tc+gR2dCG/AAgPo6EzpiDjD3ngphM96UzxEchkpC/zkQS5
         LeNjpZz2EQXzbtwxUZLVgAmljApogymhXhd+lZEzOa8sj4ThGyVGD+nIYqA74DNPEveB
         wD3SPyd3HssMA2VF5Z+T5QZaxrkFCwJkuA0/vu/DrNZ+0+oKrRE3vs3Le2x+NeqkFmes
         dIJR+m1ASSGw5jQR2Sc3/9hKnBMpMhAle9xgDE+N6u9X574pcbx7TUyop77O4hotKxL1
         MCYu799F707Z1hgfJRPqMvThxVMbWzNz/0nNHrQI3gCrfz1YtaU2PsvYhMA54auM0CxU
         JB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772691672; x=1773296472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8hZ/u63/1B5iEl5ucyLfex+mt3rmiBZrOOtdGWM0QE=;
        b=Q9AAvYZDgL9TN6IkWa7tPCMXsCkNIZh/3JkCBdPIYQQMoFEgfGJ8rIc18PWOvHvCgx
         iIsEW5EZmLAD1LXW9/BKcgmUxlQ/50Y3JD8i1iKY5RIuhRWawtD7KCNGZ1r0ojCunP+o
         zL1GVkai/4icUUp7nLOOkCM0VQC+jizyKCuDZJnVXrkfwjOKqxKOjT5cCWnvtSAISNdN
         V+lwRJ6n1mN59KSIiCCpGT89a2+sPtVRb4GCQhPdOMe5LfG8EtSHZmondSvq4UJ3079E
         /uHwAolRZ0PAyEbnrc0YrTtcTB2bjH3NsSS66mr4ssmF21BrRAaszbKIJwiZYRTo2w7n
         ml9A==
X-Forwarded-Encrypted: i=1; AJvYcCXBgo/6XkMR2gOhxUQxlLrENzF5x0DryFgXqc86W5vtlamJM1MXWfr76vin8OiAf/Fbsy7L6ECqEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDTay+LjreaxuB8RN/r3cVEFnKTd0NEBDaIncFhdGCWeEFonKN
	vSgbakmYZ6OO9FOyW7ipPEUrqK9EKZZ313Tmmoya4ip5wc7Y2itZwhw4GLVtAKQAP6k=
X-Gm-Gg: ATEYQzySJZRueNffdjjhwEWLyDqjK1ksngJRztqt3rpnvwI3SrIGC+BntZrXepr1lc4
	MtFnFeunHKhKDX7MCcJTT6tvGCIVPUAGcjGZUu90gEx2S+sdKba3dAJkEQP6ZVN8O8GzWLCDtPr
	Y5j9DBjjJTgqOEZQfeca7kDBFlaopXohDplYC1nY4arkVBrT1r8hSdsHgCcAgC0NflZXuQwM5iD
	ufmRLjyFmluwLrDdHpwQNTgloJzWR1XG8M6zvQQDZ6plWqI/QUC7wDBdfUpryV+1Qnh4DxQYFOE
	3G7gGaVQOoeO38dLyGk66SmDBUlfbPUTtt25OWiaPPRBaUZl1+BPKfvZW104P8S6GjhaOk8X9TR
	enXDis7gdQKtAAcGut7zSL2WFdHeIcqUmxBMs4qYvFTFqJ9o1mozgq3zrWJNd0X8nKOPYlPjMGy
	ve1XQh1bIGeV4gQtUBr9tRcsnCY0T05OY/Wjo=
X-Received: by 2002:a05:6a20:7fa5:b0:34e:7bef:e820 with SMTP id adf61e73a8af0-3982e1f55d1mr4796896637.41.1772691671733;
        Wed, 04 Mar 2026 22:21:11 -0800 (PST)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73790f881esm3100347a12.10.2026.03.04.22.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:21:10 -0800 (PST)
Date: Thu, 5 Mar 2026 11:51:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com, 
	linhongye@h-partners.com
Subject: Re: [PATCH 2/2] cpufreq: governor: Apply limits with requested_freq
 or next_freq
Message-ID: <bx2qtqvaoaf2nnlb7335onsolgdqtcfaqkkifhlvwhxsorujmp@jndpowazrp3p>
References: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
 <20260210115458.3493646-3-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210115458.3493646-3-zhenglifeng1@huawei.com>
X-Rspamd-Queue-Id: 2832120B7E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43652-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:dkim]
X-Rspamd-Action: no action

On 10-02-26, 19:54, Lifeng Zheng wrote:
> For conservative, ondemand and schedutil governor,
> cpufreq_policy_apply_limits() is called in .limits(). This function updates
> the target because the limits (policy->max and policy->min) may be changed.
> However, it uses policy->cur as the reference for the target frequency.
> This may cause some problems because the value of policy->cur is influenced
> by a variety of factors.
> 
> For example, for some reason, the platform determines a final
> frequency divided from the frequency distributed by the OS, and this is
> reflected in policy->cur. After that, cpufreq_policy_apply_limits() is
> called and because policy->cur is out of limmit, policy->min will be used
> as the new target.

Yes, but policy->min should be higher than current frequency then. The algorithm
has derived policy->cur to be a reasonable frequency, and we are taking decision
based on that, which looks absolutely fine. We can fix the algorithm
(governors), so they choose the right frequency, but this logic looks to be okay
I guess.

> This caused the real frequency lower but it's
> unnecessary.

Lower than what ? It is still higher than the last configured frequency.

-- 
viresh

