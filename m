Return-Path: <linux-pm+bounces-42765-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGonMsaelGmrFwIAu9opvQ
	(envelope-from <linux-pm+bounces-42765-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 18:00:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD5314E76F
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 18:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 748CE300C30B
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 17:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF00332C317;
	Tue, 17 Feb 2026 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="XFCehqo3"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701B7C2FF;
	Tue, 17 Feb 2026 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347650; cv=pass; b=LqyvugHeupWcSDT75Id9xt4MaK/vS+Dd2eqq3LUrnlO0yogtbflUTFHV88z2SIaEY/JOf7x8C8zfNwLMVQzzBfJ2jbVdfIwxRpCeFBCXlTaD/ZFOYbzRxnnLI0ycdDmwETbxNdkpdNrh/SNnQ8zVmsFWjYw6X3vz1o0wwD/HxVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347650; c=relaxed/simple;
	bh=qOoRjgnSHrNjTvcalH2hcho9xgYd1gl35shmwDVmt2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jjHJnMEaYBn8Z30bjIrdl/bSP1hcybVVrQZKckR2n+Nl/Oqi0F8W5nibtjZ8FDFUpQHUe9dWhWHR+Cv098y4oF5fuoHXM7xhilGDtJNhe71xugidTTywQzT+IVQVstEyR7khoiJg5j5RdRbuUts2rO3pIUO7F4NvcCoM+dwP6M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=XFCehqo3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1771347611; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QHszZFOWTbW11U8NV6KPlrJZGsJUGGmvCS2afP1YX+VDV4DJzUcOieqGb5ON6MhIkMxKwHi/8S5ReAe4l11iZP8x1BJc+TFSc3qXFLKGY6cgq4SBub6n5RQbCVdyA3oe8nBK1ZZCb9cogQpzqPi9QCI2xt9YdKxOAnhYkPucrYc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771347611; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qOoRjgnSHrNjTvcalH2hcho9xgYd1gl35shmwDVmt2k=; 
	b=CsVdkvxj+cocPq5qvwKi2A3KUkm2LhZSz+qfhsAXW+P1Zd2jp+tjXBsnRBD4s7IpnFlkF6cx4sk1vsqDlaLqJCsJorqNYCzo2dM5TJ9ExxHKWwBx1FVV39/WtnICb5Cg7UN3L56IOYuJ2qHQg2uT0klmRLcxigfs/0sq4Qx6U4E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771347611;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=qOoRjgnSHrNjTvcalH2hcho9xgYd1gl35shmwDVmt2k=;
	b=XFCehqo3rqYYi6FbsDMqUhqUfvbdhGZBsNhWdwP1dUlPjBFsAGe8YsZcyEkwFbgq
	rzWk3SsYGvMz+fVq8BArAPieMwaNuOExAyqTjd5LpN6yDSaAxFKz2Ot+HT4tBup5AXw
	1PdkmBEnSuTAA7c6xBB7szxGLmwEtKsAcq+eg+Co=
Received: by mx.zohomail.com with SMTPS id 1771347608544533.6723972839652;
	Tue, 17 Feb 2026 09:00:08 -0800 (PST)
Message-ID: <c2e418a1fb0c8df38f47fed5010f2a22621afeaa.camel@collabora.com>
Subject: Re: [PATCH v3 04/10] pmdomain: mediatek: Refactor bus protection
 regmaps retrieval
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Macpaul Lin =?UTF-8?Q?=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
	 <Macpaul.Lin@mediatek.com>, AngeloGioacchino Del Regno
	 <angelogioacchino.delregno@collabora.com>
Cc: Pablo Sun =?UTF-8?Q?=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=	
 <pablo.sun@mediatek.com>, "lihongbo22@huawei.com" <lihongbo22@huawei.com>, 
 "robh@kernel.org"	 <robh@kernel.org>, "kernel@collabora.com"
 <kernel@collabora.com>,  "ulf.hansson@linaro.org"	
 <ulf.hansson@linaro.org>, Moudy Ho
 =?UTF-8?Q?=28=E4=BD=95=E5=AE=97=E5=8E=9F=29?=	 <Moudy.Ho@mediatek.com>,
 "mbrugger@suse.com" <mbrugger@suse.com>,  "conor+dt@kernel.org"	
 <conor+dt@kernel.org>, Sjoerd Simons <sjoerd@collabora.com>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org"	 <devicetree@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org"	 <linux-mediatek@lists.infradead.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,  Nicolas Prado
 <nfraprado@collabora.com>, "wenst@chromium.org" <wenst@chromium.org>, Bear
 Wang =?UTF-8?Q?=28=E8=90=A9=E5=8E=9F=E6=83=9F=E5=BE=B7=29?=	
 <bear.wang@mediatek.com>, "y.oudjana@protonmail.com"
 <y.oudjana@protonmail.com>,  "linux-pm@vger.kernel.org"	
 <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"	
 <linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"	
 <matthias.bgg@gmail.com>, MandyJH Liu
 =?UTF-8?Q?=28=E5=8A=89=E4=BA=BA=E5=83=96=29?=	 <MandyJH.Liu@mediatek.com>
Date: Tue, 17 Feb 2026 18:00:01 +0100
In-Reply-To: <54d3abf79ce1cc0f59a18cfff585699073918f60.camel@mediatek.com>
References: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
		 <20250805074746.29457-5-angelogioacchino.delregno@collabora.com>
		 <a2eae87efe46ebf397bcec3580eb9bc152b80846.camel@collabora.com>
		 <be3a2d50-044b-429a-820c-5260c6ce730c@collabora.com>
		 <fd071501b66fb332439617f2b270c837043b0862.camel@mediatek.com>
		 <8fc93d93-7d99-4d38-9fa8-92951a0acdcf@collabora.com>
	 <54d3abf79ce1cc0f59a18cfff585699073918f60.camel@mediatek.com>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42765-lists,linux-pm=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,huawei.com,kernel.org,collabora.com,linaro.org,suse.com,vger.kernel.org,lists.infradead.org,chromium.org,protonmail.com,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,collabora.com:mid,collabora.com:dkim]
