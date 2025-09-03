Return-Path: <linux-pm+bounces-33753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08553B428C7
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 20:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17D516B1BC
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 18:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A21368092;
	Wed,  3 Sep 2025 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV83WRpG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C01B0439;
	Wed,  3 Sep 2025 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924591; cv=none; b=h8tCG+0H2BX78RnPD3lyknTE5b/jrPre/ZMGjmjQsPcwgjpAAxPYL700wV51aX4V4LMZW4F1pibU4dt3kjn/o/dMbZ8vwFbUcX4A6BH8FdFyVArZblMOfB86LuVoZPUvNsLz0ifdgTJ6uTeTplGYTbZfDhIDyVi8NtieAqysQwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924591; c=relaxed/simple;
	bh=DxGbF8nyuy2x1Qe0JywEi7i8GgYPUaoARbWOEZzLKoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBpB+wC9ux3hXOM8eZt1jAVUbFI2fC9kUaSwLBXitxsxDHmCChw0Z1g3HuGUUZLy2MgSPTFFXU2hIiDo7DUKthWYy+y9mOsma0ka7bDjzTL5q5WkjvLe3TKxaKIMklK1yHaVNEeL++JFZwX3DzlRJt/MfBNumY8jKnRRlF3+3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV83WRpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22A3C4CEE7;
	Wed,  3 Sep 2025 18:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756924590;
	bh=DxGbF8nyuy2x1Qe0JywEi7i8GgYPUaoARbWOEZzLKoI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GV83WRpGnwyEV0MUKSCaGeIkw9kXlys0qESYwOehY/3xtrSk7s6o9sMZCzWo7q67N
	 POugD1LGlL8PWvCWQqeasyX/SaRpZr082Np7/5rvq304wG2aBwysqBZEXvEeVPZke7
	 L8xIusKFzUralRBOY+oWzmFWz0QIqJNIHcI9DMEv4gC5W4TC+hbHrmDXCS2qjNQHNX
	 BVoBdqnGgZDn1gIsNZwcUQtzWep6SBLKkeR/mfmueltGtRIFLx4ayqsHZZtQqBTYn+
	 /lXXglOT8N7IWbSBzvy4mp1RQ5zkoOHyUrwq3jQ5XP7v3rMYHtjmRViYcslOy9U/XD
	 E/6BLTUyDm6+A==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-61e74e59d8fso91808eaf.0;
        Wed, 03 Sep 2025 11:36:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDhWVLz/sn8M/9vcuwuMoS74AMuLogScj65LVXelllkxKODMY6+Mk+1CbEIwYPs6uy1StPWTrKnvgTbFU=@vger.kernel.org, AJvYcCXeMv5rGb1CQMyeHsqEu+FvF2+v6H2Vnk/g35gnXzlt/mkWOzqkTUmZytCBqvy7eO2biogtFsk3b8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbM0SyDA+rxadyUUDa4FqlTE480s7GZ6s0DjXY8sccD6mJYSSF
	xDfjUSTEpFyLZvPkpYUXrcoBjMryFdLSzFou5YYbAHRFcqdzEej/jszTuoZevhAYrWyPZlKJZSA
	4AwNrdta1DAREd/34QK41Vcvety1W17U=
X-Google-Smtp-Source: AGHT+IGxEVBXAzUtzz5LDGx0UWbbjZ0fGVov7RkAQBFfSP7bN7hFDxN7tzQnRyxhfbBcLgETPtTAm1VTcCNPshwcVDU=
X-Received: by 2002:a05:6820:c309:b0:61b:f98a:2f19 with SMTP id
 006d021491bc7-61e3195183bmr5496413eaf.2.1756924590085; Wed, 03 Sep 2025
 11:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901150653.166978-1-osama.abdelkader@gmail.com>
 <CAJZ5v0hrKBNxDeZOKpUXyuZV7LRUX4ov4ifEGDtNMrA8km6uOA@mail.gmail.com>
 <aLhK_zMvtkdCtsHR@osama> <CAJZ5v0j2ooBwnPWKjXGyYOOBtjs6zbAh-+jaUaV5u7sBi87+Rw@mail.gmail.com>
 <aLh62dIWcHtWv2uj@osama>
In-Reply-To: <aLh62dIWcHtWv2uj@osama>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Sep 2025 20:36:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jpAm-KrS0k4be523ygbRMPjSDGgNas7ipwpd9kKacqKg@mail.gmail.com>
X-Gm-Features: Ac12FXxMug-OuZUCmZo3ji2RSEI6m_lTCwTED6lG6J9lQfpnDoPqvzkfMduKHKE
Message-ID: <CAJZ5v0jpAm-KrS0k4be523ygbRMPjSDGgNas7ipwpd9kKacqKg@mail.gmail.com>
Subject: Re: [PATCH] thermal: hwmon: replace deprecated strcpy() with strscpy()
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 7:29=E2=80=AFPM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> On Wed, Sep 03, 2025 at 04:21:35PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Sep 3, 2025 at 4:04=E2=80=AFPM Osama Abdelkader
> > <osama.abdelkader@gmail.com> wrote:
> > >
> > > On Wed, Sep 03, 2025 at 01:50:03PM +0200, Rafael J. Wysocki wrote:
> > > > On Mon, Sep 1, 2025 at 5:06=E2=80=AFPM Osama Abdelkader
> > > > <osama.abdelkader@gmail.com> wrote:
> > > > >
> > > > > strcpy() is deprecated; use strscpy() instead.
> > > >
> > > > So why is it better to use strscpy() in this particular case?
> > >
> > > Thanks for the review. Technically, there is no change since both hav=
e const buf size,
> > > it's just for consistency with other drivers.
> >
> > $ cd linux-kernel-source
> > $ git grep strcpy | wc -l
> > 1187
> >
> > What kind of consistency do you mean?
>
> I mean in thermal subsystem, it's only this one.

So please add this information to the patch changelog.

