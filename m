Return-Path: <linux-pm+bounces-7084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A48E8B233C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 15:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AECE8B25A6D
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE885149DE7;
	Thu, 25 Apr 2024 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="ghmM1RiL"
X-Original-To: linux-pm@vger.kernel.org
Received: from pv50p00im-ztbu10011701.me.com (pv50p00im-ztbu10011701.me.com [17.58.6.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D0149DE0
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053393; cv=none; b=SMT4FxfPCDCtrEkOBaKusYr+K469ayPiyZlbulPF0by+aqCj9M1aheUqYHZdCfA8oJ5FAXgqlPKqQpjZ5DkyzUls+DbZxDRQ6kAP34FX+AJkPjju2l08kvKFvzDtGiq9vK+9du7RGG2zkkxETlq7s4LRg+6Sa2CZ5UiQqHKhUHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053393; c=relaxed/simple;
	bh=7K+Nf6VsdXl6zyASN0NLSdOXvxm4osmhlY7e+F5gksk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bjNWehjImoKQWylwqohnGfieumvTmZLfw/t5mXp8uCzFtfBWz+iEqFKqE4D5M8Rx4xpN36bmAp11sO5vosPtcVmlXdXIIEu8mvecM0jLcCLRgWNzH6Dct32iZyarDlfi8agLSDBl9wMDPF9CiMwqqwGtQJKvq8aobSYoRywfdTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=ghmM1RiL; arc=none smtp.client-ip=17.58.6.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1714053391; bh=7K+Nf6VsdXl6zyASN0NLSdOXvxm4osmhlY7e+F5gksk=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=ghmM1RiL2wniVl79VbV1vyEX1i2eISohkaW6uB7INhH2gAcI2m7Bi8orwDpdEN1EZ
	 OBGDd8eWAk/Um6g+jUVwhE9jLGNBP6MCc4gjoptQDRsSu9QPT+rS+4urTXPlLTkr8D
	 rHTc4F3MAAhSMhmUOTmk+2GpdYtFFrnYS+/QsnX3fIOV+ywk+tGbDhnesNCeUBWAkK
	 HylvAAbN8bW5H5kGjjhlJXE8EOCVUzpF/34OPbNDYdGhC/nwsir8GseAGXDyBFbDNg
	 +lq9xbIrzXF8909SK1oh2Fb7xYKRtEpD/4Y0I6YwUPiY2V3hX1zZnbvbxezDbaH/Tf
	 s7wFz9acIhD8Q==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztbu10011701.me.com (Postfix) with ESMTPSA id 9B32A74029D;
	Thu, 25 Apr 2024 13:56:29 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: cpufreq: Fix printing large cpu and cpufreq number
From: Thorsten Blum <thorsten.blum@me.com>
In-Reply-To: <20240425110017.75238-1-joshua.yeong@starfivetech.com>
Date: Thu, 25 Apr 2024 15:56:16 +0200
Cc: rafael@kernel.org,
 viresh.kumar@linaro.org,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <15DCD462-940A-487C-9780-5B87BF0B3CE1@me.com>
References: <20240425110017.75238-1-joshua.yeong@starfivetech.com>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-Proofpoint-ORIG-GUID: hMIv8pj21TZYbU91GXcnwnG2S3Wl4IZ0
X-Proofpoint-GUID: hMIv8pj21TZYbU91GXcnwnG2S3Wl4IZ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_13,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1011 malwarescore=0 adultscore=0 mlxlogscore=983 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2404250102

On 25. Apr 2024, at 13:00, Joshua Yeong <joshua.yeong@starfivetech.com> =
wrote:
>=20
> Fix printing negative number when CPU frequency
> with large number.
>=20
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>

Reviewed-by: Thorsten Blum <thorsten.blum@toblux.com>=

