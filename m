Return-Path: <linux-pm+bounces-924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2A480E0BC
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 02:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F019B2150B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 01:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6B7639;
	Tue, 12 Dec 2023 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XKEvYUiK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89D1C4
	for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 17:10:04 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231212011002epoutp03e5dbf47d78e0ecc989adff40e3e794e3~f8E477o5O2309023090epoutp03e
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 01:10:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231212011002epoutp03e5dbf47d78e0ecc989adff40e3e794e3~f8E477o5O2309023090epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702343403;
	bh=53SGPNwqJDNwkpSp/kpKMKy0RNs23DJQx/RtIVJ1gj4=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=XKEvYUiK348lOYmed/f/ibcOBjhXBwEzEJV/jkERElkSRv9GVjOyAlwRp+724C2/A
	 Y7h3dpVOQLEV1/Iy5XRS77Gz6iekK/3eAxwBWv/gsn19EeFiD5DyDTE5KZseHGrVDi
	 loAWqas1i+L+V5ktaLPU47NRcFtk1zo/ISZRN+rQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231212011002epcas1p22c116deaee3c252421f7c15498cf98e7~f8E4oKQ9R2269922699epcas1p2p;
	Tue, 12 Dec 2023 01:10:02 +0000 (GMT)
Received: from epcpadp3 (unknown [182.195.40.17]) by epsnrtp3.localdomain
	(Postfix) with ESMTP id 4Sq0s64LH4z4x9Q8; Tue, 12 Dec 2023 01:10:02 +0000
	(GMT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: Re: [PATCH v4] PM / devfreq: Synchronize
 device_monitor_[start/stop]
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Mukesh Ojha <quic_mojha@quicinc.com>, Chanwoo Choi
	<cw00.choi@samsung.com>
CC: Kyungmin Park <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "huangzaiyang@oppo.com"
	<huangzaiyang@oppo.com>, CPGS <cpgs@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1296674576.21702343402595.JavaMail.epsvc@epcpadp3>
Date: Tue, 12 Dec 2023 09:27:02 +0900
X-CMS-MailID: 20231212002702epcms1p6a18b626aee8f700957dbc2855d1711b4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20231206105023epcas1p443ebecc35010d2577b86c3fa23e24e45
References: <CGME20231206105023epcas1p443ebecc35010d2577b86c3fa23e24e45@epcms1p6>

On 11/25/2023 2:41 AM, Mukesh Ojha wrote:
> There is a chance if a frequent switch of the governor
> done in a loop result in timer list corruption where
> timer cancel being done from two place one from
> cancel_delayed_work_sync() and followed by expire_timers()
> can be seen from the traces[1].
>
> while true
> do
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "simple_ondemand" > /sys/class/dev=
freq/1d84000.ufshc/governor
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "performance" > /sys/class/devfreq=
/1d84000.ufshc/governor
> done
>
> It looks to be issue with devfreq driver where
> device_monitor_[start/stop] need to synchronized so that
> delayed work should get corrupted while it is either
> being queued or running or being cancelled.
>
> Let's use polling flag and devfreq lock to synchronize the
> queueing the timer instance twice and work data being
> corrupted.

Would you please identify the resources to be protected by this lock
and specify them in the devfreq->lock declaration?
(it seems the list of protected resources is growing, and
we need to track them.)

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

