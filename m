Return-Path: <linux-pm+bounces-19974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBC7A01CEB
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 01:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC481883788
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 00:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7175F3C47B;
	Mon,  6 Jan 2025 00:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7ZFosQ7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B01C69D;
	Mon,  6 Jan 2025 00:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736124957; cv=none; b=amjsjRaeDKdLwJi0/ZffpxUqyaYjFxGAdiW/X/jQkcmxcEN8Bfkl9tGInTyqdXfSyRntW3oxUXmkobxvcQDFR8V4LJNgF+bssa7c0SAwMhWaI4UIth0V7q1K/E9muVaO9F0y1DhMi5Gm+wseqtd+SJBulP4khLR1pDzQA1ta7nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736124957; c=relaxed/simple;
	bh=5iacpTJgQ5VakTnBQlizLdhO6M8IL4jj5UTXCh7Re6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnjQ77AIf02+539glqq1nkcTGlt+xJzTcY7nnuLX+15fg8w2utqR87lhbxWET4T+JvB/sT0IJjtrWjEWHuhWdUhKWT/d7r7mpsJVxhudrFZc2LnT8StsXENppaTIw7Rp+5pIpYchj5ZsX+zjJKiqa3855TwxpXEd1X4AjclVRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7ZFosQ7; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a7deec316aso51483025ab.1;
        Sun, 05 Jan 2025 16:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736124955; x=1736729755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YN6aE+MuJlFK2b44/x4t1iC0A/Dr6QJNJOQ49JRdhBA=;
        b=I7ZFosQ7z+odK02+CKrWe7oJSBlB8uK3k2MVLxvLq6ShloNuqvJ6nhrTKTNt6ARni0
         nD4D2OkhM98/UUQ/6HHe/LpXHA3xNac9O0Wwbnhg4h1XA9G3m7UYqMGpWvOkamSQ6shv
         QsAtzF8RUKEy7JQcf5Mvvs/ufxOVr0Mm6d0ENAFdQtCv9yNjln1fX2mu8/SMp8OjHfhS
         2saOf8Zqdm1yC7uYmhdXpSwDbEqQsxf8+fzXucuFYUq5Cs7FG/TOSq4PH5DIDYnugVq3
         jucxtuBWx04iDTnpTDBlbpfYbseRBIF6+pdIWIZR2eMATkfjfPIcj8AAz+bTV73Jr4ko
         uFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736124955; x=1736729755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YN6aE+MuJlFK2b44/x4t1iC0A/Dr6QJNJOQ49JRdhBA=;
        b=C5g3H3y514EMniiVBJ0MzhZ/DNuIkPl3LG9WTlcjfSB9ed1pqbjYlhaaVPwNekvVKx
         y8NlNtr46QvZwcmiPTa9MBFqRhnjPoQ5FisFLy4gaoIYrV4qDcAhpS+YClj+jzsIcyLr
         zsh9K29VcWfhfBv2aO3JLtX8TqRDFVQDe3K2qMOEdApp5ShKi/J8VMubyaCPOCqA8fxy
         b5hilf6eVL6bUDbbouENbTQyib+aPuCWIHaBIx1oUzOZ9slHH9gZCR5Hr6Lugh/xw2H3
         cAKZlKvyRjqbCQ8TER8l3hpGSnBLrVlUm0kQyyvahQQOyOWzUmnfRzsnNJHQaj4RB4z1
         RFKw==
X-Forwarded-Encrypted: i=1; AJvYcCUVhNCwW73MHWPRRhyIW/yjPFQt4dyVmqbK29XfdcESQwMgr5E5nDnCjo6UUw/PCy5Wf2J3grgPw72OZoOpEQ==@vger.kernel.org, AJvYcCV2G2OLZwMd4wd+teLESvEkCaF1TI+7vbPhsuvC0SyaeWFBrDrki3vfD3ZEzHEtDJZxJLHMXBrEt7jxHwEd@vger.kernel.org, AJvYcCVph9zBeOVXVQ4cK0wJRDTdYwt30ircSvMm9o11F6DcHzAh8pzHyBglqVlq3edSqF6IHSHmNWJ2Do4V@vger.kernel.org, AJvYcCW1qc7q+ZFOiXkY0QkT+Lxi2d61m5O96MNyEkUPUvVoPnGApW3c82PPWd8FSmf0VAboN8narqE1qhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt9bkKgE0skqSoOMjvJY7caHT+D6WtAPxQLZLfmy+B8WDt6It/
	c54l4WTw4i0idyYk80qgFl446EPwbEVTyyAlHPMnu3AgoADL264dxLRS4/JpynGID56z5AHMz+7
	oVimb/NagVjFuiOB/BQ6jRF7X3v4=
X-Gm-Gg: ASbGncvzQW/yXF/1qXn/4TcEP5X8niHHG6Ppc2KCaoV+c+iaagorcoXhOpIABNT8szR
	CA3eqr2JMlAzjncAwVHyZuVAkemGOIPCfyzTD2w==
X-Google-Smtp-Source: AGHT+IHJYmBSxrbrAmecPUQ24zUko4o/O+WMOcCAM1FBbr8iLzQz0Mn6QzWXyUlMFbvBdDMqznBqnwfKE3rr7sF3iOQ=
X-Received: by 2002:a05:6e02:1d0c:b0:3ab:a274:d73 with SMTP id
 e9e14a558f8ab-3c2d2276f0bmr356917355ab.7.1736124954550; Sun, 05 Jan 2025
 16:55:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231-gpu-acd-v3-0-3ba73660e9ca@quicinc.com> <CAO_MupJ21kOQPZG_=87mC-fQKmL=-K9AgOjriWR=wXCKU0897w@mail.gmail.com>
