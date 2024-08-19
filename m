Return-Path: <linux-pm+bounces-12428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0825956C27
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 15:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7181F1F239D6
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 13:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35A116CD2B;
	Mon, 19 Aug 2024 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbVpJ6hg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72491B5AA;
	Mon, 19 Aug 2024 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074320; cv=none; b=fvrmKoz0ipAevGuMACnddLP8a+v3XCekxxYzmA/WaqGDh3ypC5lsrZYJ4xpiitmdhS6yovtQfyOZ32j7HuNS/gGzgF95I8FlA4DV6XchUxEjngo3iKRiA6mKMmyKkHR0lB6MwYB4MCPsNhMNK3g2i+8n930fVNTB1Hpy3R2n0Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074320; c=relaxed/simple;
	bh=wDk+/MxwCfdTBOwhmCaGnEGbWArWtSM8qyn0KWOxD70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNjcnO1cUuSzRFHwnPLyczsduVH2r2KTjH2DTuuSxmMCx4RUwvFMEllAX3zXBKgvGBj6TazTqIzylSsFkbdnzqlphnDL2QuhC6T3gS0WobNpuAjM8fAg8Iir8Z9jVHoZkSlbRabAJpHVFozd86n22ZTWBneZx7AmBBCD+AcH9b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbVpJ6hg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDFFC32782;
	Mon, 19 Aug 2024 13:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724074320;
	bh=wDk+/MxwCfdTBOwhmCaGnEGbWArWtSM8qyn0KWOxD70=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RbVpJ6hgUZvYZNR72yTDU4wwyVIldcEJbKTr1+WWcdSeRTwmgkfEoHQSOmDm4D7CM
	 sDo2ttHO2wws8WTUrZMhcm0/d052Kf6id+6eJDCF7FwuGgy7zUNpEpn7vJwU/5sSs3
	 1YY1GPtWeb+XjuxHOAkS/tpaKOL75ni/G5LMUawlGUvtXwYjaw9QosgrIMhHs4XeZI
	 no8vDJoF0A04uuHkojoYJYLZh8BzaT9rAba1YM0WC+UcZ4AO4LOwcye1eh9/3M45lv
	 NfNxY3XoljaqeDGdgt0rnTa1x4anBLJrfocIn8F9sCwed9Z6D/pESgOko7RsH49N+F
	 GHiCEwP40/VVA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2635abdc742so541697fac.2;
        Mon, 19 Aug 2024 06:32:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUH2GxeMPt3u96zKBssqT6HcqpsixTGXJPc3T2L2XJaB5rgWuY4yzfZd2X1CS9fdQsYIEhoQ52VwcUfcSo=@vger.kernel.org, AJvYcCUk6SVb0Y3MwTDP3CHgnF+uD0pHd5ojQdDm5AQZ+W05BYvv4d+B0DqDMlSzM3KLIuuapFb4l01t@vger.kernel.org, AJvYcCXi6FqWG99ovXhrfrH0D3zgUUiFWF9S0Pr6zwBpr2SAh7VbroSVevlomAQVC9vBD6A3ZlhXjGBUMFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS6M5KKcruwg+XW9mTtaIf0++U/FfmO5hoW1J0FcYu5ya49Us5
	L5hpq/rwAtSOEA8RlIVr8of90P2otI8CAwS7+sf+wThYRZ9EIe0HfNb4xNEh/V1r5o5gWh3XQ7t
	w8+noMrPhfwTf6s8VjxhtP5L7BhM=
X-Google-Smtp-Source: AGHT+IGHU4saW8k1R3qAWY8cuDgDmZOFsXDxPE0gh+Gvi3OXMn9y0Eg5XWtiQud2blaw7j7Li+YPopdeKgKqzx88RJg=
X-Received: by 2002:a05:6870:71d3:b0:260:df6a:28ca with SMTP id
 586e51a60fabf-2701c50f784mr5673784fac.5.1724074319541; Mon, 19 Aug 2024
 06:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
 <f3d2c104-360a-4da0-8d77-59af89ebda2b@linaro.org> <CAJZ5v0hiR0sqgfR1WiuT=tXx3XRWgAE-j3biEMMaV5FjiSZwbw@mail.gmail.com>
 <9e6d817f-1fcf-4d31-b0c5-d68753e1f949@linaro.org>
In-Reply-To: <9e6d817f-1fcf-4d31-b0c5-d68753e1f949@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Aug 2024 15:31:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jU4xOwgA8neFVMijV+T9=oiOBoEjD9viaCq=g51wFGkQ@mail.gmail.com>
Message-ID: <CAJZ5v0jU4xOwgA8neFVMijV+T9=oiOBoEjD9viaCq=g51wFGkQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal: of: Fix OF node leak in thermal_of_trips_init()
 error path
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 3:22=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 19/08/2024 15:20, Rafael J. Wysocki wrote:
> > On Mon, Aug 19, 2024 at 12:12=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 14/08/2024 21:58, Krzysztof Kozlowski wrote:
> >>> Terminating for_each_child_of_node() loop requires dropping OF node
> >>> reference, so bailing out after thermal_of_populate_trip() error miss=
es
> >>> this.  Solve the OF node reference leak with scoped
> >>> for_each_child_of_node_scoped().
> >>>
> >>> Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
> >>> Cc: <stable@vger.kernel.org>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> ---
> >>
> >> Applied, thanks for the fixes
> >
> > Is there a place from which I can pull these?
> >
> > It would be good to include them into 6.11 as they are -stable material=
.
> >
> > Alternatively, I can pick them up from the list.
>
> I'll send a PR for fixes only. Let me double check if there are other
> fixes to go along with those

Sure, thanks!

