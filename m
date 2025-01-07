Return-Path: <linux-pm+bounces-20049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBE8A043FE
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 16:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DAB1886CCC
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 15:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01A21F37BD;
	Tue,  7 Jan 2025 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdUXPGyC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64D81F2C4E;
	Tue,  7 Jan 2025 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262990; cv=none; b=aw3DL+ymPcLeNw/aEjK0iZGVxKNcpwwbZsJ8fvTOt+bf/qMsnh0MeoKuxLu9uFmoFGMwsijh1fwCG/d02jaxRiQ6JmECu/x2fTE25Wgsc+NhSa6Sd1uS2SNiVK1xAWrhXnyYwN92hiWjpBmUzkt7imYgmqwejs4VWEaAaZDsErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262990; c=relaxed/simple;
	bh=sJzvWCCziUNdC/Z50YeioK8brZ/gDsfnrfrUwZ2h6E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaZnIhrCIBa7PNlSREkxGrzPOG4oMCDGM3j7ZViK9KGLEyn1yuYDlT6F7AN4YxWnpfdy7AF8Sd8Krha3xz+R4I6UmHQrPuV1N76zSJOzL3RiqdPVP07uy8o30V/mtLwUL3pMTIgJn1HDwSI2ZRcuPkCGd5ykRgenrGqQrLaAR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdUXPGyC; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a777958043so61745455ab.2;
        Tue, 07 Jan 2025 07:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736262985; x=1736867785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEpmGsnYD20KF98YPxRoScx17fqF75iFjcKl5Un5Rwc=;
        b=fdUXPGyCaPbb3YafMa5uTqjbGN/DWDsFan/Lmx9QvxGY/kaiy8Ecwf9gR2DyN6LSzD
         qZFMQ9Dpi69R+TbNas1T7olpjtQQCBoui8PGV0l2UopXuA13EOwO7egMD4+CWTI0HPkX
         Go6WsLWLQI6UCOeQdi3vP6LBUV8pLLrvMaisNFsf0eKLVYVE2f0U+uuytrVpO2V9IVEB
         uPpKZTM1JX6AibOlC3NuqmIsh3GQAJfPVYz1ug0dPrb4LqfthpT9nObbRwBSaL6gmOsY
         sm9PzLZ/6kyPH2OSx2W6rWkh9qX84Uo3snVlFxjPGL+weU6/hGhghC6Fly5169/VZTHu
         Yh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736262985; x=1736867785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEpmGsnYD20KF98YPxRoScx17fqF75iFjcKl5Un5Rwc=;
        b=KFEofpios7zrfsTkOcbHSlqJ7B4Ohm8LN05yi59N24cMqfSU5mYWKhyOif/xj41DVO
         Of0PN9TAcMo/l5Ebd6HyWhVzoeE5yspns9XkBTI0dEz5OeYBXY25ekNAkYpS1ygE3w5m
         vgjeDnvgJq902njwjkMa6DxeBk/gvmcIYMX8dIk7CdHdPwfHkpl8mu8AkaqdIX3X4XW/
         vObbuo24Aqq6P8zgkdZIChT2RGEcl+NaHEw/qodIatYe7L2miIU0n+dLupozMA3NSmis
         0Aafrycxd0TxkTbEnbVjLNyE3baLBnrIJAc74RPUnNmve0D92YqEO679+/sJ3nvcs3wZ
         UgIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjibM2Q5KUHAa6ajznIKTMYuBjLHxPTtqK0xJv5lNSdVabb1U4hKq8sVWp0N6JlR5X9LI1g8Bdc6Q=@vger.kernel.org, AJvYcCVrNwivoPpgU7HcpY2rPHTciwt+YH1BIzN7m4LH0Z8xGmtFK3zZxpD14QKQLv92tYxtRYJQw+GqlRWUXyxH@vger.kernel.org, AJvYcCWNzWYiUCbTuL+Tp0zOaxGXoHJdpK+mMQOYbpSB+iETmn1AovesjqyghYfcy+MgqO+Kp02IuKw3zN2pjUCP@vger.kernel.org
