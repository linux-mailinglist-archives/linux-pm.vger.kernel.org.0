Return-Path: <linux-pm+bounces-19403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2139D9F5DBB
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 05:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CAD164EAF
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 04:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEE314A4F0;
	Wed, 18 Dec 2024 04:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVw2j0pH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E848146D57
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 04:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734495092; cv=none; b=B2tkixPlP73+VSr/59rfkCH1jldtYqRPfCDsTN/2nGYA54CMCeewNeLT60fbSmrJsDhJA7hojIOcbWe32TPMUwzdUN0WtTaX/CXil4ueitGiZvLaYFsp/q4YtJJLmzBnMzhob3X3r1UMmKCTZ4wnyqT6rjOjCGOU/L9kHnAziTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734495092; c=relaxed/simple;
	bh=YYhNaD2Yr+jchoTk8EiKLQl+e7xsWcAkGDWERN9QZc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fls+8XkOIjhZG2Hj8ahun1Rd1X6iMjIenrWAo9qn6+CTFZaGE0UoYOI0AU9Zq75h6j1kxEfXtMgqcQe+MRmwog4uZ1E0vUxX5tyq95AbUpN2CXDXLb0Y3ydr1FPnvH4Snbd0bcRfZOEkSeK/lJIZeYsI6AcePT7gF/WJXJtuMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nVw2j0pH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-728f28744c5so5610804b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2024 20:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734495090; x=1735099890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=anbuEbZW8yvbXFC35C2SRwfKrlOPlxSRe3Xsz2o+b10=;
        b=nVw2j0pHUy/oCN6CtZy6qD5plO9b1mbjkV2wGF+GOHEjkEsI9mkOJuE1V52uyi9zIb
         auCDyuWnVn/nd1YIElq6JbwI5mmJkRmq5rqq0H0yPDhZJRyrdbJUBDf5nWNzyGdgCl8N
         fCpW3jz6DLfUA1w1oLQ9mb3qAX7/llR3nekx+tDbXHGevKc03Z7i1c/fIVTQvHXv1tzO
         djtwdA2gtNetHonTBw+FZ8JVRkoHVRT7vNxuYRhy1Xr3TCzbkUGAjI3WbBA1zuO6POe+
         fhHGo5b9UhbjwK/V70OsvjCaNK8B0PyU4GJXJ2q/vHj/J/am8hjH+HRwr6lV9OKTdt2t
         i8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734495090; x=1735099890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anbuEbZW8yvbXFC35C2SRwfKrlOPlxSRe3Xsz2o+b10=;
        b=i6d3zc9QBVuCMfpO34RX8SrmN41Qx+Y+dgRRjVyZEJ20tZDjVT5THJN0cykx0tGgeH
         0YIJL0XZZ6oFDZS2nt8tIIiBU3PvToPR/kWfvtEnMO52sTE9Fj7qPcynWKXZjznLyGqd
         UebOXwBOkc9nf7N56OB3B9TOwNLO8ATbOUYtqU+aHMD/piXnsUiKAzKUNAncGErNgvEM
         YDnCbDFSUUa1+i8aIqqbYvpB9s9wnEGMe+31nob+WtpIslvHrPJwkf2bLFLOoeRSso6U
         mQZWCFHBWL4ZsGolPYDjmzJh7dWDFN9/tZAOiUNPgW9HZy3LxqyFSU3TfZKI3CSviwKX
         vKzg==
X-Forwarded-Encrypted: i=1; AJvYcCVWJv7W0eLVK7c+nRzTmZgJ/JRDUW0T3Zbqx9ByA6p1Kkv0ej7Ppj19THhPrnK9fbPfHotbOHMxGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrCcMM92SX8ztB9vdDd4eFv3EaXPLm3LVAWgqzykvzoejWhmTW
	D+1YSEel9h5rlgpAvAv0SJvkdFGMj2v/zQxNBiaa5p7caRP05snxAy1aUEDlGiw=
X-Gm-Gg: ASbGncuPzRNv0O4SbJlh8/NETg0evsjpBwBAzqrcjTUjhLQkEpaWIP++kWMF5B80ASm
	V4nU12u4ZwxW026u2/wr2TJQRBAqbyvO3thROJiQ+RoXo9+UE1CGz81raOKj9J3JjNBI0bJ5k/e
	vz0OFsW9W+Jc7d26VqBtPopMXo3HQ0Kka+XmprJDDRxfzszTStmASUFVABfacEOePVtfifqv2ai
	EOUWOjLkUUJcZYy+vfdaAyyxnQQyw2ONaX830ZUYAkp5cxo0koTcSQHFBk=
X-Google-Smtp-Source: AGHT+IG4sPsc/N7IOp43iXXeKOWo6JJJXd9zgTWOHLq4CFq7GSx+SKJhvF92c9uFAmfB0bNzPUQSSg==
X-Received: by 2002:a05:6a00:2191:b0:725:e5a7:fdac with SMTP id d2e1a72fcca58-72a8d2eedb6mr2614606b3a.26.1734495090289;
        Tue, 17 Dec 2024 20:11:30 -0800 (PST)
Received: from localhost ([122.172.83.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72a9d3e94f2sm76959b3a.199.2024.12.17.20.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 20:11:29 -0800 (PST)
Date: Wed, 18 Dec 2024 09:41:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Phil Auld <pauld@redhat.com>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
Message-ID: <20241218041127.khdwo3hzmywcwuh5@vireshk-i7>
References: <20241206135600.4083965-1-beata.michalska@arm.com>
 <20241206135600.4083965-2-beata.michalska@arm.com>
 <20241212065100.sjb7lrlmksbm2hdk@vireshk-i7>
 <Z2CmcelSy89NULtz@arm.com>
 <20241217042726.isllh5bulpnwql7i@vireshk-i7>
 <Z2Haw_o8gF-Ce1gx@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2Haw_o8gF-Ce1gx@arm.com>

On 17-12-24, 21:10, Beata Michalska wrote:
> On Tue, Dec 17, 2024 at 09:57:26AM +0530, Viresh Kumar wrote:
> > On 16-12-24, 23:15, Beata Michalska wrote:
> > > My bad as I must have misinterpreted that message. Although I am not entirely
> > > sure why this might be unacceptable as it is not such uncommon approach to use
> > > signed int space to cover both: expected positive value as well as potential
> > > error code case failure.
> > 
> > This part is fine. The problem is with handling frequency here. Signed int can
> > capture up to 2 GHz of freq, where as unsigned int can capture up to 4 GHz and
> > so we would really like to keep it at 4 GHz..
> Right, though the arch_freq_get_on_cpu operates on kHz values.

Hmm.. Missed that.

If you still want to keep it, make that change in a separate patch and
the new sysfs entry in a different one, so related people can easily
review.

-- 
viresh

