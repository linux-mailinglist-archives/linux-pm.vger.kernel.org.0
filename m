Return-Path: <linux-pm+bounces-41812-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFjqKRs/fWmoRAIAu9opvQ
	(envelope-from <linux-pm+bounces-41812-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 00:30:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A59BF5E9
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 00:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D5053033A8C
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 23:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D8B2E06E6;
	Fri, 30 Jan 2026 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8A9m734"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1C0211A09
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769815833; cv=pass; b=WrjkPUvui9UQJBSW2mJoOf3s+g3JTxzdLcpsAucsxf0y3I++woJpLq+MDaWeYyeFlNuiS6NIA7Wdb6MZTNBw+F0afWfJUebVLrq9TgDBVo/V8tZLXYrmg3qCAqUh8rYFBIR1fa9CFUbC0OuZT5sxTFHZSXrg5hgMhjH2f+PYZog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769815833; c=relaxed/simple;
	bh=rT7JMLQZVTloQNPuDwEaJYqdWaSBLoWAOtMrpR0m480=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oz2LA4xs8w0Ju/pIV1GrRGFWPay0WLL4IKj1T70wVdEssh5jD81OUzAYRACMu8JwOvgsfmSRnOYAvwNiE3oAwNqhmPep4F04J6v4RSXWiWHx5kc6tl5j34XP2SNIyJzlhQR8p9Cx++Uo9sKnEXmGtWkVQuTi8+QV5LLqMkf2yyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8A9m734; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79274e0e56bso27187827b3.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 15:30:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769815830; cv=none;
        d=google.com; s=arc-20240605;
        b=RB0QYv94w+nJJS+c5YPs9+gWpo3ok7uoO272cUL2D6g1Noyc2AxU5ICHersxva/fpA
         FMkjJmd9kLBCHFlZf66m4LXwxJLS3oQ9dOwjWKgBCg0IGkyT1ivF7Bi/LDlXGzSQig0c
         p7VEOeyoy6GKbsbVcFNn6qyngqWedpaaKZ0TkD3ucyPWa13K0EaEZkXeC/9TmJXIpdb5
         uoSidcMCyysPL1G7dZiifCoBgL3iFYfVN0yIJ1CtZBZnPid+CyxOKTnraXfYOqbLchip
         TLlmbIDOl5bqu8bRgUvmMuBaSI/4++/NjObmb6/6j+gB1iVuH+GPiDbuAfr2u03/b+Zi
         bgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3bpaxfJsKwpZBjFf2pjQJex7pcwV+ph+c/+CNE1sRVg=;
        fh=Joxq3QlxYlBv0a4npV38piYjQgKEtdtR2QpoH77LG6w=;
        b=kYHoVgiCxye7J/6a8qJqTEtn8IOUuTp3gkX7TJMx2jRnmC3bW/hyv4+9OxzSIJwtOZ
         U5nV25MVrpVGUHAxQ+NePORpyd2RofD/r+QAQgYX+SHh6egH7hC+8hepCNZNGEJ8eSL7
         QBsR6vxt0IV+5lr4suZJRNkeDXLEp+Ub+zZ63KSCPGnuj25tl3PG+tU301z0XzB238bl
         GMTUo2PxhrvuhsZ4vKmm/BPF8XGETHO9sU2TUhNqHbZD0yQnR9/7yFoEvhgoi4jue1Y9
         Opwj47yWfatfjwo9j3nzOV9SePqTiwcSQId7Fy8uq7wgcsY6WMCyrVLZNnoxeIvZI7nN
         0p+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769815830; x=1770420630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bpaxfJsKwpZBjFf2pjQJex7pcwV+ph+c/+CNE1sRVg=;
        b=g8A9m734K2lmh3+dqfxSoNpYcJ4PcV7zXmsIyKi3tPYU0DeGytilNsTxrQqWU+F7nh
         gk3APc83i118zgohjuEKTl8pF2cZdfD3krDf131Z7q7pBa+JiNlFoVoq7OpmnWciDQRF
         GnkSJNdrRPsBSAMWKRQENHjAZxeAqGhAfprySBwez3w1ncGmMxVy13SQuOmiURAIkBEm
         kpP4jG5FxzqC6eUkB7rZcg5DAtNjEWO/ipvsIdXAXLHSMqXhzmlAR0EMkdV4a2PazJuH
         4VyHEsGSCCgEAam5lqVSWjLYnyZIJk0qmfNzgwZCV/1AwkcK4EFh/Cxj+S8o8r5VSGHG
         jBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769815830; x=1770420630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3bpaxfJsKwpZBjFf2pjQJex7pcwV+ph+c/+CNE1sRVg=;
        b=QROvHT2wPTDIRFf84m5LwDW1DyX9QFiTzOzfEdoAZAGiHW4INs14+5x0Fi+vFvgWbe
         UshSb9UfDKrPsrZgJ2bCrnptd+qJGgnthXiGzmBVOE2iONzof/2J4r6GhBckHMJxRbvb
         F9D6uIyk/6OPq74hAWm+R6dMheykhmkunhdmn6h6SnYcyZiJ0pBBMxaEq8exVfUOlzuV
         qg/f3YLLQgBMKjADYHqQGKScF1yyN4iqjKCqE3H8J34ip6zUoynoPc6b1tHx/We5mzHw
         u0ATjNfABDIiq5xaJl5FHRMS3T9QNStHd97j/vKKo/ffvzmmvhgo/ITCR79v2f9ool+A
         aZzg==
X-Forwarded-Encrypted: i=1; AJvYcCWeQAZ4Iujaj9veW9G59c7/zLxqoFrON576NYWfNOihGNMPdc5EonLd4ObKK9RHaZ+h2mJrwCscxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI56eonSbgIn+ZBWofMJToxkEPc6a+1qhXAZeYbsGF0fPWMU7N
	U/GJnaTA+RFHTjfkVJktoo0EPsPmEecaCwbvN5j5fCmX5HosGOzJN7sAlneZ6XVFsryN6nncZzL
	+UFsllaNHcWlfjC2EOC9rDzCeBn0WFSRw1Z27DtXL9A==
X-Gm-Gg: AZuq6aIhmShrU6bvgGomw+xWn+wipSyIArRLWZ6KR97ncqvAt7pI24SBwmvILL3evvq
	q6nu9SquxVnsjsgQqN6/xbVodJTlfowj43bdaF6047ZMP07luiWSZvjCUJyw6Lh26N9EaItKKw1
	uUrTeeRt393Ibq1tNG3qJQquRLEHya67KNvmonzJhDZquWqHGgV9+OL3Lgxf/YrXeIF7Blq+fMZ
	ZEN7wXCaLw1dIcA3zAUXkYViQTlUl8/TCC4N6fUCVEkhmhNJd+UqEnraR85pHnr6Xq/wqSlkLte
	/vu5G2ymIdGAZrJXthJoXQu8hz2s
X-Received: by 2002:a05:690c:38b:b0:794:8cde:3ef0 with SMTP id
 00721157ae682-7949e025a14mr36842957b3.61.1769815830402; Fri, 30 Jan 2026
 15:30:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126-b4-macsmc-power-v6-0-9861d4070f92@gmail.com> <aX0L6Kb63My-PsGd@venus>
In-Reply-To: <aX0L6Kb63My-PsGd@venus>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Sat, 31 Jan 2026 10:30:19 +1100
X-Gm-Features: AZwV_QgJvifP9ntug-W6Gb1lAE8Nl6_8Gyela5QkjsYmR3oHPckI82eNoFIRm5E
Message-ID: <CANpmGNsCC09A4Dgy0NMye83g1c22x1RbOG0KRpvDryPW7H1oNA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add Apple Silicon SMC power driver
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Hector Martin <marcan@marcan.st>, Joey Gouly <joey.gouly@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-41812-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelreeves077@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,collabora.com:email]
X-Rspamd-Queue-Id: 03A59BF5E9
X-Rspamd-Action: no action

