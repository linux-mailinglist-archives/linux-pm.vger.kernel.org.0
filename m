Return-Path: <linux-pm+bounces-21548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8F8A2C7AC
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 16:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CAE93A31D5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 15:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61A82417E1;
	Fri,  7 Feb 2025 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9GeH0/p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF6C2405FA;
	Fri,  7 Feb 2025 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738943135; cv=none; b=jKkcL52+W9o6Lh07MbK9dAtMpJcFgQlBCL1k4JI12yI21h+hlb6L04qiRUMruH21Ac+qWE/hw7llBL/b8kWkF0J3IzZAJP/LKp9V9jSSkLjI4g9YM4zOYzItRun6bYGHKdr2w5SyGB+jQnytTyRBr6wMQcud4zD3pRaOpORAnoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738943135; c=relaxed/simple;
	bh=Hx2rwNHpKVZGqIWJCihyCYLrZaN78Rf2HghLipar48o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIcQcxR9i+qulwy85iJz0aaapauPBGNxpcU9dbBu1p0952iC/OLwPEzW0GBf3GuW1SdB9a2dA0XeoGj7G31DxtOKwKHSjgvyaueOp1HDS8d55FE8scQt9+7g/4w16z0+rCswUdM/d0a+4c5Gmsxub33AIx4bAlPuGOFuvhQwutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9GeH0/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB5AC4CEE6;
	Fri,  7 Feb 2025 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738943135;
	bh=Hx2rwNHpKVZGqIWJCihyCYLrZaN78Rf2HghLipar48o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h9GeH0/pKSGn61cLNtWMZz8DRkVUJoHSVM7W9FsxQLr/tu9EGmYj9sROKiWbcp/kv
	 SefzvAm41mVPC2DN15OwxfdcYCuBJxpfbLMpM/onsMWIOfKLm1JdfUZKyW5seD5rPY
	 Pv9fr5+nex+kewezSbMwLVWTghHJS+JWITrSBxegR1xElwcIbaMddeBX9z4sqmoQ7F
	 q+yF3IyP2tHPB7ihEBBdT4lPQBgALV3lvMAFKEgAAGdAXxrdATbrq0opqVw9tn9Xjp
	 Hrx1aX/DasoGA52Ofc/aJ+xBYzm2wQFORPh5C3OtM5weKMwkhkdXwbvmahdA2q2PLv
	 boJ/Wxti1H/+Q==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fa2685c5c0so853001eaf.3;
        Fri, 07 Feb 2025 07:45:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/VRdE3FW6E0+jWAyVag+StE1VjWdG+0CNh6RqTzn4ubbrE4X7J6RnFLqyGB8ueer5nRUL/IzwLHGF4d8=@vger.kernel.org, AJvYcCWENi9Ce34MXZz+4S4ylQ3NwQA2yszC/XAPMhgmoqS+thkPu3nJVOjvl+baimd3rx/Snkpq3fDvmCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRPwtzZyuHeqQnPdwyTgegw/q88O3MXotqHhuRmVORE5QLFhxM
	pKDzt6FRfvWbXdtG/iu6cVHZJw182aXr5FrpOerXYT6uWCm4drpHRJC3fRzGuo8PME4XclMtHdI
	J8fsPgccZD/i5ls2sIHQV7bHfFWk=
X-Google-Smtp-Source: AGHT+IFpHOKFdfsnTT7mx6fQeF3im8bxXggMcEaYKM/DSIgYwMOYXCGknNXIiPphEpFCxdnkkEUnYVehp49Lo9ruc0I=
X-Received: by 2002:a05:6820:827:b0:5fa:73ed:de8 with SMTP id
 006d021491bc7-5fc5e71b079mr2600610eaf.6.1738943134445; Fri, 07 Feb 2025
 07:45:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2774831.mvXUDI8C0e@rjwysocki.net> <bacc3a3f6066af7a6b96c48d4aff734a29819a24.camel@gmail.com>
In-Reply-To: <bacc3a3f6066af7a6b96c48d4aff734a29819a24.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Feb 2025 16:45:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iusKBzPHZ+yJAQ8iVKCLq_TksD7zxPDhMOJZ8kEDA3pg@mail.gmail.com>
X-Gm-Features: AWEUYZnpzA4KgG8FrMpD_GMaDq-C-dJhelNsW5r1cAaUaD3D_IJGwRLfWhHi1ls
Message-ID: <CAJZ5v0iusKBzPHZ+yJAQ8iVKCLq_TksD7zxPDhMOJZ8kEDA3pg@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: intel_idle: Update MAINTAINERS
To: dedekind1@gmail.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 3:52=E2=80=AFPM Artem Bityutskiy <dedekind1@gmail.co=
m> wrote:
>
> On Thu, 2025-02-06 at 20:45 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Update the intel_idle record in MAINTAINERS to reflect the current
> > state of affairs.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  MAINTAINERS |    5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11675,8 +11675,9 @@
> >  F: drivers/crypto/intel/iaa/*
> >
> >  INTEL IDLE DRIVER
> > -M: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > -M: Len Brown <lenb@kernel.org>
> > +M: Rafael J. Wysocki <rafael@kernel.org>
> > +R: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> Could you please also add:
>
> M: Artem Bityutskiy <dedekind1@gmail.com>
>
> So that there are 2 e-mail addresses? Thanks!

I can, but it would be either "M:" or "R:" in both.  The latter is
better IMO if you are going to only review code and send patches, but
please let me know which one you prefer.

