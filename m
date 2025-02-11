Return-Path: <linux-pm+bounces-21876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 998EEA31628
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 20:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7833A1DBD
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 19:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DBC26563D;
	Tue, 11 Feb 2025 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEW5XX+d"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB15F263889;
	Tue, 11 Feb 2025 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303782; cv=none; b=iUUaKppEb1NTpPWyZDR/BcWlUpM/lsPYaOucQJjO1O+DKzD1w8DBsZq014Innbow4jjOw3zkUtaVooNij3hvQjmC/7fRQpMwvSTyqFc4p/Nmi4Y0DI901PjzsY1Xs5xM42Fk2XevE8nUvZ+94T8KVyqQZbcRRATb6jXKHp1plvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303782; c=relaxed/simple;
	bh=nBJQigJiT1yr/FXXSFZaZjN8SnEii17RwBuosv1Y7eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6UPBqCDACalURnb1KrcsSCMDD0C5X+1E+VyJ574S3iBntfT8lsGFnafJ+nyeN10mozKN1xuSBwMF9vqpoCbqHpr3fYY2VMxTRCJjsrglcjYN0M2vFRnAd7Awakx+jDRLIeIYZPeJDkIA5DeG3HYxGtYx/BwUTSZFW/IO/CDzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEW5XX+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8B6C4CEE6;
	Tue, 11 Feb 2025 19:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739303782;
	bh=nBJQigJiT1yr/FXXSFZaZjN8SnEii17RwBuosv1Y7eM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XEW5XX+dpxW545gkg2X1lwJFt6Fe0M5hIZwsH0Jgc1RjbMPViK4owlWr8xw1euKYc
	 Wirqa+lTO7wSbceZA2VztLan6je/77XO6bYR6YAB6QHvZ0WfaqZG76APweDJSXHmaR
	 FdltMcJy8v/cQpsHzmiU5R3QRJH0ht22qoBRnHBdav9yUIDL//EiCdNKeN/TOW65jm
	 za5YtgOMZM22tm85FbEk4D2aRnTIGB8PRAPa0WKt/b3JOZHEeovL7gEaXnkhg7TaZl
	 LPrmonUJztji6b0RGsWWyhrQomK85TSCD/VQtJaxqNpKn8NkaTk0QQfL+Su5+V5kQh
	 /8S+YwkXMGKow==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2adc2b6837eso1909788fac.1;
        Tue, 11 Feb 2025 11:56:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrPxpj3GX0z0KWLfGdhhNKPViunqNFYFK+4aAVwrrr7oMa3qcidPB/MbEXpCBMtCUbJeNQ9jWmUsSlfy8=@vger.kernel.org, AJvYcCXaFJ05c1SdrQDawf/0EnsJ350ciFF9Vz9/3Y7LeFBPHDovF2oDU6ol6+ZhCUBcRd6JGmHvfshfXoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yziq89tf8QhzVLpuRdkbfUpG84/oWgmOk5gOi+nmRWyi99KBp0x
	MJ1cbSboDxp1PsFAKthJ/x6hDjPvwA9y0OYZtjwxCPDL/GTLTYH3z1fcqp1huuxbwjs24R0Wk6s
	BTDYqpJiJsdvM9x0frC84IjO4EGM=
X-Google-Smtp-Source: AGHT+IE53ZVQgnDAbfLfTL4TCyjsDlJP6MTsRP/YQy1fNanawCkhx6gO8D4mkItT4YW3pYPrkoGmJoA4CWlA8D6XNbY=
X-Received: by 2002:a05:6870:1b0d:b0:29e:766d:e969 with SMTP id
 586e51a60fabf-2b8d64ca121mr610024fac.10.1739303781360; Tue, 11 Feb 2025
 11:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208074907.5679-1-rui.zhang@intel.com> <15de0ea2-eae6-4f23-9ca1-15836ec95cca@linaro.org>
In-Reply-To: <15de0ea2-eae6-4f23-9ca1-15836ec95cca@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 11 Feb 2025 20:56:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jykaz8y9Wb3uT=jmtrf0Q3xxWYc5nxDH_KknvjFUjfJg@mail.gmail.com>
X-Gm-Features: AWEUYZljxil1uaP98N3qUeokjk4tuAjAPl42Q8RjcDcG2Dd7Hezav7MPA68hel0
Message-ID: <CAJZ5v0jykaz8y9Wb3uT=jmtrf0Q3xxWYc5nxDH_KknvjFUjfJg@mail.gmail.com>
Subject: Re: [PATCH] thermal/netlink: Prevent Userspace Segmentation Fault by
 Adjusting UAPI Header
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, srinivas.pandruvada@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 9:01=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 08/02/2025 08:49, Zhang Rui wrote:
> > The intel-lpmd tool [1], which uses the THERMAL_GENL_ATTR_CPU_CAPABILIT=
Y
> > attribute to receive HFI events from kernel space, encounters a
> > segmentation fault after commit 1773572863c4 ("thermal: netlink: Add th=
e
> > commands and the events for the thresholds").
> >
> > The issue arises because the THERMAL_GENL_ATTR_CPU_CAPABILITY raw value
> > was changed while intel_lpmd still uses the old value.
> >
> > Although intel_lpmd can be updated to check the THERMAL_GENL_VERSION an=
d
> > use the appropriate THERMAL_GENL_ATTR_CPU_CAPABILITY value, the commit
> > itself is questionable. The commit introduced a new element in the
> > middle of enum thermal_genl_attr, which affects many existing attribute=
s
> > and introduces potential risks and unnecessary maintenance burdens for
> > userspace thermal netlink event users.
> >
> > Solve the issue by moving the newly introduced
> > THERMAL_GENL_ATTR_TZ_PREV_TEMP attribute to the end of the
> > enum thermal_genl_attr. This ensures that all existing thermal generic
> > netlink attributes remain unaffected.
> >
> > Link: https://github.com/intel/intel-lpmd [1]
> > Fixes: 1773572863c4 ("thermal: netlink: Add the commands and the events=
 for the thresholds")
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
>
> Right, thanks for the fix
>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied as 6.14-rc material, thanks!

