Return-Path: <linux-pm+bounces-16345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC319ADE6C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 303FBB20FC8
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 08:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB13A189F4B;
	Thu, 24 Oct 2024 08:05:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B08516BE01;
	Thu, 24 Oct 2024 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757145; cv=none; b=KhmMhP8TNdCDVVl6rIHx0/Bx7xEJNQiijK0L6JWLCI4ruF1A+5vbxUlCwbE4z+EYwwr1gdaITGaP88HzlgisrIWPHskS3SY2iViy01CvxxWPwAdqxOIVcB/raTcI+Ukqj319WrviHLikPEZ6v1oQI3X2fY/hactV5N18RtEkk6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757145; c=relaxed/simple;
	bh=gogD0i7bwHKLV0LMRBH2B2NSjmA6gbgxRSx0dkfFLbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5FPn5zEehERyGdmb2kEtthKvnYqN7aqyczQFY8nZx0DGS642wpdonzcEhHr9Jfwbo6y0sot0WrNxAIC3mxPDvw7D2B2G5ue/hlHYY9U0bzN46tszA6ikT43w33XEhFwvPF3qoE1IhqdzsgxwiaF62KUh7Ho4EGGeBTAaBHKy8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: Qa5GtYvOTCKff3z87s9KJQ==
X-CSE-MsgGUID: oA48d9dMSMKsPclrLT/uUA==
X-IronPort-AV: E=Sophos;i="6.11,228,1725292800"; 
   d="scan'208";a="125165157"
From: ZhengShaobo <zhengshaobo1@xiaomi.com>
To: <zhengshaobo1@xiaomi.com>
CC: <chendejun@xiaomi.com>, <chuci@xiaomi.com>, <daniel.lezcano@linaro.org>,
	<dingchongchong@xiaomi.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <lukasz.luba@arm.com>, <rafael@kernel.org>,
	<rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: gov_power_allocator: Granted power set to max when nobody request power
Date: Thu, 24 Oct 2024 16:05:35 +0800
Message-ID: <20241024080536.660-1-zhengshaobo1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0g=uyPA1QH-gQbTZBim7EB8Fn+8Q_7Bc+eOmPqGaDQh0A@mail.gmail.com>
References: <CAJZ5v0g=uyPA1QH-gQbTZBim7EB8Fn+8Q_7Bc+eOmPqGaDQh0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BJ-MBX07.mioffice.cn (10.237.8.127) To BJ-MBX15.mioffice.cn
 (10.237.8.135)

On Wed, Oct 23, 2024 at 12:09:44PM +0200, Rafael J. Wysocki wrote:
> On Mon, Oct 21, 2024 at 2:12 PM ZhengShaobo <zhengshaobo1@xiaomi.com> wrote:
> >
> > From: zhengshaobo1 <zhengshaobo1@xiaomi.com>
> >
> > When total_req_power is 0, divvy_up_power() will set granted_power to 0,
> > and cdev will be limited to the lowest performance. If our polling delay
> > is set to 200ms, it means that cdev cannot perform better within 200ms
> > even if cdev has a sudden load. This will affect the performance of cdev
> > and is not as expected.
> >
> > For this reason, if nobody requests power, then set the granted power to
> > the max_power.
> >
> > Signed-off-by: zhengshaobo1 <zhengshaobo1@xiaomi.com>
>
> I would have applied this, but your S-o-b above needs to be fixed.
> Why don't you use your real name there?
>
> If it can be changed to "ZhengShaobo <zhengshaobo1@xiaomi.com>",
> please let me know, and I will fix it for you when applying the patch.
>
Yes, it should be "ZhengShaobo <zhengshaobo1@xiaomi.com>".
I would really appreciate your help in solving this problem.

Thanks,
ZhengShaobo

