Return-Path: <linux-pm+bounces-16573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85DC9B30CD
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 13:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3ABB23AC0
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA9B1DDA15;
	Mon, 28 Oct 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL0y63KZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3A21DB53A;
	Mon, 28 Oct 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119435; cv=none; b=undA9YNhONiO0v72M26glXiSz3vdjJUGxOxAWi8twZMuDzKPonKUNMU9d2aGF/BtHw6ZjkrscN11H+Y9Yx1RTOvGPWpT8WRS56NLVOqXW/rNmx3UoQ8VZdMdzJy8Atc21qmhGizTerA/nzBF4025f1Pc0bd3rm8+hkgascbe2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119435; c=relaxed/simple;
	bh=PmzRzCwShNmL4Avnj7jpxfgOTY0mlM0j8+YfSm+8k3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wx236uv9Ry/RVjtHQNsHipZF5Oi/Fa/I2qWCIeIxkxHLPcxC1BiB2RbNWi5jI6TIXBultqzXfD4BwJEZSqi1nIJ5cWti6oIBvkqXnSZbVtjo4EEfFw/EXMIXbXD7mfgOSRTFpnSF2+TyyR/1AJu2EwiSPaiurBfXOWcWxkiJUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL0y63KZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052A9C4CEC3;
	Mon, 28 Oct 2024 12:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730119435;
	bh=PmzRzCwShNmL4Avnj7jpxfgOTY0mlM0j8+YfSm+8k3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CL0y63KZWnW5uiINPni9CYwGJpGhLr1fmW9pkIJmQYc0pAWUr9ylHRVLJwS0eG6j7
	 CRSVIEeTilc4kdUSs8LDMoRescbQBC9K7jpSJ9VNf8y9r3wvfBwYVZJVFrnt1P56W7
	 FO08XuKxkM8Ju9UuneHwCTXopZfMVNP101H+MZMYR4kCZY8G7UJwTfxMNSTBXU8eOg
	 XmHU/AiuIgpGeuesyQxYaj9s/f4CEJfQnHuOte2BlIyuWQ5PfVZUi62MLgV/Ozr7Yi
	 nICP1PniuHXy4S4xbSpA35v9W5x8s3FqQJpnRym7feJzYZ2RP466HRc/Mn7CKq2Zi+
	 LRhcLI+GSJ9Wg==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7180e07185bso1861746a34.3;
        Mon, 28 Oct 2024 05:43:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6XUgKdgG6SqE1b3ZRduow27socNnGMXZpnaJANg+7kjW66zDwdMZuimbY9UzWgCYA53cIuSNmo03H@vger.kernel.org, AJvYcCVRrQ4FupE1CbchrFTt/5rOnnoacfBwhIw2haWlMDzvaCB4r51uIqfYO5itgQGSesTlwUmWOaYL32biGLbG@vger.kernel.org, AJvYcCX0y41OeC3T0dm/0aWJLYIIR9z4rGNsV0GLU8sAIKHF6LTLJt4YES5+Cs5qy2hYrPfauznvFnZYpoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSJc4Nm3ZwxjRxIiyxh89M49UcllWFts0hECfP/CT/poOeK/+z
	MdFdIK1kB2A7vDooEkA3dwSm+tSpPYI4lOpFWhVX+dtgp/Fi3u2gzSl2FaFvT/YYfdrmB9Fm29r
	PCnoR4sJLMI8P8xHjxzrdYUoNQ7k=
X-Google-Smtp-Source: AGHT+IGQ9MyGzhtRLH4m8r7Cm5t2pkfk+XvoRhtqYm8hb4hBlseZb94+kKXybee7Jx19YthZkIopo/JaDENPDcdROZ8=
X-Received: by 2002:a05:6870:9507:b0:277:e6f6:b383 with SMTP id
 586e51a60fabf-29051c04017mr6683115fac.24.1730119434391; Mon, 28 Oct 2024
 05:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919000837.1004642-1-davidai@google.com> <20241001092544.2tlydouyyc7jwuja@vireshk-i7>
 <CAGETcx8GomM0znaYKsS412dRvnUQd7_78pKuV82t2b14VBvKVQ@mail.gmail.com>
 <CAJZ5v0iTLX9NAT0PN804QahQ7D=+=D1uJ7PVnZfk5UrpP5uXpg@mail.gmail.com> <Zx-Ek7IbpYNDbG9D@bogus>
