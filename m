Return-Path: <linux-pm+bounces-7937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F718C8910
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 17:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD52B216D1
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 15:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEDB664DD;
	Fri, 17 May 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNucaEUZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9516BFAB
	for <linux-pm@vger.kernel.org>; Fri, 17 May 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958688; cv=none; b=ghDBHTexYsBcf+QsWrCenV6QBosudL14Obcnd2YQM1zreOmG5T/QK4zFPK+sSL8Icz5ne3EZN9gaiy9iJh/4rylln0CPsXsGoFuHZ5sfFrtEf7D8AmvznXlJsH9NgWbAAESFkwqAa8zXs1Z3MzvsRuVI/0wPn4AErD2WqZCf4RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958688; c=relaxed/simple;
	bh=eRggKTDOJy03ew6YsvIhZ0Fa/Wei2aYJKixoG35Zb6I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzS+EbNZIacrq+13mc850d+OkNy/ruKcBS4K/pyMoIYG5diXtVam1OpOlpxdWd0HRuQs5a7S3CpDIEHzZ0FbUe4vI6R667/7ntcA5s2PR0nvlqu7Y6Gnr16lBgyyCXeTRQ6QD4+EeNXP8nlabnnC/0FCTaZc3vzTBCTtuPzGtFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNucaEUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF7C5C32789
	for <linux-pm@vger.kernel.org>; Fri, 17 May 2024 15:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715958688;
	bh=eRggKTDOJy03ew6YsvIhZ0Fa/Wei2aYJKixoG35Zb6I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pNucaEUZ6d9NGmmFzTY8dlmCFU6UubOwn1INXRuM995d7UIuvOyKsCA7uDnlUEcwo
	 zbLIloS13QtOXB4ic6WkIzLu/FvPRFwbd49Dnl2rz/cpeBHsTbgcJxIuHMkr7FNxC4
	 puIZVai0HxR+YvjufqulXXrBfdnio1yloDyK6pdpVxU3n4vk1HiB5CCy8TQAbD7Kr8
	 0bduQOsZ7Ie91bpbhW43rC3dr9ZmgEaCmSM+OFJm+Ws20/4PO7Tf65bH0S6+z9TeKA
	 z2o1tG1Ob6GKsh28//nEFJudf2WNN34nqgaa9q5Ta2wjbUnpUXwXmKmEbkFKYHtSIc
	 En5t+tDHRac8w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DB096C433DE; Fri, 17 May 2024 15:11:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Fri, 17 May 2024 15:11:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-3piF9Dp2vk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

