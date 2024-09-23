Return-Path: <linux-pm+bounces-14570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6B097EC10
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 15:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4261C21390
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755EE198846;
	Mon, 23 Sep 2024 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="danD9/M0"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6608E13B7BD
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727097136; cv=none; b=R8fkBPSoapFp59OpaJZpLqbPXuR8nC8xWtn488TIqMfVRsxsqGn6zrJoCMf+Gw5MuXeKgEvwHI0h5YkII68mRWoZjdx/z5HRGzn79KdI0x+NXUDlJDDHiDHrLU5q7D6ITkyWLmlrCrvDY6EPQ11CbEv5PUKuCGhv3dM9RLpiED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727097136; c=relaxed/simple;
	bh=SJIzmdHJpH/fbfEtC3KDt9Sex2b18qIxyMo9n9RsHQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXlHO863nDXH53Um2rMtd753TkVsz3iMS/k1d5HLi/AUkjddAq3YgNYYHwh3TL8BAvMOk+8+EglHh5Xx3d2jeO2elVjudTxgjP503hE2ULHGKUgv26UZM8zVcemM7XwUJ/91qoBmyokGN8sKC0AZr50UgbjId56Y8+vaPBdpRWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=danD9/M0; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 3100F2E09373
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 16:12:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727097121;
	bh=SJIzmdHJpH/fbfEtC3KDt9Sex2b18qIxyMo9n9RsHQk=;
	h=Received:From:Subject:To;
	b=danD9/M0pLlTn3DaNbZx2c6als9HSMUN8pyOMY0/Sy3/JY2+kknY+nr7v6uRnfCKP
	 OPEkv4QAkt9hRlKBdRVoTFrTj/I6WGhnOqaVGrm6KK2QlO/D+4QsuPP7HZ9cOu2tVf
	 MST+m8cK+YxbQbxh2lUP1Iblq/ZbS4JMTzxaGi74=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.171) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f171.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-2f761cfa5e6so43734431fa.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 06:12:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW2t1Xt9PGpvOQFG3sSy0/j87PKZeVZH3NI8WK2hwDuk1OUpWRYOJwmdpMow29c23hJxY6FFwglnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHQUC4Yg3x9Vv/Dbf6Zxvr1PtzD+f6H892Y7AlsUTIxqMkLMeu
	dm8PBmMkOfFvFEFACboEK6pfO3bYtsM9m8wFUts/BvMYQ8xlI2iWR+Btp1e7WqdDvW0AvSLVt37
	hZS52PJPTFbfmSNtpCYDvUJWQUNA=
X-Google-Smtp-Source: 
 AGHT+IHqsvwJDWGEKrXzZ8xqYffThQxo5weKZgc11kYePXJfEya7oF6xo6BQQ/tnY/ashTMWDU7t8ttC5nad6J+cYyU=
X-Received: by 2002:a2e:9fca:0:b0:2f7:77ff:d739 with SMTP id
 38308e7fff4ca-2f7cb2fc01cmr43099621fa.26.1727097120351; Mon, 23 Sep 2024
 06:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: 
 <CAGwozwHqHbHNi53T87m36-OZ8suCEo1wgJ9fPPgPdcLnt_+S4g@mail.gmail.com>
 <20240923013657.7464-1-derekjohn.clark@gmail.com>
 <CAGwozwHmS-XjhzYayNvT07vesw4eOBh+ZjWi_NDa4xsOangYDQ@mail.gmail.com>
 <b43f9654-4dd7-4f3c-95b5-575473c3bcc1@app.fastmail.com>
In-Reply-To: <b43f9654-4dd7-4f3c-95b5-575473c3bcc1@app.fastmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 23 Sep 2024 15:11:48 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwE_MXuqreQvDFyVyodrzH5HFB=Nab9LfxD9DMB+HGkt3Q@mail.gmail.com>
Message-ID: 
 <CAGwozwE_MXuqreQvDFyVyodrzH5HFB=Nab9LfxD9DMB+HGkt3Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls
 outside suspend (fixes ROG Ally suspend)
To: Luke Jones <luke@ljones.dev>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>, me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <172709712175.25933.17249161034798822277@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Luke,

> What Derek is saying here is correct because it is based on data I have s=
hared with him for testing to help ASUS engineers fix the root issue in fir=
mware.

Would be nice to back it up. Indeed, right now on the X i am facing an
issue that Windows also has (see below), so it is not like Asus do not
have their work cut out for them. I would have to test the new
firmware and get back to you.

> I have direct contact with engineers in ASUS and I am under NDA (extended=
 to a few others) so certain information can not be shared. The proper fix =
for Linux is done in the MCU firmware - this is something ASUS engineers wh=
o work on the Ally devices have done with our aid in pinpointing the exact =
cause.

The proper fix for _Asus_. I need to support a lot of manufacturers
and a lot of them use these _DSMs, so we need to get a better ordering
here.

> Denis was very clear I thought, perhaps you misread? Thank you for your t=
horough testing Denis.

Uh, Denis is never very clear unfortunately. From what I understood he
hit the reboot bug once. But I could not get a feel for what his issue
was. I know on V1, the XInput controller did not suspend properly.

> It isn't about trying to suspend the thing "quickly enough". And I'm hopi=
ng that with your analysing of that statement it provides you some insight =
as to why it's a bad assumption to make and why things are always going to =
be at risk of breaking with async linux suspend when you get another device=
 like the Ally. At best the issue may be masked only to have seemingly rand=
om fails that people can't reproduce easily.

If you look into my patch series, you will see that unlike the
variants you tried, there is no async within it. The calls and the
delay are inserted before beginning the suspend sequence (which is
async). I think this is a good compromise and can be blended with
userspace going down, so it will not increase suspend delay in the
long run for devices that need a quirk. For the Ally X, even without a
delay, the controller always comes back online. Seems that it is the
case on the original Ally as well. With a caveat.

That caveat has to do with the delay before suspend. If it is too
little, the OG Ally XInput MCU does not turn off and the Ally X MCU
loses its state. For the OG Ally, I guess Denis informed you about it.
For the Ally X, this manifests itself as the MCU rebooting once when
it receives the first command after suspend. When powersave is off,
this happens when there is no delay, when it is on, it always happens.

I can reproduce this bug on windows very easily right now too.

It is a small nit that can go unnoticed though. So hopefully you can
test the new firmware (with whatever kernel you want) and report back.

Hopefully you are right and it was a timing check and that timing
check also fixes this.

> It is perhaps best if I refer to what Denis and Derek told you about mode=
rn standby: focus on background downloads and proceed in that direction - t=
he firmware really does fix the suspend/resume/reboot issues. You can also =
drop the asus-wmi patch (in submissions) as that will get dealt with soon e=
nough.

Indeed. I am the one with the problem here. I have too many Ally users
and for me to require them to update their firmware right now (for
basic functionality) is a non-starter. Which is why I was happy kind
of keeping this patch to myself.

I personally do not have a problem with making the next variant of
this patch an RFC. But currently I think it has a good scope, so I
would like to ask what other kernel maintainers think.
Also, after we do a bit more testing on the OG Ally, if everything
goes well, my version of the quirk is expected to have better behavior
than the asus-wmi, so I do not see a reason in refactoring that,
unless that refactoring ends in it completely removed. There is still
the issue of old users in this case though.

Antheas

