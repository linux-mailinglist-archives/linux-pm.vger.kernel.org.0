Return-Path: <linux-pm+bounces-25111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EAFA84391
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 14:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA19189DF7E
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 12:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5032628540E;
	Thu, 10 Apr 2025 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="hf/PPn+n"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCB82853EA;
	Thu, 10 Apr 2025 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289078; cv=pass; b=rH7ZOrSfCBVlRaZ1/+q3LT9sihbVw+lat6bNMM2f/cn/WEjd0qlb5sR5airSCxV/totIC2YhrJ4dQI90VfX/nYWq6RkGBCCNnnrjqtU9Q4zT+pMfOAKwVcjvGccFGPZ4JS3X2hjG9BI/20tQj4pWCTN+ASqEa6XvEPVgVnkxcvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289078; c=relaxed/simple;
	bh=/XY1s941qrrmoSZKz0kUv7RWnzbemE9Z2YY27XwIl4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdjly2N1yajWHqKbjZuN3BkHJntEYYsdAN0ynYBi0A8uf9ZPXFdxgI4h629QCDRbZJfsSn0WPhiycOx7aUO4ymyMEFkRjnyLZaIqP+1G+3+wj3BmBliukzHuiOdcM3pjCJNFl2Ouo3p+kAfQqjbfEzb+LGx1zzpmEXmZBxRI9go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=hf/PPn+n; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744289049; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=faUr5cMNVJEtxkEF81Uj66v0dLpqsPPbOQ8jeHs+xjdzkfu20q5tyxCGuJdgnkvjNQyi7LdlGMby2SHrjeb7zfpy10MEUBxa/TsMJb/otf87w7zIhK8upE8pUIYrb+WMGGdn68unk6B3YFkH7EsR2lWuVMBi0pq15gntgaE7qhg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744289049; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q5riLeTe/Eu2n5//o/VPdIzBfe0QKtBNXlz9iKtSP2Q=; 
	b=FAwslMOd1D3HFexQPIoaHr9ykGjPn+yhh37TR+myOwni4K2r7IL22j/bkAY8hqsvcvlP9bqA2RyqSvfeoudmoS97rjJDZ72TA1dcoODVLzXSTf9T3s79i4uuJmUBZvOXHbxgpNWl8+XklImn1hfMmmPgUk6caZ8KotoSCFxuccY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744289049;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=q5riLeTe/Eu2n5//o/VPdIzBfe0QKtBNXlz9iKtSP2Q=;
	b=hf/PPn+ncwxnG6f2I+tARaUTsD3w8+H/v4M/MvP6LjGueeGOqhHIC8KRA256Ou4Z
	JeBu/vXfJdQLf02AbSGpkh+oK3Rr4kU3Cm3f6Q9DQJQhONMtlSSVm0U7tKzdlxkX9Ra
	v0EPXQJS1/C1AyqYnR4FHr6n3ELAWicoGLly1jOk=
Received: by mx.zohomail.com with SMTPS id 1744289048170962.4372419761808;
	Thu, 10 Apr 2025 05:44:08 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Elaine Zhang <zhangqing@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>
Subject:
 Re: [PATCH RESEND] pmdomain: rockchip: keep PD_NVM on RK3576 always on
Date: Thu, 10 Apr 2025 14:44:03 +0200
Message-ID: <10136636.CDJkKcVGEf@workhorse>
In-Reply-To:
 <CAPDyKFpw=qXT6Qh_Gyub7L3ELdODPkyEZVtALvnJZ3OZQeS76w@mail.gmail.com>
References:
 <20250408-rk3576-emmc-fix-v1-1-3009828b1b31@collabora.com>
 <CAPDyKFpw=qXT6Qh_Gyub7L3ELdODPkyEZVtALvnJZ3OZQeS76w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 10 April 2025 14:10:56 Central European Summer Time Ulf Hansson wrote:
> + Shawn Lin
> 
> On Tue, 8 Apr 2025 at 17:28, Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
> >
> > Due to what seemingly is a hardware bug, PD_NVM never comes up quite the
> > same after being turned off once. The result is that the sdhci
> > controller will lock up the entire SoC when it's accessing its CQHCI
> > registers.
> >
> > The downstream kernel hacks around this by setting
> > GENPD_FLAG_RPM_ALWAYS_ON in the mmc host driver, which does not seem
> > like the right place for this.
> >
> > Set GENPD_FLAG_ALWAYS_ON in the pmdomain driver for PD_NVM. I'm using
> > the non-RPM version of the flag here because I have my doubts a
> > suspend-resume cycle will fix it. Suspend-resume currently seems busted,
> > so I couldn't test this.
> >
> > Fixes: cfee1b507758 ("pmdomain: rockchip: Add support for RK3576 SoC")
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> Shawn Lin recently made some changes [1] to make UFS work for this
> platform, as you probably know of. In particular the changes affected
> how to handle the UFS controller from the power-domain point of view.
> Could it be that something similar is missing for NVM too?
> 
> In any case, I am happy to apply this as a fix if you still think it
> makes sense.
> 
> Kind regards
> Uffe
> 
> [1]
> https://lore.kernel.org/all/1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com/

Oh my, good catch. That does look like a similar kind of thing, and
potentially a better solution than what I'm going for.

I'll have to do some testing on my side, thank you for bringing this
particular part of the UFS series to my attention. I'll either respond
here or post a new version of the patch series depending on the outcome
of said testing.

Kind regards,
Nicolas Frattaroli