In-Reply-To: <CAO_MupJ21kOQPZG_=87mC-fQKmL=-K9AgOjriWR=wXCKU0897w@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Sun, 5 Jan 2025 16:55:42 -0800
Message-ID: <CAF6AEGvYFL9Q88c727eFrTgDb+FvnPm2d=6niLu80DM1DJdm5g@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Support for GPU ACD feature on Adreno X1-85
To: Maya Matuszczyk <maccraft123mc@gmail.com>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

fwiw, I did see some perf boost (was mainly looking at gfxbench aztec
ruins vk high/normal, and also a separate mesa MR that fixes some LRZ
issues with turnip, so I don't remember how much boost was related to
which offhand)..  I've not seen corruption yet (gnome-shell / f41),
although what you describe sounds cache-line(ish) and could be just
timing related.  You could limit max freq via
/sys/devices/platform/soc@0/3d00000.gpu/devfreq/3d00000.gpu/max_freq
and see if that "fixes" things.  I don't really expect this patchset
to introduce these sorts of issues, but maybe the increased freq
exposes some preexisting conditions?

BR,
-R

On Sun, Jan 5, 2025 at 9:56=E2=80=AFAM Maya Matuszczyk <maccraft123mc@gmail=
.com> wrote:
>
> Hi,
> I've applied this series for testing, and I've no performance
> increase, and some screen corruption, there's some lines(mostly white)
> on my yoga slim 7x that appear on the bottom of the screen. When I
> move my cursor in swaywm over it, the lines get occluded by the cursor
> and screenshots don't show these lines.
>
> Best Regards,
> Maya Matuszczyk
>
> pon., 30 gru 2024 o 22:11 Akhil P Oommen <quic_akhilpo@quicinc.com> napis=
a=C5=82(a):
> >
> > This series adds support for ACD feature for Adreno GPU which helps to
> > lower the power consumption on GX rail and also sometimes is a requirem=
ent
> > to enable higher GPU frequencies. At high level, following are the
> > sequences required for ACD feature:
> >         1. Identify the ACD level data for each regulator corner
> >         2. Send a message to AOSS to switch voltage plan
> >         3. Send a table with ACD level information to GMU during every
> >         gpu wake up
> >
> > For (1), it is better to keep ACD level data in devicetree because this
> > value depends on the process node, voltage margins etc which are
> > chipset specific. For instance, same GPU HW IP on a different chipset
> > would have a different set of values. So, a new schema which extends
> > opp-v2 is created to add a new property called "qcom,opp-acd-level".
> >
> > ACD support is dynamically detected based on the presence of
> > "qcom,opp-acd-level" property in GPU's opp table. Also, qmp node should=
 be
> > present under GMU node in devicetree for communication with AOSS.
> >
> > The devicetree patch in this series adds the acd-level data for X1-85
> > GPU present in Snapdragon X1 Elite chipset.
> >
> > The last two devicetree patches are for Bjorn and all the rest for
> > Rob Clark.
> >
> > ---
> > Changes in v3:
> > - Rebased on top of v6.13-rc4 since X1E doesn't boot properly with msm-=
next
> > - Update patternProperties regex (Krzysztof)
> > - Update MAINTAINERS file include the new opp-v2-qcom-adreno.yaml
> > - Update the new dt properties' description
> > - Do not move qmp_get() to acd probe (Konrad)
> > - New patches: patch#2, #3 and #6
> > - Link to v2: https://lore.kernel.org/r/20241021-gpu-acd-v2-0-9c25a6280=
3bc@quicinc.com
> >
> > Changes in v2:
> > - Removed RFC tag for the series
> > - Improve documentation for the new dt bindings (Krzysztof)
> > - Add fallback compatible string for opp-table (Krzysztof)
> > - Link to v1: https://lore.kernel.org/r/20241012-gpu-acd-v1-0-1e5e91aa9=
5b6@quicinc.com
> >
> > ---
> > Akhil P Oommen (6):
> >       drm/msm/adreno: Add support for ACD
> >       drm/msm: a6x: Rework qmp_get() error handling
> >       drm/msm/adreno: Add module param to disable ACD
> >       dt-bindings: opp: Add v2-qcom-adreno vendor bindings
> >       arm64: dts: qcom: x1e80100: Add ACD levels for GPU
> >       arm64: dts: qcom: x1e80100: Add OPPs up to Turbo L3 for GPU
> >
> >  .../bindings/opp/opp-v2-qcom-adreno.yaml           | 97 ++++++++++++++=
++++++++
> >  MAINTAINERS                                        |  1 +
> >  arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 25 +++++-
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 96 ++++++++++++++=
++++---
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |  1 +
> >  drivers/gpu/drm/msm/adreno/a6xx_hfi.c              | 36 ++++++++
> >  drivers/gpu/drm/msm/adreno/a6xx_hfi.h              | 21 +++++
> >  drivers/gpu/drm/msm/adreno/adreno_device.c         |  4 +
> >  8 files changed, 268 insertions(+), 13 deletions(-)
> > ---
> > base-commit: dbfac60febfa806abb2d384cb6441e77335d2799
> > change-id: 20240724-gpu-acd-6c1dc5dcf516
> >
> > Best regards,
> > --
> > Akhil P Oommen <quic_akhilpo@quicinc.com>
> >
> >

