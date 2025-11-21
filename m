Return-Path: <linux-pm+bounces-38374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE50C79689
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 14:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id B006228A82
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEBF33438C;
	Fri, 21 Nov 2025 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huFHck4h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA73F9D2
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763731916; cv=none; b=EEV2xWn+eQrfPyjXYN6sQuzJ9/oCK1+nRrt55MIUhuRGmpNKdNSjIBsKHBut6b0mwmP64zOrXy3f4nvwXjrjw9MEdQcqcH1NDB5namPNsL+0h2xteIkrYbqQHJWaeFOIqMqaFg1gtz0l0jncuYRz3ueD6k5isrnffF3R52FXmsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763731916; c=relaxed/simple;
	bh=pztRP1chr1Q5GoxgTUrDPjvVTN1vIREHiqy2bEgguts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+CZRN8Ji1N94a9C6rRthKAU2tlCMbc/h4K17wOooiKuCIdnzMlSFN5hZgx2BUl/SwXLPfuYquBBpWozw831oL22f5NJ/X0NiVdQm67t1NbqaSa025ibX7/dmPMM/vhnf02BAehyaCD5HeGGw4MtBiwbWor1AEjYa0BIWlRqz8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huFHck4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C12C16AAE
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 13:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763731915;
	bh=pztRP1chr1Q5GoxgTUrDPjvVTN1vIREHiqy2bEgguts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=huFHck4hqlS+vBlBBtiKbgGN82F7Mw7JjPPJu8PsatGBgDIHZVceawi5K3eblDmRG
	 WcZeXHEhOyv+A4GWoCkHkdZfh0db24kZxwewdIJ0wHwTkbsF4VWBS18LTnBgMMKQlB
	 OQ9JLjU9mXr6v2HsrOWzYNhVETqasImyO5xTOr3h3WRnCS85w2VnGVrVl+J5mjUgtS
	 IuqkYyJf/kIdj638imonzkGD1T1zgzDh6N0xzNcIckLJe7wrFNcFjmkEdcCqHAp+NM
	 bBXUclYzRbePDKMJpu51w5G+4u2U4gDOYmc3iACinCYd9LsHOZ8N8uDtPL3E+9XJNg
	 0FyHoiIS4pT2w==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-65763315216so843172eaf.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 05:31:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyFpHKMWsY1hvFl7fLs46tZNOEJ9Mhwb0c321VFl4thpmzOsex9uLgKWczz16t1M6eVq7cYNaMCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNHi/aOmPzM1oPtadJcSIOnejr4Feg9mthmTi3CTQ7VXC6o4sw
	BfG8Qbs3+98zST/IAhOlPWpzzqEmW49gw2C+nYIXdLOZqiVzsnC36JvIwaljHzqvmo/f9R488/+
	WlRE1ehAHV1qWtI63UTXdi/8QDYgiv+0=
X-Google-Smtp-Source: AGHT+IF0iQJS3tVv9qLJbrkQxfwNA37G9ltJnTaGg2zEgP5E/ZiK+w4qMqaeXilBlRVJ3LVVHuS4hgE3x9Lnxz5svAY=
X-Received: by 2002:a05:6820:4c09:b0:657:61da:5089 with SMTP id
 006d021491bc7-65790b6080fmr815913eaf.7.1763731915123; Fri, 21 Nov 2025
 05:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119002545.666251-1-atomlin@atomlin.com> <20251119002545.666251-2-atomlin@atomlin.com>
 <CAJZ5v0hUWMgJVAZ36_9k8N3AdZ_rGajKpQSprF6QwUtxmpH2qw@mail.gmail.com> <oifgpnkuupj4s7picyujw3jp2b22dcdrr7kqejho6uhxh3juam@7bqtbuxzjt5p>
In-Reply-To: <oifgpnkuupj4s7picyujw3jp2b22dcdrr7kqejho6uhxh3juam@7bqtbuxzjt5p>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Nov 2025 14:31:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j3Mpo2LLGN+jWbNi4vT+u+Wckm5NK+ehA=GhigThpcnA@mail.gmail.com>
X-Gm-Features: AWmQ_blRBb9Giqe8VAqZHm-pVk0XjMctq8g77Yu3SLbuw-ry0kq4THoCCFMw0GQ
Message-ID: <CAJZ5v0j3Mpo2LLGN+jWbNi4vT+u+Wckm5NK+ehA=GhigThpcnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] cpuidle: sysfs: Display idle state enter function name
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org, 
	gregkh@linuxfoundation.org, nathan@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 4:16=E2=80=AFAM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
>
> On Thu, Nov 20, 2025 at 04:36:21PM +0100, Rafael J. Wysocki wrote:
> > I'm not really sure how this helps.
> >
> > For example, the intel_idle driver uses the same function for all idle
> > states except for the polling one, which is already advertised as
> > polling.
> >
> > Besides, why do you want users to look into the kernel source code to
> > figure things out?
>
> Hi Rafael,
>
> While intel_idle uses a single function for most states today, other
> cpuidle drivers, different architectures, or future changes might impleme=
nt
> per-state variations.
>
> The mapping from abstract C-state names and descriptions (e.g., "C1", "C3=
")
> to the actual kernel implementation might not always be clear. Exposing t=
he
> enter function offers a direct, cheap and reliable way to easily identify
> what is being executed for each state without using a kernel debugger
> (e.g., crash(8). Finally user-space tools might benefit from introspectin=
g
> implementation details at runtime to validate configuration. This is
> primarily for the advanced user.
>
> Please let me know if this clarifies the motivation.

No, it doesn't.  You'd need to tell me specifically what use case is
going to be addressed by this change.

Though this is not going to fly regardless because exposing kernel
internals via sysfs turns them into ABI which may hinder future
improvements.

So let's first talk about what problem there is that needs addressing.

