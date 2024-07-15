Return-Path: <linux-pm+bounces-11126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAA4931DCB
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 01:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08CE2828DD
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 23:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B0414375C;
	Mon, 15 Jul 2024 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="UYo4CEr6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9933D1E890;
	Mon, 15 Jul 2024 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087331; cv=none; b=KVjXsu8+gnzxmi0OxpOtFpNMjMWphoWg3Pu8E7d/DuKB92tTkmoO6+TRRWcBIMcroC9K/rkIvSMFvWHdtNkZnosuHrvQmpL+W6LmSckAnhq3wEY8hvWe8czD5WDJKR33ggwYVgNHbFjYwymvareDITA5QcDoPPOuKXT5KXl6tuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087331; c=relaxed/simple;
	bh=LSr9DCwybH953AHAZ+tVm+BfKr48TD9trw7Lyon3Pvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2llG81lkkdG8mQZbDUy92FfsyhyEwbVZcYs2wywU90UMuGm7W0K5WSIOGJ1NZmEYXZy3VgaoJz3l4VY1p8bU1sXDt1nd5MknzhXRWkWxe1hF+qTir+rESCBM9nGB4EmtLy6ihduc5U15+HreT31xe8fgprvOPyPzQifpECzabQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=UYo4CEr6; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721087313; x=1721692113; i=s.l-h@gmx.de;
	bh=ge2mNpHRtAgm+XOljWk/lmzXJZmYxpov2mWQv5oGaNM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UYo4CEr6YcqVH65aYAUnCmfOBBevsVJCFjjObFyJM/SJ1i5ONBPubyBIfENLxX0H
	 ScxPvghEcEkqNVtqESBKovfrvl9ejM20SF7Z50g9j3Rfc0wBVVI8MUrVyPLCNnx05
	 77CyEoy3Z/Qs8f3t1ff9t068CNF8Fk+eb6CKgqwzJmt9SrbW7ZpCLpR/OxUtwpKxp
	 VPhe+R5hL9xu3dZRinO3DBNXOi2sdZzO0jSS0IJZXw/0Zbd9zruy0fOM2MRohd54E
	 0A6t/pob0TFCV0T2QkHbVz3p9+QpPcWheYmSc2TM5Rt+0I4dYGvHGUAjVwW0jdgvm
	 gagyCztpFigAEbKNWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.83.155]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ycl-1sVzTO35Kt-00B9Qf; Tue, 16
 Jul 2024 01:48:33 +0200
Date: Tue, 16 Jul 2024 01:48:30 +0200
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Eric Biggers
 <ebiggers@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukasz
 Luba <lukasz.luba@arm.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
Message-ID: <20240716014830.243bb0cf@mir>
In-Reply-To: <CAJZ5v0gPiwkNczZhCf_rkxVoUX33tS9c6irMf_7=Rg48Nw9C4w@mail.gmail.com>
References: <6064157.lOV4Wx5bFT@rjwysocki.net>
	<20240715044527.GA1544@sol.localdomain>
	<4d7e11a7-b352-4ced-acee-b5f64e3cd0b6@linaro.org>
	<CAJZ5v0gx6GyKBYt7YMFwmUQ4OCG49d9k2H=P-4Awr-mJ=eFHKw@mail.gmail.com>
	<20240715145426.199c31d0@mir>
	<CAJZ5v0gPiwkNczZhCf_rkxVoUX33tS9c6irMf_7=Rg48Nw9C4w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fjc3d3kbblW7VwkaCKAKB9ywyW4ByFNhDPtS7o8Aa9eCbhp/bXH
 1MC0xXyslAf/2DhUiQj+ev+C+R1Ugd5MmVN9P1IYnD/g2XHKoXLo6pc9vLT8yYVnjf8WycP
 jv4gKmiQYKZqw4QE2yxeSdEGhPijgwTnRtih0mgipA3+6PscH9vvbtr+DbKflYmBB7wQnuC
 ZYIckJncHBwfzzH1Ihyrw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J9rdLLvui0U=;woKg5latmgCFHzgSndDG9bObmZh
 BqCLLZhLR0j1ig5G4dsY7rsmZqkH+jI+JGnEt9yarMuGqk5sNdxb2JhVokJoAwveae3Fh97iS
 CRR8t6MfX9MoQde7BsLlCg64Hgj9AaR719b9bac2n95tjBTBxJfa037emXldwG0WYejSc0MG+
 odL1KbPjvLK+j8atrItTt0rNhz78OSTSl3rV9bVCvpxdCV5lbL8rNOWWGKJ+IfYZK4zn8XPoT
 +Vl9Krr5Y0EN02v2d7DFhYeOQ7x78HlCEzlXXBj5csGbaYiCJpwZmPp2EC3Tr9WKXE5HVsl/y
 3xf9nD11BLdRqJ7zB7er3A7aWZJ9ZD1RWZOcWW+g3k7jrulWjIRPPG0KWB5DRurxIl9IF5hfH
 hnW2z7ouOb/VjCUsG322xsdQBUbO3yEWoaxwhg6809+9qK6ou/yxi8/385fMD4meMhKEOulj5
 +TsDtANYNDt1mNiSmjKqLAkty0/t81AjV1lIrsOVW4J/3z8UQGmp5djUlmJ3xpypLyYOI9+yG
 JWdDhZDR0DnpoEv3zXtbRtPppiCGyKyOfEYwV7y+LwKOdL8k+iNnu2NucLRAFzMc7ibJr8IYy
 /QPIy+47gSHUPsIT/u3aBArYktCu2iPr0Y0ydFTlPNyLjGOSZPZ4SYF/sGhUZYwQcGpsJ6AGu
 r+r+IlPxBdzyVm4nFKC+BT2WqOMC+EmuEg9Y1qS8Fh2nd5lPjRDK8Ho2dlnkcFEVdEe3IFG7k
 3OA4uHPC6QZgOlyD5fwEqLncFxxmgt1pvnnlTkOnXgIxGDb4lq773YKhNmidyssmRudweomMT
 fSMNX8n2XrOo27YdIoA8LFTQ==

