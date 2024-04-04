Return-Path: <linux-pm+bounces-5927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36155898688
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 13:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97671F21913
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 11:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A681A83CC9;
	Thu,  4 Apr 2024 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7Kv/rOG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A4081AC4
	for <linux-pm@vger.kernel.org>; Thu,  4 Apr 2024 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231654; cv=none; b=Jjagi+FdgDbCjlMZunwDy6MwTAhNdOIpxGM18B/2aBcQVblG5bD8nB8nbgvNHgMY/MKOmOjStpwzEgWct77k1kjNQsWwoF1udfd/8U5oV7nHZzcoaIa2etEqisNtmF1AiS76+KcGTZUqQRB0LOMMMh/7aFq2XYHwYwGA0KC42ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231654; c=relaxed/simple;
	bh=1sj9CtIa3vst6Kj48VqXx1mJzJBtfzLfWjvkvm0guDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tb4A3EAHtu20FagkcGd0VYKiDE8mIi9UeRp7b1H9XgVOTXEaGbdamA6mhm6YVlPXUmQKrBbyZVvqoNsOugCK3Rcdz+BWxbcRnX1q5NUZQwpn9W+TpBqFgiNktLINFAonsS6OivEax6ANehlKUGRocxxwDCR07bl0XhAfVI1oBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7Kv/rOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15683C433F1
	for <linux-pm@vger.kernel.org>; Thu,  4 Apr 2024 11:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712231654;
	bh=1sj9CtIa3vst6Kj48VqXx1mJzJBtfzLfWjvkvm0guDg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R7Kv/rOGPcQr4xnQay1iUdPNbFpl5sy0sW9Abj49X0Kh7eKeLR6J4TvzGZD0q6asD
	 +ibTxVIhiHJN+sWMT6r1Ei5m2AW/suQHCInpX9HBtpmYPZWSSHhHGG3pHshyxksprV
	 gQe2sTHXSpyhgAbTmIPmsyrhDU/bNTwchHICo+gXl0ahvDnAJvqH9Cbx2G7CdJJG5b
	 d4dfSlZONJ72NkmYH1LYhEUwDOk50Kk0XL5pZtXEaedNn945KrJvU+/jY5Bl8e/yYy
	 DnPJ8rm91pPCmnTiyBB0lDvHt7nHgs0kXju4sF92rlXej/lifNSH0wt0vElgBDRQC5
	 vbSi9osDTlx0A==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a9c2045b8bso129687eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2024 04:54:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUROhcHj0DxVtkI4cmLqChIZU4Agu4RDL2Clb/na1j9sxKfm03KrELmn65LqpdNI1K34K5gLwMcSTNcEE874en29JFaViFssYw=
X-Gm-Message-State: AOJu0YzAUOb09XB0BJ4nuyEi50fKqtU5Pk6/kp+/S5WkHKJUy6nZqCFm
	V3oeJXHayFq/jvFK2W5KiKCiRzFE7KNd2zj/jHnoWch6TwsfZx83Tzrd+tZr3KDf5+ayfQF94Zn
	1nUroNbRBYaeDZ7QlSo9jzu4vMWM=
X-Google-Smtp-Source: AGHT+IE88Xra3cp1UaHxXsipkbuj0Yc4maNT384fQXToBmXq23V3rpiBCFSxAN8TKU9HFbsk34RyrFA6d7x9YUwwDL4=
X-Received: by 2002:a4a:3511:0:b0:5a4:6ac7:de6d with SMTP id
 l17-20020a4a3511000000b005a46ac7de6dmr2022880ooa.1.1712231653308; Thu, 04 Apr
 2024 04:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0i+G7q0jxLGEnoigWf8Aa=zi4esC3EzethsBkxrp=sCLA@mail.gmail.com>
 <CAPDyKFrUKZ+h37YEhkkLj9ffPtV_gn5_8_dqUrSGNsYn7T_ozw@mail.gmail.com>
In-Reply-To: <CAPDyKFrUKZ+h37YEhkkLj9ffPtV_gn5_8_dqUrSGNsYn7T_ozw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Apr 2024 13:54:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h+rWjpPZuwQAwhz0Po_9cWXbKH8k9R_6Lm32sScigqng@mail.gmail.com>
Message-ID: <CAJZ5v0h+rWjpPZuwQAwhz0Po_9cWXbKH8k9R_6Lm32sScigqng@mail.gmail.com>
Subject: Re: [CfP] LPC 2024 - Power Management and Thermal Control Micro-Conference
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dhruva Gole <d-gole@ti.com>, Nikunj Kela <quic_nkela@quicinc.com>, 
	Kevin Hilman <khilman@baylibre.com>, Doug Anderson <dianders@chromium.org>, 
	Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 1:32=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> + Dhruva, Nikunj, Kevin, Doug (I probably forgot some of the last
> years attendants, please loop them if you know)
>
> On Mon, 25 Mar 2024 at 12:37, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > Hi Everyone,
> >
> > This year the Linux Plumbers Conference will be held in Vienna,
> > Austria, on Wednesday 18th,  Thursday 19th and Friday 20th of
> > September (http://linuxplumbersconf.org/).
> >
> > As it has been a tradition for the last few years, I'm planning to
> > submit a proposal for a Power Management and Thermal Control
> > Micro-Conference to the LPC and I'm looking for topics that people
> > would like to discuss in that MC.
>
> Thanks for continuing to drive this!

Anytime!

> If you need some additional help around this, feel free to reach out to m=
e.

I will.

> >
> > The LPC is focused on work in progress and future developments, so any
> > work that has been completed already is not a suitable topic for it,
> > but if there's anything you'd like to do or you are planning or
> > considering in the power management and thermal control space in
> > Linux, please let me know.
>
> We had a BoF last year around "supporting multiple low power states
> for system wide suspend".
>
> Not so much progress has been made I believe? (Except for some local
> hacks that I am working on).
>
> If possible, I think it would be a good opportunity to continue the
> discussions from last year, assuming people are still interested in
> this topic.

OK, I'll add this to the list of prospective topics.

