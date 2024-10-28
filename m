Return-Path: <linux-pm+bounces-16630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61569B3D41
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 23:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DADF21C20B77
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 22:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C865201012;
	Mon, 28 Oct 2024 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jpew2H3o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9411EE010
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 21:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152300; cv=none; b=Zb41AX5+7fe3MJbjsyskW8Mj9Cynqg12Hvixx4huT3SJHqtrRv/4BY2ZVJhEA8hrZn/tjoJyU+SJAo9ygv06nbpqJJzReKwiqvXVpJ3VzTuBKXsNab8yJ7fWi1vO/b2gLfY8O4smQiNBdt/xNyuz1TnznjrumM0Ez6USzy2yTD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152300; c=relaxed/simple;
	bh=9qLDJXZ3fIjfSxkEuavE29HqShFtPoj5eTwQYhV+lUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo16F2bp7rxjvDxZk9mfNpIK22Y6Y8iftvoOCJQTu+1LbDYxIhbeZndeR+IyC9s6uKLnTlzYJlExWtiFP2wYXwm3baQoHtoeUYCWxR+oeR48FEhMQIg4yzHnBICYmNifWr7f2XWHiYuqnb35sjHUHpx5ecl7fbxwWUJGjrOQZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jpew2H3o; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e28fd8cdfb8so4827870276.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730152297; x=1730757097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qLDJXZ3fIjfSxkEuavE29HqShFtPoj5eTwQYhV+lUM=;
        b=Jpew2H3o67UQIZ/w67BMTPkRegMPH/cAi2123A7wdMFEBI6U0Q7lWw05n54cypGPg2
         81wjp1m8m3Y1UQzpTEoxkUcSR3Krb2WQO/t/oQE0VT/CnA0vKJCMk8GRUxICgt8eYHKQ
         28wm63GwI6aItw9dAdAMDbtfnQKjzri8WNCl6MeOEpPVtRvvORgoa764YwAXONweomf9
         QTWYa+9QuRM48LxSlGE5Q8SflO5ggf02N4lpEWECPJk6YGym4ctd7MFR5Fb0spEpO2oW
         jvPVT+7IIw1SluQ1sVACcAE/dcbrO7FN/0o/mAuTMhcE1tmFawSKUZ9R8EKdGo1xd/yC
         V4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730152297; x=1730757097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qLDJXZ3fIjfSxkEuavE29HqShFtPoj5eTwQYhV+lUM=;
        b=ElKhQt3a7exVTpv5kLJm0XL1Cq9NNDCldUxK/SFUmmbO0L7M+zGYF2ZaXxWmgt+3ZW
         fGCjCpWKhl55OHTIpviGb1s9oabIigeEkymaNL0cM1O4vgtOEwo6VP7rxDuIeFta3j09
         1KiT2ivNlkkj1aA7v5s1+gW03gROv3UaG1HYDSJ9cqohbLKbIaQwm4Yr6zRt92+XBiMb
         jyERpsV2vlwhMkzvpr0S9TYk1eEDuBnQFNH064n5UWGTt0W/D/J4B05d2slIyuRUAUtU
         vZveh4tAwduch9Mu4zIcZcwqF3/FoX25pSfPdsPVoPiGutxnSSyYl9pB9cG1AKfoMjcI
         +o3w==
X-Forwarded-Encrypted: i=1; AJvYcCWdypPzu8nqMPvBoCa/oCyQxa+M6UoYT9xpScD+REIMu5Ci/6+O/1GJK5G2oPGHqh3ZP0Gy4pU+Qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEV9/MHaymtgHMjUXigNrSYKbWiZCAvG3Ir+4iziSR7LBTwU6l
	KELSlWMFEP6VDRbpi1Q5vF2QGEIBYWZ7PyD8RePnzki7O7O+nPwrwz4Wrw0HRH2tKkLodns7lGm
	6brSMKhf6NKMkPI/nyeQWVimomqefdGlXcdV7rxgz1fOGLNGK
X-Google-Smtp-Source: AGHT+IHGeaxi9oCwvuuA7PbJZSA6oQ7alp5NrGsI3AtrEBKCd3bVoJxof6lJB9e1l9CVuxoUoBVjgK48/iKg/gyfopw=
X-Received: by 2002:a05:6902:2b87:b0:e0e:7fb3:cf88 with SMTP id
 3f1490d57ef6-e3087c35835mr6223710276.57.1730152297217; Mon, 28 Oct 2024
 14:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024094930.3221729-1-dario.binacchi@amarulasolutions.com>
 <CAPDyKFqqCWt5oCj6qBuP_oZ=O1kmkfMirYETPXEeW-AmiA9P+g@mail.gmail.com> <CABGWkvqbiuvBNy2wBT4yVgwP+CY67__+sNxN3vS3Bwss7AwQhA@mail.gmail.com>
In-Reply-To: <CABGWkvqbiuvBNy2wBT4yVgwP+CY67__+sNxN3vS3Bwss7AwQhA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Oct 2024 22:51:00 +0100
Message-ID: <CAPDyKFo0PpqvSHVgL3AaFQUR7B=+MqzCqkg4+t2Rt3nidQzYRw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: fix "sd_count" field setting
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Michael Trimarchi <michael@amarulasolutions.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Oct 2024 at 16:07, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> On Mon, Oct 28, 2024 at 2:34=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Thu, 24 Oct 2024 at 11:49, Dario Binacchi
> > <dario.binacchi@amarulasolutions.com> wrote:
> > >
> > > The "sd_count" field keeps track of the number of subdomains with pow=
er
> > > "on," so if pm_genpd_init() is called with the "is_off" parameter set=
 to
> > > false, it means that the power domain is already on, and therefore it=
s
> > > "sd_count" must be 1.
> >
> > genpd_sd_counter_inc() is being called when adding subdomains. Doesn't
> > that work correctly for you?
>
> In my use case the genpd_add_subdomain() is not called.
> I am working on :
> drivers/pmdomain/imx/gpcv2.c
> drivers/pmdomain/imx/imx8m-blk-ctrl.c

In that case you don't have a child-domain (subdomain), which means
the sd_count should be 0.

[...]

Kind regards
Uffe

