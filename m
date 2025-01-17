Return-Path: <linux-pm+bounces-20643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DE9A158B3
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 21:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833D13A8E94
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 20:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4699F1A9B5C;
	Fri, 17 Jan 2025 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WI+diBVs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEEE1A238C;
	Fri, 17 Jan 2025 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737146372; cv=none; b=tyz2qCst7uThABn4SoJqaapfPh+DRwC2cTBRtViOGseWD98s5LLU1yBY8iersmRIgyTkMktTUQplmAQR/4DXTNQVP78ASjjeQiBo2EdDVQhmjT1Yh+jiUoBl3cNpptyEmpDyMvMGAcjiheQpNUzrcB4ngej4rYCuk34DG/X+miw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737146372; c=relaxed/simple;
	bh=02C1+kSYfyjckmjSRW7gZxiV8lZ+PbR8lB8xGhhah3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9mHvXyZfWZGmZicHOi30HpRL2OtdQxCdmE9g3fdx9SqgV4VmksQwLE4chlVTKtPxQvsARWDned1XcVmauSRxi5/HzpdewM8tzTgi46TpCmOzZB9/iLyuRFDa9r3PZT4WUJb+O1D50pjjNCUwrSFdZOAIR0J+1JLfOcDXhzIahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WI+diBVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A80C4CEDD;
	Fri, 17 Jan 2025 20:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737146371;
	bh=02C1+kSYfyjckmjSRW7gZxiV8lZ+PbR8lB8xGhhah3E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WI+diBVsGQBcHPso1kYGCgvoNv863PAKNccDp+UNZvvqmrv+gFxA10Mx5wCChcPoF
	 c09coMf21iKcd9QRxUhygKB0NLjXR6Gud/3RhzihCmC7xRwI+zke1eazn3ZHyXo2k3
	 kez9JmxojjPtlsFD/REVRAQgiYpRPQFl5n6ARAvAc6PaOQ+v9pjSKNA6URdxXoOO82
	 8HMN8Wl6vgxggLJ952AmXkv4KvOKUUhL+bDIKD4bKMfEUin9XCZ1/RS/TGwPCQJY9k
	 N08rBFPjFsv9xeKosS2UMrvUHrOZcm9XV/p16uhWbX4PnvQqfo/glV0jJ9hW9blxpy
	 mUECyR7MxVjPw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2aa179a8791so2101906fac.1;
        Fri, 17 Jan 2025 12:39:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJvgQ5KTbiZa0cA9K485klcqv9Iz01bjPpdUPKq//eyuGMij7iVVlz0HsLouZ0Hvd2pCXjw1N7Eqc=@vger.kernel.org, AJvYcCXc1mpPdJjgR/tEY0ukror/0tieYIewWnc+Hq1RUgybBlGk6ffKxaRPSZ0qAe9W0TUgHj04z5fNKG9RCIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBzXFmjNZ6CnQWquwDWRfZDIMLt1tnjFaT4UBgbtTsOkZeCzZY
	ZAXRE57K+RGuT+DB5AHbr/AFtCkO0ABgFqonhkahO1bou5r1JVEJAhGTju26ZPu31Ar64ckIL0T
	xfAdq/lyYOhZnHlxFzTO3E3GqBTc=
X-Google-Smtp-Source: AGHT+IEalU/o1KA83gr6b+/W9WgaDsAhcEqzMVIXWfIZuL2VgKl8+dzJL0W0W098hg+TBz6Z0v1wWUn0tvaNN3hZkKI=
X-Received: by 2002:a05:6870:ad8c:b0:29e:74a0:e03f with SMTP id
 586e51a60fabf-2b1c0de4d5emr2401516fac.24.1737146370887; Fri, 17 Jan 2025
 12:39:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bb8faeef-d79f-4156-9a4d-5a0dbbcad7a1@linuxfoundation.org>
In-Reply-To: <bb8faeef-d79f-4156-9a4d-5a0dbbcad7a1@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 17 Jan 2025 21:39:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gxxQqthYEnucnTqxJiiqMZD8wVLz15xyy8WUPxNKuShg@mail.gmail.com>
X-Gm-Features: AbW1kvYUkdvTNZN-mkLz11FZyZpa9NloHxs9-MVdIuplGgDjYJ9_bzNgdTlKdWQ
Message-ID: <CAJZ5v0gxxQqthYEnucnTqxJiiqMZD8wVLz15xyy8WUPxNKuShg@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower second update for Linux 6.14-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.com>, 
	"John B. Wyatt IV" <jwyatt@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Fri, Jan 17, 2025 at 9:32=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower second update for Linux 6.14-rc1.
>
> - Add missing residency header changes in cpuidle.h to SWIG
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit 8d097444982d7b23a5396169dc9d2923a59b5a=
79:
>
>    pm: cpupower: Add header changes for cpufreq.h to SWIG bindings (2024-=
12-27 08:11:51 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.14-rc1-second
>
> for you to fetch changes up to 3d6f25870d172e2b5f27dd829bbe567d5fe8ea31:
>
>    pm: cpupower: Add missing residency header changes in cpuidle.h to SWI=
G (2025-01-13 16:13:49 -0700)
>
> ----------------------------------------------------------------
> linux-cpupower-6.14-rc1-second
>
> - Add missing residency header changes in cpuidle.h to SWIG
>
> ----------------------------------------------------------------
> John B. Wyatt IV (1):
>        pm: cpupower: Add missing residency header changes in cpuidle.h to=
 SWIG
>
>   tools/power/cpupower/bindings/python/raw_pylibcpupower.swg | 2 ++
>   1 file changed, 2 insertions(+)
> ----------------------------------------------------------------

Pulled and added to linux-pm.git/linux-next.

Thanks!

