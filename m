Return-Path: <linux-pm+bounces-31666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CBFB16CCC
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 09:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B078B18C7358
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 07:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE91728D8DF;
	Thu, 31 Jul 2025 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2j0PoK/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E8C19597F;
	Thu, 31 Jul 2025 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947223; cv=none; b=AaDazajyZapEY3Zq5bYG7wtfDnl7tIh8SFrKBSdZT3QSH7nfdZwvDYnAgK5Gum5IY9ktf2fvTimJXj8usdJdT861voc8LaUxjfAWArPct1EAcz/upiTwJ1vJJU5YU1m+dpqVKJavOiqHWpk8I6tK+z+Oj+Ma6AWDyVomCR1LuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947223; c=relaxed/simple;
	bh=8gd1XJu/hU6zK55BIaEKAOX9pr+PQogrt/+iL+WtPlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hj33EBAoDh1a7VzlmmsoZab3E+6GtSJWFStQs9qw/gqwz0pw/slPsuMA5Q9G2E50ykno0n51jSdW2begevgubn3re1jUHCnqDOe0hrAq5H4A1xgSe0kN5ZV9A+8Na91/aDk4KzrPPY/eGLjZVAH68y77krZ2Wexp3pOqSipX1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2j0PoK/; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab3802455eso7911001cf.2;
        Thu, 31 Jul 2025 00:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753947221; x=1754552021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOX9X8brnwUNsz5uO4Te0xlPw30giJyAMqsCiquXPp4=;
        b=Z2j0PoK/WXwwMNZuFYWGc558gF3SkrqH3VCTJmVDPRJLCUzcHVooJTONi/Dsmjx5LT
         tnd7c+8DNogXJpZ5wIIIZLDebpawxGqco5S+4qvhNxh9tch/KvXdTXpPsvUTsxw54jCm
         leh02h3tkCsbgxbANvFH/zKYBflBA/svAdxabB7uXpXwmhiBVCcnbxuIUJsCyZHjfD5K
         pxwfOkhhKROGOrhQZjVrxDLve/Iknoy07AHRiUng5nkY9Dxd2PtRQw3rEBHreGwZrKlv
         mPa7VzGpM4bXY7n1H99KsKXtnBQDlECcsWLr8gRLb770EHHGbJNJheFxr6f3TtuBA+wV
         Np2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753947221; x=1754552021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOX9X8brnwUNsz5uO4Te0xlPw30giJyAMqsCiquXPp4=;
        b=VSW7hM8wFPfUhFThlXw5t0hYL8XUKrjn20epF69NwKzboNdi2eiWcZWU8GffS0Es7g
         WUvtQnJT6SrUZ8tZ29g8NMKdXTazBUaaVqhtJ6FBWQAGLop9ltEXvOg+YTFZJBITY2Ry
         iKr5i4wwr2Lcmt/2QGbbRFrszRY/z+IAHVgQB0Izp6plSoiD44zYGBND7prqpXBTCN+K
         ncMvAAbeBS9v1H8TsuKxSI4zvDS5LXVmKj9Zel3Ot7OgIa2Z5xNNf/kSZlRXzxzXAvtx
         EvZqxKz1P03rd9ZUjCEznvN8KqrTUrFJTUJTap4LxcJ6BqX5kOnYEd/kVvN27nuYjsHP
         DKYA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Fyo3mrWBePFCmSLeneusqX4vKTy1l1XeHKFkX8Rjn31dLahJJC3kLbONXqiYlb4DZslXeSIHqWE4LJR7@vger.kernel.org, AJvYcCWmG3CnrK3r+ZKXjbSPGsyMO7vNZvJqu+V5HEH8mBr81RLmtrmqfI4rgS0KOWoqeIEUFCl74uk1//s=@vger.kernel.org, AJvYcCX6D7pEOQ7gHxjfpHqEQc/Y0l8ZoE0I3gyS3R90xEONU3CLtOVx3OiYkKGwQswKy9ul8pYWYqfunfse@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3W9+2fc8aamDBqQDxMn0FhEAmlspxuLx1sLr/NxKooC1X+eJ
	LtL6kv+wcpf910fEHPPfmJkP8+82SOUBWH6/PCroGZzuMgeh+cuJL9O7xafMbeFJv0DU9f2mguY
	nqyQuJACmLP37jwu/Lg0OUlHgJeQ5/FQ=
X-Gm-Gg: ASbGncs2VGv/DDm/DcA+wfvLleVSWVtkEdtXt5zLHXuU2H2H9ra40URFABMcuEghPzJ
	lCl9bnlqTDoYpmBo+NoExbfuqXXHpyf9n8IU9S0SZNeMy/FYupYwXb8SGhOQqEF/Zt42oAifbTR
	kLC5DHEB+y6wxFwDKcOxB9HuxTBFfE3nNVGvFqoiqIsRZTPvK0BHSbMmKuT3LefyEwpfFjo3Nk9
	MmnMavPl4iz9RP4S9ffl7mFw5BPetmeYRvhcD3Z
