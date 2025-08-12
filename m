Return-Path: <linux-pm+bounces-32217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F30B22327
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 11:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB241A26C4E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 09:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E552E8897;
	Tue, 12 Aug 2025 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CI8PX8iM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8FF2153E7
	for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990832; cv=none; b=g11UBpbfFFhd1UKu0RIEclNdtTSMV5a85KM79uLN8CNNwGxNexaVxCOqthVLGw0+ayjYDGbbEDolyIaMwj9yNNkHP5G/ZQyaUZKP/cX4hpipb5+aFmW1A37yvWafdweNfxTzclXiBGOogarc1chBJSF6rzQS8POQ1BCkq7W2bfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990832; c=relaxed/simple;
	bh=EQiCMrOW6d0ack6Jt6caSgsfJMbni5eEelJcbz45kfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e9MRCFpVg24XF2Oyy6/7VgO8Cu6AfFllRqVvH7e6dFeynqO2pFl1pLjzULZFKhw28oCY79iP2yBlQeWLdPyhcrt94vDHUM7u7d9oi7EX0ZPkWU04WrHwnYeTa6fUA4lo4hREMkL6mkymNpwxRLDe3YBBJFIeEMzSeM43Gqn4KeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CI8PX8iM; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71bd028bb5bso57455757b3.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 02:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754990830; x=1755595630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbNnZigL96XkjlyiZZXbbetrtilx16GXfj1hRtZynwA=;
        b=CI8PX8iMbLj74ca6ygw0BS6S8YXFLDPp3dKDirP6aL6k4RUKs36rdJgKpWZofMoF/D
         JxQdWIpkOUexFl45pocoSvGOkihceheWZcII0lA97J/DzRX4SUDpZrKYlnROez1bAyXi
         tU3EVRz5uf8dGWQWqdmO0D4Ym3t8NkKHC4UCLjvyK+8aanYIcZ1cnkUBL23mBysxLaz3
         TIcqDqnJaA8IuJmSG4Xw8P6SPbahYEdV87ISFyNikJu9P5/htZNhdCN2AUfHoxlay8Vp
         lC5HxK5OKuCngWYxvfBTWxTUx5b4duC8a8DA5ifbprlHiDqJIPjZ59DQddQLqMspjDAL
         pgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990830; x=1755595630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbNnZigL96XkjlyiZZXbbetrtilx16GXfj1hRtZynwA=;
        b=OMVk/j3cyyP2zNVPPODU+9PumVkO9QuSHXEYXSZ0Sx2o2OpnJNyGz41GzBSdn38DY3
         CNMr4rJ895DxbyO54xofOOGAcgAWMEScicWDUGfvx3+2/mB6bG8NEKl2zXy/W6hpxdXQ
         X1sb33WuAP9B6GvXLyA3ecsp0tTfTDNxjlFSNQIauycUtGQEDVCDRW4gqMyA8rMp0i05
         xKijCdqQ1AZ36XKXbmt/EJoItSO4gKiawnzj2stR9E3pe3yffmVsAiP7zifBPVjZideN
         MJmBm6++RmHXcvrNlJUYLXPM701pa4AuZJLJ0dqfaDFLqHfT1ccTttkiq+2t2t7fVcE5
         Mzsg==
X-Gm-Message-State: AOJu0YxfRwKrTXp5nbITd5loqMwpklsySvapyNK/h0vsUDE0fliBbMod
	S/YbuyhnSRc6qRspqO0HvDfDDzAfIWU1cCenoBdrdcHAk1zKiJaz9ooeSLqnNYZbLBXqvOfV9LT
	/bnT2uUSOPjGVZO0/9UThxjJzUQjcMxlEqLGgSW/7gA==
X-Gm-Gg: ASbGnct+mYOC7N2O1Rgw3NFJVUa6JjNILHC7ftpBP6tE27+dQNk5uuXYDTcZh6B0KcD
	tXZNzp2BBWa5I7Z8RfYn9mpKOuEBjWhzmxhcWIPLG7FSqssheWp1R09dwZP616kouhQb9fYn3Q0
	VFrQb/BOhCkJECeqUqYG582AE5hLMz8epUg7amDNJExSH5R/0jlMKGtonw26kk7ctNQBCokbeE0
	214ATul
