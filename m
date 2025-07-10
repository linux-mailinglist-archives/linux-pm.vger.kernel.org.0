Return-Path: <linux-pm+bounces-30561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2276FB0012F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA405483BD
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 12:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDBC23BCFD;
	Thu, 10 Jul 2025 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8Hcmi77"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5066185E7F;
	Thu, 10 Jul 2025 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752149283; cv=none; b=vGeHrLVizWDqVPfVqV2xuB5b4RDzAraXf1B+ek/E25yUp4bOJD7Wnvc7kYT6VQA+1/SxkYFOraYEqK2Y3gqnaUHDJOkAU8Ryj4hL0WoicUC0AbXlgHv9DaCazIXFPfdIcRk9YJ79bxMbDdAC9suDDaCshZEaOW0QhKVGl2pXktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752149283; c=relaxed/simple;
	bh=EeZLTgM1M9H26Bkr97QKAVopRLeFG/Y8KKTjOZaykXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jy5xE2DwQ458HqrkW4nh9jDK3taDh5QC15yTiObbPYO1vzalTc87F1BLiswvX+JnkiV6ppm8VPdUoMUj9UlCp5fiYw0EcV87ecuOV/Lc8PZHO8S/tck6SJcDFOvBQmNvWXiYrnVcetIeTzR5ryeqXIt1pMLBnQX07GxG5XiOLyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8Hcmi77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7A4C4CEF6;
	Thu, 10 Jul 2025 12:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752149283;
	bh=EeZLTgM1M9H26Bkr97QKAVopRLeFG/Y8KKTjOZaykXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O8Hcmi77bkbWQzQfK44ZZPSgV80wX8OttH8fuLLCRo2UrduBrWwLTHgJOKrt6xAH2
	 L2UKgG5VGs9tKJG+24fXrr8DOCY9uzMl1QkuO6WSfoUx4bqtRsfcTgEavw8ywsWiHG
	 fNKvpFPjz5EW6wv6orQcNsp13jgbi50t/Mo6Jda8MrrQ9E6ADpnIuAnC9kMDflhtji
	 3YBn2rmk0EpqeiuPKxrIeOfZ4I//YmYz0KL/zzYl1Qfs0t/aTgpG1FNdnVlXxuUaeV
	 jz9QqRDHfDikQ3Aspg3yur6kASWyC+lLQ/Dbygj8Z9UKBhk9yjbTOpFtahebgkWO4G
	 Zuu3BJgThehLQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2ea58f008e9so791998fac.0;
        Thu, 10 Jul 2025 05:08:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2dFniob2ZbfXfz11DywW49N8JivwNJAVWPDmSIs/sFP8j/KvgXSTedOjprs/AmkfHuQ7ES+sIfOA=@vger.kernel.org, AJvYcCWbSZVZnEzZ8iN9bDboyYlBN39pJYPpDSf6bMzvC7eNHH1eUT7gsov7qN1cb7URiiWIXahVD95K7+E3Qy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3aEKDQ9IT+LFKYBqdSbAXVqwjArf/Sfp2d9cMb7dSMzsTA0I5
	RCPc4BO/9P2HvGGUfasxaypQDJXfJHv9bC1+3dVysorYCZea4/Y74lK5H4YbOqecqFhfPpyyl8m
	V3rWk6RgKi0dkh3UdZX+W0MChQGLth/M=
X-Google-Smtp-Source: AGHT+IFivLEtZ2TkdFYClomLUjsQNkfHcplGgy7HwWbXbinaM2yZEa6fTbW4IcgGRGPsoJLyd6LLJ4Esb6m5tVmx1pM=
X-Received: by 2002:a05:6871:bb04:b0:2ea:87d7:5a35 with SMTP id
 586e51a60fabf-2ff10aa34c6mr1602462fac.36.1752149282367; Thu, 10 Jul 2025
 05:08:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710102656.127654-1-ulf.hansson@linaro.org>
In-Reply-To: <20250710102656.127654-1-ulf.hansson@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Jul 2025 14:07:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jv0YXQPH_35FKfEoR7RbiNmWsffp+aRgymqEU03g3t6w@mail.gmail.com>
X-Gm-Features: Ac12FXx4OUZd333ad_pf-4U5yiVSi6P3X3K8lsutqL54bKnbXelWz5Xkzp6NV4Q
Message-ID: <CAJZ5v0jv0YXQPH_35FKfEoR7RbiNmWsffp+aRgymqEU03g3t6w@mail.gmail.com>
Subject: Re: [PATCH] Documentation: power: Remove info about non-existing QoS interfaces
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 12:27=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> cpu_latency_qos_add|remove_notifier() doesn't exist, hence let's drop the
> documentation of them.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  Documentation/power/pm_qos_interface.rst | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/pow=
er/pm_qos_interface.rst
> index 69b0fe3e2542..5019c79c7710 100644
> --- a/Documentation/power/pm_qos_interface.rst
> +++ b/Documentation/power/pm_qos_interface.rst
> @@ -52,13 +52,6 @@ int cpu_latency_qos_request_active(handle):
>    Returns if the request is still active, i.e. it has not been removed f=
rom the
>    CPU latency QoS list.
>
> -int cpu_latency_qos_add_notifier(notifier):
> -  Adds a notification callback function to the CPU latency QoS. The call=
back is
> -  called when the aggregated value for the CPU latency QoS is changed.
> -
> -int cpu_latency_qos_remove_notifier(notifier):
> -  Removes the notification callback function from the CPU latency QoS.
> -
>
>  From user space:
>
> --

Applied as 6.17 material, thanks!