--- Comment #47 from al0uette@outlook.com ---
(In reply to Perry Yuan(AMD) from comment #46)
> Created attachment 306303 [details]
> attachment-18522-0.html
>=20
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
> Hi there,  AMD has been checking with asus to request to update bios to n=
ew
> version,   Cppc needs to be enabled from BIOS otherwise it will not work
> anyway.   have you submited support case to Asus ?
>=20
>=20
> Best regards,
>=20
> Perry Yuan
> ________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: bugzilla-daemon@kernel.org <bugzilla-daemon@=
kernel.org>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: Friday, May 17, 2024 4:50:33 PM
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Yuan, Perry <Perry.Yuan@amd.com>
> =E4=B8=BB=E9=A2=98: [Bug 218686] Fail to set energy_performance_preferenc=
e of amd processor
> on asus ga403uv
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218686
>=20
> --- Comment #45 from al0uette@outlook.com ---
> Hi Perry, I consulted ASUS for this problem and they're unwilling to prov=
ide
> help, and it has been 3 months since the last BIOS update. Today I notice
> this
> bug tracker: https://bugzilla.kernel.org/show_bug.cgi?id=3D218171, which =
seems
> have similar issue. Do you think it is possible to fix this problem with
> similar method?
>=20
> --
> You may reply to this email to add a comment.
>=20
> You are receiving this mail because:
> You are on the CC list for the bug.

Yes, here's their reply:

Dear =E5=85=88=E7=94=9F/=E5=A5=B3=E5=A3=AB=EF=BC=9A

=E6=82=A8=E5=A5=BD=EF=BC=81=E9=9D=9E=E5=B8=B8=E6=84=9F=E8=B0=A2=E6=82=A8=E5=
=AF=B9=E5=8D=8E=E7=A1=95=E4=BA=A7=E5=93=81=E7=9A=84=E6=94=AF=E6=8C=81=E4=B8=
=8E=E5=8E=9A=E7=88=B1=EF=BC=81


=E6=88=91=E6=98=AF=E4=B8=BA=E6=82=A8=E6=8F=90=E4=BE=9B=E6=9C=8D=E5=8A=A1=E7=
=9A=84 Vicky=EF=BC=8C=E5=BE=88=E9=AB=98=E5=85=B4=E4=B8=BA=E6=82=A8=E6=8F=90=
=E4=BE=9B=E6=9C=AC=E6=AC=A1=E6=9C=8D=E5=8A=A1=EF=BC=81


=E5=85=B3=E4=BA=8E=E6=82=A8=E5=8F=8D=E9=A6=88=E7=9A=84=E9=97=AE=E9=A2=98=EF=
=BC=8C=E7=9B=AE=E5=89=8D=E6=9F=A5=E8=AF=A2=E6=AD=A4=E6=9C=BA=E5=8F=B0=E6=9C=
=80=E6=96=B0=E7=9A=84BIOS=E7=9A=84=E7=89=88=E6=9C=AC=E4=B8=BA303=E7=89=88=
=E6=9C=AC=EF=BC=8C=E8=BF=98=E6=B2=A1=E6=9C=89=E6=9B=B4=E6=96=B0=E7=9A=84=E7=
=89=88=E6=9C=AC=EF=BC=8C=E5=A6=82=E6=82=A8=E7=9B=AE=E5=89=8D=E5=B7=B2=E7=BB=
=8F=E6=98=AF303=E7=89=88=E6=9C=AC=E5=BB=BA=E8=AE=AE=E6=82=A8=E6=AD=A3=E5=B8=
=B8=E4=BD=BF=E7=94=A8=E5=8D=B3=E5=8F=AF=EF=BC=8C=E5=85=B7=E4=BD=93=E5=8F=91=
=E5=B8=83=E6=97=B6=E9=97=B4=E6=88=96=E8=80=85=E6=9B=B4=E6=96=B0=E5=86=85=E5=
=AE=B9=E7=AD=89=EF=BC=8C=E9=9C=80=E8=A6=81=E4=BB=A5=E5=8F=91=E5=B8=83=E5=AE=
=9E=E9=99=85=E4=B8=BA=E5=87=86=EF=BC=8C=E5=A6=82=E5=90=8E=E7=BB=AD=E6=9B=B4=
=E6=96=B0=EF=BC=8C=E4=BC=9A=E8=BF=9B=E8=A1=8C=E5=8F=91=E5=B8=83=EF=BC=8C=E5=
=B1=8A=E6=97=B6=E6=82=A8=E6=AD=A3=E5=B8=B8=E8=BF=9E=E6=8E=A5=E5=A5=BD=E5=85=
=85=E7=94=B5=E5=99=A8=EF=BC=8C=E4=BF=9D=E6=8C=81=E5=BC=80=E6=9C=BA=E6=9B=B4=
=E6=96=B0=E5=8D=B3=E5=8F=AF=EF=BC=8C=E7=9B=AE=E5=89=8D=E6=B2=A1=E6=9C=89=E7=
=9B=B8=E5=85=B3=E7=9A=84=E6=97=B6=E9=97=B4=E5=92=8C=E5=86=85=E5=AE=B9=E7=9A=
=84=E4=BF=A1=E6=81=AF


=E5=A6=82=E6=82=A8=E6=9C=89=E5=85=B6=E4=BB=96=E9=97=AE=E9=A2=98=E6=AC=A2=E8=
=BF=8E=E6=82=A8=E5=86=8D=E6=AC=A1=E8=81=94=E7=B3=BB=E6=88=91=E4=BB=AC=E3=80=
=82

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