X-Google-Smtp-Source: AGHT+IH1uwkUGAwbjx/9dKqcwJTQI9b2LQO1Th3mXrOlkX6OvkMWjy54q1bCvJ9oudoi0B/QbEA71tvh/WvbZgihO6E=
X-Received: by 2002:ac8:5913:0:b0:4ae:cc75:4704 with SMTP id
 d75a77b69052e-4aedbc6b2abmr108326681cf.59.1753947221032; Thu, 31 Jul 2025
 00:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
 <aHgHxR1_Gzu8Dwbm@mai.linaro.org> <4178173.5fSG56mABF@diego> <14c91ee4-3a09-4ec9-966f-0d563d7c8966@linaro.org>
In-Reply-To: <14c91ee4-3a09-4ec9-966f-0d563d7c8966@linaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 31 Jul 2025 11:33:32 +0400
X-Gm-Features: Ac12FXyBhKCe01359PD8yUXtXOTB-iOa83dWxetYoDpIa3sijPk9zpEZPKHbrQs
Message-ID: <CABjd4YzJeNf0Qq9qFeMcoYQV5erZGUeOpmJynRW88AeL9dJNhQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] RK3576 thermal sensor support, including OTP trim adjustments
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonas Karlman <jonas@kwiboo.se>, Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Ye Zhang <ye.zhang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiko!

On Thu, Jul 17, 2025 at 12:20=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 7/17/25 09:21, Heiko St=C3=BCbner wrote:
> > Hi Daniel,
> >
> > Am Mittwoch, 16. Juli 2025, 22:12:53 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Daniel Lezcano:
> >> On Tue, Jun 10, 2025 at 02:32:36PM +0200, Nicolas Frattaroli wrote:
> >>> This series adds support for the RK3576's thermal sensor.
> >>>
> >>> The sensor has six channels, providing measurements for the package
> >>> temperature, the temperature of the big cores, the temperature of the
> >>> little cores, and the GPU, NPU and DDR controller.
> >>>
> >>> In addition to adding support for the sensor itself, the series also
> >>> adds support for reading thermal trim values out of the device tree.
> >>> Most of this functionality is not specific to this SoC, but needed to=
 be
> >>> implemented to make the sensors a little more accurate in order to
> >>> investigate whether the TRM swapped GPU and DDR or downstream swapped
> >>> GPU and DDR in terms of channel IDs, as downstream disagrees with wha=
t's
> >>> in the TRM, and the difference is so small and hard to pin down with
> >>> testing that the constant offset between the two sensors was a little
> >>> annoying for me to deal with.
> >>>
> >>> I ended up going with the channel assignment the TRM lists, as I see =
the
> >>> DDR sensor get a larger deviation from baseline temperatures during m=
emory
> >>> stress tests (stress-ng --memrate 8 --memrate-flush) than what the TR=
M
> >>> claims is the GPU sensor but downstream claims is the DDR sensor. Inp=
ut
> >>> from Rockchip engineers on whether the TRM is right or wrong welcome.
> >>>
> >>> The trim functionality is only used by RK3576 at the moment. Code to
> >>> handle other SoCs can rely on the shared otp reading and perhaps even
> >>> the IP revision specific function, but may need its own IP revision
> >>> specific functions added as well. Absent trim functionality in other
> >>> SoCs should not interfere with the modified common code paths.
> >>>
> >>> Patch 1 is a cleanup patch for the rockchip thermal driver, where a
> >>> function was confusingly named.
> >>>
> >>> Patch 2 adds the RK3576 compatible to the bindings.
> >>>
> >>> Patch 3 adds support for this SoC's thermal chip to the driver. It is=
 a
> >>> port of the downstream commit adding support for this.
> >>>
> >>> Patch 4 adds some documentation for imminent additional functionality=
 to
> >>> the binding, namely the trim value stuff.
> >>>
> >>> Patch 5 adds support for reading these OTP values in the
> >>> rockchip_thermal driver, and makes use of them. The code is mostly ne=
w
> >>> upstream code written by me, using downstream code as reference.
> >>
> >> Replaced previously applied version V5 with this V6 patches 1-5
> >
> > are these commits available somewhere?
> >
> > Because git.kernel.org reports that
> >    https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> > has not seen activity in a while?
> >
>
> I just pushed the bleeding-edge branch

Just wondering if patches 6-7 from this series are on your radar?
Driver changes are in -next AFAICT, but not DTS. Can't wait to get the
temperature monitoring working on RK3576 without out-of-tree patches
;-)

Thanks a lot,
Alexey

