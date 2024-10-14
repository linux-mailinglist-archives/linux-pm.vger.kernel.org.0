Return-Path: <linux-pm+bounces-15631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D78D99D7D2
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 22:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93D05B20D11
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 20:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC68A1CEAD3;
	Mon, 14 Oct 2024 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/u4CEKE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA351CCEE4;
	Mon, 14 Oct 2024 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936236; cv=none; b=isVuYEn+ib+kySeegjxWaEOolBQVdcZe3w3N1+AjhNiUWP00K964FgCsbr9CuXIxgkGmA5r8+cd8AWF8zJvxeKlYYHsDwE83c8S0HWoSaBNqJwptonvU2aD8rNpTcBrgYhhfgyr68Y2yFz6WaYW0/ovwXOps3l0KDD2sAaHVBMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936236; c=relaxed/simple;
	bh=31eAeCf1Pu8m37jDhpFlOugCH/adcm0tfpKkul9cMhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNDcPnQdX6K3uyubC63Fb3AsMqaVz3/li1hmHA1IvUyqjU3hdaqAMx3aLa73wESSR4BtoogftH9p+Iz9v9QCxAAmOx+C/snTKiu4JThXJ79AueBSCt1fee2xnMHgiYkF+6cpCZjfQbesYZAQLkOnEdh+czhNAdFfr7MpHF9hLW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/u4CEKE; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso6826491fa.1;
        Mon, 14 Oct 2024 13:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728936233; x=1729541033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5Ryw9wfAFFqkya8ePoot2rbTzCnReGstxM2eHbD8gA=;
        b=N/u4CEKEED2Vo7jTP3HMU0gdPqi+Jnk0MG5XYgrFRoAm0EAYDzMz9j8jur6pmDBvVu
         IjA0arERM524A9a2Vi/qCugILxxweJkA9sljQGYeWFPxR4BjM9uZF9BAsNNynw/QQ1Vm
         ulDgNyDVVmHlSw+i9mV4m/ZN9v6ZmgKMYddRf1DPG9mAFGYLqdRqEH8G4OiU9/Wtyh2X
         b5OUoYWTjU0slsmwc0k7aCjMSKjuBto9kCi5hQOCaVHi+8uaDt7fH2x+aeC8ICq6bdQn
         CIW8IhCOxmRfY8OZ2SBB9X+aobxxUeIE6PCPD1jDeaKKpvbYXujdUMXyBP4ctWMfY9B8
         oMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728936233; x=1729541033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5Ryw9wfAFFqkya8ePoot2rbTzCnReGstxM2eHbD8gA=;
        b=CJcDL7Bq8fD/EGY9nhdF5Fv3k9JyDIi22HUoyN5iRLfCUIgMfC00mLs2/M5Ed9rPhE
         uSZW0YPSr1WIY89inM7aeXkj0kx5BPBETIaPu9ECTfmU2lXYMcqvpBMfxZfIcPZb0xdF
         Rh0W7Lxdw7jUk9+tM6TkzfJgphZRA0o/0JQB+ZhfBDLIpxUjsjVPZ023rllMW7+z5MGU
         4jb+ONYCSAqSS0+sCPbdTf146/PD0CkSBtQj4985PGzh77RnlAo2kuV6Lt7gqCLhr89c
         fkP2QlpnBbYjroUU2LGHuxQH6xoX2tYA4HwT3CaWQmAH0jJoR/lFWcrBuP7J8VPjHdUE
         2qWg==
X-Forwarded-Encrypted: i=1; AJvYcCUgdS0Wr5i0V7z9Po3zzzKNZ5iGtL+WGoUAeGr329EZD6Kzz9D0Dmk8w2pTFsffj1kWqfPj4Ld1Tlk=@vger.kernel.org, AJvYcCWL3iJfiM/raTJOagIG5LE6RmNy+25puU7F2FiJ7AxmA0IcjpU7ivle4zXrXViKUITVAuEtGtZydOj52qSi@vger.kernel.org, AJvYcCWoBITtyIMGMrMgEivWhEuUMDirC1gAWMyoJR5iy4VtsDnw/ii7Seoz3P8WtWVgLqilr1F1S4R964qKy6IauTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC834Yt6eHbF6VlYUFk916tS0onvqXOPFnrlOFS7+guu1+oci0
	u9SRaP/t2+9HGwVfdiyztRwpWpc1yCABMEcdE/HBuydBD7qK3Ihb+Wc42u4jzHjtzscVxpvlUup
	H0ggOUbglnwO0u1GC/dNfzxBJ5OM=
X-Google-Smtp-Source: AGHT+IFRmi6V6Ogg7qI8ZXexlusZsNA7Qz1B5IAbwBMMsBtLcm7B+OCU6xd5Kd0nmmVbExkF9aykbWG6gnMV1FWDVR4=
X-Received: by 2002:a2e:515a:0:b0:2fb:411e:d979 with SMTP id
 38308e7fff4ca-2fb411ed9d7mr25971451fa.31.1728936232926; Mon, 14 Oct 2024
 13:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iUaszpE=J3_wLhdmBrrDdTSL1Rs-mgjL8koC1kk4apOA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iUaszpE=J3_wLhdmBrrDdTSL1Rs-mgjL8koC1kk4apOA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 14 Oct 2024 16:03:40 -0400
Message-ID: <CABBYNZL_EtFQ-n5K8fFQJpCJmDksLpJ38RMcoawgttCHP6Hwwg@mail.gmail.com>
Subject: Re: [Regression] Bluetooth mouse broken in 6.12-rc3
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Kiran K <kiran.k@intel.com>, 
	"Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

On Mon, Oct 14, 2024 at 2:37=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi Luiz,
>
> Unfortunately, commit 610712298b11 ("Bluetooth: btusb: Don't fail
> external suspend requests") from you that appeared in 6.12-rc3
> prevents my Logitech Bluetooth mouse from connecting to the host
> (btusb).  The LED activity on the mouse indicates that it tries to
> associate, but there is no response.  It looks like the host is
> suspended before the device can connect to it and it cannot be woken
> up for some reason.
>
> It worked no problem in 6.12-rc2 and the above commit is the only BT
> one in 6.12-rc3.  Also reverting it makes things work again.
>
> In the "good" case (for example, in 6.12-rc3 with the above commit
> reverted), the following messages are present in the kernel log:
>
> [  251.748734] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [  251.748763] Bluetooth: HIDP socket layer initialized
> [  251.773010] hid-generic 0005:046D:B016.0001: unknown main item tag 0x0
> [  251.774432] input: Bluetooth Mouse M336/M337/M535 Mouse as
> /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0=
005:046D:B016.0001/input/input14
> [  251.775733] input: Bluetooth Mouse M336/M337/M535 Consumer Control
> as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:=
1/0005:046D:B016.0001/input/input15
> [  251.777163] input: Bluetooth Mouse M336/M337/M535 Keyboard as
> /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0=
005:046D:B016.0001/input/input18
> [  251.815905] hid-generic 0005:046D:B016.0001: input,hidraw0:
> BLUETOOTH HID v12.03 Mouse [Bluetooth Mouse M336/M337/M535] on
> 9c:b6:d0:96:8e:c8
>
> In the "bad" case (for example, in unmodified 6.12-rc3) they are not
> there at all.

Thanks for the report, we had quite a few similar reports and I will
send a fix sortly.

> Thanks!
>


--=20
Luiz Augusto von Dentz

