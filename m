Return-Path: <linux-pm+bounces-13417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D00B969DA1
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 14:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326A91C22B51
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5450E188001;
	Tue,  3 Sep 2024 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9Cwt331"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF521B12F2;
	Tue,  3 Sep 2024 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366677; cv=none; b=dMzl7sQXWUxXqg00fa+89FmAYpQc7Z7/rAqTwH6ziLNqaDxNUx61b/Gjt/+k/zr0JnFyZ7na+hM2Rum5fUhM2RZE3f2UQBcPj/LZtunsZ9697OC4r4yybcQM84gQ8+MKsmSEQ3AXdEEBqRiZNnoanl4AJThf7YpJ1vVS/HSo9HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366677; c=relaxed/simple;
	bh=qd3YxyjMYJ2bCJ1Cx0VsMYa5IKT9E+IfmiTj9DCPMgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9NnwcC2AWwWqmyLF6ZDJewj8cooijITXmV9gKUxpMKul9AhMBdj+q71GisT6oVzGxIcwVZlU8Eas6ecfjtod7mK8H/CCRnwLL0yPxPdjW/+uXrAQxdcJIEwQZf2ktAWvc+PS7lpP+vWuAQgtPkqUNH2f0hkZ0EOgvRnxRVErxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9Cwt331; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE55C4CECA;
	Tue,  3 Sep 2024 12:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725366676;
	bh=qd3YxyjMYJ2bCJ1Cx0VsMYa5IKT9E+IfmiTj9DCPMgA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p9Cwt331oTsaBNNrEypvf8b/uEF69M+RFSUX9uXcNrYfWJwDNCbrQfL3m8DThVSAl
	 b3xwH0H91TVS8haXoVVe47qPwvXlze90hFuZWNhzAUhrC6+SuDm6G+7yfDe7n1aC8M
	 oQgduVcD7wHXryQNOU7oVoSyXYUFhbovZF+IniPUUB4WQufgLugkScpnFnaplx0sb7
	 UgTP9qp8Qwwvk+SIsZ3Bg03I7YSGkdtGMBBSyIe3U67AOjz6f3LGlxbxTn4tit7wSR
	 Sf3gTURGWu3c0QVVeXV53F1pjtzBhXHG6PlT2/bejy5vkQ9DUfzJPonN34eFkM4/jg
	 2m+EyXqZCPTaA==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3df0dc53ec1so3040433b6e.1;
        Tue, 03 Sep 2024 05:31:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGZSerFs3xsky+yKqtsjR4hp4hWM1u+XDHtAbfa6vS0IG+LiTZGM8TnRmSLUGZh5StukJLmdD5PoI=@vger.kernel.org, AJvYcCUfKZGOg6KohIWCG/oxfoXvuep6gJIVhLn/3kqUHonGFs0FOXzSUShGEoVP0yETx6cu6T73tuheJhYWjio=@vger.kernel.org
X-Gm-Message-State: AOJu0YweraKT1n/Hfky+yI4tseL0TpL/qZsLefAFurlaE5Eqh5ZPKTBc
	ogC8hnrFZjvQsLKteWpdpQ6zK07l7OSRhNrTzWYhGxLwfMaOWe9C4FnTLkxQ8b9/YdDpDN4/ZWy
	Wna5C+xJwtopqB+FgbA5w2eLjZ1U=
X-Google-Smtp-Source: AGHT+IHvp5rsI7Bt85qzdXZ81AuCvRx2LxFL/Zu5C1K0ZMKZAS7lysa3cHAw5xVEHBIQXAYgRKzPVlbJLjZifH3WEk8=
X-Received: by 2002:a05:6808:1892:b0:3d9:2c7b:26d4 with SMTP id
 5614622812f47-3df1d66126dmr13542701b6e.28.1725366675807; Tue, 03 Sep 2024
 05:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902125933.5742-1-00107082@163.com>
In-Reply-To: <20240902125933.5742-1-00107082@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Sep 2024 14:31:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hMnnDjKJLMgcT_p1nnejyyAyaqaA_AF5t+_=PsSMfceQ@mail.gmail.com>
Message-ID: <CAJZ5v0hMnnDjKJLMgcT_p1nnejyyAyaqaA_AF5t+_=PsSMfceQ@mail.gmail.com>
Subject: Re: [PATCH] pm: sleep: do not set is_prepared when no_pm_callbacks is set
To: David Wang <00107082@163.com>
Cc: rafael@kernel.org, pavel@ucw.cz, gregkh@linuxfoundation.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d1c4a80621363b96"

--000000000000d1c4a80621363b96
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 2:59=E2=80=AFPM David Wang <00107082@163.com> wrote:
>
> When resume, a parent device with no pm callbacks
> would have "is_prepared" and "direct_complete" bit
> set, and skip the "fib" chance to unset "is_prepared"
> in device_resume because of the direct_complete bit.

Sure, but is_prepared will be cleared in device_complete() AFAICS.

> This will trigger a kernel warning when resume its child
> For example, when suspend system with an USB webcam
> opened, following warning would show up during resume:
>
>  >usb 3-1.1: reset high-speed USB device number 4 using xhci_hcd
>  >..
>  >ep_81: PM: parent 3-1.1:1.1 should not be sleeping

This is printed in device_pm_add(), so apparently something new has
appeared under the parent while it's between "resume" and "prepare".

The parent is actually still regarded as "suspended" because any
resume callbacks have not been called for it, but new children can be
added under it at this point because doing so does not break the
dpm_list ordering and all of its ancestors have been already resumed.

