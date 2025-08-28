Return-Path: <linux-pm+bounces-33254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1237BB39C00
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 13:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471023A9D88
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 11:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EE530F527;
	Thu, 28 Aug 2025 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="FShbToC2";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="ZY6yP+2N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D038A30C61A;
	Thu, 28 Aug 2025 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381935; cv=pass; b=U03AAD3GU9XO/ql473tbQVrbGLOZDcGpugnW2b+dhs2iwWGSVRWwC5WKUBTgqXoXRVnVu3JalHvEMahT8XxYbySsYRsZCMfl/BVZps867kHNWge9UkY/YvLjl4tYFsUWAvTKk/phOLMvJHqFo7ClT+cMyKsEHPRk0IOZnFGXdGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381935; c=relaxed/simple;
	bh=Kx4l3+xB1BSQ8qLi5aQcVgB8V8o2amSYdQIf+TG/czk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sCiPqTYpXY2CYBXGzoHEmX5Mq+eXRgZCyveXSelbfwG6I9y/QAdub1uJai46tLXd3afj3OTnzt4hMRIbEst4DckPeThAHhRRbWr+YVlZFiW3B9lC+fp6a7moJnNvqzekuE9SIirM8sia2YnZYjE/FXgiZtjxMbNzuQmlAfGYmro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=FShbToC2; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=ZY6yP+2N; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1756381559; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HW9nBCZm79N6/3lZiBIBb4oNVP9kUaaVmnjTuYubgdIKr5rMuKkjVkG3wCpdSJlJFn
    s4dBpD2BubC5bWfWJEsfo30j0o4gNoBLhE+YY1njsotQqnsMi3DMG4zkyC6Kr3seK3uH
    b9kyzjVwJJdHpz7PZYfeyyKyyF7+FuP/K7xMNWknwjfD/M5knzqZ6Fjc2Csazy/DrNS0
    kB4OchwC8i0HgcOf29l8jwlYaZsU/Lx2Rk+Fmrfk9DTiNCtfkDRjWM0K4PTwrpPmdHRC
    hcHASJYuRDA1QTKi6U0CUIUrl1YUKbBudJnlrRTtgLt8VGRG05o8GnMKP6Pgoen95qoM
    8Urg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1756381559;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=MWefUO0OIHQqurX1Ir8EInMU5qzQRWl+IVu35PatAbo=;
    b=Yu6249nvabFJ5RYXNlBYsx39cc4KZrKiYbJ9jT3eyPf3b95UWsugoEgQA6wJ8/ZNLP
    2ePmozzO1duK7DJ6GsdObPF7j37gSTMoDax5miwrLYfDaHaq9IO20LN8lHxKMusnX8Fa
    ATWYrA+CoPf/56ioGKhruj0J7FxEK/OzK6OnvPa7lsBfU9SZJQsTlshga9VFMi+/PF7m
    pIGyeiDDuWY8F3mH0uoNCBHfzLidn3sZV0DV/lYufs182Y7/q328MMJrTBVGxatGn/f3
    b2sJ4KothJW/UXMKHhMtwklfbnYI0Al+2uQ1FpUCyxU+8ukmctkHgtU9jaFFCm+fh6ys
    Tfhw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756381559;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=MWefUO0OIHQqurX1Ir8EInMU5qzQRWl+IVu35PatAbo=;
    b=FShbToC21WikuInf/t99VpikTtjdvsnOYD8Zj3hPA3Po04737lsI4QJ86sOlkG2scf
    tjI3A9Bd8sPKuvJzKHASi9LuSKtOE4QYaian4ZzjIIGII1BsQ/wea9H0O2hy+9HHwgwu
    G+q9H2XCcpSbudEhAjmHFsPbhEJsULPPXnVpeqS4E6Qth0I6DulxikE7Gk4Ky8qb+pAa
    cly6/nUyTe1B/5sv9L6LJHHYGGoU+P79M8c3tidCpUkivNGDyXWzmUwduHiB//GzkG93
    SQNd8K4vfb9U6hO2karL+lxaBu47dH/lGd4yeyS7esehLrekJLEiOxg01DFiyBVJIZAD
    vQqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756381559;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=MWefUO0OIHQqurX1Ir8EInMU5qzQRWl+IVu35PatAbo=;
    b=ZY6yP+2NQbqb9OW//H9p8m+GSWe9pffRqxLaNPL91GNCtyv9ztcN4qAsO2lHHhc3O4
    7OSfVauPQvB3hh8UFdDA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeTsZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 52.1.2 DYNA|AUTH)
    with ESMTPSA id Q307a417SBjwmjN
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 28 Aug 2025 13:45:58 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [Letux-kernel] [PATCH v2 2/2] power: supply: bq27xxx: restrict
 no-battery detection to bq27000
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <6162e560-1b60-4e30-8d1e-210ba9e132cd@axis.com>
Date: Thu, 28 Aug 2025 13:45:47 +0200
Cc: Sebastian Reichel <sre@kernel.org>,
 Jerry Lv <Jerry.Lv@axis.com>,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 kernel@pyra-handheld.com,
 =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 Andreas Kemnade <andreas@kemnade.info>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CE9A923-2205-425D-81D0-DAFF8527C498@goldelico.com>
References: <cover.1755945297.git.hns@goldelico.com>
 <dd979fa6855fd051ee5117016c58daaa05966e24.1755945297.git.hns@goldelico.com>
 <6162e560-1b60-4e30-8d1e-210ba9e132cd@axis.com>
To: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
X-Mailer: Apple Mail (2.3826.700.81)



> Am 28.08.2025 um 09:33 schrieb Jerry Lv <jerrylv@axis.com>:
>=20
> On 8/23/2025 6:34 PM, H. Nikolaus Schaller wrote:
>> There are fuel gauges in the bq27xxx series (e.g. bq27z561) which may =
in some
>> cases report 0xff as the value of BQ27XXX_REG_FLAGS that should not =
be
>> interpreted as "no battery" like for a disconnected battery with some =
built
>> in bq27000 chip.
>>=20
>> So restrict the no-battery detection originally introduced by
>>=20
>>     commit 3dd843e1c26a ("bq27000: report missing device better.")
>>=20
>> to the bq27000.
>>=20
>> There is no need to backport further because this was hidden before
>>=20
>> 	commit f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again =
when busy")
>>=20
>> Fixes: f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when =
busy")
>> Suggested-by: Jerry Lv <Jerry.Lv@axis.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>>  drivers/power/supply/bq27xxx_battery.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/power/supply/bq27xxx_battery.c =
b/drivers/power/supply/bq27xxx_battery.c
>> index dadd8754a73a8..3363af24017ae 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -1944,8 +1944,8 @@ static void =
bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
>>  	bool has_singe_flag =3D di->opts & BQ27XXX_O_ZERO;
>>    	cache.flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, =
has_singe_flag);
>> -	if ((cache.flags & 0xff) =3D=3D 0xff)
>> -		cache.flags =3D -ENODEV; /* read error */
>> +	if (di->chip =3D=3D BQ27000 && (cache.flags & 0xff) =3D=3D 0xff)
>> +		cache.flags =3D -ENODEV; /* bq27000 hdq read error */
>>  	if (cache.flags >=3D 0) {
>>  		cache.capacity =3D bq27xxx_battery_read_soc(di);
>> =20
>=20
> This change works fine for BQ27z561

Thanks for testing!

So it appears we need a maintainer to pick up these patches...

BR,
Nikolaus


