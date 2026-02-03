Return-Path: <linux-pm+bounces-41937-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDMiIy27gWm7JAMAu9opvQ
	(envelope-from <linux-pm+bounces-41937-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 10:09:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC400D698C
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 10:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B05D6309E153
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2BD39447F;
	Tue,  3 Feb 2026 09:04:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A8D38F25A
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109492; cv=none; b=uOAI8p2fC6KBVAgUdGKWxgxiehSHg7iEYCpLNAY6tBE05quXaNZgknk6SEyPXq63+3Te0HbF/T1Rm7npIJY290t3iZhm0djZSeR1VQUFAxs1Pu1tW5+Fo2JeaaYeQqBSaRzi9yOe9EWtE6EWlmfFQebgNcqDwgWIlUWnFXcT4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109492; c=relaxed/simple;
	bh=hMHPqQMG753T7ncGetQAZ0pJ5UyesNGe7Vaq1/V8TYc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fa8X0Z6acCCg52Bi2n7iuWbO17Z1uSq0JAYnTTY1rScP4MN8K+Gyj8o63oy4k58SXwoP82HAJsZGLKGhnCrzZnPRbrAlVh+fct1s0Nz7w/B+IFovGMzqBCXZyB/0rc/ctQjmas78eh4q+NbI54iR0TvXoNw9cXsccwKgm+0nxR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1vnCKi-0000Yw-8R; Tue, 03 Feb 2026 10:04:28 +0100
Message-ID: <20602b86caa7166a5ac8eb75d38be07c7d7bb264.camel@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mq: Restore VPU G2 clock to 600MHz for
 4K60fps decoding
From: Lucas Stach <l.stach@pengutronix.de>
To: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>, Nicolas Dufresne
	 <nicolas@ndufresne.ca>, linux-media@vger.kernel.org
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, 
 benjamin.gaignard@collabora.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, p.zabel@pengutronix.de,
 sebastian.fricke@collabora.com,  shawnguo@kernel.org,
 ulf.hansson@linaro.org, s.hauer@pengutronix.de,  kernel@pengutronix.de,
 festevam@gmail.com, linux-imx@nxp.com, Frank.li@nxp.com,  peng.fan@nxp.com,
 eagle.zhou@nxp.com, devicetree@vger.kernel.org,  imx@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
Date: Tue, 03 Feb 2026 10:04:25 +0100
In-Reply-To: <ca3a8042-1394-4925-9c61-dbfcbf4cf7d9@oss.nxp.com>
References: <20260130084133.2159-1-ming.qian@oss.nxp.com>
	 <df8d5d5f28870752e77ec74f34fea7ceb6e97286.camel@ndufresne.ca>
	 <0b24716b-438c-4185-8a93-3a3879147c24@oss.nxp.com>
	 <169eba79e8e1f906b1a0b59e22a531dfc7e57a1f.camel@ndufresne.ca>
	 <5e3431c69da07557edb20a252c4759be8c857f08.camel@ndufresne.ca>
	 <ca3a8042-1394-4925-9c61-dbfcbf4cf7d9@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-41937-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,xs4all.nl,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[l.stach@pengutronix.de,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:mid]
X-Rspamd-Queue-Id: EC400D698C
X-Rspamd-Action: no action

Hi,

Am Dienstag, dem 03.02.2026 um 15:13 +0800 schrieb Ming Qian(OSS):
> Hi Nicolas,
>=20
> On 2/3/2026 3:12 AM, Nicolas Dufresne wrote:
> > Hi,
> >=20
> > Le lundi 02 f=C3=A9vrier 2026 =C3=A0 13:44 -0500, Nicolas Dufresne a =
=C3=A9crit :
> > > > This doesn't sound like just a VPU issue; it's related to the displ=
ay or
> > > > DDR.
> > > > If not displayed, do the fluster test cases yield different results=
 at
> > > > 600MHz and 300MHz?
> > >=20
> > > Didn't you run these tests before sending ? I can try again, but in m=
y
> > > internal
> > > notes, I wrote:
> > >=20
> > >    > Tested that, and everything becomes unstable
> > >=20
> > > That was before I figure-out the IRQ handler didn't handle exception =
bits that
> > > didn't stop the decoder (or dry IRQ, which strangely is common from t=
he G2).
> >=20
> > Ran some fluster tests now. With this patch the results is not consiste=
nt
> > anymore. Then I ran it with weston being started, and in the middle of =
the test
> > the display turned black. Matches my past observation. We did reproduce=
 this on
> > BSP kernel too. When the display goes black, the recent hantro drivers =
reports:
> >=20
> > [  827.581586] hantro-vpu 38310000.video-codec: frame decode timed out.
> > [  827.720201] hantro-vpu 38310000.video-codec: not all macroblocks wer=
e
> > decoded.
> >=20
> >=20
> > I have local patches to reduce the cascade of errors, so it likely surv=
ived
> > longer then last time. I will send these patches soon. The "not all mac=
roblocks
> > were decoded." is triggered by a bit in the status register that is not
> > documented in NXP TRM. I found that bit in some VC8000D documentation (=
the
> > sucessor of G2). I concluded it was the same meaning after looking at t=
he failed
> > buffer visually, it is indeed missing couple of macroblocks near th end=
. Each
> > time we see this error, the DCSS gives up and turn either black, or som=
etimes
> > other color. The second case has been tracked to a DCSS Scaler underrun=
, the
> > first we don't know.
> >=20
> > Fluster command ran (two threads, never completes):
> >=20
> > ./fluster.py run -d GStreamer-H.265-V4L2SL-Gst1.0 -ts JCT-VC-HEVC_V1 -j=
2 -t90
> >=20
> > Nicolas
>=20
> My test results for fluster differ from yours.
> On my end, the results for JCT-VC-HEVC_V1 are consistent at both 300MHz=
=20
> and 600MHz.
> And results remained unchanged after multiple tests.
>=20
> I'm not sure what caused the differences between us.
>=20
> Below are my test results:
>=20
> 600Mhz, 0.9v
> 	cat /sys/kernel/debug/regulator/regulator_summary  |grep SW1C
> 	 SW1C                             0    1      0 unknown   900mV     0mA=
=20
>    825mV  1100mV
> 	cat /sys/kernel/debug/clk/vpu_g2/clk_rate
> 	600000000

You are driving the SoC out of spec. The datasheet clearly states that
you need a 1000mV typical voltage for 600MHz VPU clock.

If you drive the SoC outside of those ratings it squarely depends on
the individual SoC if it will tolerate the too low voltage without
errors. Some SoCs land on the better side of PVT curve and will run at
the higher speed without issues, but some will not and will exhibit
random issues outside of the datasheet provided specs.

There isn't much to discuss here. The upstream DT for the i.MX8MQ runs
all the clocks at a rate to meet the nominal drive voltage specs. If
some peripheral clock does violate this, this is a bug not a feature to
replicate in new patches.

Regards,
Lucas

