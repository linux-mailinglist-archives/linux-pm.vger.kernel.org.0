Return-Path: <linux-pm+bounces-18115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209229D94C2
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 10:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C81E1642FE
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D561BDA8D;
	Tue, 26 Nov 2024 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LaflbYGS"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C727E1BC07E;
	Tue, 26 Nov 2024 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614230; cv=none; b=gNEgt7lWv+YL1w8cLaWP9Pg3fGj3tmhrcXdoT+9rz7NA0rCCzEArInD0tIID+jVDdmfbSDg9nXo9eBHDTDgLCitDLH7owVwaRBKlWNlmjFCOm6Q3BfP/2aSrZ6448H+HqFZ62EwA68/LgGIx0b2baBihoVwmqTUDCN6rX6y9xb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614230; c=relaxed/simple;
	bh=BiEwKuqmX4KhsPyzAc5KYyXSQ0Z0HZ4DaUDlKOGAzdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyzZGn1qjFQH9V1o/FUY3vPm0DTrnzbfCKXfrymiSaBHXjUaY4ehbhh6zvi99xMKbo7DfEmSPu+Px6ezIaIoFeCL3l1PU1ZsTWE5AYIiwlVrBrtnBbqywBOU+/oCR6hHXAPdr5jpU9lp0eOXazlb7AA1lZ0iImiHo3senQ6OjJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LaflbYGS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732614227;
	bh=BiEwKuqmX4KhsPyzAc5KYyXSQ0Z0HZ4DaUDlKOGAzdI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LaflbYGS+QTbiuEdpS9lFjQx2139EdfWctWT3G9HdCRfUvmJwSJKFImp8lxVA7qbv
	 +JyXBnI9vclkj7KCSt6SQ9a03QpBfhYyAka52AeERt1ERkua80v3tNuuzuwyNtE7wW
	 ea3RPmjl/hyO+7/snmnQRQbwPCt5eHtr7mk29vNC56reookqKTGyDFNBsBUitz0fPy
	 QXnX5wbahiuxXgsMuRWZ97MooWhJav0aYv8/BqnZdykH8zk500wC7OieUhi8vcpa4J
	 AEwh7WgA3xhuRsGz8n5p8PE/OJTVirzb+7E6PrgLPvZAUcpJ/LeOC50UcwIwAdhzSj
	 4K612s2YeOxew==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3D12317E35CF;
	Tue, 26 Nov 2024 10:43:46 +0100 (CET)
Message-ID: <018e7608-d9b6-47cb-9233-7733fd1647be@collabora.com>
Date: Tue, 26 Nov 2024 10:43:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] thermal/drivers/mediatek/lvts: Start sensor
 interrupts disabled
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Alexandre Mergnat <amergnat@baylibre.com>,
 Balsam CHIHI <bchihi@baylibre.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Chen-Yu Tsai <wenst@chromium.org>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?=
 <bero@baylibre.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com>
 <20241125-mt8192-lvts-filtered-suspend-fix-v1-4-42e3c0528c6c@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241125-mt8192-lvts-filtered-suspend-fix-v1-4-42e3c0528c6c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/11/24 22:20, Nícolas F. R. A. Prado ha scritto:
> Interrupts are enabled per sensor in lvts_update_irq_mask() as needed,
> there's no point in enabling all of them during initialization. Change
> the MONINT register initial value so all sensor interrupts start
> disabled.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

I definitely agree

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



