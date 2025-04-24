Return-Path: <linux-pm+bounces-26096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E0BA9A3F6
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 09:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5010D3BF4F4
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 07:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6E121B183;
	Thu, 24 Apr 2025 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eciZ3AKC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9401F4703
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479653; cv=none; b=hW/mO2t2HP/D230NZVK1QJPMb4hfXvx8s+hVQyw/8Ie4AA9Xi5+bc2vw7UhKtI1MBr9B1JwXz8W7RBNdwjDQzA+inlJmle0YEuEzJ5zRqdnfTWF7gilfUwmQeiIK2qWS+kfyV84Eaf7ZzDZdlca3DQrXVYsHPHZWUwdlzuoNX5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479653; c=relaxed/simple;
	bh=nfS/x7gU72+XZ/1UFNxd1HLffHl8y6g5SuxZxkDA59U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNNXIzhAbfAGSpDu1J1lRr/qQK1nghTeOhDqBZXi5R0aI1eOcGPl2FOPdKrevkDsEyeMmKSihxR3/raGO2EqwT1DLUhAAD5VTvqv7cDibIzgD+ulDl2OitAjP1zn0HUpPZ27CP8FMSHwQenRuDck8eiZ33cS+cPYfJlNe94eCoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eciZ3AKC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7396f13b750so708913b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 00:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745479651; x=1746084451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xc6Bs3X2UGLyK7xuUxebVRwe8Yuv6ialkBolRwEEth4=;
        b=eciZ3AKCZNi9nydQQXX83dFrc//SczevNhjo4Pc3xh09twTwV69V1kZz7M9fd6wHzm
         76CYlDppAdBNJJOnGZr1CISUzcjBvdNYEhRheFR1Gb4yVXFWjJhufVi9TRdUzE96LWYU
         3oBYfO5ZSDrsKs9r+b4QlBzxLloWuJOoD9q6jc4+1KfoDcbep/tS0tVWccoh/r+A17Bn
         Cg5JjZ4HvHsY7j/ldA1H+xwYj8ZY1CA7kMD/df2xFInmX0oBmtFdydyHcVojgx2FKg9C
         34ZKtNKpPubD6KFEYhfR++s/3C8OAxUKLFIOkMZkXGdSt+CFz8dHpM0ErzMc2zXqXov3
         rjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479651; x=1746084451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xc6Bs3X2UGLyK7xuUxebVRwe8Yuv6ialkBolRwEEth4=;
        b=rbIwaNnYVfMtrGaHs30VmqPvPfNysjFyJk1QXSLBDyPRBkb//QRNeynJBT3k9q9MQg
         CtKTH02qrEQ/yjQYCJyM4UFPXCSZZ3HicB1dJ/INjXO+vIYgmHxybOQlE75hFQwUP7l0
         6mvMqDcUnG/SrcG5Wx8gF0t5cyQGiIJunbjUofpMojTEesy8CulJyMimorId8J+b/UpU
         yMs88FpNV7mL1JsdSo6r+ArHbvLB8UJfW7VmLtyBR6dGrfILAq8wxMvuvKy9+KtiiWB0
         yiwkG0uEwDXJO5PdM3ii0BQMZCElzV7NGjtYCpOl9TgzTD7wQXWz4b+ld/VbgMUjx8Rv
         qMkg==
X-Forwarded-Encrypted: i=1; AJvYcCWbwgg5UcdQNecRljJupm+EiPbLJzutV17fGKdyjOVffPq4/I4V7DW5CI1TQZoYEbEPRZCbja53/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKbW9RI7ecB+cL/K8yDuyLscPGE+aEa65SU0U1yWZxsTbQWF6c
	YgI2VKkvkFXMP8vaErgPLVCnNwQgV6B+8v+IDMM5JfsgHa1j0rXxqCMRYEgNoDA=
X-Gm-Gg: ASbGncsLZEZQ4j9MpP7FOdOQ9BvQsobsmwFMixCWjf1G6XvN8DiVOmYE5uoJUYLux42
	7QxX1f4OTUFs9Ij5bwGWaR0WJDePS/UkxK0KFD3reFmRsauJkGrP1u7nnFpQ/zKNKrOknm2DhNT
	VLFsPt7HUxQpYPnfu/Xa+Afl/dUEHW6UDtf2621zkjSoyzd8Ju0eby2u00XYG5r+ksYHZk7/ZRG
	OqlAahY+0IVRwFgASfhqu9xPjMYk6wJtvok82Orcx/TQBc+Gaw6b7SWjppx+h9p8PcrDWwKjzm3
	JUGo798dsC84Pet5lY18RUcXswTrj7tSL/QK46tYCUYqZLlzkT1l
X-Google-Smtp-Source: AGHT+IFfO2QBFWIVhr5m1hx0gDzPpYf2exm/10n5qGHZbkS4yQ7Df4uixIbTqJipsI6JMV03ToC3DA==
X-Received: by 2002:a05:6a00:391d:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-73e247d74cfmr2285546b3a.19.1745479650864;
        Thu, 24 Apr 2025 00:27:30 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9a0e5sm751557b3a.132.2025.04.24.00.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:27:30 -0700 (PDT)
Date: Thu, 24 Apr 2025 12:57:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nicholas Chin <nic.c3.14@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] cpufreq: acpi: Re-sync CPU boost state on system
 resume
Message-ID: <20250424072728.bbcbbcxv7x4cumck@vireshk-i7>
References: <cover.1745315548.git.viresh.kumar@linaro.org>
 <d8651db6d8687a0e37d527267ebfec05f209b1b7.1745315548.git.viresh.kumar@linaro.org>
 <CAJZ5v0hWUdRdbPL2=qybaEsNfPzAqdxW+xBrjwy4HaBXnTwD0g@mail.gmail.com>
 <CAJZ5v0jFy9ch4ZcW_zQs6GfvB=LCnzm94d35ifMpdv=VrqTHQA@mail.gmail.com>
 <CAJZ5v0jenM_pYUkTv-qPV21tok15R+KfT497itPO=fLUywDKqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jenM_pYUkTv-qPV21tok15R+KfT497itPO=fLUywDKqw@mail.gmail.com>

On 23-04-25, 16:59, Rafael J. Wysocki wrote:
> On Wed, Apr 23, 2025 at 4:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > IIUC policy->boost_enabled is false at this point, so say that
> > > boost_state(cpu) returns true and say cpufreq_boost_enabled() returns
> > > false.
> >
> > This cannot happen for CPU 0 because of acpi_cpufreq_boost_init() ->

Right.

> > > cpufreq_online() will see policy->boost_enabled ==
> > > cpufreq_boost_enabled(), so it won't do anything regarding boost, and
> > > say that this happens for all online CPUs.
> >
> > -> so if boost_state(0) returns true, policy->boost_enabled will be
> > set for all policies to start with due to the code in
> > cpufreq_online(), but this is far from obvious.

> > I would at least say in the changelog that set_boost() need not be
> > called directly at the policy initialization time because of the
> > above.

Sure.

> I also think that acpi_cpufreq_resume() may be a better place for
> re-syncing the boost state with policy->boost_enabled because it may
> do that for CPU 0 as well as for the non-boot CPUs.

I thought about that but kept this in acpi_cpufreq_cpu_init() as there
are other corner cases too. A simple CPU hotplug (without
suspend/resume) for example. In that case exit/init will get called
but not resume.

-- 
viresh

