Return-Path: <linux-pm+bounces-5269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02298896CD
	for <lists+linux-pm@lfdr.de>; Mon, 25 Mar 2024 09:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A9A4B33AE8
	for <lists+linux-pm@lfdr.de>; Mon, 25 Mar 2024 08:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2B9137779;
	Mon, 25 Mar 2024 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="2Jz0jA0+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C6A21084C
	for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2024 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711334251; cv=none; b=Qn3TvcKv2iuNjKIg456eagQnBvRma+WibHkl86QQP9FgIOPrPCdasWyWlokkBxJbz/klkYulqrmmL0Gl8HezT+2YnzgNYaHgqVXV5i79FuhcsboOITXkXjpj+1zqYD1WuKi9E4zDDuhcqPBRC3dHF4iFeurGPg35jGALvf+Lx4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711334251; c=relaxed/simple;
	bh=CUhu4fcoHxot+obl+L/lIB2mjnnCYJgKXU5JhtEOyz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUm2nDWlgaUD4yqtMoD9hVvgKP/snd5uT8AjtWhVtMAZhi4vtFKwWswD49w/yjp7rSksaRf5gTpRyN7kNMT3VJWgT6Rvnm4vQ/1K6PotZE8yM+EVlIJORtmpd6Y1pMiDNpooiXF/VxbIN2t2/mSMaYmzjMIAZmDqsuk4XEK8D5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=2Jz0jA0+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-341cf77b86bso139279f8f.2
        for <linux-pm@vger.kernel.org>; Sun, 24 Mar 2024 19:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1711334248; x=1711939048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OmGpqFfHYwDGnVVZ3jzAGoFdzesxBNnjTqhjXueHYVY=;
        b=2Jz0jA0+gY0hPyGeZZI/SS29mN7sv/9v/HpfhXgWqXrc9xBobiybpkROmw1LG7IR6n
         SD07nDUS2Nu1c8sz/xv+BGN8p9T9xHQLUZd5p0WVk8MOb6hJvau5X8rd2I0T5BenOE+U
         yedEE1zb2ySqyWfEPZlOfoAyZV5Wh3/MoOLmRNnfVb6lZpD3UMeIRj6JY3ZlTiaOeO6v
         GROdaPeZVy4uCnbht1zSMf9RKkSXPxkkWm503kszhbMEkS7oT6qH7VUFO66YxFLOR4Gb
         ELbzWQ+3C28ehNmvr+GwfFsPPhnkQOVVe/qZ9intuoj33pShgVlyIhXq2+E59QbtOnfc
         //7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711334248; x=1711939048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmGpqFfHYwDGnVVZ3jzAGoFdzesxBNnjTqhjXueHYVY=;
        b=npHBzlMNjmDwYxhQd8lZD3RZauOeogEfF1GcErktEFWoDLlr8K+8xaw0gRp/yujLH9
         K5gSi0iiyB1LPcJaGkGPrpluNAwalnXCK9MkbG3spvZ4I+ZZnKlHPoXqOyZCbSK8AOGR
         v5f7YKwa3T5Nj08qNm9bl3EgCr36/o7HwO7xcwEBSKoTEkreuSTFQzWGpc1QWsANsOw+
         ac62OT/78SFdg6tscjkDZwPr3JNpsOOQdCIAPb+HqcmZFf4qfmF4ntfG1GZjqFgaDUQL
         3a4hbjpe7KcCxdy7B0FwDR41YgE+7P831tNtT9E62xh6vJvfHs/ULPDMHjLFgrb1ysUJ
         qEtw==
X-Forwarded-Encrypted: i=1; AJvYcCUuhnx5e+u69pge3MUryZ6FUt47ObXYAcNoddjkBkYFKGJX3lNVShKuPhegRBE7QBSZo7z/3a29infVhV3Jolaa8PV7ieJ2YZI=
X-Gm-Message-State: AOJu0YzQZ+fncKAau62G2Tp1E+g97H9o0mHVeTRl5DSF63ht+H9kSOIN
	GEPIQBb6plGc4S6hpkyTBFwRRo5T8sePq7BjcD1VwrTE/DSmbn8J77WWAU8Sg5k=
