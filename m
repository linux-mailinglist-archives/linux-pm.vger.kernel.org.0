Return-Path: <linux-pm+bounces-28565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D54AAD79E7
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 20:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D22A27AE3B8
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 18:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AC51F463E;
	Thu, 12 Jun 2025 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjiiOam3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A9713D539;
	Thu, 12 Jun 2025 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749754021; cv=none; b=NlFWtEBDsPKNVlr/t5N8PHNhcFrWXQNp4A0dy/EzwDIllodns/ofcvxoRWZdOABwGyY2DMOEdOOGfrWPPpPmkXBFAfh6Y5cMFpA+GegczrGIFiKCPmmc0io29bT7PC8ERkhAmK5A+WPNmpODfHxHMKojA0wPj8IFrOvkySfAYGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749754021; c=relaxed/simple;
	bh=rae+Xy+GVeClcCuswO7WbVtIsL71ZmU4FtcEUBegmnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrOLie8W7A/P4toljWIbIMYpinyAPdpYs2TiHSo1k7Z0FtOg+YWtVsXlCzk01L+ah4Sy5oBdVtsRoQ9GUeLRuIGjVVprsUCPcqT5E4MJpmgxPoeuUJt2lr6zB7ukStZ/DJnmwpMrzfYXu4b654V4fVVltobY+1J8WB78tVFMDhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjiiOam3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037DAC4CEF1;
	Thu, 12 Jun 2025 18:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749754021;
	bh=rae+Xy+GVeClcCuswO7WbVtIsL71ZmU4FtcEUBegmnw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OjiiOam3P0ES7NiE+EZJjuXt7LqkCLNruQnPCNpX06jpVlpRfuT+ibrxnDfCr0Qgc
	 aVmenVGPayEVh2vBYKeO9OxkFdANxN+sF9dpZl1f50vhu/3TPnrU6fxMxryjugHJ0F
	 OKC1MjSo8BZ23PZF3xzP0Pw8eXOEpdfMIwAETx+6iXATUZ93/ovbHZklNkYigseKK1
	 JRcZtE7lzdX62ZT87N0AZ+XGacFN00z4cIWuGiWW2U8AK/gPVPESeseWd5DA9iYXhT
	 6WAamqnLjbDyz5qKvoz8e790Q2osebh0BfhNUmWJDrQD/hrQJK+PMqsG/tGOBfkszj
	 Rjk7GyUDVfOlA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6065251725bso871119eaf.1;
        Thu, 12 Jun 2025 11:47:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1rHUBy2kx3KRoTGpddzPz9vqOvfzo9fqma0Dy5HIZttUG/Gv5k2u+6UmF3uDDutOvhPp1sjwKGw==@vger.kernel.org, AJvYcCW5JliNhPEphbk4qbS3oLyS/PPN+mgniZbpA0rIvZKbikGRfSqxnRXqXOEJOe/MXbxYJ4oMmB094zIIHWylep3up4C/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3RQllC2Qm/q7CRxpFFUr73tr2qJWC6gkW/5FOVkdJqtp76mtm
	SOI2xKwz7TGVS7sU5GrTHOvZ4RDhvlDdYZ+UbR83QyzUV0mLIa1MAlAk7ni8ifMsnLR8e7gqCTa
	556zKbwyesbYOrwzPWSnQPXlBcS3lQxc=
X-Google-Smtp-Source: AGHT+IGVBH3lWI6ocKqXpduli60MAl5yPrTXUSBJUCNvpZ8YMVLXnRTpp4jSJe5p38bu5Vi5w5+ShdNClwr7F6Qn4V8=
X-Received: by 2002:a05:6820:1a09:b0:60f:3be9:187a with SMTP id
 006d021491bc7-61107aa1b27mr172114eaf.8.1749754020209; Thu, 12 Jun 2025
 11:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612145310.563358597@goodmis.org>
In-Reply-To: <20250612145310.563358597@goodmis.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Jun 2025 20:46:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iTrDBV7wG0gzpg3hzjBFWUdohquyVGta93uOhyoWpiLw@mail.gmail.com>
X-Gm-Features: AX0GCFtmIZhBJxZjxq0ItKlhq1D_VGfvqSHyPe_kp82oXVvS-MbMbDdYCDMbVmA
Message-ID: <CAJZ5v0iTrDBV7wG0gzpg3hzjBFWUdohquyVGta93uOhyoWpiLw@mail.gmail.com>
Subject: Re: [PATCH 0/4] PM: tracing: Don't compile in unused trace events
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:52=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
>
> I have code that makes unsued events trigger a warning. I'm currently cle=
aning
> up the kernel to remove the majority of events that are defined but not u=
sed.
> When an event is defined, it can take up to 5K of text and meta data per
> event. An event should not be created if it is not being used.
>
> The powernv_throttle event is only used by the powernv code so I moved it=
 to
> its own header file and it gets created when the powernv code is compiled=
 in.
>
> For the other power events, I just added #ifdef around them with the conf=
igs
> that enable them.
>
> Steven Rostedt (4):
>       PM: cpufreq: powernv/tracing: Move powernv_throttle trace event
>       PM: tracing: Hide psci_domain_idle events under ARM_PSCI_CPUIDLE
>       PM: tracing: Hide device_pm_callback events under PM_SLEEP
>       PM: tracing: Hide power_domain_target event under ARCH_OMAP2PLUS
>
> ----
>  drivers/cpufreq/Makefile          |  1 +
>  drivers/cpufreq/powernv-cpufreq.c |  4 +++-
>  drivers/cpufreq/powernv-trace.h   | 44 +++++++++++++++++++++++++++++++++=
++++++
>  include/trace/events/power.h      | 28 ++++++-------------------
>  kernel/trace/power-traces.c       |  1 -
>  5 files changed, 54 insertions(+), 24 deletions(-)
>  create mode 100644 drivers/cpufreq/powernv-trace.h

For the series:

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Thanks!