X-Google-Smtp-Source: AGHT+IFNHyi9PkglivXNoVBWj4TyIoB57VF8R/kbQ4uy2Cl5XiB1zv2NfrPbzHVGSmscBPhn3nbLKKjwbESLvohzgkA=
X-Received: by 2002:a05:690c:2609:b0:71c:530:1450 with SMTP id
 00721157ae682-71c42a3efd5mr27229697b3.21.1754990829669; Tue, 12 Aug 2025
 02:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716123323.65441-1-ulf.hansson@linaro.org>
 <20250716123323.65441-2-ulf.hansson@linaro.org> <CAJZ5v0iq7UODJ83fkwnzfFR3HpG2_R-YRnip_cLwyUHZZ+rXyg@mail.gmail.com>
 <7hldnp6apf.fsf@baylibre.com> <CAJZ5v0j=9RXHrcVEBp0yy1Ae4_kC1y-WFQyBf89r3NtoL-tYQw@mail.gmail.com>
In-Reply-To: <CAJZ5v0j=9RXHrcVEBp0yy1Ae4_kC1y-WFQyBf89r3NtoL-tYQw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Aug 2025 11:26:33 +0200
X-Gm-Features: Ac12FXwwaNXc80cBU4vSzIIxgYvcERSkmEn1P5fKOYJFDUVvl_f-HYgIWyz5FVI
Message-ID: <CAPDyKFpeVF_EHJDQ9u=LDuJ56g7ykYUQWHXV2WXTYLa-mYahVA@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/3] PM: QoS: Introduce a system-wakeup QoS limit
To: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	Len Brown <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Saravana Kannan <saravanak@google.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Aug 2025 at 21:16, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Aug 11, 2025 at 7:16=E2=80=AFPM Kevin Hilman <khilman@baylibre.co=
m> wrote:
> >
> > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> >
> > > On Wed, Jul 16, 2025 at 2:33=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > >>
> > >> Some platforms and devices supports multiple low-power-states than c=
an be
> > >> used for system-wide suspend. Today these states are selected on per
> > >> subsystem basis and in most cases it's the deepest possible state th=
at
> > >> becomes selected.
> > >>
> > >> For some use-cases this is a problem as it isn't suitable or even br=
eaks
> > >> the system-wakeup latency constraint, when we decide to enter these =
deeper
> > >> states during system-wide suspend.
> > >>
> > >> Therefore, let's introduce an interface for user-space, allowing us =
to
> > >> specify the system-wakeup QoS limit. Subsequent changes will start t=
aking
> > >> into account the QoS limit.
> > >
> > > Well, this is not really a system-wakeup limit, but a CPU idle state
> > > latency limit for states entered in the last step of suspend-to-idle.
> > >
> > > It looks like the problem is that the existing CPU latency QoS is not
> > > taken into account by suspend-to-idle, so instead of adding an
> > > entirely new interface to overcome this, would it make sense to add a=
n
> > > ioctl() to the existing one that would allow the user of it to
> > > indicate that the given request should also be respected by
> > > suspend-to-idle?
> > >
> > > There are two basic reasons why I think so:
> > > (1) The requests that you want to be respected by suspend-to-idle
> > > should also be respected by the regular "runtime" idle, or at least I
> > > don't see a reason why it wouldn't be the case.
> > > (2) The new interface introduced by this patch basically duplicates
> > > the existing one.
> >
> > I also think that just using the existing /dev/cpu_dma_latency is the
> > right approach here, and simply teaching s2idle to respect this value.
> >
> > I'm curious about the need for a new ioctl() though.  Under what
> > conditions do you want normal/runtime CPUidle to respect this value and
> > s2idle to not respect this value?
>
> In a typical PC environment s2idle is a replacement for ACPI S3 which
> does not take any QoS constraints into account, so users may want to
> set QoS limits for run-time and then suspend with the expectation that
> QoS will not affect it.

Yes, I agree. To me, these are orthogonal use-cases which could have
different wakeup latency constraints.

Adding an ioctl for /dev/cpu_dma_latency, as suggested by Rafael would
allow this to be managed, I think.

Although, I am not fully convinced yet that re-using
/dev/cpu_dma_latency is the right path. The main reason is that I
don't want us to limit the use-case to CPU latencies, but rather allow
the QoS constraint to be system-wide for any type of device. For
example, it could be used by storage drivers too (like NVMe, UFS,
eMMC), as a way to understand what low power state to pick as system
wide suspend. If you have a closer look at patch2 [1] , I suggest we
extend the genpd-governor for *both* CPU-cluster-PM-domains and for
other PM-domains too.

Interested to hear your thoughts around this.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20250716123323.65441-3-ulf.hansson@linaro.org/

