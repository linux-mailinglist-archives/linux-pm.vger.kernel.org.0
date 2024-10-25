Return-Path: <linux-pm+bounces-16489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04FD9B128B
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 00:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60591C21AE9
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 22:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240E420F3D3;
	Fri, 25 Oct 2024 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W0QcgkVS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430241C878B
	for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2024 22:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895162; cv=none; b=LZZKS8DzRchyGC+IxPjW1YuVCdFLgh+/VRgjtmGlFXM5NJsFopI8jr0PYTIuXUuyJIMMYD/hYHCm3PbeR1hO1le+OdRe/j4xjToZQy4f2g34FGiTSvUqCJGhGFpqulf0uljlSMf6ZkLpPosC/qzjfoRVFSN9lKVgKSOjDoz3FNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895162; c=relaxed/simple;
	bh=iEHk5Ta4phb4cptYASkNbTGv77etjCbTBmGJXO0C01s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbgT+KK4dMWVTIu3pyHcZ0iWEhfaA15FgTJu4cqp0ALQvx0kWAdgrIf7Vk7yfZn/u171fpLip+2vm5gaRYW0GffaL9vsGTxQKossFzEhWLKd0WtYerSxT7z3xa5msrNDV8UUz7gNlpWA6bBP5H6gn/nETjSPe8JcW/BTAb+JW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W0QcgkVS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7203c431f93so1989567b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2024 15:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729895159; x=1730499959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwRrmapI/txMqNn3ixRKI9VZY2NYrfTNrvsL9ny9Phg=;
        b=W0QcgkVSi8/qpFLW3pZr6Ne4c6tRLW8I2ydGmT0Il26vI7FDRV8VFlpIsSnOyiMu+I
         zDIsf3YY+wGqWuOZGCXoAYK3keoiLRvR2E3Bnp3Qegw6d6bRNJReEFMFl5sksy9E1VLJ
         SVfCzFbdejFH1uK0+dBv8FkHKUTt/8an1ZqOwgTr7Abq1LX16mNCAIFA6afT9bVy0f9u
         W0vj0t/BgB0G3QmFkwFsZTwu8+iyy+7uHdwF4JR2bBe/DRE6bnyFK+c8Uz9lBcINNCpG
         uzgBf/Doc4NIWxxvUd2RM66ovQC7JHfkxdAU9qHiebx6843Ok7GL2WrMvkMOatsOlRnY
         lU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729895159; x=1730499959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwRrmapI/txMqNn3ixRKI9VZY2NYrfTNrvsL9ny9Phg=;
        b=haaSoFAfBFo6cbhOZTpdgVXxlI/LBJ3/71bDqo74p4tDwknVKlT/1o9o2ZrS8rYjjG
         bKZHG3aSRBtIv/P1M9uMDfJFEDjuR5b6XoX4csXAF5FBquFdAf72wEUxNiWNaN/TX4Hg
         RpSUh1NatYcdUe4VMMWUCcnpdriWH5NnMIg3pz0nhBa8A67EpfSGItaWzMDAqArPLier
         z1PCwCIie3gXcrLkZZELLgHlXZIDdAtekavJR+WFYbVZQj7z6f/LAi+1gVuCZESYBBhb
         l6PkugsW1Rl9HOoBx4rSWuBObTGtM7lXDVHBQlcHvwZS7eq8Hc65F3texyM9aVD8Otxm
         oA3w==
X-Forwarded-Encrypted: i=1; AJvYcCUIvOMwgymlce7MoL4Umenind2jiHdHP6+m76JEcrhxc5YfPYrPZaHiHXwHcLTLYnpuAuV5izKmfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YynJV8OvqLUSvZnCCjINE8hDVe+JzX/Y0r/tyUGKiiF7m3hn/pM
	Fp7W6f3/RFkEyA/rUcxAAuN6JQ5iikOGVNZQUurXlqHVh4f+irNlg83gtZx+55BNDdM3CcvNc8h
	SB0RaPksH24YhPFcZXAx1er0X3dOLY8Db5A0H
X-Google-Smtp-Source: AGHT+IGX8MDtucdFqCHFcQA61gmD7H5jVN4y1wegzvDHItkpHjN6au3Qg7GBheJFWL49G4c5etcrSDOh0YRCUmkszFU=
X-Received: by 2002:a05:6a00:3d4f:b0:71e:581f:7d7e with SMTP id
 d2e1a72fcca58-72062fd92c4mr1505841b3a.15.1729895159155; Fri, 25 Oct 2024
 15:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919000837.1004642-1-davidai@google.com> <20241001092544.2tlydouyyc7jwuja@vireshk-i7>
In-Reply-To: <20241001092544.2tlydouyyc7jwuja@vireshk-i7>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 25 Oct 2024 15:25:19 -0700
Message-ID: <CAGETcx8GomM0znaYKsS412dRvnUQd7_78pKuV82t2b14VBvKVQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Improve VM CPUfreq and task placement behavior
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: David Dai <davidai@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Quentin Perret <qperret@google.com>, 
	Masami Hiramatsu <mhiramat@google.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Pavan Kondeti <quic_pkondeti@quicinc.com>, 
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 2:25=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 18-09-24, 17:08, David Dai wrote:
> > Hi,
> >
> > This patch series is a continuation of the talk Saravana gave at LPC 20=
22
> > titled "CPUfreq/sched and VM guest workload problems" [1][2][3]. The gi=
st
> > of the talk is that workloads running in a guest VM get terrible task
> > placement and CPUfreq behavior when compared to running the same worklo=
ad
> > in the host. Effectively, no EAS(Energy Aware Scheduling) for threads
> > inside VMs. This would make power and performance terrible just by runn=
ing
> > the workload in a VM even if we assume there is zero virtualization
> > overhead.
>
> > David Dai (2):
> >   dt-bindings: cpufreq: add virtual cpufreq device
> >   cpufreq: add virtual-cpufreq driver
> >
> >  .../cpufreq/qemu,virtual-cpufreq.yaml         |  48 +++
> >  drivers/cpufreq/Kconfig                       |  14 +
> >  drivers/cpufreq/Makefile                      |   1 +
> >  drivers/cpufreq/virtual-cpufreq.c             | 333 ++++++++++++++++++
> >  include/linux/arch_topology.h                 |   1 +
> >  5 files changed, 397 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,virt=
ual-cpufreq.yaml
> >  create mode 100644 drivers/cpufreq/virtual-cpufreq.c
>
> LGTM.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Rafael/Viresh,

Nudge... Any chance this will get pulled into 6.12?

Thanks,
Saravana

