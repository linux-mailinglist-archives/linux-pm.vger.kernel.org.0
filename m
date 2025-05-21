Return-Path: <linux-pm+bounces-27450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB8CABF2B8
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 13:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71921B6724D
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0F7262FC7;
	Wed, 21 May 2025 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhPlanBI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA851F869E;
	Wed, 21 May 2025 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747826686; cv=none; b=psCoVUiI8b77cmjwYlJHSambLHZlyjYHqz9BYAtUpJQARgmcnVY/HQpU8h9fdnfo8Pl+HigT192I27Xc9H/xiu9l5MYwl9uUdNKhYeYUDB+f5BrfFzpQ5mju3NRABN44bLZJ81uj8JUPxQqvxDnyQRjJ9pL0gKQqPXa19uYscxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747826686; c=relaxed/simple;
	bh=mLNmfdLuIwuQVtiVC4nR0oWRA8XNs6X92h+G1nfsW/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1OuhvyMvXW2Hx4aiwke6ag8byYwugREjg2TmHU2rUIG9h8SKYCKwSBugsyaqwOq6tol/uZAn9mvsgBBToHTYQl6lC4kCQ3XamEAZNEH0LC0ClpKfsp/QAHs9jm5VoExjwTLDC8WDIOopDn/+1Mi0z4cI1zcKhUErre9Oaekso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhPlanBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA8DC4CEF3;
	Wed, 21 May 2025 11:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747826686;
	bh=mLNmfdLuIwuQVtiVC4nR0oWRA8XNs6X92h+G1nfsW/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YhPlanBIpg261hemEQ+5H6SZJ9usP0ai00liNP8klwPpTFaINPvhyt5a2XjFyihgU
	 CZ3eigaQkVQk8iEUG8NhhEvv4y403FZ5xwUbKObX07F1GvErUlrHsruXK1Rz6IeEfH
	 zv4bwaJKDpSdxOFFGY6OOO0HMg+DnWtDPQGHJNpMCPfJMvWUubvsurjzqhd9ods24W
	 FGxE2MDqZorSt+9R8J2sb0HggSo5nIISij/+XWgEoU6BZOiKlRdlyWu0HBSL7gc4AD
	 Bp4DOvcLZym3SRmAVBjTC0qxoIwpZqstoE/J6ebDFsot0EG1asyn432WSOju0AcKh5
	 USVuvr9vAy+3g==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-60638c07cabso3805270eaf.3;
        Wed, 21 May 2025 04:24:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWAOMxqKbPka4ycl5Lm2cRvtwHH7+iDk0uiGXkdg28dvYHfZZgoOw5la8jxVW9jXX9aNe5LgvV6OO8F@vger.kernel.org, AJvYcCXPbuaNQ6xpUuJBu02hUbr7ALUslmVsLnotmwoWqaWXjbYsRykKl18Q9I0coZo5IYjwkJb9Eq8GrkYe+FE=@vger.kernel.org, AJvYcCXPmzsdSNNj6cn1LmcrHDuZAdxCqyjBGGW3R1qyyKZ+5VDusPhtra8O+sg+wm+dNSD+525FB/E089Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YziDXs0USUsbB1fKdW0dQIH+hR7qKEVzYFt/cx3eEbu/7ePD85n
	9/r+pOpYwpqFTvgbe49uMKhIN5ahoG713GS/6OEEie8/G9wKZoLraDU2g/q6mUHCze1j5ai3Co9
	G8puRIKugL7Gf77gcpTcUNpxJZxkfRkQ=
X-Google-Smtp-Source: AGHT+IEXE7uqWMn78PfoHPkPyJ0TvFJ8r94/Hhu4v7FXyu5CBcMr7cVPb8NMjy+x+UZr/ig5utvqqPWv+WJcL8+5+Xo=
X-Received: by 2002:a05:6820:1795:b0:60a:32a:b016 with SMTP id
 006d021491bc7-60a032ab17emr10304012eaf.6.1747826685293; Wed, 21 May 2025
 04:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6180608.lOV4Wx5bFT@rjwysocki.net> <2025052158-venture-bottling-a3f8@gregkh>
In-Reply-To: <2025052158-venture-bottling-a3f8@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 May 2025 13:24:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jR88ZNLFiJ-B_FEi=1--Z5tg2on6xCyLJF_K0ynmF_5A@mail.gmail.com>
X-Gm-Features: AX0GCFs0RLHS39pyygbfr00TxMqjnMJWIOPWP6863CYgiRxyqZvU5NkS1W5Y_z0
Message-ID: <CAJZ5v0jR88ZNLFiJ-B_FEi=1--Z5tg2on6xCyLJF_K0ynmF_5A@mail.gmail.com>
Subject: Re: [PATCH v1] ucsi_ccg: Disable async suspend in ucsi_ccg_probe()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>, 
	Saravana Kannan <saravanak@google.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 1:11=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 12, 2025 at 03:26:53PM +0200, Rafael J. Wysocki wrote:
> > From: Jon Hunter <jonathanh@nvidia.com>
> >
> > Commit aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending
> > children") had triggered a suspend issue on Tegra boards because it had
> > reordered the syspend of devices with async suspend enabled with respec=
t
> > to some other devices.  Specifically, the devices with async suspend
> > enabled that have no children are now suspended before any other device=
s
> > unless there are device links pointing to them as suppliers.
> >
> > The investigation that followed the failure report uncovered that async
> > suspend was enabled for the cypd4226 device that was a Type-C controlle=
r
> > with a dependency on USB PHY and it turned out that disabling async
> > suspend for that device made the issue go away.  Since async suspend
> > takes dependencies between parents and children into account as well
> > as other dependencies between devices represented by device links, this
> > means that the cypd4226 has a dependency on another device that is
> > not represented in any form in the kernel (a "hidden" dependency), in
> > which case async suspend should not be enabled for it.
> >
> > Accordingly, make ucsi_ccg_probe() disable async suspend for the
> > devices handled by, which covers the cypd4226 device on the Tegra
> > boards as well as other devices likely to have similar "hidden"
> > dependencies.
> >
> > Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending=
 children")
> > Closes: https://lore.kernel.org/linux-pm/c6cd714b-b0eb-42fc-b9b5-4f5f39=
6fb4ec@nvidia.com/
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Commit aa7a9275ab81 is in linux-next and it has not reached the mainlin=
e yet.
>
> I'm guessing that's in your tree, so can you take this through that?

Sure.

Done already.

Thanks!

