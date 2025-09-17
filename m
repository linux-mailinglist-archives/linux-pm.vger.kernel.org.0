Return-Path: <linux-pm+bounces-34912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC9FB81679
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 20:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F185D1C26C21
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 18:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEC13009ED;
	Wed, 17 Sep 2025 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OC2Jgq4W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2442F616C
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758135528; cv=none; b=d7cbELiuPY8vTp2uDH5owgqUVLofeLMwx4rX3R9TsMFVVtNnMmzrlEj1b/PhFgR+oxiQwtHE6m/IL/ou1Xd1H8qtRVV45qibwrRmAmuL4Bvy+3Mwjg+m3D2PxCetdcSAyUg+hxulhjuY905I273Wp0JkMgYPQMz88E6CplU2GyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758135528; c=relaxed/simple;
	bh=qZ47U+uY1V1aqR0QgSujsnkp/ccycMFr96/IAqtBk4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvIWBZcU6yu4tDdNduf05SBOZNUYBWZbe2053UK1uh98qI9FHvo6/aK6w6MIkr3rkpyDeO28CBM9bVkWGKEsrjJOc/QJm9xVI8/WxOctk0wvhgvSbH6zpRGKUI4lFBEhrulnbGoemGbWykzqQx363xhI3NlRwvjFXDK7fwNy2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OC2Jgq4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AFCC4CEF7
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 18:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758135527;
	bh=qZ47U+uY1V1aqR0QgSujsnkp/ccycMFr96/IAqtBk4o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OC2Jgq4WzcVbLflvSOOVjUDkLyy70FncV2GNdzBDt4/Qeu2rIngaobwsV6D4y67/h
	 vbNhebcLlxqIuMWwr+JJIjqOZyJ0SlKuwq+fEU1qs4+8KZl8NQpiK5jkjiICwPUdGt
	 UcqKPGmuJ5o7+LzFpQYcWMmMrzOllQWuoBqxwvLwOoXjgJOh21eApVNyAtpB3B9hOz
	 o7CZV0mzG6Ht9d+H/EIPIfA8bw2lQYEbSjew6MgcwKCiFeqaUbjw7e1P1LIML9/zfq
	 HDNoohHmmwRVXBJM2ZaUb28HNbLQHYsHJFjDarhn4M5G+biPSgb+Qj6VpokygRa9Zt
	 D8muUpHD6e0+w==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-621cecfcc04so110223eaf.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 11:58:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUm335G4jfPiJY4DKjpgQfpEflVhOgj0WDca9HhWH4HpC78DurJFy0OqWeWm4ZZBRhYtA56Bn0Ugw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqMxDlliz55TKI6M1xKgWurrkTCKxtkEoBXeZrz1Z6U/Z5WqhD
	xdR90VLR7A/8LFzrHFX9VmgijW+nJuFWIvcfMus8ISGZnmGLSBvPjKJE95NhFuz3xYX+9RcKIMm
	CM7fglqT5EtiqM5IXonTW2YnzGZWAy2A=
X-Google-Smtp-Source: AGHT+IEltsAuTUpyjSvRYRPajVO0elNn8WTQYTo1avIgYupEMA/sG+mB59YaRalHS0jLIMjI93RXyrNDHri/QJou2EU=
X-Received: by 2002:a05:6820:80a:b0:61f:f591:8a2c with SMTP id
 006d021491bc7-624a0920a79mr1733768eaf.0.1758135527113; Wed, 17 Sep 2025
 11:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878qimv24u.wl-tiwai@suse.de> <87ikhptpgm.wl-tiwai@suse.de>
In-Reply-To: <87ikhptpgm.wl-tiwai@suse.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Sep 2025 20:58:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0htMKOcCoKts-B9BaE0VpS2oc9-cp=5VnNwS2Qe2iB+Kg@mail.gmail.com>
X-Gm-Features: AS18NWCm0TDXKUZAEXCsqFOaRysUs4POiddI_TfFNgwgoOlM00T0qOv12UeLO9A
Message-ID: <CAJZ5v0htMKOcCoKts-B9BaE0VpS2oc9-cp=5VnNwS2Qe2iB+Kg@mail.gmail.com>
Subject: Re: PM runtime auto-cleanup macros
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for the delay.

On Thu, Sep 11, 2025 at 9:31=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 10 Sep 2025 16:00:17 +0200,
> Takashi Iwai wrote:
> >
> > Hi,
> >
> > while I worked on the code cleanups in the drivers with the recent
> > auto-cleanup macros, I noticed that pm_runtime_get*() and _put*() can
> > be also managed with the auto-cleanup gracefully, too.  Actually we
> > already defined the __free(pm_runtime_put) in commit bfa4477751e9, and
> > there is a (single) user of it in pci-sysfs.c.
> >
> > Now I wanted to extend it to pm_runtime_put_autosuspend() as:
> >
> > DEFINE_FREE(pm_runtime_put_autosuspend, struct device *,
> >            if (_T) pm_runtime_put_autosuspend(_T))
> >
> > Then one can use it like
> >
> >       ret =3D pm_runtime_resume_and_get(dev);
> >       if (ret < 0)
> >               return ret;
> >       struct device *pmdev __free(pm_runtime_put_autosuspend) =3D dev;
> >
> > that is similar as done in pci-sysfs.c.  So far, so good.
> >
> > But, I find putting the line like above at each place a bit ugly.
> > So I'm wondering whether it'd be better to introduce some helper
> > macros, e.g.
> >
> > #define pm_runtime_auto_clean(dev, var) \
> >       struct device *var __free(pm_runtime_put) =3D (dev)
>
> It can be even simpler by assigning a temporary variable such as:
>
> #define pm_runtime_auto_clean(dev) \
>         struct device *__pm_runtime_var ## __LINE__ __free(pm_runtime_put=
) =3D (dev)

Well, if there's something like

struct device *pm_runtime_resume_and_get_dev(struct device *dev)
{
        int ret =3D pm_runtime_resume_and_get(dev);
        if (ret < 0)
                return ERR_PTR(ret);

        return dev;
}

It would be a matter of redefining the FREE to also take error
pointers into account and you could do

struct device *__dev __free(pm_runtim_put) =3D pm_runtime_resume_and_get_de=
v(dev);
if (IS_ERR(__dev))
        return PTR_ERR(__dev);

