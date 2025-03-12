Return-Path: <linux-pm+bounces-23934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E275A5E535
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 21:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA39189C0A3
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 20:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EB91E9B3B;
	Wed, 12 Mar 2025 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c10uLhiM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D131D5147;
	Wed, 12 Mar 2025 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810774; cv=none; b=cBchHP7mBFAP5fhA/2vEInVhsEDhjd6rb2Ygz5KkymrAN/7ODI9I40YnNlxC8b3zG1oq2WZzNHMBQyxSN4dlAP0A4PfSsb53srQBBUZ5iFuNILXlIR0lcQruNCwIMBVvxZgvb/WGY7+yWKVp333l5SUJgl28HYzov7UWjCFgP/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810774; c=relaxed/simple;
	bh=dP8j15QLVHCFzZENDuU3agpW/8W1hNls4T8B5Yzf/1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jz4RLG5VKoavPvrEyAaI++d4qugdGvrAR5ORXgOGZahRAuT0qQNBDsPdp7LDFcIkMRRqg1i7VSrbX/ljYyzTpx/an84dz9ZyeIKlLR7GWhhMKnU4KCwQUV22io7zdJOvQiQDGlGryPvbPq9RzifRcewDtFb6Rk6V/HbuNV+E7X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c10uLhiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0846FC4CEE3;
	Wed, 12 Mar 2025 20:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741810774;
	bh=dP8j15QLVHCFzZENDuU3agpW/8W1hNls4T8B5Yzf/1c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c10uLhiMpHqHwE7ODWos3IqpFPyBUJ+KfUvijj0PEczyscybTbinIYiRp1LASzmcy
	 5FL3iLGYUK28us2+DIUbKuds/JsC/iZ/GWCTrdAYh6IRsuHpsmSzJkeSVY8nwMZ3K8
	 8r+OhG2RpiPwr7Ft37S8CZuSsDl1mRd+ev/V4I+tNa1xtoXIUVGfk7eJxjsCYbY80V
	 QgxVx0OWrfGbmmQLjPruMDowgGr3/1/w1ADnVYKTFWPkDEMHHJFkR2oYM+skBWaBbO
	 tPmOTY4ggYretfdttoTkN2MbYXc/Qqr3bWfYLt46HNX0bAcjIv/MOakwcvhzGBm3+W
	 4klrE8ScBFdyA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2b38896c534so154377fac.0;
        Wed, 12 Mar 2025 13:19:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVKTxfmqNrWnYXCB7UJ5AmiO6ERSgd15oiAd2aUz2LN72DW4jW4b/xukBcGBorkS3UGIO3P4zUc5HC7No=@vger.kernel.org, AJvYcCXkbVTa5TxP4Den6MTBHN3OJHf2nLkx/TQpS0stRyuDAEx6cW6uIbn2c43qbstmO7HkDly4q1KUH88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYBEHcrBaAAL/wrme9lbNac9XgNCyzTNB9okiL72I7M3nEna8F
	uekyuEUW6KQ+6oFziiRcA75BiHuY95ngaEzAj2vfUMlqg1GEHVRvlsvjyAqKEKi1mMWh65G38ym
	vUccj4OFHedSaEI0wXotd2koJ3gU=
X-Google-Smtp-Source: AGHT+IGPtIF9n8Q2zJiH5GLOWyfayshIf1MppX2HsgP9ODt5i6P6R9UmXD/Y4iQWdD9K8NuF29K1ZXcbQwiWtnigJ08=
X-Received: by 2002:a05:6871:8416:b0:2c2:b18c:9be9 with SMTP id
 586e51a60fabf-2c2b18d470amr5236207fac.3.1741810773370; Wed, 12 Mar 2025
 13:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9c8ff2b103c3ba7b0d27bdc8248b05e3b1dc9551.1741776430.git.geert+renesas@glider.be>
In-Reply-To: <9c8ff2b103c3ba7b0d27bdc8248b05e3b1dc9551.1741776430.git.geert+renesas@glider.be>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Mar 2025 21:19:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hOUHQeWYtJ2Nousa9C6Coi7W6njaXDCa_=vk0Rzo6=pw@mail.gmail.com>
X-Gm-Features: AQ5f1JoQXdRNfRAL6c45dmkPkHvUFlBg-EBDerL3rMhug15BgJN_QHAryHC73xE
Message-ID: <CAJZ5v0hOUHQeWYtJ2Nousa9C6Coi7W6njaXDCa_=vk0Rzo6=pw@mail.gmail.com>
Subject: Re: [PATCH] PM: core: Fix indentation in dpm_wait_for_children()
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 11:47=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The body of dpm_wait_for_children() is indented by 7 spaces instead of a
> single TAB.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/base/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e4103d29a21a6b2f..2fc37658b0b582e2 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -249,7 +249,7 @@ static int dpm_wait_fn(struct device *dev, void *asyn=
c_ptr)
>
>  static void dpm_wait_for_children(struct device *dev, bool async)
>  {
> -       device_for_each_child(dev, &async, dpm_wait_fn);
> +       device_for_each_child(dev, &async, dpm_wait_fn);
>  }
>
>  static void dpm_wait_for_suppliers(struct device *dev, bool async)
> --

Applied as 6.15 material, thanks!

