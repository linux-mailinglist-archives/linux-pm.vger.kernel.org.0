Return-Path: <linux-pm+bounces-10268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA5E91D640
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 04:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242182819EB
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 02:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B6F8F77;
	Mon,  1 Jul 2024 02:46:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F05680;
	Mon,  1 Jul 2024 02:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719801987; cv=none; b=Og5MCBTOaeEWcVJ3/jVmiitdZkWwhkR5/P6B+dTuyDYM9oEyuOOVbrahnsTZ7uhblM269JpsDHtNM++csbYD73l+gbx+HtrSBfTY5UzLe86SQVkflRIjuzxT4ETrzcVMuaL1AmTzM8rTaFac9KrnQt29N4g2RRRJWC7qlLMMf6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719801987; c=relaxed/simple;
	bh=7QeMM0gqfioaq1tzuce9qEX8WvIyij1AGAKhAI7KO2c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TGRsWpnGblPURuAZPhgFi9XiX9frTlGhb6KMiGVCdY7343NmZEGzH1IhSnLpP71h6eieYgsoEZUNfi20jCNeGMym6vMpnpVQkYwHjiwgLp5nbgBYn43DoDLii4Dh0tWXq2RnpCp3i6BBeDkzvHSo1QICgduUKIfJ7pi9+ftJChc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4612k9A613276257, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4612k9A613276257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 10:46:09 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 10:46:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Jul 2024 10:46:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 1 Jul 2024 10:46:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Forty Five <mathewegeorge@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Bernie Huang
	<phhuang@realtek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Topic: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Index: AQHayyKWbA+C/SyMRES67Y/3y6K7kbHhKj7w
Date: Mon, 1 Jul 2024 02:46:08 +0000
Message-ID: <e7e1750ff40345ecb9aac437a8ec49c9@realtek.com>
References: <875xtqjli4.fsf@gmail.com> <87a5j2s0e2.fsf@gmail.com>
In-Reply-To: <87a5j2s0e2.fsf@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Forty Five <mathewegeorge@gmail.com> wrote:
> Forty Five <mathewegeorge@gmail.com> writes:
>=20
> > I applied both patches on the latest master; here are the crash logs.
>=20
> Just realized I forgot to run the commands to get debug messages for all
> except the first crash log (kdumpst-202406301756.zip). I'll send more
> logs later.

It looks like you forgot to apply my attached debug patch. With debug mask,
many messages output to kernel log but I can't see things before suspending=
,
is it possible to enlarge buffer size of kdump?

Thanks

Ping-Ke


