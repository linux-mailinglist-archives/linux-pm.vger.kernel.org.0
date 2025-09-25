Return-Path: <linux-pm+bounces-35422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C35BA1B07
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 23:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2FB87BE43C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 21:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0124A049;
	Thu, 25 Sep 2025 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNR0p0Cr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A8C1E573F
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836952; cv=none; b=DYgTo/4bMhbI1FbH1IhbN7ErnvH+aFto/AqNewwiH0VIXAIVGXqhzWMbQt0VO4Up8/zs920jxspytb3LV3tFRzyH5+npAy+9/HEA4MP4GkUfldFweGWZ6/U0Nw0L9wkJQcdyJ/ck1NYKbhjRKV4zJSRhCNwcWUUzNUmCaqBEXqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836952; c=relaxed/simple;
	bh=0zz+zlV/h+YdUE7L0q7xwlAzVpf0NAuwuvJYaO/dqXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzKYB0kDfU2NTf4lQa4rd0B7/ko6ldiz7vc6xE+NvyfQk6hSoSqq6SKCwfClxrIaO/rF0UwyJO3nPYv7nqoeYzDWzQgz5FdyLXgPb1cFdf9HKGkBKb8puHn85hUku6Flmtfg77kJvcmhZDciFhVA27i+XMF/yNpD/4bi7eDxhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KNR0p0Cr; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8e3d93c0626so1074873241.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 14:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758836950; x=1759441750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWnxKjjg3IdFv7NXQ56rxUnSHi4RjgZEkDrUKCiu4wM=;
        b=KNR0p0CrpxbT+q1B6MFMT9cX4H764lLe2f43btteIuKJGy16uUB9R/t2fDes1QPFrp
         dbXY6QFTWPy7RreKMViA5gEe5/OqegSTAN34yLWhi00yqSYgk543+dpag9nUeQVuQQ3c
         jjizmSL0MoKGOUxOYneIePKtklZAcDPPyxMrk+y8I5OT0Q6Vz2yYM/URslG/cbJBTHz6
         Q0NV1Ol4EqIVpbBxO6gD68XLEmHWwohQ29+awNCFmBKCfyZXgRTfzPT2QLSk9oSxzRYN
         /MlQjOcZjfEPbXnPrJI+w4+JUqt3EzYqacuNdWvxrQeQ5QAWy2Hnf4DYLrBUo8cLb+ZU
         WQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758836950; x=1759441750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWnxKjjg3IdFv7NXQ56rxUnSHi4RjgZEkDrUKCiu4wM=;
        b=wQB4i3Ppuer5+HlvZ3M0NjFz2ULO9NI2iH1kFbETng3Ss44sLP3MIq0DutKQ3JWqph
         SQD+Y9JuzSyzpN+mwchviFBKN82e/S9g3I5C3Ae/AB4RYifhnQ8nJDHZ1I0MB7XR+LIQ
         Fbc9pPJcWhT2PYxp9kP40PmanTvTX8WcUjRZWSIo1vVmvo3Os6aSxNAU2vsadjmSHVqW
         efEZUiv7z1OFod/YXmEI9eLwA07z2IKuDJ1KTBVR0w+IgZRzh+eNeGV+XToaBZlcK4Yv
         leNJLIUmzjS8yRwU1VivW9beasHsVnY6dM9eTgtNJrTmsLwQXruG3z3gThQtTFuSau4M
         X79g==
X-Forwarded-Encrypted: i=1; AJvYcCXaRtAYmyZpSamRMstVIFuHtaqh52NJlCnOKC6EUCN28yr1gefdoaggRjt5onkwDPLopy+cMFzsEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwL5A1/I4A+UsmVJBxyRK8YYiOYQRFcOmpVJR3fbUAzt+uw1FTz
	QKimS27QmLJ31XeCJtODEertDGhfYCJfPyOPvmnfi4KRRJUL11iWf29Ru8McwtXppwwskQCwJMF
	mWb5eSW+80weA5kU9tFJWgpgjHRge7hcNlSgtEVGE
X-Gm-Gg: ASbGncsqRdgzN80L2fNEF0U6JCG41hlvhI/O1p9AztBGRrx/tPBvvGGRqveG0AdarOP
	scpCWiE+afU8xxoyFQ3+OiSrnTlebcMKfZyx6Ea1lORIC1icWYlCddMgXjicqOtxBmDsQyFv4+k
	JLlm8L+qbZnNs4mKhQoE9+lgZM+P7i40tAokEePj3hYKYrGBdVdWIcHQGYlyFMMmRebTHmm+8Zl
	tYY9FRA90JYhPqEkHD8Tr/3xByWFAx9Ltb8zsAHCdw2
