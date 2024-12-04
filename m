Return-Path: <linux-pm+bounces-18544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4724C9E3C76
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 15:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35ACA166460
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321831F756F;
	Wed,  4 Dec 2024 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKtzrwC3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC53198A05;
	Wed,  4 Dec 2024 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321778; cv=none; b=dfFFns42k7VItWgUX5NVKBmjfup7spDC4pOoR8jO5OyHnLQsme3ls1qiVRpC6aVkuDVU5WaTR6Qsi47b2QSNuOpHVbGSLwW9bizkb95Af0G0xOvSSQe3VH52MLt/3anZCQGY4rg+fv2rfIKoR1HbJ3iGT+YEHMHm/TnPtnQgGM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321778; c=relaxed/simple;
	bh=Fc6w8nphRLmfLmeDvo1AnME2gK8eg5/F7cqZLhFXv1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3IiCPzrFXLrirZwsk6xR1b4OA/swMzCKNMnsQdwoxpg3z1lY8TYHVq36y51rjfnNSxr8C1yXnClkQKNyWHDbTTZWb74WXReMdtDQKgzvBW3DfxMO9lpLvoTA5TPAkgtvjmnDKm6OS3ZRm8tecoLL6uLvfWOSKEhqi/R+MVCTiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKtzrwC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87761C4CECD;
	Wed,  4 Dec 2024 14:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733321777;
	bh=Fc6w8nphRLmfLmeDvo1AnME2gK8eg5/F7cqZLhFXv1I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FKtzrwC3vkt8vxhhKIInYOsEya+i5E/nqxW8GD/0zfV9Rk2+s0Kpgtnpg/j9l0Sbc
	 FCwUbOIFZxTSL3laNixOE0ir6dum1FSGRjjbE+sop2p4XB07p0xLvfm3PVRI11wVQ4
	 XrzHWvWpub25n1Auo7CRohJhow71U9M94EQWsiC/vtiErVF3PE8N3a02sHnn73ePwF
	 3BDqposvlGL1v3BBoZE7LV1m4Yj5JXaJgRD+p/fWT5f+hH7SRokURUo1rBVvizS1SI
	 MOnPD6MWgcu47kjr5h8uyHpisufc2FjtoiJGhyB6Op8IbsdQNfLUcxKYqKUX5SSOv+
	 4jWJZ/ZzEeyLQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-29666708da7so4223666fac.0;
        Wed, 04 Dec 2024 06:16:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDwaA6pb1/i8J9SZeryfWeOLO6Upa391a51MleDnwx/2AkABiAwpMyUeJ0kTkKGBSrcploTwroOtdFVOY=@vger.kernel.org, AJvYcCX1GuSqZi+27N94bGY/WMPwjYtSXWSkiWoAkrOswZy2LzwozdmmwX1L73NxerOxt+hhty+iaYL04aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIvkJcFS2BNpGvfZJpUk9nSQMyBMYE5PFI8oEZb25Ielb2FvLA
	fEb5VDt9BKEodG5CFYHrgHpcMnNfe4hy1xBUJXdbr2oL8Z5K1W2e/PdMl+TjHCOgTejxmobqV78
	TyXXzbroWjynF6AD33ATV7JvsTNs=
X-Google-Smtp-Source: AGHT+IFk/r60vYgO0Ks6VuJEKbdILY4SBQ/Dzs+tQLh00873VXCEGKvFQCbt5zBm5zDGHWaAPDpTD9Q7kXQUnmlS3ko=
X-Received: by 2002:a05:6871:580d:b0:29e:2586:cff7 with SMTP id
 586e51a60fabf-29e9b3a80b2mr2159531fac.42.1733321776893; Wed, 04 Dec 2024
 06:16:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2787627.mvXUDI8C0e@rjwysocki.net> <2024120450-makeshift-haggler-625c@gregkh>
In-Reply-To: <2024120450-makeshift-haggler-625c@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Dec 2024 15:16:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hyi_2KL-h_+CbCSsZcQXEP3BspBxCbhzmfX2KydSfRKQ@mail.gmail.com>
Message-ID: <CAJZ5v0hyi_2KL-h_+CbCSsZcQXEP3BspBxCbhzmfX2KydSfRKQ@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Update stale comment in device_resume()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 2:12=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 04, 2024 at 02:02:04PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There is no function called __device_suspend() any more and it is still
> > mentioned in a comment in device_resume(), so update that comment.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/main.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/base/power/main.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Are you not using git?  This looks like the old cvs output :)

I use git, but for patch generation I prefer quilt which has produced
this patch.

> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