In-Reply-To: <Zx-Ek7IbpYNDbG9D@bogus>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 28 Oct 2024 13:43:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iWX6B9hVP4nZKhKJPpO+Fm+ktNHaX1hAhMV_UAPYp33w@mail.gmail.com>
Message-ID: <CAJZ5v0iWX6B9hVP4nZKhKJPpO+Fm+ktNHaX1hAhMV_UAPYp33w@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Improve VM CPUfreq and task placement behavior
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, David Dai <davidai@google.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Quentin Perret <qperret@google.com>, Masami Hiramatsu <mhiramat@google.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Pavan Kondeti <quic_pkondeti@quicinc.com>, 
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 1:33=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Mon, Oct 28, 2024 at 12:39:31PM +0100, Rafael J. Wysocki wrote:
> > On Sat, Oct 26, 2024 at 12:26=E2=80=AFAM Saravana Kannan <saravanak@goo=
gle.com> wrote:
> > >
> > > On Tue, Oct 1, 2024 at 2:25=E2=80=AFAM Viresh Kumar <viresh.kumar@lin=
aro.org> wrote:
> > > >
> > > > On 18-09-24, 17:08, David Dai wrote:
> > > > > Hi,
> > > > >
> > > > > This patch series is a continuation of the talk Saravana gave at =
LPC 2022
> > > > > titled "CPUfreq/sched and VM guest workload problems" [1][2][3]. =
The gist
> > > > > of the talk is that workloads running in a guest VM get terrible =
task
> > > > > placement and CPUfreq behavior when compared to running the same =
workload
> > > > > in the host. Effectively, no EAS(Energy Aware Scheduling) for thr=
eads
> > > > > inside VMs. This would make power and performance terrible just b=
y running
> > > > > the workload in a VM even if we assume there is zero virtualizati=
on
> > > > > overhead.
> > > >
> > > > > David Dai (2):
> > > > >   dt-bindings: cpufreq: add virtual cpufreq device
> > > > >   cpufreq: add virtual-cpufreq driver
> > > > >
> > > > >  .../cpufreq/qemu,virtual-cpufreq.yaml         |  48 +++
> > > > >  drivers/cpufreq/Kconfig                       |  14 +
> > > > >  drivers/cpufreq/Makefile                      |   1 +
> > > > >  drivers/cpufreq/virtual-cpufreq.c             | 333 ++++++++++++=
++++++
> > > > >  include/linux/arch_topology.h                 |   1 +
> > > > >  5 files changed, 397 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/cpufreq/qem=
u,virtual-cpufreq.yaml
> > > > >  create mode 100644 drivers/cpufreq/virtual-cpufreq.c
> > > >
> > > > LGTM.
> > > >
> > > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > >
> > > Rafael/Viresh,
> > >
> > > Nudge... Any chance this will get pulled into 6.12?
> >
> > This is not a fix AFAICS, so 6.12 is out of the question.
> >
> > As for 6.13, Viresh thinks that this change is a good idea (or he
> > wouldn't have ACKed it), so it's up to him.  I'm still not convinced
> > that it will work on x86 or anything that doesn't use DT.
> >
>
> +1, I was about to comment on DT bindings patch, but then I assumed it is
> accepted to have a device object with similar CID and CRS(for register ad=
dress)
> in ACPI for example.

Well, where would the device ID be defined for this?  The spec or
somewhere else?  If the latter, then where again?

> But yes, the patch itself is not adding support for that
> yet. If not is not the way, then we need to come up with a way that works
> for both ACPI and DT.

The DT use case is there I think and so I don't want to block it just
because there is no ACPI counterpart.  It can be added later if the
use case is relevant enough.

