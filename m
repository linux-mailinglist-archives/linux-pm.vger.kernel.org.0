Return-Path: <linux-pm+bounces-20945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABA7A1BD5D
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 21:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2935D188F7A4
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 20:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DE9224B12;
	Fri, 24 Jan 2025 20:28:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98718A93E;
	Fri, 24 Jan 2025 20:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737750498; cv=none; b=AWcIM9x00Ui1nc3K37sh1MjHTYGURIQRon3OjDiBV34w0HbG6RPH/pxw51zWB0OCJ6OK39SR3dslrilvZPl3Ib7Pgimy5IOvocOQZxYEHxhXE7RpDyscpZ0FBKEI8CiMRbg4wHvBboq1G+7QEUzvezayZuUwmYvfh8iJoc5qeoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737750498; c=relaxed/simple;
	bh=r0pJJfMwlOwu8JpK6FSU5yUYusLZf+hX1ICXUCSrI4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcXXYbake312BXriTH6eTXBv2g6IcCuzfeNTjwEl0VcY0BhUlQIrbGQyldAVuhIPSpznG651SOU/R7UW4UyuW637WYcUaBHcLHVqZ/bHVqg1Ym9xEq8vn87vQmDQaUmJqdaVMyDJE36CrH1HL5FAGNKZzWlo8HPBwrzfQMVc5d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512F1C4CED2;
	Fri, 24 Jan 2025 20:28:14 +0000 (UTC)
Date: Fri, 24 Jan 2025 15:28:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Keita Morisaki <keyz@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 lpieralisi@kernel.org, sudeep.holla@arm.com, rafael@kernel.org,
 daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, aarontian@google.com,
 yimingtseng@google.com
Subject: Re: [PATCH v2] cpuidle: psci: Add trace for PSCI domain idle
Message-ID: <20250124152824.292985bf@gandalf.local.home>
In-Reply-To: <20250120013616.1116126-1-keyz@google.com>
References: <20250118072438.3647805-1-keyz@google.com>
	<20250120013616.1116126-1-keyz@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jan 2025 09:36:16 +0800
Keita Morisaki <keyz@google.com> wrote:

> The trace event cpu_idle provides insufficient information for debugging
> PSCI requests due to lacking access to determined PSCI domain idle
> states. The cpu_idle usually only shows -1, 0, or 1 regardless how many
> idle states the power domain has.
>=20
> Add new trace events namely psci_domain_idle_enter and
> psci_domain_idle_exit to trace enter and exit events with a determined
> idle state.
>=20
> These new trace events will help developers debug CPUidle issues on ARM
> systems using PSCI by providing more detailed information about the
> requested idle states.
>=20
> Signed-off-by: Keita Morisaki <keyz@google.com>
> ---
> v1->v2: Split the ftrace event into two (psci_domain_idle_(enter|exit))
> 		and rephrase the commit message accordingly. Rebased onto the latest.
>=20
>  drivers/cpuidle/cpuidle-psci.c |  3 +++
>  include/trace/events/power.h   | 37 ++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)

=46rom the tracing point of view, there's nothing that sticks out that is inc=
orrect.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

As for if it should be applied, that's for the maintainers of the subsystem
that it exists in.

-- Steve

