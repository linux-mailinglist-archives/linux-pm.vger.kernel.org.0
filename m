Return-Path: <linux-pm+bounces-30896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BB9B0757E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 14:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA37D3B2BC2
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 12:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68E42F49FD;
	Wed, 16 Jul 2025 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAJ9eJQa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC8A2F49F1;
	Wed, 16 Jul 2025 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668637; cv=none; b=JuTXLMOO9/YZ4K0HUVx9M1NxeDOpa9GKBpTXDc85/+yOna4euTschFbK87JdIDWkoDg2nBbJVCX4qbX1oI7Yv6AAw6X+/K7I/EK38gYG1zFHt1cXzmCjMPsozQGuGleLb0502ZlkiV031Vy5Lecbe1O8V3ZMEafRGcqilJiGbC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668637; c=relaxed/simple;
	bh=adfBujZfHC31DSYRyLy0OgdmyJaP5mTjJ9NVnjL4SDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdLj51OCfad1YX1zOuq+a+ClEM+8AaGFWPZtyCiejLDsr2e01XWfvctULYzwh/j7VnVoaPoOnAW5iyAo+XfflhQaTdZfedIZkGq2lOR2/Yo+lrG8gF6VG83cxIVJwcKIpb7QJPXjgwAw/LoKC9WlI83g2ePUvx2b9Wld+7Y9STo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAJ9eJQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19569C4CEF4;
	Wed, 16 Jul 2025 12:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752668636;
	bh=adfBujZfHC31DSYRyLy0OgdmyJaP5mTjJ9NVnjL4SDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WAJ9eJQaV1kHxKH2ss7lCYqUDWkYnB3Y/pjXDA305kCIxCYoPV8nwkcjB+rkxddww
	 cLAixshYaMSVpxlaFEs22AVelL6I5Z8L+tMOn72YkAfVXFdF+aYhUPPq2CJn0D4w/b
	 gOb4UdMDk5TM4GcSsK3X1X+jpYbq6/wRchZ6xqNXMa3aAxj7UQyN9hUF2TR2pne2Xb
	 iz9cjRfPXOol8C3rC2rKoQ7sUz54hkCUq616rLlbIHYuIQHP1afoC2pCG+66qLCn2R
	 evQnzq5jPehqEWgWqScBzGgisL+pfjFGbDYVCAMuy/4DgNLzLQXwoMge7jNqJNG/m9
	 +HKYtYsaUJrgQ==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-40a4bf1eb0dso3082473b6e.3;
        Wed, 16 Jul 2025 05:23:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX21ws5t0w9ICzVh576iS/2JA9scc0DJd+R7l5e35sroD/nSI1xlxAJwplEwjfMeijQoqXzJqy7Y7EOsl4=@vger.kernel.org, AJvYcCXy21h7M2modQrFzz2owJRNeL6rbv89e0BniWoWAf37+DzzwaFtOACnlMHsTTQRQHYWwjPeRjG1VhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGFalJ2reFngjFV90B6KeB8kBt/EVLEe89ze+r8Do+cd03TmGz
	uW5Q3V/99BfYMZdEdBlaoUHlL8Kuy/Z0y97t2PffGL+FLrZiS6qJDmz+T9a8P3w+CZg41G4sTdz
	QS6cSrK/6ygFWezevCBY0AWSF6kLgmCg=
X-Google-Smtp-Source: AGHT+IE5fLu0mPJIYxNwAkT62HeKwY7Lp3Q5SsfJH5r8kneuXOjh/KvASJHdcTnn9K6mPMmo7rapYVfTYKOJItgBXB0=
X-Received: by 2002:a05:6808:bc4:b0:41c:35b9:acbc with SMTP id
 5614622812f47-41d032fccefmr1731912b6e.2.1752668635250; Wed, 16 Jul 2025
 05:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712030824.81474-1-zhangzihuan@kylinos.cn>
 <9d35035d-c63e-4d11-a403-54c50e8b35c1@kylinos.cn> <CAJZ5v0g22fMDc21yV2svePf_4BWZRrcy+b3-efpbfAGLpa2=Lw@mail.gmail.com>
 <76a87abf-8fc9-445b-83d5-0daa33746014@kylinos.cn> <CAJZ5v0jKwHZUpsYLzUkcL4=FDnewXoTeJo5e+ccyHw2bZ+ghTg@mail.gmail.com>
 <79468a7f-061f-479a-9357-e48c69cadbb8@kylinos.cn>
