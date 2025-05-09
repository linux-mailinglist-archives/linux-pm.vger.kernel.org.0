Return-Path: <linux-pm+bounces-26948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD3DAB1573
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF81B7BEA12
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B09229189C;
	Fri,  9 May 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iem9mMlG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F18F2900AE;
	Fri,  9 May 2025 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798184; cv=none; b=GCtx49FUpWVNRRhNgaaqZ6lh7QVrLgOYBiV2NAMKKqdyCZ+173goXLfUM/G1UEnaQaJEpWGYTeTpw0OxWSJ3nqnSBi9JnAHUhK/Ty9n/Zpu6fU/GkoFsbX1q8haHifCvmmm2o/KzU0T8PNl83JRHLmkYdGzMITnORBsXFMpML/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798184; c=relaxed/simple;
	bh=TQd5Vp1kLt4MGHAQMKGIWYORUesqGeQtaKXFyKSJ5LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ln0N+oNKxBu59+wc/lUvWCdxJItIzDoOo3p7l/X7P5/ROlPNd09khoSXf+QVlRtvXM4K++jLir0wtNIzt73BPYKl+ddqyWRFQHvq75y6dNmFmsA6xhmt3wUZg+pmCIFNmkkwqQ5fwqOu24kr+7IfjJJNMDBRcp2WEO2yu0S+NFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iem9mMlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A998BC4AF0B;
	Fri,  9 May 2025 13:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746798183;
	bh=TQd5Vp1kLt4MGHAQMKGIWYORUesqGeQtaKXFyKSJ5LQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iem9mMlG2xUFvWPyWbMeGri9MKEZjolgqzHjYaF2+40q5zU3OaZJkcp61ptRp2bnz
	 eYqRsCADEVBtr8QFJsL1ZvRc5fdAW2tzJQA1vOjBHpJ0AJ6m0Kyw6B0qOv10d4+xG+
	 y7qlla6gG8RiwzgTWNZaUps7IQPm64bhPvF4FRW5f010pl6vGa3WhcDA1CXm4PC1Rb
	 +hlznebl2hnHNbhm0yZhEpt/R8QARnFfpX82GivA9tD3n9ZvBTeZ1R6yyhuaJBeUQf
	 awxLUHOPMR8ENmPlAItyIdSqukhja0oiUI7e/7XTocbmjVs/dP78F/Y/ITQ5Qmo35V
	 mUd3T8cxupLbQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2c76a1b574cso820686fac.2;
        Fri, 09 May 2025 06:43:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU88P3VcyXvZQvZpCmhTwCz7q/uyvRkprjP+GQFOSr+v198tsWUK5jxE79UJc9h891UM/Dw40RxtpM=@vger.kernel.org, AJvYcCV+qLNPepDBsF/yQOwljLh92r1G26eJUmySDE80YoM4OjcICKR4pJ69eV2Qfq55N7uQGSWJGY9/D+oZ5ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZI/OFXTi8kULBjBiyfbckkjvgVC20/IhBkq07xFYDduy2AHG
	n/bhgNafN1yxGl0ZvF/Ph5lONpPl0UipApWDT3LRgzU5xQWBvw/yeJ6moGe1Y9UJKGnNVYyeNCV
	j33rjQ5MGajYdp15PTwUXGOC7/Dc=
X-Google-Smtp-Source: AGHT+IFp2vFzobKkZvJWbgDXQd3AMuJzFnrgvSIB605nw5ZNTJ6Clt6kYHT7HCnP+Yopo060EnfUOMyRdq5LYNj+obQ=
X-Received: by 2002:a05:6870:2104:b0:2d4:ef88:97c3 with SMTP id
 586e51a60fabf-2dba44e48ecmr2062868fac.27.1746798182998; Fri, 09 May 2025
 06:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-add_power_attrs-v1-1-10bc3c73c320@quicinc.com>
In-Reply-To: <20250505-add_power_attrs-v1-1-10bc3c73c320@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 15:42:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0he_7jmpafGcSUDhtXcwSBi1RSP=AQYr9QBr4UNzdw+Gw@mail.gmail.com>
X-Gm-Features: ATxdqUHbIr1bmvPzJAWIL6c0rB-Zxzj7NF4fl8Pnfo7tR6hvo2d1UhsfFk2Ity8
Message-ID: <CAJZ5v0he_7jmpafGcSUDhtXcwSBi1RSP=AQYr9QBr4UNzdw+Gw@mail.gmail.com>
Subject: Re: [PATCH] PM: wakeup: Add missing wakeup source attribute relax_count
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 12:17=E2=80=AFPM Zijun Hu <zijun_hu@icloud.com> wrot=
e:
>
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> There is wakeup source attribute 'active_count', but its counterpart
> attribute 'relax_count' is missing.
>
> Add missing 'relax_count' for integrality.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/power/wakeup_stats.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeu=
p_stats.c
> index 6732ed2869f9f38a272faab0044b6eb3edc051f2..3ffd427248e8eebae3c05b516=
5bd4200a0668339 100644
> --- a/drivers/base/power/wakeup_stats.c
> +++ b/drivers/base/power/wakeup_stats.c
> @@ -34,6 +34,7 @@ wakeup_attr(active_count);
>  wakeup_attr(event_count);
>  wakeup_attr(wakeup_count);
>  wakeup_attr(expire_count);
> +wakeup_attr(relax_count);
>
>  static ssize_t active_time_ms_show(struct device *dev,
>                                    struct device_attribute *attr, char *b=
uf)
> @@ -119,6 +120,7 @@ static struct attribute *wakeup_source_attrs[] =3D {
>         &dev_attr_event_count.attr,
>         &dev_attr_wakeup_count.attr,
>         &dev_attr_expire_count.attr,
> +       &dev_attr_relax_count.attr,
>         &dev_attr_active_time_ms.attr,
>         &dev_attr_total_time_ms.attr,
>         &dev_attr_max_time_ms.attr,
>
> ---

Applied as 6.16 material, thanks!

