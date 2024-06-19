Return-Path: <linux-pm+bounces-9630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BFD90F738
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 21:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2BFB22EDB
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 19:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E34B158D60;
	Wed, 19 Jun 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaJYpcmR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93921876;
	Wed, 19 Jun 2024 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718826798; cv=none; b=o4t4u/HO+0bZcAIAxu73YKtNvugoB1Jy6YXhYl5TlPLRRX2Rm4jVQT9uk33BHaqYuTYm2nDorsqHBZmo+r2S8HfGRAewZJOvprtMP9MYjDvzMAtCgkgyycigjQx/j1EbDkYXwwNATaQZL2yThjqeGURZMjTRDF0S5lCD01hRIsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718826798; c=relaxed/simple;
	bh=A0XJ3zxj2pli2ZWa4qkl9gsTqQ108uDa4Q9wpZWBNK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMvZ4TbCqgm2KbO1CekqWItKv8XSHw1mE5yg7fjsl0NnAOi2GNh9iJagH05kUJKa4XKbifwd8c/qU/hV3PJjy8DoWhIdGjRAwZeanw7dKWnc9DkbSXgy9B9jwpUSxqWlXnG+BJ4mgaf0gw+q+2L3mMyYaEZROBMPL4+Z/9qot7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaJYpcmR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f47f07acd3so1120165ad.0;
        Wed, 19 Jun 2024 12:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718826796; x=1719431596; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOB2A/jK1WHukX2KwddAtG4INsdzOOkmUA4oas+nXS0=;
        b=PaJYpcmRMs9p4eTy1WBwim0QaqlK3JLf8uYPalb+j4lmdCif+CAgLGd5TK3p6Vo+cs
         25O6kGTRvo9DK+oUnpyo2ZCKLm7L6qVF8WooBRjZ782fnisMsNzEZX9VD+ekZCB/Xwbn
         ISUTelvi+1ehfVlf52SBOKXkmVxJUOSj9kEMasZIziT5ioZ+RGlI4DMpYi8jNYQjcjr0
         dVMWtudCur0GriEU5AZdNFFi8//x+POBjdLVlvMguzKLL5rfH8bFKnXRrhGYI7Bjjp3k
         GsTzfs+2IO6ufEu6eQTmWLpYR26qdbEbZ8dXRaY+2cMYbYmWhR6nqyMwQw36n2MR8nrN
         W0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718826796; x=1719431596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOB2A/jK1WHukX2KwddAtG4INsdzOOkmUA4oas+nXS0=;
        b=saBz38A2K83YWcSGVaECgQcr48pthKvseDu1b1qa1fcM841Q7wb8Hr3IJ9nZuFY6NZ
         TwMd1/lhJ70tQuS8nZY69klTri3Nfp+k2RYY4WV2eRH4iTKlkX9azWVHOcM0sYt8C/Iq
         y+9OK4rVs9zLlPTkdrmPIWRAHOcatEYS43JcGIwmQa5RJ1N6Uv5oLcc4nNxQv0A2rvE9
         4u75MBa2hefhyTLFpGrAZ2MC542Su6/oDwiFN1RC/Emawnv1+XS/7rGRIQB2WSxOCnYj
         aMvvvVe5BYh0QYy6DrPcfsyrX5l02Ei+3IjX8DQGkwN2z6AQymDGJCGb6dnnjVnQdspg
         xGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK0h/NxpydzXrbMe3CrPm342PY7xxkmB3GuBcRVuWfADPqJXBmtNx4kPPdolMGDTvmcw98w4oNIgNo0BPisbMOnouIMNRHoG07Fqm6/YZbzt1l3qv0jnMdW4Ui14+P4iBhI0jy4YI=
X-Gm-Message-State: AOJu0Yw+IcTqPvAjJyPH6/jhwigoTIgE4NjQg4BNI9qmXhJceUeUQt9M
	gJeUOdK/mqiyL7nSsH9iWCBg5QC6XVCdW3LUKIPr0CJxU0RjvrHU
X-Google-Smtp-Source: AGHT+IHUBrhZZvtm6NcZr3vDMxebVh3Q4znsEMqbwmVJ447+3TCtJmTTgB/qWpr3PsAWEqL0rQfLIw==
X-Received: by 2002:a17:902:f685:b0:1f9:b5b7:a482 with SMTP id d9443c01a7336-1f9b5b7a9cdmr22081875ad.24.1718826795861;
        Wed, 19 Jun 2024 12:53:15 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f339fbsm120933395ad.262.2024.06.19.12.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 12:53:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 19 Jun 2024 09:53:11 -1000
From: Tejun Heo <tj@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, void@manifault.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] cpufreq_schedutil: Refactor sugov_cpu_is_busy()
Message-ID: <ZnM3J7pvg6fyksby@slm.duckdns.org>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-2-tj@kernel.org>
 <CAJZ5v0i=0QqkvjA9mnqcX6Yv-T+rQ7ZKvuF1HPJL8pG2kqicGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i=0QqkvjA9mnqcX6Yv-T+rQ7ZKvuF1HPJL8pG2kqicGQ@mail.gmail.com>

Hello, Rafael.

On Wed, Jun 19, 2024 at 08:45:42PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 19, 2024 at 5:13 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > sugov_cpu_is_busy() is used to avoid decreasing performance level while the
> > CPU is busy and called by sugov_update_single_freq() and
> > sugov_update_single_perf(). Both callers repeat the same pattern to first
> > test for uclamp and then the business. Let's refactor so that the tests
> > aren't repeated.
> >
> > The new helper is named sugov_hold_freq() and tests both the uclamp
> > exception and CPU business. No functional changes. This will make adding
> > more exception conditions easier.
> >
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Reviewed-by: David Vernet <dvernet@meta.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> for this particular change.

If the cpufreq_schedutil part of the second patch looks good to you, would
it be okay to route together with this patch through the sched_ext tree?

Thanks.

-- 
tejun

