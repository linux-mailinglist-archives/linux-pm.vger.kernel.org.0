Return-Path: <linux-pm+bounces-8509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AF48D792C
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 01:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358A0281976
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 23:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F007E0F0;
	Sun,  2 Jun 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howett-net.20230601.gappssmtp.com header.i=@howett-net.20230601.gappssmtp.com header.b="xKOkSB7o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F997D08D
	for <linux-pm@vger.kernel.org>; Sun,  2 Jun 2024 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717371632; cv=none; b=gXar0jGbBnav5B9a6SGSXFsnzhWA4xKWI919cMXvTvktmZT336OsPpXSwWitH0N20XhInh9CeiatPrvodPsrLklrU4x8yINVwLZru6dK3PHqT1RwykztOXd925Vl2TC69htdP32K2FuOUJnl+47GR8Qw3GSD0isCjrqh4b6eCac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717371632; c=relaxed/simple;
	bh=EHRepVezwMfVoPL6Mw07oqATYl7aotVo1rQYOCPwKrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txBj1+hRVCe+abUJ2Vv9UA4+gU6yx6YRex0DWGOINMeTyujjt7+AdhVPgUHMl6QMOQaFx18eVtlpRWarNkpDcGeFMNPq0CfGbC0rmfXee50xGy5cGp+B1vUomGGgYwD7VBEknoe5aHUcecLc03syNB8SuDlopOqOqJi7D3Veo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net; spf=none smtp.mailfrom=howett.net; dkim=pass (2048-bit key) header.d=howett-net.20230601.gappssmtp.com header.i=@howett-net.20230601.gappssmtp.com header.b=xKOkSB7o; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=howett.net
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfa72c9d426so2493900276.3
        for <linux-pm@vger.kernel.org>; Sun, 02 Jun 2024 16:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett-net.20230601.gappssmtp.com; s=20230601; t=1717371630; x=1717976430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kB05bl6nBL/GV64EJffHVt909Yg9H0aq3pdV1Zuvdyk=;
        b=xKOkSB7oh/e/9KgGaEufvfOXMLfzwsjPWwaDW7q6CrnFWn9YUtQgumz3p/1g5pGLaK
         TAeXTeZE3MK2lo/1FWXQRUJ+6Pck2SglvhvTKwmozzSdKMmUXcJ3ZLu3MaYKg9gUjQ/j
         b/KvX0sTxa8pdyIpqyPwsrOlkIS30H7OJAb/ruHu9IIwmwFzE7sgcDCX7Ma2C4VgxME1
         yaLoz1liugftYl9yBPGv02gYOuA/DnudTwIvfsFlNxFrOf+IdUtoepnZaD8oVgDQjhmD
         j4Ei2pHB/zge1KsDjAKV9vtCCsSjTXCjDRUHmD7VLO7C6YzCA6hjjiHumdkVrJwg4ebr
         TdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717371630; x=1717976430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kB05bl6nBL/GV64EJffHVt909Yg9H0aq3pdV1Zuvdyk=;
        b=wuhQJQDbnZ8PglPLjyGv2NqX/cy0iwnmXLMxmwX9UaepyuEkfJUiTWrk3muldKDsnu
         S6p5Y6shITwf+kvebt3ftJO2K9WgoRvM7u3R0qOn5V4rYTzGvhGvs889zc2En34rinpU
         2Dx/LV2oISw3TQNQ9elKK6K0VgtrosNisfztAjyCgUJ2fGaKjNg6neFlLH1jao4lFmSU
         CmtgzHSpzTRgDYzFgMISJiW/tdYebmYh3WDB2qTW4YGsXs4ZmHnbR6RImK8++TQnK/VM
         TVNG0NajlfUAq3jpxFpI6Dj1467cuOFgZjDu0d/rC3DYCpVwsvi3UFejWwmlxs/oQDfX
         8Jdw==
X-Forwarded-Encrypted: i=1; AJvYcCXNLMp+VDHjXJJrOsgHahCFGG9Slo4+5I7/ZZFb9Y8PjanxRibgOCZCKtZBZRvD1i1v8ci15+6mfRdmmY5abh+gV/2rpQ2/ndQ=
X-Gm-Message-State: AOJu0YyxB9HolzYO5ga8A/tq3MggGL/sFprfTXfKnX3M2jCwfs6RDmhR
	qONw7EzdzlmoRrK2Z1jm7f2JVErk0mOv123YV5o83qdzlxEz+ErcS9B38L2a9afsxerRLyrGXPJ
	ysu7/FXvw+1Gn3PUEMRtKuXu0BqR1fi4O0/b9
X-Google-Smtp-Source: AGHT+IFdFbO/JdCzTUHIjfXmLV6Vnd6UNkZHgxfb8QNHaFRuKatU9hk38ie3OnpmMurJr4aQmZNPxtlWwl7vAEgGwFw=
X-Received: by 2002:a25:d890:0:b0:dfa:5a2f:9e56 with SMTP id
 3f1490d57ef6-dfa73bed87emr6826339276.6.1717371629757; Sun, 02 Jun 2024
 16:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net>
In-Reply-To: <20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net>
From: Dustin Howett <dustin@howett.net>
Date: Sun, 2 Jun 2024 18:40:18 -0500
Message-ID: <CA+BfgNJByawxkZukaCXYcmOo_K9aQ0W1x8B6Y+Hyg_fZaJ4axw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ChromeOS Embedded Controller charge control driver
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Stephen Horvath <s.horvath@outlook.com.au>, Rajas Paranjpe <paranjperajas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 3:05=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> Add a power supply driver that supports charge thresholds and behaviour
> configuration.
>
> This is a complete rework of
> "platform/chrome: cros_ec_framework_laptop: new driver" [0], which used
> Framework specific EC commands.
>
> The driver propsed in this series only uses upstream CrOS functionality.
>
> Tested on a Framework 13 AMD, Firmware 3.05.
>

I've tested this out on the Framework Laptop 13, 11th gen intel core
and AMD Ryzen 7040 editions.

The problem is that the AMD framework laptop *reports* support for the
CrOS charge controller, but it does not truly support it.
As with the 11th Gen Intel Core (and by proxy the 12th, 13th) it still
does require the OEM-specific command.

This is evinced by a mismatch between the firmware-configured value
and the value reported by the charge control subsystem through this
driver.

$ cat /sys/class/power_supply/BAT1/charge_control_end_threshold
100

$ ectool raw 0x3E03 b8 # OEM command 0x3E03 with BIT(3) in the payload
is Framework's charge limit query host command
Read 2 bytes
 50 00                                           |P.              |
(in my case, 80 in decimal)

The charge limit is managed at [1], and it does not appear to
integrate with the standard charge control machinery.

I'll pursue getting this board not to report support for CrOS charge
control. This driver is still entirely fit for purpose, just not for
this board.

Cheers,
d

