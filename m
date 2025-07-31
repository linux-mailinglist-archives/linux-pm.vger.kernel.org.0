Return-Path: <linux-pm+bounces-31710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34062B17864
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 23:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34E93BE806
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 21:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8C725F984;
	Thu, 31 Jul 2025 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkEPpbFA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BDB2907;
	Thu, 31 Jul 2025 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753998366; cv=none; b=tEYNFrp0MnjrJ0wUaCSoX0cklfJL2tvbrnuB6q4A9jpMKp9+A2MWmBuL+OsQlmZefOhVINX2QD6q+IM0gGJMUFi0UJNELl1QC0TnhjjKjUP438YL3qZqNNvs5q/Rgs6tVlCXGd1SCQ4PlIvu/gjx5aMHJCKfxCYiOmen43Kx+5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753998366; c=relaxed/simple;
	bh=EAi11GnM5NOpqtZGQP1+CvoqjqN0gawbLhNDx0WJK9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktWLiyskBy/EV9OjED/7oEs587ZAvIDGsuYiCHSFYUUEHxSDIn5b33EMOvKSW/VnDd/mKUsolMyf/K3OS1GvDNDpNnjQ9QabRBiPhYGuVSJYnNjTSvR8L4Quj/YMbQgQnIUwSKL0166k5YpeZWlZhKk6+tVMgSqmjJ8r/gy3RR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkEPpbFA; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-33216091f46so1914131fa.3;
        Thu, 31 Jul 2025 14:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753998363; x=1754603163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5O3S8YHjEKxf35I4HemjKP04DsSFKh+k5HBzaaWKAg=;
        b=PkEPpbFAnzme0GCIYc7NsFX2BJjflYaBTj+VN/wpl8d66/i9KQYA28eVI+xIO6WBdj
         KAsSXLMshqgYk5Y/bbHO8GqbTqeBMFeMrszZRvtjn1tJvFyjXGM4yyphygyAb8F9iran
         1QS84LrRnTZBvF7DUSAPbioWJM77gjY5qqatg0RUFMXwfrp44pTJnxUbbS8AfAcD1OTG
         vqoMHlIsS71OMCAWaRVh1ZTVuoPQ4qXgCB+f6LlPKOg5s7pwlNQzq5acMMnff2Rq2zzY
         3JiuB9Bp8YLjjkluXpHExYMqTD/7jegN3POZzqswhxJcAqT9df9tuUpYO1oW2sd9BAur
         9WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753998363; x=1754603163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5O3S8YHjEKxf35I4HemjKP04DsSFKh+k5HBzaaWKAg=;
        b=exgbEPu9TZPoFRz0P8k0/thsddWNazC1UePwoMLYX5Juro8DDcpO4KqtbasM6J89v7
         deHhRBMXqj3zVYqPVLsfxO+fD1XrOoV/+uTSeMg8V88DFS6qdi/0iXK5igsmGfl9eCjM
         cmC2EzAfqNoGusXOMjwAegxLPiEA3U3ESSetaRuv0jgaZiFLeZmOW6xBLCV2MQ0Gvg3L
         EMGVrhx4zDd/wyoH9U67PdmM/2c9/d6ZHWmvBol7nXj6OZuoY0y2ByePYBST+LA6s2lg
         IcosHumGpxAFwnSMF13ts+kQ+VxPhoJK8fqtPohN+aW3lKs5mIQGbySPiStvv7VhvTXW
         O/mA==
