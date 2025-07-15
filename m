Return-Path: <linux-pm+bounces-30862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA3EB05A90
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 14:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126C44E1104
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 12:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171241EF09D;
	Tue, 15 Jul 2025 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1KanH5D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F81E1A31;
	Tue, 15 Jul 2025 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583717; cv=none; b=E9tYuHhrO8aq9X9JIvwwvS8MAiv0Bm2QyLMusjK3rAos798fgUgojZpOSUxJigK3iXjwhsDZz02PUna2LngW4JwyIWqJ/D0YifkPYatVgjDULDSJC1IIP5QJRvWuBLp0M7ItXpE8i3C2MGxb4eu+Oe6wfJ+gKixx4upy3WDTTfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583717; c=relaxed/simple;
	bh=t3kRF9DW//cxgAY4RwJrfGg5IU+PW+muRgdn6txGjfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXbCqQEnsc5UqC+Dmxy8p6AMJHu4/Xaz1lLxHcjU8EIOkZXooKDK86i/3MxmXAUX4XaEzuoSRyuHkd+1vmkR9XY8kghxapeC3lPNYdUrZz/WpTP6AqJ/0okflaXCr0eH+xhL8LjuqK65YEZLwP1VAF14b/56b5a8BjQT4FlN7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1KanH5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E77C4CEE3;
	Tue, 15 Jul 2025 12:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752583716;
	bh=t3kRF9DW//cxgAY4RwJrfGg5IU+PW+muRgdn6txGjfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j1KanH5DHsTwgGabasl0v7Rou73MdkyulAGDLAekcCyGJG50MBUZUQCtXs8uVUPT3
	 7DhO5PcOpbFkVfIYIVvJPdF8vqlsGLIiApUc6aoLJqfgnj177s0E++dVYZa2XhwlFt
	 0HzDM5md9tIlEeur4ExcxZ/k6p9k+AqVZ5xEtAudP0MYsCV2tSXw64FY6Vd6jitqJJ
	 BxidI88dFl1j9330GiIHynMS+rFAhY9uJuD1pGrL1Un2BwPcNj/wwT3OLeSOVTHx34
	 6c8/K+4xYU6wOgwWGXCjYRbhmCJcOBvx1j7wweJ3XzNj2vOxg3Oe+iK4qUMMQl0D6P
	 zU2t0oERP4dCg==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-40aef72f252so1495290b6e.0;
        Tue, 15 Jul 2025 05:48:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXMSpHrDKH//ToJmlxd69rXqhfG1j3ARaQothoPrV8FCjr3f2YjQLwCNZEKp3ZWLU/8RsTE4d8F/yyGV4=@vger.kernel.org, AJvYcCX7yZmF7GKMxA6nUdYCSQmwXBtv8BEeBcm1CSxeH98B0eg7YDNu4sSrIEuiD1KpGVr7qSmpkGxhp1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjQFmMcveBH5RIMNjyxOqNASHoBkb/9xegxpUAVwXBp6wnEy7
	e9gk8wH1unsi6R5UuebYOtyZc7nr6M7jnqZwN4mL90dp49bYi+i/zoJyrI6BVnHTv3M7xJmvhLg
	l7R0E4Q40ePO/Q/TjIsqHmzKBzP2Z+e0=
X-Google-Smtp-Source: AGHT+IGU/g8i3nzaWagW3UcONVPpebwZNNz8b1J1UQh5Qc53tVe2lFSz557yyTokDlXBx82gXWYabIklMKSwv+/rOtI=
X-Received: by 2002:a05:6808:4f62:b0:3fa:daa:dd8e with SMTP id
 5614622812f47-41bab41f1damr1984869b6e.35.1752583715652; Tue, 15 Jul 2025
 05:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712030824.81474-1-zhangzihuan@kylinos.cn>
 <9d35035d-c63e-4d11-a403-54c50e8b35c1@kylinos.cn> <CAJZ5v0g22fMDc21yV2svePf_4BWZRrcy+b3-efpbfAGLpa2=Lw@mail.gmail.com>
 <76a87abf-8fc9-445b-83d5-0daa33746014@kylinos.cn>
In-Reply-To: <76a87abf-8fc9-445b-83d5-0daa33746014@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Jul 2025 14:48:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jKwHZUpsYLzUkcL4=FDnewXoTeJo5e+ccyHw2bZ+ghTg@mail.gmail.com>
X-Gm-Features: Ac12FXwUoA_bQtKEdmFpzn8lu7PEpyAPa1OoMBnFbIMFyvcKAZjHOanxwdvdfDY
Message-ID: <CAJZ5v0jKwHZUpsYLzUkcL4=FDnewXoTeJo5e+ccyHw2bZ+ghTg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: suspend: clean up redundant filesystems_freeze/thaw
 handling
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 8:12=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
> Hi Rafael,
>
> =E5=9C=A8 2025/7/15 01:57, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > Hi,
> >
> > On Mon, Jul 14, 2025 at 10:44=E2=80=AFAM Zihuan Zhang <zhangzihuan@kyli=
nos.cn> wrote:
> >> Hi Rafael,
> >>
> >> Just a gentle ping on this patch.
> > I've lost track of it for some reason, sorry.
> >
> >> I realized I forgot to mention an important motivation in the changelo=
g:
> >> calling filesystems_freeze() twice (from both suspend_prepare() and
> >> enter_state()) lead to a black screen and make the system unable to re=
sume..
> >>
> >> This patch avoids the duplicate call and resolves that issue.
> > Now applied as a fix for 6.16-rc7, thank you!
>
>
> Thanks for the reply!
>
> Just a quick follow-up question =E2=80=94 we noticed that even when the =
=E2=80=9Cfreeze
> filesystems=E2=80=9D feature is not enabled, the current code still calls
> filesystems_thaw().
>
> Do you think it would make sense to guard this with a static key (or
> another mechanism) to avoid unnecessary overhead?

Possibly, if this overhead is significant, but is it?

