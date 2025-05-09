Return-Path: <linux-pm+bounces-26949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF32AB15C0
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A8C7AA3C8
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B488429189C;
	Fri,  9 May 2025 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcLfg91L"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D08632C;
	Fri,  9 May 2025 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798590; cv=none; b=m2QoQU05mOxYcb8mxqnrkh9KKvRxum+MQduWUlUWj7XSi1Ea4VPiFnbFxhXGbd7vgHd+9X64wedCMhvkMXBJoHLw4+0dA7+0qrCd9v8WpJoryoPE9rn902nW4EnJgVAIK8wLq1p534sJJ2DEEKV0UTxF7QkeLkb51bYMWdDjGqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798590; c=relaxed/simple;
	bh=6bZ+vf6SEbbcD54k3LpukEwQykUSzOHjLk3LAB6BAVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2gk2i+ECXNWm1aoFDUndAqyB9gxdYR2XuJcjyXAr1NmtU7P2RlwA3InxTxIPfLL+T6PvaB2+dKWu2dNE1JUW6DjnnjG3YJmVfW87nAq8kY1keJjZTvfTa5e7H54Y4SXU3UVuq9IbdweNre/9njeWmmuAt2w0GkTIGRv1KrDDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcLfg91L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37D5C4CEEB;
	Fri,  9 May 2025 13:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746798589;
	bh=6bZ+vf6SEbbcD54k3LpukEwQykUSzOHjLk3LAB6BAVY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fcLfg91LGpTLIQZEPPwf8pV0V6BUAplVsYR6gpfWHr6th9yXjZ3TbBJYYT3IrPDD2
	 CUCmYJzWVxMShkaHi4S4GHv9F9LHeWFwN1sXaxT8uXRexeju3VMY074TjncNf2dKG6
	 4dFq+FVkGD0iT22BM8rdhK0rCYLQtd1Fl2TA2Z8wzwBoWV9e/t73FjQDk2lvxtCuYB
	 U60StW+iMWdA7vApxv8rZp9yljvKvEMlhyO4mHyJNPeJLkeSkNxAwNFZCjvwsEwLs5
	 x6m8teVO538pjSqMls0ILlHWZ+BQcKe/iZ4S1MFjFCM5a1M2ocvPaQWvqRbBbsXj6i
	 ecjjZmzdQhW8Q==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2c2c754af3cso2002386fac.3;
        Fri, 09 May 2025 06:49:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+BGUFy347FsUEbSln07CNi9F+IaC2k0c6Zc9svBXTtKU+qN8XBe4qAVs8smEXklX0ol28f7wlWNs9VwY=@vger.kernel.org, AJvYcCWtH5BJ9JoNCJ7//dSJnXK2soO5IregKaFHx0QqfxerNS2j+MHsV13wQS7RFRvoKvNmTzmp6704v5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVbl0SN/MultHTuUtDjMTh74wVZBI9amchxYqBBhATsBBQLtFs
	6zVmcI/LRLYwo1kw3irqJsKIvDIikmrG4lXBkVVaSdKWgnkDRTYF2IPYDYygu3dWdHw2FUsneQa
	RZgyvQ4tGqNgFTvD9bdoKZv1O1/g=
X-Google-Smtp-Source: AGHT+IEQu7O66imBb1XCgR/7r44Byx2SHH/bX8IUTBLO+SQS6K3b/qN3CU2FJ7QEKF17DuQilWKuLOF2r3T4qgpDg9w=
X-Received: by 2002:a05:6871:ea8c:b0:2c1:7289:d62a with SMTP id
 586e51a60fabf-2dba455cef4mr2223647fac.36.1746798589193; Fri, 09 May 2025
 06:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-fix_power-v1-1-0f7f2c2f338c@quicinc.com>
In-Reply-To: <20250505-fix_power-v1-1-0f7f2c2f338c@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 15:49:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ihdg3S0--73OjdMjCxkE1NaEmBEEOc-gDS-u64gC0+rA@mail.gmail.com>
X-Gm-Features: ATxdqUG40BLfKieLCPtixT71HD9NmxJnsUih7D-2BBRvIjqTb--i7CDoi6Z2k-8
Message-ID: <CAJZ5v0ihdg3S0--73OjdMjCxkE1NaEmBEEOc-gDS-u64gC0+rA@mail.gmail.com>
Subject: Re: [PATCH] PM: wakeup: Delete space in the end of string shown by pm_show_wakelocks()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 11:27=E2=80=AFAM Zijun Hu <zijun_hu@icloud.com> wrot=
e:
>
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> pm_show_wakelocks() is called to generate a string when showing attribute=
s
> /sys/power/wake_(lock|unlock), but the string ends with an unwanted space
> the space was added back by mistake by commit c9d967b2ce40
> ("PM: wakeup: simplify the output logic of pm_show_wakelocks()").
>
> Remove the unwanted space.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  kernel/power/wakelock.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
> index 52571dcad768b988eaadbd3ce98a4ac42dd2f7dd..4e941999a53ba69410f4526d5=
d55c32312c36140 100644
> --- a/kernel/power/wakelock.c
> +++ b/kernel/power/wakelock.c
> @@ -49,6 +49,9 @@ ssize_t pm_show_wakelocks(char *buf, bool show_active)
>                         len +=3D sysfs_emit_at(buf, len, "%s ", wl->name)=
;
>         }
>
> +       if (len > 0)
> +               --len;
> +
>         len +=3D sysfs_emit_at(buf, len, "\n");
>
>         mutex_unlock(&wakelocks_lock);
>
> ---

Applied as 6.16 material, thanks!

