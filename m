Return-Path: <linux-pm+bounces-33203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F50CB389F1
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 20:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBF07C47D1
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 18:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8777B2E54A9;
	Wed, 27 Aug 2025 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltXO+4Qr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5954B1DFE0B;
	Wed, 27 Aug 2025 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756321032; cv=none; b=YDmBbz1rtxtUgV7OinKdNBb1krCUHB2B35RMIaC7tY1vnb3BGOfYhy5IjJ0S6YTWfhaWR6yRQcBB6A/KMBDyZytHTn8ppiV92WibLNZivU8lNhlHuCYMMJH+SyncDpO827rJC8IFnYStzQM67+WrfsBBRk720g7pefBJZrH6wBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756321032; c=relaxed/simple;
	bh=DFcwD5wv8boG5Yw+kZoSyddpCexgu/K9NQMraZJx9i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mo+8y8eki4X1HEgL5IP105ziKWcQmlOtJUtPm9w1KjrZD9YAzFacsfFvJEJHL6XikWOsXDeRXK4GuQcQULeNffJfbgUdXjZse2gUODy3o737q5igSmBA4hYh9L6CH9J0tBcPZeymSka+izOovj1IKf9e9yweZBx7quVtbvY7Ekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltXO+4Qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52FFC4CEFA;
	Wed, 27 Aug 2025 18:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756321031;
	bh=DFcwD5wv8boG5Yw+kZoSyddpCexgu/K9NQMraZJx9i8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ltXO+4QrZcKiWl8KcMd/n0W3EtEqJ3EffFBILsTzuhRBgM/Pbuh2CKSU6MWxNvz4O
	 sDAcGoqZQ1NfZS926zQtaxnWo7MEPxrnM3trQhHRQcbq8mF8ruGtSOBB2YObDWpBur
	 dbbcerasz0BrYk6Mn5Sf/GuK3+ycMR86wkXqQ2R2/NyK6QzP8BXImp4FOtudYuJ/UC
	 4QFJSGu8O2Aeg1xFuStBUkkV0huotYRirRffiAGNz0ELr+p29JI0njXpTuFPeVAc+J
	 pUB0sZboY0jc3t/gaLjA317M/++CRkp6fR6O7mAFsmMqf4sjGcLbfzA+Uure3rOi24
	 m4cNBcaFw2uwg==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-743749537caso1030961a34.0;
        Wed, 27 Aug 2025 11:57:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVqZmngs9APkZcyykXGPjdsBoo5Xvhvt9p1ehKxULx/cD6XCLZOMOZXTVuKP3yJHVLLlDw6btDKfMPyH4=@vger.kernel.org, AJvYcCVvaQmKi90y2SIceBzypkb5s88yIll/prBBJ+/broOepRaEzDoK4EG9AqRH/WMZOsdw/2hIs8RdJJSL@vger.kernel.org, AJvYcCWeuSKUgjL2dYDqMhFPUfZPcOmyabPsQ80nwbwENB6YDn3NoMMPicydLEqlva3o9UkSXXZWjXWx7N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFFfyxq9O9k0guutx444dvYBfsdHg88klHEXkFHppSM30NnYa
	ApyN2DaN/HfbGoTQDhRowqyioI0TGygdpCuzs3COJkSm/jFNAH3zl5RjUYWm+7OxO8i5rfFBD4G
	uKotL0LReVB56RiDiAz2sveDymrkcb1U=
X-Google-Smtp-Source: AGHT+IEC2ghCQ0MO1CJCGsXmI5mtSbb6TkKZeWUOoMwVPghWXTpZl6QcvCdI3YgtP05qnKHcAXNzKpCNWfVMRWLM8Io=
X-Received: by 2002:a05:6808:1b1f:b0:437:75ea:6c72 with SMTP id
 5614622812f47-437c544113bmr3155427b6e.21.1756321031183; Wed, 27 Aug 2025
 11:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826150826.11096-1-ryanzhou54@gmail.com> <CA+zupgwnbt=5Oh28Chco=YNt9WwKzi2J+0hQ04nqyZG_7WUAYg@mail.gmail.com>
 <CAPwe5RMpdG1ziRAwDhqkxuzHX0x=SdFQRFUbPCVuir1OgE90YQ@mail.gmail.com> <5d692b81-6f58-4e86-9cb0-ede69a09d799@rowland.harvard.edu>
In-Reply-To: <5d692b81-6f58-4e86-9cb0-ede69a09d799@rowland.harvard.edu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Aug 2025 20:56:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jQpQjfU5YCDbfdsJNV=6XWD=PyazGC3JykJVdEX3hQ2Q@mail.gmail.com>
X-Gm-Features: Ac12FXwZkTPT2-RMDugAYZDU2uopbwIA2WbOc1-Kkou8zroX8GC-ntYgdaMUhSM
Message-ID: <CAJZ5v0jQpQjfU5YCDbfdsJNV=6XWD=PyazGC3JykJVdEX3hQ2Q@mail.gmail.com>
Subject: Re: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
To: Alan Stern <stern@rowland.harvard.edu>
Cc: ryan zhou <ryanzhou54@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Roy Luo <royluo@google.com>, 
	Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 4:52=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> Ryan:
>
> You should present your questions to the maintainer of the kernel's
> Power Management subsystem, Rafael Wysocki (added to the To: list for
> this email).

Thanks Alan!


> On Wed, Aug 27, 2025 at 10:09:10PM +0800, ryan zhou wrote:
> > Hi Roy,
> > Thank you for reviewing my patch.
> > >
> > > Wouldn't the parent glue dev already resume before resuming the child=
 dwc3?
> > >
> > No, in the following case, the parent device will not be reviewed
> > before resuming the child device.
> > Taking the 'imx8mp-dwc3' driver as an example.
> > Step 1.usb disconnect trigger: the child device dwc3 enter runtime
> > suspend state firstly, followed by
> > the parent device imx8mp-dwc3 enters runtime suspend
> > flow:dwc3_runtime_suspend->dwc3_imx8mp_runtime_suspend
> > Step2.system deep trigger:consistent with the runtime suspend flow,
> > child enters pm suspend and followed
> > by parent
> > flow: dwc3_pm_suspend->dwc3_imx8mp_pm_suspend
> > Step3: After dwc3_pm_suspend, and before dwc3_imx8mp_pm_suspend, a
> > task terminated the system suspend process
> > . The system will resume from the checkpoint, and resume devices in
> > the suspended state in the reverse
> > of pm suspend, but excluding the parent device imx8mp-dwc3 since it
> > did not execute the suspend process.
> >
> > >
> > >Why would 'runtime PM trying to activate child device xxx.dwc3 but par=
ent is not active' happen in the first place?
> > >
> > Following the above analysis, dwc3_resume calls

I assume that dwc3_pm_resume() is meant here.

> > pm_runtime_set_active(dev), it checks the
> > parent.power->runtime_status is not RPM_ACTIVE and outputs the error lo=
g.

And it does so because enabling runtime PM for the child with
runtime_status =3D=3D RPM_ACTIVE does not make sense when the parent has
runtime PM enabled and its status is not RPM_ACTIVE.

It looks like the runtime PM status of the parent is not as expected,
but quite frankly I don't quite follow the logic in dwc3_pm_resume().

Why does it disable runtime PM just for the duration of
dwc3_resume_common()?  If runtime PM is functional before the
pm_runtime_disable() call in dwc3_pm_resume(), the device may as well
be resumed by calling pm_runtime_resume() on it without disabling
runtime PM.  In turn, if runtime PM is not functional at that point,
it should not be enabled.

