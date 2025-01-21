Return-Path: <linux-pm+bounces-20736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366D9A17677
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 05:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15563AA830
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 04:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4771891AB;
	Tue, 21 Jan 2025 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qq53x1Hq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC7814D2A0
	for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 04:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737433230; cv=none; b=NLEGCLOPOaQIVEx/j1ZIPZ6KWNbiztXZAxMUIWxn5o3t9dz0e1XQLE9RVk92u5wdVF5YrK+F6f+jz9WHeg0Fnu5L8xVtcRAVT0bQC9FKIaEmd+6xK1CMRQCC0Pz6bDRtZdkgGjNCj79mFz8ItS/mEd39auGBQiJqkKFJUPqPpVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737433230; c=relaxed/simple;
	bh=ICrD6D8VgVHSgFucl2FixT2Me39Z806PVrbdxN4cqEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcWsxuSOA51jsNojOBCl6tq7NxCzlayd/ABjOUBUIMlD/fz04YMzF+4874QhN3/YUaOwI7VktVRJCSm7lzGPdvt3jzzxPIxR2Ld45ULe/aH18C8qBhTbQeCXlVq9xa0w3Dvg2qqyxmGgg28u9hQ2bzUZ1Z4SKkuFMmmhzGb5eLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qq53x1Hq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2166f1e589cso124545535ad.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 20:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737433228; x=1738038028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/gBvcyyH89Yi+/gFYNgktGFcmGyjlJgsZzOk0Kft5gU=;
        b=Qq53x1HqKa+OjT0tFxr6/EIx7VFBx1N6Rd2aLy/9C5EmiWbSP6ZUeNBJLpDtz3vH96
         4+kNwQFHt19954Xd5bnVqQquHXP1M0ZSyhrNsHNGh4phYSt0tpGd3hkDCzqT4gruFHhZ
         T9/+QfDZpSLfOg6W1CK6WCq6QhZbesTvgurJfXjv607WkpW1QX5o0MghawRV9wrKRaSV
         xH73Xhynut0Ww7P5xIB9yZUU1TG4mWTF6VxvdYYYo6iiwizgzNP4oMReNS7VA/fLmDLh
         L2VEDl1gX/4eqro96YfWx9KqWClHUsF2GS7MdnmLySdgDmng0TgSwq2h47jVP7HFLeHj
         kdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737433228; x=1738038028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gBvcyyH89Yi+/gFYNgktGFcmGyjlJgsZzOk0Kft5gU=;
        b=tEp9z8A0c8HhQgq4gXM02+MmNIvDMNMxDEoSTH5stM3e0xb5Upt85ooeGnOyXWpoUu
         jlGL6YrF1KXQ15p5vLdjBXJVzH1j1/Z+ZHf1/TBFZVyaxAo5Ccm5dxf1bvTX144hkLhn
         SpsquLy7q5S6f4sgn7NMFocv5tyIx4I4ZlSJkWIqvWa3AWe+9OE9QC+cttuh8VUMOmPi
         jnyPnac9uupvmV79aUUJYRJQbV0Ge8xpv9o4aG4FGVV2OHOC2SKfqGjEzyOP3wWfAoj3
         s6E0xekdJy4HDkqjGahXgQ6QHz8yNVdT4Vi9VWAX9+nhVlTeCEfr1xqr9O0HUSc+fbO5
         7vqA==
X-Forwarded-Encrypted: i=1; AJvYcCXz7nklG+FBRjh20ofgChS09FKy4yxmDq0DfJkGHSQohWrSaM3+12KmA3GGK+nS7wbYSeB7CrqnOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwY4q5JHDE2B5tX1iyKq0oEm/UBI9x25g83Kn2S9bPjuQyZDxxx
	sh9NMezQnNdUib46ek9jFrIK7LRjaw2MVxMGp125qAqHAHTMY38WMgq/PQPAwm8=
X-Gm-Gg: ASbGncsORunZKu8G9QR5HUm+CosHcWA7+EoYdYPB8gvigMmWFh2BLnW6GX862koG2Di
	U2F4b2r/JmVRAbCJDjEHR7tU8XLuV0V3wMvGIc1A0DY1cJtU1ivXRYBXiyzsOV8Cb4mU1W1hXA1
	CRWmkEV793WvFhOOqZwQ714HlSskDz6yzsCXEH+iNDwxF/QlpAtlygHcRqI6wlCJ/fWTLmxA/sE
	TDAnQceW8dwb+mvHFZkGfYaRNIhk8vO7Iu43hkJzG2D+mDTcImwFvzZSatNy+grzqVzIJh5
X-Google-Smtp-Source: AGHT+IHJL6mbFAtUKS4aoTYf8ieFqDuYFSyaeqEyjcGXt5LKYNjPdMd3yMWqRL9QGamrS+JqherYJg==
X-Received: by 2002:a05:6a20:3942:b0:1e1:9f77:da92 with SMTP id adf61e73a8af0-1eb215901e0mr23084565637.33.1737433227866;
        Mon, 20 Jan 2025 20:20:27 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bcdcf6154sm6532770a12.33.2025.01.20.20.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 20:20:27 -0800 (PST)
Date: Tue, 21 Jan 2025 09:50:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH v2 2/4] cpufreq: Introduce a more generic way to set
 default per-policy boost flag
Message-ID: <20250121042024.pstn2otfqnnajgxl@vireshk-i7>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
 <20250117101457.1530653-3-zhenglifeng1@huawei.com>
 <20250120090102.erm2ffkbnwa5vraa@vireshk-i7>
 <0c910772-368b-4e30-9ce2-1f68510703c4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c910772-368b-4e30-9ce2-1f68510703c4@huawei.com>

On 21-01-25, 09:45, zhenglifeng (A) wrote:
> On 2025/1/20 17:01, Viresh Kumar wrote:
> > On 17-01-25, 18:14, Lifeng Zheng wrote:
> >> +	/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> >> +	if (policy->boost_enabled != cpufreq_boost_enabled()) {
> >> +		policy->boost_enabled = cpufreq_boost_enabled();
> >> +		ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
> > 
> > I though you agreed to do some optimization here ?
> 
> Sorry. Do I miss something here?

https://lore.kernel.org/all/17c7ed77-21f1-4093-91fc-f3eaa863d312@huawei.com/

-- 
viresh

