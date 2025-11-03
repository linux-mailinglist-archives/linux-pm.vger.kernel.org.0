Return-Path: <linux-pm+bounces-37319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D09C2DF41
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 20:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C61E3BC7CF
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 19:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA0229E113;
	Mon,  3 Nov 2025 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd4FU5WC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E76238C1B
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199792; cv=none; b=hfEaeQ2mZzITUfHHUrnxNcX0I2pNT5DP7+F/BihiIPjZjoVK7XHmLhGLCG8+1J7Xn4W7AFNAeNUDaH7ZeqC77CBxspvUMy/6rCFoydafcuawabVKsj0j+rl/yLOBkahv74ABqKRc7pqoWGAbPinrnHF9GVqgXUoeyLmARZkhMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199792; c=relaxed/simple;
	bh=K8U9FjbSy68cHFiBv6fP3tmAtWKlD6ipzwvHHEvYLv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMK3w2K8r205y7JwaH+Ewcfxv7aZx754XccW0GfEeFyzlPGq480xJgr/85BJgXXtV7fBmifjdJ2Hv7elrU2c6ZInvxJdnNlMZfPxY8GDyExVfeSTfVErE1YqfvprdSaDcAdYFkTEzj2mQlB+ClVPrlZra7AlCfCI2TVrE9576K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd4FU5WC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71A6C113D0
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 19:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762199791;
	bh=K8U9FjbSy68cHFiBv6fP3tmAtWKlD6ipzwvHHEvYLv4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Cd4FU5WCBfGXFnP9m3HY77kLl06nseMXEwojC6X3kDXlc0+e/oPZrYc/9ePox2ojh
	 zDZORSbY5DDLm+GeEcMLNCxqmn/7tyADGYb84kxc8wUQleYO8PDmS/7f8iu7RDTJz2
	 ET/4WeopbBP3lLiZgZalzqRrdXBDL5rtbkUHMCNlz7AW4U2RQOwmSa3IjL42hd53hb
	 gS+H1pCwhKNKwU4Og/JOC5kYTYqGcCU7Pwic5KiWY1pUejNSmrxjmJnyPCiCMR0h8n
	 5p6Hh/k9teKeF1oxMu0P0chi5+z5I+Tn562f6NV6fIOT1q1ONXVa1J4ImtjxzSTn0y
	 y3yaschxevwhQ==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-44fa105ce72so1342007b6e.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 11:56:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKXr+IDuN6LNVOkwrnCS6zVER+R0LLpUwexwcFBuF+nZMkFUdzfPc8OxMEYQdYV5utLePMGUMJZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2PYXEbP/nK+YJj1B2ViNG/7rD6mMT0IJXKcZsNmmg1E2RFaMo
	T/JsR0BGxPdAENFYUXM62gpsWeylA8B9JV5t6uG1nY5pakgo5e7+ZTKsvfdrgH4ua6uQYrfcO88
	5ZTImpkFbUlX4m27GO7szmFpizIp/VqA=
X-Google-Smtp-Source: AGHT+IFLBIvlFygNPnaui76B4Uc/Q8alPYhqukXcVN9dqWzcvHCti1vpdnsQMxld4YiAMnmiHZgk6pz1Dnkkto30Uew=
X-Received: by 2002:a05:6808:448e:b0:43f:42d4:aca5 with SMTP id
 5614622812f47-44f95f46bd6mr5773953b6e.37.1762199791150; Mon, 03 Nov 2025
 11:56:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025004341.2386868-1-superm1@kernel.org>
In-Reply-To: <20251025004341.2386868-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 20:56:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ivamhYUY_-0KYjDhy0esvxHgLayyhx4BE3ELZnBmS7NA@mail.gmail.com>
X-Gm-Features: AWmQ_bkdpMtbpeCj5vDZZF6lpgqCZ-HR9ktEEdT769kkMtfO8s8iBfF71stVQxQ
Message-ID: <CAJZ5v0ivamhYUY_-0KYjDhy0esvxHgLayyhx4BE3ELZnBmS7NA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: power: Add document on debugging shutdown hangs
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org, lenb@kernel.org, 
	pavel@kernel.org, Harry Wentland <harry.wentland@amd.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 2:44=E2=80=AFAM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> If the kernel hangs while shutting down ideally a UART log should be
> captured to debug the problem.  However if one isn't available users can
> use the pstore functionality to retrieve logs.  Add a document explaining
> how this works to make it more accessible to users.
>
> Tested-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  Documentation/power/index.rst              |  1 +
>  Documentation/power/shutdown-debugging.rst | 53 ++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/power/shutdown-debugging.rst
>
> diff --git a/Documentation/power/index.rst b/Documentation/power/index.rs=
t
> index a0f5244fb4279..ea70633d9ce6c 100644
> --- a/Documentation/power/index.rst
> +++ b/Documentation/power/index.rst
> @@ -19,6 +19,7 @@ Power Management
>      power_supply_class
>      runtime_pm
>      s2ram
> +    shutdown-debugging
>      suspend-and-cpuhotplug
>      suspend-and-interrupts
>      swsusp-and-swap-files
> diff --git a/Documentation/power/shutdown-debugging.rst b/Documentation/p=
ower/shutdown-debugging.rst
> new file mode 100644
> index 0000000000000..cdfa2cd90e5c6
> --- /dev/null
> +++ b/Documentation/power/shutdown-debugging.rst
> @@ -0,0 +1,53 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Debugging Kernel Shutdown Hangs with pstore
> ++++++++++++++++++++++++++++++++++++++++++++
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +If the system hangs while shutting down, the kernel logs may need to be
> +retrieved to debug the issue.
> +
> +On systems that have a UART available, it is best to configure the kerne=
l to use
> +this UART for kernel console output.
> +
> +If a UART isn't available, the ``pstore`` subsystem provides a mechanism=
 to
> +persist this data across a system reset, allowing it to be retrieved on =
the next
> +boot.
> +
> +Kernel Configuration
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +To enable ``pstore`` and enable saving kernel ring buffer logs, set the
> +following kernel configuration options:
> +
> +* ``CONFIG_PSTORE=3Dy``
> +* ``CONFIG_PSTORE_CONSOLE=3Dy``
> +
> +Additionally, enable a backend to store the data. Depending upon your pl=
atform
> +some options include:
> +
> +* ``CONFIG_EFI_VARS_PSTORE=3Dy``
> +* ``CONFIG_PSTORE_RAM=3Dy``
> +* ``CONFIG_PSTORE_FIRMWARE=3Dy``
> +* ``CONFIG_PSTORE_BLK=3Dy``
> +
> +Kernel Command-line Parameters
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +Add these parameters to your kernel command line:
> +
> +* ``printk.always_kmsg_dump=3DY``
> +       * Forces the kernel to dump the entire message buffer to pstore d=
uring
> +               shutdown
> +* ``efi_pstore.pstore_disable=3DN``
> +       * For EFI-based systems, ensures the EFI backend is active
> +
> +Userspace Interaction and Log Retrieval
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +On the next boot after a hang, pstore logs will be available in the psto=
re
> +filesystem (``/sys/fs/pstore``) and can be retrieved by userspace.
> +
> +On systemd systems, the ``systemd-pstore`` service will help do the foll=
owing:
> +
> +#. Locate pstore data in ``/sys/fs/pstore``
> +#. Read and save it to ``/var/lib/systemd/pstore``
> +#. Clear pstore data for the next event
> --

Applied as 6.19 material, thanks!

