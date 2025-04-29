Return-Path: <linux-pm+bounces-26386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E9AA1A4F
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 20:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8584E17E717
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 18:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F02254876;
	Tue, 29 Apr 2025 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhNam745"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73D254861;
	Tue, 29 Apr 2025 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950756; cv=none; b=q3FwUu/NzzxiYdiquLwtS5qxa6InUhQOk0O956AlD8HYN50HgQcU/3saJHrjHs+GxS3InqJJucJv6pxTsJ2sofb6B48eMurgBSESQGmVtCVxOKzYOAsJdyydnCYN8CezZ4UMUqniFluJbXNul+J/3QiX4IejXZ+HbAoa48FBuEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950756; c=relaxed/simple;
	bh=A5+DrCAn9M6+wxz5jRD2PElzZRM4ayte0Hxt1H5mz+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG+U3GhoCZBx2gN+Cwg81L4qXZT3qvPZa/hPI/FXHlEEYySlaUuOw5Xj+g8eX2gN6tUMoPeB6Gw1WFYIWhql/K7E5NMOkxVwzx+2FsAkWdvQL+wxGuHDtuoZ1rnpX736cjTWcXMd+r7dEzjWSdMIELKu+IY9+JxOrD8FdYrRP28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhNam745; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8f7019422so64673866d6.1;
        Tue, 29 Apr 2025 11:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745950754; x=1746555554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aqvYy3CZDC8z+XLmUbJgcn0ixQTVHuAMPBSfeUzVW+4=;
        b=NhNam745EgWMJ+DGxS2aiSO8bzfvS+4QITjNgffGm/hExxbo8HmYf23B3DUUkhdbaJ
         EFIqVjeKYMZmEoua3cOmb5mE/TrtUYPA24wLmvZLe6wW45cO7SgMivOxML9BFKDA9L/Y
         5N/qZt0+Msm4NEFQOBcnkZto+ipZy0qpiht7M2oZQ+8h2Ue2koj5+1dIANZD/xSeARQR
         ZfyfyaJM8SlnnyxFm0dGM3cPMr+lYAcMcrpott/n1ZtweHySu9zQh5Q4h2GDnlEL77I6
         Ky44MIMcpcJ2FPHlXKwUkVTmDNZbDIABwu542hthGpK8AMuYOVpzWzq44b+QJdumwnzd
         tEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745950754; x=1746555554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqvYy3CZDC8z+XLmUbJgcn0ixQTVHuAMPBSfeUzVW+4=;
        b=MaALqtI1s6OLG/TP1VTcOLowVCUTEmpsL7EY1KXbkV9hI+OuMTxQD2t1u9bgu9I0mb
         bVED7MrKhm0gdPxO1MVcQuBqQLLGAiBXemwJeObU0QXe126/mV1/p8zhHAz6LNxA4qAu
         VKD1L3dPKOMr/jHu6N+Wmb8jlozUV0reRU79sfFnSlwDGY1JdJQ5TzkiyL53yD5GWa1Y
         DeEcjrS82NPZ8tUSHU4W6zoCwU9r+/zNO/8QpAFWjv2pOyNB9HuMG/jShZAaTSjb7RtZ
         aW3mbQSJEa7DHLgcOGMczTlDUCo6+D6vfKRnfJKwpKSEni/iQDAeMA1jepJD/ahcQbf+
         lSkg==
X-Forwarded-Encrypted: i=1; AJvYcCV1Bp+Vz3fm4JLgUSoVhk0AGpw3M9P0RWOVsCxcwvkn+qSkLNfQXjU0e0zn2HG6/Boa7QW33uzsTn3kp7I=@vger.kernel.org, AJvYcCXgStGvyki8mkyNeRnXIrp3a5zgiLhcf8U4/21e1svlfSrjsruIOtnDbNpuG7zNqkxZ2HaryjqJ5nM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1XGR8yqZSB73a64Ks/HFosKC/kT8CplmQJb+bUmHP0w866bb1
	SnPlSZvGHp79qATI/RIV4FQDhgt5CvqTn97bIJCCz9E6JqvHEcgk
X-Gm-Gg: ASbGncvcvFTwdRF9PQOsKQGs98KmQpRwJJn/0bL6nkhbp9LBi9jSyvLJNBnsxwZbkSP
	hRSRQK7nVOoBk//ZtsorrTMGUg8oU9Htg2vy60T5bVAC8iqSuPGvtJPu7DKnwLyxr/VVWdxDOm2
	zkk5xxK5xvvURU0ZjtSJTNFxCc10z7PCyLJck+CMf5dPbxY36k98SxeApanC/LJ/EFJKY3JAIe/
	4u9dUzUdewhefUA8F9hUVuIuC/MIcLPMxDa1+AnXie9ji+sxnTmkhUPeKCrISLu1NUdcbNOkwwp
	7KiemIBL6OosuOD60tH+eSQMc3K3kTW0Tayq5A==
X-Google-Smtp-Source: AGHT+IEho+3WjiTT4Oby8bMTkwgpHxUSpTv0GDtLD75FE2xDGA85LjxZziuggH9k6T/JSdAgycTGSw==
X-Received: by 2002:a05:6214:2523:b0:6e8:9321:87cd with SMTP id 6a1803df08f44-6f4fcfc7576mr5429086d6.40.1745950753728;
        Tue, 29 Apr 2025 11:19:13 -0700 (PDT)
Received: from localhost ([184.148.73.125])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f4c0938399sm74599306d6.40.2025.04.29.11.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 11:19:13 -0700 (PDT)
Date: Tue, 29 Apr 2025 14:21:29 -0400
From: Seyediman Seyedarab <imandevel@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] cpufreq: fix locking order in store_local_boost to
 prevent deadlock
Message-ID: <laqfi4de6ang3ugwwpvdgpmwffk4ice6vcw34vdwgeo6fsixly@msdle5sobc7o>
References: <20250428171931.1850-1-ImanDevel@gmail.com>
 <20250429052444.zfmfzjirkcaq3edh@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429052444.zfmfzjirkcaq3edh@vireshk-i7>

On 25/04/29 10:54AM, Viresh Kumar wrote:
> On 28-04-25, 13:19, Seyediman Seyedarab wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index acf19b004..5464c8487 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1045,11 +1042,17 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
> >  	if (!fattr->store)
> >  		return -EIO;
> >  
> > +	if (fattr == &local_boost)
> > +		cpus_read_lock();
> > +
> >  	down_write(&policy->rwsem);
 
> And please rebase over PM tree's linux-next branch, your patch won't
> apply anymore due to recent changes.
 
Since the new code uses the guard() macro to lock the policy,
I see two possible ways to address this:
 1. Switch to scoped_guard() and manually wrap the local boost case
    in an if block, calling cpus_read_lock() and cpus_read_unlock()
    around the scoped_guard(cpufreq_policy_write, policy) block.

 2. Use DEFINE_GUARD() to create a cpu_hotplug_read guard, but this
    requires introducing an empty struct to satisfy the macro. Feels
    semantically awkward, since there's no actual object being guarded.

Option 1 looks more reasonable to me, because it's more direct and avoids
misusing the guard pattern for something that's not resource-based.

Let me know if you'd prefer the second approach for consistency.

Regards,
Seyediman

