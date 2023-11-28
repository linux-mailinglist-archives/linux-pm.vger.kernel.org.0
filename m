Return-Path: <linux-pm+bounces-326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376C87FAF67
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 02:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4D0B20EAF
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 01:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9276315C9;
	Tue, 28 Nov 2023 01:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C3D135;
	Mon, 27 Nov 2023 17:11:02 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1f9decb7446so2459060fac.2;
        Mon, 27 Nov 2023 17:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701133861; x=1701738661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ne/1BGfawz38RnpEDcGFX2lcTtrweNNkz2EvVODo1EA=;
        b=dQz0XNEm5qU7FVlNN//Ce7Ti20FNoWWsO6OHeGYDz2vzaqP7b9Jj6Ci0A9GN2Xs1KN
         kbuwJ7pZ5Fqi2PMXJvcMtdywvF1PKXol2MZI+c/jtQaILfG+T0SsajaFDYoVP8+//cN0
         BLyt+AmLK/5SshT2gdISw7ynAEQUUBYalyGyqmgL+cHnhs6NGJBUPsi9a4NnYGpAfmOd
         +sLVoV070z/CzWuLtEIJFsbwQD8RamBScpa1QVritij6zdKFBCvOR1iofOk9z+4dcVd0
         WC1HPMlH0ckyDDHx0fpXC3bvrV93b4yxnQJBdXQuaqNDQ/u/XG/gRQxUiO+iVDY6S4Mv
         1yFw==
X-Gm-Message-State: AOJu0YwROMARTqjxLe6ru+F3ZT5f6NiktbpTJKJ9mOZQCYVP3sVACtgp
	j/Qu3PZ8TrC75bveB24XWMsaTB13gsqUdDhctkBJZ7Np
X-Google-Smtp-Source: AGHT+IFj+A9tDPPZZ1IPR3GhrwcRUxIkAARPbua8/pydDU5x95PxtY53KncURTsCPPPLL6cuSqdeRSt66DasCi1Tqv0=
X-Received: by 2002:a05:6871:5811:b0:1f9:5e2a:ea2d with SMTP id
 oj17-20020a056871581100b001f95e2aea2dmr15726384oac.37.1701133861529; Mon, 27
 Nov 2023 17:11:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231022055221.569634-1-yu.c.chen@intel.com>
In-Reply-To: <20231022055221.569634-1-yu.c.chen@intel.com>
From: Len Brown <lenb@kernel.org>
Date: Mon, 27 Nov 2023 20:10:50 -0500
Message-ID: <CAJvTdKkFLTzWdU7bssUSJkTW4ocfKcFEu5c+8m=EVNZ44+iXug@mail.gmail.com>
Subject: Re: [RFC PATCH] tools/power turbostat: Do not print negative LPI residency
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Todd Brandt <todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

BIOS bugs:-(

I agree that printing 0 is an improvement over printing an insane
negative number.

But printing 0 suggests that there was no residency, and that could be
misleading...

Maybe we should output some kind of warning about the broken BIOS?

On Sun, Oct 22, 2023 at 1:53=E2=80=AFAM Chen Yu <yu.c.chen@intel.com> wrote=
:
>
> turbostat prints the abnormal SYS%LPI across suspend-to-idle:
> SYS%LPI =3D 114479815993277.50
>
> This is reproduced by:
> Run a freeze cycle, e.g. "sleepgraph -m freeze -rtcwake 15".
> Then do a reboot. After boot up, launch the suspend-idle-idle
> and check the SYS%LPI field.
>
> The slp_so residence counter is in LPIT table, and BIOS does not
> clears this register across reset. The PMC expects the OS to calculate
> the LPI residency based on the delta. However, there is an firmware
> issue that the LPIT gets cleared to 0 during the second suspend
> to idle after the reboot, which brings negative delta value.
>
> Prints a simple 0 to indicate this error to not confuse the user.
>
> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 9a10512e3407..3fa5f9a0218a 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -1472,8 +1472,16 @@ int delta_package(struct pkg_data *new, struct pkg=
_data *old)
>         old->pc8 =3D new->pc8 - old->pc8;
>         old->pc9 =3D new->pc9 - old->pc9;
>         old->pc10 =3D new->pc10 - old->pc10;
> -       old->cpu_lpi =3D new->cpu_lpi - old->cpu_lpi;
> -       old->sys_lpi =3D new->sys_lpi - old->sys_lpi;
> +       if (new->cpu_lpi > old->cpu_lpi) {
> +               old->cpu_lpi =3D new->cpu_lpi - old->cpu_lpi;
> +       } else {
> +               old->cpu_lpi =3D 0;
> +       }
> +       if (new->sys_lpi > old->sys_lpi) {
> +               old->sys_lpi =3D new->sys_lpi - old->sys_lpi;
> +       } else {
> +               old->sys_lpi =3D 0;
> +       }
>         old->pkg_temp_c =3D new->pkg_temp_c;
>
>         /* flag an error when rc6 counter resets/wraps */
> --
> 2.25.1
>


--=20
Len Brown, Intel

