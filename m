Return-Path: <linux-pm+bounces-39327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B91A9CAEE5B
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 05:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D09E83024357
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 04:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC6A27E066;
	Tue,  9 Dec 2025 04:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKQRLve1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D0277818
	for <linux-pm@vger.kernel.org>; Tue,  9 Dec 2025 04:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765255122; cv=none; b=qRHF80X11sQzYE5o1hvX8aVU7mbcUCo8SbnxJYmOv64MGOl4l6Nn2F2fg2qNNtfS6U+pLQZqL6QKwKsd2ZEWWfDH1SjjC8WEaq00x9e9ieY5VABHcet+Ha1DwRKkD2Xd19JFigspdC/gRBLq8gptCB+HNzQpXYY9asXbx8MIF9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765255122; c=relaxed/simple;
	bh=lCeS2rZs0DOuchGORWhUOHFafJbHcX8mIQByqB5tQ6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTiw1qDrwoOyVoYDghMfCj4Ww3ivO/dWJCr030sczgoLvM0BFtsYtXU2B8xmsxYHz3JhXble8/QszlQVon8shxqsyvxGrPMOkdG7COd8m2gu/6WPqAbn/lsQO47Xu+Wb3gqCVpMhADvIpJ6lYflAMi3Uenf8ogM/D/iwZzVQ4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKQRLve1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5942bac322dso5124087e87.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Dec 2025 20:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765255119; x=1765859919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzHsigVrv0A4MNDWjYlB5QyJq7OvnSZmzl7cSMbglZ8=;
        b=hKQRLve1O5jcfydsLE/2hrtvhQGb9Z3SQTjEGk6zX4puFbnd4XmkKJM2nSWFB0uQ4K
         2qRxUnxc51jB+NsZVeQZARuGInstpkW8n5Jpc2JAe7CC+vJMG6FrUrjpy2f+ImCU2IsN
         j0SjMUtWqJzu7q6PyTSyh/E8lWJLTqCcCESIMYAbdYZSD8oa5UabW9GTJkHBv5h6gVgw
         OvkFhMMa6JT1Ppedq96JtLt17oJIrodIwey8bWyIZ0O+X8JjBV/fCi29a94taTrTkPXp
         KdgYGY5Z1VnVRhSUiL6IXuS4epnP5GBRniDyAKlAU7o07fj63ZZnv8q2m7Wh4xUSwKLF
         SGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765255119; x=1765859919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SzHsigVrv0A4MNDWjYlB5QyJq7OvnSZmzl7cSMbglZ8=;
        b=RA5UBd8sGPwW1yW/GC3aBjb1TK3x+Ecd4i0gQoHrHk9sZRyBfxlkhLn/HV8fJi/P6M
         g7GRr8TX47ajGqLnx0n/OvSiZQEbaHl52eKWZjiyAlLMxnr31g+9mvRJkuFyonpYnauQ
         0ihLEgB++ywb9TTIiwTgdQH4HCCQWR9mYxKm9Tu5sSuUI0FciVqA0QvqFIZyyWtXBgBG
         FIdNTTyYVcsmXF/lvLUbtyNMqmgCgVwszCVAb/yyA51GeXtUZrkBcbakJyfmPD48T0eF
         CtNkifPgM2NFNpl1BGBVlOxE03lMN133Dfi/DIddaOEBEhwsGqt1QteHy9bu7F33KaRs
         ZypA==
X-Forwarded-Encrypted: i=1; AJvYcCX5IKrpeAMlcft9a3k376N30MgVwKXCAC7xwBsbzk5vmoBUCVhRcH0Uh+78PUGloMGm4GxDfWBGYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX9kthGVSKzkz5RStLZhhXbyTRenNVJH2Uej2O/TGrKH+kIHNx
	BGdj0JzXG1sNr36ID9+SFzyjQSSSVPvdQFQjupIV1/inFW6ZOjzjm/1KEsLzwcjye893OVSgQ3p
	jAjFMut+kl4HqZmqv6ylPvyh1xSITAH4=
