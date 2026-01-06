Return-Path: <linux-pm+bounces-40310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32794CF85B4
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 13:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 561F33111C21
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE09D329E53;
	Tue,  6 Jan 2026 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXIQGolh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B716D325730
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702615; cv=none; b=ef5QJLsrxp3UYrBKKzOj5mN2ZBq8o0J+Z1hLe5rjENVDMC9NWeVw59chhaQ25NkHkrkJk5io++z+QubpsShCod6/Fmu2OCYMk3PrPw7TPmmyh9zMLEejrMHhxTxAhg+dl6JM66XgmWlUkgtTSbf5MW2a7IR4616/z+YwsaffgOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702615; c=relaxed/simple;
	bh=FQLuWk6kGeepu32+iEhmSBIml17MKCpSgScV1hNzA5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJP3aJPorJWssd2b6P/gRph61UpeVh3Eo+c3zz8FExsbYk53XEY7vvx8IcBYp14+d8XiioWy+1yZOpxYzKE9zVWQDSK4TVlrbFNMTPlUWrhOydCzzVBmq8TPotSUNXRQFDh/6Qu23oCgmEOBPpp2Q7YaqgkyzwVPJSa95AIBJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXIQGolh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F1DC2BCB0
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 12:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767702615;
	bh=FQLuWk6kGeepu32+iEhmSBIml17MKCpSgScV1hNzA5M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HXIQGolhJd+z2QWLEBFeABhZ47UV+ZqLlMYQZMSXGkXybgCSUMThTPkOhy7FP/DHB
	 l8qEm7zdPU/7hMyymyc2p/UCL70HdVwBwT2uS40GkLwO55PvUbyqaGP6ZIlOHCqBeM
	 faTczxDN9TEP/LXKveKplEs0dYoHtNbmuuIBJE6xkKVYfnDxROQaYvEx+oKTTCb6GJ
	 8Xm8HzxOMqVvj7qpTMHLTnSPUYGAX0ECoPgMi0z3KMNX51mbt+u6DkhTm27KqYMibG
	 Vi29sFMBXAgiQNvGUJfYg/1gaYhj8LmbE+kDtdkAbjsOU9rZL3jaf2pobGR4WqwFzS
	 McGbyE7qUafOg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b679cff1fso343907e87.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 04:30:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVW7150/O9NxcbNUOn5h5sjd2uLCuQJMokYOTlVgHmy76xvoFng2wws4KID7XJX4/Wg8WyOdwk7sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRUtzpUimKbhP5y0R+NtmBNy/VPuA0nF/AGb4Ltu71mZ8hfdXj
	4aqOQ0xYnr7aesSows6JUgfI9SkNymiktzwP1ggCA3b8SZObZBni6TXwqXgDL2SvTeqd6oZKBYr
	osmxfSIwAuWA0tej+g1sZWShI3xMVyr7WMAwoe4Jqmg==
X-Google-Smtp-Source: AGHT+IEv1cDKis9ahl0NHeYL6ip0JnRoN/mEt3uGev0kmbqpRkYiA+Ba/VisBT/vnF4d+mRmFetyQymW+clo868a2ZE=
X-Received: by 2002:a2e:a58a:0:b0:37a:34e2:88e7 with SMTP id
 38308e7fff4ca-382eaab3976mr8018841fa.22.1767702613967; Tue, 06 Jan 2026
 04:30:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
 <20251228-arm-psci-system_reset2-vendor-reboots-v19-1-ebb956053098@oss.qualcomm.com>
 <CAMRc=McEB+yVYxropzsqLExZCU5Pd_iy_=5N3pTxu28-ZX=7_w@mail.gmail.com>
 <acbb37a1-3189-4d4e-5c05-55b13cd40a7f@oss.qualcomm.com> <cvmtn335gwnl6rvmlm4vgyablsj735rknga4ffv53gpk4k7d6g@tt7ebuyusocu>
 <e4b01dc7-02dc-060e-d1a6-abd2c801a78a@oss.qualcomm.com>
In-Reply-To: <e4b01dc7-02dc-060e-d1a6-abd2c801a78a@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 6 Jan 2026 13:30:01 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfaCKe2-Eca6fZ00NQkdLqJV-NH0XAsTKHkU3N7P7pnEA@mail.gmail.com>
X-Gm-Features: AQt7F2qoW4mNxgIcydrH2q8rPkPDFlKCMFSE05cerY8eWHdGfV_LH-ZXO5y5uFs
Message-ID: <CAMRc=MfaCKe2-Eca6fZ00NQkdLqJV-NH0XAsTKHkU3N7P7pnEA@mail.gmail.com>
Subject: Re: [PATCH v19 01/10] power: reset: reboot-mode: Remove devres based allocations
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, 
	John Stultz <john.stultz@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Moritz Fischer <moritz.fischer@ettus.com>, Mark Rutland <mark.rutland@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Srinivas Kandagatla <srini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 7:31=E2=80=AFAM Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
>
>
> On 1/6/2026 3:01 AM, Dmitry Baryshkov wrote:
> > On Mon, Jan 05, 2026 at 11:46:40PM +0530, Shivendra Pratap wrote:
> >>
> >>
> >> On 1/2/2026 3:35 PM, Bartosz Golaszewski wrote:
> >>> On Sun, Dec 28, 2025 at 6:20=E2=80=AFPM Shivendra Pratap
> >>> <shivendra.pratap@oss.qualcomm.com> wrote:
> >>
> >> [snip]
> >>
> >>>
> >>>> +                       pr_err("reboot mode %s without magic number\=
n", prop->name);
> >>>
> >>> If this is an error, shouldn't we bail out?
> >>>
> >>>> +                       continue;
> >>
> >> This is not an error as per original design of reboot-mode framework.
> >> The code as of now says, if the reboot-mode node has an entry without
> >> proper magic value, ignore it, and, process the next.
> >
> > Then why are you using error level for the message printout?
>
> I have changed from dev_err to pr_err. Can make it pr_info. Will
> that change need a mention in commit text?
>

If we can ignore something safely, then I'd just use pr_debug().

Bart

