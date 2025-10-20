Return-Path: <linux-pm+bounces-36503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D13BF30BD
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 20:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFE0480458
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 18:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57CE23A9AC;
	Mon, 20 Oct 2025 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIzWjg9g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE9A2D5922
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986431; cv=none; b=tvrSH8yLrNESQStjYYzXxBcHjO3io+ylNGAJg4BQ/U4HVEdyaAiPpnOJ99eF5CqRbdnSNRHGyjKh4TXloneiY/AFVrNPCJmkyHm2DcJ9KJokDxtc45HhQKTiWbXiR6CDFpc/keF70aY8eJ0YxllBBVZzoBea8QfBA2NOIcR9/MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986431; c=relaxed/simple;
	bh=ep9oGRp0oF+oCFDHArxdHwQE5BacfqsLXNq7hLcEyno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlLiih4p4IeJLMP5ykn2uhd6QFoM5GPvAaWcg3egFRBF2e2b+s9YirKVT3JBn/Afc0RSHjA2MZAW5Y7VLhAiwXSjqJXIDPVhsJUZHkk9LuTznBkbnitTy4ftPpnoCwEOCtxuIHXBxznOAU01aWO+AskEtIj34o58Anxy1zZXyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIzWjg9g; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso5494757e87.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 11:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760986427; x=1761591227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvkRm+XTrLJJZVcVghGvmjpr/0j+IP7YtKfaztr+Qdc=;
        b=DIzWjg9gnQnUG9TcemQgQYlJC55i8rgv3s+7i2MxRtYySa9ILCW7fpRp9+J2yWIUEl
         viFqIMc25uHKqE43zhQ2Qr2hAW7gVMoVl98xyP7YerEPBKHs4claLxW18eJl+NreoJej
         WffmX3v9GA7My0V+8IfhPBc8dGhJ7ua17YO5gpnpjBL3NuSe8BOAKoHqVqdfywjpmbaF
         V+NwuuKz4KqToNNYnna2QJtySN0ULEyzfCdRYcwssMitclS8mmxPy5YJdXCiYEFsOeib
         BiQIBJ1dDXo4RWYkETf2/Dv5QVUmC5rJp9xAu+ogGX4V0Yzng765/M9+UZU0QAu8v9hI
         88vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760986427; x=1761591227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvkRm+XTrLJJZVcVghGvmjpr/0j+IP7YtKfaztr+Qdc=;
        b=QHibFvgkQxHIZHTM68aEbTgO1QTapIALwEE8ikYMfwjsR3jILqQM1SO8bpdy8x65gk
         XngQ9WATSud/FKqqjIbZnpKl6JRZuKIVE+8QTNaAgun+lx4fbVt+JOJ5Gvlc7ndq/WcB
         XKSlj/VpbpQUaR0osD0STMdPbzpzFjm3b6GuGZLySRdVoFw2CHtrFrX3bIgHsviMlmXp
         C4S7Yq0VW75Dl7AC3crg6fLK0EFPAo0sSziJmuBh9h0WiChLbYdq1p6mU4NkV/RamP0T
         IugZkJOPaZVzEScPR+fmQhpV969ebwDIXK5+JqOIgqakWTK1Bv53vrafXaORapW6J1rU
         wJoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo40sWRtDQTsPSfnzEUxIfORc02gzP04mN6VW4OSD7ZlU3orgH2+/n9VqnT22uHsCX9i9Nocspwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq99q9aVJnTyGbmqacazDzikYy9eB4qPVoSToJT+mO/BvIzvUy
	EgElA88kgQcKlNfF/KHPryPmz0RxMNxxxvOXIiqwmE6Zw61RthCQ4stQgSFqaRA2bfOMXoFpLpL
	rUYIPJyAykBwi+LZrwTv1rnnkun69eZU=
X-Gm-Gg: ASbGnctiVqeD5zXh6F81fkMbL10DK1yEzNCNFLOJAmebovyvDXob3z559oJnh5aGZQm
	htWXrGiaax4nM7ny7SbakQm/eDPHYV7d3JaQtgkJLszCc4CgezJhupw9c3fP23Fb2ha8kYgNEUL
	6jnobprzVJGrr0v/ApbJ46bgChNXI7B5wTYThRlYDrbdAMw1DWNEm5/xY7GILcZZLJeWZjXBpq1
	bUFogHkGvsx5gRdE/4oIqzUIJfd6gJjp98bhaHYKdFF2u+kHRORZHWv742F
X-Google-Smtp-Source: AGHT+IGriJ7UXZ9nd8XnOsNbi6d9VsXWG8HB0uHqueF027XCSb3Vwq82mSdbbfih1n1Eq8I/zX/Vvg6RGc3tBqBeAaA=
X-Received: by 2002:a05:6512:308d:b0:577:318a:a1c6 with SMTP id
 2adb3069b0e04-591d84f7185mr4042715e87.23.1760986426759; Mon, 20 Oct 2025
 11:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731-pci-tegra-module-v7-2-cad4b088b8fb@gmail.com> <20250926212519.GA2268653@bhelgaas>
In-Reply-To: <20250926212519.GA2268653@bhelgaas>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 20 Oct 2025 13:53:35 -0500
X-Gm-Features: AS18NWCmMUTtQXUaLifQrSGp8qDRYM75-V9Y9cQ9D8p5t478TikwLfPuNlOWrnU
Message-ID: <CALHNRZ-1sLDz7rSO97tWFeRzgP4rGo=winc7ZsANtAtQkU+pFw@mail.gmail.com>
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

On Fri, Sep 26, 2025 at 4:25=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [cc->to: Rafael, Daniel, any feedback or ack?  Would like to resolve
> this (part of Aaron's series at
> https://lore.kernel.org/r/20250731-pci-tegra-module-v7-0-cad4b088b8fb@gma=
il.com)]
>
> On Thu, Jul 31, 2025 at 04:59:25PM -0500, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > Add export for tegra_cpuidle_pcie_irqs_in_use() so that drivers like
> > pci-tegra can be loaded as a module.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  drivers/cpuidle/cpuidle-tegra.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-=
tegra.c
> > index b203a93deac5f378572be90e22c73e7417adb99e..aca907a62bb5de4ee4c71c1=
900eacedd4b90bc0a 100644
> > --- a/drivers/cpuidle/cpuidle-tegra.c
> > +++ b/drivers/cpuidle/cpuidle-tegra.c
> > @@ -336,6 +336,7 @@ void tegra_cpuidle_pcie_irqs_in_use(void)
> >       pr_info("disabling CC6 state, since PCIe IRQs are in use\n");
> >       tegra_cpuidle_disable_state(TEGRA_CC6);
> >  }
> > +EXPORT_SYMBOL_GPL(tegra_cpuidle_pcie_irqs_in_use);
>
> tegra_cpuidle_pcie_irqs_in_use() looks like a workaround for a Tegra20
> hardware defect, and having no knowledge of typical Tegra20 systems,
> my questions would be "Why do we even bother with this?  Should
> cpuidle-tegra.c just disable CC6 always, unconditionally?  The whole
> thing, and all of include/soc/tegra/cpuidle.h, looks like it might be
> more trouble than it's worth."

It's been almost a month again with no responses. Does this have any
path forward that doesn't include signoff from the cpuidle
maintainers? It's been over four months since they were first asked to
look at this, so I presume there will never be any response.

Aaron

