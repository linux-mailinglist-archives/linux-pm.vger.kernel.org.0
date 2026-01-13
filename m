Return-Path: <linux-pm+bounces-40732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D9BD18AFC
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 13:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4941E30082E5
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0504E38F248;
	Tue, 13 Jan 2026 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLsloDXe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F966389DE1
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307044; cv=none; b=LBLOW9TYJYKcc91ABF+9SuXqHak9sVLr4+V3F00HALeI1EOm10Xs5P3RQgiCUu7hcMx9UW8lOJxKdwz0kA5AoeqfvRKyIojhGZaFAAtFdUUv9OfVShaZCrRUqCAsBlnP/8UNfyE/m2oExIuxDoERXjVj1xNeCLTQXGpQWPIfAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307044; c=relaxed/simple;
	bh=n2O+8S+jpTerGsJOPL5jzjcMN1tKFELJLHPmeyg+3kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBojm2ne1mfXGlUsuQGYxvgOjTULoq6btnIr10fxL8ecuYHota5m34+Xb3zvf7Y3oSDd9/DFK6BXMiksuSPMlHZSKqQcYH98Lrr/svBu1H4jKRSSrZ7J7cOpodi/JoBAXNUy7OqFvw0n2dP82PYc0doXSaTaYEa5AOiN1Lr8AEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLsloDXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D602C16AAE
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768307044;
	bh=n2O+8S+jpTerGsJOPL5jzjcMN1tKFELJLHPmeyg+3kY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fLsloDXekgF+jN99mm3MQgITqE3lBGKpyFY+5qGmcXrNodVt4PyXPO/UfBubn59fH
	 RjdD7+UmhQNROK/QV0VUCi50sMbodbXvqHogvdnGIpbfwwwYxFw+R1tNsxDDEQ9hhj
	 xuXEznwvnzaHXi2JawqzxQCJmsmraosIlUB/oVW5ycH594l43BT5O0yUxyDt/3stOz
	 XZOu9+sH0H1a9xco8FPsudaJv0xdmhXLdu6lkI1rCuldfOTttqnpE88kYz3DKukHF6
	 30uGM/NahxLkJLrVxrT8LVI132a/3uPqRB7ikhn7MfWAtB7fwy/ErNL1+HMCeCh3DR
	 T9cjzSGrFG9Qw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3f0d1a39cabso5235968fac.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 04:24:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBLsy2bwyCYKITlvbY4TRuLBGIeU+wcuFAH0EWHJSiBxXw+JPzV5vWfr5nTm6aOt6Yy8jrHmdcTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIE5bJzpMoZmwgWx9XfI3Gh0yiFU0FTsB5xymon0Vk4glbpJB4
	fwG9cjnWbSpiDUQRvV2EzL1ipmibceLq3HT/Xw5poX+fXF0IrLSAcL1XXgz1P0D9EVBbeAczwX/
	ph7Rk6XDXcAqDJjp4CSnVCiik4UR33Zw=
X-Google-Smtp-Source: AGHT+IFtArymh5MJGF7j0B2G7oobB6Cj6U7oXuW3L8H2n7ETCAuKTUKsB7QgkZhfXCTOmVq6X1I+J2n60VS+rsB/ygY=
X-Received: by 2002:a05:6870:c0ce:b0:3e8:44ec:3416 with SMTP id
 586e51a60fabf-3ffc0b721dcmr11317088fac.46.1768307043419; Tue, 13 Jan 2026
 04:24:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112151441.1860607-1-yanhuoguifan@gmail.com>
In-Reply-To: <20260112151441.1860607-1-yanhuoguifan@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Jan 2026 13:23:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ihxgyqcG_dU0XS48g6TwHhw5rA58niTfc1SDtHBEPxJg@mail.gmail.com>
X-Gm-Features: AZwV_QinrwZQCsM2U3y2JwtIaLFf5iYbniCZf6wwJIhJmIiAPkXp1FeEjHAz8aU
Message-ID: <CAJZ5v0ihxgyqcG_dU0XS48g6TwHhw5rA58niTfc1SDtHBEPxJg@mail.gmail.com>
Subject: Re: [PATCH v0] PM: wakeup: call device resume after superior device
 complete resume
To: Li XingYang <yanhuoguifan@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 4:15=E2=80=AFPM Li XingYang <yanhuoguifan@gmail.com=
> wrote:
>
> Background:
> Extist device A,B and C.A is parent of B,C has no dependency on
> either A or B.A is an asynchronously resume device,
> while B and C are synchronously resume devices.dpm_list: A->B->C.
> When A has not completed asynchronous resume,
> the main loop will be blocked at B,and C cannot start resume
> even if it is not associated with either A or B.

Yes, that's how "synchronous" works by design.

If you need/want C to suspend/resume independently of A and B, make it
async instead of hacking the core code.

Thanks!

