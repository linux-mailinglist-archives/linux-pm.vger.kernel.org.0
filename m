Return-Path: <linux-pm+bounces-9178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3676390898F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 12:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FDA1C26D26
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 10:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9144F194AC9;
	Fri, 14 Jun 2024 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEbBKomz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E261946CF;
	Fri, 14 Jun 2024 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360299; cv=none; b=rwxZq/4iSxIaj5ID3Qbs9V4TisfwFbP9y+MbGcafZFQCKOOjyVG8Ni3UNVczh0VIluduGehaQASp8sPb1RLltNzLWBZL9yrjGqxViGrh5O1XSvYNehFjKO5rU1B8JhGyCov5VO7C7YWq2hR85aVy+UklXRUbK1IFT7OGRtZmT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360299; c=relaxed/simple;
	bh=h8LI/aLo2YCQ6LHsew5aV45Yh/X6RYEb897K6QSHCcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjlGvp3r4vgPGtODuIXNuuR2VqyQRlp1hDxEGLu2jLVbOvBF1b3n6evmgKiNegy3XQ+B9DzLAmntOxrBXvxmsBvlwT1IVpoy5Fc41wr9QF2fCPT4u9btKMRxhQ1eeYyRQsaM6M1INPFJeuZlZMv0AlZ80izDFwja+EQTPipRF4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEbBKomz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFC8C4AF1D;
	Fri, 14 Jun 2024 10:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718360299;
	bh=h8LI/aLo2YCQ6LHsew5aV45Yh/X6RYEb897K6QSHCcA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UEbBKomzV/KNMhnpo8CPfXQvLOiAnYpmsRSU+Noine82IcDR0hlgvkaKIbbgb+14z
	 xjJSdxjyRNRJIGfyZ6nS+9FuoJTaWGFDugVjfOa1LaszunyM5QVvakBvbybI+bLrEu
	 IezpSaCMIQg+Y+3uQDlZQwqizEHfR/KsgmNgdhqR4YBL2fTsnJ9RL+NoFU2MbecL4F
	 +ziGgLNhu3HMsx4rD3p6Dwg8qHNOYmn0VBnkq0kAtms8a4N0QPWV7QvsFhyPyWhAd9
	 B9MXHLa+teQhQ2ACerLRHy2yNiV5j03/voL9uXcXmpYAQwKRRYIVD6EpkDR2h42Jow
	 mPEMcIgaHT2ig==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d1b5f32065so78384b6e.2;
        Fri, 14 Jun 2024 03:18:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmfWtRrrOLwLGl7syMmB8a+GYXuVlOrPAUmmdOK10KMvV23Uym+gI/ia+4MUYgyAlf2NZ6m4Y340x2knilNEUj2eeYQWsSxtfDecJv5rDEaJuMUI3HVz55qi3AFfy3Gb1u96INU/A=
X-Gm-Message-State: AOJu0Yxx/p+YwtpIu88isjJFxFeoISp0OIsaU5SUmHQAc8tlDz+Av7Sd
	isIPC83rDWQKJX/Qcrc8/Hs9wi3wuxvL0OtGMGVWQj1x3UUoLD6BYDjQrcCbKAk/FAULo5yyPlh
	YMwCwwoq/fhWuI7mD7khXkQmQj/U=
