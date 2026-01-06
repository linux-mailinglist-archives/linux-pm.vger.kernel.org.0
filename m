Return-Path: <linux-pm+bounces-40316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E86ACF885C
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 14:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2599C303BA84
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6F0331A4A;
	Tue,  6 Jan 2026 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glpoJe4G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17933123B
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706140; cv=none; b=DtrRfo5Ww/JnAYmKjuUPc/4JJy5pyg+bZaqclCWNsx64yUcTYxT75/aqA81zpzJBiRZTGRKAgj/FvncsWtsIZLyVcowt/SERKsv0wza/hFTDTi8I13K9Bb36uAz2L1F+j9a8ci9cy++oMuu8l7rwmc2N4vHhZgCZ9HTKG8oosvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706140; c=relaxed/simple;
	bh=1P1MLHblIEblLscCyAsxLjS0olkfH791KSwC5KO7UyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdoJU58TqrTEXGhwBqKiPTN9BF5BTdIz+eJ1STJfNhPcauZ/G6QOa5JpY1qiGafA3GBbiwHP9nU68lX6zRYpGGDWLsi8Qd7DMtkGvoATP2zK5I5xrRkl6s91zCDUoPf1Uv1CGVCwXnW7GWvzO3XB5TPjd1WnH1nQv7JnoJlR0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=glpoJe4G; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-598f59996aaso972368e87.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 05:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767706136; x=1768310936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1P1MLHblIEblLscCyAsxLjS0olkfH791KSwC5KO7UyE=;
        b=glpoJe4GWHHxqHWCpSNe8Cu35qxTGWuT6Gykbcnxz9hvemuxBthzdOq6N/y2Lyd53/
         4E3GXGdDOLE9g60dnlEQzKsFAEwSp4v4y7AW0vFlxD1NDtW6qjM6eraI+G5qWvhyno25
         kIKm7vFc4u64jzspJn8/QPwFvwdvy9mm54GYPY7gVlDvBc4a7qv8/7AEfWndIXgYYFCF
         Rbl9bfZ2NUzm8TszT7rSE8lQRNHiuCBrDvIbZ4rkeEHKzMU2vKFOLNUk0EoLGCP5f0s0
         +UZlw30AgdoWRYkzirD7Z1MCDr2cVNaaimQme6DUURrPNkGEvLCffdr5UXhxWkLnfLE/
         rO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767706136; x=1768310936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1P1MLHblIEblLscCyAsxLjS0olkfH791KSwC5KO7UyE=;
        b=rxmuPTcBvpC/Ru1puPHxs8fDBWoMAmf4BoucQZLGTsL5ASKRsJs9iMJLBJyuwILjWo
         OPVJXIAyUXOZ/QdrZl1Sv/rUs1ZkZ2Fu5fek4y3PEZrVGhCQt0KDZfgrcpoErOibqBdu
         6mRPf05bvImiOziBu4pdgNFOsEqPk2NZOVXREad3bpBbeGb4fA5U7cIlMUXBqYYRIU4Y
         mexGSPXn0smiLFVEurI4UiHc4e270shVCRM7o+3tGVNyoy9ZtfTeRtlDLrspXFEKUAJz
         tcgcIUznO82I3NRf2pwsk/fJnzGS9RHS8u4yhTs8NH8F/XttDIZkenIyPSEE/jVfci7Z
         f16A==
X-Forwarded-Encrypted: i=1; AJvYcCWQ2Is59ZaL9puA6We7FTPvGnuHTZi67eXF3ivVGzVjIXZC17Z1y7VH9kTP0Ec6CEaterq/A7RtcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIMALwnbssBuDF0/ppu2urCC5vERnfyXiE3Ktx0FanfToxBeMo
	guSmDRDIv39tXKFbkv2b15hGcJvHY0Pf7tq6DtBS6WJTfaQNxN95fwaO01goYP3Eg9yL2u8c+Cx
	BqcnStSOTHve0IAT4lqNt1drlRpz/66yG6zaUcPD6pg==
