Return-Path: <linux-pm+bounces-10187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9931F91BD76
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 13:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CAFB283F73
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 11:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AE9155A59;
	Fri, 28 Jun 2024 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew49spsc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D936B11;
	Fri, 28 Jun 2024 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719574272; cv=none; b=cN3fwGdECkhMQspbywpXGdY39sEgZltqaU6GtqtnfsiTJEd7OpN3v5br42OXB7DyKY5TZTScTgiF1Y6f6Y2NAwFZqyYt/47kJ3qYX9OqCHPDDNHwKrcqGN6GGmc2UuPk1xiB1w+fqC9A2/lMfNdq1alwVMwd5hO2LVK35jI4z4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719574272; c=relaxed/simple;
	bh=TNbh7kr7o8ZhrD0QtPetaMUbfVxV7BCiJh8Y/z/LoUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3wk391AFZYdGoByOBeY6AiBP1a4/6/pWAJRgQst/lr+oMG1L2KxRC/mNFf0r5AgsObWsN0SM+hSJzYLbzYh3n1We6pmMtlI/myJ0/cBfNTai3K4wmGouKhU5yDiWIDqAkeF+kXxiHzrns+NY6LZQRUZtDOHpGfkJQVh6Fz6Uxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew49spsc; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d20d89748so599984a12.0;
        Fri, 28 Jun 2024 04:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719574269; x=1720179069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNbh7kr7o8ZhrD0QtPetaMUbfVxV7BCiJh8Y/z/LoUY=;
        b=ew49spscFiHUDHR0pCDX8XtIPU9twBdbGVyD+jCS5nvgVGXRhgVQ21oFT1V2yJwwkj
         WQjP+W71YFrd9whXiHHPRUfgSc4zbygNPqm+8U0moNkWOEzqLWHTyUY73VxcM1m9fX5V
         VIG0+HCiODNMle/+RrIKgrETbiXh8fg2UaiDy8e9a9z52zZevXFPO/3ZHPED4fQnJuJv
         +s3/1QYsa1l6Pv+4/E08UIRisve1nJoSPSQ4Wk1NViAvuHHwnQGNCqnzKG81eD8OeYCE
         C+CvBOQlemqMhoC36IfsmceoeN94pN0+fOuydXQAevI1iGMW75tDiJ96ayUkwHOBGuJ+
         kabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719574269; x=1720179069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNbh7kr7o8ZhrD0QtPetaMUbfVxV7BCiJh8Y/z/LoUY=;
        b=j4IbvbrsbM6kyE3gbQOnEBVjWlf3a/xvYoEQ+bUUpmXqUdE7pGPMl618zDy+UDI3w3
         ypVerc/kvtyb/H/469TiKuhnjA5thAjtfS77fhZaJWSWKUVU+mI9DqqV7I9oTsn9i9qm
         NbjzpFVcYTWpofZZgsA9NUkqdvF1SOHK3P1eDpdxl9hUxzet771vCa+pKuLtOzTPnm5l
         Efqj8q1mzutKy00oTk7O6ylJm38IQcotkgZHYuTSRT+6M1t0FJmgYLuww2rimGYsbXBQ
         abM20eoxvuEe6Chcblcof/e0ij0+fu79mejbTOqtzUFFl5DD8qbuZ4Q69tonBriaQG1x
         cQ8A==
X-Forwarded-Encrypted: i=1; AJvYcCXD8E2dY/KF44bq+u7+URzwWezDZMPPb5Q8XEsor5CO7CPesvnb8fvaHwuJ6pZLr8OuUSkZgeRqs5QvUDsUmfbNaeODlDnfjw+u77RnIqEuYmGoAgAVvPejAB68T1onYdX5rESK/Hw=
X-Gm-Message-State: AOJu0YyeTWjGcYKOvduUpT3fE8VQ0tNaL1K0qwNYvaLC/RhGR9f0Wl/G
	MTM60OohkL0nH0D0Skh3Rh0t7sgjHwk7lqoQPioQdH1mu8FsvGPXxs1M3dZD9H+0a8qk5qaHtwo
	tRU6sGF93TdlHPvtnpETu4sOp5BA=
X-Google-Smtp-Source: AGHT+IGr5leLxrSm2FuRQCxaU5tFV02KFH2s7nnXe/Arg9OQSRUvFxehjob4WYaZ+ZFNSh6vDdF83E+R3D6z+xuQaqc=
X-Received: by 2002:a05:6402:35c7:b0:585:f46d:f573 with SMTP id
 4fb4d7f45d1cf-585f46df576mr1781292a12.0.1719574268511; Fri, 28 Jun 2024
 04:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-fix-help-issue-v3-1-85318a3974e4@gmail.com> <c9df6637-6055-4668-b80b-a1a6e6be445e@linuxfoundation.org>
In-Reply-To: <c9df6637-6055-4668-b80b-a1a6e6be445e@linuxfoundation.org>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Fri, 28 Jun 2024 13:30:56 +0200
Message-ID: <CALsPMBMeo5E9ZND0bPK089VHBZnybsigkvoC2r8BLCTjYt9QFA@mail.gmail.com>
Subject: Re: [PATCH v3] cpupower: Make help command available for custom
 install dir
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 7:33=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 6/27/24 01:49, Roman Storozhenko wrote:
> > When the 'cpupower' utility installed in the custom dir, it fails to
> > render appropriate help info for a particular subcommand:
> > $ LD_LIBRARY_PATH=3Dlib64/ bin/cpupower help monitor
> > with error message like 'No manual entry for cpupower-monitor.1'
> > The issue is that under the hood it calls 'exec' function with
> > the following args: 'man cpupower-monitor.1'. In turn, 'man' search
> > path is defined in '/etc/manpath.config'. Of course it contains only
> > standard system man paths.
> > Make subcommands help available for a user by setting up 'MANPATH'
> > environment variable to the custom installation man pages dir. That
> > variable value will be prepended to the man pages standard search paths
> > as described in 'SEARCH PATH' section of MANPATH(5).
>
> What I am asking you is what happens when you set the MANPATH before
> running the command?

It adds the custom search path to the beginning of the MANPATH variable.
I tested this case. All works as expected.

>
> thanks,
> -- Shuah



--=20
Kind regards,
Roman Storozhenko

