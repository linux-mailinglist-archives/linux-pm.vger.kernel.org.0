Return-Path: <linux-pm+bounces-7668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50668C037F
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 19:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A351C20400
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 17:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F5512A142;
	Wed,  8 May 2024 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjSS6GNw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD62127B5D;
	Wed,  8 May 2024 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190234; cv=none; b=O7WbpG7Nj3NRkZOks5BlYS1aim77lSdukNb+otx5IONPa+8yEKJCmp32wCu8UQZy5bxiB8eh1DrfmCdZ4EUvhKOzVDLD4uG/7+rJpbNcN5t5X+UEGCVCJf9+/2j4nfuXRmW3lfnsjJCjLCw5ZpgeKORTRvS6eSBCNQy/2sjyqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190234; c=relaxed/simple;
	bh=GlmaXEpUPEAQv38l0+uXNYHgdFDEfZFJKr1OuTg/q14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=md2S6h+X430ZdB74RNi3cAWP8BeK9Ux2+3U8dvq49rnqDeI+cbbDDKB5UO0X2BRUtpQq+D9Zq0RDA0+QIlJRdWsUthb4V2eOj2KYC3O6yX/xAoeNus2Fe6ijpVhWieajkYSuoy5BABZvYlj4MXHiQbQJeXy6Eh7u3jQCFny8Gsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjSS6GNw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f45f1179c3so46814b3a.3;
        Wed, 08 May 2024 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715190232; x=1715795032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2iBgujy0OnahX2J/HXjxE27YjCfQEv+29oMFARQDLY=;
        b=TjSS6GNwfjGPWkQULp0DM1GGyowNnzxy0/1tzOLbqacZH1WLJVSNzkebMTWwi4ky7B
         zU6pfDb2dr5x086gDq45SiEkKwWgJxNxZ3QD986quani5ywmJxeZMpsVXsSZvnzwtr66
         ZsQyfyftQ3bIrJJDjo0t95NGQmjybg5o4Z2iYm6+GQOMDXV+iCnJHlsmeS4t2ZIZZnE0
         KQVAbgOxykpnp/TfXiewpUgmV6Q+R9LDsqRr6QCuqFHsbZic+tZW7KCkatiMcbk4SLVO
         rv0+wQESfpQb6HMbHo2JZgq4Obj0gdODADI4fQ1aqoU+vog89deKm7cAXa6y0hukk7Qk
         sO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715190232; x=1715795032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2iBgujy0OnahX2J/HXjxE27YjCfQEv+29oMFARQDLY=;
        b=uCCWa15RzP+sksSyfDN9yU6AeXztPO4qQbwkLXj68vGBp72Bi2xz7v6C6A/bkL6kde
         eKnwiuGXgfyFZ7NaSLP/AnmaZQ2oLDc7cV13LzCUYUe1ODZ0yVP97XXaev977d82lyX9
         5beFuNL+GJqvx+bzulnXE0CE/MaGa7JwqlFISboN9dt7J/JOcUVR4PVHo7jb7OgAIWa3
         X2eqNkCYR+fljBKK4Wm7GX+oN/AHZvaEztmOE59uodqnJQNxVBGzQUyCV+avwGXll7N1
         sQxppTl1SOaJVUsBlifWjXZ0GeWOc+o7CBtk1/TC7DJFkS2vrCFu28FGMpRRYD2N/qN4
         SzEg==
X-Forwarded-Encrypted: i=1; AJvYcCUhW/VZL07OJFLQ2q0xAKBaBepHlz+w+YKH9PKL1ABls8mIcHXRNVsLGy5KM8c3LpY6kSq60Mnsrggcwvhp2iZ/YTzn2AWE58Q79e9yqEPNgRimkBZi63njDuqpS3zky64oABMLG9iDw8z6NgxkuGn8aoISDK0yj5nKeswtWnY=
X-Gm-Message-State: AOJu0YwspZUptIxs0i6N6pafbGP4bjjYmT74TSx/tVo1lFRJcvrwBLbO
	hCduTsUVOGijgZEEhNm6ZzAFTSiiXDzC9ie16jital62HWm9HbdeawAY/IdhPFoUfKB7s92s4gB
	ZEktS0yAxIU27JGKZ//lu29V7dSk=
X-Google-Smtp-Source: AGHT+IFNCDDSAiSeJeoQ+30FLHwPJeK88LACkFxqTrxmJnoIsjAJHHUfvL9LP70Z6C6Vj3Ca1UikUQhh+pxiYdXUWaI=
X-Received: by 2002:a05:6a21:2d85:b0:1ae:13f0:9bfa with SMTP id
 adf61e73a8af0-1afc8db7e93mr3770555637.44.1715190231927; Wed, 08 May 2024
 10:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418155151.355133-1-ivitro@gmail.com> <20240508174048.GA5257@francesco-nb>
In-Reply-To: <20240508174048.GA5257@francesco-nb>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 8 May 2024 12:43:38 -0500
Message-ID: <CAHCN7xLnSEPzvsWbm-+JquJrpOfMFwaE3Hd26Qhv_WqGaweUaA@mail.gmail.com>
Subject: Re: [PATCH v1] pmdomain: imx8m-blk-ctrl: fix suspend/resume order
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Vitor Soares <ivitro@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Vitor Soares <vitor.soares@toradex.com>, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 12:40=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> On Thu, Apr 18, 2024 at 04:51:51PM +0100, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> >
> > During the probe, the genpd power_dev is added to the dpm_list after
> > blk_ctrl due to its parent/child relationship. Making the blk_ctrl
> > suspend after and resume before the genpd power_dev.
> >
> > As a consequence, the system hangs when resuming the VPU due to the
> > power domain dependency.
> >
> > To ensure the proper suspend/resume order, add a device link betweem
> > blk_ctrl and genpd power_dev. It guarantees genpd power_dev is suspende=
d
> > after and resumed before blk-ctrl.
> >
>
> Cc: Adam Ford

Thanks!  This is what I was thinking from the other thread.  I just
didn't see this one.


adam
>
> Francesco
>

