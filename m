Return-Path: <linux-pm+bounces-17468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F24689C6843
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 05:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1321F23599
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 04:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6F916D9AA;
	Wed, 13 Nov 2024 04:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mt6kv7jj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E482B17C
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 04:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731473839; cv=none; b=TDQzUb4BPWJsBU2r/14tt0Y3rBGKjNvj21IeCxQxC8W45YDAsev/bdmP/FF1ySxKOFHCZdfYQ4sJGYfDDwp8cV7+ZuAhT1602ihwrzlIyeql8bsefGsDBq6KTMwfm8fLjdE70d62XkKDgmC/nJATxg0vJ5X/klZ/hYxHbExijws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731473839; c=relaxed/simple;
	bh=JifAmFemsyo63HkMfEhYvgvO7zx15msgyEKEspgf5ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNqjL5GmraiRJLOw1CQVm/K3P0FscCYnozl8Mj8/JQEraNdmch0BX3oAMTW/3uGsSKFynCXiEBvKXaYlKEBZv2BgcsIYwtZRgsMY1kZQi6QHKgAsDFO6f5MWSI51cI/N/8/1OzCMWh1amt9t1CbNhdXSWMA6xY0g+U1CL9n6RtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mt6kv7jj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99e3b3a411so62403166b.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 20:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731473836; x=1732078636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9cizkMlnSkQJTSX5VRA9hTdazGF3kyGBdVj0AKFLU8=;
        b=Mt6kv7jjLbYjI3rHkUkw8LEoox/JLN1xrk+EJZ6oviRgpuLK6i+PLdcpvgmzYqIV9C
         tq01HwAvMkSrU5WtszkW3xo4S62sb0J5ViTS7/B8qpVro3frcNDpz+M8c1pYIuuzXf2A
         6qi4yx5s0KjvPWboZZSLvSl8tlo4kYFBqTpfIYyzqpftb4wskZ2Rn0/sySJo8socDEop
         oRJDuCxEB81gR4ErPGmCrN++Dc33rkkaV5iz4C6VVRhVR/usslpjMdd2n2Uwlq/Z/LT7
         OsgzMoi/pTQuf7ttAW46oa4MjU+8n1Ycv+J/HE+EpNI0Q5eAzLw4dzQmKHrz4xBDrnoi
         QWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731473836; x=1732078636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9cizkMlnSkQJTSX5VRA9hTdazGF3kyGBdVj0AKFLU8=;
        b=XbUL3oz6nxzYTRxHnt3DRNKteDIcjQNPi/xTR4uLzpFITFBa542lYdig12tdwcbAaG
         3N1AtS3IApEjU0AEAReAVfoyjvZO4CveRHuokeonNnw3T1wjkwDcPviMBcM5QT7+Bvq8
         I6l0o/yX6GuKvMRK7/oVTlJmW1iNFG3QsilLx6hIhYd6IatoG8fFQOijKBZ1tVn1lUb0
         NyhBDWvc3POU3AB9BWj56j91GQWwSRzuSqz6lqm8O4GIFIl1QX5xkyfqpSX+5NCFSCj+
         f0oTG5RYEMGRFIUlk7lQPKajQNMQjRBKfDcJww3NDTCcY3/8do3LR75GiYNQ23Hv62zD
         MHew==
X-Forwarded-Encrypted: i=1; AJvYcCUC8n55nJ6hLvBe/zUlUPed5NpKsxIyeEdIRwirMI0NzOZyv6b/c2hmZVfHhgJSKl7AaOP+//kcnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdB12EB4gCG+EXXIFXFiXZvX84xbV+iTKAKfzc0573lYtIg9iu
	8AzwTo7h6k7CKrlsbxiSrMnnU9EgLAm4nAnpd5DkdHpQqM3Pz9f5iClN1J5Kfn3IybaqtK9tY//
	f6glxSWqChsU54J1wb43lpqxYlTEtSxc3LFg=
X-Google-Smtp-Source: AGHT+IE7VofiUrMaYJb+VVrnAJg28tRtxoTO4tZdwZpaWQULQuwbzbECXxJFTdkr9f4TkI2uEdj23gE4GdqDWbxYsbk=
X-Received: by 2002:a17:907:97c5:b0:a9e:670f:9485 with SMTP id
 a640c23a62f3a-a9eeffe72afmr1580317666b.30.1731473836251; Tue, 12 Nov 2024
 20:57:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820163512.1096301-1-qyousef@layalina.io> <20240820163512.1096301-10-qyousef@layalina.io>
In-Reply-To: <20240820163512.1096301-10-qyousef@layalina.io>
From: John Stultz <jstultz@google.com>
Date: Tue, 12 Nov 2024 20:57:05 -0800
Message-ID: <CANDhNCre2=8aHCgy9DNHkXix2Leu3MSDD7HRJp9wbrHBm+kNGg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/16] sched/fair: util_est: Take into account
 periodic tasks
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 9:36=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a6421e4032c0..0c10e2afb52d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4899,9 +4904,12 @@ static inline void util_est_update(struct cfs_rq *=
cfs_rq,
>          * quickly to settle down to our new util_avg.
>          */
>         if (!task_sleep) {
> -               ewma &=3D ~UTIL_AVG_UNCHANGED;
> -               ewma =3D approximate_util_avg(ewma, p->se.delta_exec / 10=
00);
> -               goto done;
> +               if (task_util(p) > task_util_dequeued(p)) {
> +                       ewma &=3D ~UTIL_AVG_UNCHANGED;
> +                       ewma =3D approximate_util_avg(ewma, p->se.delta_e=
xec / 1000);

Same 32bit build issue due to 64bit division here. Need to rework w/ do_div=
().

thanks
-john

