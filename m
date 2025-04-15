Return-Path: <linux-pm+bounces-25489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB2AA8A6D7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 20:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1CB7A925D
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9255B20FAA9;
	Tue, 15 Apr 2025 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9Ng4nFy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69449126C02;
	Tue, 15 Apr 2025 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744742049; cv=none; b=GNymL5iqugdVkIxBRMLfn+ZGTLF/sugFw79ELOvGG/nTu5vXLQrgq0QjpfT6Vqw8VTq0ED8Ep0V5ZS7Z8IYjrObTcMurEPxpUllx95uJgbd7wkyvE9MlFLzFAkdnLO3Cr6VB94BawiK1EYDQkjZ/dyf/UXNUlKj454VkVBw6/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744742049; c=relaxed/simple;
	bh=GN0AXho+6xPL/OzDK6JwEd2TeunolBetRB+dgg5WpVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTrRTxstT1EtmT1HImCF+ClH//+TsFMn0t7h8a3xI1EzbVASvyfJue67fK5D7rD7aORy3RCZPHsCcOTR4XlQ1BTkmkw95dRBXRXbdMmOs8KoeQhFdl0aDHpch74KVMJ6Y4k/oINp7pLbYye1RAQDNUZzZXzmcr5QVncczfL6ZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9Ng4nFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE594C4CEEC;
	Tue, 15 Apr 2025 18:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744742048;
	bh=GN0AXho+6xPL/OzDK6JwEd2TeunolBetRB+dgg5WpVg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g9Ng4nFyRw4QXgQoLADCVMNad/loBFLsx6KZp3z65TeNnK87iq61BJVnSK9DpgnuD
	 VHdnaCbJOShyn+vr8dgbFsGomB1hrpEo6Lqaxdtfh8HdEzboZlrEaqsj6/vORL3XJB
	 Bejv+1GoV2tYAl13BjG5mdSrBgvqAbKZhRZI09dOkYKpUg8vf4rAI/SQwvwdEzJZsO
	 RHmyJAm0+QV9V6DfT3wDH6T/t8dbQ/Y1FG/gWlYACJWv+nDSFLXg40Wjm/UFkL3f1f
	 DIrjagOcdO7q19QFxqJSIepJbFSiFC+ftzdUmYwKH30xHJjgDf9Tv7wg8UYl1n1KhX
	 mEseUvfo0gkYg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so3998961fac.0;
        Tue, 15 Apr 2025 11:34:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1afac5zSVcjXy4L31NIToh2WXpDTsebvZn+KZ6PTWqsktVRlClwmWZ1vn9yNywAGRnhvltgqM0KQBHgM=@vger.kernel.org, AJvYcCVOxYUmxo3px0dFsN2cdUF89eGrJeKQqdD5XNlyR0deacMmCaSdEuuufeLsTb2A62Ds1IqOInARH0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YypCXjAuygDIafw2PHKkQ87b2ynqSJTpvf0ezfXRzU2PoBv+EUs
	P/Y5m44oHZ7YhnM76mPcLl+tVmL9T1e0oRBLIV6Z99C0rlGzfdNZexrFiFOVLQIkvzMHCUIQfwK
	pR6beG3qlNP92OPF085+odq4JIcI=
X-Google-Smtp-Source: AGHT+IHhRkmZ318d0p9TpXUxfMLu1DnY4tNRHfMkNFDD0g+/o1w/Fk2AQb4Eh2kAnIPmhcVpV3/xUw9oxVWp/yAkM2M=
X-Received: by 2002:a05:6871:6111:b0:2b8:eb06:57e2 with SMTP id
 586e51a60fabf-2d1c1043c0fmr2760922fac.1.1744742048185; Tue, 15 Apr 2025
 11:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1742278664-398536-1-git-send-email-liuyuan1@oppo.com>
In-Reply-To: <1742278664-398536-1-git-send-email-liuyuan1@oppo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Apr 2025 20:33:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ia9k2nht1mnPaMRPt760LQc-5NLbMhmgOZ16phZzKFBQ@mail.gmail.com>
X-Gm-Features: ATxdqUHVCSHzFyvF1c02x0Z8H_veppGizKcjiVbTQJlOWVsZ9ml6m1zEm21t1_c
Message-ID: <CAJZ5v0ia9k2nht1mnPaMRPt760LQc-5NLbMhmgOZ16phZzKFBQ@mail.gmail.com>
Subject: Re: [PATCH] PM / Wakeup / freezer: Check pm_wakeup_pending() before freeze_task()
To: liuyuan1 <liuyuan1@oppo.com>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chenzhengding@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:18=E2=80=AFAM liuyuan1 <liuyuan1@oppo.com> wrote:
>
> Check pm_wakeup_pending() before freeze_task() can reduce
> overhead by not freeze tasks in aborted case. freeze_task()
> will cause high cpu loading especially when system has a large
> number of tasks need to be freeze.
>
> Signed-off-by: liuyuan1 <liuyuan1@oppo.com>
> ---
>  kernel/power/process.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 66ac067..84704b3 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -49,6 +49,12 @@ static int try_to_freeze_tasks(bool user_only)
>
>         while (true) {
>                 todo =3D 0;
> +               if (pm_wakeup_pending()) {
> +                       wakeup =3D true;
> +                       todo++;

This is going to produce a confusing message below.

> +                       break;
> +               }
> +
>                 read_lock(&tasklist_lock);
>                 for_each_process_thread(g, p) {
>                         if (p =3D=3D current || !freeze_task(p))
> @@ -66,11 +72,6 @@ static int try_to_freeze_tasks(bool user_only)
>                 if (!todo || time_after(jiffies, end_time))
>                         break;
>
> -               if (pm_wakeup_pending()) {
> -                       wakeup =3D true;
> -                       break;
> -               }
> -
>                 /*
>                  * We need to retry, but first give the freezing tasks so=
me
>                  * time to enter the refrigerator.  Start with an initial
> --

