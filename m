Return-Path: <linux-pm+bounces-23886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E0BA5CC4C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 18:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96A63AA2BD
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FAB260A21;
	Tue, 11 Mar 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDaqEuID"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD971D514A
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714511; cv=none; b=Ks6vC04vPKBaomrZpiIhDu7bT0xH4k3R739f1hRwvOyjEebpP29FU1qWdEF6WwTkolU3hr7bzS1kX/PF5tM1q9WvlbES1nQATIiPwN0I6REhMIl5CaMspE1sQ6CffyxilG4mApJlGQKxktC8hsdSvBX/1rceS6jvyO3A/SanEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714511; c=relaxed/simple;
	bh=GNGlCFtibwN8753LWlEdKG1YKNmJ3P/UPAfn2NJwDdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CF+V0B3CbvsqdD4yjr8Me/oxNSlMmpietQm+kLDTenA8MVdcjQ6GZfwnFw5iR1hcw6dI0VWq+SCPDGLjg/7+U5EwTW4mhXqFc5HAcW9LGBSduvJYByhE91G1EqaqTNOb/jt6kpijot1GUFd8bXi7xkIi5qhaQ6cPr6fpXN9Ndzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDaqEuID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3092C4CEE9
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 17:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741714510;
	bh=GNGlCFtibwN8753LWlEdKG1YKNmJ3P/UPAfn2NJwDdY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MDaqEuIDESkz42EV+5YCJyMFsRY3NVovh3fmHNpxt5VWe3gCx74uGUwRkKulsO8f7
	 EXjhnPcBSGTkly00EO94Jt1It2AwAE7mR62MXhdP4EWRTFG3ww+UfTJxeQU59ypW4P
	 pYXsjXIJMEpPBaI2FNGlB3PxFJbN0C28zz58OQzKMnCa6QSHprpjfU1SzcHdoMS2qp
	 rwBqtj1/4M+tyfKTyIwtEiNz4Mjd/KrpxYbRd3+/aL0vOC/8+pRW32M9SjC7rtcesx
	 wlIKkgCDJxzieqd27SxlnlgrtNmBhFNevhc0UV8u7GZJ1u+UX6zCrztewPV2QcLLUE
	 aF3fvjz2jsm8Q==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c186270230so1511694fac.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 10:35:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrTkVdA+7OQO6deto211e2FEQ3mmajwn1n1OiDoShy2cttfwXBE81rsLqqWRiLnWaBXPRzZwtgIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFK6h/s8WMjOYrrRgT3rYRaqhLnKWp+vUIMdoocRl8elXxyMxx
	y7mmZexYRvzooatM+KCbV6E2x/44yADDDDu0OtvYhAK8v60XC2N38I72iQ2IvdwZW8fHI1NWC0T
	PLvN4I41LjjSPoYDRiE/39HjF0ls=
X-Google-Smtp-Source: AGHT+IEagMiGY63qEO+T2wvNfqtriJBPiif7UdO9dMUiD/B5xHZADKMlokZq8II/ph/ZlmbEldG2ylk6k52GrdnlWQQ=
X-Received: by 2002:a05:6871:6011:b0:2bc:9116:8856 with SMTP id
 586e51a60fabf-2c2e89c6840mr2531549fac.36.1741714510252; Tue, 11 Mar 2025
 10:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <483602d6-4ac2-4785-b205-912b59fbd6f1@linaro.org> <4a50de85-0deb-4864-b7b5-ee81cec7f167@arm.com>
In-Reply-To: <4a50de85-0deb-4864-b7b5-ee81cec7f167@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 11 Mar 2025 18:34:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jBFOZ-z29-KwgHN9cL4sEPsW9K5TG6XeT7Y-ADbVPcCw@mail.gmail.com>
X-Gm-Features: AQ5f1JqKxcjQdAfMdEBayKBD19-ArXHUstc87QZC3mihZMFb30f3VNV1iLuCUHA
Message-ID: <CAJZ5v0jBFOZ-z29-KwgHN9cL4sEPsW9K5TG6XeT7Y-ADbVPcCw@mail.gmail.com>
Subject: Re: TEO as default governor ?
To: Christian Loehle <christian.loehle@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM mailing list <linux-pm@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 5:47=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 3/11/25 16:31, Daniel Lezcano wrote:
> >
> > Hi,
> >
> > I think we can agree the teo governor is better then the menu governor.
> >
> > Would it make sense to make the teo governor the default governor ?
> >
> >
>
> Rafael's position seems to be quite conservative here.
> Fact is menu is still the default on many systems.
> Even worse, the really bad performance disadvantage when
> using menu in an intercept-heavy workload has been fixed by Rafael :)
> https://lore.kernel.org/lkml/bc7f915b-8d9f-4e05-9939-8b7ecc078f85@arm.com=
/
>
> FWIW I proposed this a while ago:
> https://lore.kernel.org/lkml/20240905092645.2885200-3-christian.loehle@ar=
m.com/

It will help if one can make a really convincing case for this change
(that is, show that menu with the most recent fixes included is really
significantly worse on their platform).

