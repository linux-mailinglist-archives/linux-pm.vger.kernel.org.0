Return-Path: <linux-pm+bounces-18942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B47AE9EB9F2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 20:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FCC2832E2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 19:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BCB1BC9E2;
	Tue, 10 Dec 2024 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHN3Ajuf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2B23ED63;
	Tue, 10 Dec 2024 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858165; cv=none; b=YooUH1zen4Qp7ZS/eHVcf7++TPf0s8/CX8Wtqq/y+/60w9IsFGgSZ4K/doah9DJOOvM4pkFIGPE4k+/RAtTY/ttVXJjbgThohSu3/JT5YzjCYZdZ6YC2OkWkHmPyfkAFxsdNP08jEG6J+eRV2TtqUf+knUUrSbymXWbD+gW/aQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858165; c=relaxed/simple;
	bh=dTh0f4Eb1IUBh61NKD536k6i1e5gAg+9XbUosL5lnMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcXrMVVW/phu83FKVqiKsB0vNbAmpjHwiVyGLTepDQ0KpbpmfgL86E28bLkdKrHoGmF8LBOFBiJCEOLz2ldpn2AvuRzh1f6S4mOI+bMclgC8FrfYJd38K9tMnI+TuHr8SmfrWWlK702E1X8ORS+A/lj6BipmKjuaCEw4U84YqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHN3Ajuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080D5C4CEE1;
	Tue, 10 Dec 2024 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858165;
	bh=dTh0f4Eb1IUBh61NKD536k6i1e5gAg+9XbUosL5lnMc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PHN3AjufxqgxuYDFQVzayKedOQ/nBGx8WF0pdH/Nb6X1dDD1RxaKZGvbNBjIEXX7y
	 UDtAftM8QxYDXXAOlYSyVKVGACL7sMx+vTqrB0MNSjl6UWKe3epwi3rIRSbWJik8nx
	 qkHNe/LysWQTujUl+JD0OMLRdLsTUPaxjRVRoqGzHOHG+a1SbeeyaKXJ9lDnlAfzrR
	 rdLpZ3M1ea7t7N2A+dvjVm22ypUL7cWD2P7WIF8tSJgiULpdCdZdoM8SMj0e9RcN23
	 xdCl2eXvZwvpeHULduQqTcYWpSJZRATVuTE8fxyF8uzBkuCBAw6VytLG5Rqs21E+0g
	 1tRKYvrpA1a/A==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71dfaa28eeaso1316165a34.0;
        Tue, 10 Dec 2024 11:16:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVU4jN1Rj5p10XbwJxEubMq5blGhkxtuAJ5jFCp35SPq55nRgpIVGo2pq9fPQMrQBKC1ZP+CA00eGM=@vger.kernel.org, AJvYcCWVMqB2fhuyuwnhHyKs61XgOn6PSYJTKmHAN8WRBddbB7EsAra7xi0DRCGUtycHCmzEcokwOyAFldihFn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3spedWWv6Ii040DBFCXSIElJoqzl1imR06V1T91teMcvpgoFx
	kXntht/qDTHxv/yWpAPXFbHTA2mkkUNgDeo57pc3YOBdURSRrfmOke/QJS2ofOJ0cpK72HokU5w
	qa4SGT4aV4AEbeCCHJAWAhCnzKNY=
X-Google-Smtp-Source: AGHT+IF3PhBBh4zFLI4PBAPxw0IFKiyucLSi/qXLMPA15KDoalq7haRCQLVLvG1fcxMcZshIODUwYjbcI/OF9Rc+ql4=
X-Received: by 2002:a05:6830:6d14:b0:71e:4fc:6ef6 with SMTP id
 46e09a7af769-71e197e566fmr38214a34.12.1733858164326; Tue, 10 Dec 2024
 11:16:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203143729.478-1-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20241203143729.478-1-paul.barker.ct@bp.renesas.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 20:15:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j9JMPYGprbFdTX80d7ghE13ndcxR1ANcdLqj6yDU5nMg@mail.gmail.com>
Message-ID: <CAJZ5v0j9JMPYGprbFdTX80d7ghE13ndcxR1ANcdLqj6yDU5nMg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: PM: Clarify pm_runtime_resume_and_get
 return value
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Alan Stern <stern@rowland.harvard.edu>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:38=E2=80=AFPM Paul Barker
<paul.barker.ct@bp.renesas.com> wrote:
>
> Update the documentation to match the behaviour of the code.
>
> The function pm_runtime_resume_and_get() always returns 0 on success,
> even if __pm_runtime_resume() returns 1.
>
> Fixes: 2c412337cfe6 ("PM: runtime: Add documentation for pm_runtime_resum=
e_and_get()")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  Documentation/power/runtime_pm.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/run=
time_pm.rst
> index 53d1996460ab..a86f1173980a 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -347,7 +347,9 @@ drivers/base/power/runtime.c and include/linux/pm_run=
time.h:
>
>    `int pm_runtime_resume_and_get(struct device *dev);`
>      - run pm_runtime_resume(dev) and if successful, increment the device=
's
> -      usage counter; return the result of pm_runtime_resume
> +      usage counter; returns 0 on success (whether or not the device's r=
untime
> +      PM status was already 'active') or the error code from pm_runtime_=
resume
> +      on failure.
>
>    `int pm_request_idle(struct device *dev);`
>      - submit a request to execute the subsystem-level idle callback for =
the
> --

Applied (with some minor adjustments) as 6.13-rc material, thanks!

