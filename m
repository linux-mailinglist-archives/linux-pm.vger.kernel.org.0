Return-Path: <linux-pm+bounces-20678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC88AA16847
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 09:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10DE3A442E
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 08:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1111F194C77;
	Mon, 20 Jan 2025 08:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CXYXMxsV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2491F149DF0;
	Mon, 20 Jan 2025 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737362209; cv=none; b=Oj9pPyXsS/K4RNg3zG/F+JISsRj9vE7NT7O07rLjux29PRRIMVbB9WuDBOe/sgbm2fFQJh/+t++8k6fNepwE87rhegkqycDjeSYVjgaLPoQoh0F60hTzPfr72vBkt+cMbMYUqWrWtfVAktms9HQBitPn7wau5DRFhK7hOWrSwRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737362209; c=relaxed/simple;
	bh=iPRD2KWoZvbHZFTPohaghCcVvZX1drMbrOqQgWvHJmg=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hfbYR/PCm7VOCHnlanjIvo8yEepwBG4gSJfZS+BjtZaoWkPtNk+mb/REk94u0peEB8ZbKoPvgoXYt3CH8/umT5NLXEm5HyPe21Zqh23ZGf6oBUmDANDrM96iKiJRJlDbcesp7OngPzRbqkdEsK0XYvnLqKhRUOQ8k+/Oljm/Ghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CXYXMxsV; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K8VeAT027721;
	Mon, 20 Jan 2025 09:36:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	iPRD2KWoZvbHZFTPohaghCcVvZX1drMbrOqQgWvHJmg=; b=CXYXMxsVof+3Wz47
	pE44y6yoapWMYfryXmQmgwWCVrd1MV0ICGv6PCjjCMpIGQttUaApGosIU58zgpIy
	vfdnQJxX6cGKfRGAp3ZpqnpIE7lZsFFFXHdLnyFbraBYqqeX3+/5oAX1Pbbh1H/g
	Z1zTGqiGugZk7RQcr0gTqlv93umVokS7DlAb9sFO5hlHNEJSBXw0+ZY+mD6TTi8q
	wd2UcMwGP0xxMcy1k29Bv3kXT/8msT6uHT/J0WL9iuUCn+QdGxedMk/pXBcccG5m
	0McvNf2JQUoo1Ch89bbYfGv1cFMej52XR4TunA24staAgIpqHMkvR8bmpyyMAHax
	nVGU9g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 449jdf875u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:36:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1005640048;
	Mon, 20 Jan 2025 09:33:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 17DC127B404;
	Mon, 20 Jan 2025 09:32:10 +0100 (CET)
Received: from [192.168.8.15] (10.48.86.148) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 20 Jan
 2025 09:32:09 +0100
Message-ID: <98652dc2f29b172a9caafe55d04cb965768e2a66.camel@foss.st.com>
Subject: Re: [Linux-stm32] [PATCH v2 06/12] rtc: stm32: Use resource managed
 API to simplify code
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Dmitry
 Torokhov" <dmitry.torokhov@gmail.com>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire
 McNamara <daire.mcnamara@microchip.com>
CC: <linux-rtc@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Date: Mon, 20 Jan 2025 09:32:07 +0100
In-Reply-To: <20250103-wake_irq-v2-6-e3aeff5e9966@nxp.com>
References: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com>
	 <20250103-wake_irq-v2-6-e3aeff5e9966@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_01,2025-01-20_02,2024-11-22_01

On Fri, 2025-01-03 at 16:41 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Use devm_pm_set_wake_irq and devm_device_init_wakeup to cleanup the
> error handling code and 'driver.remove()' hook.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Antonio Borneo <antonio.borneo@foss.st.com>

Thanks,
Antonio