X-Google-Smtp-Source: AGHT+IEjg0Dx2wC73NkBfmUP1gPclrGptZkf2D1z3neuXuajn9j5XqsQLarLqd/JDV0rW21mR1/m4A==
X-Received: by 2002:a05:6000:1d85:b0:341:c9d1:eae5 with SMTP id bk5-20020a0560001d8500b00341c9d1eae5mr2379711wrb.27.1711334248259;
        Sun, 24 Mar 2024 19:37:28 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ck19-20020a5d5e93000000b00341c6440c36sm3898009wrb.74.2024.03.24.19.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 19:37:27 -0700 (PDT)
Date: Mon, 25 Mar 2024 02:37:26 +0000
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	juri.lelli@redhat.com, mingo@redhat.com, dietmar.eggemann@arm.com,
	vschneid@redhat.com, vincent.guittot@linaro.org,
	Johannes.Thumshirn@wdc.com, adrian.hunter@intel.com,
	ulf.hansson@linaro.org, andres@anarazel.de, asml.silence@gmail.com,
	linux-pm@vger.kernel.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] cpufreq/schedutil: Remove iowait boost
Message-ID: <20240325023726.itkhlg66uo5kbljx@airbuntu>
References: <20240304201625.100619-1-christian.loehle@arm.com>
 <20240304201625.100619-3-christian.loehle@arm.com>
 <CAJZ5v0gMni0QJTBJXoVOav=kOtQ9W--NyXAgq+dXA+m-bciG8w@mail.gmail.com>
 <5060c335-e90a-430f-bca5-c0ee46a49249@arm.com>
 <CAJZ5v0janPrWRkjcLkFeP9gmTC-nVRF-NQCh6CTET6ENy-_knQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0janPrWRkjcLkFeP9gmTC-nVRF-NQCh6CTET6ENy-_knQ@mail.gmail.com>

On 03/18/24 18:08, Rafael J. Wysocki wrote:
> On Mon, Mar 18, 2024 at 5:40 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 18/03/2024 14:07, Rafael J. Wysocki wrote:
> > > On Mon, Mar 4, 2024 at 9:17 PM Christian Loehle
> > > <christian.loehle@arm.com> wrote:
> > >>
> > >> The previous commit provides a new cpu_util_cfs_boost_io interface for
> > >> schedutil which uses the io boosted utilization of the per-task
> > >> tracking strategy. Schedutil iowait boosting is therefore no longer
> > >> necessary so remove it.
> > >
> > > I'm wondering about the cases when schedutil is used without EAS.
> > >
> > > Are they still going to be handled as before after this change?
> >
> > Well they should still get boosted (under the new conditions) and according
> > to my tests that does work.
> 
> OK
> 
> > Anything in particular you're worried about?
> 
> It is not particularly clear to me how exactly the boost is taken into
> account without EAS.
> 
> > So in terms of throughput I see similar results with EAS and CAS+sugov.
> > I'm happy including numbers in the cover letter for future versions, too.
> > So far my intuition was that nobody would care enough to include them
> > (as long as it generally still works).
> 
> Well, IMV clear understanding of the changes is more important.

I think the major thing we need to be careful about is the behavior when the
task is sleeping. I think the boosting will be removed when the task is
dequeued and I can bet there will be systems out there where the BLOCK softirq
being boosted when the task is sleeping will matter.

FWIW I do have an implementation for per-task iowait boost where I went a step
further and converted intel_pstate too and like Christian didn't notice
a regression. But I am not sure (rather don't think) I triggered this use case.
I can't tell when the systems truly have per-cpu cpufreq control or just appear
so and they are actually shared but not visible at linux level.