In-Reply-To: <79468a7f-061f-479a-9357-e48c69cadbb8@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Jul 2025 14:23:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j4biD2Jd5isUGFmwAva1RJsPDCHNpb1VEjM5vTBrk-jQ@mail.gmail.com>
X-Gm-Features: Ac12FXwtXi1zr5T7_1efrXKgutl40aXbTzP8Ps82-K5dI3fE71PQpgPM3bdsf3s
Message-ID: <CAJZ5v0j4biD2Jd5isUGFmwAva1RJsPDCHNpb1VEjM5vTBrk-jQ@mail.gmail.com>
Subject: Re: [PATCH v1] PM: suspend: clean up redundant filesystems_freeze/thaw
 handling
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 4:04=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
>
> =E5=9C=A8 2025/7/15 20:48, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Tue, Jul 15, 2025 at 8:12=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylin=
os.cn> wrote:
> >> Hi Rafael,
> >>
> >> =E5=9C=A8 2025/7/15 01:57, Rafael J. Wysocki =E5=86=99=E9=81=93:
> >>> Hi,
> >>>
> >>> On Mon, Jul 14, 2025 at 10:44=E2=80=AFAM Zihuan Zhang <zhangzihuan@ky=
linos.cn> wrote:
> >>>> Hi Rafael,
> >>>>
> >>>> Just a gentle ping on this patch.
> >>> I've lost track of it for some reason, sorry.
> >>>
> >>>> I realized I forgot to mention an important motivation in the change=
log:
> >>>> calling filesystems_freeze() twice (from both suspend_prepare() and
> >>>> enter_state()) lead to a black screen and make the system unable to =
resume..
> >>>>
> >>>> This patch avoids the duplicate call and resolves that issue.
> >>> Now applied as a fix for 6.16-rc7, thank you!
> >>
> >> Thanks for the reply!
> >>
> >> Just a quick follow-up question =E2=80=94 we noticed that even when th=
e =E2=80=9Cfreeze
> >> filesystems=E2=80=9D feature is not enabled, the current code still ca=
lls
> >> filesystems_thaw().
> >>
> >> Do you think it would make sense to guard this with a static key (or
> >> another mechanism) to avoid unnecessary overhead?
> > Possibly, if this overhead is significant, but is it?
>
> We've done some testing using ftrace to measure the overhead of
> filesystems_thaw(). When freeze_filesystems is not enabled, the overhead
> is typically around 15=E2=80=9340 microseconds.

So this is the time that can be saved by adding a
filesystem_freeze_enabled check before calling filesystems_thaw()
IIUC.

I'd say don't bother.


> However, when freeze is enabled, we observed that filesystems_thaw() can
> take over 3 seconds to complete (e.g., 3,450,644 us in one test case).
>
> freeze_filesystems  not enabled:
>
> # tracer: function_graph
> #
> # CPU  DURATION                  FUNCTION CALLS
> # |     |   |                     |   |   |   |
>    4) + 15.740 us   |  filesystems_thaw();
>   11) + 16.894 us   |  filesystems_thaw();
>   10) + 17.805 us   |  filesystems_thaw();
>    8) + 37.762 us   |  filesystems_thaw();
>   ------------------------------------------
>   11) systemd-54512  =3D> systemd-66433
>   ------------------------------------------
>
>   11) + 15.167 us   |  filesystems_thaw();
>    6) + 16.760 us   |  filesystems_thaw();
>    7) + 14.870 us   |  filesystems_thaw();
>    3) + 16.171 us   |  filesystems_thaw();
>    1) + 16.461 us   |  filesystems_thaw();
>   ------------------------------------------
>    3) systemd-71984  =3D> systemd-73036
>   ------------------------------------------
>
>    3) + 28.314 us   |  filesystems_thaw();
>
> freeze_filesystems  enabled:
>
>   10)               |  filesystems_thaw() {
>    2) $ 3450644 us  |  } /* filesystems_thaw */
>   ------------------------------------------
>    1) systemd-72561  =3D> systemd-99210
>   ------------------------------------------
>
>    1)               |  filesystems_thaw() {
>   ------------------------------------------
>    7) systemd-71501  =3D> systemd-99210
>   ------------------------------------------
>
>    7) $ 3429306 us  |  } /* filesystems_thaw */
>   ------------------------------------------
>    7) systemd-99210  =3D> systemd-100028
>   ------------------------------------------
>
>    7)               |  filesystems_thaw() {
>   ------------------------------------------
>    4) systemd-53278  =3D> systemd-100028
>   ------------------------------------------
>
>    4) $ 3270122 us  |  } /* filesystems_thaw */
>   ------------------------------------------
>    7) systemd-100028 =3D> systemd-100720
>   ------------------------------------------
>
>    7) $ 3446496 us  |  filesystems_thaw();
>   ------------------------------------------
>    7) systemd-100720 =3D> systemd-112075
>   ------------------------------------------
>
>    7)               |  filesystems_thaw() {
>   ------------------------------------------
>   11) systemd-66433  =3D> systemd-112075
>   ------------------------------------------
>
>   11) $ 3454117 us  |  } /* filesystems_thaw */
>
>
>