X-Gm-Gg: ASbGncvn7BGniVFbJVn8wASGuoWzvviPLjrusVx8t6FqYlGzn14KcRHKEyM7+gfSA5T
	/nFviagaYDqIoQEtumBDrt36vdu/4jZzafG4h4w59TPf9A+j+iw0WHbZQHAAQ8LMYWD7VhRgSvF
	AunoqebN2LMAG+gYytzYK4sKU3pGLw1Cua8HAs1gHh8RcPQCHqtnuVjkMImOPQUzQahkTqIjVXb
	DJrjbvrjJywTuQQ2iWe5jdmiX4G5vAp9RTbIiHn69CMRIp2H0fwxi+bzdoZC52dPuBnetg=
X-Google-Smtp-Source: AGHT+IHc8wnLSC3QKPaNCjZkhPEnAZ8Y/+7SK+LNIP9wQWMucLG9PhpZ4JxKAADqY3Ze08e24Vac7MAoxfivyy3iyM4=
X-Received: by 2002:a05:6512:124b:b0:595:9d86:2cc7 with SMTP id
 2adb3069b0e04-598853c1be6mr3876881e87.39.1765255118790; Mon, 08 Dec 2025
 20:38:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731-pci-tegra-module-v7-2-cad4b088b8fb@gmail.com>
 <20250926212519.GA2268653@bhelgaas> <CALHNRZ-1sLDz7rSO97tWFeRzgP4rGo=winc7ZsANtAtQkU+pFw@mail.gmail.com>
In-Reply-To: <CALHNRZ-1sLDz7rSO97tWFeRzgP4rGo=winc7ZsANtAtQkU+pFw@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 8 Dec 2025 22:38:27 -0600
X-Gm-Features: AQt7F2pvGcZWndtbfMMeJ1f-6NSlT5r1quLqId4BydBljPNcuT6AVY1N-3SAoqM
Message-ID: <CALHNRZ8JBMQRBXeO2cx11UJ2Ag6vzkuOj8Dg5BnYke8b41_AeQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] cpuidle: tegra: Export tegra_cpuidle_pcie_irqs_in_use
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 1:53=E2=80=AFPM Aaron Kling <webgeek1234@gmail.com>=
 wrote:
>
> On Fri, Sep 26, 2025 at 4:25=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org=
> wrote:
> >
> > [cc->to: Rafael, Daniel, any feedback or ack?  Would like to resolve
> > this (part of Aaron's series at
> > https://lore.kernel.org/r/20250731-pci-tegra-module-v7-0-cad4b088b8fb@g=
mail.com)]
> >
> > On Thu, Jul 31, 2025 at 04:59:25PM -0500, Aaron Kling via B4 Relay wrot=
e:
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > Add export for tegra_cpuidle_pcie_irqs_in_use() so that drivers like
> > > pci-tegra can be loaded as a module.
> > >
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > >  drivers/cpuidle/cpuidle-tegra.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidl=
e-tegra.c
> > > index b203a93deac5f378572be90e22c73e7417adb99e..aca907a62bb5de4ee4c71=
c1900eacedd4b90bc0a 100644
> > > --- a/drivers/cpuidle/cpuidle-tegra.c
> > > +++ b/drivers/cpuidle/cpuidle-tegra.c
> > > @@ -336,6 +336,7 @@ void tegra_cpuidle_pcie_irqs_in_use(void)
> > >       pr_info("disabling CC6 state, since PCIe IRQs are in use\n");
> > >       tegra_cpuidle_disable_state(TEGRA_CC6);
> > >  }
> > > +EXPORT_SYMBOL_GPL(tegra_cpuidle_pcie_irqs_in_use);
> >
> > tegra_cpuidle_pcie_irqs_in_use() looks like a workaround for a Tegra20
> > hardware defect, and having no knowledge of typical Tegra20 systems,
> > my questions would be "Why do we even bother with this?  Should
> > cpuidle-tegra.c just disable CC6 always, unconditionally?  The whole
> > thing, and all of include/soc/tegra/cpuidle.h, looks like it might be
> > more trouble than it's worth."
>
> It's been almost a month again with no responses. Does this have any
> path forward that doesn't include signoff from the cpuidle
> maintainers? It's been over four months since they were first asked to
> look at this, so I presume there will never be any response.

It has been another month and a half without any response. Is there
any kernel policy for handling completely dead subsystems? Can the
maintainer of -next sign off? Can it be sent directly to Torvalds? I
have been trying to get this merged for almost 8 months now. And the
majority of that time has been waiting on one single ack for a trivial
one line change that wont affect anything outside of this series. This
is seriously ridiculous.

Aaron

