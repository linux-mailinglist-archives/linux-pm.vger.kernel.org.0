Return-Path: <linux-pm+bounces-33703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EF2B41D21
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 13:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95E847AAA82
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 11:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8FA2DCF65;
	Wed,  3 Sep 2025 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By/G2Rw4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED511DB375;
	Wed,  3 Sep 2025 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756899213; cv=none; b=pK1mHbCkhdgGHKjd9Bq00rme1J2nzEiOFQsheHOJ5hpl9Quwz7qaE7wNNCFNGnmKj5A0xA4RTWbhhY3fWsQxWDi3aSrZCAZqaCKtrCOG+bfPls8EWZKcaP4D8LMzy59XWXcyw9DopxbntRh+vpBSkgKFoq6yIprZ7iGpQFZKZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756899213; c=relaxed/simple;
	bh=++UudfQVUVzd+Q2HYNxYisedh+rWpnx9M9Vmx0J/mD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMDc8DxPzKysCx0zjZhd5XdIzx85vMF1YoQfddUd0IO1ixgZHD4huAq1ezt2r2pNhcs0oxacW0qRncpNuKnmxrTb5SisS4a1GUiMMMJZRLtPre5YgevJq+rxAo2q9URb7tJjTUyIYkLQjT/MuM8jE2nfeo4AGq0gFFXYD4LmZ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By/G2Rw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B92AC4CEF5;
	Wed,  3 Sep 2025 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756899213;
	bh=++UudfQVUVzd+Q2HYNxYisedh+rWpnx9M9Vmx0J/mD4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=By/G2Rw41kJ+Lf6i/1YmB/JAmv2P1HFe7QchUZ2SoQM6UG3sRnmQQMTFgiMu2cAwj
	 zxskHl7DfKsN1EKY6wka7fFAnBqM60grsVgNSnuj6+EM0PinIFrRf028GbSYoh13Fb
	 OHHGxn5VulBN/CfJaF7KJ8xAcO3qBXf6s7vCS3Tviy+O4XTuIDS5taWuVABv+Ke/BE
	 xTmVH/gFuekja/XzZ3L4UETNpaGb15dWeqJVoXVx1QIkSm5tl7PZ9eZeuB5PzLBGGm
	 CPJJB6GcyrP8Jn75VpJ8UXL8P5nfu2/79KUu+G2ko3gQDAH9KvAXiLEkTB8jxehEu8
	 oraMWGp6XhBTg==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-74526ca7a46so2230095a34.2;
        Wed, 03 Sep 2025 04:33:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVf9jtFHc3YCBx+cE8UlYaeq+NDAFYqvE5c36zNagdol6MdCCFJkBl03VRYdn/5BqSBPYKCGdBO/CVJbo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF844OBCuypO3H1JGO9NKLZDDhWv4U7gBr06XlsRbkeHngpqjj
	s48mzM/+QJROfoB/6nQpj8fBd8BV07mG/kkj5A2N0XiQd6DsxOQl3JpNB4I3Y0vsPkIvbHB3LxQ
	svrv3wgedlVSCLaWTGms5IP27i097he0=
X-Google-Smtp-Source: AGHT+IG+hX/aP41lYZAwj8P7nJywK4yBfuk/J9BgDr6cr/iqovN4g3fn6kZ+4ZW5sddcQVLOSPMhgJEkKwdyG7snkuY=
X-Received: by 2002:a05:6830:488e:b0:743:15be:641 with SMTP id
 46e09a7af769-74569e8e8d1mr9411654a34.21.1756899212435; Wed, 03 Sep 2025
 04:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12749467.O9o76ZdvQC@rafael.j.wysocki> <2025082851-progress-unsliced-ade4@gregkh>
 <CAJZ5v0hn9NXvHPy6zV4R4y0AHtN2BfN41wjd5s7dos0wx6ih0Q@mail.gmail.com> <CAJZ5v0gj33W-2FOswYoBLQQyTj0wr_EuMUdLiL_tdt4t=ss-jg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gj33W-2FOswYoBLQQyTj0wr_EuMUdLiL_tdt4t=ss-jg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Sep 2025 13:33:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ifvwbPs1VKBMpWdanBKUdHSZuNandbF9=uhec56DynNw@mail.gmail.com>
X-Gm-Features: Ac12FXyPeyVhWyfG2ijM3-TdflQjKp_7ihFunhbLxK9BxtDXeKxUJnk-tq6pkzc
Message-ID: <CAJZ5v0ifvwbPs1VKBMpWdanBKUdHSZuNandbF9=uhec56DynNw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] driver core/PM: Two updates related to power.no_pm
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:09=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Aug 28, 2025 at 1:20=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Thu, Aug 28, 2025 at 1:07=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Aug 28, 2025 at 12:55:50PM +0200, Rafael J. Wysocki wrote:
> > > > Hi All,
> > > >
> > > > Applying this series will cause power.no_pm to be set for faux devi=
ces (so they
> > > > don't get processed unnecessarily during system-wide suspend/resume=
 transitions)
> > > > and power.no_callbacks to be set along with power.no_pm (for consis=
tency).
> > >
> > > Oh, nice!  I forgot about that entirely.  Should these be backported =
to
> > > older kernels as well?
>
> So do you want me to resend these patches with suitable Cc: stable tags?
>
> Alternatively, I can just apply them with the tags and route them
> through my tree, whatever you prefer.

In the absence of more feedback, this is what I'm going to do.

