Return-Path: <linux-pm+bounces-32360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4FCB2569C
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 00:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9894A1C28429
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 22:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6B630275D;
	Wed, 13 Aug 2025 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YtagT0no"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1C1302750
	for <linux-pm@vger.kernel.org>; Wed, 13 Aug 2025 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123937; cv=none; b=C0zhdnuqrhlWw8Lf+L+/qMutSQZQkPImEjG28horZI/o7kfLMwNee6hzhJIyD+wHZPUti+gEHHh3OxbVxhgk4lVMmaRVQAwTldm1oHItJwhYQUrytsHIellyur/2K39tup4+L77P8Jaoun4g74atLHVq0HaQViskjrryxO+stqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123937; c=relaxed/simple;
	bh=raUBW/Rwb08ubnoczjUwuWKQXa9m1IdVItor+BrO4Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE7lI0t0DMGF7QRJtSfMfN5gaZolSbuV8ISBH6fmtXZD8DixDVqmcohkAbgyUJrmVbpnSeqA9KOUVD/lqc5apHzZT8Tno7kgDkA6NFKZnW4cY43JPhCFSLXa9/EzcAAoS0fjecL+isefg7BYsTLY+Ruw9396K5DmGygY3d2FXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YtagT0no; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-242d1e9c6b4so80005ad.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Aug 2025 15:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755123935; x=1755728735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=raUBW/Rwb08ubnoczjUwuWKQXa9m1IdVItor+BrO4Qw=;
        b=YtagT0noN2fkCae1O1KpXmUbwK+1MYhT+oqDmqnRKgBBfW5BrfoxuOD3wGN/QBWWE/
         w1myyY7rTo1NMomNpwKrGB+nk7l4rq9Txy8fK1gSOOr/Mc+XiFxHaUtEM440eZB3uMuY
         ysF3M7C/rAw+F9ALH52QcbSAx417Hmzxj7NNxtcmLRXRsDbfObipnnDHggOVT6DXTEgj
         Kfff2N4u/buv/8ddDzuNXJ3MJ6PXBY5nMJDILOtJkw+SODumDqsAwhbxv0aJi/F+OhY+
         ZjnNxgCb+99FpqKYuC8EHEBLUaEoR+b7AKvcb1kfVtKA4ENg7lDTLGFHWNIyh5nD/lw0
         qRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755123935; x=1755728735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raUBW/Rwb08ubnoczjUwuWKQXa9m1IdVItor+BrO4Qw=;
        b=EeRaROaS7oLjEarTvo79ueDjob+S4yvmsVmKC4VTBQtHX3hmql3t2mBXO17rcemQqh
         p9hU+PczUag5SKlOTDlyC8LO4QCISUn98T8lTK4WWm/i9BzYPwrGW1lbemWZnCOH06vr
         9+6MqHWyZf0wWb0p2Eg7UUdmUW219QDtc/GYcbkaT0uTUpnPiuWaW5yPBArj2wNdNVpX
         BVgvi3rnAWRVqQ/0+eZ6HvhbjFQ/ufQXznkgGnZ3dU69unO8QdNpc3N5xNK7M0wC6bYa
         XOPz02N2xcR+E6Z9aVh37I6HDTKgpQIavFZgt0AmkoEPhYwwAs5hv+ZRhZ2qNN/G6sQj
         8umA==
X-Forwarded-Encrypted: i=1; AJvYcCUZw3cLzhVF4piRVXHMxeH/q7oEl8kpJqesUlybXNU0rM9cnk5Be/DbZTi2fXRtNvR8RP0i7LH7bA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlwDx/LW4RiZxrQ1yGxTOe/JTNM9xONeaClN1ORIzrG/jCwjer
	llM/NXSKKkiJbBMx1w6Cu/pFXIADXZzSE5ySoL/17xbnPEnSiLuDfcD/SVpb5YrEjA==
X-Gm-Gg: ASbGncuY0m1d8zeBEdBfT1y8OuayVHNiPiKqDZb7RmOnOj8VOaX0DvtgWxTzSY44OII
	QxG1IzR1UO+IxhTdZ6s87HmKHx1n03ADXavd0u6GyXtFE0fGvVsHy9qKuOypdhiX3CE4A1SRwIM
	VvABvOA37i4QdvWjjezOVEofhOI68pP+C+zJGFGodRpjDijhgJadn1ReHJz+IZ6Wt3JFj3nU8XK
	FW60e/I8Dl2P4YU8GCE29VgO/CwBSCmu2EWIW8/Fen63KYut8VK+EGpPnSfKvi3W2j2ynecokLm
	9rm7P9nD3MQ0QfK3vw25PvDTiMKtEjTmGVKpLdp/8jB+vC4G0KV4svMYNk0idHi79wLaD7t/YLj
	i8QFnoBet98nTCQoEXUKJCAFaZ1YgqqDb7MTXZHRo1I6AP4v40aOOKl4SA4278w==
X-Google-Smtp-Source: AGHT+IG1N03rQpeAx72+yz9CMGd4rX7g1DTxOuQnxcey3VbI1ylZABro6XbAD2gbqzuQi9feBogTOw==
X-Received: by 2002:a17:902:d491:b0:240:86b2:aee0 with SMTP id d9443c01a7336-2445a702649mr286615ad.1.1755123935216;
        Wed, 13 Aug 2025 15:25:35 -0700 (PDT)
Received: from google.com (167.212.233.35.bc.googleusercontent.com. [35.233.212.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232577eb37sm1075365a91.13.2025.08.13.15.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:25:34 -0700 (PDT)
Date: Wed, 13 Aug 2025 22:25:30 +0000
From: Prashant Malani <pmalani@google.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <aJ0Q2uEQ03P9Nuf1@google.com>
References: <aIso4kLtChiQkBjH@arm.com>
 <CAFivqm+kbRbJsJ_Obb4bV6fgxbqAwOndLUCDwHvWWnpMYoNoNw@mail.gmail.com>
 <aIvSe9VtZ-zlYfbQ@arm.com>
 <CAFivqmKR1dqVqTsoznH2-n8cyAM1=5zEGcEvmESU8RNGac-0sA@mail.gmail.com>
 <CAFivqmKgiVEWMQ90Lh6T+Y44E6m4jmdF5sUFfVNTmgVHOMtZsw@mail.gmail.com>
 <aJMCgGt5zu5Dhrd5@arm.com>
 <CAFivqmLSp6RwfsPBK0d=zvRd6M_5GoeU4jHb-0OM9BpaDeSrzA@mail.gmail.com>
 <aJR-4J-sTpLaNIJB@arm.com>
 <aJVdjwU-qkdDIXaD@google.com>
 <aJxlvMFD2hHaKdoK@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJxlvMFD2hHaKdoK@arm.com>

Hi Beata,

On Aug 13 12:15, Beata Michalska wrote:
> Ok, that's not really good.
> Any chances on sharing which platform are you using ?

Unfortunately I can't share that info ATM.
But it's the ARM standard counters in FFH, so it should be reproducible
on any platform that has that configuration for those AMU counters.

> Remote debugging tends to be rather painful.

Totally understand. I really appreciate your patience and help in
figuring this out!

Please LMK if there are any other experiments/patches you'd like me to
try.

BR,

-Prashant

