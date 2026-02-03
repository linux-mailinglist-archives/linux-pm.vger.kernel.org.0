Return-Path: <linux-pm+bounces-41979-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B0qORsXgmkDPQMAu9opvQ
	(envelope-from <linux-pm+bounces-41979-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 16:41:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A11DB651
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 16:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64C1230164BF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 15:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528193B95FF;
	Tue,  3 Feb 2026 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="SKicUJXV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3D03B8D42
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133259; cv=none; b=lYnmiZEn8aZtzHaTglO/Jcud+6Hl4ZF5jLq2XjBgxu+GcvOdetuO8aUNus7em5K/WoPIAj61kLN60ldCIpCIpTFOn5VEFVlngefEvcxUZeI4IgXns5pqzeDpD3Nf740d7aYhFlG0IViCGk4BbL+Qge3kSINDHw8oyCGe18qYcZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133259; c=relaxed/simple;
	bh=2GolLxBI7M4FrQQ01gPdYp9MHSke1dJvpw9m0JW/AlM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MxxEy1WFVjwjfegym1KVyBUfwpJqC2F7LyL+FcHDAv4FSfdF+AuCVjhOPbDMYER165BGp2dIs3mdE++CDEEcC4tAV8NfYIXzbk8p3/eR4J8jCFZVbFgFmTCBvoOAo04WVOkQU44WVmQc5QF2mbO+RhNt7mbx3bsO1mhyL+WduDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=SKicUJXV; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c655e0ee70so620569785a.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 07:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1770133256; x=1770738056; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2GolLxBI7M4FrQQ01gPdYp9MHSke1dJvpw9m0JW/AlM=;
        b=SKicUJXVbyCi+jh+7oHFUk9zdm8/7Ov6NfLvUOnUq5LOK5g9LOdJjfalN+c7I9nYmB
         Y27eWjoehA9uUl9dAbfEP6iySAzXrw9UdxroDEkKJo1HILQdZfVhz1SI/K4GndntPfOj
         jInQXwDYS3jbqzkrIQQoELOnRavoi5ikmSWcuRGX2AjYl+hauZc5IBT6+hFqBta7hL0z
         n3zNVX4nhIhX1Ai2/V8df/NrUoNZTb1y9rzI4CdT9raUxtKbciKmkjTmD4rTDsvyHs2r
         FoFZwRwH7fIxnh4JyIpPyu+U1H7ZNIpsOSCqRI1L+su8+ZEzeSxS0psd03MXG4+/XWAi
         xH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770133256; x=1770738056;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GolLxBI7M4FrQQ01gPdYp9MHSke1dJvpw9m0JW/AlM=;
        b=vqtSabl4o0Kbf2R0xtJFBJNHl2kAHVgvxp2/vfx0nfeXIJndMA3MMOgXxYn0++apvz
         OXjCW/FLgMwcNP4tXZaDYO/TxLTY6PSbL6vmBJzEax20iwd9my3icetsIAAs1ydHR+fA
         ahjsfGu3LAAO1gJdaZFSKUoULNTIuVedTVkK4WAajYRW29apBU0II/1yZd+fYdIgmuX3
         PGK7Q6kXNFJQtkNa26szgyEN/uGKdsoVv5exIlMLbrPJSG754l9zXNl+NL5ZZW5nv6q1
         IjDnbNQ9NOB71Vsa1nn74uhoXibcdCfxJPu01NtdWQnaK8c//bjr0YmJ0Y3Mm8Zr+Ted
         D/+w==
X-Forwarded-Encrypted: i=1; AJvYcCWGPP6aX4cmB3L6vTmfEf1q3E6r9HJCE+TwR4u5c+Us9EwSSS8nv9yjKGjcKpbSct1oDWPXFDELgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOGSOF6iQ4Gaa1nBebRc2EGqY4L2SlVJW6LXDPu5jy+eLGsamT
	3TfBxJ160U1W8IgS7XcDS/Nnp/yU1HYJ/nFMVwlfSSHqP4Jl7NOaIQGHfwziZbbDOzQ=
X-Gm-Gg: AZuq6aKLfB9UtAzkNaOME5D+N5z1DOuW28+SVJI4vnBd03BrCLj3IYRBc9u32iNN11d
	6rVBLVjOnHspB2IPF3eguKWs4XXNJP9BNu/deL2i7CF80ssUxTc9s+sGqFILGGRA6H89ZWELqrh
	etlzyZm0JcrN/aJ5jkMGKlVczZ5BvrfSTh2qtbGZUt9vSf2LL7iTwf5pRGoebrG4BCkNOLsvbc6
	u8Wp3O6pC4cgnvYjkGA3496mBXJgfGJgK8c8YBwUFKdOp7a89TNg+wrMp+eaZxWpuYhCMATjnrk
	j1Ivz8RmZrfGxZWkFe7DLHnjYoOOLSX1S+FsEon/CqmJI/qvl2rMU8uMmETtkfaS1DCTgEd3e8x
	kRtIAj/Gndk5rYvZhzeXiwCBltGyebEwf6wzvvh04XrXzAZ8Xj9ahK5D3fLPbLR/qTp9EN8ETDy
	PA5kRdSFUQJz+9fmKy3B2C0aej7rw=
X-Received: by 2002:a05:620a:7105:b0:8c6:d2ca:1d0e with SMTP id af79cd13be357-8c9eb2584c3mr2033310985a.11.1770133256006;
        Tue, 03 Feb 2026 07:40:56 -0800 (PST)
Received: from ?IPv6:2606:6d00:15:210e::5ac? ([2606:6d00:15:210e::5ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711ba6c58sm1610151685a.23.2026.02.03.07.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 07:40:55 -0800 (PST)
Message-ID: <db9016a39f612cc93ee070c1eba4e4471a89a5cd.camel@ndufresne.ca>
Subject: Re: [PATCH] arm64: dts: imx8mq: Restore VPU G2 clock to 600MHz for
 4K60fps decoding
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>, Marco Felsch
	 <m.felsch@pengutronix.de>
Cc: linux-media@vger.kernel.org, imx@lists.linux.dev,
 ulf.hansson@linaro.org, 	Frank.li@nxp.com, peng.fan@nxp.com,
 festevam@gmail.com, robh@kernel.org, 	benjamin.gaignard@collabora.com,
 sebastian.fricke@collabora.com, 	linux-imx@nxp.com,
 devicetree@vger.kernel.org, conor+dt@kernel.org, 	p.zabel@pengutronix.de,
 linux-pm@vger.kernel.org, s.hauer@pengutronix.de, 	mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, eagle.zhou@nxp.com, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 hverkuil-cisco@xs4all.nl, 	krzk+dt@kernel.org, shawnguo@kernel.org,
 l.stach@pengutronix.de
Date: Tue, 03 Feb 2026 10:40:52 -0500
In-Reply-To: <cd07dc6e-1f19-4a59-8ee5-81a36d51bf1c@oss.nxp.com>
References: <20260130084133.2159-1-ming.qian@oss.nxp.com>
	 <df8d5d5f28870752e77ec74f34fea7ceb6e97286.camel@ndufresne.ca>
	 <0b24716b-438c-4185-8a93-3a3879147c24@oss.nxp.com>
	 <169eba79e8e1f906b1a0b59e22a531dfc7e57a1f.camel@ndufresne.ca>
	 <5e3431c69da07557edb20a252c4759be8c857f08.camel@ndufresne.ca>
	 <ca3a8042-1394-4925-9c61-dbfcbf4cf7d9@oss.nxp.com>
	 <20260203083110.woan3gmc3qdh7nmm@pengutronix.de>
	 <cd07dc6e-1f19-4a59-8ee5-81a36d51bf1c@oss.nxp.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-okkgKqsgZ+IV64MKbOhB"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ndufresne-ca.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[ndufresne.ca : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linaro.org,nxp.com,gmail.com,kernel.org,collabora.com,pengutronix.de,lists.infradead.org,xs4all.nl];
	DKIM_TRACE(0.00)[ndufresne-ca.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41979-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas@ndufresne.ca,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,aka.ms:url]
X-Rspamd-Queue-Id: 54A11DB651
X-Rspamd-Action: no action


--=-okkgKqsgZ+IV64MKbOhB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 03 f=C3=A9vrier 2026 =C3=A0 16:53 +0800, Ming Qian(OSS) a =C3=A9cr=
it=C2=A0:
> Hi Marco,
>=20
> On 2/3/2026 4:31 PM, Marco Felsch wrote:
> > [You don't often get email from m.felsch@pengutronix.de. Learn why this=
 is important at https://aka.ms/LearnAboutSenderIdentification=C2=A0]
> >=20
> > Hi,
> >=20
> > sorry for jumping in.
> >=20
> > On 26-02-03, Ming Qian(OSS) wrote:
> > > Hi Nicolas,
> > >=20
> > > On 2/3/2026 3:12 AM, Nicolas Dufresne wrote:
> > > > Hi,
> > > >=20
> > > > Le lundi 02 f=C3=A9vrier 2026 =C3=A0 13:44 -0500, Nicolas Dufresne =
a =C3=A9crit :
> > > > > > This doesn't sound like just a VPU issue; it's related to the d=
isplay or
> > > > > > DDR.
> > > > > > If not displayed, do the fluster test cases yield different res=
ults at
> > > > > > 600MHz and 300MHz?
> > > > >=20
> > > > > Didn't you run these tests before sending ? I can try again, but =
in my
> > > > > internal
> > > > > notes, I wrote:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 > Tested that, and everything becomes unstable
> > > > >=20
> > > > > That was before I figure-out the IRQ handler didn't handle except=
ion bits that
> > > > > didn't stop the decoder (or dry IRQ, which strangely is common fr=
om the G2).
> > > >=20
> > > > Ran some fluster tests now. With this patch the results is not cons=
istent
> > > > anymore. Then I ran it with weston being started, and in the middle=
 of the test
> > > > the display turned black. Matches my past observation. We did repro=
duce this on
> > > > BSP kernel too. When the display goes black, the recent hantro driv=
ers reports:
> > > >=20
> > > > [=C2=A0 827.581586] hantro-vpu 38310000.video-codec: frame decode t=
imed out.
> > > > [=C2=A0 827.720201] hantro-vpu 38310000.video-codec: not all macrob=
locks were
> > > > decoded.
> > > >=20
> > > >=20
> > > > I have local patches to reduce the cascade of errors, so it likely =
survived
> > > > longer then last time. I will send these patches soon. The "not all=
 macroblocks
> > > > were decoded." is triggered by a bit in the status register that is=
 not
> > > > documented in NXP TRM. I found that bit in some VC8000D documentati=
on (the
> > > > sucessor of G2). I concluded it was the same meaning after looking =
at the failed
> > > > buffer visually, it is indeed missing couple of macroblocks near th=
 end. Each
> > > > time we see this error, the DCSS gives up and turn either black, or=
 sometimes
> > > > other color. The second case has been tracked to a DCSS Scaler unde=
rrun, the
> > > > first we don't know.
> > > >=20
> > > > Fluster command ran (two threads, never completes):
> > > >=20
> > > > ./fluster.py run -d GStreamer-H.265-V4L2SL-Gst1.0 -ts JCT-VC-HEVC_V=
1 -j2 -t90
> > > >=20
> > > > Nicolas
> > >=20
> > > My test results for fluster differ from yours.
> > > On my end, the results for JCT-VC-HEVC_V1 are consistent at both 300M=
Hz and
> > > 600MHz.
> > > And results remained unchanged after multiple tests.

After more testing, the fluster test is stable for NV12/NV15 tiled output f=
or me
too. I'm running the tests with linear NV12/P010, which imply an extra set =
of
buffer. I will check if I can give you a easy way to test the linear format=
s. I
also have couple of streams that systematically breaks at specific spot (hi=
gh
complexity scenes) with the provided patch. As most licensed content, this =
is
not sharable as-is. I will try and see if I can find a way to share somethi=
ng.

> > >=20
> > > I'm not sure what caused the differences between us.
> >=20
> > Once it comes to system stability, you need to ensure that your
> > bootstack is aligned e.g. same TF-A version and sometimes same
> > bootloader since there might be workarounds/erratum applied by the boot
> > firmware.
> >=20
> > Regards,
> > =C2=A0=C2=A0 Marco
> >=20
>=20
> Thanks for the reminder, and I agree.
> I think we need to align our board environment first.

I do likely have slightly different bootchain, and of course all the HDMI
component are downstream, but I can't really isolate the dramatic issue of =
this
overclock without a display component of some sort. Its a huge differentiat=
or in
the bandwidth consumption which is the main challenge on this SoC so far. 1=
0bit
videos makes things a lot worse fwiw.

We did review latest IMX vendor firmware package and can confirm we are run=
ning
the latest memory training blob and HDMI firmware.

Nicolas

> Regards,
> Ming
>=20
> > >=20
> > > Below are my test results:
> > >=20
> > > 600Mhz, 0.9v
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cat /sys/kernel/debug/regulator/=
regulator_summary=C2=A0 |grep SW1C
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SW1C=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 unknown=C2=A0=C2=A0 90=
0mV=C2=A0=C2=A0=C2=A0=C2=A0 0mA
> > > 825mV=C2=A0 1100mV
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cat /sys/kernel/debug/clk/vpu_g2=
/clk_rate
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 600000000
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ./fluster.py run -ts JCT-VC-HEVC=
_V1 -d GStreamer-H.265-V4L2SL-Gst1.0 -j2 -t
> > > 90
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ********************************=
********************************************************************
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Running test suite JCT-VC-HEVC_V=
1 with decoder
> > > GStreamer-H.265-V4L2SL-Gst1.0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Using 2 parallel job(s)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ********************************=
********************************************************************
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ran 139/147 tests successfully=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 in 505.434 secs
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ran 139/147 tests successfully=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 in 505.350 secs
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ran 139/147 tests successfully=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 in 507.540 secs
> > >=20
> > > 600Mhz, 1.0v
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cat /sys/kernel/debug/regulator/=
regulator_summary=C2=A0 |grep SW1C
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SW1C=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 unknown=C2=A0 1000mV=
=C2=A0=C2=A0=C2=A0=C2=A0 0mA
> > > 825mV=C2=A0 1100mV
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cat /sys/kernel/debug/clk/vpu_g2=
/clk_rate
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 600000000
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ./fluster.py run -ts JCT-VC-HEVC=
_V1 -d GStreamer-H.265-V4L2SL-Gst1.0 -j2 -t
> > > 90
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ran 139/147 tests successfully=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 in 506.901 secs
> > >=20
> > > 300Mhz, 0.9v
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cat /sys/kernel/debug/regulator/=
regulator_summary=C2=A0 |grep SW1C
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SW1C=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 unknown=C2=A0=C2=A0 90=
0mV=C2=A0=C2=A0=C2=A0=C2=A0 0mA
> > > 825mV=C2=A0 1100mV
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cat /sys/kernel/debug/clk/vpu_g2=
/clk_rate
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 300000000
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ./fluster.py run -ts JCT-VC-HEVC=
_V1 -d GStreamer-H.265-V4L2SL-Gst1.0 -j2 -t
> > > 90
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ran 139/147 tests successfully=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 in 506.063 secs
> > >=20
> > > Downstream v4l2 driver
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cat /sys/kernel/debug/regulator/=
regulator_summary=C2=A0 |grep SW1C
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SW1C=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
=C2=A0=C2=A0=C2=A0 2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 unknown=C2=A0 1000mV=
=C2=A0=C2=A0=C2=A0=C2=A0 0mA
> > > 825mV=C2=A0 1100mV
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cat /sys/kernel/debug/clk/vpu_g2=
/clk_rate
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 600000000
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ./fluster.py run -ts JCT-VC-HEVC=
_V1 -d GStreamer-H.265-V4L2-Gst1.0 -j2 -t
> > > 90
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ran 136/147 tests successfully=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 in 460.435 secs
> > >=20
> > > Regards,
> > > Ming
> > >=20
> > >=20
> >=20
> > --
> > #gernperDu
> > #CallMeByMyFirstName
> >=20
> > Pengutronix e.K.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > Steuerwalder Str. 21=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | https://www.pengutronix.de/=C2=A0|
> > 31137 Hildesheim, Germany=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Phone: +49-5121=
-206917-0=C2=A0=C2=A0=C2=A0 |
> > Amtsgericht Hildesheim, HRA 2686=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | Fax:=C2=A0=C2=A0 +49-5121-206917-9=C2=A0=C2=A0=C2=
=A0 |

--=-okkgKqsgZ+IV64MKbOhB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaYIXBQAKCRDZQZRRKWBy
9BdEAP91RCuQpeIs8WIAVqMpbGlTfJSJeLeq5HmQ5J1hZGuwXwD/WVhjnKNga4Pq
kYR1FIhai0zcA1k4q9wESua75qp+hQM=
=GTde
-----END PGP SIGNATURE-----

--=-okkgKqsgZ+IV64MKbOhB--

