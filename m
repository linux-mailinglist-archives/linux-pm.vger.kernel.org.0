Return-Path: <linux-pm+bounces-41919-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iVqnMX/xgGk/DQMAu9opvQ
	(envelope-from <linux-pm+bounces-41919-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 19:48:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB64D04D3
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 19:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13C7A304DCB6
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 18:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6458376473;
	Mon,  2 Feb 2026 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="Nfk/Cd0d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD30199252
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770057875; cv=none; b=KriOYA7C5UFpPklbVOundHc196T8DB14DbT+Us3Zh/l1O8808OdPwWrPM3+wRIjb2be0hFUZE86x8YvA2cbiZfuMhLBxYzvVZ1q/Zvc2JAv91OFRaM6MeCVwYLsgOXdKk8rCD4XD05ZMEPweD3JfP2Jqd3YN7WhorSUborCAIUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770057875; c=relaxed/simple;
	bh=WYQiIExxKDX0cCt2DTvo3Yevcg7P9+CnoNuVKvWhxaw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U9g56GCl+jaHQ87TIXbIrDC5tfTdxTFPM6RgtpRfz7021k+elp63Y+pNA+wZh6t7jYlgByrSuulJJlKudycjwEsALyqGVNVGMA3Gan6u6yZex6xh6VQToAQCqfXRPUcJ0pMwFZIPIG4jMA053/thBw2JtddDiwrkWLqw1vaHCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=Nfk/Cd0d; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88888c41a13so61483206d6.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 10:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1770057871; x=1770662671; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fXE7ald5tcjEzZ48f0b2jZkl5LlJhCx6n0+to2+iB3E=;
        b=Nfk/Cd0dbdg4xT2MrpmJU/ayp/sIu8FQAxyVl4r4zDYYIb50KIPEFyvJ1ukyIh+QPh
         z/Wo+X4OxLEzJcb57t+8ql30bSz0bKwHdv40ZFx227PPM2MyY/gzVPp/8jyDe3z6JGKY
         jUFcSUSvZPuiOHDZ8l6RoVvJJ2FR1TI+phC7tDZGRmq2W6zmVXsyNeXNXNBXyxf5rIZq
         Zv/OfPo0GGLPd+pT3GQt5G6naN3OIa/D6oX1pSPOLQuMu6053FQrMXii5ZSNLZFhZ24H
         EQ8pKwDBorf+FKWmxmnuLzPk/DfntPT+SxigR5UDK7uFima7LUVAhRZDjWf7Be5USe+I
         ON3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770057871; x=1770662671;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXE7ald5tcjEzZ48f0b2jZkl5LlJhCx6n0+to2+iB3E=;
        b=upIslhxZLsD9BVOFjw3hhE63APTfFJXO5YqCqfG4F92g19RxQqlHSOuTJzK+1VsGvI
         x6GHaCRgU87nb2GI5wQb0W2P2FwaJccmQA+haz96EDIvilqhk4cfMPTtlLrYB41JtKrr
         IKPBdOw/aqbPhqOKu966zR/sY+0p9iYopOGtyX3CIpOTaUEoSg8Aym5Ted1h9ETroAbV
         boUgplSF2bs7WSg1ekKTkYMp9Cb/qNSO/voHOtUfYSGhyLS7dBhfC0tW00S/iTJQIY6C
         fAxwaWYlkPMfmSF+gzpyZJEzPADQXxvVDbT58WDlq5hb5RwnWydOe7G1I74pAgImlKYb
         tQhA==
X-Forwarded-Encrypted: i=1; AJvYcCWMfTAZWW4NcV3NQrbLLt9wfNxHywaCoFirVBvKL813IloZV5g/kaNxk1RjIF3Advjs0ctEnWx0Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeOICEiOeF56RLTcP3mCyHRHhoMImXe0BeSGurtxy6XikDl0si
	2bL2HX2W3rrXrYIAl91PlF/RTOW8FBZz51BECoN3pDHxv3oAdSKmSD6VWcTnroQlPIU=
X-Gm-Gg: AZuq6aLB5dnT8Q/8MVt4W5KkzUOK8rMyHg2S9nCLEcwUYHAL7IO2zvKadkG5z4amUld
	1TlFuJzwUDCmcPXkp5xmxi5ndZ9qE6fxz/kLJmikNvTxknwIaHMWJAGXQSeTrrv1a3E7quswhnp
	eGBXBOMqzjjRlmatzt4Lu18XG7qVPpgK5al9WDqsKyeUCaMSnw6mjRlUQqLznz8V6d9ADhRzxqz
	Edxo3C9ZZqng1MK+++Ng1aXk3R8fv9gH7+PV3r8am6BB7RvqABnMwU0Kl0g6QWb/Bj+skk12wdW
	GU4K9VdFRnUT3J74UfhEfXNctvLXk5WMSz1INo7J6cZ8jCBCARhlIrvjGshxd/yj2pQZCxZ64Gg
	khMBvDCVi4Jei5okUBu0Ppd1CUvhAjpoFfkJwc6KHj+q9IA/1+Li8MjZsIOIx+msC1cGTW0N+mv
	A8cUtlp8IOZtUOndqn
X-Received: by 2002:a05:6214:c42:b0:894:46d9:53f7 with SMTP id 6a1803df08f44-894e9f27762mr178804396d6.12.1770057871331;
        Mon, 02 Feb 2026 10:44:31 -0800 (PST)
Received: from ?IPv6:2606:6d00:15:210e::5ac? ([2606:6d00:15:210e::5ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3740e62sm119882596d6.26.2026.02.02.10.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:44:30 -0800 (PST)
Message-ID: <169eba79e8e1f906b1a0b59e22a531dfc7e57a1f.camel@ndufresne.ca>
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
Date: Mon, 02 Feb 2026 13:44:28 -0500
In-Reply-To: <0b24716b-438c-4185-8a93-3a3879147c24@oss.nxp.com>
References: <20260130084133.2159-1-ming.qian@oss.nxp.com>
	 <df8d5d5f28870752e77ec74f34fea7ceb6e97286.camel@ndufresne.ca>
	 <0b24716b-438c-4185-8a93-3a3879147c24@oss.nxp.com>
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
	protocol="application/pgp-signature"; boundary="=-VlA8ZcxnzX2eUS2/dkES"
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[ndufresne.ca : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[kernel.org,xs4all.nl,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-41919-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ndufresne-ca.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas@ndufresne.ca,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_PROHIBIT(0.00)[0.0.0.6:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ndufresne.ca:mid,ndufresne-ca.20230601.gappssmtp.com:dkim,60fps:email,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FB64D04D3
X-Rspamd-Action: no action


--=-VlA8ZcxnzX2eUS2/dkES
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 02 f=C3=A9vrier 2026 =C3=A0 15:44 +0800, Ming Qian(OSS) a =C3=A9cr=
it=C2=A0:
> Hi Nicolas,
>=20
> On 1/30/2026 10:47 PM, Nicolas Dufresne wrote:
> > Hi,
> >=20
> > Le vendredi 30 janvier 2026 =C3=A0 16:41 +0800, ming.qian@oss.nxp.com=
=C2=A0a =C3=A9crit :
> > > From: Ming Qian <ming.qian@oss.nxp.com>
> > >=20
> > > The VPU G2 clock was reduced from 600MHz to 300MHz in commit
> > > b27bfc5103c7 ("arm64: dts: freescale: Fix VPU G2 clock") to address
> > > pixel errors with high-resolution HEVC postprocessor output.
> > >=20
> > > However, testing shows the 300MHz clock rate is insufficient for
> > > 4K60fps decoding and the original pixel errors no longer occur at
> > > 600MHz with current drivers.
> >=20
> > Tested on EVK, with the downstream DCSS driver, and this change trigger=
s DCSS
> > underrun (which is related to the DRAM QoS erratas on this SoC). It als=
o
> > sometimes trigger the "not all macroblock decoded" warning I added rece=
ntly, and
> > we can empty IRQs, but these are handled now.
> >=20
>=20
> This doesn't sound like just a VPU issue; it's related to the display or=
=20
> DDR.
> If not displayed, do the fluster test cases yield different results at=
=20
> 600MHz and 300MHz?

Didn't you run these tests before sending ? I can try again, but in my inte=
rnal
notes, I wrote:

  > Tested that, and everything becomes unstable

That was before I figure-out the IRQ handler didn't handle exception bits t=
hat
didn't stop the decoder (or dry IRQ, which strangely is common from the G2)=
.

>=20
> > >=20
> > > Test results with 3840x2160@60fps HEVC stream decoded to NV12
> > > (the same scenario that exhibited pixel errors previously):
> > >=20
> > > 300MHz performance:
> > > - Severe frame dropping throughout playback
> > > - Only 336 frames rendered in 11:53 (0.471 fps)
> > > - Continuous "A lot of buffers are being dropped" warnings
> > > - Completely unusable for 4K video
> > >=20
> > > 600MHz performance:
> > > - Smooth playback with only 1 frame dropped at startup
> > > - 37981 frames rendered in 10:34 (59.857 fps)
> > > - Achieves target 60fps performance
> > > - No pixel errors or artifacts observed
> >=20
> > That probably only true with the upstream DCSS + a small resolution emb=
edded
> > panel ? Can you clarify this setup, because the display drivers mainlin=
e are
> > very minimal. Would be nice to show you average DDR read/write bandwidt=
h
> > utilization during this run for comparision.
>=20
> My display is hdmi, I'll try the DCSS.
> And the DDR bandwidth results measured by perf are as follows:
>=20
> =C2=A0 Performance counter stats for 'system wide':
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 113303664278=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 imx8_ddr0/read-cycles/
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 82457075530=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 imx8_ddr0/write-cycles/
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 634.892101865 seconds time elapsed
>=20
> >=20
> > Another information that bugs me, in the BSP code, the G2 voltage is in=
creased
> > too, which you didn't do here. They also use the thermal 2 zone to kick=
 it down
> > to 300 until it cools down.
> >=20
>=20
> In our internal code, whenever the frequency of either g1 or g2 reaches
> 600MHz, the voltage is adjusted to 1.0V. Since g1 is already set to 600
> MHz in the upstream DTS, I believe the default version is already 1.0v.
>=20
> And do you mean vpu-thermal? But it doesn't define the cooling-map, I'm
> not sure how it works.
>=20
> 		vpu-thermal {
> 			polling-delay-passive =3D <250>;
> 			polling-delay =3D <2000>;
> 			thermal-sensors =3D <&tmu 2>;
>=20
> 			trips {
> 				vpu-crit {
> 					temperature =3D <90000>;
> 					hysteresis =3D <2000>;
> 					type =3D "critical";
> 				};
> 			};
> 		};

Its not:

 $> cat /sys/kernel/debug/regulator/regulator_summary | grep SW1C
 SW1C                             1    1      0 unknown   900mV     0mA   8=
25mV  1100


Before I gave up on 60Hz on this SoC, I did test raising it to 1v with this
patch (hopefully there is a way to do that in DT, would be more elegant):


diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index 4b828d74a606..2f2b85ca6fd2 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -639,6 +639,7 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] =
=3D {
 		},
 		.pgc   =3D BIT(IMX8M_PGC_VPU),
 		.keep_clocks =3D true,
+		.voltage   =3D 1000000,
 	},
=20
 	[IMX8M_POWER_DOMAIN_DISP] =3D {

I would also like to remind you your own erratas, in the errata document yo=
u
state that DRAM QoS is broken, and all transactions are treated with the sa=
me
priority. If you overload the bandwidth, it becomes fatal for the display
controller. We tried to workaround with changing the NoC configuration, but=
 it
did not work. It feels like that NoC granularity is not enough to prevent
underrun of the display controller (where the QoS would work, since its don=
e at
transaction level, not by measuring bandwidth).

Nicolas

>=20
> Regards,
> Ming
>=20
> > Nicolas
> >=20
> > >=20
> > > Restore the clock to 600MHz to enable proper 4K60fps decoding
> > > capability while maintaining stability.
> > >=20
> > > Test pipeline:
> > > =C2=A0=C2=A0 gst-launch-1.0 filesrc location=3D<4K60_HEVC.mkv> ! \
> > > =C2=A0=C2=A0=C2=A0=C2=A0 video/x-matroska ! aiurdemux ! h265parse ! \
> > > =C2=A0=C2=A0=C2=A0=C2=A0 v4l2slh265dec ! video/x-raw,format=3DNV12 ! =
\
> > > =C2=A0=C2=A0=C2=A0=C2=A0 queue ! waylandsink
> > >=20
> > > Fixes: b27bfc5103c7 ("arm64: dts: freescale: Fix VPU G2 clock")
> > > Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> > > ---
> > > =C2=A0 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
> > > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > index 607962f807be..731142176625 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > @@ -960,7 +960,7 @@ pgc_vpu: power-domain@6 {
> > > =C2=A0=C2=A0								=09
> > > <&clk IMX8MQ_SYS1_PLL_800M>,
> > > =C2=A0=C2=A0								=09
> > > <&clk IMX8MQ_VPU_PLL>;
> > > =C2=A0=C2=A0						assigned-clock-rates =3D
> > > <600000000>,
> > > -							=09
> > > <300000000>,
> > > +							=09
> > > <600000000>,
> > > =C2=A0=C2=A0							=09
> > > <800000000>,
> > > =C2=A0=C2=A0								=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0>;
> > > =C2=A0=C2=A0					};
> > >=20
> > > base-commit: c824345288d11e269ce41b36c105715bc2286050
> > > prerequisite-patch-id: 0000000000000000000000000000000000000000

--=-VlA8ZcxnzX2eUS2/dkES
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaYDwjAAKCRDZQZRRKWBy
9M0iAQCQ+75+dFwxPBtQI6SItaSuQV1acKtDid/mlGDfjCw4EQD/Xw6NrgBGFWtL
nBi1uvDvRI2awNqQROZ2r40kipfvpwc=
=PVw+
-----END PGP SIGNATURE-----

--=-VlA8ZcxnzX2eUS2/dkES--