X-Gm-Message-State: AOJu0YxlzJ87/c5EtVyfPox27S81LSr4S0XaZfKIsftmTso73IhKOpaq
	L+XlguJ5ZvKcahlemykTCPpw+KzyQy4g0rvKYhpknjx2SJLn1M2UPtf8GvWk1bxEXCC3iRKd9ZS
	PZtKUV5bIWyh6QST5V6YHb4/ZGDg=
X-Gm-Gg: ASbGncsQFHln5KiQ0ceJjlNk+vk3G3Noj42H6Jio6SVT3671bqxIPu5PDJoZflKtdMc
	8Ta+xxJG3umvWDlXnXLBA3DEbXRl/muAIC4JBEOBBjyXRbNqPmb+9udi96CYzhQpp9GxV
X-Google-Smtp-Source: AGHT+IHlytIOa8SLJD6ilASbLpCUQevKgStkuVESsGuRpq4383tKFP0QuXLkBBL6bO1X1rxhpJ3kjld29+v9vpnSuz8=
X-Received: by 2002:a05:6e02:2384:b0:3a7:fe8c:b014 with SMTP id
 e9e14a558f8ab-3c2d5917533mr523633585ab.21.1736262984845; Tue, 07 Jan 2025
 07:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210165127.600817-1-robdclark@gmail.com> <Z30kWxVxwJXO_z2_@google.com>
 <20250107125840.GB6991@willie-the-truck>
In-Reply-To: <20250107125840.GB6991@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 7 Jan 2025 07:16:13 -0800
Message-ID: <CAF6AEGuXD6rCx8yABH338XSr0Wq6fyFe9Z6fWCh1KPNMbJgiOg@mail.gmail.com>
Subject: Re: [PATCH v11 0/4] io-pgtable-arm + drm/msm: Extend iova fault debugging
To: Will Deacon <will@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	Rob Clark <robdclark@chromium.org>, 
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <dri-devel@lists.freedesktop.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Joao Martins <joao.m.martins@oracle.com>, Kevin Tian <kevin.tian@intel.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 4:58=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jan 07, 2025 at 12:55:55PM +0000, Mostafa Saleh wrote:
> > On Tue, Dec 10, 2024 at 08:51:18AM -0800, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > This series extends io-pgtable-arm with a method to retrieve the page
> > > table entries traversed in the process of address translation, and th=
en
> > > beefs up drm/msm gpu devcore dump to include this (and additional inf=
o)
> > > in the devcore dump.
> > >
> > > This is a respin of https://patchwork.freedesktop.org/series/94968/
> > > (minus a patch that was already merged)
> > >
> > > v2:  Fix an armv7/32b build error in the last patch
> > > v3:  Incorperate Will Deacon's suggestion to make the interface
> > >      callback based.
> > > v4:  Actually wire up the callback
> > > v5:  Drop the callback approach
> > > v6:  Make walk-data struct pgtable specific and rename
> > >      io_pgtable_walk_data to arm_lpae_io_pgtable_walk_data
> > > v7:  Re-use the pgtable walker added for arm_lpae_read_and_clear_dirt=
y()
> > > v8:  Pass pte pointer to callback so it can modify the actual pte
> > > v9:  Fix selftests_running case
> > > v10: Call visit cb for all nodes traversed, leave the decision about
> > >      whether to care about non-leaf nodes to the callback
> > > v11: Adjust logic in 3/4 [smostafa@]
> >
> > I see the level initialization was not removed as it was in the diff[1]=
, so it
> > seems to me that=E2=80=99s redundant as the level is set anyway in the =
callback, and
> > actually looking at that I see it=E2=80=99s not used or printed from th=
e driver,
> > so may it can be removed all together, anyway that=E2=80=99s nit that m=
ay be Will can
> > fix it up while merging.
> >
> > Otherwise, For the whole series
> > Reviewed-by: Mostafa Saleh <smostafa@google.com>
>
> I'm happy to drop the 'level' field if it's not used. We can add it back
> if/when it's needed. Rob?

That works for me, thx

BR,
-R

