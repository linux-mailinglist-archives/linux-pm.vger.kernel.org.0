Return-Path: <linux-pm+bounces-32929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B49B32838
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 12:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC03686ADF
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 10:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A0E23908B;
	Sat, 23 Aug 2025 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="HPfAXSxL";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="u5rjwlbx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407E1531C8;
	Sat, 23 Aug 2025 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755945273; cv=pass; b=MyhKx49O2yQvkiZtXuccChBtiTXljGnjyuoPQwDRfA0goT+Ic+gDdFI31XqiEldaebMNNfIW30OMaJNnIQyihmAxmRY98Znl7LwitGisjSqef0Lcq2UtPTJHyP+f+2slkIvu04CBoklt19omHDLxyAxCOl6fYTXLEyTkBd2uHao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755945273; c=relaxed/simple;
	bh=0/OB5VflSjij8TvXSNLlENtij5iyXwZRqP3qH+cGyNI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OU4CtVrlih1W6ata/lqLxFuwfq9pF/AwcnEMbqjvVyyv0oeuNynR7HjsOS2xiaMu2JZ4x0Fzkc5xhnFccm6m3tBhNtykw0FCI0Jy6Gu38T6DmshCFJOVJC1P+vNKBnEl+dzSk4OHTeOYs9nm4HT7S4h0fQShzFjBl1LTYfRmajg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=HPfAXSxL; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=u5rjwlbx; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1755945077; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=P3RR0lC46OSACTvaVJXq8bs/R+QZ5dx+CN077hsfa1gyc3IHSaI4zM6VK+jWTl3ZML
    LH5KnIjkALxyg1pnoqNtAiZGdGhDHTaRTnXoS1TmeSsujXwFjl0amxPzi+oaoO52uioj
    aeIe1E++hbEG/kkvbFv9oK9EN56CGR8P1aSsVzmU4YMDFVMPms+kE3mNFiHZAAORv4Vt
    yeiAc2McZa5Bju8G9Pn4Sk8Pz56cIrwfQTEnDk/UOomuoNpiAA9tv4k3beuxK7LQujQA
    FTOH0iaR3o/w47LnNTUMdYNjshsFsTs5o/xTTV98tLxJmoEB8ccCl09e3ltrGXaf+1Wr
    Vh+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1755945077;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=0/OB5VflSjij8TvXSNLlENtij5iyXwZRqP3qH+cGyNI=;
    b=HQbzoIzCZ1bg/ri2M3M3y8uTB6zxcpb/36eRYRVD4mXk22So5lTjwQ5jwc8IhB/BqQ
    A36ficBaw23Q083LhK2F7sg1Tx8CnL4rJ1SmBflR4eJ1KJF+tAbsAYXYDnNmUl7fo2eU
    j4fh/Un1CJR+5obdx1oTKibJ3TvXgJKeaPUmOxG4CP6I30WuP50TkTcAl1wYEBpEqcfL
    RqNaEVIk+AO5PUG5MMnao6Fwvtoo+gcrpnsMGHrvmQVwcmuFW+y1MjJLQjS6YMFGSxK5
    Xv91Aszh4dego73hITgIvFnw6RCYAei4y6DBYrcVZdORt4p6FTqo3Y94WBxmbXp5dK0/
    IUQg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755945077;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=0/OB5VflSjij8TvXSNLlENtij5iyXwZRqP3qH+cGyNI=;
    b=HPfAXSxLw1BjlzRITQWeXIYKIA80kNRTT31sqTKzFOHL3jjBwZJvU7eDe4RW6cfGxG
    l9ph/eo0qonOKTttnIDzD4RBTl/iCtU6j5fC9fwcUVI3exFLT8yYk6nIU3iljjiP3n8Y
    WrPQM0CWVh4cvtF3yXu2pT+Q3dlP6Mhkv71XH99aqgCJ/3l5Ne2pK7SdP30Y9+jlpQv5
    ss1dYWjMpElF6a2V8DvjrBrZYmdF2/7CjpbFlNoQQX59Xu0L8hBruc610v2dblwf6xWZ
    H2DQ+eHwpU+AiyVguY742AYdPK8nc2RJiwaSHxd4p9a4RewJHxv6d7JHbL2qUUHMJsho
    oNuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755945077;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=0/OB5VflSjij8TvXSNLlENtij5iyXwZRqP3qH+cGyNI=;
    b=u5rjwlbx14Z7ncL3oBHEv5Q9G7EHTDp4/ajNkKasdOqYnWxaAWtjq+1mHKzVDQY4vV
    d04FwgL/RFNw+dHPlOAw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQ35pZnciHiRbfLxXMND9/QZnI+FEnHoj9hoo="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id Q307a417NAVG8vg
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Sat, 23 Aug 2025 12:31:16 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] power: supply: bq27xxx: fix error return in case of no
 bq27000 hdq battery
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <VI1PR02MB10076D58D8B86F8FB50E59AADF422A@VI1PR02MB10076.eurprd02.prod.outlook.com>
Date: Sat, 23 Aug 2025 12:31:06 +0200
Cc: Sebastian Reichel <sre@kernel.org>,
 =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "letux-kernel@openphoenux.org" <letux-kernel@openphoenux.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kernel@pyra-handheld.com" <kernel@pyra-handheld.com>,
 "andreas@kemnade.info" <andreas@kemnade.info>,
 Hermes Zhang <Hermes.Zhang@axis.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <301AB844-A18F-48D6-9567-04E7C6586AF3@goldelico.com>
References: <bc405a6f782792dc41e01f9ddf9eadca3589fcdc.1753101969.git.hns@goldelico.com>
 <VI1PR02MB10076D58D8B86F8FB50E59AADF422A@VI1PR02MB10076.eurprd02.prod.outlook.com>
To: Jerry Lv <Jerry.Lv@axis.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi Jerry,

> Am 05.08.2025 um 10:53 schrieb Jerry Lv <Jerry.Lv@axis.com>:
>=20
>=20
> But there is no similar check in the bq27xxx_battery_hdq_read() for =
the HDQ/1-wire driver.=20
> Could we do the same check in the bq27xxx_battery_hdq_read(),
> instead of changing the cache.flags manually when the last byte in the =
returned data is 0xFF?
> Or could we just force to set the returned value to "-ENODEV" only =
when the last byte get from bq27xxx_battery_hdq_read() is 0xFF?

I tried to move the 0xff detection to bq27xxx_battery_hdq_read() and =
make it trigger only
for register 0x0a (BQ27XXX_REG_FLAGS), but there are other locations =
where bq27xxx_read()
is called for this register. And those emit error messages in case the =
battery is removed
while user-space is polling.

So I'll post a v2 with two patches (for different bugs):
a) set cache.flags to -ENODEV to fix the -EPERM bug
b) restrict the check for the 0xff condition to the bq27000 to avoid =
false positives for your bq27z561

BR and thanks,
Nikolaus


