Return-Path: <linux-pm+bounces-820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96A1809887
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 02:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D07B20A0E
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 01:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E5E110A;
	Fri,  8 Dec 2023 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9thBKFL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDB51706
	for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2023 17:19:04 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c09f4bea8so17091805e9.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Dec 2023 17:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701998342; x=1702603142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYzwSCPqiLl7k8qbCaz0m1NIvdf+DIxXUY3+wg3ee94=;
        b=E9thBKFL18i+pJ5L25jNA6tVkGftyHb3+sNN/BHAu5MicLbZH0Xpc1hYWF4o/aXbUX
         oNlO1TDm3jroN6PodcwQqAeVhHItH2IOFrkGaDzoG1OhRfKZulOtNMsVAbyIoRXwT/Yg
         7SoCeTZvOMWKhVpLn52ot2it0o3pd9p00BzaRmU3rliZMCPmN+Iq2QAUGnDLLrOWJRq4
         ie+brBLyJ8i4rHoDqoqzll9+tEhIZ+/O9GHQs6T6dygsIzAVav5cRg2+whSkDr1y1cLM
         9UwN3VW6hGrigR48VGkM+J2CYQP18eVlfKQEnVrPPQPM3/QtYvM3jb6pJceTNYbQ/ZTn
         FQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701998342; x=1702603142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYzwSCPqiLl7k8qbCaz0m1NIvdf+DIxXUY3+wg3ee94=;
        b=SLflWbrx8hnHgLk/HpZR5LKdck7hb594CTFOzvbSh4LSkUFVtv+GyXT3iC3fQOr5Me
         6VzBw5/w/UIn9fs7+Ut1mkv/zpTSiBKzBiHlo60ZVzMwiA/ks/kYc9ACiE/PzdkfDVoS
         1F59IfmnJc/50hwWkCagvXytjG04ADqpIyHDiIaLeRz/B7s8IuKkOLNKYmdVeiv0SAiq
         a60EWUo+/SAJg2635+nj3LETZqN+XGV2vTI81Ix9VkTu7CWCIHp2DPDISapa1C3x2N4S
         TfdTtQ6ft0AcTy8dulXcWrW+M/UJbZKhYz0D4D2z6rFHNM9opA0sX+Rqj76wHQ5VZn95
         vz8Q==
X-Gm-Message-State: AOJu0Yz0deRTYT9FFOh3oWHz38DU4yAnKxvDuH7xZArQNG9rUwG56SWu
	t4jRCCvUf3OFxRjmLfDWBR5VvqWRp9rOEnQkW3B7zw==
X-Google-Smtp-Source: AGHT+IG+m5ndDrZYwAjGiJo+XbvTuXbn4cv9JA7hIaiio0HiC93zA6LGU2W0vDdt642q9QLDRGH9i6qmYPagNCY64U4=
X-Received: by 2002:a05:600c:246:b0:40b:5e59:da8d with SMTP id
 6-20020a05600c024600b0040b5e59da8dmr2133389wmj.160.1701998342457; Thu, 07 Dec
 2023 17:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111014933.1934562-1-davidai@google.com> <20231111014933.1934562-3-davidai@google.com>
 <20231115062932.vz2tyg6wgux5lx6t@vireshk-i7>
In-Reply-To: <20231115062932.vz2tyg6wgux5lx6t@vireshk-i7>
From: David Dai <davidai@google.com>
Date: Fri, 8 Dec 2023 10:18:51 +0900
Message-ID: <CABN1KCKfCWB6fVAuMSN9AdJOe-zueNMPFUdDnKLcq-uetz2ZFQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] cpufreq: add virtual-cpufreq driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Saravana Kannan <saravanak@google.com>, 
	Quentin Perret <qperret@google.com>, Masami Hiramatsu <mhiramat@google.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Pavan Kondeti <quic_pkondeti@quicinc.com>, 
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

Apologies for the late reply,

On Wed, Nov 15, 2023 at 3:29=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 10-11-23, 17:49, David Dai wrote:
> > diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtua=
l-cpufreq.c
> > +static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *polic=
y)
> > +{
> > +     writel_relaxed(policy->cached_target_freq,
>
> Drivers shouldn't be using the cached_target_freq directly. Use the targe=
t freq
> or index passed from cpufreq core.

We were trying to avoid rounding to frequency table entries to provide
more accurate frequency requests. However, we didn't find any
significant power or performance regressions using the frequencies
from the table, so I'll send another patch series using your
suggestion.

>
> > +static int virt_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> > +{
> > +     topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_VIRT, policy->=
related_cpus);
> > +     kfree(policy->freq_table);
> > +     policy->freq_table =3D NULL;
>
> No need of doing this. Also the order of above two calls is wrong anyway.

Can you clarify this point a bit more? Are you suggesting to just
remove setting policy->freq_table to NULL and swap the ordering
freeing the freq_table vs clearing the topology source? I can
alternatively use dev_pm_opp_free_cpufreq_table to mirror the init.

Thanks,
David

>
> --
> viresh

