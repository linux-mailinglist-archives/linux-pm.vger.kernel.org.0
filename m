Return-Path: <linux-pm+bounces-16797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E8E9B7371
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 05:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39811F2470A
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 04:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C83126BF2;
	Thu, 31 Oct 2024 04:06:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EA11BC20;
	Thu, 31 Oct 2024 04:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347592; cv=none; b=Eys6Q6GklT+kY4/J+XpsoWx5yjc6yeycV31RIZJxUKpxMRC5W2UMsPLr9bjjxm03mGpWR7mnTlmzecVVVdFdk28FYS1/4nTkKa91fo0rLweKq3MAfkwblDkKiwUkjlt8SMZh4YMS7ef9Zy928UXZpBddlJ1LezkK7TsV162lNQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347592; c=relaxed/simple;
	bh=8o0wTajvqrceEEN1/lA+Tv1Td9XaWmKPnsf2QQimHKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWRIL9F514eN0bUWr5bwhLpOFPMbe2VaYCvyDfkX0D24kmHZ48c4b6WS1zKYNx4OV30KB8unyQjF+KlqeLMvsHFU30u/Db5TEJ7NvkhSekzwh/NFzsA4d8oZd1NKoYCE8dZaS4iUTpU5lA16PDwjaCd0QIXK0n0mv2nGIvOmP3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: 5JNKYTz+RBS8Iv7eOVhPJg==
X-CSE-MsgGUID: /tW1S95tRrW/EKJJuUfyNg==
X-IronPort-AV: E=Sophos;i="6.11,246,1725292800"; 
   d="scan'208";a="100008817"
From: ZhengShaobo <zhengshaobo1@xiaomi.com>
To: <rafael@kernel.org>
CC: <chendejun@xiaomi.com>, <chuci@xiaomi.com>, <daniel.lezcano@linaro.org>,
	<dingchongchong@xiaomi.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <lukasz.luba@arm.com>, <rui.zhang@intel.com>,
	<zhengshaobo1@xiaomi.com>
Subject: Re: [PATCH] thermal: gov_power_allocator: Granted power set to max when nobody request power
Date: Thu, 31 Oct 2024 12:06:23 +0800
Message-ID: <20241031040626.631-1-zhengshaobo1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0gbpx7+hS=NS2+kNgRaOvADrY_2JsoRSg21tmF4oRnFwg@mail.gmail.com>
References: <CAJZ5v0gbpx7+hS=NS2+kNgRaOvADrY_2JsoRSg21tmF4oRnFwg@mail.gmail.com>
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

On Thu, Oct 24, 2024 at 05:26:49PM +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 24, 2024 at 10:01 AM ZhengShaobo <zhengshaobo1@xiaomi.com> wrote:
> >
> > On Wed, Oct 23, 2024 at 12:09:44PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Oct 21, 2024 at 2:12 PM ZhengShaobo <zhengshaobo1@xiaomi.com> wrote:
> > > >
> > > > From: zhengshaobo1 <zhengshaobo1@xiaomi.com>
> > > >
> > > > When total_req_power is 0, divvy_up_power() will set granted_power to 0,
> > > > and cdev will be limited to the lowest performance. If our polling delay
> > > > is set to 200ms, it means that cdev cannot perform better within 200ms
> > > > even if cdev has a sudden load. This will affect the performance of cdev
> > > > and is not as expected.
> > > >
> > > > For this reason, if nobody requests power, then set the granted power to
> > > > the max_power.
> > > >
> > > > Signed-off-by: zhengshaobo1 <zhengshaobo1@xiaomi.com>
> > >
> > > I would have applied this, but your S-o-b above needs to be fixed.
> > > Why don't you use your real name there?
> > >
> > > If it can be changed to "ZhengShaobo <zhengshaobo1@xiaomi.com>",
> > > please let me know, and I will fix it for you when applying the patch.
> > >
> > Yes, it should be "ZhengShaobo <zhengshaobo1@xiaomi.com>".
> > I would really appreciate your help in solving this problem.
>
> OK, applied as 6.13 material with the S-o-b tag as per the above, thanks!

I would like to backport the patch to android15-6.6, but this needs to be merged
into the maintainer tree. I am wondering when this patch will be merged into your
maintainer tree, and I hope you can let me know.

Thanks,
ZhengShaobo

