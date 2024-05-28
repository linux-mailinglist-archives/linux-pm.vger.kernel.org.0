Return-Path: <linux-pm+bounces-8213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4D98D132E
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 06:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0D11F217BD
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 04:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5F61803E;
	Tue, 28 May 2024 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QATxRP8r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D22C199B9
	for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 04:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716869032; cv=none; b=i58ubw8Ke5uy6FFzpqk64iojojJniMMFCmEqyI+m/lHMRiFGbOCRN3GZbJveqguXXMQQLg1QPYeututFsFep7/hPqkoNP0l1qx+jKTKI8PmmhGiuMkRLs90UlFTJ8UTmsSj8m/bE0kplT5fFX8FvH0didN5mtKrbdm4I+IBig2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716869032; c=relaxed/simple;
	bh=nvmQbMSy/xDnp4t59qze6qqL8MOKPZ+l9BJVovTrLUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfy3hcg8L2uRqyk8ggzTQcOIiJb0MO+xGI7Y/Haxdm6S6kuugNGfBgmCyueR3P4KiAZqJiRjcYzNK+Eq79ylfeSk72PF4JRFIVXO1qyWrNHPQVB8Dd+lepFzJS+G+NxMc/s1ehk2W/dFYtIc6YDKsczmg7qtQgTBBLoBobF2p6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QATxRP8r; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-681adefa33fso372781a12.3
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 21:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716869029; x=1717473829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6CEMW9a4/PMVNxLukMbKPAVKxBTND9bevwPFka9vvQ=;
        b=QATxRP8rav7dsoxqPX844UZj2X1ixRZLe12Pq4RMltsaSeQnsoRSURAuJXhC/TbsBs
         s60BPjRCNBTYwiT+9RAHf0zjaih/qkJ73clUF9ErD8GjpkmTeeVC9+XG1V/0qUT4CpFU
         QpAv9K0roMUHRlYEDqCKCzzjKp5y5ZyPniU4B8EsZn+5U92T6mymgNVdi5hZ0KAteVIs
         60NDBk8gwVryxpzWQlOGSRKm6eibiPou8wX+k5lkdnCHqx49HBuHGuGA9ZxOCG6eHr9X
         zseTyvDrZTRlXvL5npgbahGp3KVB1PDdMLA9QLEeQnl/LG8/nUZ+4YMbkrA/gf62Hggk
         zapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716869029; x=1717473829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6CEMW9a4/PMVNxLukMbKPAVKxBTND9bevwPFka9vvQ=;
        b=iiLNkR8Ie9E5kJiTps93qT5hbvt/NX6uyydBEpDAyoA41rhxHM+d9RQ/4a1h9rZeai
         nM6sKZZ2H4JOVsktiV0EwzUU+guXLnSX2iOsZlYkpgy9sijDFnuGxaun8UPL2GKoe+xc
         tenw0E/fyO0oBMTZ+gfoETsWNE/WlqWODR7wlMkGPW8/cnCO3yyl9aPidI0bVDk6E+2i
         VRajr2Gk4zzYvWY4om8j08sxuZ7g3z7mPl0etP8gu5juaH+N+rbwcp4u8q0m5h4rgpNo
         nhUFA+u9qzM1wuLhfG9t8ekYaDydDfKZJdP30sgKl68dhX7qOFem/IxeG2F98wt6edk9
         Wqjw==
X-Forwarded-Encrypted: i=1; AJvYcCWfANTvt4epSQOU7HUS5rhUy2c7FgQTQHgvdRmdBM86zU9ZEydEhAy/NZt3u8Yn8ltBbqwzcHOGew3n74bzOF3mV4EvqKVKiok=
X-Gm-Message-State: AOJu0YwqQr5omN178YWkIamBDtGKnxdfrKX3bnYPRy/wPFFAfiEGqJYZ
	+YzeokgYTB25laXVvBRVk7ELBQDhZheXVf7g8H25Ow1ta3G2ELRRok9p41j4lSU=
X-Google-Smtp-Source: AGHT+IGSS9psSLsvm6XTl81wgOYtz9x1Dc2PBuLQ0h/YskIif/iqhFMW0znjZ5di3n0CeT8e3P9Paw==
X-Received: by 2002:a05:6a20:431e:b0:1a3:b642:5fc3 with SMTP id adf61e73a8af0-1b212df06f3mr17629902637.41.1716869028413;
        Mon, 27 May 2024 21:03:48 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682273c4503sm6645718a12.83.2024.05.27.21.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 21:03:47 -0700 (PDT)
Date: Tue, 28 May 2024 09:33:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Vivek Aknurwar <quic_viveka@quicinc.com>,
	Mike Tipton <quic_mdtipton@quicinc.com>
Subject: Re: [PATCH V2] cpufreq: scmi: Avoid overflow of target_freq in fast
 switch
Message-ID: <20240528040345.ghw6qkha3cka2pe5@vireshk-i7>
References: <20240520063732.11220-1-quic_jkona@quicinc.com>
 <20240520084744.sb2rk7l2pjf4whyd@vireshk-i7>
 <e3a7c295-28e8-465c-824f-6f14c5977726@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3a7c295-28e8-465c-824f-6f14c5977726@quicinc.com>

On 27-05-24, 15:26, Jagadeesh Kona wrote:
> 
> 
> On 5/20/2024 2:17 PM, Viresh Kumar wrote:
> > On 20-05-24, 12:07, Jagadeesh Kona wrote:
> > > Conversion of target_freq to HZ in scmi_cpufreq_fast_switch()
> > > can lead to overflow if the multiplied result is greater than
> > > UINT_MAX, since type of target_freq is unsigned int. Avoid this
> > > overflow by assigning target_freq to unsigned long variable for
> > > converting it to HZ.
> > > 
> > > Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> > > ---
> > > Changes in V2:
> > >    - Updated freq variable from u64 to unsigned long to keep it
> > >      consistent with the rate parameter in scmi .freq_set() callback
> > >    - Link to v1: https://lore.kernel.org/all/20240517070157.19553-1-quic_jkona@quicinc.com/
> > > ---
> > >   drivers/cpufreq/scmi-cpufreq.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Applied. Thanks.
> > 
> 
> Thanks Viresh for the offline update on applying this patch to cpufreq arm
> tree. Please help share the git tree details of the same, since we need them
> to pick this change in Google ACK and downstream tree.

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

I have pushed it out now, it will be there in linux-next soon. My
branch is not fixed, I may end up rebasing it. Ideally, you shouldn't
backport anything to android unless it end ups in Linus's tree, only
then the sha id will be fixed and guaranteed not to change.

-- 
viresh