Hi

On 2024-07-15, Rafael J. Wysocki wrote:
> On Mon, Jul 15, 2024 at 2:54=E2=80=AFPM Stefan Lippers-Hollmann <s.l-h@g=
mx.de> wrote:
> > On 2024-07-15, Rafael J. Wysocki wrote:
> > > On Mon, Jul 15, 2024 at 11:09=E2=80=AFAM Daniel Lezcano
> > > <daniel.lezcano@linaro.org> wrote:
> > > > On 15/07/2024 06:45, Eric Biggers wrote:
> > > > > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysocki wrot=
e:
> > > > >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[...]
> > Silencing the warnings is already a big improvement - and that patch
> > works to this extent for me with an ax200, thanks.
>
> So attached is a patch that should avoid enabling the thermal zone
> when it is not ready for use in the first place, so it should address
> both the message and the useless polling.
>
> I would appreciate giving it a go (please note that it hasn't received
> much testing so far, though).

Sadly this patch doesn't seem to help:

$ dmesg  | grep -e iwlwifi -e thermal
[    0.113700] thermal_sys: Registered thermal governor 'fair_share'
[    0.113700] thermal_sys: Registered thermal governor 'bang_bang'
[    0.113700] thermal_sys: Registered thermal governor 'step_wise'
[    0.113700] thermal_sys: Registered thermal governor 'user_space'
[    0.113700] thermal_sys: Registered thermal governor 'power_allocator'
[    3.885485] iwlwifi 0000:04:00.0: enabling device (0140 -> 0142)
[    3.888462] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id 0x1005=
30 wfpm id 0x80000000
[    3.888471] iwlwifi 0000:04:00.0: PCI dev 2723/0084, rev=3D0x340, rfid=
=3D0x10a100
[    3.892720] iwlwifi 0000:04:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 89=
.3.35.37
[    3.994292] iwlwifi 0000:04:00.0: loaded firmware version 77.a20fb07d.0=
 cc-a0-77.ucode op_mode iwlmvm
[    4.383879] iwlwifi 0000:04:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MH=
z, REV=3D0x340
[    4.513229] iwlwifi 0000:04:00.0: Detected RF HR B3, rfid=3D0x10a100
[    4.578828] iwlwifi 0000:04:00.0: base HW address: 94:e6:f7:XX:XX:XX
[    4.592597] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[    4.604651] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
[    4.849442] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[    5.105488] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[    5.361470] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[    5.618458] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[    5.873428] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[    6.129429] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[    6.385446] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[    6.641695] thermal thermal_zone2: failed to read out thermal zone (-61=
)

Regards
	Stefan Lippers-Hollmann

P.S.: I've now also noticed the same issue on a raptor-lake system with AX=
201.

