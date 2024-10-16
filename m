Return-Path: <linux-pm+bounces-15732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1370E9A014F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 08:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB518282DB8
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 06:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5714018C93E;
	Wed, 16 Oct 2024 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="IzxMrFRT";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="f1nb08xF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2940156E4;
	Wed, 16 Oct 2024 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059678; cv=none; b=M2UxgA8ixet+yapOpW8xpT11HBH2VxlNZ3T97aHpPs744nVNXoq79PTL8cwqT8idWDxXh6xsS6oWe+W88YD41QpOAVQMDj5oTzSAgH+OnIMCk3T1cpTBWwyuOs6+7IJcPYwZQ4+7/PQa5Ie33VhwDyEq3KgvmXDchwge5ErcSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059678; c=relaxed/simple;
	bh=qtIq09jJAzOgiH9f6OxuvGgP5PFO3K4dHolkl1tEZBk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7ErmZKqEJJQ85k56rF8rgdNojhf1gZsBb31Bznqq+1FFqi0RD7dG/nBi+32AWbUY5xR1KddjjVezJopjkawjRBU5gYkoT5IS9iUlrqWmxqG0MsuurgUwe7+DCS1fnVcvLU3hQS14fCsFCFgqE+60WBrAKO5UBPtFrVAoHqQqFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=IzxMrFRT; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=f1nb08xF; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1729059673;
	bh=RdJKZic5d6lX67BxlIEuRa8JabQ9jOO0FLV2ks0qcjQ=; l=616;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=IzxMrFRToR298fGP+MXDuLZ/g6Py2YvgBAVzoAC4V2lk3YRh0beDGq42Y32ylA6eE
	 KVOZ/zC2IrysI0dTx2HS1DJYHA6s0ORGB/EiRFJbRKNhvsuR2elhxAtu91Ye0GF0QD
	 fN0+AVzVkdB1hQFlilzE5wvEExKQqNBnsR7OyxPJlBcNMrjSKq3XD4xx0A1pCVQPbs
	 GeR4w2YAAbrw23xqQSlGjZEoWISFQOn5TtN7jIHAYJh6ZBgoyGp9i7kzI6FsoDsK1W
	 KAJfauFy5bVUCccPM6088bLTiI9UgKrjJW0bYBEHANfHm7jS6KkbVr29pXXppIfoTK
	 JdrG6gEy7xx5w==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(3190218:0:AUTH_RELAY)
	(envelope-from <prvs=10165246CB=cy_huang@richtek.com>); Wed, 16 Oct 2024 14:21:12 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1729059672;
	bh=RdJKZic5d6lX67BxlIEuRa8JabQ9jOO0FLV2ks0qcjQ=; l=616;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=f1nb08xFuZJRJYxvuBR4O0BogWKSrzG60oACns2/SvKSb9GDUcQSseUHQimoo7rcf
	 DxNvG/Q92usfeHJ0oHeCrQBFw+ic89AiEHjOUr72v0ISODfVSQAVSTziEhFa0Z3oAe
	 F63g+tzVdhAApl+IPUNylvjX14bsbI5BZP+pOE5VmMnpkX5Biz1SkPPihRxEYRca2W
	 EUaN4wb7S/UuWQmpgWASVCiC5oUso/ckZsg7fv7ISsV1SPoaeeQ7H9NISm5GTYFif1
	 3/0hLQbEPtyN/ARZKXlFLi/TLuQqYwOwwqyQ4Khn+owqx30OsY+kPAzwNEqS29QS31
	 cUsxA0zypx+qQ==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(956549:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 16 Oct 2024 14:13:40 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 16 Oct
 2024 14:13:40 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Wed, 16 Oct 2024 14:13:40 +0800
Date: Wed, 16 Oct 2024 14:13:53 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <lucas_tsai@richtek.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] power: supply: rt9471: Fix WDT bitfield and charger
 status
Message-ID: <Zw9ZoaJQAqp8Oqh9@git-send.richtek.com>
References: <cover.1727252762.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1727252762.git.cy_huang@richtek.com>

On Wed, Sep 25, 2024 at 04:32:57PM +0800, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> This patch series add the following fixes that reported from the end
> market included WDT bitfield and the real charger status.
Any reply for this patch series?
> 
> ChiYuan Huang (2):
>   power: supply: rt9471: Fix wrong WDT function regfield declaration
>   power: supply: rt9471: Use IC status regfield to report real charger
>     status
> 
>  drivers/power/supply/rt9471.c | 52 ++++++++++++++++++++++-------------
>  1 file changed, 33 insertions(+), 19 deletions(-)
> 
> -- 
> 2.34.1
> 

