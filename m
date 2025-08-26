Return-Path: <linux-pm+bounces-33091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF9FB3559D
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 09:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1C71B65729
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 07:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC822F60D5;
	Tue, 26 Aug 2025 07:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vmk/4byl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945092F49FB
	for <linux-pm@vger.kernel.org>; Tue, 26 Aug 2025 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193175; cv=none; b=A1gvtImYv1e4rzRkiX0DWpgZpmIefMoBtbD5lNiTcoKPjSiUiy//U9nvKXLnCY8NXUZb9MzC+ylmBSOixS+LoLJ2Xv15h3I+zi9N/KhEc0MGR48kdhpzDb1HaWYu5BYwxVcYpJcpJ8ESwnXDFdc+lBADkhDj92f+i0MzR/BygNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193175; c=relaxed/simple;
	bh=DcMpv+3mgF8aZDoDXRSQ/IQVeWP92JqyekiKkdCx2mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=FwILSMB413jmqRqJvAJIu2H4ngV827ScNPpsjdQ7MNER2dZ5HFKuEK3Wg/a56q985BQU8G6KcJH5opRlhfMHo2bCmIRzBmzg7/Ug7RMrCve2tDwvZqdefFyBh0GWEpqd/rdDC2zJcjo+swgbAiLCWFoEOOVokdmvNCeu5WvVM34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Vmk/4byl; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250826072610euoutp02ed9a094328a41cb302acb4740a4d7613~fQGIrcedt1623316233euoutp02M
	for <linux-pm@vger.kernel.org>; Tue, 26 Aug 2025 07:26:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250826072610euoutp02ed9a094328a41cb302acb4740a4d7613~fQGIrcedt1623316233euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756193170;
	bh=9i5p2LxvgZLund35hCqkpCnzys4/u1z+zSXgl9PoA5s=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Vmk/4bylMbV/wtYHG7M1xjRGAt+Lhv3D9zWse1vOVtbeAo5MtxIFj5y/MhBMRbGHg
	 mC8qDI9JSMhI5zC5p9Xrv0fQidPif8c+fXYbBR2ttKUgtGKmlvRfxJyBWu5gtjHnBV
	 hVP4BkVJFcvdaK/K2gKsWUaP0Vax20+8zYs8aHoU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250826072609eucas1p184dfb0642e07f6b843172d9974f16b7f~fQGII8nK-2890728907eucas1p1Z;
	Tue, 26 Aug 2025 07:26:09 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250826072607eusmtip1479a4e682590dd94ab45dd1f1689d810~fQGGRvVEr1983919839eusmtip12;
	Tue, 26 Aug 2025 07:26:07 +0000 (GMT)
Message-ID: <d8599b11-66dd-486b-89e4-52b82d90f04e@samsung.com>
Date: Tue, 26 Aug 2025 09:26:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v4 2/7] OPP: Move refcount and key update for
 readability in _opp_table_find_key()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Viresh
	Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
	<sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Manivannan
	Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson
	<andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Krzysztof
	Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250826060647.7eerg5blx3xho27p@vireshk-i7>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250826072609eucas1p184dfb0642e07f6b843172d9974f16b7f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250825135939eucas1p206b6e2b5ba115f51618c773a1f37939c
X-EPHeader: CA
X-CMS-RootMailID: 20250825135939eucas1p206b6e2b5ba115f51618c773a1f37939c
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
	<20250820-opp_pcie-v4-2-273b8944eed0@oss.qualcomm.com>
	<CGME20250825135939eucas1p206b6e2b5ba115f51618c773a1f37939c@eucas1p2.samsung.com>
	<4066c0b4-807f-401e-baaa-25f4891f10ac@samsung.com>
	<20250826060647.7eerg5blx3xho27p@vireshk-i7>

On 26.08.2025 08:06, Viresh Kumar wrote:
> Marek,
>
> Thanks for the detailed logs. I would need a little more help from
> you.
>
> Can you give this a try over your failing branch (I have already
> dropped the patch from my tree for now):
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 81fb7dd7f323..5b24255733b5 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -554,10 +554,10 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
>          list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
>                  if (temp_opp->available == available) {
>                          if (compare(&opp, temp_opp, read(temp_opp, index), *key)) {
> -                               *key = read(opp, index);
> -
> -                               /* Increment the reference count of OPP */
> -                               dev_pm_opp_get(opp);
> +                               if (!IS_ERR(opp)) {
> +                                       *key = read(opp, index);
> +                                       dev_pm_opp_get(opp);
> +                               }
>                                  break;
>                          }
>                  }

This doesn't help. I've stared a bit at that code and did some tests 
and it looks that the issue is caused by _opp_table_find_key() returning 
the last opp from opp_list without updating the *key and calling 
opp_get() for it (happens when compare() returns false).

> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