> The device parenting relationships are:
> [usb 3-1.1] << [uvcvideo 3-1.1:1.1] << [ep_81].
> When resume, since the virtual [uvcvideo 3-1.1:1.1] device
> has no pm callbacks, it would not clear "is_prepared"
> once set.  Then, when resume [ep_81], pm module would
> yield a warn seeing [ep_81]'s parent [uvcvideo 3-1.1:1.1]
> having "is_prepared".
>
> Do not set "is_prepared" for virtual devices having
> no pm callbacks can clear those kernel warnings.
>
> Signed-off-by: David Wang <00107082@163.com>
> ---
>  drivers/base/power/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 934e5bb61f13..e2149ccf2c3e 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1880,7 +1880,8 @@ int dpm_prepare(pm_message_t state)
>                 mutex_lock(&dpm_list_mtx);
>
>                 if (!error) {
> -                       dev->power.is_prepared =3D true;
> +                       if (!dev->power.no_pm_callbacks)
> +                               dev->power.is_prepared =3D true;

This is not the way to address the issue IMV.

power.is_prepared set means that the device is in dpm_prepared_list
and I wouldn't depart from that even for devices without PM callbacks.

>                         if (!list_empty(&dev->power.entry))
>                                 list_move_tail(&dev->power.entry, &dpm_pr=
epared_list);
>                 } else if (error =3D=3D -EAGAIN) {
> --

It would be better to add a power.no_pm_callbacks check for the parent
to device_pm_add(), but this would still suppress the warning is some
cases in which it should be printed (for example, the new device's
parent is a "virtual" device without PM callbacks, but its grandparent
is a regular device that has PM callbacks and is suspended).

Something like the attached patch (untested) might work, though.

--000000000000d1c4a80621363b96
Content-Type: text/x-patch; charset="US-ASCII"; name="pm-sleep-pm-add.patch"
Content-Disposition: attachment; filename="pm-sleep-pm-add.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m0mepvtg0>
X-Attachment-Id: f_m0mepvtg0

LS0tCiBkcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jIHwgICAxNiArKysrKysrKysrKysrLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCkluZGV4OiBs
aW51eC1wbS9kcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBt
Lm9yaWcvZHJpdmVycy9iYXNlL3Bvd2VyL21haW4uYworKysgbGludXgtcG0vZHJpdmVycy9iYXNl
L3Bvd2VyL21haW4uYwpAQCAtMTI3LDYgKzEyNyw4IEBAIHZvaWQgZGV2aWNlX3BtX3VubG9jayh2
b2lkKQogICovCiB2b2lkIGRldmljZV9wbV9hZGQoc3RydWN0IGRldmljZSAqZGV2KQogeworCXN0
cnVjdCBkZXZpY2UgKmFuY2VzdG9yOworCiAJLyogU2tpcCBQTSBzZXR1cC9pbml0aWFsaXphdGlv
bi4gKi8KIAlpZiAoZGV2aWNlX3BtX25vdF9yZXF1aXJlZChkZXYpKQogCQlyZXR1cm47CkBAIC0x
MzQsMTIgKzEzNiwyMCBAQCB2b2lkIGRldmljZV9wbV9hZGQoc3RydWN0IGRldmljZSAqZGV2KQog
CXByX2RlYnVnKCJBZGRpbmcgaW5mbyBmb3IgJXM6JXNcbiIsCiAJCSBkZXYtPmJ1cyA/IGRldi0+
YnVzLT5uYW1lIDogIk5vIEJ1cyIsIGRldl9uYW1lKGRldikpOwogCWRldmljZV9wbV9jaGVja19j
YWxsYmFja3MoZGV2KTsKKwogCW11dGV4X2xvY2soJmRwbV9saXN0X210eCk7Ci0JaWYgKGRldi0+
cGFyZW50ICYmIGRldi0+cGFyZW50LT5wb3dlci5pc19wcmVwYXJlZCkKLQkJZGV2X3dhcm4oZGV2
LCAicGFyZW50ICVzIHNob3VsZCBub3QgYmUgc2xlZXBpbmdcbiIsCi0JCQlkZXZfbmFtZShkZXYt
PnBhcmVudCkpOworCisJYW5jZXN0b3IgPSBkZXYtPnBhcmVudDsKKwl3aGlsZSAoYW5jZXN0b3Ig
JiYgYW5jZXN0b3ItPnBvd2VyLm5vX3BtX2NhbGxiYWNrcykKKwkJYW5jZXN0b3IgPSBhbmNlc3Rv
ci0+cGFyZW50OworCisJaWYgKGFuY2VzdG9yICYmIGFuY2VzdG9yLT5wb3dlci5pc19wcmVwYXJl
ZCkKKwkJZGV2X3dhcm4oZGV2LCAiYW5jZXN0b3IgJXMgc2hvdWxkIG5vdCBiZSBzbGVlcGluZ1xu
IiwKKwkJCSBkZXZfbmFtZShhbmNlc3RvcikpOworCiAJbGlzdF9hZGRfdGFpbCgmZGV2LT5wb3dl
ci5lbnRyeSwgJmRwbV9saXN0KTsKIAlkZXYtPnBvd2VyLmluX2RwbV9saXN0ID0gdHJ1ZTsKKwog
CW11dGV4X3VubG9jaygmZHBtX2xpc3RfbXR4KTsKIH0KIAo=
--000000000000d1c4a80621363b96--