X-Rspamd-Queue-Id: 6CD5314E76F
X-Rspamd-Action: no action

Hi Angelo and Macpaul,

On Fri, 2026-02-13 at 16:07 +0000, Macpaul Lin (=E6=9E=97=E6=99=BA=E6=96=8C=
) wrote:
> On Thu, 2026-02-12 at 12:15 +0100, AngeloGioacchino Del Regno wrote:
> > Il 12/02/26 08:58, Macpaul Lin (=E6=9E=97=E6=99=BA=E6=96=8C) ha scritto=
:
> > > On Tue, 2025-10-14 at 11:59 +0200, AngeloGioacchino Del Regno
> > > wrote:
> > > >=20
> > > > External email : Please do not click links or open attachments
> > > > until
> > > > you have verified the sender or the content.
> > > >=20
> > > >=20
> > > > Il 13/10/25 15:41, Sjoerd Simons ha scritto:
> > > > > Hey,
> > > > >=20
> > > > > On Tue, 2025-08-05 at 09:47 +0200, AngeloGioacchino Del Regno
> > > > > wrote:
> > > > > > In preparation to add support for new generation SoCs like
> > > > > > MT8196,
> > > > > > MT6991 and other variants, which require to set bus
> > > > > > protection on
> > > > > > different busses than the ones found on legacy chips, and
> > > > > > to
> > > > > > also
> > > > > > simplify and reduce memory footprint of this driver,
> > > > > > refactor
> > > > > > the
> > > > > > mechanism to retrieve and use the bus protection regmaps.
> > > > > >=20
> > > > > > This is done by removing the three pointers to struct
> > > > > > regmap
> > > > > > from
> > > > > > struct scpsys_domain (allocated for each power domain) and
> > > > > > moving
> > > > > > them to the main struct scpsys (allocated per driver
> > > > > > instance) as
> > > > > > an array of pointers to regmap named **bus_prot.
> > > > >=20
> > > > > Trying to boot v6.18.0-rc1 on a Genio 700 EVK using the arm64
> > > > > defconfig,
> > > > > ends up hanging at boot (seemingly when probing MTU3 and/or
> > > > > mmc,
> > > > > but that
> > > > > might be a red herring).
> > > > >=20
> > > > > Either reverting this patch *or* having CONFIG_MTK_MMSYS
> > > > > builtin
> > > > > rather
> > > > > then a module seems to solve that.
> > > > >=20
> > > >=20
> > > > Thanks for the report.
> > > >=20
> > > > This is not a problem with this patch specifically, but surely
> > > > some
> > > > race condition
> > > > that was already present before and that does get uncovered
> > > > with
> > > > this
> > > > one in some
> > > > conditions.
> > > >=20
> > > > Without the devicetree updates (which are not upstream yet)
> > > > this
> > > > patch is
> > > > fully retaining the legacy functionality 1-to-1.
> > > >=20
> > > > I'll check what's going on ASAP.
> > > >=20
> > > > Cheers,
> > > > Angelo
> > > >=20
> > >=20
> > > This issue also happened on mt8195. I've done bisect on linux-
> > > next
> > > master with mt8195-genio-1200-evk board.
> > > The result shows c29345fa5f66bea0790cf2219f57b974d4fc177b is the
> > > first
> > > bad commit.
> > >=20
> > > I cannot simply revert this commit since there are some
> > > dependencies
> > > commits.
> > >=20
> > > I'm not sure if there are any API or flag change would
> > > affect interaction between the pm-domain driver and scp firmware.
> >=20
> > I'm 99% sure that the SCP firmware has nothing to do with this -
> > but
> > then
> > even if it did, there's some quirk to be uncovered and properly
> > handled.
> >=20
> > So - if it is (again, most probably not) a firmware issue, it was
> > only a
> > matter of time until this situation would've happened. It's pretty
> > common
> > to see two wrongs making one thing right (but in 100% of the cases
> > it
> > does
> > eventually break).
> >=20
> > > Just a remind it is hard for MediaTek to update scp firmware for
> > > a
> > > mass production chip. Each scp firmware seems specifically
> > > designed
> > > for
> > > each chip separately which leads the API might be changed between
> > > each
> > > chip.
> > >=20
> >=20
> > Adding Louis-Alexis to the loop;
> >=20
> > Louis, can you please try to reproduce this one on any of our
> > boards?
> > I can't seem to be able to reproduce here.
> >=20
> > Cheers,
> > Angelo
> >=20
> >=20
>=20
> Angelo and Louis,=20
> Please put this issue to low priority.
> I did reported this issue but it should be quite a while from now.
>=20
> I'm not sure why and how the mail client or mail server send out this
> mail so late, and it has been sent twice until I've discovered right
> now.
> I guess this issue has been gone during 6.18-rcX period.
> However, double check the latest status with latest kernel version is
> good. I think it should be fixed already with AFBC patch or something
> around that time.=20
>=20
This issue was indeed fixed by commit c1bac49fe91f ("pmdomains: mtk-pm-
domains: Fix spinlock recursion in probe"), that was merged for v6.18
release.
I did not reproduce it with stable or linux-next tags since then, on
the Genio boards I'm using.

> > > The error log occurs on emmc at first and than rcu_preempt
> > > happens.
> > > [=C2=A0=C2=A0=C2=A0 1.291055] mtk-msdc 11240000.mmc: msdc_track_cmd_d=
ata: cmd=3D8
> > > arg=3D000001AA; host->error=3D0x00000002
> > > [=C2=A0=C2=A0=C2=A0 1.292775] mtk-msdc 11240000.mmc: msdc_track_cmd_d=
ata: cmd=3D55
> > > arg=3D00000000; host->error=3D0x00000002
> > > [=C2=A0=C2=A0=C2=A0 1.294539] mtk-msdc 11240000.mmc: msdc_track_cmd_d=
ata: cmd=3D55
> > > arg=3D00000000; host->error=3D0x00000002
> > > [=C2=A0=C2=A0=C2=A0 1.296293] mtk-msdc 11240000.mmc: msdc_track_cmd_d=
ata: cmd=3D55
> > > arg=3D00000000; host->error=3D0x00000002
> > > ...
> > > [=C2=A0=C2=A0=C2=A0 1.430408] mtk-msdc 11240000.mmc: msdc_track_cmd_d=
ata: cmd=3D55
> > > arg=3D00000000; host->error=3D0x00000002
> > > [=C2=A0=C2=A0=C2=A0 1.433766] mmc0: Failed to initialize a non-remova=
ble card

There are still some error logs related to mtk-msdc on Genio 1200-EVK
board like those but unrelated to this issue. They appear during boot
when no sdcard is inserted in the micro sd connector.
It seems there is no card detection GPIO present on the board that
could be used to prevent those log occurrences.

There is also cases when emmc is enumerated as mmc1 (and sd as mmc0),
as no mmc alias is declared in this board devicetree.
I'll send a patch to add them.

Regards,
Louis-Alexis

> > > [=C2=A0=C2=A0 22.297240] rcu: INFO: rcu_preempt detected stalls on
> > > CPUs/tasks:
> > > [=C2=A0=C2=A0 22.298723] rcu:=C2=A0=C2=A0=C2=A0=C2=A0 6-...0: (2 tick=
s this GP)
> > > idle=3D104c/1/0x4000000000000000 softirq=3D45/45 fqs=3D37
> > > [=C2=A0=C2=A0 22.299827] rcu:=C2=A0=C2=A0=C2=A0=C2=A0 (detected by 2,=
 t=3D5256 jiffies, g=3D-1051,
> > > q=3D200
> > > ncpus=3D8)
> > > [=C2=A0=C2=A0 22.300689] Sending NMI from CPU 2 to CPUs 6:
> > > ...
> > >=20
> > > Best regards,
> > > Macpaul Lin
> > >=20
> >=20
> >=20
> Best regards,
> Macpaul Lin

