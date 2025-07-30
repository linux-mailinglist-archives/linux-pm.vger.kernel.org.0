Return-Path: <linux-pm+bounces-31643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B4BB16917
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 00:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B5A167178
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 22:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C914522D9ED;
	Wed, 30 Jul 2025 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSSTxRp6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26122222D8
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753914901; cv=none; b=vAJECUnFkXZrDn58/+9O44SajS7WBOinBHSsTES9BBFngN4eUAwaHV82gauc2LlQGuxuHTBVp7yfyMp5Y6A1EOQWiCDCWG0o7uo5J+XwK/0oP9QWfAxQeevvxiSIlahLly3CmRUJSauQ4JhFpjQiv9mZ+VIL4R64Z/547WLIDVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753914901; c=relaxed/simple;
	bh=2fk7Lmp7GQcfI+scgJXRMAuE5War32ra1deNa9zkIDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JE+IqhIz2xOgD17GcUe9SC8rrWtW8XEsXU3jKO5oTPC+99B7232oxBv1cACcwUCgMGIAHRMNB/7Xf789T6K0en/W7+13vyNu8i/gdrWE/7wS92uEbXhSoV7dzN4BjU3vDG/fimps7AGboVEs41YjatLYavSLQzAewhlsLKc2WwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PSSTxRp6; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab86a29c98so104131cf.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753914899; x=1754519699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8kQ4bfCiQxnkckR4mjXN6hX/e097lJxxAb3MZbkRgNM=;
        b=PSSTxRp6bqR/onUSru6WYLD3dDC2gqK/nr460IeC6lq7FiAm9ScsljRYE7j3ChhFYa
         ybMMnFA9lgzTYoOy38/TlIYSoWSHXNfVTjiVVzUPJuJEeLLEbePZHzfUZBXRB6RkM2qT
         kkTBvm8WJl2jAGmwt3YQtwoClRTy43jc4fblyUgv1DtFx2BVaFAtXHUjqIevXQXUSX53
         foR6sPL4ArTUCns6/Ddn74pcZ/2r/IAWD4vtNNz7SEEbZg4tpefZyW1UN54IPmEAkMM1
         6KIA5TXu5Ri8UouGlNnph3qhg18UUjCeijiJAJyYKFCGjBtWXOX7tyFdL1oAWVhgHNVz
         CO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753914899; x=1754519699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kQ4bfCiQxnkckR4mjXN6hX/e097lJxxAb3MZbkRgNM=;
        b=l3PnDOGEcmt0nNSTan0cBuw42xe1+RrEv5MNeLCJNmn5eCc4UC2WL/vGVcclRbvDcp
         xQjSABMXo8SGcB9sW+6JZxlfSEtbPDA+q9IquvTQWolObemvyz4ZtXQZROMZaV0+LlgN
         /BUxp2s0sllUGwMI63eJrbsKFdjB4nNIuDwdla63qqAPAGmnFlHl1kOWduR/rtY08t9K
         zbGyXdPTKQmBXES9rd27jI1fqgjKuJDzzHeaDYXi6wT1ZUTw0bwOSSgDShz79nN7e/JB
         Fh76Z8OlQvtl1sehqmWbaxoQKx3WgYy9xWXa52qOs7ZN8cnLpfDoETXOsMshgJlGUSet
         eCBw==
X-Forwarded-Encrypted: i=1; AJvYcCXnsn4GfQ9pCvyBLZMuHynBFY7QmmfyUfOusBTgl17N3bVnd6ENGNKYiftDbgN0bYIyCPzz3+dX3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYHbWhkdZ/SOb1F1bVCE7MVamEfEHdaJEtzZAKOHSSs1zwxe7s
	6c0zYHxO2QBTMLy3uulIYTsMuPRGD+qxkaBQ3X05I22lIbDjMrc4PoA1jTXP2v2LdiPS7nuqryt
	+80yGgRJkzyl4wEIGWcg7h5XthQefgPzGtEocgIGC
X-Gm-Gg: ASbGncvxBHTseqOh2af5kkXlb4OSlPHHGfWshzLvAPrdH3LmdRDhFB8Y2WUKHmajX0k
	+vV0TDl+4w0N2D+/ujEYT6OY38rKcTaPt2dCKFlaHaRiKtlc9wD8JisHknn2XgvjMvjjr36Mfqh
	0zwNyuAgmWn759dwk1pRbUntTJ+JaQgZcYlAaQ7PAq7Ihluv4Z1Km/hDdMG0tml/buBA9Z8hPoM
	y1It5hESujOFc5vDrkbrTrZexG+eiscWg==
X-Google-Smtp-Source: AGHT+IGlZnMidGeylHmeMBI9Al3pOpa1i+4rutb6h3joKg0QO4oZntcS55qYmjUS30Z7Qx/HMHcxsZMWn33hnNIJcj8=
X-Received: by 2002:a05:622a:1207:b0:4a9:7c7e:f2f9 with SMTP id
 d75a77b69052e-4aef0376a7emr246241cf.17.1753914898419; Wed, 30 Jul 2025
 15:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730032312.167062-1-yubowen8@huawei.com> <20250730032312.167062-3-yubowen8@huawei.com>
 <20250730063930.cercfcpjwnfbnskj@vireshk-i7>
In-Reply-To: <20250730063930.cercfcpjwnfbnskj@vireshk-i7>
From: Prashant Malani <pmalani@google.com>
Date: Wed, 30 Jul 2025 15:34:46 -0700
X-Gm-Features: Ac12FXzJKlOTvvQVQrnkjqm_RZrHhkujSCGJ9c_8nKLlG-C3SKCPflENeEsLJLM
Message-ID: <CAFivqmLkLn-92rMow+c7iEADCdh3-DEapVmtB_Qwk1a2JrwwWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: CPPC: Fix error handling in cppc_scale_freq_workfn()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Bowen Yu <yubowen8@huawei.com>, rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	zhenglifeng1@huawei.com, Beata Michalska <beata.michalska@arm.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"

Thanks for adding me, Viresh.

On Tue, 29 Jul 2025 at 23:39, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> + Prashant/Beata/Ionela
>
> On 30-07-25, 11:23, Bowen Yu wrote:
> > From: Jie Zhan <zhanjie9@hisilicon.com>
> >
> > Perf counters could be 0 if the cpu is in a low-power idle state. Just try
> > it again next time and update the frequency scale when the cpu is active
> > and perf counters successfully return.
> >
> > Also, remove the FIE source on an actual failure.
> >
> > Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index 904006027df2..e95844d3d366 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -78,12 +78,23 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
> >       struct cppc_cpudata *cpu_data;
> >       unsigned long local_freq_scale;
> >       u64 perf;
> > +     int ret;
> >
> >       cppc_fi = container_of(work, struct cppc_freq_invariance, work);
> >       cpu_data = cppc_fi->cpu_data;
> >
> > -     if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
> > +     ret = cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs);
> > +     /*
> > +      * Perf counters could be 0 if the cpu is in a low-power idle state.
> > +      * Just try it again next time.
> > +      */

FWIU the performance counters shouldn't be returning 0 in an idle state.
Per the UEFI spec [1], they increment any time the CPU is active,
so they should just return their last counter value before they went into idle
(of course in the FFH case an IPI is performed on the target CPU, so even
if the CPU was idle, it will get woken up).

As such it is better to either :
- Check for idle_cpu() directly and return (see [2] for the function)
or
- Always clear the source on encountering an error return value.

[1] https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html?highlight=cppc#performance-counters
[2] https://lore.kernel.org/linux-pm/20250619000925.415528-2-pmalani@google.com/

HTH,

-Prashant