X-Forwarded-Encrypted: i=1; AJvYcCUe+zi9Mq0WRY2GjJXwP219T3yHgdlXijvejjRYCsJeQe8Md4/QbDZVZia6KU6Tz6eg6iuC9PazqUE=@vger.kernel.org, AJvYcCV8phsYteUbWwpNFeoBl2oE3ePhn/Z8Pi4Sga4stlBeD13aD0JbWmM7V4Tuj9KFRF4t8qs39iWrZ0Fr@vger.kernel.org, AJvYcCVgYCDJz4+gouLdgioNAh4FOc4OQ+KkFQQA7q1o969/K7pwjjKE6kHJD7SV6xDHm8GBO5ayrzSG0HJ0PTm9@vger.kernel.org, AJvYcCWXnmSjJ4yZunxJMWHSuka0f8vMJvZS1mN1p/n1lMnP64q88mNRDZDeDLeyZDbKhy6z82meAfh1w3DWyUA=@vger.kernel.org, AJvYcCWxFTmZtIpeCkeJXx45bKSEZEZd/ydUucTzQpItXS/A9pc4KCi6IyeV3JNI4y5m4qZvxHvoDwah0xf9@vger.kernel.org, AJvYcCXZ7XMAgAEoJAB0sfAYS0I77SJRTqZEbL9MpkYQeuU9ODjG0czuxsQpEPsR1EOAvQp+rkz7IJjlQVKv@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3IhTbNRDte6CqPxB/tl5Kl6HnuY2dpMYBi8mfGqKmweFUoa6
	cFL14/l4G5puXMikfFFLzYJ8N33If3NPr9I2XYDSvbMqTTVAfx4FIm674tGAWRYmd6DcxhPnv+B
	Bb150N70dP7SE2SfkGydqfx3iLolBdN4=
X-Gm-Gg: ASbGnct8M7100N1MRwp0VV8r6EVAo4OKfH1TzcWYLQ8Odm612iytQ2OKJsGbUEwGT6b
	uU007S1dSff4I2eSX641O0id7WbRRI5QejUZgmnrT/go5rqS3d4gFbShEssXh/Wy4E+jn8WOnGr
	jSgY7A+A2kJf3mxjr0SYZzkdbJ6HcbvOamVjXvYTlG1pSNKQlpMv06aPjMkzJELBJyBIoNqttpC
	720olQz3kH/yz0bOviYEU6rJ7Io
X-Google-Smtp-Source: AGHT+IE68ugzaerYztp5XTRePDBYmlv+5hk7MWpjNQloFG3z43Am06Y5klzWQnNYHpsFYONif7VtzQJSYSRafwvOkDU=
X-Received: by 2002:a05:651c:508:b0:32a:8591:6689 with SMTP id
 38308e7fff4ca-33224a725fbmr23822031fa.7.1753998362736; Thu, 31 Jul 2025
 14:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720-t210b01-v2-0-9cb209f1edfc@gmail.com>
In-Reply-To: <20250720-t210b01-v2-0-9cb209f1edfc@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 31 Jul 2025 16:45:51 -0500
X-Gm-Features: Ac12FXwmiSNEzxCmapZYKElVAjT1-RsIDF_NIv5WiOavZcEcHwc6rmCyCZHdaRw
Message-ID: <CALHNRZ992mowGjQY7U6hLRsPemaE6AikK-rDp+_CZkGruzP2Qw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] arm64: tegra: Add Tegra210B01 support
To: webgeek1234@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Nagarjuna Kristam <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Mathias Nyman <mathias.nyman@intel.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, 
	Prashant Gaikwad <pgaikwad@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-usb@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	Azkali Manad <a.ffcc7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 9:17=E2=80=AFPM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> Also known as Tegra X1+, the Tegra210B01 has higher CPU and GPU clocks