X-Google-Smtp-Source: AGHT+IGW3IGcV5PFx26sBUC3o5KQKz0L+yhUmcatupyzMMfX6K50TKytxIHLN/TtYzhr65CzmVBHguoTSQdL6HZwja4=
X-Received: by 2002:a05:6102:6109:10b0:584:7aa3:a329 with SMTP id
 ada2fe7eead31-5ae1498e243mr1554315137.4.1758836949517; Thu, 25 Sep 2025
 14:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925115924.188257-1-ulf.hansson@linaro.org>
 <DD1XOHE6P5OC.2JUQRAGAE1KTU@cknow.org> <CAPDyKFrKP2bdpKTHzqDdhEpRAjYu+PFd2Bst=-WPddByxcAX_w@mail.gmail.com>
 <DD22MGF3HNLM.Q7S70RX4NZXS@cknow.org>
In-Reply-To: <DD22MGF3HNLM.Q7S70RX4NZXS@cknow.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 25 Sep 2025 14:48:32 -0700
X-Gm-Features: AS18NWAGOAAorHTgXiAOX4nfP6hG9rqbItxzDXqOiV7WiydESLBuu8CfUToVl8g
Message-ID: <CAGETcx-WY1x_ud8Ef1jbpYQVtFv7MZHMpHfSVKA9R9tya0Lxjw@mail.gmail.com>
Subject: Re: [PATCH] driver core: fw_devlink: Don't warn in fw_devlink_dev_sync_state()
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:52=E2=80=AFAM Diederik de Haas <didi.debian@ckno=
w.org> wrote:
>
> On Thu Sep 25, 2025 at 4:26 PM CEST, Ulf Hansson wrote:
> > On Thu, 25 Sept 2025 at 15:59, Diederik de Haas <didi.debian@cknow.org>=
 wrote:
> >> On Thu Sep 25, 2025 at 1:59 PM CEST, Ulf Hansson wrote:
> >> > Due to the wider deployment of the ->sync_state() support, for PM do=
mains
> >> > for example, we are receiving reports about the messages that are be=
ing
> >> > logged in fw_devlink_dev_sync_state(). In particular as they are at =
the
> >> > warning level, which doesn't seem correct.
> >> >
> >> > Even if it certainly is useful to know that the ->sync_state() condi=
tion
> >> > could not be met, there may be nothing wrong with it. For example, a=
 driver
> >> > may be built as module and are still waiting to be initialized/probe=
d.
> >>
> >> "there may be nothing wrong with it" doesn't sound very convincing.
> >> So there *can* be something wrong with it, so warning sounds
> >> appropriate? If there is (certainly) something wrong with it, I expect
> >> an error.
> >
> > Sorry if I was too vague. See more below.
> >
> >> FWIW: most of my drivers/modules are built as modules.
> >> I do seem to run into 'problems' more then average because of that, bu=
t
> >> to me it just signals there is something wrong ... which should be
> >> fixed. Not silenced.
> >
> > Well, why is it wrong to have drivers being built as modules? They

IIUC/Remember Kconfig correctly, FW_DEVLINK_SYNC_STATE_TIMEOUT should
be off by default? (if I don't give any default, what ends up
happening?)

If we can assume, timeout won't happen by default, then the only
people seeing this warning are people setting the flag or setting the
command line param. So I'm okay with making it an info.

But the "sync_state() pending due to" is for the default behavior. I'm
assuming without the sync_state() supported added to power domains,
the ones getting this warning would have been powered off? But after
the sync_state() support, it's not powered off anymore. That can cause
increased power usage. Seems like something worth warning about.

Also, another thing I want to understand is, for all the reports you
are getting for "sync_state() pending due to", is it actually correct
to have them pending? Or can fw_devlink do better in those cases and
turn them off? It could be a driver fix/fw_devlink fix depending on
the issue.

TL;DR:
1. For timeout messages, since timeout isn't default behavior, I'm
okay making it an info. But
2. For pending sync state messages, I think it should remain as a warning.

Thanks,
Saravana

>
> Nothing wrong with it at all. It just means I notice issues (like [1])
> that others may not who have modules built-in.
>
> [1] a52dffaa46c2 ("drm/rockchip: vop2: make vp registers nonvolatile")
>
> > just happen to be probed at some point later, then why should we have
> > warnings printed in the log due to this?
>
> I thought the failure of the check was more important then it apparently
> is. Then warning about it does seem excessive.
>
> Cheers,
>   Diederik

