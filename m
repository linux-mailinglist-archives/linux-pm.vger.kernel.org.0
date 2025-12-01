Return-Path: <linux-pm+bounces-39001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C58FBC98CEA
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 20:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 592174E2069
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 19:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E33239E6F;
	Mon,  1 Dec 2025 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=it-loops.com header.i=@it-loops.com header.b="YA5tU3cZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF8F221D92
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616201; cv=none; b=LtcOGBEegnAP9ysNwYC+IMzrLy6tn0molB90sNkrfncjkr2YnGegdvsnde+mM2IBFJuWBX5XPEaCsi5z89IPRTq0BYiJ9D7YKxWAcLB/x+7pONgmBB1M3qwZzYoyN+45s5CiXLDIE4dXiMrkh0Qzi1GpcBBGu4r16OhvPRdMD8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616201; c=relaxed/simple;
	bh=SVRmWcU4reDKs5HHBiPJg4YERntaC6a4bjb65WL5Ll8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrpmN46uegbyKrhvNklIa8eF1/S8L7gZhWWDrTCZRCxwljClYsXAkLCKDsNjF1JyfNlxO4rWJN9dCdyov3npvxwiBNmLDKOaH+3otZbOqQfgFRPLOkENgdIvKh/DIgxQYXg733/yQ1pM7gfT6eoMMjTiXC6Fsfi0187kHHrjGhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-loops.com; spf=pass smtp.mailfrom=it-loops.com; dkim=fail (0-bit key) header.d=it-loops.com header.i=@it-loops.com header.b=YA5tU3cZ reason="key not found in DNS"; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-loops.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-loops.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so1298484a12.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 11:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=it-loops.com; s=google; t=1764616198; x=1765220998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9lyjwDqKk+QqPVACOcdksqjAbpRjmOBLHeLAVEc6wc=;
        b=YA5tU3cZ+g3sK66fC72nxQy9/2Bf9ohExSHsHHJTV8YILVHuCUrfDAxEzrXgceadhF
         Bpb1Mf6R76mjtka8lO0+yk/AxMa5oQuWTE41VHlhnoWHAFNN4pxgbolpBKSAWKGdcOLJ
         C1QGNUmMgoOO14IKpjGyLAgEEozOWISy5qr2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764616198; x=1765220998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g9lyjwDqKk+QqPVACOcdksqjAbpRjmOBLHeLAVEc6wc=;
        b=DTNEDheBXGhALuMPcDs1xVpUK1PyQGuaO392WoZqgl/PPRpIoijYpRnfKH7qvrcTlD
         szy+YAAieKU7SxiOAIlvbxRd/1ZtLsjSrvRfyalNneMxIc9u/EGj0q7MKbS8Dl43PjI2
         FMABMGXhbqWppcbXg5vUSYbz9vt0272tyJTA1yXE3M3pzbmiJ/Z24ZSRUt9f7qMNC44c
         wJ3oXBsQ67nbTZjJtsMbUoF5YWUgjS+KOOWYYZZp9qgVx+r0QopIqTuJrSR9QOMUzY5K
         fggtuZQJTtKb9M3N8RjNxpBvyCsLWASEixRxzyIhtUIX5KuYAPvT70QXl7CEKNTcSv5H
         uwrw==
X-Forwarded-Encrypted: i=1; AJvYcCVdvs30dcjmArV8aOROqU6IkJ7lkGgYwnSAZkSBIQHxSa08dqrgYFM6/i3aiobzI379QDbYAqNHUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjr2gsWd1BlbIp1omGleB8WcQ3tgyBxBSdcnipqA6gwvQ//R+L
	ee4/LcGyfhHsOXmzZbGyFTToyyGDE22HG1rht4meQQCaAL8rVD+wsoH6ZxYsDl1YyYtM4plsLgH
	K6m91TmM6s0npvNdt8qEREuCzIraD9gUjgumdTWY8dQ==
X-Gm-Gg: ASbGncs4gi2znRj4pFnA3EPj3l5q7Qp435lVIx3EIRLRQmxjlek8ezYGL0IUGTHextc
	mTVskxddk5eHgVo8CqKiM66Oj3jfGBkMtRcKpb+rGviX+dBc6kQsBpkCWdva9So4HZ8EZBXSETz
	96AWYEqMuU8kv3l4MeaOvixG9F0jpbS1HlrONUif5pigI0f/6fHrBu/lPfU/R+hQR892EFJ7rMm
	4kaojm9YkAzByUo/8gobxy2OgbPDJy/UnGqGr5ib/H0y0BYNnIGQim1RBxygEKAIYOwvQFm
X-Google-Smtp-Source: AGHT+IGOTyOpca8Bkm84/CeGDYKF35ETxinW7GVj+Vtn2G6U42NT9STdY6vw7lpQ0JlDfrhENEba8b6RRkfXj6TIzFg=
X-Received: by 2002:a05:6402:2353:b0:645:d578:13c3 with SMTP id
 4fb4d7f45d1cf-645eb2b58e2mr24564984a12.26.1764616197808; Mon, 01 Dec 2025
 11:09:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALG0vJuaU_5REU55Hg170LipPLj7Tt0V3icn7XzxLY-8+jsx-A@mail.gmail.com>
 <20251120055748.GM2912318@black.igk.intel.com> <aSGTghJyX-u-leL6@wunner.de> <6e7aa10e-9938-4ab1-af14-b3d2906c211a@panix.com>
In-Reply-To: <6e7aa10e-9938-4ab1-af14-b3d2906c211a@panix.com>
From: Michael Guntsche <michael.guntsche@it-loops.com>
Date: Mon, 1 Dec 2025 20:09:46 +0100
X-Gm-Features: AWmQ_blakwbWOT6KrL76uyA3F8k_mQ8r2CJl6T5K_SnWqDq6g2_2g2KzHQYk0KY
Message-ID: <CALG0vJv7ZA8byAF25pKqh9fEBpfgbXk+cAE6s9K1N6ZvVRroUw@mail.gmail.com>
Subject: Re: Oops when returning from hibernation with changed thunderbolt status
To: Kenneth Crudup <kenny@panix.com>
Cc: Lukas Wunner <lukas@wunner.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-efi@vger.kernel.org, maarten.lankhorst@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[cc +=3Dmaarten.lankhorst@linux.intel.com]

On Mon, Nov 24, 2025 at 7:02=E2=80=AFPM Kenneth Crudup <kenny@panix.com> wr=
ote:
>
>
>
> On 11/22/25 02:42, Lukas Wunner wrote:
>
> > Also the photo shows a UBSAN splat in drm/display/drm_mst_topology.c
> > 220 msec before the oops, maybe it's related?
>
> FWIW, this sounds really familiar (resume crashes if I changed TB docks
> between suspend and resume) and was getting an OOPS there I'd bisected to=
:
>
> Resume OOPS from f6971d7427 ("drm/i915/mst: adapt
> intel_dp_mtp_tu_compute_config() for 128b/132b SST") if MST displays
> disconnected while suspended
>
> ... and this was fixed in 732b87a (Fix determining SST/MST mode during
> MTP TU state computation) back in 6.15 (which IIRC, is when your crashes
> started happening).
>
> I wonder if this is related? Maybe reach out to the i915 guys?

I tried this now with 6.18 and got the same issues, now it even fails
for me  if I unplug the dock while hibernating.
The last entry I see is the UBSAN message and an out of bounds index error.

