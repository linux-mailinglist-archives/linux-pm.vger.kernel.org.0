Return-Path: <linux-pm+bounces-33328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E553BB3AAE9
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 21:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1691B27C9A
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C76925D1E9;
	Thu, 28 Aug 2025 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6H3WEwr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D02356B9;
	Thu, 28 Aug 2025 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756409666; cv=none; b=q9VbJ51LDZaNroKvjbDKB3fYpWJUdeMW99A2oYmyxUme7ya6qVK/JLQQQaCm4A2/KonqGYZL9BP6vd49JNJpxemK8Rdx0XJTQbZV4KQc/DEzv7VRt6KUx1Nm5WRPf2V9MIjCI+meQVrTpKPufHVOK9RmZaaJfxmSiSXF4BS1sGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756409666; c=relaxed/simple;
	bh=W2KYNoXmBvpxs9p5dj2MfY1PazlxzEh7ETuq21IVPKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afirtWjZ3lf6eU7mE5S+Ig+ROwwTmDYdrg+B9ys/3lcBlOAkJkhBR4XiZ4bthaqzXgjDuDvj+xdyWPVJmeXuEGGnFv03o0gpgYnukigajonFf6vJWUc2lecfaQokJ0jbJdY+bJ1r6H6+SLrXV7rMFhnFgLzoYTkHwerxrOHSnt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6H3WEwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE47FC4CEEB;
	Thu, 28 Aug 2025 19:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756409665;
	bh=W2KYNoXmBvpxs9p5dj2MfY1PazlxzEh7ETuq21IVPKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q6H3WEwr78OcpzrWxMyF8+vUquTFMWhTfEW2mau9s6J5OPZM9HdqhmWim6l5gyUyx
	 Y//kL//kMGTGFA22FlYzjMj3Ev06LXf+SpnLxfBnegMoTHDD9obJfHjb5pi5IxTDMN
	 O2onNvS25mx0J3OPjkSaEQ879avWOuJj7c7Qka9aCFjDssa/ZLxVQMClMw2p+kWv9l
	 pKJHt1XzzYJctK90rRlgzegWZpeSGRQGhIDcqxc3u31z2cqvho3uWP6KdHIRXmcPbK
	 IQrfvSc4InXbDyekX7VAiy+F1jipb+1TUelicMDn5o6WYu076AirdlYaizdKIOPu92
	 8VRqP7yBcia6Q==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-30cce8ec298so988344fac.1;
        Thu, 28 Aug 2025 12:34:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvLB+d3MJbISKhox+99lEfdDqOBnfU8WeByQEgv1gDMWO1Sc6w4bQeWrfgO5WSb7giVnlZB4fOKpJk35Q=@vger.kernel.org, AJvYcCXM4OHcxOjGBJyqQmi97rFBISd4kK3YFmoJXZlGZkH69EkKNi0eSVUiip01LAaB6iYFSfcfAQCjj/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YypKC8wRB2+SEMe+X7vvUt/uZWiXBP09BkiYnzsmFhNdUJsjCOs
	2JvMLgwHwTA+Icr1PUo1nGHOZe5tbOzOwaDVxJjR3aMfBXdF5K/B+8XM/4oEsbgU9zxc+oAyTub
	tQgHjQ16jfA8St6DszEPM2DB3QuwNZFg=
X-Google-Smtp-Source: AGHT+IFFk7du/mqCUt6LHDFKUbHDXS0Qz4YhyEt7bFz6DD4Ywx3LTWIjQqFq0/TVE8NGrMrcomieKcB2+luVQa5lApY=
X-Received: by 2002:a05:6871:cc87:b0:315:7456:1b2a with SMTP id
 586e51a60fabf-31574668393mr2965175fac.24.1756409665244; Thu, 28 Aug 2025
 12:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828192328.929742-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250828192328.929742-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Aug 2025 21:34:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hcwgmddSN=0eM+PxTNuE1dm=iRLBbYWF7PFcB8H2ztDA@mail.gmail.com>
X-Gm-Features: Ac12FXySfrvBFXJug8oQebP776jG0EUIHYWKh151xeW-gk4Kvv0TapmExBHXOCY
Message-ID: <CAJZ5v0hcwgmddSN=0eM+PxTNuE1dm=iRLBbYWF7PFcB8H2ztDA@mail.gmail.com>
Subject: Re: [PATCH] selftests/thermel/intel/workload_hint: Mask unsupported types
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 9:23=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The workload hint may contain some other hints which are not defined.
> So mask out unsupported types. Currently only lower 4 bits of workload
> type hints are defined.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../selftests/thermal/intel/workload_hint/workload_hint_test.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/thermal/intel/workload_hint/workload=
_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint/workload=
_hint_test.c
> index ba58589a1145..3ee018bca899 100644
> --- a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_t=
est.c
> +++ b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_t=
est.c
> @@ -133,6 +133,7 @@ int main(int argc, char **argv)
>                 } else if (ret =3D=3D 0) {
>                         printf("Poll Timeout\n");
>                 } else {
> +

Is this change intentional?  Looks like it is not needed.

>                         if ((lseek(fd, 0L, SEEK_SET)) < 0) {
>                                 fprintf(stderr, "Failed to set pointer to=
 beginning\n");
>                                 exit(1);
> @@ -144,6 +145,8 @@ int main(int argc, char **argv)
>                         ret =3D sscanf(index_str, "%d", &index);
>                         if (ret < 0)
>                                 break;
> +
> +                       index &=3D 0x0f;
>                         if (index > WORKLOAD_TYPE_MAX_INDEX)
>                                 printf("Invalid workload type index\n");
>                         else
> --
> 2.50.1
>

