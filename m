Return-Path: <linux-pm+bounces-20573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE32A13F7A
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB021888DD7
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0260F22CF35;
	Thu, 16 Jan 2025 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3ueES+G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB7E1E766F;
	Thu, 16 Jan 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044891; cv=none; b=n+sLtSW8bXNcM/akbBZDUNxEhsE7CANUfw4UHbuzryybIt1k6qFDIudtCHHIh8IYTpx7cb2Bu5f2+kMMrkhxhRYPDqFnRTbjVlYbJ333oO88m8SFCYpiUZxGKrlUJLR64rfBSBJlfA9+X+4HmLByMbJ0oqsma0+HltiN6NoFJJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044891; c=relaxed/simple;
	bh=W3LD/mc8OgjXFPgxHAgdDbVEbuCUXcztBYZfDxNaNpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPNpQIrGOWYnuA/SXrDH7OvrTJpXBWyiIsNKe4VhEwxsy5vCo1QEBR8hq644JkpNAfCbRShp+HHGxFOAnAO9Q56MFxvfI8FJDstu9gIGbpDSUrjnjEwLXnW2Bu2hHbV0Y1+rOKgj/eCuZWKR6aC1bE2pCxhdH0xEJZv894R/e9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3ueES+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBCCC4CEE5;
	Thu, 16 Jan 2025 16:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737044891;
	bh=W3LD/mc8OgjXFPgxHAgdDbVEbuCUXcztBYZfDxNaNpI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y3ueES+GgmUQ9LT3FnPufEvSoPQaLHdgDCrDG8l/2hU6b5Nb2whXBHGmju7Wyq0nL
	 FhwmuOk04AUhckzSW5FU/AK8mRTJ/5Nz2+T7ZYgq1aA0L6vR16gYyvFLFE/W+anj1b
	 kZUiLabsqycOkEUfEJNQ/N5Lp7SuQ7WRznXL9535hzuxJLyC9ZAvitId6WJ4IT5LkN
	 IUtwbWsTsT5S+d/gukzPYXSl9jihD3Yq/0GLx4r57gJSUw9D4by6utoHI1HhYZg0uf
	 K3i/yYxd3/SIeZVsXFJ2EJqCZKIPm8R1GgOxOdvW+mvxnvUEJY1eY2TuWKGBDY2jP2
	 A6uCQggkOFHeg==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3eb87127854so369454b6e.2;
        Thu, 16 Jan 2025 08:28:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxVI4/DNjDYFBR5ByvMG8iaPdr5Qagk6FGNj8JvB0RXd2xFcTgl8/KPpcxKFvg3sBRWRcYU2wCTyc=@vger.kernel.org, AJvYcCXC6M6DDp2/fBQgE1h3yBniNzcFkwE63WHx5569S7/yaZTppd87+qeiI36iDrxGtrLZTufRjAhPhi09PtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyncMJtFEB0Fx4Qk+r727bvMeHU1PBiShS6P4LoKV1EmrgDL4JR
	gbpVemx/83MmNQZZ1u0929WKOOcQq/SnYet8GY7ULQJPHkoh/wjAabTIW9wJJig3NTSwS4LbdpT
	0wUcZ0UZoYPnzLLRblhwEw62dT8g=
X-Google-Smtp-Source: AGHT+IHHxANpiaIDQ9iNwT6ona780AQYihnMyGKLJ98qqK+EhP0tPssncTog1nZS9rfKYdqj9HYfGkC1IJMOnG4mlQQ=
X-Received: by 2002:a05:6808:2103:b0:3eb:3b6e:a73c with SMTP id
 5614622812f47-3ef2ec6c4c8mr23509859b6e.1.1737044890651; Thu, 16 Jan 2025
 08:28:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116154354.149297-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0izBnSGjmjO7T+_gEhrSib0==_bRXnsLEdzEjbH0cZDqg@mail.gmail.com> <Z4kwK6JCm5RDI4nG@smile.fi.intel.com>
In-Reply-To: <Z4kwK6JCm5RDI4nG@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Jan 2025 17:27:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jdqtyF_Prf6TETwaLJ3Cr3sK4rFnU68C5ioqKq8OF02A@mail.gmail.com>
X-Gm-Features: AbW1kvbiR7X26FCPNfAVlMeoK4-_AjX_GmZ-xvNeT1WV_qp4jDF2NpP9AtmLTpk
Message-ID: <CAJZ5v0jdqtyF_Prf6TETwaLJ3Cr3sK4rFnU68C5ioqKq8OF02A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PM: Revert "Add EXPORT macros for exporting PM functions"
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@ucw.cz>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:13=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jan 16, 2025 at 05:09:29PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Jan 16, 2025 at 4:44=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > The introduced macros are not doing what they intend for, namely
> > > they won't eliminate the code when CONFIG_PM=3Dn.
> >
> > I don't think they have ever been expected to eliminate the code then.
> > They just don't export the symbols in that case.
>
> Then I'm really puzzled with (potential) usefulness of them to begin with=
.
> Having a dead code that is not exported is doubtful benefit.

Arguably, exported dead code is even worse.

Anyway, it is hard to say what they are good for if there are no users.

My point really is that you don't need to add anything beyond "this
stuff has no users" to get it removed and arguing about what the
unused stuff was intended for is not very useful so to speak.