> than the original Tegra210.
>
> This series adds Tegra210B01 support to several drivers, as a slight
> extension to the existing Tegra210 support. Then adds a generic soc dtsi
> in the same vein as other tegra archs. And finally adds a barebones
> device dts to be used for dt checks. Further device support will be
> submitted in later series.
>
> Earlier internal revisions of this series included changes to the dfll
> driver to support Tegra210B01, but those did not work in testing, thus
> was dropped from the series. A bindings update to match is still in the
> series so the soc dtsi can declare a separate compatible from Tegra210,
> preventing the driver from attempting incorrect initialization on
> Tegra210B01.
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> Changes in v2:
> - Fix patch 1 subject
> - Add descriptive name in patch 8
> - Fix copy-paste error in patch 13, discovered by kernel ci
> - Link to v1: https://lore.kernel.org/r/20250714-t210b01-v1-0-e3f5f7de5dc=
e@gmail.com
>
> ---
> Aaron Kling (16):
>       dt-bindings: soc: tegra: pmc: Document Tegra210B01
>       dt-bindings: phy: tegra-xusb: Document Tegra210B01
>       dt-bindings: usb: tegra-xusb: Document Tegra210B01
>       dt-bindings: usb: tegra-xudc: Document Tegra210B01
>       dt-bindings: thermal: tegra: Document Tegra210B01
>       dt-bindings: clock: tegra: Document Tegra210B01
>       dt-bindings: clock: tegra124-dfll: Document Tegra210B01
>       dt-bindings: tegra: Document Shield TV 2019
>       phy: tegra: xusb: Add Tegra201B01 Support
>       usb: xhci: tegra: Add Tegra210B01 support
>       usb: gadget: tegra-xudc: Add Tegra210B01 Support
>       thermal: tegra: Add Tegra210B01 Support
>       clk: tegra: Add Tegra210B01 support
>       arm64: tegra: Add BPMP node for Tegra210
>       arm64: tegra: Add Tegra210B01 support
>       arm64: tegra: Add support for NVIDIA Shield TV Pro 2019
>
> Azkali Manad (1):
>       soc/tegra: pmc: Add Tegra210B01 support
>
>  Documentation/devicetree/bindings/arm/tegra.yaml   |    6 +
>  .../bindings/clock/nvidia,tegra124-dfll.txt        |    1 +
>  .../bindings/clock/nvidia,tegra20-car.yaml         |    1 +
>  .../bindings/phy/nvidia,tegra210-xusb-padctl.yaml  |    4 +-
>  .../bindings/soc/tegra/nvidia,tegra20-pmc.yaml     |    5 +-
>  .../bindings/thermal/nvidia,tegra124-soctherm.yaml |    2 +
>  .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml |    2 +
>  .../bindings/usb/nvidia,tegra210-xusb.yaml         |    4 +-
>  arch/arm64/boot/dts/nvidia/Makefile                |    1 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   11 +
>  .../boot/dts/nvidia/tegra210b01-p2894-0050-a08.dts |   10 +
>  arch/arm64/boot/dts/nvidia/tegra210b01-p2894.dtsi  |   70 +
>  arch/arm64/boot/dts/nvidia/tegra210b01.dtsi        |   64 +
>  drivers/clk/tegra/Makefile                         |    1 +
>  drivers/clk/tegra/clk-tegra-periph.c               |    3 +
>  drivers/clk/tegra/clk-tegra210b01.c                | 3758 ++++++++++++++=
++++++
>  drivers/clk/tegra/clk-utils.c                      |    5 +-
>  drivers/clk/tegra/clk.c                            |   19 +-
>  drivers/clk/tegra/clk.h                            |    6 +
>  drivers/phy/tegra/xusb-tegra210.c                  |   41 +
>  drivers/phy/tegra/xusb.c                           |    4 +
>  drivers/phy/tegra/xusb.h                           |    1 +
>  drivers/soc/tegra/pmc.c                            |  117 +
>  drivers/thermal/tegra/soctherm.c                   |    4 +
>  drivers/thermal/tegra/soctherm.h                   |    1 +
>  drivers/thermal/tegra/tegra210-soctherm.c          |   78 +
>  drivers/usb/gadget/udc/tegra-xudc.c                |   20 +
>  drivers/usb/host/xhci-tegra.c                      |   25 +
>  include/dt-bindings/clock/tegra210-car.h           |    5 +-
>  29 files changed, 4262 insertions(+), 7 deletions(-)
> ---
> base-commit: 347e9f5043c89695b01e66b3ed111755afcf1911
> change-id: 20250509-t210b01-c154ca0f8994
>
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>
>
>

Reminder about this series.

Aaron

