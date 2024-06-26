Return-Path: <linux-pm+bounces-10033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC4A917E46
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 12:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9500F1F24F9B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C811662F2;
	Wed, 26 Jun 2024 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSj90z8A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE616D335
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398312; cv=none; b=cgTgqiCKl1iPlptNuFhKSbrs52tTzsactGvJdH2a3iG2BPi3zDTBoctXHaDjPhT8yoiVzYlR8v2qrpRG5b2nqEd7UJ8j4q84M44/Yn5hc0loPNCZ7KPWM5PefG5iNCjBljHwq/C85SK1/XlFJK2cINo/P9mUEDDIvlFO6Pxhnv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398312; c=relaxed/simple;
	bh=oeUK5LCbF3ki/dxVLtEiuRD2GAcgZ8DnpofnrCLPlQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aESOGx3tlvm455C86HZOhCDbzy8b/RFpSkVvZ79nq2BpABieUGcvxnXlVd4ugxqo8zLxwAADrg7UIKdKM3+RfNa/fumpct72jHK/k/8+h+FTlYqlMj/1BF91Zgs3GgKBqynVw5VdaY8U2Gloun6mxWK86Kx3t3Nfs9A7DnI5sLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSj90z8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D9CC2BD10
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719398311;
	bh=oeUK5LCbF3ki/dxVLtEiuRD2GAcgZ8DnpofnrCLPlQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kSj90z8ABWgUQCaW6iYyyvy0AqC928Nc6/IcmceWsVJo0Up6N6UJykQY/kcxYuEEM
	 Oy0rl7OHPCdPpH5FGcU6U2N5EB2oUuZTxftFxyaJ3SP6UAf8mmka5ECF4hOQAlkO13
	 qUzdvI1jdtPkKPk/uG1Z8gYkV/ZQhhXRdLPA/92DqKzk9j8YA9wQgtzMUoUBFF0og/
	 8p63J4SVPwq5eCgMWs38loCCv3S5o5RcbhStpcVYyTDRSSphjq8CHhY/GbxA9OWN85
	 TdjQQnz43IDft5GxN3iypWH39KTYsRvH7Fo8xtLTvL8ugoDtr4PGeyKQIOIYPKyT7b
	 +uqKJjbbVdrCw==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d560c1d953so15096b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 03:38:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8Emg/anIPJ5b8uHNOMNznQ1caLUf2VfuUZFY9yXtXki7oABkNdCQKaxxehrymGaNNikoHTM6/WwJziXQ/dBC+VCpqswGEpMo=
X-Gm-Message-State: AOJu0YzC71jqrUAVUsLSmKppmZkCIO0MP0KTcMa8oBhRQd3lG92+5BnG
	Eni8Z4aF0wRUV/HuQEBcfP7d2OsErnoBpMnaWG69X5lQDHNjFkDewdOiFHBnyd8RlEnIb8jH9U9
	T8C871lluwHaZGbC70qVKFy8qEso=
X-Google-Smtp-Source: AGHT+IEn9De1JS6uymS974XUakBJ3ZC66L3zX/6BZnKH+GLY4rntt7DbZntfZABWRDLitYRPb5FE0COiBFdyG5tNg4k=
X-Received: by 2002:a05:6820:2210:b0:5c1:30b6:c9ea with SMTP id
 006d021491bc7-5c1e440a61amr15775057eaf.1.1719398310751; Wed, 26 Jun 2024
 03:38:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org>
In-Reply-To: <dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Jun 2024 12:38:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iu9dg-tzfzZH5vfDZAv_OD1PKiZwaU-Q07Jz0-ULjtYg@mail.gmail.com>
Message-ID: <CAJZ5v0iu9dg-tzfzZH5vfDZAv_OD1PKiZwaU-Q07Jz0-ULjtYg@mail.gmail.com>
Subject: Re: Trip points crossed not detected when no cooling device bound
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, 
	Lukasz Luba <Lukasz.Luba@arm.com>
Content-Type: multipart/mixed; boundary="0000000000008a6499061bc89da6"

--0000000000008a6499061bc89da6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 26, 2024 at 8:50=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi,
>
> after experimenting different setup I noticed there is no longer trip
> crossed notifications sent to the userspace when there is no cooling
> device bound to a thermal zone.

I think I've seen those coming for zones without any cooling devices,
so it seems related to the setup.

> git bisecting leads me to this commit:
>
>
> 202aa0d4bb532338cd27bcc64c60abc2987a2be7 is the first bad commit
> commit 202aa0d4bb532338cd27bcc64c60abc2987a2be7
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Tue Apr 30 17:45:55 2024 +0200
>
>      thermal: core: Do not call handle_thermal_trip() if zone
> temperature is invalid
>
>      Make __thermal_zone_device_update() bail out if update_temperature()
>      fails to update the zone temperature because __thermal_zone_get_temp=
()
>      has returned an error and the current zone temperature is
>      THERMAL_TEMP_INVALID (user space receiving netlink thermal messages,
>      thermal debug code and thermal governors may get confused otherwise)=
.
>
>      Fixes: 9ad18043fb35 ("thermal: core: Send trip crossing
> notifications at init time if needed")
>      Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>      Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>      Tested-by: Lukasz Luba <lukasz.luba@arm.com>
>
>   drivers/thermal/thermal_core.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> -

Oh, I see where the problem can be.  If the zone is polling only, it
will not rearm the timer when the current zone temperature is invalid
after the above commit, so does the attached patch help?

--0000000000008a6499061bc89da6
Content-Type: text/x-patch; charset="US-ASCII"; name="thermal-poll-if-temp-invalid.patch"
Content-Disposition: attachment; 
	filename="thermal-poll-if-temp-invalid.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lxvpanxw0>
X-Attachment-Id: f_lxvpanxw0

LS0tCiBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgfCAgICAzICsrLQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKSW5kZXg6IGxpbnV4LXBtL2Ry
aXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC1wbS5vcmln
L2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYworKysgbGludXgtcG0vZHJpdmVycy90aGVy
bWFsL3RoZXJtYWxfY29yZS5jCkBAIC01MTQsNyArNTE0LDcgQEAgdm9pZCBfX3RoZXJtYWxfem9u
ZV9kZXZpY2VfdXBkYXRlKHN0cnVjdAogCXVwZGF0ZV90ZW1wZXJhdHVyZSh0eik7CiAKIAlpZiAo
dHotPnRlbXBlcmF0dXJlID09IFRIRVJNQUxfVEVNUF9JTlZBTElEKQotCQlyZXR1cm47CisJCWdv
dG8gbW9uaXRvcjsKIAogCXR6LT5ub3RpZnlfZXZlbnQgPSBldmVudDsKIApAQCAtNTM2LDYgKzUz
Niw3IEBAIHZvaWQgX190aGVybWFsX3pvbmVfZGV2aWNlX3VwZGF0ZShzdHJ1Y3QKIAogCXRoZXJt
YWxfZGVidWdfdXBkYXRlX3RyaXBfc3RhdHModHopOwogCittb25pdG9yOgogCW1vbml0b3JfdGhl
cm1hbF96b25lKHR6KTsKIH0KIAo=
--0000000000008a6499061bc89da6--

