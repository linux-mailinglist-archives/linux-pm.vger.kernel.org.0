Return-Path: <linux-pm+bounces-16976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A701D9BBA35
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 17:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E82FB21ADE
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA821C2325;
	Mon,  4 Nov 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHLWJc5W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455FD42AA6;
	Mon,  4 Nov 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737222; cv=none; b=uQabPaiR2m3QXfNjOEQbQeq8dBx2HC9jnkng+kEXsUqhT7MCmS86954SIhcIOry7oc8sGHzxdyMp4aBBB8IcCd5ACP6lZPOfNSQFxVzPn+X4evzybDGaTaQH0rsc1MUI5ZoNeWNq55caPpmFfiUBPaLFcGjx45DpWOt4TrEc9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737222; c=relaxed/simple;
	bh=DxhaOPfKoLz2uC9aKp0uM0TtGsHNPcDML9iDcAKzt7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AE3mHfdM9YiPFdzpVKyv2tXS0eyRhe1kM/QOTtxGo+0lEibpYFOTtqSo0/9PphRFU1aHsH/Ls9NjqwZDTXbb/pB9U/5lp0dPhkwZMF8GwZCX6V7FEvIxWBD7pYymAdUHbKnqDWWzQbuiI3gDZ3B+mleI3pDAZ3Jm3bm0zcwtW3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHLWJc5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202E3C4CECE;
	Mon,  4 Nov 2024 16:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730737222;
	bh=DxhaOPfKoLz2uC9aKp0uM0TtGsHNPcDML9iDcAKzt7U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sHLWJc5WE/qeOysHvvZhkAHqYWN4tbWCRdcUWbn9bT/pdUrKlN9y81VPWvDR5SJxV
	 8tio2fDAwAOxgnc/chsF8ngIjyf5/bdWbpOhXG9eH7l9TREZabOEX0dVo0iZaKGPHl
	 yycEOwGYBQwXTf8T/7RI8e64nMv/KZCSvs4joPvRztf0CCR+uQ1dmPfJnTwAD/LjeJ
	 Tze9JtLXDZIAzgO0epHAiD6O99JUBWA+mFKOqvbb+ceakW76dH8d6GY2OcFuBMXDd4
	 Nt62chfE3EqNzgjEojaVRW/JjI3excIaSEE6JLINPXGcvapFXgjTgJH4/ozbvnBTwV
	 MqJNbNTm/Laew==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso643859fac.1;
        Mon, 04 Nov 2024 08:20:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHdKlSk53Scmg4yXnNSS5o2PYoC1MqgZTUkDYuvXPe7T+TFpry7hSp33D9aKg98iqDfjmYRAAeMo5GL5s=@vger.kernel.org, AJvYcCVxfCC5CpuhAeGuRtjfEysibFgTSWMCv+yKHRk5LOZRwsFHQdAzQStqX8cJUaIpuKP/KDxHMvG5A+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx99DAuTkED3RsYbqYJWspHnGcA8hD474QV7s+rNU6lIdhmyjZy
	Bs+ZmH5AMmTwhfeLEA8i9/vb940vm8otDSPldCtm7xiepIwydsl/C4ZfF718DOuhkt1kbV0sGAZ
	4I4biAFHKT2J7ovmGKB3fIt80e/k=
X-Google-Smtp-Source: AGHT+IFf4WD5U1Q607IIFaIyvF/k5k3uxxuk7F9lgmG54W9ALpQZiRlt/Q2lQGza9d878zL0uda1EJ6u9nDexYRXny0=
X-Received: by 2002:a05:6870:1d10:b0:278:25d:d473 with SMTP id
 586e51a60fabf-2948440d44emr12991862fac.1.1730737221463; Mon, 04 Nov 2024
 08:20:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101145241.10326-1-av2082000@gmail.com>
In-Reply-To: <20241101145241.10326-1-av2082000@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Nov 2024 17:20:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h_yu6YHcYRPSOg5yrrvWd-Mv4+xYtU+XouP2APoydm+w@mail.gmail.com>
Message-ID: <CAJZ5v0h_yu6YHcYRPSOg5yrrvWd-Mv4+xYtU+XouP2APoydm+w@mail.gmail.com>
Subject: Re: [PATCH] pm-graph: Refactor installation script
To: Amit Vadhavana <av2082000@gmail.com>, todd.e.brandt@linux.intel.com
Cc: skhan@linuxfoundation.org, ricardo@marliere.net, 
	linux-kernel-mentees@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 3:53=E2=80=AFPM Amit Vadhavana <av2082000@gmail.com>=
 wrote:
>
> Change installation script to ensure that the terminal returns to the
> original directory after the installation process completes.
>
> Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
> ---
>  tools/power/pm-graph/install_latest_from_github.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/power/pm-graph/install_latest_from_github.sh b/tools/p=
ower/pm-graph/install_latest_from_github.sh
> index eaa332399d36..aaf3515400ed 100755
> --- a/tools/power/pm-graph/install_latest_from_github.sh
> +++ b/tools/power/pm-graph/install_latest_from_github.sh
> @@ -4,6 +4,9 @@
>  # Script which clones and installs the latest pm-graph
>  # from http://github.com/intel/pm-graph.git
>
> +# Save the current directory
> +CURRENT_DIR=3D$(pwd)
> +
>  OUT=3D`mktemp -d 2>/dev/null`
>  if [ -z "$OUT" -o ! -e $OUT ]; then
>         echo "ERROR: mktemp failed to create folder"
> @@ -36,3 +39,6 @@ else
>         echo "INSTALL FAILED"
>  fi
>  cleanup
> +
> +# Return to the original directory
> +cd "$CURRENT_DIR"
> --

Todd, can you please let me know if this is OK?

