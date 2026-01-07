Return-Path: <linux-pm+bounces-40405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7596DD00131
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 21:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6515C30550D9
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 20:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE5933986E;
	Wed,  7 Jan 2026 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3vG7pUU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8648833985D
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767819262; cv=none; b=dRIx1bb88UsxrBTx9ZYdqplhYs0JHJXWudvv5hPwANWrrI2xF0+yKUrjAz6ntdjswDYUGL4Hqx/Tm8Dt4c+mSGi8xnJG46Zo8F6VHWjyORJ6+V1UisIAzXBU5yQk2Ef/Qcpc4whBAztpz7uEvRa0h6cRW/bTE/8hz0ub5ixEXtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767819262; c=relaxed/simple;
	bh=znYsqZrF8MEY5vx7UxEDoP8bMd82co4/4IZKl7WKKWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBXsXFlbxXUPONTWpLBJK+HaRjCuQEdepDVpAy+hiaXeaOA5TqXLJ460gH2x7t4XHjw6X3f3NnPkDrrBIwx3tNv5nxqrZOv2S8/7oTua5ipqrb7qRYeVpL8U2XX1ZmKdRNTM8ki0ZT2TEX+rM5d1S2+TFOz+w3PrJH2/To6/Al4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3vG7pUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B38BC19423
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767819262;
	bh=znYsqZrF8MEY5vx7UxEDoP8bMd82co4/4IZKl7WKKWM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r3vG7pUUmpc3r62VTrhIK8t3C1DWCIYHqnAFrrLDqHyzSLycKK13Djo7BXiybvEur
	 r32IeQvF61zGZXv1cRISBtDigWahi8nF2lT9DAZOsE9y/ZKuC7XP8V5SBcXuiMnieM
	 wGoyDqlBhOP1+vmVd0FHRRb0DUEHuzEA9m7leyz++SCNHRinb1JuWBhlBeeWVXr55l
	 7sahzWNPizpJ7QQlnhqJikkrbaYxWbssq4E+ILbhvs77f/5LqqQp0f5qQEmo6lwsaJ
	 a5dunjHS6gT5YfNjltKKhEx2BOnLxpuvej9aC7DaofOT0UHMJYE7dSSYvaaqhPtytI
	 EqmjpsHv10vxg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3e8819eda8bso935267fac.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 12:54:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJuXq7MpgIdaQE7CRmuBzSQUlJApu0dFLDNKbVOmmiPwCL6tBQxCLDSI8lbnFGQuCfiHq3sOXVFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDENZs2wrepWqm3bVa4FF4boO6jey6LDEGkW+VaYpfib6dkn5J
	SXkrpDsMBCjzurOejOiyU/EyvzR0yviEsDeFHHz5jkzNIV/e2/J0YW+dTHK4wjJGhNTWqBp3xs+
	dZau7PrA9b7dZg3kBd/n3vU1pza4LiHg=
X-Google-Smtp-Source: AGHT+IFqsrwWQ2nKtdJwuhcWdOFD9E0SuuTrMEwjrv1Vj5uEjYAqfsK72JxV+Rqcr0bBF5tp68lzvbMwWIuP6hgTgNU=
X-Received: by 2002:a05:6820:4588:b0:65f:6ed:7474 with SMTP id
 006d021491bc7-65f54f5a8edmr1210320eaf.51.1767819261303; Wed, 07 Jan 2026
 12:54:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219184521.379599-1-sumeet4linux@gmail.com>
In-Reply-To: <20251219184521.379599-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 21:54:10 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gxm2KJ11jqsL355kjkAAb=y_L+kq5i_JSZB8LxkBV+Uw@mail.gmail.com>
X-Gm-Features: AQt7F2qkXISoxf6TaFB8qFOj7nW6-07QriIjfTgpM8kEBHQTmAM1SzGpOysn918
Message-ID: <CAJZ5v0gxm2KJ11jqsL355kjkAAb=y_L+kq5i_JSZB8LxkBV+Uw@mail.gmail.com>
Subject: Re: [PATCH] powercap: dtpm: Fix format string issues in log messages
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: daniel.lezcano@kernel.org, rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 7:45=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmail=
.com> wrote:
>
> Fix few format string issues in dtpm.c file,
> - Extra trailing comma and space in the debug message "Registered
> dtpm node '%s' / %llu-%llu uW, \n". This unnecessary trailing ", "
> before the newline character, resulting an illusion of some more
> message available for this under debug output.
>
> - Incorrect log level for subsystem initialization failure message.
> There is an error condition, not informational, and should be logged
> at error level for consistency with other failure mssages. Changed
> pr_info() to pr_err() for this subsystem initialization failure
> message.

Please leave it as is.

Error-level messages in the kernel log are only useful if the
user/admin of the system can do something about them, but this doesn't
seem to be the case here.

