Return-Path: <linux-pm+bounces-41920-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAhwDVv3gGmxDQMAu9opvQ
	(envelope-from <linux-pm+bounces-41920-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 20:13:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D612D069C
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 20:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73AC33017248
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 19:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE582F39B9;
	Mon,  2 Feb 2026 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="3Y4wISw7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC02D9499
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059580; cv=none; b=oEXpiFjVRS8U5bu5E3TR0HRGYaQf4zJmPPJagpnTvq5GIK/eFv/Y7dEUBofrY4pYMV8n7eWlk4/qxduLj5WtIkMlzxoHNo9c2kFlQLks9OcgOeXEGPcwk5LKfeZeonXks8ietNiJxTA+qGQLeIQJeG1vhvb/iDGvl3lDYs07CJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059580; c=relaxed/simple;
	bh=jyjqmYf+LsGP41c2GAP0D20VhnppouPXYV8u5gTUsfM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BeLfvuJNQeAmc9T5xxlVppLtEYLpeYpMgRp/ctzL72xMh0NU396lSPVzixX5V1Hl8nG4ydAMhkv2ulb3Vud7mmjAkycUBceCv1zAOdVmnxOdhomHnIDWpbF4hfCVRxldc3/Lvr6HqoGpJ9rcSwzY/Z1k7P53hN9SWdLpnT167Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=3Y4wISw7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-502b0aa36feso596751cf.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 11:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1770059578; x=1770664378; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7uEx9VgfdjgwYROqUMQFza98mDrih8nCYBKA+muYRBQ=;
        b=3Y4wISw7dK4gRqnXU+ngrPXZuCtqmiXcRlbEW/VgMN6RrGUb6G85pLzG5aCN4J8q0g
         H0DJQFtcPPmiv78iMHwRNu0WLKRaVreay+dIgbfWMwhydOtao66dD/dWcbCXCHkk85Ol
         kNdiE2rtFPa4PX6dKoYP0BegFpEA+g0xJ14m6nvKa2acjpE45pis7fcuXpp2tc606nFa
         ZNuUiMS3t0gl8mMORH7ECVqwz2CB08V+BPmvKmWYmIG3IJEsUxAu8AGhhrA9jq1e86Ka
         nIkX/ODV6HrivSveVt7l/QFdtLqt6bVSu/Pf3WFpRuScbHkEdKnY/PQRfnWJsA8qveEz
         5mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770059578; x=1770664378;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uEx9VgfdjgwYROqUMQFza98mDrih8nCYBKA+muYRBQ=;
        b=QRmxc/XIozLKDyXiNHVX0zv1qOo6WxRuSGkS9qYeLrgLaeFrXKN2w+pj9D/gZ3WLoy
         XK4xVWtkbtDJzrnD4/nicw50loilGtRanmT6NSlHho7xBEh0whdBBKEzUjr1qwxW8iJo
         HlVIOFA36yrDmx7Hhflj8ZrhVucOCqU1i+m6vCjU1vYEb4fnQN7YDIrpOa3WvY4IV0p0
         nzl32Tlg5aAyBYNU3RPW6Q6l0TWGjlaryCrGKtCtx3adIJd9pRVCYYG1+gm9HiQt9D0m
         mRusu17O16+Gp5AH/Aymb4H3afDYlkleXaaWfFD0gKMXOJ6xW14jR2csY57yE4EbzomV
         9hPw==
X-Forwarded-Encrypted: i=1; AJvYcCUfGGzbxLI5lqlt6xZ/rebimtmadG9tdxUG6Mkjv4HPvh8h/HEXXTBAb1D1jgK+vbwKJiavpHTKVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1eGMkpvUaRcXn8a5kXW10kNaeFzj3wn27zR49W8T4ZYhE3Fi2
	twPG0rBTWcH3aU81dUdOVpy69IPlUJ9CIbBXJdfR40tW+f3GDfZ5WNCJ1R/eFKKHqg4=
X-Gm-Gg: AZuq6aJz1+BFIjC6ZLkLhpAoAvPc70/dgV1O22UolxMrWUERtZIICwMnlKGi6wdXbmm
	KNQw3Z/B9Sbnbu7HDEJ0m5w5Ye6GYrQgHBeFv4JQBRotnw59BKJvBqHDkVKgpppnKn9nJcnwDUC
	J+Z2gt6Abfz/1TqVGzKUb9XfB0SWTisX1Wj+9DIjcw2oOlcy4JQJcFbDf2lkx0pjm/uzsr3FdBI
	PpgUvhVl4bYqQvZIhErSNdYBVrr8AKdJ65o5zuu/jyk2iUzWvxYmd879ZRuvxMMNIe4noc2Qvkt
	XCUENlWx3hKxdSiqgWgRw0dIKItJwNS+MEojKteiu4aUs5rx+WQxvXHA2XLahclveXRwIuoVh0W
	ISmjcqMrtfFbhyk3K1TdIzzJ/z+N08eMY/rqtVgYWnF70GDlIgdukUiSFn+rK0uZFZ+mqgPsZ6d
	C4wex3SOi0Nj3SxjLv
X-Received: by 2002:ac8:5fd6:0:b0:4ed:70d7:aa5a with SMTP id d75a77b69052e-506092c7e40mr6181511cf.25.1770059578134;
        Mon, 02 Feb 2026 11:12:58 -0800 (PST)
Received: from ?IPv6:2606:6d00:15:210e::5ac? ([2606:6d00:15:210e::5ac])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337ba3997sm110411631cf.17.2026.02.02.11.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 11:12:56 -0800 (PST)
Message-ID: <5e3431c69da07557edb20a252c4759be8c857f08.camel@ndufresne.ca>
Subject: Re: [PATCH] arm64: dts: imx8mq: Restore VPU G2 clock to 600MHz for
 4K60fps decoding
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>, linux-media@vger.kernel.org
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, 
	benjamin.gaignard@collabora.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de,
 sebastian.fricke@collabora.com, 	shawnguo@kernel.org,
 ulf.hansson@linaro.org, s.hauer@pengutronix.de, 	kernel@pengutronix.de,
 festevam@gmail.com, linux-imx@nxp.com, 	l.stach@pengutronix.de,
 Frank.li@nxp.com, peng.fan@nxp.com, eagle.zhou@nxp.com, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Mon, 02 Feb 2026 14:12:54 -0500
In-Reply-To: <169eba79e8e1f906b1a0b59e22a531dfc7e57a1f.camel@ndufresne.ca>
References: <20260130084133.2159-1-ming.qian@oss.nxp.com>
		 <df8d5d5f28870752e77ec74f34fea7ceb6e97286.camel@ndufresne.ca>
		 <0b24716b-438c-4185-8a93-3a3879147c24@oss.nxp.com>
	 <169eba79e8e1f906b1a0b59e22a531dfc7e57a1f.camel@ndufresne.ca>
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
	protocol="application/pgp-signature"; boundary="=-LAOjFPzcyPbpnKVdmA5V"
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[ndufresne.ca : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41920-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[kernel.org,xs4all.nl,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ndufresne-ca.20230601.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas@ndufresne.ca,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ndufresne-ca.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ndufresne.ca:mid]
X-Rspamd-Queue-Id: 8D612D069C
X-Rspamd-Action: no action


--=-LAOjFPzcyPbpnKVdmA5V
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 02 f=C3=A9vrier 2026 =C3=A0 13:44 -0500, Nicolas Dufresne a =C3=A9=
crit=C2=A0:
> > This doesn't sound like just a VPU issue; it's related to the display o=
r=20
> > DDR.
> > If not displayed, do the fluster test cases yield different results at=
=20
> > 600MHz and 300MHz?
>=20
> Didn't you run these tests before sending ? I can try again, but in my
> internal
> notes, I wrote:
>=20
> =C2=A0 > Tested that, and everything becomes unstable
>=20
> That was before I figure-out the IRQ handler didn't handle exception bits=
 that
> didn't stop the decoder (or dry IRQ, which strangely is common from the G=
2).

Ran some fluster tests now. With this patch the results is not consistent
anymore. Then I ran it with weston being started, and in the middle of the =
test
the display turned black. Matches my past observation. We did reproduce thi=
s on
BSP kernel too. When the display goes black, the recent hantro drivers repo=
rts:

[  827.581586] hantro-vpu 38310000.video-codec: frame decode timed out.
[  827.720201] hantro-vpu 38310000.video-codec: not all macroblocks were
decoded.


I have local patches to reduce the cascade of errors, so it likely survived
longer then last time. I will send these patches soon. The "not all macrobl=
ocks
were decoded." is triggered by a bit in the status register that is not
documented in NXP TRM. I found that bit in some VC8000D documentation (the
sucessor of G2). I concluded it was the same meaning after looking at the f=
ailed
buffer visually, it is indeed missing couple of macroblocks near th end. Ea=
ch
time we see this error, the DCSS gives up and turn either black, or sometim=
es
other color. The second case has been tracked to a DCSS Scaler underrun, th=
e
first we don't know.

Fluster command ran (two threads, never completes):

./fluster.py run -d GStreamer-H.265-V4L2SL-Gst1.0 -ts JCT-VC-HEVC_V1 -j2 -t=
90

Nicolas

--=-LAOjFPzcyPbpnKVdmA5V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaYD3NgAKCRDZQZRRKWBy
9IfHAP4rQUDUDbBIhNcS34h3qHt/x8THSc1WpgWBmUlwFmTckgEAs9XuoGSBAa2w
7zD1Mvo6hkReZD5SmiJWAnGAjRbhvQ4=
=BWBL
-----END PGP SIGNATURE-----

--=-LAOjFPzcyPbpnKVdmA5V--