X-Google-Smtp-Source: AGHT+IEHJ41s4vZC8w/qfjS4THnTprUyL/hz49O9TrABifs4wGJv/11tj8VA3mnTAyto3HebuvupmbVoS5vb7IMWMY4=
X-Received: by 2002:a4a:de45:0:b0:5ba:ca86:a025 with SMTP id
 006d021491bc7-5bdad9f3f2dmr2229187eaf.0.1718360298223; Fri, 14 Jun 2024
 03:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1051df4c-067f-455e-8c7f-9dc47dc8ed00@yahoo.de>
 <435867b5-029b-419f-bb7f-2d4902c62556@leemhuis.info> <a97f9f4d-17f1-44cf-a0f4-634fd38aba2a@yahoo.de>
 <CAJZ5v0jwvq6W0u7Zx4GzQxJOnrF4KvN1RHtqqDcaMvN6yp0hDg@mail.gmail.com>
 <312649b1-eea9-4346-af93-76a821e88eb7@yahoo.de> <CAJZ5v0jfvRWK0M3Xf=36e74cVQ9rN5T1WdZZVnuk1XmZ=xu==g@mail.gmail.com>
 <78549853-1763-40cf-9974-3fc737fad093@yahoo.de> <CAJZ5v0h5pQDaA-bEOmcz_TpE87kFqWLFLJC+=OLjg5ZtF3hxpQ@mail.gmail.com>
 <91d94429-fc7e-4828-914d-1a251ee1ba99@yahoo.de> <CAJZ5v0gPZHDfuK1FRdTAG8Eqjf0NWUQdf-_GCWsWf6dCBE=1dg@mail.gmail.com>
 <543787c3-db5b-4f63-b5e0-df508300db73@yahoo.de> <CAJZ5v0h7jDw3yX689nZdB+YeJbCk0vFoUgVb4Yi0cqDxjL5chQ@mail.gmail.com>
 <40ec1e53-2bc8-48aa-9909-fac9072adb57@yahoo.de> <CAJZ5v0jtjXfvr4GXukjyO9XsEO6K2Nfux3otpFPP4vWS_9_qEQ@mail.gmail.com>
 <CAJZ5v0hcX0JAMBA+EVZURDH1BTQ2zL-W_4BjSx0a=1oRaR90ug@mail.gmail.com>
 <CAJZ5v0jGGV=i8Swu=c8f9bwo--AckUfqZrt0zeqDWKBijG+Z3A@mail.gmail.com> <bcac5925-fe2b-4570-83b6-182f4a301721@yahoo.de>
In-Reply-To: <bcac5925-fe2b-4570-83b6-182f4a301721@yahoo.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Jun 2024 12:18:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h7WnfQxhobA6B7S3Tvo-AnKTR9kP+5aexa6rixqpyHJg@mail.gmail.com>
Message-ID: <CAJZ5v0h7WnfQxhobA6B7S3Tvo-AnKTR9kP+5aexa6rixqpyHJg@mail.gmail.com>
Subject: Re: Regression, thermal: core: battery reading wrong after wake from
 S3 [Was: Bug Report according to thermal_core.c]
To: "fhortner@yahoo.de" <fhortner@yahoo.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:04=E2=80=AFPM fhortner@yahoo.de <fhortner@yahoo.=
de> wrote:
>
> Am 13.06.24 um 17:14 schrieb Rafael J. Wysocki:
>
> Let's see if the ACPI thermal zone is the real culprit.
>
> The attached patch only adds the delay for thermal zone 0 which is the
> ACPI thermal zone.  It also prints the ID and type for all of the
> resuming thermal zones.
>
> Please test it (removing all of the test changes/patches tried so far)
> and let me know what happens to the battery readings.
>
> Patch
>
> thermal-delay-resume.patch
>
> does not work. Output according to dmesg.txt
>
> Attached is a slightly modified version of the last patch I sent.
> Please test it and let me know if it addresses the problem you are
> seeing.
>
> If it helps, I think we are done with this at least for now.
>
> patch thermal-core-resume-prio.patch with .priority =3D -1 does work
>
> One more thing to try is the attached patch (independent of the
> previous one) to lower the priority of the thermal PM notifier to make
> it run always after the ACPI battery one.
>
> Please test this one too and let me know if it works for you.
>
> patch thermal-core-resume-prio.patch
>
> with .priority =3D INT_MIN does also work.
>
> If you need any further tests, please don't hesitate to tell me so.

No, thank you, I think you've done enough and it is appreciated.

I don't see any particular drawbacks of this approach and investing
more time in trying to get to the bottom of the issue is probably not
worth it.

I'm going to submit the last patch as the proposed solution.

> Thank you for your help!

No problem and thank you!