Hi,
On Sat, Jan 31, 2026 at 6:54=E2=80=AFAM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Mon, Jan 26, 2026 at 10:16:55AM +1100, Michael Reeves via B4 Relay wro=
te:
> > This series adds a power supply driver for the Apple SMC found on
> > Apple Silicon devices. This allows the kernel to report AC status,
> > battery charging status, and power metrics, and modify the charging
> > behaviour.
> >
> > The first patch adds the driver itself, and the second patch wires it
> > up to the MFD core.
> >
> > The driver is based on an original out-of-tree implementation by
> > Hector Martin. It has been refactored by myself for upstream inclusion,
> > including support for newer SMC firmwares, devices without batteries,
> > dynamic property detection and improved state management, among other
> > things.
> >
> > This series is based ontop of the current linux-next at time of writing=
,
> > the exact commit hash is listed below.
> >
> > Tested on: Apple M3 (MacBook Air, J613)
> >
> > Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> > ---
> > Changes in v6:
> > - Add FS header include for emergency_sync()
> > - Link to v5: https://lore.kernel.org/r/20260126-b4-macsmc-power-v5-0-3=
02462673b18@gmail.com
>
> This fails to build as module, since emergency_sync() is not exported:
>
> ERROR: modpost: "emergency_sync" [drivers/power/supply/macsmc-power.ko] u=
ndefined!
> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
Thank you for finding this! Sorry, I didn't test building as a module,
only as built-in, I will do this
going forward in future. After some research I've found
hw_protection_trigger which is exported
and will emergency sync and power off (just like this) after a
customisable timeout, which
seems suitable for this usecase. I'll test it now and submit v7 shortly.
>
> Greetings,
>
> -- Sebastian
>
> > Changes in v5:
> > - Readd cover subject that mistakenly got dropped, apologies.
> > - Link to v4: https://lore.kernel.org/r/20260126-b4-macsmc-power-v4-0-a=
a2a682ca650@gmail.com
> >
> > Changes in v4:
> > - Restore Hector Martin as primary author for the series.
> > - Restore downstream Co-developed-by and Signed-off-by tags.
> > - Add Reviewed-by: Sven Peter <sven@kernel.org>.
> > - Simplify MFD patch authorship and remove redundant tags.
> > - Fix probe return value being overwritten by devm_work_autocancel.
> > - Return -ENODEV in probe if neither battery nor AC adapter are found.
> > - Add bounds check for nprops against MACSMC_MAX_BATT_PROPS.
> > - Refactor macsmc_battery_set_charge_behaviour to remove unnecessary re=
sets.
> > - Improve critical_work shutdown flags and remove return.
> > - Add comments explaining SMC key firmware history and flag meanings.
> > - Clarify event ID descriptions and restore BSFC flag comments.
> > - Remove redundant dev_dbg logs for missing battery or AC.
> > - Link to v3: https://lore.kernel.org/r/20260115-b4-macsmc-power-v3-0-c=
236e09874be@gmail.com
> >
> > Changes in v3:
> > - Rebase on top of latest linux-next
> > - Drop charge control threshold properties.
> > - Switch to devm_work_autocancel() for critical work.
> > - Add platform ID table and remove MODULE_ALIAS.
> > - Simplify property array management in struct macsmc_power.
> > - Improve probe error handling and device pointer usage.
> > - Minor style and indentation fixes.
> > - Link to v2: https://lore.kernel.org/r/20260109-b4-macsmc-power-v2-0-9=
3818f1e7d62@gmail.com
> >
> > Changes in v2:
> > - Added Reviewed-by: Neal Gompa <neal@gompa.dev> to all patches.
> > - Fixed Makefile alignment by using tabs for the macsmc-power entry.
> > - Upgraded physical battery exhaustion log level to EMERG.
> > - Downgraded software-triggered orderly poweroff log level to CRIT.
> > - Added check for CHIS key to skip AC registration on desktop models.
> > - Link to v1: https://lore.kernel.org/r/20260105-b4-macsmc-power-v1-0-6=
2954c42a555@gmail.com
> >
> > ---
> > Hector Martin (2):
> >       power: supply: Add macsmc-power driver for Apple Silicon
> >       mfd: macsmc: Wire up Apple SMC power driver
> >
> >  MAINTAINERS                         |   1 +
> >  drivers/mfd/macsmc.c                |   1 +
> >  drivers/power/supply/Kconfig        |  11 +
> >  drivers/power/supply/Makefile       |   1 +
> >  drivers/power/supply/macsmc-power.c | 852 ++++++++++++++++++++++++++++=
++++++++
> >  5 files changed, 866 insertions(+)
> > ---
> > base-commit: ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
> > change-id: 20260125-b4-macsmc-power-bb30389e05f1
> >
> > Best regards,
> > --
> > Michael Reeves <michael.reeves077@gmail.com>
> >
> >
Thanks again,
Michael

