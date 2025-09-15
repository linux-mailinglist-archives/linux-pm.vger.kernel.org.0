Return-Path: <linux-pm+bounces-34678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D431B57F02
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 16:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E62D1885E56
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 14:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684BD272E42;
	Mon, 15 Sep 2025 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpWQljDp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4331F1D79BE
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946714; cv=none; b=qeLNqEX/eq2iMHz8nzkL6ZpmoNbup0BlpyZIGqXna4RGj0NjqR96UUCjZ80UbbXeG/8O8UwMHfvpjR+00R2I2/oEWTasAlCGUeHjzYViyi2jDoXLNQHI4yuDBlig9tuL74Cf4fcPq6XGmbxDAFU1ezVNp5rfhPxz7tFogx+TJx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946714; c=relaxed/simple;
	bh=e+aCqHVKJ7dJBf75rc1ndifsfC04NmgRfdjtZ5Qj96c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSTOLXAOFWe19NeXrulJcpm6ssNYbr4dWYA0H5HaUOiHCln/TE6OITrK/YE/SeLPUF/E4voZc10+8iaznli6hOl+gx1O/WfpgBX9ZC+XKyFKuMSAqCMGjUzdcqdvUwdBnFtxBXV0BsaZcFukUEpizu9pqktk1EyNEiPEqdpLeJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpWQljDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58A0C4CEF1
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 14:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757946713;
	bh=e+aCqHVKJ7dJBf75rc1ndifsfC04NmgRfdjtZ5Qj96c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HpWQljDp+XDYt4SbLHQes88yOd8e4HYn81PYXEdDWdrI+AOP8jdatxR/0FJjXuwpX
	 +VTcsyhQR4ivRSLGqAz72EmESuUE8vzi2fPvZ658Ak3AnzfXpngNPBZ4gPVOKKt5Nn
	 VILR0X6XOZ8dXvcCw7twjBCNm+0Q/Hww4IA2pFD/Qjtoe252Zqbyt4GYFmKUmLvrqW
	 UKN+gNF0cXjSozHUMw/3GIGixsCf2LHW8X0KF3idD5qOCFSOPEbpmLh/i1q3C/RQv2
	 kp1ogR0FKDyVTuqW9LT+NQLnDvRAJQ6YsuxRywAGWPuqe5l5By3/2SQZm/pafN5LeD
	 mSTVNpiNn1h4g==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-746c06937c3so2383299a34.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 07:31:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhIa1C6nOd3jMLZiBjn7zdJD/Gu4B3jrJXGis5wrJjh8cFmM9bveVSGINbY4sSxhw9+dr/ubLd8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4MVXJEX3CBUNmRykRWblVpQJXKYKb11XQFMZR5WWdos7M+aYw
	RH2eKnBv4V2k3Oxn33fUinFfju/JRa7VBdICv4i7iNZYhIpALDO4bQKEa3zU6UOFRYv0PF2AftF
	P6xatx8BCUwRjbScrueU6WjEx1zvfBEc=
X-Google-Smtp-Source: AGHT+IFLtTr4eynOJEwpWbv9jqHw7njjay2+yWb6qsR0EoZiFWYmBrhnEhqXUCW123Dxew55TFs52IQ3TIznM40VBl0=
X-Received: by 2002:a05:6830:6c0b:b0:745:9907:3fb5 with SMTP id
 46e09a7af769-751df0bee5amr11202269a34.7.1757946713198; Mon, 15 Sep 2025
 07:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825185807.57668-1-vivekyadav1207731111@gmail.com>
 <CAJZ5v0gfrTvLgs=PdmRbRRN05GE4Bk8Q7hJdtQfyk3VqaOz7FQ@mail.gmail.com>
 <CABPSWR5cG=xTA72BHayYQTb=24VS3N+=dbsiMcU+gyqTKvNXAQ@mail.gmail.com>
 <2fb11c0970da307cf8cf4f35d35c49f78f82ee72.camel@perches.com>
 <CAJZ5v0iAfgE4RkVXH7GaG9SqvGa0VfVuFi_cLd0utC8oPY0Fkg@mail.gmail.com>
 <99c1c03a9f7fe55b8f73e5574612dc3e1cd1af55.camel@perches.com>
 <CABPSWR6uKR0fz1-jJcJ1_JCsBbXhHioUe3o02DMSP8T18y1T1Q@mail.gmail.com> <CABPSWR4kcdwEvC6zMTOGgME4ZDPpOsdtjheD8ZgTa0iaTqQwhA@mail.gmail.com>
In-Reply-To: <CABPSWR4kcdwEvC6zMTOGgME4ZDPpOsdtjheD8ZgTa0iaTqQwhA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Sep 2025 16:31:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gTtTZt7oE0vME0qRo8nZ=KX3DwF46PhyUVe7e85uZaNA@mail.gmail.com>
X-Gm-Features: Ac12FXwvSHrkpD6oRgoIBwD0II_TD2HP5L0R7ONoO5lfRb3bDZcJG2moMarRhmQ
Message-ID: <CAJZ5v0gTtTZt7oE0vME0qRo8nZ=KX3DwF46PhyUVe7e85uZaNA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: sysfs: Use sysfs_emit/sysfs_emit_at instead of sprintf/scnprintf
To: vivek yadav <vivekyadav1207731111@gmail.com>
Cc: Joe Perches <joe@perches.com>, "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 5:20=E2=80=AFPM vivek yadav
<vivekyadav1207731111@gmail.com> wrote:
>
> Hi @Rafael J. Wysocki ,
>
> Is there any update for me on this patch ?

As I said before, please do not rename the variable.

Thanks!