X-Gm-Gg: AY/fxX4Y4yrSLe/vLSx2onLjOeMqJuIXT/hsvik4mZeFde0bVn63BmIpP8UEwrbnGRs
	b83zzhQc0MVdLgfVFv7GlsPdpi+1kwzsoznBLdJPnu/h4Jwpch+ba0IVy5D5MfBWlmSLjX7mqmh
	oYN58is0nq/IHvZROZZqDjx4F4QKsqLONTzf84l8BwO0duvVBg82cCN6DxZ8N5lTFkKFVz+ylhW
	9tp0rlsc/mdiRsl2ZlWHgGTRjqMnpQCKqXuRnlX8XbsCNFhwxagOj6btx57KYQt7XTmz/U=
X-Google-Smtp-Source: AGHT+IHkKfseNVlbexy7OYWanrOUhCQ9xbT4x6amCXeiCeHgnckAsxqlsczo+X6SDJmlQDkKr5zQ1Uvoi6Pw/dvfyTY=
X-Received: by 2002:a05:6512:688:b0:595:7854:af77 with SMTP id
 2adb3069b0e04-59b65225f3amr1166436e87.22.1767706136101; Tue, 06 Jan 2026
 05:28:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205015428.643-1-ming.qian@oss.nxp.com> <20251205015428.643-2-ming.qian@oss.nxp.com>
 <CAPDyKFpt-GL-RFcJ5mTWFqaRfy1dQJ7LL8OBCoQK0+zPDFEzsg@mail.gmail.com> <16eb88083b68e3701f22799d8ccc20b800b59d61.camel@ndufresne.ca>
In-Reply-To: <16eb88083b68e3701f22799d8ccc20b800b59d61.camel@ndufresne.ca>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 6 Jan 2026 14:28:19 +0100
X-Gm-Features: AQt7F2rDAkeOIKvNG1n_1ix69cFZ19Y_sfdt-a0UsEok8udvX69D57IFSE6PaYY
Message-ID: <CAPDyKFrWx3FwNDAzYrsQTaoZtmaM+bnx=Q7c5vxjntv4L06BiQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] media: v4l2-mem2mem: Add a kref to the
 v4l2_m2m_dev structure
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: ming.qian@oss.nxp.com, linux-media@vger.kernel.org, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, benjamin.gaignard@collabora.com, 
	p.zabel@pengutronix.de, sebastian.fricke@collabora.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-imx@nxp.com, l.stach@pengutronix.de, Frank.li@nxp.com, peng.fan@nxp.com, 
	eagle.zhou@nxp.com, imx@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Jan 2026 at 19:08, Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>
> Hi,
>
> Le mardi 30 d=C3=A9cembre 2025 =C3=A0 14:39 +0100, Ulf Hansson a =C3=A9cr=
it :
> > On Fri, 5 Dec 2025 at 02:55, <ming.qian@oss.nxp.com> wrote:
> > >
> > > From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > >
> > > Adding a reference count to the v4l2_m2m_dev structure allow safely
> > > sharing it across multiple hardware nodes. This can be used to preven=
t
> > > running jobs concurrently on m2m cores that have some internal resour=
ce
> > > sharing.
> > >
> > > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > > Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> >
> > I certainly don't have the complete picture for how this needs to work.
> >
> > However, I was thinking that rather than using a kref and having to
> > share two specific functions to update it (v4l2_m2m_get|put), couldn't
> > we just use a device-link instead?
>
> The device link seems to be intended for power management, I'm effectivel=
y not
> familiar with it, so thanks for the information. However, my impression i=
s that
> this is indented to describe power management dependencies on siblings, b=
ut this
> was done differently on this SoC (way before my time here), the DT seems =
to
> describe a block controller which is common to the two (defective) cores.=
 So
> power management wise, its already handled.
>
> Be aware that my intent is to rename v4l2_m2m_dev into v4l2_m2m_sched. It=
s not a
> dev wrapper, but a helper object that will schedule work coming from N
> v4l2_m2m_ctx (per open() calls). Making this helper object ref counted ma=
kes the
> live-time management a lot simpler, and since its not a dev wrapper, this=
 patch
> is not creating a second refcount for the same object.

Okay, fair enough. No objections from my side,

[...]

Kind regards
Uffe

